# README.md

## Project Overview

This project is based on [Zabbix-NUT-Template](https://github.com/delin/Zabbix-NUT-Template).

### Key Features

- **Enhanced UPS Monitoring**: Added support for monitoring UPS units connected to remote hosts via NUT, accessible through `upsc ups@remote_host`.
- **Customizable Discovery**: The list of hosts for UPS discovery is specified in the macro `{$NUT.UPS_HOSTS}`, with hosts separated by commas. The default value is `localhost`.
- **Template Improvements**:
  - Added tags to the template.
  - Renamed template items to match the naming conventions of official Zabbix templates.
  - Removed custom graphs that were identical to standard ones.

## Installation Instructions

### On the Monitoring Node

1. Place the `zabbix_nut_monitor.sh` script in a directory included in your shell's script path, such as `/usr/bin`.
2. Add the `userparameter_nut.conf` file to the Zabbix agent configuration directory, which is typically `/etc/zabbix/zabbix_agentd.d` or `/etc/zabbix/zabbix_agentd2.d`.
3. Restart the Zabbix agent to apply the changes:

   ```sh
   sudo systemctl restart zabbix-agent
   ```

### On the Zabbix Server

1. Upload the template file.
2. Link the template to the host that will be used for NUT monitoring.

### Discovery and Monitoring

- UPS units defined in the NUT configuration on the host will be discovered automatically.
- To monitor UPS units on remote hosts accessible via nutc, add their addresses to the {$NUT.UPS_HOSTS} macro along with localhost, separated by commas.

### Deactivating Unsupported Data Items
- Some data items defined in the template might not be supported by certain UPS units.
- Unsupported data items can be deactivated as needed.

## Conclusion

This enhanced Zabbix template provides robust support for remote UPS monitoring via NUT, with improved naming conventions and streamlined features for better integration and usability.