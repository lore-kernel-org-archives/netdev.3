Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793465827;
	b=CNUmfXKzfDV40lrr+l53cL712SffS57PbdA1g8lBkwny0DGw/URwgbu8efrT9W/nrwTA
	 ja66v2pcTdjTmKPQNp32QnOE4DCKEw7juC0wc5ietSJDyKEFZZ819t1uE0qihQgnn0aHr
	 Gm3zlycbnFv+K5MHVTBF0n6Niy42weUHYC3tjQr0uAElrMwSgBHsYYQ6VybHh3lE51xOZ
	 qwcmNt/DN3H7RyA9+n3Mhv7b3rV1xlrz6TCsnxof7fSJBTilwXdzjkJSa/E+KliivWan8
	 uS2hQ+GLY5Tm0yABBVGTBcWuigZkXPzWhsF0luexmtxm70VrDwI02rFMEb/OrATKaBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465827;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=28YrCYrPaLmxbfjWxFD7RssKsQxLpDugnX72xZJqlrE=;
	b=g9hiPyJ2J6Axa6PznRd4jP65BFTZnSEp+RQvC3xTqkMKLGr+LqG8d6UJErScCt5g3Hbp
	 lHNzaBnIo7VHBqGdhrbCQc09vd7iHDOgp1RlVJqvsY/L6QAZDOecJF71W5PJayvvnaJVC
	 UIeXCx0mnLtJSiqlhrP/FLhVRA3OKy2OfeiLCCW1R0s/xmePd+WNvjrMdtrjOSoj37J9/
	 DTRopo5INytv13uBHVUVrlndw/5cjnRj0PxgcDAZsJQ4KFPXTl+zGzsgCyz4UtGFALffd
	 GvLpmahfWtxwGIsUVZYyQwpWDM9XA2myCVPLfa2q0oBlpWpmv1ApXmCTmhfnvbC0j6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=machnikowski.net;
	spf=pass smtp.mailfrom=machnikowski.net;
	dkim=pass header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=AjYz3UnX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4AF606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 16:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD4AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=AjYz3UnX
ARC-Seal: i=1; a=rsa-sha256; t=1793465783; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k39nsnB3EPri52ZgCz0qnQVKKymgAhTZHifd1pyK4dLN3G//7LwoOfnPdtrLPxaicXseIFLDVvClaEhBhr4YTZJh7VGceDgGOSMgzvQp/5qUR4yyiPnH70aXIp8O7kczZqMFzXuQRX3NlyD1WlyTLdgBDF0C1ydvv8MA6LPphsw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793465783; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=28YrCYrPaLmxbfjWxFD7RssKsQxLpDugnX72xZJqlrE=; 
	b=A18DpLWno4vUIxH9886BRToGpj7M7qe7pPqVunK3V7l2HGsrbaUeZQAg62rqKGCbp3NqCAoPoiMVoLB2bF6qky4VCB25HU0mX/3+Ctm4YMN4pZ79qJD1WvvYoMdvVb7xCPnGq8bDnsUp6oPltu/m0inmkgJux8ahwvTQwZRRTKo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: a=rsa-sha256; b=AjYz3UnXiQxWfpgVOISRVmiwbKhyNd1MZmVdTuhKfWgth2RGEQQN8VY2v7xRWw55t2XXt0royC2InV1SnFBIF7PCnnwBHuTzqze7txCQQYP0r4VL3ikE5N0cEtvq7UxO2vwIqYY2BUeg7oyMNAfipQzZw9fUC20Cm80GhTDt1caEvqNXDK1PI1LMHxZQvkzH+GdZX6ZaLGBIZY6nt0FdqILPDgAce2cXMb6s5HwyPDCmTyF2P1EnyxW6P408OwdogQMVffoIE4POPHdSZZ+6Hb6Xc0AuKtLfmBpBXTZOujXXdZbXg+TR7E7Q1Trfjp1qXUhhhyxXccjdUuhdY8MMRg==; c=relaxed/relaxed; s=zoho; d=machnikowski.net; v=1; bh=28YrCYrPaLmxbfjWxFD7RssKsQxLpDugnX72xZJqlrE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793465781031135.65610496501597;
	Sat, 31 Oct 2026 09:56:21 -0700 (PDT)
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
Subject: [PATCH v11 net-next 3/3] selftests: drivers/net: Implement ptp4l sync test using netdevsim
Date: Sat, 31 Oct 2026 17:28:04 +0100
Message-ID: <20261031162804.1893-4-maciek@machnikowski.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031162804.1893-1-maciek@machnikowski.net>
References: <20261031162804.1893-1-maciek@machnikowski.net>
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
 tools/testing/selftests/drivers/net/ptp.py   | 97 ++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/ptp.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 79c6f998e704..ed41a69ef6ad 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -23,6 +23,7 @@ TEST_PROGS := \
 	ping.py \
 	pppoe_gro.py \
 	psp.py \
+	ptp.py \
 	queues.py \
 	ring_reconfig.py \
 	rss_key.py \
diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index 4838adf27fa1..30e69446d41d 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -21,6 +21,7 @@ CONFIG_NET_SCH_INGRESS=y
 CONFIG_NET_SCH_PRIO=m
 CONFIG_PPP=y
 CONFIG_PPPOE=y
+CONFIG_PTP_1588_CLOCK_MOCK=y
 CONFIG_TLS=y
 CONFIG_VLAN_8021Q=m
 CONFIG_XDP_SOCKETS=y
diff --git a/tools/testing/selftests/drivers/net/ptp.py b/tools/testing/selftests/drivers/net/ptp.py
new file mode 100755
index 000000000000..121167256f35
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/ptp.py
@@ -0,0 +1,97 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# By Maciek Machnikowski <maciek@machnikowski.net> (c) 2026
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
+    KsftSkipEx,
+    NetDrvEpEnv,
+    bkg,
+    cmd,
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
+def _require_hw_timestamping(ifname, host=None):
+    """Skip the test unless ifname supports HW TX and RX timestamping."""
+    end = "Remote" if host else "Local"
+    ts_info = cmd(f"ethtool -T {ifname}", host=host).stdout
+    if "hardware-transmit" not in ts_info or "hardware-receive" not in ts_info:
+        raise KsftSkipEx(
+            f"{end} device does not support hardware timestamping")
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
+    cfg.require_cmd("ethtool", remote=True)
+
+    _require_hw_timestamping(cfg.ifname)
+    _require_hw_timestamping(cfg.remote_ifname, host=cfg.remote)
+
+    leader_cmd = f"ptp4l -i {cfg.remote_ifname} -m -2"
+    follower_cmd = f"ptp4l -i {cfg.ifname} -m -s -2"
+
+    with bkg(leader_cmd, host=cfg.remote), \
+         bkg(follower_cmd) as follower:
+        synced, output = _poll_follower_sync(follower, PTP4L_SYNC_TIMEOUT)
+
+    if not synced:
+        ksft_pr(f"ptp4l follower did not reach locked state (s2) within "
+                f"{PTP4L_SYNC_TIMEOUT}s")
+        tail = output.strip().split("\n")[-10:]
+        ksft_pr("Follower log (last 10 lines): " + " | ".join(tail))
+    ksft_true(synced, "PTP sync timeout")
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
2.56.0

