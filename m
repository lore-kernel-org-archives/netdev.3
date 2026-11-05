Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886285;
	b=f8fuwlG+O9mWRIkODHZ0SO0WJu03h6a9AAdrv5BlqcFBU8e5ldv1GoE9qqQHV6NO51/K
	 2627JziwmEbwBwQSCbEsInTvrQYrVrnrSdgmrW+AKbEkA+HR7JgQVzCD1Nn0en2aOv26C
	 zw4tDTiBxtR42kW1dseHZa5V5JgY5C6eoHd/M1L2VrageiqNMQK8+ltuDE8q6OdcC7YV9
	 m8eh4YXqJRMC4EuYBhPUpgsT4JQb5MjNoQ7nbp5WLwHbhCy30ru+cETAKb9wQ6OSi+q6T
	 nXn1CZkF86YAR3XJBHR563N6YE5mB98NGqjK7Kp3JbelNfuoKw0vnI1xEhDGh8x6eGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886285;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=DlOBeGxzTAgZd6EL9u9PquVu5y4ryas9OocFg7pGGpY=;
	b=MVTyRuGlTm1rduUNGbIOz7O+2Q+WJ5bNyWFilJy+xyh2vR05yDxWaS+g+ODBZ1YrIRAM
	 AV8b1bwvTgtevjU9Xu+O8hrMN0GqJiRHE+O7cW5y+m0DL4sFmmkt6FiFlF+bNd3UvBTIX
	 gh5L5ms2BvNDVg0Zhj7y+TS8+eK9Ly3ayOIeYXO4gFabnLfaedJvBr3fMIDvFYcOW1jn1
	 y8c7fqxQAN5AkUjX36ycD9lxEAv0rAYvZY4ABqBbMK8rvIyqUV52dvnH5egX6VTLjVMCs
	 ZikgZfS2tJtV1Kqo8B9ZPZWa9D6Y/eVi5AAlfdSXjTiSYos58EU7KialU+v23Tgx9Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FB9XhIX4;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC26606A33A
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEC26606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FB9XhIX4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793886283; x=1825422283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ShtOES0wIYMmEUXlK0j8RP4PhK4H/DxYH8vgSziFIw=;
  b=FB9XhIX4JT5ow0MI8LUeGVoR+OXmgkcAQteLQ8hWf+oUHNtwN0xHtkVw
   HeRka70uNvvS6bme/5x6qyJSqnDvVbtVk3bM+jH7m4UbjG3e2Ptqd649l
   7utdzjCK3ZSmz9a4SWQfM8dL2x6aF5TZ1K/GgvTTVz5PNGOy3JVsKJYMv
   hCxtOfSx/5wDV0be7pIdq2hDvbOT322ItlNSFP0ReDVPFZNUaf7eGfKwt
   KfqXnCLuiipo0oez9snMBKjPE04OYQm9f6aOXu2nubo4caPyLcS4s1Bcj
   LDp/TjqFS6Sha4UypVQ4kysxgDUWbwpSIv/R1N6c8TFyTDBE0HmWOuh92
   Q==;
X-CSE-ConnectionGUID: PooYXzg5T96I3EsBDT+hcA==
X-CSE-MsgGUID: Ej4zH3DOQZK1fK/uPKk10Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2710240"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2710240"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 05:41:29 -0800
X-CSE-ConnectionGUID: AuL59QHsTb+lGI8mu53wxg==
X-CSE-MsgGUID: 7XJ6upZkSy2ggS6QmGdiig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6874442"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa007.jf.intel.com with ESMTP; 05 Nov 2026 05:41:28 -0800
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
Subject: [PATCH net-next 3/4] selftests: xsk: move the AF_XDP test suite to selftests/net
Date: Thu,  5 Nov 2026 14:41:16 +0100
Message-Id: <20261105134117.977655-4-maciej.fijalkowski@intel.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the xskxceiver engine, the AF_XDP userspace library, the test
definitions and the XDP program to net/lib/xsk, and test_xsk.sh with
xsk_prereqs.sh to selftests/net.

net/lib builds the XDP program and its skeleton with the bpf.mk rules,
and skips xskxceiver with a warning when bpftool does not work, in
which case test_xsk.sh skips too. List test_xsk.sh in
TEST_PROGS_EXTENDED, so that it is installed but NIPA does not run it
yet: it runs every case, flaky ones included.

xskxceiver builds against the uapi headers from make headers, whose
linux/netlink.h does not pull in linux/kernel.h, so include it for
min_t() directly. Put tools/include ahead of CFLAGS, so that in O=
builds a stale usr/include in the source tree does not shadow its
linux/kernel.h and linux/types.h. Move the ethtool ring helpers from
network_helpers into xsk.c, and cast to void * in the bound check of
the XDP program, as bpf.mk does not build with
-Wno-compare-distinct-pointer-types.

xdp_hw_metadata and the xdp_metadata test keep using xsk.c from
net/lib/xsk: selftests/bpf builds xsk.o from there in place of the
find_bit.o rule, which only test_xsk.c needed. Update MAINTAINERS.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 Documentation/networking/af_xdp.rst           |  6 +--
 MAINTAINERS                                   |  3 +-
 tools/testing/selftests/bpf/.gitignore        |  1 -
 tools/testing/selftests/bpf/Makefile          | 25 +++-------
 .../testing/selftests/bpf/Makefile.buildvars  |  6 +--
 tools/testing/selftests/bpf/network_helpers.c | 48 ------------------
 tools/testing/selftests/bpf/network_helpers.h |  2 -
 tools/testing/selftests/net/Makefile          |  2 +
 tools/testing/selftests/net/config            |  1 +
 tools/testing/selftests/net/lib/.gitignore    |  2 +
 tools/testing/selftests/net/lib/Makefile      | 25 ++++++++++
 .../prog_tests => net/lib/xsk}/test_xsk.c     |  2 +-
 .../prog_tests => net/lib/xsk}/test_xsk.h     |  2 +-
 .../selftests/{bpf => net/lib/xsk}/xsk.c      | 49 ++++++++++++++++++-
 .../selftests/{bpf => net/lib/xsk}/xsk.h      |  4 ++
 .../{bpf => net/lib/xsk}/xsk_xdp_common.h     |  0
 .../lib/xsk/xsk_xdp_progs.bpf.c}              |  2 +-
 .../{bpf => net/lib/xsk}/xskxceiver.c         |  7 +--
 .../{bpf => net/lib/xsk}/xskxceiver.h         |  0
 .../selftests/{bpf => net}/test_xsk.sh        |  5 ++
 .../selftests/{bpf => net}/xsk_prereqs.sh     |  2 +-
 21 files changed, 108 insertions(+), 86 deletions(-)
 rename tools/testing/selftests/{bpf/prog_tests => net/lib/xsk}/test_xsk.c (99%)
 rename tools/testing/selftests/{bpf/prog_tests => net/lib/xsk}/test_xsk.h (99%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk.c (95%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk.h (97%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk_xdp_common.h (100%)
 rename tools/testing/selftests/{bpf/progs/xsk_xdp_progs.c => net/lib/xsk/xsk_xdp_progs.bpf.c} (98%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xskxceiver.c (99%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xskxceiver.h (100%)
 rename tools/testing/selftests/{bpf => net}/test_xsk.sh (98%)
 rename tools/testing/selftests/{bpf => net}/xsk_prereqs.sh (98%)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index cc3f0d16b28f..538e71adb759 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -211,7 +211,7 @@ Libbpf
 
 Libbpf is a helper library for eBPF and XDP that makes using these
 technologies a lot simpler. It also contains specific helper functions
-in tools/testing/selftests/bpf/xsk.h for facilitating the use of
+in tools/testing/selftests/net/lib/xsk/xsk.h for facilitating the use of
 AF_XDP. It contains two types of functions: those that can be used to
 make the setup of AF_XDP socket easier and ones that can be used in the
 data plane to access the rings safely and quickly.
@@ -751,7 +751,7 @@ return values:
      returned number signifies the max number of frags supported.
 
 For an example on how these are used through libbpf, please take a
-look at tools/testing/selftests/bpf/xskxceiver.c.
+look at tools/testing/selftests/net/lib/xsk/xskxceiver.c.
 
 Multi-Buffer Support for Zero-Copy Drivers
 ------------------------------------------
@@ -785,7 +785,7 @@ can be displayed with "-h", as usual.
 This sample application uses libbpf to make the setup and usage of
 AF_XDP simpler. If you want to know how the raw uapi of AF_XDP is
 really used to make something more advanced, take a look at the libbpf
-code in tools/testing/selftests/bpf/xsk.[ch].
+code in tools/testing/selftests/net/lib/xsk/xsk.[ch].
 
 FAQ
 =======
diff --git a/MAINTAINERS b/MAINTAINERS
index 09713dc4c6a7..12e444f1f7a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30434,7 +30434,8 @@ F:	include/net/xsk_buff_pool.h
 F:	include/uapi/linux/if_xdp.h
 F:	include/uapi/linux/xdp_diag.h
 F:	net/xdp/
-F:	tools/testing/selftests/bpf/*xsk*
+F:	tools/testing/selftests/net/*xsk*
+F:	tools/testing/selftests/net/lib/xsk/
 
 XEN BLOCK SUBSYSTEM
 M:	Roger Pau Monné <roger@xenproject.org>
diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index b815bf0d8877..cd098c0271ef 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -36,7 +36,6 @@ test_cpp
 /uprobe_multi
 *.ko
 *.tmp
-xskxceiver
 xdp_redirect_multi
 xdp_synproxy
 xdp_hw_metadata
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c99e0f623e10..203f2cedaf77 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -33,14 +33,13 @@ TEST_GEN_PROGS += test_progs-cpuv4
 TEST_INST_SUBDIRS += cpuv4
 endif
 
-TEST_FILES = xsk_prereqs.sh $(wildcard progs/btf_dump_test_case_*.c)	\
+TEST_FILES = $(wildcard progs/btf_dump_test_case_*.c)	\
 	     bpftool_btf_dump_sorted.expected					\
 	     bpftool_btf_dump_unsorted.expected
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_bpftool_build.sh \
 	test_doc_build.sh \
-	test_xsk.sh \
 	test_xdp_features.sh
 
 TEST_PROGS_EXTENDED := \
@@ -58,8 +57,7 @@ TEST_GEN_PROGS_EXTENDED = \
 	veristat \
 	xdp_features \
 	xdp_hw_metadata \
-	xdp_synproxy \
-	xskxceiver
+	xdp_synproxy
 
 TEST_GEN_FILES += $(TEST_KMODS) liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -257,9 +255,9 @@ $(RUNNER_OBJS): $(VERIFY_SIG_HDR) $(BPFOBJ) $(TRUNNER_BPFTOOL)
 $(OUTPUT)/test_progs.o: prog_tests/tests.h
 $(OUTPUT)/test_maps.o: map_tests/tests.h
 
-# find_bit.c is the only runner source outside this directory, so it
-# needs a rule of its own.
-$(OUTPUT)/find_bit.o: $(TOOLSDIR)/lib/find_bit.c
+# xsk.c is the only runner source outside this directory, so it needs a
+# rule of its own.
+$(OUTPUT)/xsk.o: ../net/lib/xsk/xsk.c
 	$(call msg,CC,,$@)
 	$(Q)$(CC) $(CFLAGS) -c $< $(LDLIBS) -o $@
 
@@ -570,18 +568,9 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-# Keep xskxceiver independent from test_progs object dependencies.
-$(OUTPUT)/xskxceiver: xskxceiver.c xsk.c network_helpers.c \
-			   $(TOOLSDIR)/lib/find_bit.c prog_tests/test_xsk.c \
-			   xskxceiver.h xsk.h network_helpers.h \
-			   prog_tests/test_xsk.h test_progs.h bpf_util.h \
-			   $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
-	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
-
-$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c xsk.c network_helpers.c \
+$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c ../net/lib/xsk/xsk.c network_helpers.c \
 			   $(TOOLSDIR)/lib/find_bit.c xdp_metadata.h \
-			   xsk.h network_helpers.h test_progs.h bpf_util.h \
+			   ../net/lib/xsk/xsk.h network_helpers.h test_progs.h bpf_util.h \
 			   $(OUTPUT)/xdp_hw_metadata.skel.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/testing/selftests/bpf/Makefile.buildvars
index d2a0c0031b87..7e0dc8fa67cd 100644
--- a/tools/testing/selftests/bpf/Makefile.buildvars
+++ b/tools/testing/selftests/bpf/Makefile.buildvars
@@ -74,7 +74,8 @@ COMMON_CFLAGS = -g $(OPT_FLAGS) -rdynamic -std=gnu11				\
 	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(TOOLSARCHINCDIR) -I$(APIDIR) -I$(OUTPUT)	\
-	  -I$(CURDIR)/libarena/include
+	  -I$(CURDIR)/libarena/include					\
+	  -I$(CURDIR)/../net/lib/xsk
 LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
 
 PCAP_CFLAGS	:= $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")
@@ -156,7 +157,6 @@ RUNNER_OBJS-test_progs := $(addprefix $(OUTPUT)/,			\
 	cap_helpers.o unpriv_helpers.o sysctl_helpers.o			\
 	netlink_helpers.o jit_disasm_helpers.o io_helpers.o		\
 	test_loader.o xsk.o disasm.o disasm_helpers.o			\
-	json_writer.o bpftool_helpers.o usdt_1.o usdt_2.o		\
-	find_bit.o)
+	json_writer.o bpftool_helpers.o usdt_1.o usdt_2.o)
 RUNNER_OBJS-test_maps := $(addprefix $(OUTPUT)/,			\
 	test_maps.o testing_helpers.o)
diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index d27dc79475de..70c6e4271ca1 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -646,54 +646,6 @@ int get_socket_local_port(int sock_fd)
 	return -1;
 }
 
-int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
-{
-	struct ifreq ifr = {0};
-	int sockfd, err;
-
-	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
-	if (sockfd < 0)
-		return -errno;
-
-	memcpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
-
-	ring_param->cmd = ETHTOOL_GRINGPARAM;
-	ifr.ifr_data = (char *)ring_param;
-
-	if (ioctl(sockfd, SIOCETHTOOL, &ifr) < 0) {
-		err = errno;
-		close(sockfd);
-		return -err;
-	}
-
-	close(sockfd);
-	return 0;
-}
-
-int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
-{
-	struct ifreq ifr = {0};
-	int sockfd, err;
-
-	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
-	if (sockfd < 0)
-		return -errno;
-
-	memcpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
-
-	ring_param->cmd = ETHTOOL_SRINGPARAM;
-	ifr.ifr_data = (char *)ring_param;
-
-	if (ioctl(sockfd, SIOCETHTOOL, &ifr) < 0) {
-		err = errno;
-		close(sockfd);
-		return -err;
-	}
-
-	close(sockfd);
-	return 0;
-}
-
 struct send_recv_arg {
 	int		fd;
 	uint32_t	bytes;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 878c9fc5c37c..c7a1fd119e37 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -89,8 +89,6 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 		  struct sockaddr_storage *addr, socklen_t *len);
 char *ping_command(int family);
 int get_socket_local_port(int sock_fd);
-int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
-int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 
 int open_tuntap(const char *dev_name, bool need_mac);
 
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 9180b9bec515..7dba412401ea 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -140,6 +140,7 @@ TEST_PROGS := \
 # end of TEST_PROGS
 
 TEST_PROGS_EXTENDED := \
+	test_xsk.sh \
 	xfrm_policy_add_speed.sh \
 # end of TEST_PROGS_EXTENDED
 
@@ -210,6 +211,7 @@ TEST_FILES := \
 	in_netns.sh \
 	lib.sh \
 	settings \
+	xsk_prereqs.sh \
 # end of TEST_FILES
 
 # YNL files, must be before "include ..lib.mk"
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 7a89e2618d4c..162df07f84e1 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -141,5 +141,6 @@ CONFIG_USER_NS=y
 CONFIG_VETH=y
 CONFIG_VLAN_8021Q=y
 CONFIG_VXLAN=m
+CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=m
 CONFIG_XFRM_USER=m
diff --git a/tools/testing/selftests/net/lib/.gitignore b/tools/testing/selftests/net/lib/.gitignore
index 6cd2b762af5d..1106fef3041f 100644
--- a/tools/testing/selftests/net/lib/.gitignore
+++ b/tools/testing/selftests/net/lib/.gitignore
@@ -2,3 +2,5 @@
 csum
 gro
 xdp_helper
+xsk_xdp_progs.skel.h
+xskxceiver
diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index ff83603397d0..0a6cd733883d 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -5,6 +5,15 @@ CFLAGS += -I../../../../../usr/include/ $(KHDR_INCLUDES)
 # Additional include paths needed by kselftest.h
 CFLAGS += -I../../
 
+# xskxceiver needs a working bpftool to generate its skeleton
+BPFTOOL ?= bpftool
+HAS_BPFTOOL := $(shell $(BPFTOOL) version >/dev/null 2>&1 && echo y)
+ifeq ($(HAS_BPFTOOL),y)
+COND_GEN_FILES += xskxceiver
+else
+$(warning excluding xskxceiver, bpftool not installed or not working)
+endif
+
 TEST_FILES := \
 	../../../../net/ynl \
 	../../../../../Documentation/netlink/specs \
@@ -13,6 +22,7 @@ TEST_FILES := \
 
 TEST_GEN_FILES := \
 	$(patsubst %.c,%.o,$(wildcard *.bpf.c)) \
+	$(COND_GEN_FILES) \
 	csum \
 	gro \
 	xdp_helper \
@@ -22,4 +32,19 @@ TEST_INCLUDES := $(wildcard py/*.py sh/*.sh)
 
 include ../../lib.mk
 
+BPF_PROG_DIRS := xsk
 include ../bpf.mk
+
+# AF_XDP test engine used by net/test_xsk.sh.
+XSK_SRCS := $(filter-out %.bpf.c,$(wildcard xsk/*.c)) \
+	$(top_srcdir)/tools/lib/find_bit.c
+
+$(OUTPUT)/xskxceiver: $(XSK_SRCS) $(wildcard xsk/*.h) \
+		      $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ)
+	$(call msg,CC,,$@)
+	$(Q)$(CC) -I$(top_srcdir)/tools/include $(CFLAGS) -I$(OUTPUT) \
+		-I$(SCRATCH_DIR)/include \
+		$(XSK_SRCS) $(BPFOBJ) $(LDLIBS) -lelf -lz -lpthread -o $@
+
+# TEST_GEN_FILES lacks xskxceiver when bpftool fails; clean it anyway.
+EXTRA_CLEAN += $(OUTPUT)/xskxceiver
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
similarity index 99%
rename from tools/testing/selftests/bpf/prog_tests/test_xsk.c
rename to tools/testing/selftests/net/lib/xsk/test_xsk.c
index 4549358cc8c2..ca161511f1e5 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <arpa/inet.h>
 #include <bpf/bpf.h>
 #include <errno.h>
 #include <linux/bitmap.h>
@@ -13,7 +14,6 @@
 #include <sys/time.h>
 #include <unistd.h>
 
-#include "network_helpers.h"
 #include "test_xsk.h"
 #include "xsk_xdp_common.h"
 #include "xsk_xdp_progs.skel.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/net/lib/xsk/test_xsk.h
similarity index 99%
rename from tools/testing/selftests/bpf/prog_tests/test_xsk.h
rename to tools/testing/selftests/net/lib/xsk/test_xsk.h
index 69158b67466c..2506b0dcc6bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/net/lib/xsk/test_xsk.h
@@ -5,7 +5,7 @@
 #include <linux/ethtool.h>
 #include <linux/if_xdp.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 #include "xsk.h"
 
 #ifndef SO_PREFER_BUSY_POLL
diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/net/lib/xsk/xsk.c
similarity index 95%
rename from tools/testing/selftests/bpf/xsk.c
rename to tools/testing/selftests/net/lib/xsk/xsk.c
index 25d568abf0f2..6bd32caf5d08 100644
--- a/tools/testing/selftests/bpf/xsk.c
+++ b/tools/testing/selftests/net/lib/xsk/xsk.c
@@ -35,7 +35,6 @@
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
 #include "xsk.h"
-#include "bpf_util.h"
 
 #ifndef SOL_XDP
  #define SOL_XDP 283
@@ -779,3 +778,51 @@ void xsk_socket__delete(struct xsk_socket *xsk)
 		close(xsk->fd);
 	free(xsk);
 }
+
+int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
+{
+	struct ifreq ifr = {0};
+	int sockfd, err;
+
+	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sockfd < 0)
+		return -errno;
+
+	memcpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
+
+	ring_param->cmd = ETHTOOL_GRINGPARAM;
+	ifr.ifr_data = (char *)ring_param;
+
+	if (ioctl(sockfd, SIOCETHTOOL, &ifr) < 0) {
+		err = errno;
+		close(sockfd);
+		return -err;
+	}
+
+	close(sockfd);
+	return 0;
+}
+
+int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
+{
+	struct ifreq ifr = {0};
+	int sockfd, err;
+
+	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sockfd < 0)
+		return -errno;
+
+	memcpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
+
+	ring_param->cmd = ETHTOOL_SRINGPARAM;
+	ifr.ifr_data = (char *)ring_param;
+
+	if (ioctl(sockfd, SIOCETHTOOL, &ifr) < 0) {
+		err = errno;
+		close(sockfd);
+		return -err;
+	}
+
+	close(sockfd);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/xsk.h b/tools/testing/selftests/net/lib/xsk/xsk.h
similarity index 97%
rename from tools/testing/selftests/bpf/xsk.h
rename to tools/testing/selftests/net/lib/xsk/xsk.h
index 48729da142c2..3f1fea999763 100644
--- a/tools/testing/selftests/bpf/xsk.h
+++ b/tools/testing/selftests/net/lib/xsk/xsk.h
@@ -15,6 +15,7 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <stdbool.h>
+#include <linux/ethtool.h>
 #include <linux/if_xdp.h>
 
 #include <bpf/libbpf.h>
@@ -242,6 +243,9 @@ void xsk_socket__delete(struct xsk_socket *xsk);
 
 int xsk_set_mtu(int ifindex, int mtu);
 
+int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
+int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/testing/selftests/bpf/xsk_xdp_common.h b/tools/testing/selftests/net/lib/xsk/xsk_xdp_common.h
similarity index 100%
rename from tools/testing/selftests/bpf/xsk_xdp_common.h
rename to tools/testing/selftests/net/lib/xsk/xsk_xdp_common.h
diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
similarity index 98%
rename from tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
rename to tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
index 023d8befd4ca..84e5f4732289 100644
--- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
+++ b/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
@@ -64,7 +64,7 @@ SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md *xdp)
 	void *data_end = (void *)(long)xdp->data_end;
 	struct ethhdr *eth = data;
 
-	if (eth + 1 > data_end)
+	if ((void *)(eth + 1) > data_end)
 		return XDP_DROP;
 
 	/* Redirecting packets based on the destination MAC address */
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
similarity index 99%
rename from tools/testing/selftests/bpf/xskxceiver.c
rename to tools/testing/selftests/net/lib/xsk/xskxceiver.c
index 6cf95a44c8c0..0a63651434a5 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
@@ -81,6 +81,7 @@
 #include <linux/netdev.h>
 #include <linux/ethtool.h>
 #include <linux/align.h>
+#include <linux/kernel.h>
 #include <arpa/inet.h>
 #include <net/if.h>
 #include <locale.h>
@@ -91,7 +92,7 @@
 #include <sys/mman.h>
 #include <sys/types.h>
 
-#include "prog_tests/test_xsk.h"
+#include "test_xsk.h"
 #include "xsk_xdp_progs.skel.h"
 #include "xsk.h"
 #include "xskxceiver.h"
@@ -100,14 +101,10 @@
 #include "kselftest.h"
 #include "xsk_xdp_common.h"
 
-#include <network_helpers.h>
-
 static bool opt_print_tests;
 static enum test_mode opt_mode = TEST_MODE_ALL;
 static u32 opt_run_test = RUN_ALL_TESTS;
 
-void test__fail(void) { /* for network_helpers.c */ }
-
 static void __exit_with_error(int error, const char *file, const char *func, int line)
 {
 	ksft_test_result_fail("[%s:%s:%i]: ERROR: %d/\"%s\"\n", file, func, line,
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/net/lib/xsk/xskxceiver.h
similarity index 100%
rename from tools/testing/selftests/bpf/xskxceiver.h
rename to tools/testing/selftests/net/lib/xsk/xskxceiver.h
diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/net/test_xsk.sh
similarity index 98%
rename from tools/testing/selftests/bpf/test_xsk.sh
rename to tools/testing/selftests/net/test_xsk.sh
index 62db060298a4..448cd2462278 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/net/test_xsk.sh
@@ -103,6 +103,11 @@ do
 	esac
 done
 
+if [ ! -x "./${XSKOBJ}" ]; then
+	echo "xskxceiver was not built; skipping"
+	exit $ksft_skip
+fi
+
 TEST_NAME="PREREQUISITES"
 
 URANDOM=/dev/urandom
diff --git a/tools/testing/selftests/bpf/xsk_prereqs.sh b/tools/testing/selftests/net/xsk_prereqs.sh
similarity index 98%
rename from tools/testing/selftests/bpf/xsk_prereqs.sh
rename to tools/testing/selftests/net/xsk_prereqs.sh
index 47c7b8064f38..d8fe786e967c 100755
--- a/tools/testing/selftests/bpf/xsk_prereqs.sh
+++ b/tools/testing/selftests/net/xsk_prereqs.sh
@@ -8,7 +8,7 @@ ksft_xfail=2
 ksft_xpass=3
 ksft_skip=4
 
-XSKOBJ=xskxceiver
+XSKOBJ=lib/xskxceiver
 
 validate_root_exec()
 {
-- 
2.43.0

