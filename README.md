# Energy Monitoring Data (Kenya)

> This data is in no way canon - Data is only provided for curious minds.

This data is a log of estimated cost of energy applications snapshoted from a Kenya Power simulation.

Data is collected from a WEMO switch using the script in [tools](./tools/scripts/).

This can be scraped using prometheus on OpenWRT using [prometheus-node-exporter-textfile](https://openwrt.org/packages/pkgdata/prometheus-node-exporter-lua)

# Data formats

Data is published in `CSV` format.

# Estimates

Estimates are computed using [Kenya Power's energy simulation](https://selfservice.kplc.co.ke/).

![Simulation Example][/main/media/energy-simulation.png]

# Records

- [2021](/main/2021/all.csv)
