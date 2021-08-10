#include "Arduino.h"

// uncomment for debugging
//#define DEBUG

#ifdef DEBUG
#include "avr8-stub.h"
#endif

const uint8_t reset_pin = 2;
const uint8_t clock_pin = 3;

const uint8_t in_pin = 37;
const uint8_t select_bus_flags_pin = 36;
const uint8_t out_pin = 35;
const uint8_t a_pins[3] = {33, 32, 31};
const uint8_t set_flag_pin = 29;
const uint8_t reset_flag_pin = 28;
const uint8_t carry_in_pin = 25;
const uint8_t overflow_in_pin = 24;
const uint8_t flags_out_pins[8] = {14, 15, 16, 17, 18, 19, 20, 21};

const uint8_t data_bus_pins[] = {38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53};

bool failed = false;


void pulseClock()
{
    digitalWrite(clock_pin, HIGH);
    digitalWrite(clock_pin, LOW);
}

void setDataBusMode(const uint8_t mode)
{
    for (uint8_t i = 0; i < 16; i++)
    {
        pinMode(data_bus_pins[i], mode);
    }
}

void writeDataBus(const uint16_t data)
{
    digitalWrite(out_pin, HIGH);
    setDataBusMode(OUTPUT);
    for (uint8_t i = 0; i < 16; i++)
    {
        digitalWrite(data_bus_pins[i], (data >> i) & 1);
    }
}

uint16_t readDataBus()
{
    digitalWrite(out_pin, LOW);
    setDataBusMode(INPUT);
    uint16_t result = 0;
    for (uint8_t i = 0; i < 16; i++)
    {
        result |= digitalRead(data_bus_pins[i]) << i;
    }
    digitalWrite(out_pin, HIGH);
    return result;
}

uint8_t readFlags()
{
    uint8_t result = 0;
    for (uint8_t i = 0; i < 8; i++)
    {
        result |= digitalRead(flags_out_pins[i]) << i;
    }
    return result;
}

void setA(uint8_t a)
{
    for (uint8_t i = 0; i < 3; i++)
    {
        digitalWrite(a_pins[i], (a >> i) & 1);
    }
}

void setFlag(uint8_t flag, bool value)
{
    setA(flag);

    digitalWrite(set_flag_pin, LOW);
    digitalWrite(reset_flag_pin, LOW);
    if (value)
    {
        digitalWrite(set_flag_pin, HIGH);
    }
    else
    {
        digitalWrite(reset_flag_pin, HIGH);
    }
    
    pulseClock();

    digitalWrite(set_flag_pin, LOW);
    digitalWrite(reset_flag_pin, LOW);
}

void expectFlag(uint8_t flag, bool expected_value)
{
    bool value = digitalRead(flags_out_pins[flag]);
    if (!expected_value != !value)
    {
        failed = true;
#ifndef DEBUG
        Serial.println("Expected flag " + String(flag) + " to be " + (expected_value ? "1" : "0") + " but it was " + (value ? "1" : "0"));
#endif
        value = digitalRead(flags_out_pins[flag]);
    }
}

void expectFlags(uint8_t expected_flags)
{
    uint8_t flags = readFlags();
    if (flags != expected_flags)
    {
        failed = true;
#ifndef DEBUG
        Serial.println("Expected flags to be " + String(expected_flags, 2) + " but they were " + String(flags, 2));
#endif
    }
}

void setup()
{
#ifdef DEBUG
    debug_init();
#endif
    pinMode(LED_BUILTIN, OUTPUT);
    digitalWrite(LED_BUILTIN, LOW);
    {
        int seed = 0;
        for (size_t i = 0; i < 16; i++)
        {
            seed += analogRead(i);
        }
        randomSeed(seed);
    }

    setDataBusMode(INPUT_PULLUP);

    digitalWrite(reset_pin, LOW);
    pinMode(reset_pin, OUTPUT);

    digitalWrite(clock_pin, LOW);
    pinMode(clock_pin, OUTPUT);

    digitalWrite(in_pin, LOW);
    pinMode(in_pin, OUTPUT);

    digitalWrite(select_bus_flags_pin, LOW);
    pinMode(select_bus_flags_pin, OUTPUT);

    digitalWrite(out_pin, HIGH);
    pinMode(out_pin, OUTPUT);

    digitalWrite(set_flag_pin, HIGH);
    pinMode(set_flag_pin, OUTPUT);

    digitalWrite(reset_flag_pin, HIGH);
    pinMode(reset_flag_pin, OUTPUT);

    digitalWrite(carry_in_pin, LOW);
    pinMode(carry_in_pin, OUTPUT);

    digitalWrite(overflow_in_pin, LOW);
    pinMode(overflow_in_pin, OUTPUT);

    for (size_t i = 0; i < 8; i++)
    {
        pinMode(flags_out_pins[i], INPUT);
    }

    for (size_t i = 0; i < 3; i++)
    {
        digitalWrite(a_pins[i], LOW);
        pinMode(a_pins[i], OUTPUT);
    }

    digitalWrite(reset_pin, HIGH);
#ifndef DEBUG
    Serial.begin(115200);
#endif
}

void loop()
{
#ifndef DEBUG
    Serial.println("Testing flag register module...");
#endif
    failed = false;

    digitalWrite(select_bus_flags_pin, HIGH);
    digitalWrite(out_pin, HIGH);
    setDataBusMode(INPUT);
    digitalWrite(reset_pin, LOW);
    digitalWrite(reset_pin, HIGH);

    for (uint8_t i = 0; i < 8; i++)
    {
        setFlag(i, false);
        expectFlag(i, false);
        setFlag(i, true);
        expectFlag(i, true);
        setFlag(i, false);
        expectFlag(i, false);
    }

    for (size_t i = 0; i < 256; i++)
    {
        writeDataBus(i);
        digitalWrite(in_pin, HIGH);
        pulseClock();
        digitalWrite(in_pin, LOW);
        uint16_t result = readDataBus();
        if (i != result)
        {
            failed = true;
#ifndef DEBUG
            Serial.println("Expected " + String(i, 2) + " but got " + String(result, 2));
#endif
        }
        expectFlags(i);
    }

    digitalWrite(select_bus_flags_pin, LOW);

    for (size_t i = 0; i < 1<<5; i++)
    {
        bool zero = i & 1;
        bool carry = (i >> 1) & 1;
        bool negative = (i >> 2) & 1;
        bool overflow = (i >> 3) & 1;
        bool interrupt = (i >> 4) & 1;

        if (zero && negative)
        {
            continue;
        }
        digitalWrite(carry_in_pin, carry);
        digitalWrite(overflow_in_pin, overflow);
        if (zero) {
            writeDataBus(0);
        } else if (negative) {
            writeDataBus(0x8000);
        } else {
            writeDataBus(0x7fff);
        }
        digitalWrite(in_pin, HIGH);
        pulseClock();
        digitalWrite(in_pin, LOW);

        setFlag(4, interrupt);
        for (size_t i = 5; i < 8; i++)
        {
            setFlag(i, false);
        }
        
        
        uint16_t result = readDataBus();
        if ((result&0xff) != (i)) {
            failed = true;
#ifndef DEBUG
            Serial.println("Expected " + String(i, 2) + " but got " + String(result, 2));
#endif
        }
        expectFlags(i & 0xff);
        digitalWrite(out_pin, HIGH);
    }
    

    if (failed)
    {
#ifndef DEBUG
        Serial.println("Test failed, see above for details");
#endif
        digitalWrite(LED_BUILTIN, HIGH);
        delay(200);
        digitalWrite(LED_BUILTIN, LOW);
        delay(200);
        digitalWrite(LED_BUILTIN, HIGH);
        delay(200);
        digitalWrite(LED_BUILTIN, LOW);
        delay(200);
        digitalWrite(LED_BUILTIN, HIGH);
        delay(200);
        digitalWrite(LED_BUILTIN, LOW);
    }
    else
    {
#ifndef DEBUG
        Serial.println("Test passed");
#endif
        digitalWrite(LED_BUILTIN, HIGH);
        delay(200);
        digitalWrite(LED_BUILTIN, LOW);
    }
    delay(1000);
}
