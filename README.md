# Azure Red Hat OpenShift (ARO) create and delete scripts

The following scripts provide the easiest way to instantiate and then delete ARO cluster. Configuration as well as the naming is set at scripts with minimal amount of values, please read through the scripts and adjust then according to your requirements.

Note:

For full Azure Red Hat OpenShift (ARO) docummentation collection plase head to:

https://docs.microsoft.com/en-us/azure/openshift/

First login to Azure with command line as the install process uses 'az' at the later stage:

`` az login --use-device-code ``
To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code XXXXXXXX to authenticate.

Worth checking your current quota for available VCPU:
```
./usage_and_quota.sh
Total Regional vCPUs                      0               50
Standard DSv3 Family vCPUs                0               50
```
at the create_cluster.sh script we set smallest available vm's for masters and workers (as of today they are Standard_D8s_v3 and Standard_D4s_v3 accordingly). That makes your cluster to consume 36 vCPU (plus another 4 during installation only for bootstrap vm).

Finally just run:
```
./create_cluster.sh
```

finally you should to receive your Red Hat OpenShift console url and login credentials like the following:

```
To access Red Hat OpenShift console plase direct you browser to the following url:

https://console-openshift-console.apps.XXXXXXXX.eastus.aroapp.io/

... and login with the following credentials:

{
  "kubeadminPassword": "XXXXXXXXXXXXXXXXXXXXXXX",
  "kubeadminUsername": "kubeadmin"
}
```

once you are done with your cluster simply delete it:

```
./delete_cluster.sh
```
Have fun with Azure Red Hat OpenShift!

