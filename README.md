# FreePBX16 Installation On Ubuntu 20.04
This script helps you install FreePBX16 on Ubuntu 20.04
# GETTING STARTED
## clone this repository
```bash
   git clone https://github.com/aqeelabpro/freepbx-16-ubuntu-20.04.git
```
```bash
cd freepbx-16-ubuntu-20.04
```
If you want to install on same machine you are on then you can run
```bash
chmod +x freepbx_16_asterisk_18_install_ubuntu_20.04.sh
```
and run 
```bash
./freepbx_16_asterisk_18_install_ubuntu_20.04.sh
```
or If you want to install FreePBX on a VPS then you can copy the contents of sh file using
```bash
cat freepbx_16_asterisk_18_install_ubuntu_20.04.sh
```
in the VPS you want to install FreePBX, create a file called freepbx-16.sh or any-file-name.sh and then paste the copied content.
then again use the above chmod command and then run 
```bash
./freepbx_16_asterisk_18_install_ubuntu_20.04.sh
```
Your FreePBX installation will now start.

During installation you will have to choose the menu options that are required for asterisk and FreePBX to run like

![image](https://github.com/aqeelabpro/freepbx-16-ubuntu-20.04/assets/93031839/e4e4b337-1805-4bb7-bd1f-20d2f5d1e6ef)

![image](https://github.com/aqeelabpro/freepbx-16-ubuntu-20.04/assets/93031839/0090e592-0ef0-4d79-a9c9-e45222f54b1a)


![image](https://github.com/aqeelabpro/freepbx-16-ubuntu-20.04/assets/93031839/45f8bf20-5957-45be-a262-15c18555f2df)


![image](https://github.com/aqeelabpro/freepbx-16-ubuntu-20.04/assets/93031839/89f07af8-0d95-4821-b329-86318766ab8c)



# Post Installation Steps

## Access FreePBX Web Interface

At this point, FreePBX is installed and configured on your server.  
Now, open your web browser and access the FreePBX web interface using the URL http://freepbx-server-ip/admin.  
See the FreePBX initial setup screen.

![image](https://github.com/aqeelabpro/freepbx-16-ubuntu-20.04/assets/93031839/8c0ccec0-46ea-4693-b37b-ba13b656e37a)


Define your username, password, email, other configuration then click on the Setup System. See the following screen.  

![image](https://github.com/aqeelabpro/freepbx-16-ubuntu-20.04/assets/93031839/63c3d449-a187-490a-9b6f-9f20d7a56d47)  



Click on the FreePBX Administration. You are redirected to the FreePBX login screen:  

![image](https://github.com/aqeelabpro/freepbx-16-ubuntu-20.04/assets/93031839/26bff6d4-7293-4c9a-9829-aa930634593e)  


 
Type your administrator username, and password then click Continue. 

After the successful login, you should see the FreePBX dashboard on the following screen.  


![image](https://github.com/aqeelabpro/freepbx-16-ubuntu-20.04/assets/93031839/ad825e73-355e-4f8d-a41b-02da2ed032f5)  



# Happy VoIPing! 📞


Images are taken from https://cloudinfrastructureservices.co.uk/

