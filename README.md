# Energy Monitoring Data (Kenya)

> This data is in no way canon - Data is only provided for curious minds.

This data is a log of estimated cost of energy applications snapshoted from a Kenya Power simulation.

Data is collected from a WEMO switch using the script in [tools](./tools/scripts/).

This can be scraped using prometheus on OpenWRT using [prometheus-node-exporter-textfile](https://openwrt.org/packages/pkgdata/prometheus-node-exporter-lua)

# Data formats

Data is published in `CSV` format.

# Records

- [2021](/2021/all.csv)


# Abbreviations

Abbrv | Full Name
----- | ---------
KwH | Kilowatt Hour
FERFA | Foreign Exchange Adjustment
INFA | Inflation Adjustment
ERC | Energy Regulary Commission Levy
REP | Rural Electrification Authority Levy
WARMA | Water Resource Management Authority Levy
VAT | Value Added Tax


# Estimates

Estimates are computed using [Kenya Power's energy simulation](https://selfservice.kplc.co.ke/).

![Simulation Example](https://raw.githubusercontent.com/bmurithi/stima-data/main/media/energy-simulation.png "Energy Simulation")
