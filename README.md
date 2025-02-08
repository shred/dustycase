# Particulates Sensor Case

<img style="float:right;width:320px" src="./img/rendering.png">

This is a frame for a [luftdaten.info](https://luftdaten.info) compatible particulates sensor.

The original sensor is housed in drain pipes, which is cheap, but also looks quite like that. ;-)

This construction uses an OBO Bettermann T60 junction box, which looks nicer, and is also UV resistant and IP66 water protected. All components are mounted on the printed frame and fixed inside the junction box. Two wind pipes at the bottom of the box allow air flow. A printed tunnel guides the inlet air to the sensor, so there is no need for a hose. Grilles in the wind pipes keep insects from crawling into the box.

A DHT22 temperature and humidity sensor is required for this construction. It is placed at the wall of the inlet air tunnel, so it is protected from rain, but still exposed to the outside air. There is a space for an optional BMP180 air pressure sensor.

Also see the [project page at the PrusaPrinters community](https://www.prusaprinters.org/prints/79784-particulates-sensor-case) for more photos and downloadable STL files.

## Usage

The [frame.scad](./frame.scad) file contains the source code of the construction. You can edit it with [OpenSCAD](http://www.openscad.org/).

## Contribute

* Fork the [Source code at Codeberg](https://codeberg.org/shred/dustycase). Feel free to send pull requests.
* Found a bug? [File a bug report!](https://codeberg.org/shred/dustycase/issues)

## License

This project is licensed under the [Creative Commons - Attribution - Non-Commercial - Share Alike](http://creativecommons.org/licenses/by-nc-sa/3.0/) license.
