#include <Arduino.h>

const uint8_t reset_pin = 2;
const uint8_t clock_pin = 3;

const uint8_t register_in_pins[] = {22, 25, 28, 31};
const uint8_t register_count_up_pins[] = {23, 26, 29, 32};
const uint8_t register_count_down_pins[] = {24, 27, 30, 33};
const uint8_t register_out_data_pins[] = {14, 16, 18, 20};
const uint8_t register_out_address_pins[] = {15, 17, 19, 21};

const uint8_t data_bus_pins[] = {38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53};
const uint8_t address_bus_pins[] = {54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69};

bool failed = false;

void setDataBusMode(const uint8_t mode)
{
    for (uint8_t i = 0; i < 16; i++)
    {
        pinMode(data_bus_pins[i], mode);
    }
}

void setAddressBusMode(const uint8_t mode)
{
    for (uint8_t i = 0; i < 16; i++)
    {
        pinMode(address_bus_pins[i], mode);
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

uint16_t readAddressBus()
{
    uint16_t result = 0;
    for (uint8_t i = 0; i < 16; i++)
    {
        result |= digitalRead(address_bus_pins[i]) << i;
    }
    return result;
}

void testRegister(const uint16_t test_number, const uint8_t register_number, const uint8_t count, const bool up_down)
{
    const uint8_t register_in_pin = register_in_pins[register_number];
    const uint8_t register_out_pin_data = register_out_data_pins[register_number];
    const uint8_t register_out_pin_address = register_out_address_pins[register_number];
    uint16_t read_number_data;
    uint16_t read_number_address;
    setDataBusMode(OUTPUT);
    writeDataBus(test_number);

    digitalWrite(register_in_pin, LOW);
    digitalWrite(clock_pin, LOW);
    digitalWrite(clock_pin, HIGH);
    digitalWrite(register_in_pin, HIGH);

    digitalWrite(up_down ? register_count_up_pins[register_number] : register_count_down_pins[register_number], LOW);

    for (size_t i = 0; i < count; i++)
    {
        digitalWrite(clock_pin, LOW);
        digitalWrite(clock_pin, HIGH);
    }

    digitalWrite(up_down ? register_count_up_pins[register_number] : register_count_down_pins[register_number], HIGH);

    setDataBusMode(INPUT_PULLUP);

    digitalWrite(register_out_pin_data, LOW);
    digitalWrite(register_out_pin_address, LOW);

    read_number_data = readDataBus();
    read_number_address = readAddressBus();

    digitalWrite(register_out_pin_data, HIGH);
    digitalWrite(register_out_pin_address, HIGH);

    const uint16_t expected_number = test_number + (up_down ? count : -count);

    if (read_number_data != expected_number || read_number_address != expected_number)
    {
        Serial.println("register number " + String(register_number) + ": test failed, expected " + String(expected_number) + ", got " + String(read_number_data) + " on data and " + String(read_number_address) + " on address");
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
    setAddressBusMode(INPUT_PULLUP);

    digitalWrite(reset_pin, HIGH);
    pinMode(reset_pin, OUTPUT);

    digitalWrite(clock_pin, HIGH);
    pinMode(clock_pin, OUTPUT);

    for (size_t i = 0; i < 4; i++)
    {
        digitalWrite(register_in_pins[i], HIGH);
        pinMode(register_in_pins[i], OUTPUT);
        digitalWrite(register_out_data_pins[i], HIGH);
        pinMode(register_out_data_pins[i], OUTPUT);
        digitalWrite(register_out_address_pins[i], HIGH);
        pinMode(register_out_address_pins[i], OUTPUT);
        digitalWrite(register_count_up_pins[i], HIGH);
        pinMode(register_count_up_pins[i], OUTPUT);
        digitalWrite(register_count_down_pins[i], HIGH);
        pinMode(register_count_down_pins[i], OUTPUT);
    }

    digitalWrite(reset_pin, LOW);

    Serial.begin(115200);
}

void loop()
{

    Serial.println("Testing address register module...");
    failed = false;
    for (size_t register_number = 0; register_number < 4; register_number++)
    {
        for (size_t i = 0; i < 16; i++)
        {
            testRegister(1 << i, register_number, 0, true);
        }
    }
    for (size_t register_number = 0; register_number < 4; register_number++)
    {
        for (size_t i = 0; i < 16; i++)
        {
            testRegister(1 << i, register_number, 1, true);
        }
    }
    for (size_t register_number = 0; register_number < 4; register_number++)
    {
        for (size_t i = 0; i < 16; i++)
        {
            testRegister(1 << i, register_number, 1, false);
        }
    }
    for (size_t register_number = 0; register_number < 4; register_number++)
    {
        testRegister(0, register_number, 0, true);
    }
    for (size_t register_number = 0; register_number < 4; register_number++)
    {
        testRegister(0xffff, register_number, 0, true);
    }
    for (size_t register_number = 0; register_number < 4; register_number++)
    {
        testRegister(0, register_number, 1, true);
    }
    for (size_t register_number = 0; register_number < 4; register_number++)
    {
        testRegister(0xffff, register_number, 1, true);
    }
    for (size_t register_number = 0; register_number < 4; register_number++)
    {
        testRegister(0, register_number, 1, false);
    }
    for (size_t register_number = 0; register_number < 4; register_number++)
    {
        testRegister(0xffff, register_number, 1, false);
    }

    for (size_t register_number = 0; register_number < 4; register_number++)
    {
        for (size_t i = 0; i < 256; i++)
        {
            testRegister(random(), register_number, 0, true);
        }
    }

    for (size_t register_number = 0; register_number < 4; register_number++)
    {
        for (size_t i = 0; i < 8; i++)
        {
            testRegister(random(), register_number, random(), random() % 2 == 0);
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
