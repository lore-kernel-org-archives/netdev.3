Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794169599;
	b=M5zgRPxzyy/ckJobTxZ2mFp+FfpxGBjgIrRy6K6l8Tx8VT+I0GAxFMsx4zlA7xUDmskp
	 dOSJaILoP1umQU49OTDC2Eak0udy+i+agFzlGXWKPVN9b9OZNF6sIR9UmXPaQB/WMRj+q
	 197mYET8iMAfLJDGV+j24qK30NrHX4FhpVqWMLPNmGBeaAM/JvqIK8BBXVEeoMXTKWJRG
	 uP71kk0RAzsetb9uahbLaWVoz7gXv31qp/l4EX5VZdvAPzyV/n4yY2j6jsrvrTKeN47Fm
	 sO4QE2x4Z97MbZHOoPtzA7Jlr5jmiZIjDOuZM0l4MSsatozYy/PcgwUTXqYuPZpH2+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169599;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=7xW0TLz5lSvzPfO+HptsTc8YtmKOz/HuMEhxKbGSBVk=;
	b=3DfFmz69y1gHk3AN/A3mZl7TfAX9/igbMitaNZeVjcntW9C5/4M2fT/XUJAXqwIiCd7a
	 08MX97nO6Xay4Fa7s2mK+iOMuu9wWqFBqm6ccResLpL/Li9h8s63gLCokx4XDuVTjDU7q
	 4bsxjl01i9GsgJlMaR+Q4vmA9tBitYLcJWWH7CUZLNkva8AFKUwpvQG8MxIdzoSuEqbmK
	 7eftJR0MbJqqCRL+4P1FE6e428RXZl2XIuDsqqMv1mVfvMR9Vm6fG2QJLNeI2kBT1YfH2
	 UauTmf8ag034co7xrDs0YsixD8ylp7rSo8kjiQJHjg4OH2upUGmmx0dncdJihk9/rNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=machnikowski.net;
	spf=pass smtp.mailfrom=machnikowski.net;
	dkim=pass header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=Xh7dpspG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27E9606A333
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 20:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A27E9606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=Xh7dpspG
ARC-Seal: i=1; a=rsa-sha256; t=1794169556; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Zujhg9OQ7Q5gX7ZWBjxqdZPU/8OYSbzaqifPGjPJSuhPoDrlz2hoSDde/pphYltKR91DahCOJqrHi4J3YnClo1efFTAVdb8cguZIXyvmYbTYZzF4abpNwCtmVS9WClumV4gK4iryMMje2E/EgtWWWGYHaAROdkf3Ei3xdq/8dj0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794169556; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7xW0TLz5lSvzPfO+HptsTc8YtmKOz/HuMEhxKbGSBVk=; 
	b=dzCwAN2LJHLVaXQKuilRf8iBvSo47/bHjKfLChlcA0SrOMOHjhp32EwhCoWN+AH7BaxpT/7gKS9nTV6WzgN+6ZJ3aQAEnPLeUrJj5S/1KSLlqI0zdQ4y0szhbT9Cbl88UzcodS4wBH/jd+/BZObUsY01M5xQg16F1tkaWpVQRWE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: a=rsa-sha256; b=Xh7dpspG4oXZf4V1hAAZcPMb83CvgdhXFtfPF9hgs9nTTQCZxeW70/PTUhQ13f3juwPY6AQ2ztCYBEaznX29rc9JRk3IxxdsqeGuI8IOcW7ivdi5ApaeSWKk9Qbd4PH4u57uC/wNt8qk6dpOCy1ecDhITJxjDhJ7v1cFzMgU99IiP4S5XxQNpaLRdZsfrIlGro716DA8cTCYfiHXBUYwNvxWIQ486vCZscz7nXYA7pwv7O9I6IjrN0Uma3MpJgH9pxnov4vcfG71ZZOYNGhGnwwuWmp08aJofRqC8AFjkCSVjpVj7346C9/gHSkUZsMhqLq5hIojFod+58kzblRxYA==; c=relaxed/relaxed; s=zoho; d=machnikowski.net; v=1; bh=7xW0TLz5lSvzPfO+HptsTc8YtmKOz/HuMEhxKbGSBVk=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 17941695549301003.7078737956092;
	Sun, 8 Nov 2026 12:25:54 -0800 (PST)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev,
	horms@kernel.org,
	almasrymina@google.com
Subject: [PATCH v12 net-next 3/3] selftests: drivers/net: Implement ptp4l sync test using netdevsim
Date: Sun,  8 Nov 2026 21:15:03 +0100
Message-ID: <20261108201503.85000-4-maciek@machnikowski.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261108201503.85000-1-maciek@machnikowski.net>
References: <20261108201503.85000-1-maciek@machnikowski.net>
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

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 tools/testing/selftests/drivers/net/Makefile |   1 +
 tools/testing/selftests/drivers/net/config   |   1 +
 tools/testing/selftests/drivers/net/ptp.py   | 112 +++++++++++++++++++
 3 files changed, 114 insertions(+)
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
index 000000000000..1065bd42ba53
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/ptp.py
@@ -0,0 +1,112 @@
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
+    defer,
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
+    local_dir = cmd("mktemp -d").stdout.strip()
+    remote_dir = cmd("mktemp -d", host=cfg.remote).stdout.strip()
+    defer(cmd, f"rm -rf {local_dir}")
+    defer(cmd, f"rm -rf {remote_dir}", host=cfg.remote)
+
+    leader_cmd = (f"ptp4l -i {cfg.remote_ifname} -m -2 "
+                  f"--uds_address {remote_dir}/ptp4l "
+                  f"--uds_ro_address {remote_dir}/ptp4lro")
+    follower_cmd = (f"ptp4l -i {cfg.ifname} -m -s -2 "
+                    f"--uds_address {local_dir}/ptp4l "
+                    f"--uds_ro_address {local_dir}/ptp4lro")
+
+    # bkg() can't reliably signal the remote ptp4l over SSH (no pty), so
+    # kill it by pattern explicitly in addition to the normal teardown.
+    # pkill exits 1 when ptp4l already terminated, so don't treat it as fatal.
+    defer(cmd, f'pkill -INT -f "{leader_cmd}"', host=cfg.remote, fail=False)
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

