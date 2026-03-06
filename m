Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA51E0DE8
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 02:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762964; cv=none; b=ie2c2AWpJoi9yrxA37O5pzvn2U4/HjstaJCQuENjlTVG++7YTnfATEBXNOIIORG8GpXuI3VyyWMg1z1iY4OFIgOAx3HTjRM0Lx/Vjrmfp8pLxaSuEPVB/6rUwRdkHfKykDpzrpkPx7FhU+kCf6weWgeRGzvGloR4ymZrH0Z9vnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762964; c=relaxed/simple;
	bh=i6KUEBKrDj2yL6CljyajpmvFtlmgMT6hKU5ncdj1Sog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBIDoNzizoN7Rg+9ZkIjsdrP8K3wUUJGvfhVocQKHAGQfTSZw5WST6PcFy6sp8qOC7iXyGRHAYmhW5CrFLa4p2iYhvxzPgR8nKMnK9vlZF0a1v3Wm0fzkuFKCNihYEzBEfUtjIxzG47vUTQyf63FUEKX0DebJoEED4CrVD5UmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COQjmoVF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COQjmoVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA22C2BC9E;
	Fri,  6 Mar 2026 02:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772762964;
	bh=i6KUEBKrDj2yL6CljyajpmvFtlmgMT6hKU5ncdj1Sog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=COQjmoVFizMspCM+FcIt4jGa2xcOK/mVs29N54smGFruNaBk9dmfu1N0clpD5vN7g
	 1QFmjLInS4PHFe5KzOiK+8u1gNFLPH+TOPdkeNvj8O2taDZ47Sx4XNQr8FNLxQ6UKS
	 s32+76hn/kc2TnI4axFbgkOOVGWXWDFxwOfuht+cew8qDhLKmpdIImfgnrDuwwgU2+
	 qkaCpomdOrC84u5VE05hetO2mWzFEWCYTCiqhFqPsFk6bPXpGJCMrYzc7PR/HB4FsV
	 ONtMMrzmlrDd5bmjzOWwsviKctTAnIhspePfzZUe7hvTWL9/yDUS5lMAMk7CsSXkds
	 Sh2Ldw5VEPzYg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	liuhangbin@gmail.com,
	matttbe@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 06/10] tools: ynl: add netdevsim wrapper library for YNL tests
Date: Thu,  5 Mar 2026 18:08:57 -0800
Message-ID: <20260306020901.524105-7-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306020901.524105-1-kuba@kernel.org>
References: <20260306020901.524105-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some tests need netdevsim setup which is painful to do from C.

Add ynl_nsim_lib.sh, a shared library providing nsim_setup and
nsim_cleanup functions for tests that need a netdevsim device.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/tests/Makefile        |  5 +++++
 tools/net/ynl/tests/ynl_nsim_lib.sh | 35 +++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 tools/net/ynl/tests/ynl_nsim_lib.sh

diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
index 524092a8de7e..a329de031add 100644
--- a/tools/net/ynl/tests/Makefile
+++ b/tools/net/ynl/tests/Makefile
@@ -32,6 +32,8 @@ BINS := \
 	rt-route \
 # end of BINS
 
+TEST_FILES := ynl_nsim_lib.sh
+
 CFLAGS_netdev:=$(CFLAGS_netdev) $(CFLAGS_rt-link)
 CFLAGS_ovs:=$(CFLAGS_ovs_datapath)
 
@@ -68,6 +70,9 @@ install: $(TEST_GEN_PROGS) $(BINS)
 		    $$test > $(INSTALL_PATH)/ynl/$$name; \
 		chmod +x $(INSTALL_PATH)/ynl/$$name; \
 	done
+	@for file in $(TEST_FILES); do \
+		cp $$file $(INSTALL_PATH)/ynl/$$file; \
+	done
 	@for bin in $(TEST_GEN_PROGS) $(BINS); do \
 		cp $$bin $(INSTALL_PATH)/ynl/$$bin; \
 	done
diff --git a/tools/net/ynl/tests/ynl_nsim_lib.sh b/tools/net/ynl/tests/ynl_nsim_lib.sh
new file mode 100644
index 000000000000..98cdce44a69c
--- /dev/null
+++ b/tools/net/ynl/tests/ynl_nsim_lib.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Shared netdevsim setup/cleanup for YNL C test wrappers
+
+NSIM_ID="1337"
+NSIM_DEV=""
+KSFT_SKIP=4
+
+nsim_cleanup() {
+	echo "$NSIM_ID" > /sys/bus/netdevsim/del_device 2>/dev/null || true
+}
+
+nsim_setup() {
+	modprobe netdevsim 2>/dev/null
+	if ! [ -f /sys/bus/netdevsim/new_device ]; then
+		echo "netdevsim module not available, skipping" >&2
+		exit "$KSFT_SKIP"
+	fi
+
+	trap nsim_cleanup EXIT
+
+	echo "$NSIM_ID 1" > /sys/bus/netdevsim/new_device
+	udevadm settle
+
+	NSIM_DEV=$(ls /sys/bus/netdevsim/devices/netdevsim${NSIM_ID}/net 2>/dev/null | head -1)
+	if [ -z "$NSIM_DEV" ]; then
+		echo "failed to find netdevsim device" >&2
+		exit 1
+	fi
+
+	ip link set dev "$NSIM_DEV" name nsim0
+	ip link set dev nsim0 up
+	ip addr add 192.168.1.1/24 dev nsim0
+	ip addr add 2001:db8::1/64 dev nsim0 nodad
+}
-- 
2.53.0

