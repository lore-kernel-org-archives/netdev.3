Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C304E50B5
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585472; cv=none; b=ga8RvrECq/bPBR0F23x1ETsaXCLyzyjVPaK5hOfPNIoDK+b+XMrUBVPAgZq6vDIMhtaAs5ZktrCAaNheov0o1GAGPWrFTqC1Jijl2YDhiiqs3fqlFTG1IUYS/hL5pIHnvGnyotPVMLcB7OgNR+oUKGIbxDI79wL//Wkk1AdXw5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585472; c=relaxed/simple;
	bh=4UARhqUYlXCsmDccmgl8tK8z3CG8e666QDXfoiatlEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgt7GKttHCuqfJHgq49dkAiYfw0fHseDHnqFd3t62JOuvvUTsb7PYjj2Fow1j+hO5TceJo6BuYwI1AAW9isVQAedX06grdDjd6cskawe7YW7HGT4NmcxOqxnodbdySlQ2tSNka0FY4SVTpzSc2cpUwPoxxC43ogrIt4HBhSP3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWZPV/Ru; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWZPV/Ru"
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-39e0e245eadso10211a91.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789585456; x=1790190256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ozaFZ5v20hhxz3sQBOvyhsl1Mv0hErZOxqe6r5qngv4=;
        b=OWZPV/RuCgqQAhTBdFRhK0phDkXO49SMT8ZRf5jR2Eui84Wzel/VlpElYzreZzI1eT
         9h8VowOcgKFEBJRdtQBFyutG+TxuosHndOytlwbHx6x73D0LL+FJ7nq5np03Too5wgMf
         HdZz9NjQohN9Lj32rdx543ruWCRRFOFVcPxGMCtGoYP0VTTvpoxxr8tc4ZDjkT3fJgp0
         a3rq9vzh471WdNLtC8/vp2yCa3yvtmHaeX/ZgSPXfTRaaW5aA863E8CGnC9w5JFUQXXT
         Cl6zVDOz26QGyBI5C3qTuCE+DDh/Q3gLSzwPHeFRFs0pnKdgl7BH3TjB1XdhJ0ANBqCO
         3QgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789585456; x=1790190256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ozaFZ5v20hhxz3sQBOvyhsl1Mv0hErZOxqe6r5qngv4=;
        b=jRGmBSPR++QwGUZdaf8al2ryek+VkbiRUPUKnvhs+VJr10M2kqPkXt/jGnc7iOy2WL
         X0W7/22kM7LXyGmMELQF20Tv01RKD5/vk2pOeHrew7iu1tN/U+p2rKJ2SagfsjUC0eWB
         4iXwpmH1wL+MLJnkv4Gbnyn7SHkf8jkYS5I3z1F0D4gb+CnByaa6vdDeWetzW70SOiRe
         /7t3P14vaTEWu2z+QxCVJWNrRnoQO/3GMZlU4Dj+AFt1Y5rPvPSeiaR0kyFnxmxwF7al
         c6RsZWQwCnVtx0VNbVdZQxtBLg+/NH++Km7qgfh5adP3uagjPLjUipCHqhmET5NIZPEY
         YGcA==
X-Gm-Message-State: AFuF++mGglHjnWt23rR8d5d9uAeMyVGJA7xDAJlm9G10+cJpqWlkZ9x9
	a7vVOEEWLGyl4h91Kjt/iHSgPSsnyWkadLCUvwcWrDkrvFcAd53l2Z4w/Kr9EtvU
X-Gm-Gg: AYBFou3PkRF3L+N8Zq1s6umSpAcChCmstV+hXrNSnmaVCaRGcoB6c5EVIYwFwfM3qhX
	2Z18RVv6P07MGQA2pNiUYPWjhe3uZEbUIP/fwPtEUq9M4aqAOxOjPjOCw5ybpfyKjSejXNiefsQ
	8mycqB1B7/fz3ZuqNc55/j/OEOQ3xcbKKziIogNFj5xsh5EDz4OiGo3SP5zXHVFvdx1IZdXVvbb
	mrZ9ZszdLM6O52LNc45eAox76M5RIzAmdRaqlGB6Ps6h89yM4V97RDAMf2UCxri9BjkHe3kvViJ
	Zi9y8EVKVfQR63dxdl/p1R0+5K89+UiafLtMUgpQfCAZL36qMXpmIy4M6gEjlR+ZuqANDlrW/IQ
	pUU2EkrFrTVosh/E+qW0G5uZVEeDKOF0IRG66Q6WU61QcRm1CkMP3V+WsNCLzMrmathdjTOQOPd
	h+iBIwi2hFi49u8w1Khar6IIVJFso6PtonW3Sw2V7UfQ1bQ078JmJoDmkArzabdEk97iVhpUssO
	HA=
X-Received: by 2002:a17:90b:384c:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-39e1e48a0c5mr7980096a91.16.1789585455484;
        Wed, 16 Sep 2026 12:04:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e362f0f07sm862302a91.17.2026.09.16.12.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:04:14 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC net-next 4/6] selftests: drv-net: add an iperf performance test
Date: Wed, 16 Sep 2026 12:04:07 -0700
Message-ID: <20260916190409.1222272-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916190409.1222272-1-sdf@fomichev.me>
References: <20260916190409.1222272-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report Iperf3Runner throughput and retransmits when metric collection is
active.

Tested on two mlx5 hosts. Benchmark metric output:

  # # ktap-metric-policy-json: {"name":"throughput","regression":{"better":"higher","compare":"p50","relative_tolerance":0.05},"summarize":"distribution"}
  # # ktap-metric-policy-json: {"name":"tcp.retransmits","summarize":"max"}
  # # ktap-metric-json: {"host":"local","name":"throughput","shape":"scalar","time":11.42686,"value":32.62285180182741}
  # # ktap-metric-json: {"host":"remote","name":"tcp.retransmits","shape":"scalar","time":11.426883,"value":75895.0}
  # ok 1 iperf.test_iperf
  # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../testing/selftests/drivers/net/hw/iperf.py | 21 ++++++++++++++++
 .../drivers/net/hw/lib/py/__init__.py         |  8 +++---
 .../selftests/drivers/net/lib/py/__init__.py  |  8 +++---
 .../selftests/drivers/net/lib/py/load.py      | 25 +++++++++++++++++--
 .../testing/selftests/net/lib/py/__init__.py  |  6 ++---
 tools/testing/selftests/net/lib/py/ksft.py    |  6 +++++
 7 files changed, 62 insertions(+), 13 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/iperf.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 8aebdc6feb17..03ecc81e18e0 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -32,6 +32,7 @@ TEST_PROGS = \
 	hw_stats_l3.sh \
 	hw_stats_l3_gre.sh \
 	iou-zcrx.py \
+	iperf.py \
 	ipsec_vxlan.py \
 	irq.py \
 	loopback.sh \
diff --git a/tools/testing/selftests/drivers/net/hw/iperf.py b/tools/testing/selftests/drivers/net/hw/iperf.py
new file mode 100755
index 000000000000..77e315c9547e
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/iperf.py
@@ -0,0 +1,21 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import (Iperf3Runner, NetDrvEpEnv, SystemMonitor, ksft_exit,
+                    ksft_run)
+
+
+def test_iperf(cfg):
+    """Measure TCP throughput while sampling system utilization."""
+    with SystemMonitor(cfg):
+        Iperf3Runner(cfg).measure_bandwidth()
+
+
+def main():
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        ksft_run([test_iperf], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 1077930d1677..857bd016e5e0 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -28,8 +28,8 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
     from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_metric, \
-        ksft_metric_aggregate, ksft_metric_reporting, ksft_pr, ksft_run, \
-        ksft_setup, \
+        ksft_metric_aggregate, ksft_metric_reporting, \
+        ksft_metric_reporting_enabled, ksft_pr, ksft_run, ksft_setup, \
         ksft_variants, KsftNamedVariant
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
@@ -47,8 +47,8 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
                "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_metric",
-               "ksft_metric_aggregate", "ksft_metric_reporting", "ksft_pr",
-               "ksft_run",
+               "ksft_metric_aggregate", "ksft_metric_reporting",
+               "ksft_metric_reporting_enabled", "ksft_pr", "ksft_run",
                "ksft_setup", "ksft_variants",
                "KsftNamedVariant",
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index d779f48ea6c5..e418837f0b00 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -28,8 +28,8 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
     from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_metric, \
-        ksft_metric_aggregate, ksft_metric_reporting, ksft_pr, ksft_run, \
-        ksft_setup, \
+        ksft_metric_aggregate, ksft_metric_reporting, \
+        ksft_metric_reporting_enabled, ksft_pr, ksft_run, ksft_setup, \
         ksft_variants, KsftNamedVariant
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
@@ -44,8 +44,8 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
                "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_metric",
-               "ksft_metric_aggregate", "ksft_metric_reporting", "ksft_pr",
-               "ksft_run",
+               "ksft_metric_aggregate", "ksft_metric_reporting",
+               "ksft_metric_reporting_enabled", "ksft_pr", "ksft_run",
                "ksft_setup", "ksft_variants",
                "KsftNamedVariant",
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
index e24660e5c27f..f5f5cf780fbe 100644
--- a/tools/testing/selftests/drivers/net/lib/py/load.py
+++ b/tools/testing/selftests/drivers/net/lib/py/load.py
@@ -4,7 +4,8 @@ import re
 import time
 import json
 
-from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
+from lib.py import cmd, ip, ksft_metric, ksft_metric_aggregate, \
+    ksft_metric_reporting_enabled, ksft_pr, rand_port, wait_port_listen
 
 
 class Iperf3Runner:
@@ -57,8 +58,17 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
         """
         Runs an iperf3 measurement and returns the average bandwidth (Gbps).
         Discards the first and last few reporting intervals and uses only the
-        middle part of the run where throughput is typically stable.
+        middle part of the run where throughput is typically stable. When a
+        SystemMonitor is active, also emit throughput and retransmit metrics.
         """
+        report_metrics = ksft_metric_reporting_enabled()
+        if report_metrics:
+            ksft_metric_aggregate(
+                "throughput", summarize="distribution",
+                regression={"compare": "p50", "better": "higher",
+                            "relative_tolerance": 0.05})
+            ksft_metric_aggregate("tcp.retransmits", summarize="max")
+
         self.start_server()
         result = self.start_client(duration=10, reverse=reverse)
 
@@ -77,6 +87,17 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
         stable = samples[3:-3]
 
         avg = sum(stable) / len(stable)
+        retransmits = out.get("end", {}).get("sum_sent", {}).get(
+            "retransmits")
+        if report_metrics:
+            if not isinstance(retransmits, int) or \
+                    isinstance(retransmits, bool):
+                raise ValueError("iperf3 did not report TCP retransmits")
+            receiver = "remote" if reverse else "local"
+            sender = "local" if reverse else "remote"
+            ksft_metric("throughput", avg, shape="scalar", host=receiver)
+            ksft_metric("tcp.retransmits", retransmits, shape="scalar",
+                        host=sender)
 
         return avg
 
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 9795a83d662a..5b91de1650c5 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -9,7 +9,7 @@ from .ksft import KsftFailEx, KsftSkipEx, KsftXfailEx, ksft_pr, ksft_eq, \
     ksft_ne, ksft_true, ksft_not_none, ksft_in, ksft_not_in, ksft_is, \
     ksft_ge, ksft_gt, ksft_lt, ksft_raises, ksft_busy_wait, \
     ktap_result, ksft_disruptive, ksft_metric, ksft_metric_aggregate, \
-    ksft_metric_reporting, ksft_setup, ksft_run, \
+    ksft_metric_reporting, ksft_metric_reporting_enabled, ksft_setup, ksft_run, \
     ksft_exit, ksft_variants, KsftNamedVariant
 from .netns import NetNS, NetNSEnter, UserNetNS
 from .nsim import NetdevSim, NetdevSimDev
@@ -26,8 +26,8 @@ __all__ = ["KSRC",
            "ksft_ne", "ksft_true", "ksft_not_none", "ksft_in", "ksft_not_in",
            "ksft_is", "ksft_ge", "ksft_gt", "ksft_lt", "ksft_raises",
            "ksft_busy_wait", "ktap_result", "ksft_disruptive", "ksft_metric",
-           "ksft_metric_aggregate", "ksft_metric_reporting", "ksft_setup",
-           "ksft_run",
+           "ksft_metric_aggregate", "ksft_metric_reporting",
+           "ksft_metric_reporting_enabled", "ksft_setup", "ksft_run",
            "ksft_exit", "ksft_variants",
            "KsftNamedVariant",
            "NetNS", "NetNSEnter", "UserNetNS",
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index e44029213e4f..566ec52cd9c9 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -108,6 +108,12 @@ KSFT_METRICS_LOCK = threading.Lock()
         KSFT_METRIC_REPORTING += 1 if enable else -1
 
 
+def ksft_metric_reporting_enabled():
+    """Return whether benchmark metric producers should emit metrics."""
+    with KSFT_METRICS_LOCK:
+        return KSFT_METRIC_REPORTING > 0
+
+
 def ksft_metric_aggregate(name, summarize="total", *, aggregation=None,
                           transform=None, regression=None,
                           display_range=None, display_scale=None,
-- 
2.53.0-Meta

