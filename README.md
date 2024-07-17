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

### Usage

1. **Macro Configuration**:
   - Set the `{$NUT.UPS_HOSTS}` macro with a comma-separated list of hostnames where UPS discovery should be performed.

2. **Template Tags**:
   - Tags have been added to improve organization and classification.

3. **Item Renaming**:
   - Items within the template have been renamed to follow the naming conventions of official Zabbix templates, enhancing consistency and readability.

4. **Graph Simplification**:
   - Removed redundant custom graphs to streamline the template.

## Conclusion

This enhanced Zabbix template provides robust support for remote UPS monitoring via NUT, with improved naming conventions and streamlined features for better integration and usability.