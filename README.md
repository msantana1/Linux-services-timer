# Linux Systemd Services and Timers
Repository to test and document the use of systemd services and timers

On this case, we are configuring a service to run once per week to update the Docker containers

## 1.- Copy the shell script to upgrade the docker images

### Content of the shell script

The shell script has different stages
 
1. Pull the latest version of the images you're using
2.  Compose the containers with the new image versions using the yml file
3.  Prune the old images to release the disk space 
4. Save the date when the script was run on the log file


### Instructions to copy and set the shell script

Inside the files folder, you can find a [shell script](files/docker-compose-update.sh) update the docker images and re-build the containers.


su into your docker user

```
sudo su - <docker_user>
```
Copy the shell script to the path ``/usr/local/bin/docker-compose-update.sh`` for that run this command

```
cp ./files/docker-compose-update.sh /usr/local/bin/docker-compose-update.sh
```
Give the file the execution permissions necessary to run

```
chmod u+x /usr/local/bin/docker-compose-update.sh
```

## 2.- Copy the .service file

**Tor copy the .service and .timer file you need to be root or be an user with sudo**

Update the username of your <docker_user> on the file containers-update.service on the line ``User=<docker_user>``

Copy the [.service](files/containers-update.service) file, run this command

```
sudo cp ./files/containers-update.service /etc/systemd/system/containers-update.service
```
Enable the new service, run this command

```
sudo systemctl enable /etc/systemd/system/containers-update.service
```
### Validate the service
To validate that the service was properly configured, you need to run this command

```
sudo systemctl status containers-update.service 
```
It should say that the service is enabled

## 3.- Copy the .timer file

Copy the [.timer](files/containers-update.timer) file, run this command

```
sudo cp ./files/containers-update.timer /etc/systemd/system/containers-update.timer
```
Enable the new timer, run this command

```
sudo systemctl enable /etc/systemd/system/containers-update.timer
```
This timer will run the service **containers-update** each Tuesday at 2:00 AM (server local time)

### Validate the timer
To validate that the timer was properly configured, you need to run this command

```
sudo systemctl list-timers
```
Look for the timer containers-update.timer should be listed and it should show the time remaining for the next execution of the service

## 4.- Reload the systemd daemon

Once you have both the service and the timer enabled, you need to reload the Systemd daemon, run this command

```
sudo systemctl daemon-reload
```
Now you should have everything ready, just confirm the next time that the service should run