CC = gcc -std=c99 -g
CFILES = vector.c gravity.c main.c 
HFILES = vector.h gravity.h
OUT = cgravity

all: $(OUT)

clean:
	rm $(OUT)

run: $(OUT)
	./$(OUT)

$(OUT): $(CFILES) $(HFILES)
	$(CC) $(CFILES) -o $(OUT)

