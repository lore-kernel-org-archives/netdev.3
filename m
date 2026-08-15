Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D872380FF4
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786775559; cv=pass; b=jVRSoMtmodL2HsBjdDEMq0HRR9hM0ejaY7vatocRPDLMdOsAHGrhq7topm3BEDgXW7DpEt2Cdb2blJZ3hcbDYuLD9O1qISAIVM2Vwnd28cnCsT5hWNnVjNqOHFHye3T7tYfd/Id3uYP8VCJtct7vhFBIi1cC3CO6y+mzZqnfsOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786775559; c=relaxed/simple;
	bh=JZxxV+sttVLVKkTjRCWJtGSLltG1nriJdWGoPs6sLDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4Vt4ot/sMIAELvgx76VCKk1dn6cWMxhSV//BYY7xzWFzzmBtzXWdMBRhalJor3o6aGVxScAVvX1/1yRJFFMiajj5uv++xCce5j2ocCTCT9ghShLss9zGEbZg0Z+PuALwrEQaqXIP1cDTDhvftDR4DN7t+m5itGPHz42OSbZMjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=CMfwzz6d; arc=pass smtp.client-ip=165.173.180.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="CMfwzz6d"
ARC-Seal: i=1; a=rsa-sha256; t=1786775523; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OuTnDP8fMU2j6GgsnmwzSwrLXFtvzNHHBOUqlHsjKHKBvFfFLsfzMd/05TdhvhiieOUat59CNeHyK/ftM4Ai1s7YXKH21+Eo2pralMk8SfN3SAK2BvG47M/ut4csHerYHDQGvWUP6h2BH8L5UrVQVfeIxGFvEj9YlZhb8sIXiDo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786775523; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dcPQlaisPKUT/laURq5jklWbnDY8vId+pgQgNCuFyKA=; 
	b=knFBtNMVXObT42o5f03CI7iii2TL+zCVsyNZb7AAFVBa+pC5rafYUi5Asx6lsx8eUfSQk2znNy9YnSQ7smqmw5wzmWT57mXc3YXu3NMkE9EdADrMpi906GIWjkSFbwtdBUfLDQ7whJr07iGQSqA4khWTbeXVYetU/bmB7s68B/8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786775523;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=dcPQlaisPKUT/laURq5jklWbnDY8vId+pgQgNCuFyKA=;
	b=CMfwzz6dLWr7bOtf+ilpaSn+nxeq2mTxhRa333ZA35Nf2brgMlRBqpFNbE/zwAzK
	wa2pgQ0RJzNzxDsY8MOOzk6ssAIdH+RSq8rzFINuEO5XYGSDbLJFPGug0HwNN5uWGKf
	vGk0aKZOR7CLC62xiScMf5EdUxOWjogUKzdj+xN7XUqSIAWZRLmkKC3sUU0O058DYnU
	4drmvfAknElz9gmxQad1m0Yolx/hVorIDQMDx6TW3lI24lY/MRFtBNsOEoKZZS5gbtM
	N4GmVyFwl8xL9FisGcUwasop/+HmWXe4l1/kng1Ps2NssgtQvmLnUXDVrIvH0gGm/eg
	ZVBJl5Kdew==
Received: by mx.zohomail.com with SMTPS id 1786775519019885.8072579744174;
	Fri, 14 Aug 2026 23:31:59 -0700 (PDT)
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
Subject: [PATCH v10 net-next 3/3] selftests: drivers/net: Implement ptp4l sync test using netdevsim
Date: Sat, 15 Aug 2026 08:31:48 +0200
Message-ID: <20260815063148.2952-4-maciek@machnikowski.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815063148.2952-1-maciek@machnikowski.net>
References: <20260815063148.2952-1-maciek@machnikowski.net>
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

