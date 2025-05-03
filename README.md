# LoginControlPro for cPanel/WHM

**LoginControlPro** is a WHM plugin developed by **Shahid Malla** to enhance cPanel login security.

---

## Features

- Disable direct login (port 2083) per cPanel user
- Allow only WHMCS SSO-based login
- Bulk enable/disable from WHM GUI
- Set login restrictions based on time (e.g., block from 10PM–6AM)
- Log all blocked login attempts
- Email admin when a blocked attempt is made

---

## Installation

1. Upload `logincontrolpro_complete_alerts.tar.gz` and `install_logincontrolpro.sh` to your server.
2. Run the installer:

```bash
bash install_logincontrolpro.sh
```

3. Go to **WHM > Plugins > LoginControlPro**
4. Select users, set time restrictions, and save settings.

---

## File Structure

```
/usr/local/cpanel/logincontrolpro/
├── config.json                  # User login control config
├── hooks/
│   └── block_direct_login.pl    # Hook to block login & send alerts
├── logs/
│   └── login_attempts.log       # Log of blocked attempts
├── whm/
│   └── index.php                # WHM GUI for managing users
├── install_logincontrolpro.sh   # Auto-installer script
```

---

## Developer Info

- **Author:** Shahid Malla  
- **Email:** life@shahidmalla.dev  
- **Website:** [shahidmalla.dev](https://shahidmalla.dev) | [shahidmalla.com](https://shahidmalla.com)

---

## License

Open-source plugin developed by Shahid Malla to enhance cPanel login security.

---

## Contributions

Feel free to contribute or suggest improvements by emailing **life@shahidmalla.dev**
