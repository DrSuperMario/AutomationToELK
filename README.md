# AutomationToELK

# Test task by Mario Muuk
## Dependencies
* Python 3
* Python packages:
    * pprint, 
    * sys, 
    * argparse,
    * ansible

* Ubuntu 20.04
    * elasticsearch
    * java 8
    * kibana
    * logstash
    * nginx

## Instructions for running Automation
RUN bash:
```bash

bash run.sh

```
Bash run will check for the required dependencies and if necessary will ask
you to install them.
The final step of the bash script will initiate python automation script


Running without bash:
```bash

python3 auto.py --user <user.name> --yaml <main.elk.yaml> --inventory <host inventory file>

```
Running python script separately will init playbook without checking global dependencies. Arguments and ansible dependencies must be added or else the script will crash.
All the playbook conf is in auto.py in the immutableDict section.

FileTree:

- roles
    - elasticsearch
        - tasks
            main.yml
    - java
        - tasks
            main.yml
    - kibana
        - tasks
            main.yml
    - logstash
        - tasks
            main.yml
        - templates
            beats-input.conf.j2
    - nginx
        - tasks
            main.yml
        - templates
            elasticsearch-output.conf.j2
            kibana.conf.j2
            kibanaAdmin.j2
            syslog-filter.conf.j2


# All the Yaml file config was thanks to Mr. Google 
