Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805058;
	b=b2zjSQlOAZjGczX6avt3Wp9MXVcN82QdCCJm+8EorRQexw9Bi2mNfJe/Cp0yxPfB5vDp
	 z+MUF8J7CFiK1r4bnlqrpUPI29ZRLfp9ymp9PpJd0Bj12602H9dBmmny60nDXZFvsB4Fr
	 uID7WwFuFW4XgWIfTLTaqa/9jpkqLwcAPktlSHAzbZRfqNPHaL7+bXXbAgcLoR+rGu6ST
	 JBBlfHGptDjGQMrNlrL5y0AfcqRS+Pwacpl6pk63B7OSAbu0II2POzom5Z0VCt1yAskLn
	 lNa1luVRxU9XC99Qpcy6kns8X75XHMP/rL8JFrgC+lmu2UXbLWxanu+Sj1jAr9XjKjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805058;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=b8aZQEPYie5kxgKmnSX8nOrITEVukdnLIdfXdABdW/o=;
	b=edMHjHwFdJSthCeGS15+HYADsP8t4KfLb0vM1jU0F+awAGalpdIqTgbn72HSsJwnW+sx
	 9vEtFUdEF1CbbxZyVuNj1CBJr5BfbK+1x+OwrIBXxzDUhSIZYXfXm7nxmBsdij+CGef8z
	 6YXPlIV2b0B3tWsB10McA1gp+MyFBmMHRogvLvG5bvs7bvopYA7Kcs0nMuJeHlUJF0boU
	 ynqy+s1TzwaSpYospvcvP6eH0g6w/NZKfU+UNJbI1pQjOA/f4RNY5Z5+4FMP0AXrFdiWq
	 0g0GAHz0wQ/o504Qg7tnvxKuhlKw1eJ/gM89XmdWBL4kcnPX4CQz0YL4+jD2c4RkoSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=oITUb1lJ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=g3PejkQg;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33211606A33D
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33211606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=oITUb1lJ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=g3PejkQg
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793805055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8aZQEPYie5kxgKmnSX8nOrITEVukdnLIdfXdABdW/o=;
	b=oITUb1lJ8Fp0ZSQYIFXgvz4N1ka2MeQU+MhI9QKpu35bqoNvcR+9GdsCkhq+aT2cMrFkkL
	JXmv0duzT2H8SfgnC3lTicHAvyFWZCFJMv56cuBkm3PCOSP64xaC/9jXJ+OFJCTgUXlL85
	gNi4qrJICHlqNt/6EIs0o/1QqWHHejzsZC0gv5lFkk9GvfUivMHqAnETsaYjAvTczOuOAm
	OPq9f2lHYYLD/lKntPkdU83byjcYwc5fO4Zp64TYXT9Z/6jXWbBALkUXr5PO5qBvVdG+dQ
	zs7alffQeRtafzQcd3vgSssr0iPGw3RhYm12qEyqx+tt5LW+sEQL5LCRTNI7+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793805055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8aZQEPYie5kxgKmnSX8nOrITEVukdnLIdfXdABdW/o=;
	b=g3PejkQgjgeH0Rpm+l36BkEHB7jBCjAiTkD7iaV552tNVPN3QGgjK+4r7jeb8h5cXFN6Fi
	vnp5OWBDQtiuAfAg==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net-next v10 8/8] selftests: hsr: Add test for the inline PTP header on HSR
Date: Wed,  4 Nov 2026 16:10:44 +0100
Message-ID: <20261104-hsr_ptp-v10-8-2c4a38ad973c@linutronix.de>
In-Reply-To: <20261104-hsr_ptp-v10-0-2c4a38ad973c@linutronix.de>
References: <20261104-hsr_ptp-v10-0-2c4a38ad973c@linutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This test verifies the inline header which is used by HSR stack with the
ether type ETH_P_1588.
The HSR stack needs to recognize this header, strip it and send the
requested packet only on the requested port.

This test needs a HSR device and the two slave devices passed. It will
will send a sample PTP packet with this inline header, requesting one of
the ports combining with and without the HSR header. A total of four
packets is sent.
The test checks both ports devices for packets and complains if the
packet was not observed on the expected port and/ or observed on the
other port. The received content of the data is compared against the
send data sample. If the HSR header was supplied it verifies the
sequence number and the SRC-MAC of the received header if it matches.

Test suggested by Felix Maurer.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/include/uapi/linux/hsr_ptp.h             |  20 +
 tools/testing/selftests/net/hsr/.gitignore     |   1 +
 tools/testing/selftests/net/hsr/Makefile       |   5 +
 tools/testing/selftests/net/hsr/hsr_ptp.sh     | 109 ++++++
 tools/testing/selftests/net/hsr/hsr_ptp_test.c | 496 +++++++++++++++++++++=
++++
 5 files changed, 631 insertions(+)

diff --git a/tools/include/uapi/linux/hsr_ptp.h b/tools/include/uapi/linux/=
hsr_ptp.h
new file mode 100644
index 0000000000000..95e905441ebdc
--- /dev/null
+++ b/tools/include/uapi/linux/hsr_ptp.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef __UAPI_HSR_PTP_H
+#define __UAPI_HSR_PTP_H
+
+#include <linux/types.h>
+
+#define HSR_INLINE_HDR  0xaf485352
+#define HSR_INLINE_HDR_PORT_A	1
+#define HSR_INLINE_HDR_PORT_B	2
+
+struct hsr_inline_header {
+	__u8 req_tx_port;
+	__u8 has_hsr_header;
+	__be32 __pad0;
+	__be32 magic;
+	__be16 __pad1;
+	__be16 eth_type;
+} __attribute__ ((packed));
+
+#endif
diff --git a/tools/testing/selftests/net/hsr/.gitignore b/tools/testing/sel=
ftests/net/hsr/.gitignore
new file mode 100644
index 0000000000000..849eecb84c974
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/.gitignore
@@ -0,0 +1 @@
+hsr_ptp_test
diff --git a/tools/testing/selftests/net/hsr/Makefile b/tools/testing/selft=
ests/net/hsr/Makefile
index 2150e487ac7d7..512ccf61b6652 100644
--- a/tools/testing/selftests/net/hsr/Makefile
+++ b/tools/testing/selftests/net/hsr/Makefile
@@ -2,9 +2,12 @@
=20
 top_srcdir =3D ../../../../..
=20
+CFLAGS +=3D -Wall -Wl,--no-as-needed -O2 -g $(TOOLS_INCLUDES)
+
 TEST_PROGS :=3D \
 	hsr_ping.sh \
 	hsr_prp_redbox.sh \
+	hsr_ptp.sh \
 	hsr_redbox.sh \
 	link_faults.sh \
 	prp_ping.sh \
@@ -12,4 +15,6 @@ TEST_PROGS :=3D \
=20
 TEST_FILES +=3D hsr_common.sh
=20
+TEST_GEN_FILES :=3D hsr_ptp_test
+
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/hsr/hsr_ptp.sh b/tools/testing/sel=
ftests/net/hsr/hsr_ptp.sh
new file mode 100755
index 0000000000000..23379b1ce7a56
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/hsr_ptp.sh
@@ -0,0 +1,109 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+ipv6=3Dfalse
+
+source ./hsr_common.sh
+
+optstring=3D"h"
+usage() {
+	echo "Usage: $0"
+}
+
+while getopts "$optstring" option;do
+	case "$option" in
+	"h")
+		usage "$0"
+		exit 0
+		;;
+	"?")
+		usage "$0"
+		exit 1
+		;;
+esac
+done
+
+setup_hsr_interfaces()
+{
+	local HSRv=3D"$1"
+
+	echo "INFO: Preparing interfaces for HSRv${HSRv}."
+# Three HSR nodes. Each node has one link to each of its neighbour, two li=
nks in total.
+
+#    ns1eth1 ----- ns2eth1
+#      hsr1         hsr2
+#    ns1eth2       ns2eth2
+#       |            |
+#    ns3eth1      ns3eth2
+#           \    /
+#            hsr3
+#
+	# Interfaces
+	ip link add ns1eth1 netns "$ns1" type veth peer name ns2eth1 netns "$ns2"
+	ip link add ns1eth2 netns "$ns1" type veth peer name ns3eth1 netns "$ns3"
+	ip link add ns3eth2 netns "$ns3" type veth peer name ns2eth2 netns "$ns2"
+
+	# HSRv0/1
+	ip -net "$ns1" link add name hsr1 type hsr slave1 ns1eth1 \
+		slave2 ns1eth2 supervision 45 version "$HSRv" proto 0
+	ip -net "$ns2" link add name hsr2 type hsr slave1 ns2eth1 \
+		slave2 ns2eth2 supervision 45 version "$HSRv" proto 0
+	ip -net "$ns3" link add name hsr3 type hsr slave1 ns3eth1 \
+		slave2 ns3eth2 supervision 45 version "$HSRv" proto 0
+
+	# IP for HSR
+	ip -net "$ns1" addr add 100.64.0.1/24 dev hsr1
+	ip -net "$ns1" addr add dead:beef:0::1/64 dev hsr1 nodad
+	ip -net "$ns2" addr add 100.64.0.2/24 dev hsr2
+	ip -net "$ns2" addr add dead:beef:0::2/64 dev hsr2 nodad
+	ip -net "$ns3" addr add 100.64.0.3/24 dev hsr3
+	ip -net "$ns3" addr add dead:beef:0::3/64 dev hsr3 nodad
+
+	ip -net "$ns1" link set address 00:11:22:00:01:01 dev ns1eth1
+	ip -net "$ns1" link set address 00:11:22:00:01:02 dev ns1eth2
+
+	ip -net "$ns2" link set address 00:11:22:00:02:01 dev ns2eth1
+	ip -net "$ns2" link set address 00:11:22:00:02:02 dev ns2eth2
+
+	ip -net "$ns3" link set address 00:11:22:00:03:01 dev ns3eth1
+	ip -net "$ns3" link set address 00:11:22:00:03:02 dev ns3eth2
+
+	# All Links up
+	ip -net "$ns1" link set ns1eth1 up
+	ip -net "$ns1" link set ns1eth2 up
+	ip -net "$ns1" link set hsr1 up
+
+	ip -net "$ns2" link set ns2eth1 up
+	ip -net "$ns2" link set ns2eth2 up
+	ip -net "$ns2" link set hsr2 up
+
+	ip -net "$ns3" link set ns3eth1 up
+	ip -net "$ns3" link set ns3eth2 up
+	ip -net "$ns3" link set hsr3 up
+}
+
+run_ptp_hdr_tests()
+{
+	echo "INFO: Running PTP-header tests."
+
+	ip netns exec "$ns1" ./hsr_ptp_test -H hsr1 -A ns1eth1 -B ns1eth2
+	ret=3D$?
+	stop_if_error "PTP header test failed (ns1)."
+
+	ip netns exec "$ns2" ./hsr_ptp_test -H hsr2 -A ns2eth1 -B ns2eth2
+	ret=3D$?
+	stop_if_error "PTP header test failed (ns2)."
+
+	ip netns exec "$ns3" ./hsr_ptp_test -H hsr3 -A ns3eth1 -B ns3eth2
+	ret=3D$?
+	stop_if_error "PTP header test failed (ns3)."
+}
+
+check_prerequisites
+trap cleanup_all_ns EXIT
+
+setup_ns ns1 ns2 ns3
+setup_hsr_interfaces 1
+run_ptp_hdr_tests
+
+exit $ret
diff --git a/tools/testing/selftests/net/hsr/hsr_ptp_test.c b/tools/testing=
/selftests/net/hsr/hsr_ptp_test.c
new file mode 100644
index 0000000000000..e2c2da56138ae
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/hsr_ptp_test.c
@@ -0,0 +1,496 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Simple test to verify the usage of the inline header used for HSR with
+ * ether type ETH_P_1588.
+ * The inline header has to be stripped, the sent packet must only appear =
on the
+ * specified port and the interface needs to accept a foreign HSR header a=
nd
+ * prepend its own header.
+ *
+ * Socket handling inspired by raw.c from linuxptp.
+ *
+ */
+#include <poll.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <linux/types.h>
+#include <linux/hsr_ptp.h>
+#include <linux/if_ether.h>
+#include <net/if.h>
+#include <netinet/in.h>
+#include <netpacket/packet.h>
+#include <sys/ioctl.h>
+
+#define MSEC_TO_NSEC(_x)	(_x * 1000000)
+#define USEC_PER_SEC		1000000
+#define NSEC_PER_SEC		1000000000
+
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+#define MAC_LEN  6
+typedef uint8_t eth_addr[MAC_LEN];
+
+struct eth_hdr {
+	eth_addr dst;
+	eth_addr src;
+	uint16_t type;
+} __packed;
+
+struct hsr_hdr {
+	eth_addr dst;
+	eth_addr src;
+	uint16_t type;
+	uint16_t pathid_and_LSDU_size;
+	uint16_t sequence_nr;
+	uint16_t encap_type;
+} __packed;
+
+struct hsr_meta_header {
+	struct hsr_inline_header hsr_opt;
+	union {
+		struct hsr_hdr hsr_hdr;
+		struct eth_hdr eth_hdr;
+	};
+} __packed;
+
+static uint8_t ptp_packet[] =3D {
+	0x00, 0x12, 0x00, 0x2c, 0x00, 0x00, 0x02, 0x00,  0x00, 0x00, 0x00, 0x00, =
0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x88, 0x88, 0x88, 0x88,  0x88, 0x88, 0x88, 0x88, =
0x00, 0x01, 0x00, 0x01,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  0x00, 0x00, 0x00, 0x00, =
0x00, 0x00,
+};
+
+static uint8_t p2p_dst_mac[MAC_LEN] =3D {
+	0x01, 0x80, 0xc2, 0x00, 0x00, 0x0e
+};
+
+static uint8_t slave_mac_addr[MAC_LEN];
+static int32_t fd_slaveA =3D -1;
+static int32_t fd_slaveB =3D -1;
+static int32_t fd_hsr =3D -1;
+static uint16_t hsr_seq =3D 37;
+
+static void tsnorm(struct timespec *ts)
+{
+	while (ts->tv_nsec >=3D NSEC_PER_SEC) {
+		ts->tv_nsec -=3D NSEC_PER_SEC;
+		ts->tv_sec++;
+	}
+}
+
+static int64_t calcdiff(struct timespec t1, struct timespec t2)
+{
+	int64_t diff =3D USEC_PER_SEC * (long long)((int) t1.tv_sec - (int) t2.tv=
_sec);
+
+	diff +=3D ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000;
+	return diff;
+}
+
+static int tsgreater(struct timespec *a, struct timespec *b)
+{
+	return ((a->tv_sec > b->tv_sec) ||
+		(a->tv_sec =3D=3D b->tv_sec && a->tv_nsec > b->tv_nsec));
+}
+
+static int sk_interface_index(int fd, const char *name)
+{
+	struct ifreq ifreq;
+	int32_t err;
+
+	memset(&ifreq, 0, sizeof(ifreq));
+	strncpy(ifreq.ifr_name, name, sizeof(ifreq.ifr_name) - 1);
+	err =3D ioctl(fd, SIOCGIFINDEX, &ifreq);
+	if (err < 0) {
+		printf("ioctl SIOCGIFINDEX failed: %m\n");
+		return err;
+	}
+	return ifreq.ifr_ifindex;
+}
+
+static int open_socket(const char *name)
+{
+	struct sockaddr_ll addr;
+	int32_t fd, index;
+
+	fd =3D socket(AF_PACKET, SOCK_RAW, 0);
+	if (fd < 0) {
+		printf("socket failed: %m\n");
+		goto err;
+	}
+	index =3D sk_interface_index(fd, name);
+	if (index < 0)
+		goto err;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sll_ifindex =3D index;
+	addr.sll_family =3D AF_PACKET;
+	addr.sll_protocol =3D htons(ETH_P_ALL);
+	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr))) {
+		printf("bind failed: %m\n");
+		goto err;
+	}
+	if (setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, name, strlen(name))) {
+		printf("setsockopt SO_BINDTODEVICE failed: %m\n");
+		goto err;
+	}
+
+	return fd;
+err:
+	if (fd >=3D 0)
+		close(fd);
+	return -1;
+}
+
+static int sk_interface_macaddr(const char *name)
+{
+	struct ifreq ifreq;
+	int32_t err, fd;
+
+	memset(&ifreq, 0, sizeof(ifreq));
+	strncpy(ifreq.ifr_name, name, sizeof(ifreq.ifr_name) - 1);
+
+	fd =3D socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	if (fd < 0) {
+		printf("socket failed: %m\n");
+		return -1;
+	}
+
+	err =3D ioctl(fd, SIOCGIFHWADDR, &ifreq);
+	if (err < 0) {
+		printf("ioctl SIOCGIFHWADDR failed: %m\n");
+		close(fd);
+		return -1;
+	}
+
+	close(fd);
+
+	memcpy(slave_mac_addr, &ifreq.ifr_hwaddr.sa_data, MAC_LEN);
+	return 0;
+}
+
+static int raw_open(const char *hsr_dev, const char *slaveA_dev, const cha=
r *slaveB_dev)
+{
+
+	if (sk_interface_macaddr(slaveA_dev))
+		goto err;
+
+	fd_slaveA =3D open_socket(slaveA_dev);
+	if (fd_slaveA < 0)
+		goto err;
+
+	fd_slaveB =3D open_socket(slaveB_dev);
+	if (fd_slaveB < 0)
+		goto err;
+
+	fd_hsr =3D open_socket(hsr_dev);
+	if (fd_hsr < 0)
+		goto err;
+
+	return 0;
+
+err:
+	if (fd_slaveA >=3D 0)
+		close(fd_slaveA);
+	if (fd_slaveB >=3D 0)
+		close(fd_slaveB);
+	if (fd_hsr >=3D 0)
+		close(fd_hsr);
+
+	return -1;
+}
+
+static int sk_receive(int fd, void *buf, int buflen)
+{
+	struct iovec iov =3D { buf, buflen };
+	uint8_t control[256];
+	int32_t cnt =3D 0;
+	struct msghdr msg;
+
+	memset(control, 0, sizeof(control));
+	memset(&msg, 0, sizeof(msg));
+
+	msg.msg_iov =3D &iov;
+	msg.msg_iovlen =3D 1;
+	msg.msg_control =3D control;
+	msg.msg_controllen =3D sizeof(control);
+
+	cnt =3D recvmsg(fd, &msg, MSG_DONTWAIT);
+	if (cnt < 0)
+		return 0;
+	return cnt;
+}
+
+static int raw_recv(int fd, bool fwd_hsr, void *sample, int sample_len)
+{
+	struct timespec now, end;
+	struct hsr_hdr *hsr_hdr;
+	uint8_t buf[1500];
+	int32_t cnt;
+
+	/* The packet is expected to arrive within 100ms. HSR will send hello
+	 * packets so there an end time and poll() will wait until this point.
+	 */
+	clock_gettime(CLOCK_MONOTONIC, &now);
+	end =3D now;
+	end.tv_nsec +=3D MSEC_TO_NSEC(100);
+	tsnorm(&end);
+again:
+
+	cnt =3D sk_receive(fd, buf, sizeof(buf));
+	if (cnt =3D=3D 0) {
+		int64_t sleep_time;
+		struct pollfd pfd;
+		int ret;
+
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		if (tsgreater(&now, &end))
+			return 0;
+
+		sleep_time =3D calcdiff(end, now) / 1000;
+		if (sleep_time <=3D 0)
+			return 0;
+
+		pfd.fd =3D fd;
+		pfd.events =3D POLLIN;
+		ret =3D poll(&pfd, 1, sleep_time);
+		if (ret <=3D 0)
+			return ret;
+		goto again;
+	}
+
+	if (cnt < sizeof(struct hsr_hdr))
+		goto again;
+
+	hsr_hdr =3D (void *)buf;
+	/* Embedded magic packet passed? */
+	if (hsr_hdr->type =3D=3D htons(ETH_P_1588)) {
+		struct hsr_inline_header *hsr_opt =3D (void *)buf;
+
+		if (hsr_opt->magic =3D=3D htonl(HSR_INLINE_HDR)) {
+			printf("Error: Found HSR_INLINE_HDR\n");
+			return -1;
+		}
+	}
+	/* Assuming it is *our* network and nobody but the test here sends
+	 * packets to p2p_dst_mac. Therefore any received packet needs to be
+	 * ours and every mismatch is considered as error.
+	 */
+	if (memcmp(hsr_hdr->dst, p2p_dst_mac, MAC_LEN))
+		goto again;
+
+	if (hsr_hdr->type !=3D htons(ETH_P_HSR)) {
+		printf("Error: Unexpected ether type: 0x%x\n", ntohs(hsr_hdr->type));
+		return -1;
+	}
+
+	if (hsr_hdr->encap_type !=3D htons(ETH_P_1588)) {
+		printf("Error: Unexpected encapsulated type: 0x%x\n",
+		       htons(hsr_hdr->encap_type));
+		return -1;
+	}
+
+	if (fwd_hsr) {
+		if (hsr_hdr->sequence_nr !=3D htons(hsr_seq - 1)) {
+			printf("Error: Packet has wrong seq nr, %d vs %d.\n",
+			       ntohs(hsr_hdr->sequence_nr), hsr_seq - 1);
+			return -1;
+		}
+		/* Undo the SRC MAC change in pkt_send() */
+		hsr_hdr->src[3] ^=3D 0x21;
+		if (memcmp(hsr_hdr->src, slave_mac_addr, MAC_LEN)) {
+			printf("Error: Packet has wrong SRC-MAC\n");
+			return -1;
+		}
+	}
+
+	if (cnt < sizeof(struct hsr_hdr) + sample_len) {
+		printf("Error: Packet %d is too small for data check\n", cnt);
+		return -1;
+	}
+
+	if (!memcmp(&buf[sizeof(struct hsr_hdr)], sample, sample_len))
+		return 1;
+
+	printf("Error: Packet did not match the sample\n");
+	return -1;
+}
+
+static int recv_verify(int port, bool fwd_hsr, void *sample, int sample_le=
n)
+{
+	int32_t error =3D 0;
+	int32_t ret;
+
+	ret =3D raw_recv(fd_slaveA, fwd_hsr, sample, sample_len);
+	if (ret < 0)
+		return ret;
+	if (port =3D=3D HSR_INLINE_HDR_PORT_A && ret =3D=3D 0) {
+		printf("Error: Missing packet on portA\n");
+		error =3D 1;
+	}
+	if (port =3D=3D HSR_INLINE_HDR_PORT_B && ret =3D=3D 1) {
+		printf("Error: Not expecting packet on portA\n");
+		error =3D 1;
+	}
+
+	ret =3D raw_recv(fd_slaveB, fwd_hsr, sample, sample_len);
+	if (ret < 0)
+		return ret;
+	if (port =3D=3D HSR_INLINE_HDR_PORT_B && ret =3D=3D 0) {
+		printf("Error: Missing packet on portB\n");
+		error =3D 1;
+	}
+	if (port =3D=3D HSR_INLINE_HDR_PORT_A && ret =3D=3D 1) {
+		printf("Error: Not expecting packet on portB\n");
+		error =3D 1;
+	}
+	return error;
+}
+
+static int32_t pkt_send(int port, bool hsr_hdr, void *data, int data_len)
+{
+	struct hsr_meta_header *hdr;
+	uint8_t packet[200];
+	ssize_t cnt;
+	size_t len;
+
+	memset(packet, 0, sizeof(packet));
+
+	len =3D sizeof(struct hsr_inline_header);
+	hdr =3D (struct hsr_meta_header *)packet;
+	memset(&hdr->hsr_opt, 0, sizeof(hdr->hsr_opt));
+	hdr->hsr_opt.magic =3D htonl(HSR_INLINE_HDR);
+	hdr->hsr_opt.eth_type =3D htons(ETH_P_1588);
+	if (port !=3D HSR_INLINE_HDR_PORT_A && port !=3D HSR_INLINE_HDR_PORT_B) {
+		printf("Wrong port requested\n");
+		return -1;
+	}
+	hdr->hsr_opt.req_tx_port =3D port;
+
+	if (hsr_hdr) {
+		uint16_t pathid_size;
+
+		len +=3D sizeof(struct hsr_hdr);
+		memcpy(&packet[len], data, data_len);
+
+		hdr->hsr_opt.has_hsr_header =3D 1;
+
+		memcpy(&hdr->hsr_hdr.dst, p2p_dst_mac, MAC_LEN);
+		memcpy(&hdr->hsr_hdr.src, slave_mac_addr, MAC_LEN);
+		/* Flip a bit in SRC MAC addr so it does not look like hosts */
+		hdr->hsr_hdr.src[3] ^=3D 0x21;
+
+		hdr->hsr_hdr.type =3D htons(ETH_P_HSR);
+		hdr->hsr_hdr.sequence_nr =3D htons(hsr_seq++);
+		hdr->hsr_hdr.encap_type =3D htons(ETH_P_1588);
+
+		/* The resulting packet must be alteast 66 bytes */
+		if (data_len + sizeof(struct hsr_hdr) < 66)
+			data_len =3D 66 - sizeof(struct hsr_hdr);
+
+		pathid_size =3D data_len + sizeof(struct hsr_hdr) - sizeof(struct eth_hd=
r);
+		pathid_size |=3D (port - 1) << 12;
+
+		hdr->hsr_hdr.pathid_and_LSDU_size =3D htons(pathid_size);
+	} else {
+		len +=3D sizeof(struct eth_hdr);
+		hdr->hsr_opt.has_hsr_header =3D 0;
+
+		memcpy(&hdr->eth_hdr.dst, p2p_dst_mac, MAC_LEN);
+		memcpy(&hdr->eth_hdr.src, slave_mac_addr, MAC_LEN);
+		hdr->eth_hdr.type =3D htons(ETH_P_1588);
+
+		memcpy(&packet[len], data, data_len);
+	}
+
+	cnt =3D send(fd_hsr, packet, len + data_len, 0);
+	if (cnt < 1)
+		return -1;
+
+	return cnt;
+}
+
+int main(int argc, char *argv[])
+{
+	char *slaveA =3D NULL, *slaveB =3D NULL, *hsr_dev =3D NULL;
+	char *msg_mode;
+	int opt;
+
+	while ((opt =3D getopt(argc, argv, "A:B:H:")) !=3D -1) {
+		switch (opt) {
+		case 'A':
+			slaveA =3D strdup(optarg);
+			break;
+
+		case 'B':
+			slaveB =3D strdup(optarg);
+			break;
+
+		case 'H':
+			hsr_dev =3D strdup(optarg);
+			break;
+		default: /* '?' */
+			fprintf(stderr, "Usage: %s -A slaveA -B slaveB -H hsr_device\n",
+				argv[0]);
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	if (!slaveA || !slaveB || !hsr_dev) {
+		fprintf(stderr, "Missing network devices\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if (raw_open(hsr_dev, slaveA, slaveB) < 0)
+		return EXIT_FAILURE;
+
+	msg_mode =3D "PortA, no-hsr-header";
+	if (pkt_send(HSR_INLINE_HDR_PORT_A, false, ptp_packet, sizeof(ptp_packet)=
) < 0) {
+		printf("Sending failed: %s\n", msg_mode);
+		return EXIT_FAILURE;
+	}
+	if (recv_verify(HSR_INLINE_HDR_PORT_A, false, ptp_packet, sizeof(ptp_pack=
et))) {
+		printf("Verify failed: %s\n", msg_mode);
+		return EXIT_FAILURE;
+	}
+
+	ptp_packet[16 + 4]++;
+	msg_mode =3D "PortB, no-hsr-header";
+	if (pkt_send(HSR_INLINE_HDR_PORT_B, false, ptp_packet, sizeof(ptp_packet)=
) < 0) {
+		printf("Sending failed: %s\n", msg_mode);
+		return EXIT_FAILURE;
+	}
+	if (recv_verify(HSR_INLINE_HDR_PORT_B, false, ptp_packet, sizeof(ptp_pack=
et))) {
+		printf("Verify failed: %s\n", msg_mode);
+		return EXIT_FAILURE;
+	}
+
+	ptp_packet[16 + 4]++;
+	msg_mode =3D "PortA, hsr-header";
+	if (pkt_send(HSR_INLINE_HDR_PORT_A, true, ptp_packet, sizeof(ptp_packet))=
 < 0) {
+		printf("Sending failed: %s\n", msg_mode);
+		return EXIT_FAILURE;
+	}
+	if (recv_verify(HSR_INLINE_HDR_PORT_A, true, ptp_packet, sizeof(ptp_packe=
t))) {
+		printf("Verify failed: %s\n", msg_mode);
+		return EXIT_FAILURE;
+	}
+
+	ptp_packet[16 + 4]++;
+	msg_mode =3D "PortB, hsr-header";
+	if (pkt_send(HSR_INLINE_HDR_PORT_B, true, ptp_packet, sizeof(ptp_packet))=
 < 0) {
+		printf("Sending failed: %s\n", msg_mode);
+		return EXIT_FAILURE;
+	}
+	if (recv_verify(HSR_INLINE_HDR_PORT_B, true, ptp_packet, sizeof(ptp_packe=
t))) {
+		printf("Verify failed: %s\n", msg_mode);
+		return EXIT_FAILURE;
+	}
+
+	return EXIT_SUCCESS;
+}

--=20
2.55.0

