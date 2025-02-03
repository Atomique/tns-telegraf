# TrueNAS Dashboard in Grafana with Influx FluxQuery

Some snippets to create a basic Dashboard - not complete

## Network

```sql
from(bucket: "$bucket")
  |> range(start: v.timeRangeStart)
  |> filter(fn: (r) => r.host == "$host")
  |> filter(fn: (r) => r._measurement == "net")
  |> filter(fn: (r) => r._field == "bytes_recv" or r._field == "bytes_sent")
  |> aggregateWindow(every: v.windowPeriod, fn: last, createEmpty: false)
  |> derivative(unit: 1s, nonNegative: false)
  |> keep(columns: ["_field", "_value","_time","name"])
  |> yield(name: "mean")

//  |> yield(name: "mean")
```


## Free Pool

```sql
from(bucket: "$bucket")
  |> range(start: v.timeRangeStart)
  |> filter(fn: (r) => r.host == "$host")
  |> filter(fn: (r) => r._measurement == "net")
  |> filter(fn: (r) => r._field == "bytes_recv" or r._field == "bytes_sent")
  |> aggregateWindow(every: v.windowPeriod, fn: last, createEmpty: false)
  |> derivative(unit: 1s, nonNegative: false)
  |> keep(columns: ["_field", "_value","_time","name"])
  |> yield(name: "mean")

//  |> yield(name: "mean")
```


## CPU Usage

```sql
from(bucket: "$bucket")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r.host == "$host")
  |> filter(fn: (r) => r["cpu"] == "cpu-total")
  |> aggregateWindow(every: v.windowPeriod, fn: mean, createEmpty: false)
  |> yield(name: "mean")
```


## System load average

```sql
from(bucket: "$bucket")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r.host == "$host")
  |> filter(fn: (r) => r["_measurement"] == "system")
  |> filter(fn: (r) => r["_field"] == "load1" or r["_field"] == "load15" or r["_field"] == "load5")
  |> aggregateWindow(every: v.windowPeriod, fn: mean, createEmpty: false)
  |> yield(name: "mean")
```


## HDD Temp

```sql
from(bucket: "$bucket")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r.host == "$host")
  |> filter(fn: (r) => r["_measurement"] == "smart_attribute" or r["_measurement"] == "smart_device")
  |> filter(fn: (r) => r["_field"] == "temp_c")
  |> aggregateWindow(every: v.windowPeriod, fn: mean, createEmpty: false)
  |> yield(name: "mean")
```

## Uptime

```sql
from(bucket: "$bucket")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r.host == "$host")
  |> filter(fn: (r) => r["_measurement"] == "system")
  |> filter(fn: (r) => r["_field"] == "uptime")
  |> aggregateWindow(every: v.windowPeriod, fn: mean, createEmpty: false)
  |> yield(name: "mean")
```

