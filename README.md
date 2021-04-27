# Weather Station

Simple weather station-esque program, written in Java with the Processing library. I was getting tired of my weather station constantly running out of batteries, and it running fast, so I made my own.

Made for a 480x800 display, have not tested scaling in any way.

![image](https://user-images.githubusercontent.com/33285224/116235116-c000b100-a75d-11eb-80aa-f9d2f4ab6b0d.png)

## Install

### Prerequisites

- Java 8 ([Linux](https://openjdk.java.net/), [Windows](https://adoptopenjdk.net/?variant=openjdk8&jvmVariant=openj9))

You can get the latest release from the [releases](https://github.com/Ghoelian/WeatherStation/releases) page.

Copy ``data/variables.json.example`` to ``data/variables.json`` and edit it to include your own details. I haven't implemented proper error handling yet, so invalid values will crash the application.

### Windows

Simply run the executable.

### Linux

Make the WeatherStation file executable:

```sh
chmod +x WeatherStation
```

Then simply run the now executable file:

```sh
./WeatherStation
```

## Build

The easiest way to build the project is to use the Processing IDE. Simply load the project into the IDE, and click File->Export Application, then select your desired targets.
