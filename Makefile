include config.mk

$(KERNEL): $(OBJ_DIR)/sysinit.o $(OBJ_DIR)/multiboot.o
	$(LD) -T $(LINK_SCRIPT) $^ -o $@

qemu-test-kernel: $(KERNEL)
	$(QEMU) $(QEMU_FLAGS) -kernel $<

$(ISO): $(KERNEL) $(ROOT_DIR)/boot/grub/grub.cfg
	cp $(KERNEL) $(ROOT_DIR)/boot/kernel.bin
	grub-mkrescue $(ROOT_DIR) -o $@

qemu-test-iso: $(ISO)
	$(QEMU) $(QEMU_FLAGS) -cdrom $<

$(OBJ_DIR)/sysinit.o: kernel/sysinit.asm libk/include/multiboot.inc
	$(AS) $(AS_FLAGS) -I libk/include/ $< -o $@

$(OBJ_DIR)/multiboot.o: libk/multiboot.c libk/include/multiboot.h
	$(CC) $(C_FLAGS) -ffreestanding -I libk/include/ -r $< -o $@

clean:
	rm -f $(OBJ_DIR)/*.o
	rm -f $(OBJ_DIR)/*.bin
	rm -f $(ROOT_DIR)/boot/kernel.bin
	rm -f $(ISO)
