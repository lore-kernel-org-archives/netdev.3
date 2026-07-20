Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8172A429CDA
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571280; cv=pass; b=uYp255v7t2GYLucGq3tRSoiJekIrYBMQvlbQ5ORO9fDseEd/GStusCD57DdhMQFZrRCaVHxdfqQjHBOxsQ+8L7n5c7Z0OiKZsmUDBDnneTzIM4BHUI8SktBpxC6jSp4MVBUChkzqTP85orH9GCOWmU0N2/hxiflzbDaHlWAMXC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571280; c=relaxed/simple;
	bh=aZpwC5avhtHgnbMM2PBavtQZwp5eTXh3J/d+PNbMMOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQkV9Zr+r2V5OTw2PHFAQqKIjcCF1nYs6mtZVSN0I7+BqrTepYCAgjj+1seRMsWO0oRo8kPNBId57r5KnV68aAYV5nR9ys19NxeJgu17PIN7wdNyy0jjTX0ExiU8OsDX2+3byBzXvO1q04bR76CGN257/VZIBF6ezhIufN7ck+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=nCqlF+ls; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="nCqlF+ls"
ARC-Seal: i=1; a=rsa-sha256; t=1784571238; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UWfDU5liAzzA7Nupiib+cA+mgaNpBEqIDwQ+CCJdcmdL6VO3UJ4uPawqZ0idayH5++bz4ZyGDwWppSI9w5u7X0M8zbbmtqTkb5LxLS2J3FPiFKKKqgFGijy/OwkfEOrq0pKruX7Jn9QT3yOMrVoaW5b2R4GJ0j/CzzP2rI+S6HA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784571238; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VAltHOMihHz/sjB5W5iD5kC7zcCB1EdYIwg6g9387/8=; 
	b=bPKTlka4TL7EquQmuaABowvyFvqa2qGKfLNgWeIiqVetReSGCN/j0dlWI/uFE9A3lzO3a8O5c6nN+i6vwleUehzoSyonEwo6LTKRee99uC0blCb8TrBDgWbouILRYhAZekiqzKwlZUXJ1u+JJ8p9dYkXGoLb14DZXrBziP6FPBU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784571238;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VAltHOMihHz/sjB5W5iD5kC7zcCB1EdYIwg6g9387/8=;
	b=nCqlF+lspaPCguZ0b9IocvHO32LiGi80RKkwPrzJnmuRKhwvd8c3ElF8CY3kBfSc
	kMKYsIXT3tnnphSpMevh8G9E5jRVoYWOCjIrPcTCtuOT1Ml7+eaexGfxnxM/fkrON3/
	jBqYPeYEZQf7odHhvxQejL0w+ngwgfw/2iu+HuB00U2D4+u7YNZevtFCERKMCc1ukT7
	L7m0OBAnrXzRNi2e2PgWa4kuBjaRT/zPd4IAP978LuVlzg4potU1uhpxRWg26P09FXu
	hGe0yaElbShWm/FG0uy6MSfJI9dPysV53MWnR/7bSapWT5oBQaoveRpZhpPL+aKRsOR
	oGyxrBHOSw==
Received: by mx.zohomail.com with SMTPS id 1784571235627362.0509920093334;
	Mon, 20 Jul 2026 11:13:55 -0700 (PDT)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev,
	horms@kernel.org
Subject: [PATCH v7 net-next 3/3] selftests: drivers/net: Implement ptp4l sync test using netdevsim
Date: Mon, 20 Jul 2026 20:11:13 +0200
Message-ID: <20260720181113.3293-4-maciek@machnikowski.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720181113.3293-1-maciek@machnikowski.net>
References: <20260720181113.3293-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add PTP synchronization test using ptp4l and netdevsim.
The test uses the NetDrvEpEnv to link a local netdevsim
device to a remote endpoint, runs ptp4l as leader and follower
on the two ends, and waits for the follower to report the
synchronized state (s2).

Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 tools/testing/selftests/drivers/net/Makefile |  1 +
 tools/testing/selftests/drivers/net/config   |  1 +
 tools/testing/selftests/drivers/net/ptp.py   | 82 ++++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/ptp.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index d5bf4cb638a8..18bb7c693b69 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -19,6 +19,7 @@ TEST_PROGS := \
 	netpoll_basic.py \
 	ping.py \
 	psp.py \
+	ptp.py \
 	queues.py \
 	ring_reconfig.py \
 	shaper.py \
diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index 91d4fd410914..df28da831a7b 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -13,5 +13,6 @@ CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_FQ=m
 CONFIG_PPP=y
 CONFIG_PPPOE=y
+CONFIG_PTP_1588_CLOCK_MOCK=y
 CONFIG_VLAN_8021Q=m
 CONFIG_XDP_SOCKETS=y
diff --git a/tools/testing/selftests/drivers/net/ptp.py b/tools/testing/selftests/drivers/net/ptp.py
new file mode 100755
index 000000000000..92a943dcbb06
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/ptp.py
@@ -0,0 +1,82 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# By Maciek Machnikowski <maciek@machnikowski.net> (c) 2026,
+
+"""
+Test suite for PTP sync using ptp4l.
+
+Start a ptp4l leader and follower and check that the follower locks onto the
+leader (state s2)
+"""
+
+import time
+
+from lib.py import (
+    NetDrvEpEnv,
+    bkg,
+    fd_read_timeout,
+    ksft_exit,
+    ksft_pr,
+    ksft_run,
+    ksft_true,
+)
+
+PTP4L_SYNC_TIMEOUT = 40
+
+
+def _poll_follower_sync(follower, timeout):
+    """Read the follower stdout pipe until ptp4l reports sync state s2.
+
+    Returns a tuple (synced, output) where output is the text read so far.
+    """
+    fd_file = follower.proc.stdout
+    fd = fd_file.fileno()
+    buf = b""
+    deadline = time.monotonic() + timeout
+    while time.monotonic() < deadline:
+        if b" s2 " in buf:
+            break
+        if follower.proc.poll() is not None:
+            chunk = fd_file.read()
+            if chunk:
+                buf += chunk
+            break
+        try:
+            remaining = deadline - time.monotonic()
+            buf += fd_read_timeout(fd, min(1, remaining))
+        except TimeoutError:
+            continue
+    return b" s2 " in buf, buf.decode("utf-8", "replace")
+
+
+def ptp_sync_test(cfg):
+    """Verify ptp4l leader/follower synchronization reaches state s2."""
+    cfg.require_cmd("ptp4l", remote=True)
+
+    leader_cmd = f"ptp4l -i {cfg.remote_ifname} -m -2"
+    follower_cmd = f"ptp4l -i {cfg.ifname} -m -s -2"
+
+    with bkg(leader_cmd, host=cfg.remote), \
+         bkg(follower_cmd) as follower:
+        synced, output = _poll_follower_sync(follower, PTP4L_SYNC_TIMEOUT)
+
+    if synced:
+        return
+
+    ksft_pr(f"ptp4l follower did not reach locked state (s2) within "
+            f"{PTP4L_SYNC_TIMEOUT}s")
+    tail = output.strip().split("\n")[-10:]
+    ksft_pr("Follower log (last 10 lines): " + " | ".join(tail))
+    ksft_true(False, "PTP sync timeout")
+
+
+def main():
+    """Run ksft tests."""
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run([ptp_sync_test], args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.55.0

