Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355372;
	b=Xh4P/NzNlXVHLcZ7vGGzTRAlw814LfE5OiD7yUPyryAy5kq+BXPRM1NiUtPm05gYZdy1
	 Qj04P74o8brpwY6K+TT3hROycVWC4j+tm/g9FD5rD+jZw7gjuL7cL13mIidDWeAM7Zyya
	 zx3e15Qpgjd5inVgr1NykcZIG6p3LryxuMOVUqyYOG5LBsEzgf7KMICBhErC3bs70Xa4q
	 vN+H2heDCUWH+e2wh68WIxfYKuorTh+beFMdKmT8QntwS2PQlxSmYQ9hlz+HmrE6BfqcN
	 uOr1PSHbyzvE1OjGi/CrK2h7S50UyC+qzCDMHROcsSa8rHwodlp4dzIvIWJgAJQedhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3w0yh6AH9rrF4jqslTHyrOriJUZ7vMRCriGFzt3jMU8=;
	b=hFRhXJuZML+MISQzrN70jqi3w/XS4MdN2Txo1w56YxI58dZxQsMoAoV2RNVIwUwnyolK
	 EBv6Z06IAFPeqwh/X7mi3O3SW3i0AJdb7uOxHpkuwlwRDdE1fU/27g05fPd8oRJPqjahh
	 F59Z+H9A/5QgBWjl7RXGCULsy7JNzFrb/LFXCaB5lHyih1U9EzesRUFsCSnP+NIDGE5dN
	 +4k/W140oHN5kyidfu77nO9eTjI9inPvarkbP79vbBfMJUH4VhvQkalbVgY3cvRW+LUok
	 Ij09L/I3j27SPF3HjcX8aqA0qyWzxxghiJrheCFImSvC2aJaGXPCs3SOhUEHFepD/Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zcZ56uAe;
	arc=none smtp.remote-ip=74.125.82.194
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496B606A337
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6496B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zcZ56uAe
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-37600b0db49so778137eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355371; x=1794960171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3w0yh6AH9rrF4jqslTHyrOriJUZ7vMRCriGFzt3jMU8=;
        b=zcZ56uAe3QDCFN/CaOItKOyyYmeCRtdv/VbKdu6O/PSebs53YOvBzSJHZpVFQA2TM7
         f3p3ShZZHpb1m6G3BQ18KHcrFGxr+FQlFaLTtBumE+9Z/4XPjdr2mlZDbrEcmvw46o8J
         Y0giP8OoZuD6zLVjiklny5UED+DliWWOvfPndawuYeWC6+2ASMJ5NjLVASIlvVlDDJEO
         Gcpzovryc4GrlGaJfaqO4qTvJBXx2u7MQPlJYIEzuxck516srZ/yWQo2xGVObrPN07uB
         Y3vVckL2t2GUm/esc8dPJ5ANUTZVhuVSsdS9h2tGUC0cD+BtUBFBt5EawLZj/5BwOLQ/
         /ZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355371; x=1794960171;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3w0yh6AH9rrF4jqslTHyrOriJUZ7vMRCriGFzt3jMU8=;
        b=Wq0BrKRu0l0tvcFhBHF8yjN5+CHw/6bcswput0rXoxT+0shpxB4z1ZKCfsGYnmY8kt
         Bf5Q+N+z4RBFyUFPlE2U5iKUkSld0A+LhYoLQ30/mXPyeloJ88UTjcUVP7CpS+N0NQhM
         zmaoQMygtBSTK9mFwVKf0cQa6NvUZ5isGUbrRpyTw4LqhoiF705TG7q6yl9I+RkofYn1
         roQGHNUYq4BdyUALSTk4C9fouIsEuH5PO2oWZ4GCip1bzVSpDThO1t4qX5E9nQF9iTUa
         LN+aHZXZ3gY3OrQfRizqHOaL23IH4mmFWfREvKataXnS4hsDasRLVqrDzih3MzDKJPLk
         ePng==
X-Gm-Message-State: APuU4Z8P/XoxIDEmWaTyJGOD1odhV9ivJvRXlAq3Y+Xt8L1m8xjof7wY
	iYV6SYED8tbd+PSopwRU5M8Fx8bST9wTCQ1Co1R8zrvc48SrdtGE8zHWBeG8YeBEQTQ=
X-Gm-Gg: AYBFou20hP7ty3GxXqdCeNQmuEytLZ5mABRDN0xv9mjXycBeEeipUNEFk2gj2vOmyga
	jZOk1sOHroUwwCVGcjxpY4ma/6HIcE5D71DW1dIqccoNJkzc+knA4uxsHWMvRE04Wcc9s2/X7/O
	sZ+cSpHqQqqoBnBokqBzS4XmGoxsieC91ZwAhxEDzcqBz7yyIenQvVfmjr9vynlLnKvojjlUW+3
	WHpLkKJ66g9ONxByDiUG5p2KAIma6w3k1s8Y+0LJOl9z1u8y7V5zDM8EhTFiAm49jtRM+ZBIUxX
	YmjyTH5xazbIo5S/+C2AzXCw1eQqDDjBlWbDKdIhABXOx1qeUtVt5DmtaXLDyrYp/GYvIOhgP+1
	S/A/t+n3eTwvwGXXYQS0+k39kz66iXZ2m/iSFyjy7Zy7PBfdb11OkR9/hcsO3P7OeGX7Uq6CRvx
	kAwvcokIouh++p8HYQN3NwkhiwbxxBZjElE4BAsBkHwq1+JGW+3P4EFO0t7OxbIQW4d5MZfagvO
	47dJgQ1AIAK8ixvzdd9+od1SsylM538Q+w5SJ6RMEfLTp8xMEHyxf2CpzbZdljB4z8HDJXXAw+0
	M7C/ZXWj8kve3x1O0b9Wz5DtmcKChZP1P/54o/F/8zhnsQ==
X-Received: by 2002:a05:7022:1218:b0:1b3:a8fc:6306 with SMTP id a92af1059eb24-1b3bef0cfa4mr1284096c88.6.1794355370353;
        Tue, 10 Nov 2026 16:02:50 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6f::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe32276sm9681231eec.8.2026.11.10.16.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 16:02:49 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH net-next v4 2/4] selftests: drv-net: add an iperf performance test
Date: Tue, 10 Nov 2026 16:02:44 -0800
Message-ID: <20261111000246.962871-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111000246.962871-1-sdf@fomichev.me>
References: <20261111000246.962871-1-sdf@fomichev.me>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the drivers/net/perf target, with a lib/py of its own like the one of
drivers/net/hw. Add Iperf3Runner.measure(), which returns an Iperf3Result
that other results can join later, and report its throughput from the test.

Single-stream iperf3 throughput is flaky and can change considerably
between back-to-back runs on the same hosts.

Tested on two mlx5 hosts. Captured metric output:

  # # ktap-metric-json: {"goal":"higher","name":"throughput","value":49.92071602072054}

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/Makefile              |  2 +-
 .../selftests/drivers/net/lib/py/load.py      | 20 ++++++-
 .../selftests/drivers/net/perf/Makefile       | 11 ++++
 .../testing/selftests/drivers/net/perf/config |  1 +
 .../selftests/drivers/net/perf/iperf.py       | 23 ++++++++
 .../drivers/net/perf/lib/py/__init__.py       | 57 +++++++++++++++++++
 .../selftests/drivers/net/perf/settings       |  1 +
 7 files changed, 111 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/perf/Makefile
 create mode 100644 tools/testing/selftests/drivers/net/perf/config
 create mode 100755 tools/testing/selftests/drivers/net/perf/iperf.py
 create mode 100644 tools/testing/selftests/drivers/net/perf/lib/py/__init__.py
 create mode 100644 tools/testing/selftests/drivers/net/perf/settings

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 07c3719f8b04..c55d7792b27c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -159,7 +159,7 @@ TARGETS_HOTPLUG = cpu-hotplug
 TARGETS_HOTPLUG += memory-hotplug
 
 # Networking tests want the net/lib target, include it automatically
-ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)
+ifneq ($(filter net drivers/net drivers/net/hw drivers/net/perf,$(TARGETS)),)
 ifeq ($(filter net/lib,$(TARGETS)),)
 	INSTALL_DEP_TARGETS := net/lib
 endif
diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
index e24660e5c27f..f337b576c4b4 100644
--- a/tools/testing/selftests/drivers/net/lib/py/load.py
+++ b/tools/testing/selftests/drivers/net/lib/py/load.py
@@ -3,10 +3,18 @@
 import re
 import time
 import json
+from dataclasses import dataclass
 
 from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
 
 
+@dataclass
+class Iperf3Result:
+    """Average throughput (Gbps) of an iperf3 run."""
+
+    throughput: float
+
+
 class Iperf3Runner:
     """
     Sets up and runs iperf3 traffic.
@@ -53,9 +61,9 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
             kwargs["timeout"] = duration + 5
         return cmd(cmdline, **kwargs)
 
-    def measure_bandwidth(self, reverse=False):
+    def measure(self, reverse=False):
         """
-        Runs an iperf3 measurement and returns the average bandwidth (Gbps).
+        Runs an iperf3 measurement and returns an Iperf3Result.
         Discards the first and last few reporting intervals and uses only the
         middle part of the run where throughput is typically stable.
         """
@@ -78,7 +86,13 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
 
         avg = sum(stable) / len(stable)
 
-        return avg
+        return Iperf3Result(avg)
+
+    def measure_bandwidth(self, reverse=False):
+        """
+        Runs an iperf3 measurement and returns the average bandwidth (Gbps).
+        """
+        return self.measure(reverse=reverse).throughput
 
 
 class GenerateTraffic:
diff --git a/tools/testing/selftests/drivers/net/perf/Makefile b/tools/testing/selftests/drivers/net/perf/Makefile
new file mode 100644
index 000000000000..31b0b60de4f6
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/perf/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_PROGS := \
+	iperf.py \
+# end of TEST_PROGS
+
+TEST_INCLUDES := \
+	$(wildcard lib/py/*.py ../lib/py/*.py) \
+# end of TEST_INCLUDES
+
+include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/perf/config b/tools/testing/selftests/drivers/net/perf/config
new file mode 100644
index 000000000000..6450f34933e6
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/perf/config
@@ -0,0 +1 @@
+CONFIG_IPV6=y
diff --git a/tools/testing/selftests/drivers/net/perf/iperf.py b/tools/testing/selftests/drivers/net/perf/iperf.py
new file mode 100755
index 000000000000..5b6f0bce2a03
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/perf/iperf.py
@@ -0,0 +1,23 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Measure TCP throughput with iperf3."""
+
+from lib.py import Iperf3Runner, NetDrvEpEnv, ksft_exit, ksft_metric, ksft_run
+
+
+def tcp(cfg):
+    """Measure TCP throughput."""
+    result = Iperf3Runner(cfg).measure()
+    ksft_metric("throughput", result.throughput, goal="higher")
+
+
+def main():
+    """Run the iperf performance test."""
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        ksft_run([tcp], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/perf/lib/py/__init__.py b/tools/testing/selftests/drivers/net/perf/lib/py/__init__.py
new file mode 100644
index 000000000000..f16606cedd00
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/perf/lib/py/__init__.py
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Driver test environment (performance tests).
+NetDrvEnv and NetDrvEpEnv are the main environment classes.
+NetDrvContEnv extends NetDrvEpEnv with netkit container support.
+Former is for local host only tests, latter creates / connects
+to a remote endpoint. See NIPA wiki for more information about
+running and writing driver tests.
+"""
+
+import sys
+from pathlib import Path
+
+KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
+
+try:
+    sys.path.append(KSFT_DIR.as_posix())
+
+    # Import one by one to avoid pylint false positives
+    from net.lib.py import NetNS, NetNSEnter, NetdevSimDev, UserNetNS
+    from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
+        NlError, RtnlFamily, DevlinkFamily, PSPFamily, Netlink
+    from net.lib.py import CmdExitFailure
+    from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
+        fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, \
+        wait_file, ctl_file_write, tool
+    from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
+    from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
+    from net.lib.py import ksft_disruptive, ksft_exit, ksft_metric, ksft_pr, \
+        ksft_run, ksft_setup, ksft_variants, KsftNamedVariant
+    from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
+        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
+    from drivers.net.lib.py import set_ethtool_feat
+    from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
+    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
+
+    __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev", "UserNetNS",
+               "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
+               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily", "Netlink",
+               "CmdExitFailure",
+               "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
+               "fd_read_timeout", "ip", "rand_port", "rand_ports",
+               "wait_port_listen", "wait_file", "ctl_file_write", "tool",
+               "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
+               "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
+               "ksft_disruptive", "ksft_exit", "ksft_metric", "ksft_pr",
+               "ksft_run", "ksft_setup", "ksft_variants", "KsftNamedVariant",
+               "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
+               "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
+               "ksft_not_none",
+               "NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
+               "Remote", "Iperf3Runner", "set_ethtool_feat"]
+except ModuleNotFoundError as e:
+    print("Failed importing `net` library from kernel sources")
+    print(str(e))
+    sys.exit(4)  # KSFT_SKIP
diff --git a/tools/testing/selftests/drivers/net/perf/settings b/tools/testing/selftests/drivers/net/perf/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/perf/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.53.0-Meta

