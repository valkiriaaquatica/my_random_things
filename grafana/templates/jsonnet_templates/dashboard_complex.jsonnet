local grafanaPanel(title, expr, panelId, type = 'stat', unit = 'percent', minValue = 0, maxValue = 100) = { //this can be reused with other dashboards
  id: panelId,
  gridPos: {
    h: 8,
    w: 12,
    x: 0,
    y: 0,
  },
  type: type,
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
      unit: unit,
      max: maxValue,
      min: minValue,
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
  options: if type == 'piechart' then {
      pieType: 'pie',
      displayMode: 'labels',
      legend: {
        displayMode: 'list',
        placement: 'bottom',
      },
    } else {
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
    title: 'Complex jsonnet Dashboard',
    timezone: 'browser',
    tags: ['grizzly', 'jsonnet', 'complex'],
    refresh: '25s',
    time: {
      from: 'now-24h',
      to: 'now',
    },
    panels: [  //  if you want more just add here the queries
      grafanaPanel('CPU Usage', "100 * avg(1 - rate(node_cpu_seconds_total{mode='idle'}[5m])) by (instance)", 1),
      grafanaPanel('Memory Usage', "sum(node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes) / sum(node_memory_MemTotal_bytes) * 100", 2, 'stat', 'percent', 0, 100),
      grafanaPanel('Disk Usage', "100 - (node_filesystem_avail_bytes / node_filesystem_size_bytes) * 100", 3, 'piechart', 'percent', 0, 100),
    ],
  },
}