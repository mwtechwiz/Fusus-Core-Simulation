# Fusus-Core-Simulation
This lab simulates a simplified FususCORE environment using Linux command-line tools. It helps demonstrate my technical support and networking skills relevant to roles involving camera systems, video streams, and Linux-based troubleshooting like those at Axon (Fusus).

## Objectives

- Simulate a mock video feed using FFmpeg
- Monitor system health with a Bash script
- Troubleshoot common network or process issues
- Document real-world errors and how to resolve them

---

## Tools Used

- ffmpeg – simulate video stream
- bash – automation and monitoring scripts
- curl – test endpoints
- ss / netstat – check open ports
- iproute2 – interface and routing
- tcpdump – traffic inspection
- Git & GitHub – version control and publishing

---

## Setup Instructions

##  0: Create the Project Directory

Start by creating a dedicated folder for your FususCORE simulation lab.

```bash
mkdir ~/fususcore-lab
cd ~/fususcore-lab
```
'mkdir' creates a new directory named fususcore-lab in your home folder.

'cd' moves you into that directory so you can work inside it.

### 1. Install required tools 
![Fosuscorelab1](https://github.com/user-attachments/assets/6de0a411-1b55-42f9-afb0-8fe7d14e6d73)


```bash
sudo apt update
sudo apt install -y git curl net-tools iputils-ping iproute2 tcpdump ffmpeg nginx dos2unix
```
 ### 2. Add a Sample Video
 
Download or copy a small .mp4 video to your lab folder and rename it. For me it was "charlie.mp4"
![Fosuscorelab1](https://github.com/mwtechwiz/Fusus-Core-Simulation/blob/main/fususcorelab3.png)

## 3. Create the Stream Script (`start_stream.sh`)

This script uses `ffmpeg` to simulate a looping camera video stream by continuously writing to a file (`output.ts`).

### Create the script

```bash
nano start_stream.sh
```
![Fosuscorelab1](https://github.com/mwtechwiz/Fusus-Core-Simulation/blob/main/Fususcorelab5.png)

## Make the script executable

Run the following command to give the script permission to be executed:

```bash
chmod +x start_stream.sh
```
"chmod" stands for change mode.

"+x" adds the execute permission.

![Fosuscorelab1](https://github.com/mwtechwiz/Fusus-Core-Simulation/blob/main/Fususcorelab7.png)

## 4. Run the Stream Simulation

Now run the stream simulation script.

```bash
./start_stream.sh
```
You should see terminal output from FFmpeg showing frames, bitrate, and encoding stats. This simulates a live camera stream running locally.
Leave this terminal open and running while testing.
![Fosuscorelab1](https://github.com/mwtechwiz/Fusus-Core-Simulation/blob/main/Screenshot%20from%202025-05-13%2003-18-24.png)

## 5. Create the Monitor Script (`monitor.sh`)

The `monitor.sh` script checks whether the video stream output file (`output.ts`) exists. This acts as a basic health check to simulate stream monitoring functionality.

### Create the script file

```bash
nano monitor.sh
```
![Fosuscorelab1](https://github.com/mwtechwiz/Fusus-Core-Simulation/blob/main/fususcorelab12(monitor).png)

Save and exit the script then make it executable. 

### 6. Health Monitoring

Here we can view the stream exists and is working.
![Fosuscorelab1](https://github.com/mwtechwiz/Fusus-Core-Simulation/blob/main/fususcorelab13(streamexists).png)


### *** Troubleshooting: Streaming to Port 8080

### Initial Streaming Attempt

In the original setup, the stream was configured to send video to TCP port 8080 on `localhost` using the following FFmpeg command:

```bash
ffmpeg -re -stream_loop -1 -i charlie.mp4 -f mpegts http://localhost:8080/live
```
But after I ran the stream, it was quickly interrupted with this error:
![Fosuscorelab1](https://github.com/mwtechwiz/Fusus-Core-Simulation/blob/main/Fususcorelab8(port%20error).png)

This indicated that nothing was listening on port 8080 to receive the stream.

# Troubleshooting steps taken
-Verified that nginx was installed and running (sudo systemctl status nginx)
- Verified whether any service or application is listening on a specific port using the following command:

```bash
ss -lntp | grep 8080
```
ss – used to inspect socket connections

-l – show only listening sockets

-n – display port numbers numerically (instead of resolving names)

-t – filter TCP sockets

-p – show the process using the port

(Usually the IP address with the port number appears but nothing was available which could explain why a stream connection was refused.)

At this point, I considered setting up an RTMP receiver (like an Nginx RTMP module), but chose to simplify the lab to remain CLI-focused and lightweight. Instead I chose the stream to output through a file (Step 3).

This allowed me to:

    Simulate continuous video output

    Monitor the stream using a Bash script (monitor.sh)

    Avoid the need for an additional media server or receiver service

### Overview
This situation mirrors real-world FususCORE support scenarios, where the device is transmitting but the destination (cloud, VMS, or NVR) is unreachable or misconfigured.

The goal was to emulate a real-world FususCORE video stream environment using CLI tools to demonstrate key support capabilities such as troubleshooting, video monitoring, and Linux-based diagnostics.










