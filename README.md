# githubrunner

export GITHUB_TOKEN=sfsdafsdafsafsdfsafsafdsafsdf </br>

docker compose build </br>
docker compose up
docker compose up --scale runner=2 -d

```
(crontab -l ; echo '*/5 * * * * docker system prune -af --filter "until=30m"') | crontab

chmod +x /root/githubrunner/clean-docker.sh
*/2 * * * * /root/githubrunner/clean-docker.sh >> /root/githubrunner/clean-docker.log 2>&1

(crontab -l ; echo '*/3 * * * * /root/githubrunner/clean-docker.sh >> /root/githubrunner/clean-docker.log 2>&1') | crontab
```

### Create swap file

```
link : https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-20-04
sudo fallocate -l 1G /swapfile
ls -lh /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
free -h

sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
cat /proc/sys/vm/swappiness
sudo sysctl vm.swappiness=10

```

```
link: https://stacktuts.com/got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket-at-unix-var-run-docker-sock-get-http-2fvar-2frun-2fdocker-sock-v1-24-version-dial-unix-var-run-docker-sock-connect-permission-denied
sudo chmod 666 /var/run/docker.sock
```

