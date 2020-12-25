#include <Arduino.h>

const uint8_t reset_pin = 2;
const uint8_t clock_pin = 3;

const uint8_t register_w_in_pin = 34;
const uint8_t register_z_in_pin = 32;
const uint8_t register_z_clear_pin = 33;
const uint8_t alu_f_pins[] = {30, 31, 28, 29, 26};
const uint8_t alu_out_pin = 27;
const uint8_t carry_in_pin = 24;
const uint8_t overflow_in_pin = 25;
const uint8_t carry_out_pin = 22;
const uint8_t overflow_out_pin = 23;

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

void setAluFunction(uint8_t f)
{
    for (uint8_t i = 0; i < 5; i++)
    {
        digitalWrite(alu_f_pins[i], (f >> i) & 1);
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

    digitalWrite(register_w_in_pin, LOW);
    pinMode(register_w_in_pin, OUTPUT);

    digitalWrite(register_z_in_pin, LOW);
    pinMode(register_z_in_pin, OUTPUT);

    digitalWrite(register_z_clear_pin, LOW);
    pinMode(register_z_clear_pin, OUTPUT);

    digitalWrite(alu_out_pin, HIGH);
    pinMode(alu_out_pin, OUTPUT);

    digitalWrite(carry_in_pin, LOW);
    pinMode(carry_in_pin, OUTPUT);

    digitalWrite(overflow_in_pin, LOW);
    pinMode(overflow_in_pin, OUTPUT);

    pinMode(carry_out_pin, INPUT);

    pinMode(overflow_out_pin, INPUT);

    for (size_t i = 0; i < 5; i++)
    {
        digitalWrite(alu_f_pins[i], LOW);
        pinMode(alu_f_pins[i], OUTPUT);
    }

    digitalWrite(reset_pin, HIGH);

    Serial.begin(115200);

    setDataBusMode(INPUT);
    setAluFunction(0b10000);
    digitalWrite(alu_out_pin, LOW);
    digitalWrite(register_w_in_pin, HIGH);
}

void test(uint8_t inputs, uint16_t op1, uint16_t op2)
{
    uint8_t alu_function = inputs & 0b11111;
    uint8_t basic_alu_operation = inputs & 0b111;
    uint8_t carry_in = (inputs >> 5) & 1;
    uint8_t overflow_in = (inputs >> 6) & 1;

    setDataBusMode(OUTPUT);
    writeDataBus(op1);
    digitalWrite(register_w_in_pin, HIGH);
    pulseClock();
    digitalWrite(register_w_in_pin, LOW);
    writeDataBus(op2);
    digitalWrite(register_z_in_pin, HIGH);
    pulseClock();
    digitalWrite(register_z_in_pin, LOW);

    uint16_t expected_output;
    uint8_t expected_carry_out;
    uint8_t expected_overflow_out;
    uint8_t shift_in;

    switch (basic_alu_operation)
    {
    case 0:
    case 1:
        return;
    case 2:
        shift_in = (new uint8_t[4]{0, 1, carry_in, (op1 >> 15) & 1})[(alu_function >> 3) & 0b11];
        expected_output = op1 << 1 | shift_in;
        expected_carry_out = (op1 >> 15) & 1;
        expected_overflow_out = overflow_in;
        break;
    case 3:
        shift_in = (new uint8_t[4]{0, (op1 >> 15) & 1, carry_in, op1 & 1})[(alu_function >> 3) & 0b11];
        expected_output = op1 >> 1 | (shift_in << 15);
        expected_carry_out = op1 & 1;
        expected_overflow_out = overflow_in;
        break;
    case 4:
        expected_output = op1 & op2;
        expected_carry_out = carry_in;
        expected_overflow_out = overflow_in;
        break;
    case 5:
        expected_output = op1 | op2;
        expected_carry_out = carry_in;
        expected_overflow_out = overflow_in;
        break;
    case 6:
        expected_output = op1 ^ op2;
        expected_carry_out = carry_in;
        expected_overflow_out = overflow_in;
        break;
    case 7:
        expected_output = ~op1;
        expected_carry_out = carry_in;
        expected_overflow_out = overflow_in;
        break;

    default:
        break;
    }

    setAluFunction(alu_function);
    digitalWrite(carry_in_pin, carry_in);
    digitalWrite(overflow_in_pin, overflow_in);
    setDataBusMode(INPUT);
    digitalWrite(alu_out_pin, LOW);
    uint16_t output = readDataBus();
    uint16_t carry_out = digitalRead(carry_out_pin);
    uint16_t overflow_out = digitalRead(overflow_out_pin);

    if (output != expected_output || carry_out != expected_carry_out || overflow_out != expected_overflow_out)
    {
        Serial.println("inputs: " + String(inputs, 2) + " output: " + String(output, 16) + " expected output: " + String(expected_output, 16) + " carry: " + String(carry_out) + " expected carry: " + String(expected_carry_out) + " overflow: " + String(overflow_out) + " expected overflow: " + String(expected_overflow_out));
        failed = true;
    }
    digitalWrite(alu_out_pin, HIGH);
}

void loop()
{
    Serial.println("Testing alu module...");
    failed = false;

    for (uint8_t inputs = 0; inputs < 128; inputs++)
    {
        test(inputs, 0, 0);
        test(inputs, 0, 0xffff);
        test(inputs, 0xffff, 0);
        test(inputs, 0xffff, 0xffff);

        for (size_t i = 0; i < 16; i++)
        {
            test(inputs, random(), random());
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
