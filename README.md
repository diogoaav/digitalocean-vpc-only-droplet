# digitalocean-vpc-only-droplet

## 1. Update the bash script as described in the previous response and save it, for example, as /opt/update-route.sh. Make sure to make it executable with chmod +x /opt/update-route.sh.

## 2. Create a systemd service unit file for the script:

Create a file named /etc/systemd/system/update-route.service with the following content:

```bash
[Unit]
Description=Update Default Route Script
After=network-online.target

[Service]
Type=simple
ExecStart=/opt/update-route.sh

[Install]
WantedBy=multi-user.target
```

## 3- Reload the systemd daemon to pick up the new service unit:

```bash
sudo systemctl daemon-reload
```

## 4- Enable and start the service:

```bash
sudo systemctl enable update-route.service
sudo systemctl start update-route.service
```
