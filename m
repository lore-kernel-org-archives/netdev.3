Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886286;
	b=T4FsH96IVLetG18wSV934zWAYpJbwIQtZ+x3F/wY682Ydp85YS9KI1nLPaDxOZSUoVSR
	 zRwATXYaCkNxXpNyhl93MYDw/IE5Lsg2qs5lCMOil3NDpk4629ZMJmokZLseKjgYi0j2S
	 FsnKU66ryWmjVjSkrbj1ZxPfOsIgey4vpw2PoR0EYzwrZ5uUYvnBbnLZo1WD7fmerOg1q
	 eBb70wEET8RQJzyqT2pkEWC6p8km3nwsnABmTpe1eVZOCG7vF+/W1hKBOfkLDCURJCEhv
	 BipRwlfp6u4rSMOnn7PCZPafk9lIZ7qvaqZqyITdE2tXTOpvnHsRRNxhoz3Lfg65h4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886286;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2vyd4+b0qKsADKSADGGr3aXOxp0V8c6j+Hf4etRu0RY=;
	b=QqW/3nDHVeO4HRmkgZp35EVI6Dlpzhpx4gdIdcgSI7tytMp4JKmtncw024EvthWVNdKk
	 gWGCSZq6vSuQedi0t2QkDtL94XlAAKjZtiC3J07j9wZb3FZCv6V0J3gfum7GveWwMsywF
	 CxY25sMced12OvQIS34UZrYUsSxEeSqGL8OgcQ4yaATTpfyohm4syKLb2QJuOx7tCB6RA
	 3jsRt+lSHi9J/lBHBaqnwKY7nl9eADpWyxUBGWnapU9QUp+HIknEY7jgSbyQp3ND9DF+h
	 mCVHnAndz6Qj9LmhvGbA2CSeh9+MzEv6EGC1UJW5zebDbgfUTDkqfpWIAdqKgRLbK/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lkxdjpwy;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EBF606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15EBF606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lkxdjpwy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793886285; x=1825422285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8rezri/XGgDswkUed4NRpKnlDAfFZbgBdPPXSo+RN0k=;
  b=lkxdjpwy7Ff9GBbfoPzDuasqo2dJwYAHE2wbPc4Yoq0QJgCrE5TR6xyD
   Piz0FXyMsaFq4Ffu5LglUUEwjG9hsHF5Ilq1wb83R5/0ldkFwvGUvPcNM
   gBv6SWUp4xNUcmRckl+KnWT+LlinNe1KFJt1ayfO2QLatAedCRr4+8hLp
   Uc9Fs7aTvHNCNaC47oQ5ClXd3Pe8g0nETb/n0BqALdjqxUCqCotbXM2Cd
   xYF+3ODmkMquWgBdmnkrQx5Fq1J7Zydb/eYPhG8o547bVwMtkfwDds29p
   4iC37x7Wj7tKNIl4eQK+2Mx7zw6DkeZDHWrzg62yqQTFVs6XGnvpEpgrv
   g==;
X-CSE-ConnectionGUID: Iofg60MXS/68cc1S6ImkRg==
X-CSE-MsgGUID: Jpj65lKgQuKsTt5tpit4Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2710252"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2710252"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 05:41:32 -0800
X-CSE-ConnectionGUID: vi3GL3JWT4iKslCbAOxCZg==
X-CSE-MsgGUID: fj8VKUVvSN2XNTuhdzZjoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6874485"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa007.jf.intel.com with ESMTP; 05 Nov 2026 05:41:30 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net-next 4/4] selftests: net: move xdp_hw_metadata from selftests/bpf
Date: Thu,  5 Nov 2026 14:41:17 +0100
Message-Id: <20261105134117.977655-5-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261105134117.977655-1-maciej.fijalkowski@intel.com>
References: <20261105134117.977655-1-maciej.fijalkowski@intel.com>
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

Move xdp_hw_metadata and its XDP program to selftests/net, next to the
AF_XDP library in net/lib/xsk that the tool is built from.

The tool used test_progs and network_helpers only for start_server(),
two checksum helpers and strscpy(). Open the UDP socket with a local
helper, copy csum_tcpudp_magic() and csum_ipv6_magic(), and fill
ifr_name with snprintf(). Build the XDP program against the uapi
headers rather than vmlinux.h: mirror struct vlan_hdr and enum
xdp_rss_hash_type, and cast to void * in the bound checks.

Build the tool only when bpftool works, and install it without running
it, as it needs a NIC and a peer that sends it traffic. Copy
xdp_metadata.h rather than move it, as the xdp_metadata test in
test_progs still uses it. Update xsk-tx-metadata.rst and the XDP entry
of MAINTAINERS.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 Documentation/networking/xsk-tx-metadata.rst  |  2 +-
 MAINTAINERS                                   |  1 +
 tools/testing/selftests/bpf/.gitignore        |  1 -
 tools/testing/selftests/bpf/Makefile          |  8 --
 tools/testing/selftests/net/.gitignore        |  2 +
 tools/testing/selftests/net/Makefile          | 18 +++++
 .../xdp_hw_metadata.bpf.c}                    | 35 +++++---
 .../selftests/{bpf => net}/xdp_hw_metadata.c  | 81 +++++++++++++++++--
 tools/testing/selftests/net/xdp_metadata.h    | 67 +++++++++++++++
 9 files changed, 188 insertions(+), 27 deletions(-)
 rename tools/testing/selftests/{bpf/progs/xdp_hw_metadata.c => net/xdp_hw_metadata.bpf.c} (75%)
 rename tools/testing/selftests/{bpf => net}/xdp_hw_metadata.c (92%)
 create mode 100644 tools/testing/selftests/net/xdp_metadata.h

diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
index f240930ca1df..ac15e5fddc6b 100644
--- a/Documentation/networking/xsk-tx-metadata.rst
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -144,6 +144,6 @@ See ``tools/net/ynl/samples/netdev.c`` on how to query this information.
 Example
 =======
 
-See ``tools/testing/selftests/bpf/xdp_hw_metadata.c`` for an example
+See ``tools/testing/selftests/net/xdp_hw_metadata.c`` for an example
 program that handles TX metadata. Also see https://github.com/fomichev/xskgen
 for a more bare-bones example.
diff --git a/MAINTAINERS b/MAINTAINERS
index 12e444f1f7a6..2123857f3365 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30418,6 +30418,7 @@ F:	net/core/xdp.c
 F:	samples/bpf/xdp*
 F:	tools/testing/selftests/bpf/*/*xdp*
 F:	tools/testing/selftests/bpf/*xdp*
+F:	tools/testing/selftests/net/*xdp*
 K:	(?:\b|_)xdp(?:\b|_)
 
 XDP SOCKETS (AF_XDP)
diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index cd098c0271ef..e318a38035d2 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -38,7 +38,6 @@ test_cpp
 *.tmp
 xdp_redirect_multi
 xdp_synproxy
-xdp_hw_metadata
 xdp_features
 verification_cert.h
 *.BTF
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 203f2cedaf77..2d46e47bab60 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -56,7 +56,6 @@ TEST_GEN_PROGS_EXTENDED = \
 	test_cpp \
 	veristat \
 	xdp_features \
-	xdp_hw_metadata \
 	xdp_synproxy
 
 TEST_GEN_FILES += $(TEST_KMODS) liburandom_read.so urandom_read sign-file uprobe_multi
@@ -568,13 +567,6 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c ../net/lib/xsk/xsk.c network_helpers.c \
-			   $(TOOLSDIR)/lib/find_bit.c xdp_metadata.h \
-			   ../net/lib/xsk/xsk.h network_helpers.h test_progs.h bpf_util.h \
-			   $(OUTPUT)/xdp_hw_metadata.skel.h $(BPFOBJ) | $(OUTPUT)
-	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
-
 $(OUTPUT)/xdp_features: xdp_features.c network_helpers.c xdp_features.h \
 			   network_helpers.h \
 			   test_progs.h bpf_util.h $(OUTPUT)/xdp_features.skel.h \
diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 21412510ac26..0bd88b48a53c 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -60,3 +60,5 @@ udp_splice_checksum
 udpgso
 udpgso_bench_rx
 udpgso_bench_tx
+xdp_hw_metadata
+xdp_hw_metadata.skel.h
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 7dba412401ea..9925360a9a98 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -226,6 +226,15 @@ TEST_GEN_PROGS += $(YNL_GEN_PROGS)
 
 TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
 
+# xdp_hw_metadata needs a working bpftool to generate its skeleton
+BPFTOOL ?= bpftool
+HAS_BPFTOOL := $(shell $(BPFTOOL) version >/dev/null 2>&1 && echo y)
+ifeq ($(HAS_BPFTOOL),y)
+TEST_GEN_FILES += xdp_hw_metadata
+else
+$(warning excluding xdp_hw_metadata, bpftool not installed or not working)
+endif
+
 TEST_INCLUDES := forwarding/lib.sh
 
 include ../lib.mk
@@ -249,3 +258,12 @@ $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
 $(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
 
 include bpf.mk
+
+# Reference tool for checking XDP RX/TX metadata on real HW, built with
+# the AF_XDP library of net/lib/xsk.
+$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c xdp_metadata.h lib/xsk/xsk.c \
+			   lib/xsk/xsk.h $(OUTPUT)/xdp_hw_metadata.skel.h $(BPFOBJ)
+	$(call msg,CC,,$@)
+	$(Q)$(CC) -I$(top_srcdir)/tools/include $(CFLAGS) -I$(OUTPUT) \
+		-I$(SCRATCH_DIR)/include \
+		$(filter %.c,$^) $(BPFOBJ) $(LDLIBS) -lelf -lz -o $@
diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/net/xdp_hw_metadata.bpf.c
similarity index 75%
rename from tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
rename to tools/testing/selftests/net/xdp_hw_metadata.bpf.c
index 330ece2eabdb..a183436646b1 100644
--- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
+++ b/tools/testing/selftests/net/xdp_hw_metadata.bpf.c
@@ -1,10 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <vmlinux.h>
+#include <linux/bpf.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/udp.h>
 #include "xdp_metadata.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+/* Mirror of struct vlan_hdr from include/linux/if_vlan.h, which is not
+ * part of the UAPI headers.
+ */
+struct vlan_hdr {
+	__be16 h_vlan_TCI;
+	__be16 h_vlan_encapsulated_proto;
+};
+
 struct {
 	__uint(type, BPF_MAP_TYPE_XSKMAP);
 	__uint(max_entries, 256);
@@ -39,25 +52,29 @@ int rx(struct xdp_md *ctx)
 	data_end = (void *)(long)ctx->data_end;
 	eth = data;
 
-	if (eth + 1 < data_end && (eth->h_proto == bpf_htons(ETH_P_8021AD) ||
-				   eth->h_proto == bpf_htons(ETH_P_8021Q)))
+	if ((void *)(eth + 1) < data_end &&
+	    (eth->h_proto == bpf_htons(ETH_P_8021AD) ||
+	     eth->h_proto == bpf_htons(ETH_P_8021Q)))
 		eth = (void *)eth + sizeof(struct vlan_hdr);
 
-	if (eth + 1 < data_end && eth->h_proto == bpf_htons(ETH_P_8021Q))
+	if ((void *)(eth + 1) < data_end &&
+	    eth->h_proto == bpf_htons(ETH_P_8021Q))
 		eth = (void *)eth + sizeof(struct vlan_hdr);
 
-	if (eth + 1 < data_end) {
+	if ((void *)(eth + 1) < data_end) {
 		if (eth->h_proto == bpf_htons(ETH_P_IP)) {
 			iph = (void *)(eth + 1);
-			if (iph + 1 < data_end && iph->protocol == IPPROTO_UDP)
+			if ((void *)(iph + 1) < data_end &&
+			    iph->protocol == IPPROTO_UDP)
 				udp = (void *)(iph + 1);
 		}
 		if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
 			ip6h = (void *)(eth + 1);
-			if (ip6h + 1 < data_end && ip6h->nexthdr == IPPROTO_UDP)
+			if ((void *)(ip6h + 1) < data_end &&
+			    ip6h->nexthdr == IPPROTO_UDP)
 				udp = (void *)(ip6h + 1);
 		}
-		if (udp && udp + 1 > data_end)
+		if (udp && (void *)(udp + 1) > data_end)
 			udp = NULL;
 	}
 
@@ -82,7 +99,7 @@ int rx(struct xdp_md *ctx)
 	data_meta = (void *)(long)ctx->data_meta;
 	meta = data_meta;
 
-	if (meta + 1 > data) {
+	if ((void *)(meta + 1) > data) {
 		__sync_add_and_fetch(&pkts_fail, 1);
 		return XDP_PASS;
 	}
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/net/xdp_hw_metadata.c
similarity index 92%
rename from tools/testing/selftests/bpf/xdp_hw_metadata.c
rename to tools/testing/selftests/net/xdp_hw_metadata.c
index ab3f5fc56e86..6db928f1ffdc 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/net/xdp_hw_metadata.c
@@ -16,11 +16,11 @@
  * - TX launch time HW offload is requested for transmission
  */
 
-#include <test_progs.h>
-#include <network_helpers.h>
 #include "xdp_hw_metadata.skel.h"
-#include "xsk.h"
+#include "lib/xsk/xsk.h"
 
+#include <bpf/bpf.h>
+#include <errno.h>
 #include <error.h>
 #include <linux/kernel.h>
 #include <linux/bits.h>
@@ -47,6 +47,9 @@
 #include <linux/ethtool.h>
 #include <sys/socket.h>
 #include <arpa/inet.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <signal.h>
 
 #include "xdp_metadata.h"
 
@@ -87,7 +90,69 @@ int launch_time_queue;
 	system(command);					\
 })
 
-void test__fail(void) { /* for network_helpers.c */ }
+static __u16 csum_fold(__u32 csum)
+{
+	csum = (csum & 0xffff) + (csum >> 16);
+	csum = (csum & 0xffff) + (csum >> 16);
+
+	return (__u16)~csum;
+}
+
+static __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr, __u32 len,
+				 __u8 proto, __wsum csum)
+{
+	__u64 s = csum;
+
+	s += (__u32)saddr;
+	s += (__u32)daddr;
+	s += htons(proto + len);
+	s = (s & 0xffffffff) + (s >> 32);
+	s = (s & 0xffffffff) + (s >> 32);
+
+	return csum_fold((__u32)s);
+}
+
+static __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+			       const struct in6_addr *daddr, __u32 len,
+			       __u8 proto, __wsum csum)
+{
+	__u64 s = csum;
+	int i;
+
+	for (i = 0; i < 4; i++)
+		s += (__u32)saddr->s6_addr32[i];
+	for (i = 0; i < 4; i++)
+		s += (__u32)daddr->s6_addr32[i];
+	s += htons(proto + len);
+	s = (s & 0xffffffff) + (s >> 32);
+	s = (s & 0xffffffff) + (s >> 32);
+
+	return csum_fold((__u32)s);
+}
+
+static int open_udp_server(__u16 port)
+{
+	struct sockaddr_in6 addr = {
+		.sin6_family = AF_INET6,
+		.sin6_port = htons(port),
+		.sin6_addr = IN6ADDR_ANY_INIT,
+	};
+	struct timeval timeo = { .tv_sec = 1 };
+	int fd;
+
+	fd = socket(AF_INET6, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return -1;
+
+	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo)) ||
+	    setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &timeo, sizeof(timeo)) ||
+	    bind(fd, (struct sockaddr *)&addr, sizeof(addr))) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
 
 static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
 {
@@ -550,7 +615,7 @@ static int rxq_num(const char *ifname)
 	struct ifreq ifr = {
 		.ifr_data = (void *)&ch,
 	};
-	strscpy(ifr.ifr_name, ifname);
+	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
 	int fd, ret;
 
 	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
@@ -571,7 +636,7 @@ static void hwtstamp_ioctl(int op, const char *ifname, struct hwtstamp_config *c
 	struct ifreq ifr = {
 		.ifr_data = (void *)cfg,
 	};
-	strscpy(ifr.ifr_name, ifname);
+	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
 	int fd, ret;
 
 	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
@@ -853,9 +918,9 @@ int main(int argc, char *argv[])
 		error(1, -ret, "xdp_hw_metadata__load");
 
 	printf("prepare skb endpoint...\n");
-	server_fd = start_server(AF_INET6, SOCK_DGRAM, NULL, 9092, 1000);
+	server_fd = open_udp_server(9092);
 	if (server_fd < 0)
-		error(1, errno, "start_server");
+		error(1, errno, "open_udp_server");
 	timestamping_enable(server_fd,
 			    SOF_TIMESTAMPING_SOFTWARE |
 			    SOF_TIMESTAMPING_RAW_HARDWARE);
diff --git a/tools/testing/selftests/net/xdp_metadata.h b/tools/testing/selftests/net/xdp_metadata.h
new file mode 100644
index 000000000000..9371889f76d3
--- /dev/null
+++ b/tools/testing/selftests/net/xdp_metadata.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+#ifndef ETH_P_IP
+#define ETH_P_IP 0x0800
+#endif
+
+#ifndef ETH_P_IPV6
+#define ETH_P_IPV6 0x86DD
+#endif
+
+#ifndef ETH_P_8021Q
+#define ETH_P_8021Q 0x8100
+#endif
+
+#ifndef ETH_P_8021AD
+#define ETH_P_8021AD 0x88A8
+#endif
+
+#ifndef BIT
+#define BIT(nr)			(1 << (nr))
+#endif
+
+/* Non-existent checksum status */
+#define XDP_CHECKSUM_MAGIC	BIT(2)
+
+/* Mirror of enum xdp_rss_hash_type from include/net/xdp.h, which is not
+ * part of the UAPI headers.
+ */
+enum xdp_rss_hash_type {
+	XDP_RSS_L3_IPV4		= BIT(0),
+	XDP_RSS_L3_IPV6		= BIT(1),
+	XDP_RSS_L3_DYNHDR	= BIT(2),
+	XDP_RSS_L4		= BIT(3),
+	XDP_RSS_L4_TCP		= BIT(4),
+	XDP_RSS_L4_UDP		= BIT(5),
+	XDP_RSS_L4_SCTP		= BIT(6),
+	XDP_RSS_L4_IPSEC	= BIT(7),
+	XDP_RSS_L4_ICMP		= BIT(8),
+};
+
+enum xdp_meta_field {
+	XDP_META_FIELD_TS	= BIT(0),
+	XDP_META_FIELD_RSS	= BIT(1),
+	XDP_META_FIELD_VLAN_TAG	= BIT(2),
+};
+
+struct xdp_meta {
+	union {
+		__u64 rx_timestamp;
+		__s32 rx_timestamp_err;
+	};
+	__u64 xdp_timestamp;
+	__u32 rx_hash;
+	union {
+		__u32 rx_hash_type;
+		__s32 rx_hash_err;
+	};
+	union {
+		struct {
+			__be16 rx_vlan_proto;
+			__u16 rx_vlan_tci;
+		};
+		__s32 rx_vlan_tag_err;
+	};
+	enum xdp_meta_field hint_valid;
+};
-- 
2.43.0

