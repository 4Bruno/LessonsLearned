
struct struct_test_1
{
    int a;
};
enum my_enum
{
    ENUM_TEST_1,
    ENUM_TEST_2
};
struct struct_test
{
    int a;
    void * ptr;
    struct_test_1 * s;
    my_enum EnumField;
};

int main()
{
    return 0;
}
