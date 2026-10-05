Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BDD34F474
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231083; cv=none; b=ak9ZbmvzzH9qcDqKPyoJigFti/iHNyYdmyestIdevKgjFOYxLJ93Gcv4dXHvSYLyuOaO1rtHr6Rnw3/B3ltqOBr4XdxTl6Cz9ZgJdSX592x8ZygYQJlOa1yVPWvnuRRj8v59+EFKgi+iCjgIY3swCA+kyFmqH8fH+D1hl+6K73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231083; c=relaxed/simple;
	bh=SRh1aT2eLZcsDsuJF2SW+8mYJmm1umKWj3gfi7wqutY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9eO98sbJyXrIULX1hiLybzbKYtDTPQwPL7kuQxz57mrKpAF9NTs/Gzg2NHvwdaQ+Ai0pmabpaINuEO3ckL+jUH+bm5jiufQCj7hXPen61iLn3fJSEL5UyAaO4bpEuoYjO5mXU4EowGgGdWOT5lVYOvq0KExVL7qqaR3/FhqVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KE87eOsg; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KE87eOsg"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cb3f5bb19aso4812525ad.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791231080; x=1791835880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8iRO90kh+b1K51NpqxnyiQGiRUYB0ZuY8L6XC4rgpOA=;
        b=KE87eOsg3P808nZro0KlkJwe8roBO5ia6jTH9hJW567srZl9hvIMFfnLFlFrEDSu5n
         hbqrGgsiAvndS876kjeD7hxrX4uG0g4aFM+BFbF+jS73juKVaPVohith+gFRSiDvURkD
         3ncJI8xn5//VYKhsle3jNDs0CCKp6zgcFUOn9/VzEU8ryRcnXq+Xot4ATuqDgoafgvn1
         Ft5zjqu/xqiLqdEuBLTnYbvyYgKcbVXtN94jVfgYzcn0VP8X6ZIWCSQqqYcrlew96JyT
         A7mBfJOGRxu+MB64iAilETNumHb6F+6nW6GFl4C8+tdtcGbIA35I+MdP/na6guBF1eH+
         35rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231080; x=1791835880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8iRO90kh+b1K51NpqxnyiQGiRUYB0ZuY8L6XC4rgpOA=;
        b=obGtObl3OS9QgraP/URLxEK2t2NPmpbuF0CINUxmnZIM8XD4cxsBX9MB52+GrEQ4QK
         gKYqYSAGIb+R9qNuJn3wxdW1dY6pB5OIWW4tV9MvCFbEMOV8ErMT2ptLBQU4q7gSVSTw
         5vQq9N33TYKBAFsKltgHrXFcj/+2twItmvs54V3F5bsTuxJMErGtgffKvCHsuDb6MVpb
         4wnauY9k1Zpnqg3PY4sQlsNcSUqve4H4sH24j62ed2EYWl0FkY3XSjfxaFSNbRMcF430
         eVF++lDIqqUHWqliG0ACzKhM7SEDJq2oCZN6hXpufqug20FRgpeK+oFAC1cQNeC23LhP
         AUuw==
X-Gm-Message-State: AFq9FYLEsRyE62NjW5KIsufOYSLYgAGUVoT0NW5JFcKVw308v0qqnC6L
	pu4zRPIATYsTETmKVV8HxRalrQ65RvTWGOHPuD9YrCwiTUOOKJsGtgbw/EUFoVA2
X-Gm-Gg: AYBFou3TsHd6hspacRNeuwc2aO+a7ScUKBPxGP1hekACTHveNMP0384LoFjfV4h9FVq
	yJFWS7VoJ3MygjtiRRU6fvG4EQEAKoSOEr+k4zj9sTyV9oYUJsKosdiIt1UJohw6pKpbXOBVVcB
	lQ/+xCzaydQ703mlY6tcrX1HqumwLqxMt6n3KJHpH5YVnFhLVmMWwGcoJMuJTXdw9QfspDbZv1y
	RxXgwvJMvz6hhp3FKcbCdJlLugi4LvWW03smLVhayJx5mVwkQZN2vHDsh+xuT8qhP2nycXwaHcT
	XDz4ChJaVpUHQxZDQXTu+XzcwIj7E5L8QXk7ZP2kZD5QwWQ6hBhNJB+AyirHGisQVWM9XnkTn9L
	fd92F6Mn6FP7ExO4KzUvV8CB+8UwCGlTS3V5SBedapNokY7+o5aJQZoM45KEsJG5WeCkHGkVSkN
	kUb4rLL+MnHIYFfhH0RVCOQ7lC9yDAb1q0a6dLOuiXFqjP/rghGKfj8Ahd75YWHCE=
X-Received: by 2002:a17:902:c952:b0:2e2:e0eb:e591 with SMTP id d9443c01a7336-2e5106aebd6mr79207515ad.60.1791231079438;
        Mon, 05 Oct 2026 13:11:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a55b659asm12573145ad.2.2026.10.05.13.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:11:19 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC net-next v2 3/5] selftests: drv-net: add an iperf performance test
Date: Mon,  5 Oct 2026 13:11:12 -0700
Message-ID: <20261005201115.2690830-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005201115.2690830-1-sdf@fomichev.me>
References: <20261005201115.2690830-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the drivers/net/hw/performance target. Report throughput and
retransmits from Iperf3Runner when requested.

Single-stream iperf3 throughput is flaky and can change considerably
between back-to-back runs on the same hosts.

Tested on two mlx5 hosts. Captured metric output:

  # # ktap-metric-policy-json: {"display_label":"Gbps","name":"throughput","regression":{"better":"higher","compare":"p50","relative_tolerance":0.05},"summarize":"p50"}
  # # ktap-metric-policy-json: {"name":"tcp.retransmits","summarize":"max"}
  # # ktap-metric-json: {"host":"local","name":"throughput","time":10.685632,"type":"scalar","value":48.561920255183196}
  # # ktap-metric-json: {"host":"remote","name":"tcp.retransmits","time":10.68565,"type":"scalar","value":0}

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/Makefile              |  2 +-
 .../drivers/net/hw/performance/Makefile       | 10 +++++++
 .../drivers/net/hw/performance/config         |  1 +
 .../drivers/net/hw/performance/iperf.py       | 27 +++++++++++++++++++
 .../drivers/net/hw/performance/settings       |  1 +
 .../selftests/drivers/net/lib/py/load.py      | 24 +++++++++++++++--
 6 files changed, 62 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/performance/Makefile
 create mode 100644 tools/testing/selftests/drivers/net/hw/performance/config
 create mode 100755 tools/testing/selftests/drivers/net/hw/performance/iperf.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/performance/settings

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 273853937c25..7523f378e026 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -152,7 +152,7 @@ TARGETS_HOTPLUG = cpu-hotplug
 TARGETS_HOTPLUG += memory-hotplug
 
 # Networking tests want the net/lib target, include it automatically
-ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)
+ifneq ($(filter net drivers/net drivers/net/hw drivers/net/hw/performance,$(TARGETS)),)
 ifeq ($(filter net/lib,$(TARGETS)),)
 	INSTALL_DEP_TARGETS := net/lib
 endif
diff --git a/tools/testing/selftests/drivers/net/hw/performance/Makefile b/tools/testing/selftests/drivers/net/hw/performance/Makefile
new file mode 100644
index 000000000000..5d53ef548306
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/performance/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_PROGS := iperf.py
+
+TEST_INCLUDES := \
+	$(wildcard ../lib/py/*.py ../../lib/py/*.py) \
+	$(wildcard ../../../../net/lib/py/*.py) \
+	#
+
+include ../../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/hw/performance/config b/tools/testing/selftests/drivers/net/hw/performance/config
new file mode 100644
index 000000000000..6450f34933e6
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/performance/config
@@ -0,0 +1 @@
+CONFIG_IPV6=y
diff --git a/tools/testing/selftests/drivers/net/hw/performance/iperf.py b/tools/testing/selftests/drivers/net/hw/performance/iperf.py
new file mode 100755
index 000000000000..415fb67f4100
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/performance/iperf.py
@@ -0,0 +1,27 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Measure TCP throughput with iperf3."""
+
+from os import path
+import sys
+
+sys.path.insert(0, path.join(path.dirname(path.abspath(__file__)), ".."))
+
+from lib.py import Iperf3Runner, NetDrvEpEnv, ksft_exit, ksft_run
+
+
+def tcp(cfg):
+    """Measure TCP throughput."""
+    Iperf3Runner(cfg).measure_bandwidth(report=True)
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
diff --git a/tools/testing/selftests/drivers/net/hw/performance/settings b/tools/testing/selftests/drivers/net/hw/performance/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/performance/settings
@@ -0,0 +1 @@
+timeout=0
diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
index e24660e5c27f..a7da025b4e21 100644
--- a/tools/testing/selftests/drivers/net/lib/py/load.py
+++ b/tools/testing/selftests/drivers/net/lib/py/load.py
@@ -4,7 +4,8 @@ import re
 import time
 import json
 
-from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
+from lib.py import cmd, ip, ksft_metric, ksft_metric_policy, ksft_pr, \
+    rand_port, wait_port_listen
 
 
 class Iperf3Runner:
@@ -53,12 +54,20 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
             kwargs["timeout"] = duration + 5
         return cmd(cmdline, **kwargs)
 
-    def measure_bandwidth(self, reverse=False):
+    def measure_bandwidth(self, reverse=False, report=False):
         """
         Runs an iperf3 measurement and returns the average bandwidth (Gbps).
         Discards the first and last few reporting intervals and uses only the
         middle part of the run where throughput is typically stable.
         """
+        if report:
+            ksft_metric_policy(
+                "throughput", summarize="p50",
+                regression={"compare": "p50", "better": "higher",
+                            "relative_tolerance": 0.05},
+                display_label="Gbps")
+            ksft_metric_policy("tcp.retransmits", summarize="max")
+
         self.start_server()
         result = self.start_client(duration=10, reverse=reverse)
 
@@ -77,6 +86,17 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
         stable = samples[3:-3]
 
         avg = sum(stable) / len(stable)
+        retransmits = out.get("end", {}).get("sum_sent", {}).get(
+            "retransmits")
+        if report:
+            if not isinstance(retransmits, int) or \
+                    isinstance(retransmits, bool):
+                raise ValueError("iperf3 did not report TCP retransmits")
+            receiver = "remote" if reverse else "local"
+            sender = "local" if reverse else "remote"
+            ksft_metric("throughput", avg, kind="scalar", host=receiver)
+            ksft_metric("tcp.retransmits", retransmits, kind="scalar",
+                        host=sender)
 
         return avg
 
-- 
2.53.0-Meta

