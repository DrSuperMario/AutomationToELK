from pprint import pprint
from datetime import datetime
import os
import sys
import argparse

try:
    from ansible import context
except ImportError:
    pprint("Ansible not installed...")
    sys.exit()

finally:
    pprint("Ansible found good luck...")
    from ansible.cli import CLI
    from ansible.module_utils.common.collections import ImmutableDict
    from ansible.executor.playbook_executor import PlaybookExecutor
    from ansible.parsing.dataloader import DataLoader
    from ansible.inventory.manager import InventoryManager
    from ansible.vars.manager import VariableManager


def load_playbook(user: str, yaml: str, inv: str) -> None:

    """
    Add users and initiate YAML playbook
    """

    load_data = DataLoader()

    context.CLIARGS = ImmutableDict(
                                        tags={}, 
                                        listtags=False, 
                                        listtasks=False, 
                                        listhosts=False, 
                                        syntax=False, 
                                        connection='ssh',
                                        module_path=None, 
                                        forks=100, 
                                        remote_user=user, 
                                        private_key_file=None,
                                        ssh_common_args=None, 
                                        ssh_extra_args=None, 
                                        sftp_extra_args=None, 
                                        scp_extra_args=None, 
                                        become=True,
                                        become_method='sudo', 
                                        become_user='root', 
                                        verbosity=True, 
                                        check=False, 
                                        start_at_task=None
                    )

    inventory = InventoryManager(loader=load_data, sources=(inv,))

    variable_manager = VariableManager(loader=load_data, inventory=inventory, version_info=CLI.version_info(gitinfo=False))

  
    play = PlaybookExecutor(playbooks=[yaml], inventory=inventory, variable_manager=variable_manager, loader=load_data, passwords={})

    try:
        results = play.run()
        pprint(results)
    finally:
        play.cleanup()
        
if(__name__=="__main__"):

    arguments = argparse.ArgumentParser(description="Enter params for Ansible Playbook")
    arguments.add_argument('--user', help='Add username to login')
    arguments.add_argument('--yaml', help='Add playbook yaml')
    arguments.add_argument('--inventory', help='Add invetory manager source')
    args = arguments.parse_args()
    if((not args.user)):
        pprint("Arguments --user must be added")
        pprint(arguments.print_help())
    else:    
        if((not args.yaml) and (not args.inventory)):
            pprint("Arguments --yaml and --inventory must be added")
            pprint(arguments.print_help())
        else:
            load_playbook(user=args.user, yaml=args.yaml, inv=args.inventory)
          
  