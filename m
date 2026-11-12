Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478813;
	b=IB2VdSr6KieLcBleSQ5q9bg0n4pMSa1QFXta2kV74Q3FPXvQ0++cSttiP9qbya0eYpOY
	 SjFsE3uxl3keZm2qM2l4W8vGGgDPRspayl7k/oYL9G7CUM33I8OHtDnL8NDw5eryt2rRg
	 9UcQqnXdRBPf4g+lXpAicOTMjbrNwHxhjVNSPBNUubkfAgfzU5Hix9aOarfsLRDEGvQx4
	 6YdkY7V4NknC6b15VknLUWwSxae1XqAJz9agt717CmsTyY8BYqBEQ00aAjShxV5YtzwiV
	 WqlRIDsXyJIZukHHxZKDVkC7eGAcnVP8cjgd0H1IDOeZPj8ktPodOHLf/Kgk99Ojsyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478813;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bXUza2dtxHp/ZgF8FPlTcx86KZUYVyZV3dLfWuTp0+Q=;
	b=lker0pkzGIOXJKWRNaecLb79ePTBJKxoBMNhPhieFfGwAk6S+NlNQciHHma3FhTNUhMH
	 7O8DmLT3IMWmy9BqI/elV5R3sVArM+IZzoAytqcs6yXxCgTmS7/5dnaaaQWSDP56+N/CS
	 c6PRp11sChqsDB3M18bOqa8GVEBD730au7iXEo2gv0BJv42wuOAlnmrIH1c+0RmN5quxj
	 dOdUuM4D2HGmVVjuoatloWjl9rZMtkPYtM87qNpA144Q+5cqLwjV+t3lgIbZgvjEmyP/P
	 Z2CjXVl534YdbDvFK/3fIK3vop+uizRSO8P8yNs0xO31f6c8BWf/UFMhZW4KOa8fJMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTcLwT9z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7091606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTcLwT9z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD421F00A05;
	Thu, 12 Nov 2026 10:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794478812;
	bh=bXUza2dtxHp/ZgF8FPlTcx86KZUYVyZV3dLfWuTp0+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gTcLwT9zq2FckhRNxtPbqIQ1MfbSPyqxzpmJEDyf2hoVxHWEK2mmMF9cesdMjXKfb
	 re21e+IVXzjZ3H6qAbD8x1NLvtPalXA0nyZwrzHZxYTsVXBUl/kw/L1iVOh3ipQOOz
	 FhnZnLrDgz7Eltkjy2WV97cYfvSd7Edd+HiUVKLgEKMJAJnIVCMD5hYFORYLhXtsRT
	 H89zUJZFfmRo2MGarSib0M+Bif+kw/OEEzm1Ken9Qsv8/O1VpqKA3EcRBiOYnC7yXJ
	 /jaq/oFnD26iaDWB75r5wmfMod/GtQDf8Q//LJ+u2PyW+Y+K8ZNxk1+CABfNNPMESy
	 rtI9Wgo2yT8Mw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@kernel.org
Subject: [PATCH net 2/2] selftests: net: add a test for NSH GSO
Date: Thu, 12 Nov 2026 11:20:01 +0100
Message-ID: <20261112102001.3744643-3-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112102001.3744643-1-edumazet@kernel.org>
References: <20261112102001.3744643-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Send TCPv4 GSO packets encapsulated in a stack of NSH headers to a
dummy device which has TSO disabled, using a packet socket with
PACKET_VNET_HDR, and count the packets the device transmits.

Packets with one or four NSH headers must be segmented. Packets with
5, 64 or 8000 NSH headers must be dropped: they exceed the recursion
limit of the GSO handlers. Without the limit in nsh_gso_segment(),
the last one overflows the kernel stack.

 # ./nsh_gso.sh
 PASS: 1 NSH headers: 4 packets sent
 PASS: 4 NSH headers: 4 packets sent
 PASS: 5 NSH headers: 0 packets sent
 PASS: 64 NSH headers: 0 packets sent
 PASS: 8000 NSH headers: 0 packets sent

Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 tools/testing/selftests/net/.gitignore |   1 +
 tools/testing/selftests/net/Makefile   |   2 +
 tools/testing/selftests/net/config     |   1 +
 tools/testing/selftests/net/nsh_gso.c  | 126 +++++++++++++++++++++++++
 tools/testing/selftests/net/nsh_gso.sh |  71 ++++++++++++++
 5 files changed, 201 insertions(+)
 create mode 100644 tools/testing/selftests/net/nsh_gso.c
 create mode 100755 tools/testing/selftests/net/nsh_gso.sh

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index ca451bfeda75..27761239d069 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -21,6 +21,7 @@ log.txt
 msg_zerocopy
 netlink-dumps
 nettest
+nsh_gso
 proc_net_pktgen
 psock_fanout
 psock_snd
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 85f51a30c6a1..baea3e7f0f8f 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -76,6 +76,7 @@ TEST_PROGS := \
 	nk_qlease.py \
 	nl_netdev.py \
 	nl_nlctrl.py \
+	nsh_gso.sh \
 	pmtu.sh \
 	protodown.sh \
 	psock_snd.sh \
@@ -157,6 +158,7 @@ TEST_GEN_FILES := \
 	ipv6_flowlabel \
 	msg_zerocopy \
 	nettest \
+	nsh_gso \
 	psock_fanout \
 	psock_snd \
 	psock_tpacket \
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index d4416f8bdcfd..3e7ce41bd64d 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -99,6 +99,7 @@ CONFIG_NET_IPVTI=y
 CONFIG_NETKIT=y
 CONFIG_NET_L3_MASTER_DEV=y
 CONFIG_NET_NS=y
+CONFIG_NET_NSH=m
 CONFIG_NET_PKTGEN=m
 CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_FQ=m
diff --git a/tools/testing/selftests/net/nsh_gso.c b/tools/testing/selftests/net/nsh_gso.c
new file mode 100644
index 000000000000..9acd3f755723
--- /dev/null
+++ b/tools/testing/selftests/net/nsh_gso.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Send one TCPv4 GSO packet encapsulated in a stack of NSH headers,
+ * through a packet socket with PACKET_VNET_HDR.
+ *
+ * Usage: nsh_gso <ifname> <number of NSH headers>
+ *
+ * The packet is made of 4 segments. The send() result is not checked:
+ * the caller looks at the device counters.
+ */
+
+#include <arpa/inet.h>
+#include <errno.h>
+#include <error.h>
+#include <linux/if_ether.h>
+#include <linux/if_packet.h>
+#include <linux/ip.h>
+#include <linux/tcp.h>
+#include <linux/virtio_net.h>
+#include <net/if.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <unistd.h>
+
+#ifndef ETH_P_NSH
+#define ETH_P_NSH	0x894F
+#endif
+
+#define NSH_HLEN	8	/* base header + service path header */
+#define NSH_MD_TYPE2	2	/* no mandatory context header */
+#define NSH_NP_IPV4	1
+#define NSH_NP_NSH	4
+
+#define GSO_SIZE	500
+#define NR_SEGS		4
+
+struct nsh_base {
+	__be16	ver_flags_ttl_len;
+	__u8	mdtype;
+	__u8	np;
+	__be32	path_hdr;
+};
+
+int main(int argc, char **argv)
+{
+	unsigned int depth, hlen, len, i;
+	struct sockaddr_ll addr = {};
+	struct virtio_net_hdr *vnet;
+	struct nsh_base *nsh;
+	struct ethhdr *eth;
+	struct tcphdr *tcp;
+	int fd, one = 1;
+	struct iphdr *ip;
+	char *buf;
+
+	if (argc != 3)
+		error(1, 0, "usage: %s <ifname> <depth>", argv[0]);
+
+	depth = strtoul(argv[2], NULL, 0);
+	hlen = sizeof(*eth) + depth * NSH_HLEN + sizeof(*ip) + sizeof(*tcp);
+	if (!depth || hlen > UINT16_MAX)
+		error(1, 0, "invalid depth %u", depth);
+	len = sizeof(*vnet) + hlen + NR_SEGS * GSO_SIZE;
+
+	buf = calloc(1, len);
+	if (!buf)
+		error(1, errno, "calloc");
+
+	vnet = (void *)buf;
+	vnet->flags = VIRTIO_NET_HDR_F_NEEDS_CSUM;
+	vnet->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
+	vnet->hdr_len = hlen;
+	vnet->gso_size = GSO_SIZE;
+	vnet->csum_start = hlen - sizeof(*tcp);
+	vnet->csum_offset = __builtin_offsetof(struct tcphdr, check);
+
+	eth = (void *)(vnet + 1);
+	memset(eth->h_dest, 0xff, ETH_ALEN);
+	eth->h_source[0] = 0x02;
+	eth->h_proto = htons(ETH_P_NSH);
+
+	nsh = (void *)(eth + 1);
+	for (i = 0; i < depth; i++, nsh++) {
+		/* version 0, ttl 63, length in 4 byte words */
+		nsh->ver_flags_ttl_len = htons(63 << 6 | NSH_HLEN / 4);
+		nsh->mdtype = NSH_MD_TYPE2;
+		nsh->np = i == depth - 1 ? NSH_NP_IPV4 : NSH_NP_NSH;
+		nsh->path_hdr = htonl(1 << 8 | 255);
+	}
+
+	ip = (void *)nsh;
+	ip->version = 4;
+	ip->ihl = 5;
+	ip->ttl = 64;
+	ip->protocol = IPPROTO_TCP;
+	ip->saddr = htonl(0xc0000201);	/* 192.0.2.1 */
+	ip->daddr = htonl(0xc0000202);	/* 192.0.2.2 */
+
+	tcp = (void *)(ip + 1);
+	tcp->source = htons(1234);
+	tcp->dest = htons(5678);
+	tcp->doff = 5;
+	tcp->ack = 1;
+
+	fd = socket(AF_PACKET, SOCK_RAW, 0);
+	if (fd < 0)
+		error(1, errno, "socket");
+	if (setsockopt(fd, SOL_PACKET, PACKET_VNET_HDR, &one, sizeof(one)))
+		error(1, errno, "setsockopt PACKET_VNET_HDR");
+
+	addr.sll_family = AF_PACKET;
+	addr.sll_protocol = htons(ETH_P_NSH);
+	addr.sll_ifindex = if_nametoindex(argv[1]);
+	if (!addr.sll_ifindex)
+		error(1, errno, "if_nametoindex %s", argv[1]);
+
+	/* A packet dropped at segmentation time is reported as an error,
+	 * this is expected for deep stacks.
+	 */
+	sendto(fd, buf, len, 0, (void *)&addr, sizeof(addr));
+
+	close(fd);
+	free(buf);
+	return 0;
+}
diff --git a/tools/testing/selftests/net/nsh_gso.sh b/tools/testing/selftests/net/nsh_gso.sh
new file mode 100755
index 000000000000..d0746cf1d528
--- /dev/null
+++ b/tools/testing/selftests/net/nsh_gso.sh
@@ -0,0 +1,71 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Check software GSO of NSH packets: a TCP GSO packet behind a few NSH
+# headers is segmented, and a deep stack of NSH headers is dropped
+# instead of recursing in nsh_gso_segment() for each of them.
+
+source lib.sh
+
+NR_SEGS=4
+ret=0
+
+cleanup()
+{
+	cleanup_ns $ns1
+}
+
+tx_packets()
+{
+	ip netns exec $ns1 cat /sys/class/net/dummy0/statistics/tx_packets
+}
+
+# $1: number of NSH headers, $2: expected number of transmitted packets
+check_nsh_gso()
+{
+	local depth=$1
+	local expected=$2
+	local before
+	local sent
+
+	before=$(tx_packets)
+	ip netns exec $ns1 ./nsh_gso dummy0 $depth
+	sent=$(($(tx_packets) - before))
+
+	if [ $sent -eq $expected ]; then
+		echo "PASS: $depth NSH headers: $sent packets sent"
+	else
+		echo "FAIL: $depth NSH headers: $sent packets sent, expected $expected"
+		ret=1
+	fi
+}
+
+modprobe -q nsh
+nsh_loaded=$?
+
+trap cleanup EXIT
+setup_ns ns1 || exit $ksft_skip
+
+ip -netns $ns1 link add dummy0 type dummy
+ip -netns $ns1 link set dummy0 up
+# No IPv6 autoconf traffic on the device, to get stable counters.
+ip netns exec $ns1 sysctl -qw net.ipv6.conf.dummy0.disable_ipv6=1
+# Force software segmentation in validate_xmit_skb().
+ip netns exec $ns1 ethtool -K dummy0 tso off >/dev/null || exit $ksft_skip
+
+before=$(tx_packets)
+ip netns exec $ns1 ./nsh_gso dummy0 1
+if [ $(($(tx_packets) - before)) -eq 0 ] && [ $nsh_loaded -ne 0 ]; then
+	echo "SKIP: NSH GSO not available"
+	exit $ksft_skip
+fi
+
+check_nsh_gso 1 $NR_SEGS
+# The recursion limit is shared with the inner IPv4 header.
+check_nsh_gso 4 $NR_SEGS
+check_nsh_gso 5 0
+check_nsh_gso 64 0
+# The largest stack that fits in a 64KB header.
+check_nsh_gso 8000 0
+
+exit $ret
-- 
2.53.0

