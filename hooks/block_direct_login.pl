#!/usr/bin/perl

use strict;
use warnings;
use JSON;
use Time::Piece;
use File::Path qw(make_path);
use File::Basename;

sub log_attempt {
    my ($user, $reason) = @_;
    my $log_dir = "/usr/local/cpanel/logincontrolpro/logs";
    my $log_file = "$log_dir/login_attempts.log";

    make_path($log_dir) unless -d $log_dir;

    my $timestamp = localtime->strftime('%Y-%m-%d %H:%M:%S');
    open my $fh, '>>', $log_file;
    print $fh "$timestamp - User: $user - $reason\n";
    close $fh;
}

sub send_alert {
    my ($user, $reason) = @_;
    my $to = 'admin@example.com';  # Replace with your email
    my $subject = "Login Blocked: $user";
    my $message = "User: $user\nReason: $reason\nTime: " . localtime->strftime('%Y-%m-%d %H:%M:%S');
    my $mail_cmd = "|/usr/sbin/sendmail -t";
    open(MAIL, $mail_cmd) or return;
    print MAIL "To: $to\n";
    print MAIL "Subject: $subject\n";
    print MAIL "Content-Type: text/plain; charset=UTF-8\n\n";
    print MAIL "$message\n";
    close(MAIL);
}

sub block_direct_login {
    my ($context, $data) = @_;

    my $user = $data->{'user'};
    my $login_type = $data->{'login_type'};

    my $json_file = '/usr/local/cpanel/logincontrolpro/config.json';
    return 1 unless -e $json_file;

    open my $fh, '<', $json_file or return 1;
    my $config = decode_json(do { local $/; <$fh> });
    close $fh;

    my $disabled = $config->{'disabled_users'}{$user};

    if ($login_type eq 'password' && $disabled && $disabled->{'status'}) {
        my $now = localtime;
        my $current_hour = $now->hour;

        if (exists $disabled->{'schedule'} && $disabled->{'schedule'} =~ /^(\d{1,2}):(\d{2})-(\d{1,2}):(\d{2})$/) {
            my ($from_hour, $from_min, $to_hour, $to_min) = ($1, $2, $3, $4);
            my $from = Time::Piece->strptime(sprintf("%02d:%02d", $from_hour, $from_min), "%H:%M")->hour;
            my $to   = Time::Piece->strptime(sprintf("%02d:%02d", $to_hour, $to_min), "%H:%M")->hour;

            if ($from <= $to) {
                if ($current_hour >= $from && $current_hour < $to) {
                    log_attempt($user, "Blocked by schedule ($from_hour:$from_min-$to_hour:$to_min)");
                    send_alert($user, "Blocked by schedule ($from_hour:$from_min-$to_hour:$to_min)");
                    return {
                        'status' => 0,
                        'error'  => 'Direct login is disabled during scheduled hours.'
                    };
                }
            } else {
                if ($current_hour >= $from || $current_hour < $to) {
                    log_attempt($user, "Blocked by schedule ($from_hour:$from_min-$to_hour:$to_min)");
                    send_alert($user, "Blocked by schedule ($from_hour:$from_min-$to_hour:$to_min)");
                    return {
                        'status' => 0,
                        'error'  => 'Direct login is disabled during scheduled hours.'
                    };
                }
            }
        }

        log_attempt($user, "Blocked by admin policy");
        send_alert($user, "Blocked by admin policy");
        return {
            'status' => 0,
            'error'  => 'Direct login is disabled. Please use WHMCS or panel link.'
        };
    }

    return 1;
}

1;
