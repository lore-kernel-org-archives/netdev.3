Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AB438E8C9
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786559888; cv=pass; b=nOuSEpKgYNPjSNyqB4mDCBKGhfkLv5kAGFywwRPWQmdYoQTGP9KGbMnJKyMLWMQjJtGR666XmLS+O9KjW31BXrkvmFH3hQLXo/rlCxijmywTZ/2MVZypBwKdAHB553+fItCxhmMyYTvsjVLCf/7f+2j6UgOTAB84c5AjGlFrOzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786559888; c=relaxed/simple;
	bh=CuJg1l7RtXFZdZwdjBqV9JpfxqmwDYZ79eGA43nf+Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9tq7gLiQ1PxVj1VFlLiAFFQLvrPCeQhqW6I8kSm6BtNRYsDaQstiElRfMpSbMwmGxf3IfCzjYsixtX8FW/NbVvVm7coq16EiMAAyylRrNf789aT3Zt0ptq8crYxOST64nCt6/GlF/VbpsqSqBagPi/hwwQ7EOLCfyzV870yJ54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=Yj3Pj0sz; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="Yj3Pj0sz"
ARC-Seal: i=1; a=rsa-sha256; t=1786559842; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NFxF0EiPLb6C2C5K+WGxhSrMciDM7ibOD+U1m+FcdQsr59cB0LTeXRIulmK2HjbnxlXKTup4rNCXcLeN7YYSxNu7uf5ztiKdujhsWN9AULV9o5UDW8Ip7wIbnUga16wM33KsSVyPfrXfLBUzwkyMC6PqGGp6Y0FwnSgm8i204O4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786559842; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rV01DvtgjRlKAvr917RNjiUABzM1wyVnaD4kxhS6G4g=; 
	b=KeXpYN3Pm979DcawivibzZ5YhTV2HDQxA6244eiJ8tolG+cjIknuA6aH4izYnffFoGbd07KK3QL7o7sFTSuyBE8Uf853WV/XYv96F6Y9eL74Nd0NUx5ImJm/YaWluUMCU+nlO895rFe/lrSGIIW7NRQWwI1cKLOQ0VVUa79pKL0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786559842;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rV01DvtgjRlKAvr917RNjiUABzM1wyVnaD4kxhS6G4g=;
	b=Yj3Pj0szNpSjqGoV0kfN/2tCA+4b7R/ccQO5/cOcmlQC0ImQKgh5eH5uQYAWcTkP
	h3hfuyKqi3tajUu7737taUo85ecButsKc2XYUmroE9eRRSXfM5FRqw/JowtRm0xvkLh
	E5kmASS7yRGOjY+xETaeIpUWoVnrbr9b8uFBReYBr8UuUYFgir5/ipRVdr4r5LZyEFm
	3s3TXLXZdeCd9cLr6JunGJmcnWWDak0zzIBBWe7x/ZuL8gNrqccPQSBLpWvETb6DR57
	B6nJCn7CPxGSYxM7s8eok8JTzKFEbAZ08TRDXBF8y90lYbp0cr00ShBz9dIbLntRtDS
	e0Qi7BBGxA==
Received: by mx.zohomail.com with SMTPS id 1786559838802675.9642172422022;
	Wed, 12 Aug 2026 11:37:18 -0700 (PDT)
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
Subject: [PATCH v8 net-next 3/3] selftests: drivers/net: Implement ptp4l sync test using netdevsim
Date: Wed, 12 Aug 2026 20:37:08 +0200
Message-ID: <20260812183708.312412-4-maciek@machnikowski.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812183708.312412-1-maciek@machnikowski.net>
References: <20260812183708.312412-1-maciek@machnikowski.net>
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
index b6989c7d3d9d..7be30a72e119 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -21,5 +21,6 @@ CONFIG_NET_SCH_INGRESS=y
 CONFIG_NET_SCH_PRIO=m
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

