You have to install install-nginx first, then do sudo docker compose up

To deploy on Hostinger:

You must have:

github:

create a personal access token,
Grand it the appility to DOWNLOAD content.
Make sure it can access this repo ONLY.

hostinger:

Delete everything in public_hml of vina-med.com website
Your git url: https://<TOKEN>@github.com/DartViet/vinamed.git
repo branch: build

Create, THEN click auto deployment
The the webhook URL there.



Github webhook:
Settings -> webhooks -> delete old one if any -> create new one with that webhook URL you got from hostinger.
Go to deploy keys:

Pass the key hostinger show to it.