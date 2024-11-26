# AWX Configuration as Code Role

This role includes the setup of: credential type, credentials(proxmox), projects, job templates, inventorie (proxmox), inventory sources, execution environments, and custom settings like LDAP integration

---

## Prerequisites

1. **Environment Variables for AWX Connection**:
   Before running the playbook, ensure the following environment variables are set:
   ```bash
   export CONTROLLER_HOST=https://awx.homelab.com/
   export CONTROLLER_USERNAME=your_username
   export CONTROLLER_PASSWORD=your_pass
   ```

2. **Permissions**:
   Ensure the user has sufficient privileges in AWX to create resources such as credentials, projects, and inventory configurations.

3. **AWX Accessibility**:
   The AWX instance must be reachable from the machine where the playbook is executed.

---

## Usage

Run the role using the following playbook:

```yaml
---
- name: Configure AWX as code
  hosts: localhost
  gather_facts: false
  roles:
    - caasc_awx_yt
```

---

## Role Features

The role is designed to configure AWX by managing the following components:

1. **Credential Types**:
   Creates custom credential types for external services like Proxmox, AWS, or Git.

2. **Credentials**:
   Manages specific credentials linked to the defined credential types.

3. **Projects**:
   Configures projects by linking them to source control repositories and associated credentials.

4. **Job Templates**:
   Creates job templates for automating specific tasks in AWX.

5. **Execution Environments**:
   Configures the environments required for executing AWX jobs.

6. **Inventories**:
   Manages inventories to define the infrastructure or resources targeted by automation tasks.

7. **Inventory Sources**:
   Sets up external inventory sources to dynamically update resource definitions.

8. **LDAP Settings**:
   Configures LDAP integration for user authentication and group management.

---

Thanks and enjoy Kanye West