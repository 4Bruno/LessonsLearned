# this libraries come from source repository for clang
# https://github.com/llvm/llvm-project/tree/d480f968ad8b56d3ee4a6b6df5532d485b0ad01e/clang/bindings/python
# set your PYTHONPATH where clang folder exist
# or add them in local folder
# set PYTHONPATH=~\resources\clang
# (expects folder clang with ctypes and enumeration files)
# simply run as:
# python CMeta.py
import clang.cindex as cl

# sample command line to create data dump from clang with AST info
# clang -Xclang -ast-dump -fsyntax-only [file]

# Windows VS directory path where clang lib is found
lib   =r'C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\Llvm\x64\bin'
cl.Config.set_library_path(lib)
# main object to begin. It might have multiple translation units
index = cl.Index.create()
# translation unit - object to parse files
tu    = index.parse('test.cpp')

# now we have initialized TU and we have access to AST
# how do we navigate?
# Via cursors
cursor = tu.cursor

def decode(value):
    import sys
    if sys.version_info[0] == 2:
        return value

    try:
        return value.decode('utf-8')
    except AttributeError:
        return value

def PrintFieldDecl(cursor):
    """
    like:
    struct my_struct
    {
        type [*] name; // field declaration
    };
    Will print the fielddeclaration
    """
    FieldName = decode(cursor.spelling) 
    FieldType = ''
    IsPtr = False

    if (cursor.type.kind == cl.TypeKind.POINTER):
        pointee = cursor.type.get_pointee()
        if (pointee.kind == cl.TypeKind.RECORD):
            FieldType = decode(pointee.get_declaration().spelling)
        else:
            FieldType = decode(pointee.kind.spelling)
        IsPtr = True
    else:
        FieldType = decode(cursor.type.kind.spelling)

    print("\t%-30s %s %-20s (%s)" % (FieldType,'*' if IsPtr else ' ',FieldName,cursor.type.kind.name))
    if (cursor.type.kind == cl.TypeKind.ENUM):
        for c in cursor.type.get_declaration().get_children():
            print("\t\t%s %s" % (c.enum_value,decode(c.spelling)))

# what can you do with cursor?
print(cursor.kind) # what am I?
for c in cursor.get_children():
    if (c.kind == cl.CursorKind.STRUCT_DECL):
        print(decode(c.spelling))
        print(c.type.kind)
        print(c.kind)
        print('----------------------')
        for m in c.get_children():
            PrintFieldDecl(m)
