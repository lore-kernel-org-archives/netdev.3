Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886282;
	b=Yhfq8iH1kMJyAkem5KMNCgVHAY85fRZhm0B+FeHdoGqr9MnjTtImtn1++a0AM4t0NrQG
	 BAdDnVf/6HE/R5nYA5Z1Lu5mjNigo9YFPQaJKaoccIBHUFVfoybcupwsGKuOgaJ+EUq+f
	 +auEeSZNy7qeNn6yiS1R0BPyVpju5bQ7rCZTA2ehFY1omxgoLcSWP3RLGj/FFBvu/iRPd
	 CfUNKpopx80Zz0BaWjz1Z4jtkU3jfu5FpqLyX6pPHpleYmidu+j4NnuUqjTXtWk4p8t0b
	 7XjfpW6zuhEJ01fIJ7ajKN42TpCP7IEg5BrytFnLbUbNPxKmFmu8cBSb5WqycFohZkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886282;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4vtXlAt7qstwRwqrYeOp+M/pgAyMVQl2qRNVKHKbYO0=;
	b=O+UnWFsPiKBk9IusMOtgF+ZElWgxhjfcDaLppwUlxTlUdHhbT+be6dA56/5RRgeD9Nmy
	 6OnFtDzAVv7SugeqBMlFwIewRXzbqfV1eR02xZb4rpU8nc13TLpzKcpjtADzMQE/Y1BML
	 epovkGFDUKqoHH/I921egDqCbTBg/3QsT611ljZxjh2E8/ughMU0qrV90VHmvIfq10vjr
	 4bbpZH/aA3twFMzHywzapGpQvKCWivku7fpCBo8bFllWjm1xyeBCzu/N0z3vgZrNsYhoi
	 LCVBodUk+KVoOI/u4wdyUCcc6zjp0X/aEUuSTGa/YWrxCmfheVE+ezqr5VMY4X93wFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iBP+0utY;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25367606A333
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25367606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iBP+0utY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793886282; x=1825422282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0P/Pe7JKKBGe5Dtx94SEf1j0etq8IhhZaVIDP1YwKzU=;
  b=iBP+0utYOotlrzHd68JqI54hPqu6pvRs6+hLB9cinWqgebx4Nt2VYv5Q
   MS4d3KL+3nepRbwpND7r40q24/nyXhINCOfCO/SJxkdRJNOGeSqQzUU4u
   KGhYOKA7vilwkNJdZmCps+R3jtEyxPHAZKiTprhrGMq3+tUe1IvQATlrl
   PnfspX05V+uElkr5m3utAC8ENnh4LJbYR5ZNTpup9+n3F6zD+4uSJ8zVV
   MeE1kuGw3UZACXA2dDP9G6CbrAJKE496epaRI+C0qfGBCRMbnngeivy3Y
   9cxTKI6vzQ5Cf89KsRGXqArVEtRBmNNXs49T3b4aLWMhLarcUlYAKIzKd
   Q==;
X-CSE-ConnectionGUID: 5TW8iHL6QvyFvLNNNB8z+A==
X-CSE-MsgGUID: xXQYQmg6RcCQbQScMNumMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2710217"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2710217"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 05:41:26 -0800
X-CSE-ConnectionGUID: PtJFGf4lRY289xV/TJd8cA==
X-CSE-MsgGUID: uFYqTdRlR86p23AY5P50HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6874405"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa007.jf.intel.com with ESMTP; 05 Nov 2026 05:41:25 -0800
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
Subject: [PATCH net-next 2/4] selftests: net: add a generic rule for BPF skeletons
Date: Thu,  5 Nov 2026 14:41:15 +0100
Message-Id: <20261105134117.977655-3-maciej.fijalkowski@intel.com>
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

Tests that load their BPF program through a bpftool skeleton have to
bring their own rule for the header. Add a pattern rule to bpf.mk that
generates $(OUTPUT)/<name>.skel.h from $(OUTPUT)/<name>.bpf.o with
$(BPFTOOL), the bpftool in PATH by default, and removes the partial
header if bpftool fails.

Also build the programs in the subdirectories listed in BPF_PROG_DIRS,
and have make clean remove all program objects and their skeletons.

xskxceiver, which moves to net/lib/xsk in the next patch, is the first
user of both.

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

