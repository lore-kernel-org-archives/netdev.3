Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993523E8685
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786659685; cv=pass; b=iAjBehLJoZqd6YTmcGGm+DDm6ojYE19121X2mpgehsDTqBJ4WmzlB/J/nh2yslHPpxrCtD0IWW7ejD95ZG69BSAIMVtzTKfrM63bPVZCr/hiPCufQS1Qh6yNAJ49xCsQOH2lzWcupLDS1d32pApXvrX668GzH7A6lSi93x+GxmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786659685; c=relaxed/simple;
	bh=JZxxV+sttVLVKkTjRCWJtGSLltG1nriJdWGoPs6sLDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7Zxaf3XAmKcwhEtJbHZmH79wiQFRQkQEuZVsgjyOP8KmJGG6tqF+MYHKzfYZJARt3OdpOjuKXanZBG4w/V5D+jK5TFQIxO4/UU22fy7w3Wo+4cUTydLkJHQu8+W0jpICXKx/soLff9V90jJxApVi8DXTPea7z/xylIqynziiv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=a/hukZcC; arc=pass smtp.client-ip=165.173.182.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="a/hukZcC"
ARC-Seal: i=1; a=rsa-sha256; t=1786659637; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nPZ7gokMmfley75/X0w7imp0/8TNHPZSm7b+IvI/R/IOOtsIwRk91HSn9iDcqHKPl5n5z5pk0FEUmZ2xBG3diZsv1r/TI09SgmlVDeVaR9n6Nho/iCAfSPebMR8ErvwxF165Od/iXhCwSrAsoC5RKArMyqmM3WZJH3kCT/6DpmY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786659637; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dcPQlaisPKUT/laURq5jklWbnDY8vId+pgQgNCuFyKA=; 
	b=l5kJAQxFG/mEnr11P9hu8aOx1meQssB0adxd/MT+5xoUfX0vRygKv4BElgxslq3sckvhvMK+T4BPgt388HrLaUBXdDbLfPYwYM+Q/AjXsV+cR6v5fXtl/XCUhXcmeyQzGq9eSY4hH8bfaDen+9YtaFdv27bWwLkWkjjKvIPr+WM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786659637;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=dcPQlaisPKUT/laURq5jklWbnDY8vId+pgQgNCuFyKA=;
	b=a/hukZcCx9+GqmlmAd5jnkIbGcapGhiF12rg+jp6odHSjFtbugqJqxGDtf9r0/T+
	a8CXqYySEhDvCKMH/yl2VVEj/p8CRCqUuh7xqU7lBzirkYpAhqhSH9RfQFZVINhOiaK
	HWNVOpf8j5NWjvTkGRyqiN47qCSXEsbyR9t6ONf0fP44ZqxK00eOeY6wfoiYqiNyNV+
	QafJu2+YTRZ4ppHZ8qW5fX42XWNLq+50IMbp++q9Y+tH3sst7PDCFw6XW5TrcVdE99B
	HUH16QM1MJv0P6NSGEXjIOwhKb8J4fxxNxp1ULTUoM+SUBAbgs6bDRo5QbT7OoSs9pg
	tj+ttNwoFQ==
Received: by mx.zohomail.com with SMTPS id 1786659633814724.6911001050515;
	Thu, 13 Aug 2026 15:20:33 -0700 (PDT)
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
Subject: [PATCH v9 net-next 3/3] selftests: drivers/net: Implement ptp4l sync test using netdevsim
Date: Fri, 14 Aug 2026 00:20:23 +0200
Message-ID: <20260813222023.2460-4-maciek@machnikowski.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813222023.2460-1-maciek@machnikowski.net>
References: <20260813222023.2460-1-maciek@machnikowski.net>
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
 tools/testing/selftests/drivers/net/ptp.py   | 84 ++++++++++++++++++++
 3 files changed, 86 insertions(+)
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
index 000000000000..57ea77659b11
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/ptp.py
@@ -0,0 +1,84 @@
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
+    The synchronized ptp4l log line looks like this:
+    ptp4l[18374.558]: master offset        844 s2 freq    +822 path delay       521
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
+            buf += fd_read_timeout(fd, max(0, min(1, remaining)))
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

