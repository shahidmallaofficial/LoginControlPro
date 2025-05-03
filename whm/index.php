#!/usr/local/cpanel/3rdparty/bin/php
<?php

$configPath = "/usr/local/cpanel/logincontrolpro/config.json";

function getCpanelUsers() {
    $users = [];
    exec('/bin/ls -1 /var/cpanel/users', $users);
    return $users;
}

$config = [];
if (file_exists($configPath)) {
    $config = json_decode(file_get_contents($configPath), true);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    foreach ($_POST['users'] as $user => $settings) {
        $status = isset($settings['status']) ? true : false;
        $schedule = trim($settings['schedule']);
        $config['disabled_users'][$user] = [
            'status' => $status,
            'schedule' => $schedule
        ];
    }

    file_put_contents($configPath, json_encode($config, JSON_PRETTY_PRINT));
    echo "<div style='color: green;'>Settings updated successfully.</div>";
}

echo "<h2>LoginControlPro - Disable Direct Login</h2>";
echo "<form method='POST'>";
echo "<table border='1' cellpadding='5' cellspacing='0'>";
echo "<tr><th>User</th><th>Disable Login?</th><th>Time Restriction (HH:MM-HH:MM)</th></tr>";

foreach (getCpanelUsers() as $user) {
    $isDisabled = isset($config['disabled_users'][$user]['status']) && $config['disabled_users'][$user]['status'];
    $schedule = isset($config['disabled_users'][$user]['schedule']) ? $config['disabled_users'][$user]['schedule'] : '';
    echo "<tr>";
    echo "<td><b>$user</b></td>";
    echo "<td><input type='checkbox' name='users[$user][status]' " . ($isDisabled ? 'checked' : '') . "></td>";
    echo "<td><input type='text' name='users[$user][schedule]' value='$schedule' placeholder='e.g. 22:00-06:00' size='15'></td>";
    echo "</tr>";
}

echo "</table><br>";
echo "<button type='submit'>Save Settings</button>";
echo "</form>";

echo "<br><hr><p style='font-size: 12px;'>Plugin developed by <a href='https://shahidmalla.dev' target='_blank'>Shahid Malla</a> — <a href='mailto:life@shahidmalla.dev'>life@shahidmalla.dev</a></p>";

?>
