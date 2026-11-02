Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646512;
	b=N0IgFOH+R3EH53j2uaTe6+fi0a+s1nfITp6yGo58VQCpb3jfQMCdm3VmwW/g3Um4mFeW
	 0CjT5SI/KEnuLdufmC8Uul1PayNR8yC2JqoE1pYX+60BfHwphGJrWe1zaRLDgeGgjC5jK
	 zgU+7e07rWyQpVZMSttOJFFlvEJG0paO/A3KDsZjeAAkOfPsxIL5QjaHraMg8TEFqODSJ
	 ZrzbhsetJd0Fxa94AGEKV2z7WCE8p9B07yj5n/+TUOev8HqNOtY8M31mc6A3Ss9DEOSuH
	 uOoQPRO0bu6iueX5FV8kpf/nXAIxho1Goh64/pxYD6AZFwX61OK4Lz4kBsxPMxHiVXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VYKtxiyUILXOMEXPjS+UansPhtZWHn3ggysdgqYExxw=;
	b=Znp8w18MmjQ6T/iUgh4aQwBhwWw4C+/O/lNZ0MMbr8KjRRBIaYkX4MlOjubYCsKvUOOa
	 zN/MHjpRQanSNlF/OC4SInCwMaHx3DjSaGKu2OGzFGZj4FI+KbFvTnmmAoubke7qiSnzH
	 RX1svJA28RjAvwQ0IQumEsMbG1h/52LdX8f8jgJb6EnJEn94zWbrYRZ2a71u4KZ8SXGzi
	 OS1IiIEKpxxpNohfPWfn5wqnoWDG5fC9taPwYEOkDCTK/o2dDrD3vrasWX2jwFtYHXhCA
	 rqcWTHBnl0JgLLIN8Pp8xqApnmua10f6L2HIAQ8CK7ZZTg2ZIMBPdBF5ZUu790BscLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r2GEzWIx;
	arc=none smtp.remote-ip=74.125.82.196
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CCE606EEB0
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8CCE606EEB0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r2GEzWIx
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-36a2551d7b5so5462922eec.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646511; x=1794251311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VYKtxiyUILXOMEXPjS+UansPhtZWHn3ggysdgqYExxw=;
        b=r2GEzWIxOQTjwEWEGzwRpyYQDcH6mKvHHZFZ3VC/xFuSgc1SYHrRb7/hf9rdxUFpj/
         gs/QnpMihjBXORVW9aZ/KiofRyi2nOnslpO2XlEvJXQZIEX25kFLOtHdmlV0MY2Fh0n9
         1FoInMgx1B69z4Nyew8qWEeuvDzMcT7QIaGvEaSyc3wHNEZRUdY0v9vY01x5e+MA7QGO
         k4mB6sqa+JpXLJUQOefB4y1j9+MJAN9TGspAuL1gUyi5yl/p+M+koQg7D1zWt4FKsJhr
         4cQC1W2jb03ivWukcvQ8YXMB7xy5pHETo0D6C3qXSpT1xgocr+cz7ZjGCF//nAyO57BO
         iuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646511; x=1794251311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VYKtxiyUILXOMEXPjS+UansPhtZWHn3ggysdgqYExxw=;
        b=WYvLS0W6m3mVuLguZ14LTtP9LsM+G8mxs3ostpBU7Fq8rx0wDZBAy6a3Yz6QirJTV2
         itmQUaLk7lN7soWbenegOUfZd9NGqSrVhtBxzQTLTYFZcxydwYe+F+8NhnVyiBVaM6QP
         58KKERVFzKzQKPld34kqNugGwK4N1t+QpDjIBHdGYx1Uzn5vLRA9U7fUhcFF4NYM5hMJ
         QajO2isAx01noXkrbGObFcW2g4YQg8gab7p1QJaQZtuLzIMd1Uml/Y6tyJuFmMfjnSdM
         xMaRKVqee99Dt4CjRDTrX3ttLsRzgNcpc71x5iMfchK69mB2cvq595l9lL99RZvu7n1L
         37Dw==
X-Gm-Message-State: APuU4Z/8n5EDVxJgKK7WPvFX1t6y+dX/f0bEtK5hyyshK9GVmVppAM4m
	57ulXwQ6w6WAlnJQMWKYB8RF8UQhOeBdmsYy0AG/Dp0qVrl4DfeylN/XB+7d/KCh
X-Gm-Gg: AYBFou1KL4+Hqsrw+4VmxuvWhkPmyxLo5yzuWSefUEmIeEmcBNlwD83LYegxuk/8i+q
	Bn0S5gJJZ84utJOrbAYaK1TRcd/mFvy8KmUKjdqyEgBT+/AWnMfAyzbofml4tm1fuV9dKS46BN0
	XXoss21s0+ToHjygNBT1HLOD9LAtRrWosNCmxdHnOMorCbEFZ5boi79Y1NKnYdYzKhGeDyBPAhj
	s2AGtUa5LIcMpJuMxN3HqMhpSDvvGEtXQGbgsKfniPxNPFtviRvcb//UWhpjsMVdljGMjklokIO
	NUjwXie1DbvTi8XUAjJ89Fk4CeLCw9oP1sfg8OxYJvEK5Mzot4JPQ5Ugd7puZR15S8FxeBgeYSs
	X2g9rD+sZtmkL5g/CroGWUejneOQYQarJRxueztoXr7g6IazkqKb4T2q93nhWpKPpHxqtc+yJ0d
	AUgxu7+w0QBIRUVsf61ZeaM2i194Omt/qSQxcxqXB3wEG/nc5E+oZSo6uCyqZ1WZxilE57DqrgZ
	4GDLHqPKg1SoUAl4oB8clGDKojSJv4EQR9FsSGgC0PjAV7IEZukHeHX4GGvJ2c1Wp65HjW84nxn
	cGiUzKJsAOUomemPjGs1JXY=
X-Received: by 2002:a05:693c:61dc:b0:36a:1a7b:d1bb with SMTP id 5a478bee46e88-36a300756bcmr23752080eec.22.1793646510565;
        Mon, 02 Nov 2026 11:08:30 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:7e::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm53844828eec.16.2026.11.02.11.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:08:30 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v3 2/4] selftests: drv-net: add an iperf performance test
Date: Mon,  2 Nov 2026 11:08:25 -0800
Message-ID: <20261102190827.989117-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102190827.989117-1-sdf@fomichev.me>
References: <20261102190827.989117-1-sdf@fomichev.me>
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

Add the drivers/net/perf target, with a lib/py of its own like the one of
drivers/net/hw. Add Iperf3Runner.measure(), which returns an Iperf3Result
that other results can join later, and report its throughput from the test.

Single-stream iperf3 throughput is flaky and can change considerably
between back-to-back runs on the same hosts.

Tested on two mlx5 hosts. Captured metric output:

  # # ktap-metric-json: {"goal":"higher","name":"throughput","value":49.92071602072054}

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
index 000000000000..2bb2cd08ff7d
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
+    sys.exit(4)
diff --git a/tools/testing/selftests/drivers/net/perf/settings b/tools/testing/selftests/drivers/net/perf/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/perf/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.53.0-Meta

