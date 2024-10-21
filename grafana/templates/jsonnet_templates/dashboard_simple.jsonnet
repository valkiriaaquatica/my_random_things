// Función para crear un panel de CPU
local grafanaStatPanel(title, expr, panelId) = {
  id: panelId,
  gridPos: {
    h: 8,
    w: 12,
    x: 0,
    y: 0,
  },
  type: 'stat',
  title: title,
  datasource: {
    type: 'prometheus',
    uid: 'prometheus', 
  },
  targets: [
    {
      expr: expr,
      refId: 'A',
    },
  ],
  fieldConfig: {
    defaults: {
      unit: 'percent',
      max: 100,
      min: 0,
      thresholds: {
        mode: 'absolute',
        steps: [
          { color: 'green', value: 0 },
          { color: 'red', value: 80 },
        ],
      },
    },
    overrides: [],
  },
  options: {
    reduceOptions: {
      calcs: ['lastNotNull'],
      fields: '',
      values: false,
    },
    orientation: 'horizontal',
    colorMode: 'value',
    graphMode: 'none',
    justifyMode: 'auto',
    textMode: 'value_and_name',
  },
};

{
  apiVersion: 'grizzly.grafana.com/v1alpha1',
  kind: 'Dashboard',
  metadata: {
    name: 'cpu-dashboard-jsonnet',
    uid: 'cpu-dashboard-jsonnet', 
    folder: 'youtube_folder',
  },
  spec: {
    uid: 'cpu-dashboard-jsonnet',
    schemaVersion: 36,
    title: 'Simple CPU grizzly .jsonnet',
    tags: ['grizzly', 'jsonnet', 'simple'], 
    timezone: 'browser',
    refresh: '25s',
    time: {
      from: 'now-12h',
      to: 'now',
    },
    panels: [
      grafanaStatPanel('CPU Usage', "100 * avg(1 - rate(node_cpu_seconds_total{mode='idle'}[5m])) by (instance)", 1),
    ],
  },
}
