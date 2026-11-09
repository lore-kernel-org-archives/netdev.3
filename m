Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252661;
	b=oKdMj1Z2ZiUfNZj+jPT4LJKxqQ6LZUwaGdJJJT2D/JwKXUuzt9UCSgMou7pC9WKiMaTv
	 8Vfe1hDtc4Tp4Fu/k/u+gWq6g9vcLGnsI0Lp7039CrBI+2IzZeqQUyyMAtv9JGE7NX9gA
	 JmcSnn4B7rSFikBg/NBCMve4mQgy133Bq3i51b2Bij+OQWnIiWsa4dxTItacXtfNn18nB
	 c5r8ylHkSExee9i3+94Yx6GEBpf42KVnUN6Dh/QltQxIqOMdv+MaXEmGRgiHX3+Rx8UWH
	 vRDwvn4jYzML6Hm6ybBxIoGYy9spsMSmtxXGhvfKbkAQFeTginXaDLD44T14phzo8Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252661;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jBSfny3oo4PtsTfj4Ic3CcBo5HomQrZlQUjPqT9e5uw=;
	b=Fto0K5I8jm4iKJx6CVfuoQbyMsXsnWaid8LI+EKEqUtojm7COhqAnscMnEjeKKDoBk9v
	 8jYJHb5vX1imYNedJETvqBMYSLsLYnen3h6Itc91iu+Vwj7OAhGPC0fJWvUcY8XWLopYg
	 A7JIHjfNcZveKY1Q5fLmZJMYsi8P8fuN+OnTzQje+4WFJxgnZZw/+7ymfVabo2mNkS/cx
	 9s3e9xHrgLrfv4ZSfo9D810mM5iqI7CevuW9cZ0zXP9ajQ3SoZ9ks9EmjKspEU5s97zd+
	 HRJ+mP2oo5ACAg4eYdfwf08tUtRdBTE/M/5Ul2OsMoBTot7f5XUYl6qcsaLNWwu4ANA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nz7p9EiL;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D63606A32A
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 19:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87D63606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nz7p9EiL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794252660; x=1825788660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b74HnjQkAGXPdGJTm37j+ZdMhMTQMDIGaEyX3awN+5w=;
  b=nz7p9EiL85WFej+kLuzi5szbF4ChzXmwpYcNHXcE3114B89KqlvHEtGs
   4Ksxpc7pD36pK/V/+8zoamdM5S/8B+KTCGG/b6AyQIs+m5A4B0xoIgsEx
   A1y6jwE/mSUfsaThyYwO50axgBMTp6Jcf+2awdH+80YiDOv0SBpynMhY0
   bIEpnpne5hyXugsea4dbrguiCZtO3WNpvwo742BTnQw+gEM2EJRREcy80
   tCk8PyqlbM7RDT6ATjercaOn38Kqvau1or0ayRSJQKaqfDQWg5R6eyxVc
   pvNGxr3lUdkQT7szTC8pWEIqTqsQsP7sRZZsp4jlQ+vm2FUEGhyp5wqaF
   g==;
X-CSE-ConnectionGUID: FpJkkapbRSS8lRyGcCiuiQ==
X-CSE-MsgGUID: sAVJtJrzQSa0fsoyi5eB7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3021041"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3021041"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:31:00 -0800
X-CSE-ConnectionGUID: 6CybG1vDToKV8qA6DOPKyg==
X-CSE-MsgGUID: b3NzyAuPTVqyPkI+bv7LJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9807989"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa013.fm.intel.com with ESMTP; 09 Nov 2026 11:30:58 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH v2 net-next 2/4] selftests: net: add a generic rule for BPF skeletons
Date: Mon,  9 Nov 2026 20:30:46 +0100
Message-Id: <20261109193048.1006986-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261109193048.1006986-1-maciej.fijalkowski@intel.com>
References: <20261109193048.1006986-1-maciej.fijalkowski@intel.com>
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

Tests that load their BPF program through a bpftool skeleton have to
bring their own rule for the header. Add a pattern rule to bpf.mk that
generates $(OUTPUT)/<name>.skel.h from $(OUTPUT)/<name>.bpf.o with
$(BPFTOOL), the bpftool in PATH by default, and removes the partial
header if bpftool fails.

Also build the programs in the subdirectories listed in BPF_PROG_DIRS,
and have make clean remove all program objects and their skeletons.

xskxceiver, which moves to net/lib/xsk in the next patch, is the first
user of both.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/net/bpf.mk | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/bpf.mk b/tools/testing/selftests/net/bpf.mk
index a4f6755dd894..e0e10cf44af3 100644
--- a/tools/testing/selftests/net/bpf.mk
+++ b/tools/testing/selftests/net/bpf.mk
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Rules to generate bpf objs
 CLANG ?= clang
+BPFTOOL ?= bpftool
 SCRATCH_DIR := $(OUTPUT)/tools
 BUILD_DIR := $(SCRATCH_DIR)/build
 BPFDIR := $(top_srcdir)/tools/lib/bpf
@@ -35,13 +36,21 @@ endif
 
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
 
-BPF_PROG_OBJS := $(patsubst %.c,$(OUTPUT)/%.o,$(wildcard *.bpf.c))
+# Programs come from *.bpf.c here and in the subdirectories in BPF_PROG_DIRS.
+BPF_PROG_SRCS := $(wildcard *.bpf.c $(addsuffix /*.bpf.c,$(BPF_PROG_DIRS)))
+BPF_PROG_OBJS := $(patsubst %.c,$(OUTPUT)/%.o,$(notdir $(BPF_PROG_SRCS)))
+vpath %.bpf.c $(BPF_PROG_DIRS)
 
 $(BPF_PROG_OBJS): $(OUTPUT)/%.o : %.c $(BPFOBJ) | $(MAKE_DIRS)
 	$(call msg,BPF_PROG,,$@)
 	$(Q)$(CLANG) -O2 -g --target=bpf $(CCINCLUDE) $(CLANG_SYS_INCLUDES) \
 	-c $< -o $@
 
+$(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o
+	$(call msg,GEN-SKEL,,$@)
+	$(Q)$(BPFTOOL) gen skeleton $< name $(notdir $*) > $@ || \
+		{ rm -f $@; exit 1; }
+
 $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 	   $(APIDIR)/linux/bpf.h					       \
 	   | $(BUILD_DIR)/libbpf
@@ -50,4 +59,4 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 		    EXTRA_CFLAGS='-g -O0'				       \
 		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
 
-EXTRA_CLEAN += $(SCRATCH_DIR)
+EXTRA_CLEAN += $(SCRATCH_DIR) $(BPF_PROG_OBJS) $(BPF_PROG_OBJS:.bpf.o=.skel.h)
-- 
2.43.0

