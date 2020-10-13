#include <Arduino.h>

const uint8_t reset_pin = 2;
const uint8_t clock_pin = 3;

const uint8_t register_in_pins[] = {14, 16, 18, 20};
const uint8_t register_out_data_pins[] = {15, 17, 19, 21};

const uint8_t data_bus_pins[] = {38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53};

bool failed = false;

void setDataBusMode(const uint8_t mode)
{
    for (uint8_t i = 0; i < 16; i++)
    {
        pinMode(data_bus_pins[i], mode);
    }
}

void writeDataBus(const uint16_t data)
{
    for (uint8_t i = 0; i < 16; i++)
    {
        digitalWrite(data_bus_pins[i], (data >> i) & 1);
    }
}

uint16_t readDataBus()
{
    uint16_t result = 0;
    for (uint8_t i = 0; i < 16; i++)
    {
        result |= digitalRead(data_bus_pins[i]) << i;
    }
    return result;
}

void testRegister(const uint16_t test_number, const uint8_t register_number)
{
    const uint8_t register_in_pin = register_in_pins[register_number];
    const uint8_t register_out_pin = register_out_data_pins[register_number];
    uint16_t read_number;
    setDataBusMode(OUTPUT);
    //delay(1);
    writeDataBus(test_number);
    //delay(1);
    digitalWrite(register_in_pin, HIGH);
    //delay(1);
    digitalWrite(clock_pin, HIGH);
    //delay(1);
    digitalWrite(clock_pin, LOW);
    //delay(1);
    digitalWrite(register_in_pin, LOW);
    //delay(1);
    setDataBusMode(INPUT_PULLUP);
    //delay(1);
    digitalWrite(register_out_pin, LOW);
    //delay(1);
    read_number = readDataBus();
    //delay(1);
    digitalWrite(register_out_pin, HIGH);
    //delay(1);
    if (read_number != test_number)
    {
        Serial.println("register number " + String(register_number) + ": test failed, expected " + String(test_number) + ", got " + String(read_number));
        failed = true;
    }
}

void setup()
{
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

    for (size_t i = 0; i < 4; i++)
    {
        digitalWrite(register_in_pins[i], LOW);
        pinMode(register_in_pins[i], OUTPUT);
        digitalWrite(register_out_data_pins[i], HIGH);
        pinMode(register_out_data_pins[i], OUTPUT);
    }

    digitalWrite(reset_pin, HIGH);

    Serial.begin(2000000);
}

void loop()
{
    Serial.println("Testing register module...");
    failed = false;
    for (size_t register_number = 0; register_number < 4; register_number++)
    {
        for (size_t i = 0; i < 16; i++)
        {
            testRegister(1 << i, register_number);
        }
    }
    for (size_t register_number = 0; register_number < 4; register_number++)
    {
        testRegister(0, register_number);
    }
    for (size_t register_number = 0; register_number < 4; register_number++)
    {
        testRegister(0xffff, register_number);
    }
    for (size_t register_number = 0; register_number < 4; register_number++)
    {
        for (size_t i = 0; i < 256; i++)
        {
            testRegister(random(), register_number);
        }
    }
    if (failed)
    {
        Serial.println("test failed, see above for details");
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
        Serial.println("test passed");
        digitalWrite(LED_BUILTIN, HIGH);
        delay(200);
        digitalWrite(LED_BUILTIN, LOW);
    }
    delay(1000);
}
