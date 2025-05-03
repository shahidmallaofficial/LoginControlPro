# LoginControlPro for cPanel/WHM

**LoginControlPro** is a security plugin for WHM that disables direct cPanel logins for selected users. It allows only secure logins via WHMCS (SSO/session), and includes time-based restrictions, logging, and email notifications.

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
