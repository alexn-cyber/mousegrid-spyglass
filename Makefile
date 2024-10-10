CC = "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Tools\MSVC\14.41.34120\bin\Hostx64\x64\cl.exe"
CFLAGS = /W4
LIBPATH = "C:\Program Files (x86)\Windows Kits\10\Lib\10.0.20348.0\um\x64"
LIBS = $(LIBPATH)\User32.Lib $(LIBPATH)\Gdi32.Lib
TARGET = mousegrid-spyglass.exe

all: $(TARGET)

$(TARGET): main.c
	$(CC) $(CFLAGS) main.c $(LIBS) /Fe$(TARGET)

clean:
	del $(TARGET)
