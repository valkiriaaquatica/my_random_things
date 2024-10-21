# EASY AUTOMATION OF CONFIGURATION AS CODE IN GRAFANA USING ANSIBLE, GRIZZLY, AND JSONNET

Before applying and executing the playbook, make sure to define the following environment variables:

```bash
export REQUESTS_CA_BUNDLE="if_you_have_self_signed_certs_the_route"
export GRAFANA_URL="your-grafana_endpoint"
export GRAFANA_TOKEN="your_token_here"
```

This ensures that your Grafana instance is correctly set up and authenticated with the proper certificate bundle and API token.

### Steps to Execute the Playbook:
1. Define the environment variables mentioned above.
2. Execute the Ansible playbook that automates Grafana dashboard creation and folder management.
3. The playbook uses the own ansible modules, Grizzly and Jsonnet to apply the dashboard configurations.

### Manual Grizzly Execution:
In case you want to execute it manually using Grizzly, you can extract the relevant commands from the playbook and run them directly.

For example (make sure to seet the envirometn variables as above mentioned):
```bash
jsonnet ./jsonnet_templates/dashboard_simple.jsonnet > ./jsonnet_templates/dashboard_simple.json
grr apply dashboard_simple.json
```

This allows you to manually convert the Jsonnet templates into Grafana dashboards and apply them using Grizzly.

--- 