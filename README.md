# LoginControlPro for WHM/cPanel

**LoginControlPro** is a security plugin for cPanel/WHM that lets you disable direct cPanel logins (via :2083) for specific users. Only WHMCS-based SSO/session logins are allowed for them. This plugin is perfect for enhancing control panel security and preventing brute-force attacks.

---

### Features

- Block direct cPanel logins (username/password)
- Allow only WHMCS SSO/session-based login
- Bulk user selection from WHM interface
- Set time-based restrictions (e.g., disable login from 10PM–6AM)
- Logs all blocked login attempts
- Sends email notifications to admin when a login is blocked
- Full WHM GUI for managing users and login settings
- One-command installer from GitHub

---

### Developed By

- **Author**: [Shahid Malla](https://shahidmalla.dev)  
- **Email**: [life@shahidmalla.dev](mailto:life@shahidmalla.dev)  
- **Websites**: [shahidmalla.dev](https://shahidmalla.dev) | [shahidmalla.com](https://shahidmalla.com)

---

### Installation

#### Option 1: Quick Install (recommended)
```bash
curl -O https://raw.githubusercontent.com/shahidmallaofficial/LoginControlPro/main/install_from_github.sh
bash install_from_github.sh
