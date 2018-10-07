APP_NAME = HackBGRT
FILES_C = src/main.c src/util.c src/types.c src/config.c

GIT_DESCRIBE = $(firstword $(shell git describe --tags) unknown)
OBJECT_FILES = $(patsubst %.c,%.o,$(FILES_C))

export TOPDIR	:= $(shell pwd)/

include Make.rules

CFLAGS += '-DGIT_DESCRIBE=L"$(GIT_DESCRIBE)"'

all: $(APP_NAME).efi

$(APP_NAME).so: $(OBJECT_FILES)
	$(LD) $(LDFLAGS) $^ -o $@ $(LOADLIBES)
	nm -D $@ | grep ' U ' && exit 1 || exit 0

clean:
	rm -f $(OBJECT_FILES) $(APP_NAME).efi $(APP_NAME).so
