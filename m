Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7012E1746
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 03:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854607; cv=none; b=gd8ea9yi/ovrrcnq7f6QNxtDlBajnN7qm2vOP0CjzhwewtXsxTDGsVeG8C84nxlI/xrgtWuM+FzGsefkjGWEnWNJOF976ssoX8YQ1c17BR3PoWUInk2pp6v2WGX4eueZYnV4G93sHCGe9LMn2krmdt2YDiU4F6UnWiIjPbFgSa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854607; c=relaxed/simple;
	bh=1InCZu+kc1AamPHq6yrua+gyD4YzjwNoKmEqQ9wZlDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uwh9oUD8O521NUPCv7CHeKuQUMeGSxbcHhwyi4NDcbu+6SbKHfDq5G1O7JfhEcrvs3dLIUy0SfOjhOyhec7EanTOUAwk0QsVdyzfcXKn2qXHFf59VUPMZjWdPovzx8fZHErQYUWdOEA7AMJafl7iVfeAScL/9xFrTZpHTdNoc+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g94a7Sot; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g94a7Sot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B76EC19423;
	Sat,  7 Mar 2026 03:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772854606;
	bh=1InCZu+kc1AamPHq6yrua+gyD4YzjwNoKmEqQ9wZlDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g94a7SotJwluugQvgDVeFrgbMXDebzKSxBYYI9nGdLB7YeTDgNQPPO5OlNxSBo/3X
	 fjOwKZpHWAVn/om7HwGazJMQuQLKekrA3AyvEOH1JwsAYgvStSwZ4SGs3d73uYAxH0
	 /jEbqkUoqgXypdReQT7RK4c+N8tUZqAcZ3y7qBIBT9ESECUkiWlznNdSoGHIi7N5R/
	 3vbS4LyEKurAbfVg3tcgocEBrIGL5PmwCO9mTXNp/N42dyYCc5imy+YCf6dlOku2G8
	 cQ6r11U7BHboreV/OXd3uPgdAyWM/3dlA/UYOHNp2eDqBJzyeRjqKYljsJrbpcEQTw
	 rCT/6TssVr+OQ==
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
Subject: [PATCH net-next v2 06/10] tools: ynl: add netdevsim wrapper library for YNL tests
Date: Fri,  6 Mar 2026 19:36:26 -0800
Message-ID: <20260307033630.1396085-7-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307033630.1396085-1-kuba@kernel.org>
References: <20260307033630.1396085-1-kuba@kernel.org>
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

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
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

