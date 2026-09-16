Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398744A7C89
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585468; cv=none; b=V9ju5LQEwGnhJy7cqQCnuXLS3UEbWtx/8EVqud9Q19ofrMZ26lppXpNumOFzGFtcT3RO0oqcDrsIk5L7zim4vBv6x+SkFTBE0558KiHCKMf7zYv+npnmYlXkn9Kn3rZYvYDxTBazcHBP6B+/jH73f+9iUp+kHj0s1ELnzdKW+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585468; c=relaxed/simple;
	bh=NPGsVvGVvPQwucWULcAHxfFRN9aqGN9rZorp8Z0JeXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hckyaJkg/hw2TGgY+otT6b5Yj5qvlbtnKRv8z6wbL4nljKzwMeiUJv/UTmJOldTk712fm5VJrCn8i0REkQHppoYQ6QugUHR7REPtsGDNZUA26j7jgjE9Oes+cuekHEdWXeUMX+GohNk9v3zXcVUezCnnYSAuUUwI8v+eR7ArHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0XgHrbx; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0XgHrbx"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d6f9dddd99so300915ad.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789585452; x=1790190252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BH4GBJkOby79gkRrJiBJmAaYUTpDbPmazet2uAXNs6E=;
        b=d0XgHrbxMkbKjVV9b4mTG8SgFG2VvAt7hYnFUP5AGp8hilgEyauDvMwJ/V/EdtwcIw
         dmcLNCjB3/lug9NkqU6urBd7nSvZBywFALEFPvcvxTRE2V96LAHSmec3DoRfdepeKsM5
         SSlMIzPA7yJodcfsTJMkqOlMTBvU8kkOFR4gLzdxEdmEsyanAPWN193Dy1d/BAwSqd9b
         ryJ/zrCwFL8j/pyAelu02+WtTidrQt+KPyo+6PStKX5/duh1DsuD+kpwHMtavEq2Xa6j
         rAH++ipy0mvic+brc4D64GabUBkM9T9UpEYhLCb6bcafpqcq6emp+65qk1Cu4oq3hxVU
         h3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789585452; x=1790190252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BH4GBJkOby79gkRrJiBJmAaYUTpDbPmazet2uAXNs6E=;
        b=TyFGnRRRczmnURTx7gH/QZXui3llcpqoFBfpXVC/MIhyDUi0oSwiYkpcyY4iqXmkB9
         qMzp6Q8qGo20B3W7YQESKJEWu3M6I0X0XA6kAPPuLm5M+wkwfecjQ7+01kqhz6z6YWQu
         agpNkliF78JkOBhUgtsPoQiUiJ21otWxeFTT2jMJOn20TXv2WMbVMlssjzQ9en1f/pJO
         KKKWQ+fZ3L5Re0x5rKwNu9JwNhkLRKtsq1WB41S2vgtPemW8lZ96H8NcNQWCPbU1aA4p
         wjkj2mN4VLx9KsBEJUEYKAmR1ly8+iIo793Zu/ZcBxd6wWIRIZ5MDqnH5kh9r7BTA637
         VzzA==
X-Gm-Message-State: AFuF++npOYaSrU6PYy/XjRSJQzoTe9VmMqwRNNJyoScPDQg0h8Yy6lno
	3OaJgbkA25DzemZef9DcNO9fTsmfkgQXYLvlfLGxTN0a9/Fzum5ybES/o4ftrbj8
X-Gm-Gg: AYBFou10Py3VAOU3EG7r21sGTAiWVhgA92vD6VGMm+I4cKTvaQyJg77stRtt062Og2+
	hYh5xiKoSKeupHxrKN6Xlk7Je2Rcb45cqx6+CaK8WeZBmKAol1Gno5hhUdV2SuK7Uq8ToF5xVtN
	0HYuNNYl1diY094PIDgOChq6n8kusXTgCmVmufwK8+iUMOpb5nscRGMDWjkCIY2I/ebQQ0cm1t+
	4Jh5PtDKNdtGvpJapQTv8NXzkxRiydGI+B/Z8tFDjjqGUW5y0OG6GqATOl2rxGZQVJJDB7vdn0V
	RSp9GLEFXqHwEJQh81vG93BQjnc8T8OhjTLNYQzYFRDG/4t2VzSF3Eb20LX0Tcgq2NDfQIl0S/X
	gHYnWN2qKcP/f1j6o45UY/yrJRfPV63UHAxnvIW3OOEudVU1H8toP/sLu3nQGbxBqlhqalfdL4K
	0Ps8a99Vg6JdK6gAmpvFld2aS/q1HlWvsnijJxjFFwUeI7Q/+lNh8tiHUKwvGhNTF8ofCArIbDn
	RU=
X-Received: by 2002:a17:90a:e7d2:b0:398:a145:5d3d with SMTP id 98e67ed59e1d1-39e1e2daa81mr8605184a91.6.1789585452041;
        Wed, 16 Sep 2026 12:04:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e36170735sm738455a91.8.2026.09.16.12.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:04:11 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC net-next 1/6] selftests: net: py: add timestamped metric output
Date: Wed, 16 Sep 2026 12:04:04 -0700
Message-ID: <20260916190409.1222272-2-sdf@fomichev.me>
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

Add ksft_metric() to record timestamped JSON observations for the current
test case.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../testing/selftests/drivers/net/README.rst  | 27 ++++++++++++
 .../drivers/net/hw/lib/py/__init__.py         |  8 ++--
 .../selftests/drivers/net/lib/py/__init__.py  |  8 ++--
 .../testing/selftests/net/lib/py/__init__.py  |  9 ++--
 tools/testing/selftests/net/lib/py/ksft.py    | 44 ++++++++++++++++++-
 5 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index 3fe49bce4f3a..a6a8605844eb 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -259,6 +259,33 @@ ksft_pr()
 
 Use ``ksft_pr()`` instead of ``print()`` to avoid breaking TAP format.
 
+ksft_metric()
+~~~~~~~~~~~~~
+
+Use ``ksft_metric()`` to report a numeric measurement for the current test
+case. The helper records the time relative to the start of the case and emits
+each observation immediately before the test result as compact JSON. For
+example::
+
+  ksft_metric("throughput", 100.5, shape="scalar", direction="rx")
+
+emits output similar to::
+
+  # ktap-metric-json: {"direction":"rx","name":"throughput","shape":"scalar","time":1.234,"value":100.5}
+
+When ``run_kselftest.sh`` nests the test output, its diagnostic prefix makes
+this ``# # ktap-metric-json: <json>``. A background sampler can call
+``ksft_metric()`` repeatedly. Pass ``shape`` explicitly to describe the
+layout of each value. For per-CPU data, the array index is the CPU number and
+``None`` represents a missing or offline CPU::
+
+  ksft_metric("cpu.utilization", [75.0, 22.0, None, 100.0],
+              shape="per-cpu", host="local")
+
+The helper does not infer the shape from the Python value, since an array may
+represent something other than per-CPU data. Metrics are measurements only and
+do not affect the pass or fail result.
+
 ksft_disruptive
 ~~~~~~~~~~~~~~~
 
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 81e1d1865cd5..17e3daae10e2 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -27,8 +27,8 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
         wait_file, ctl_file_write, tool
     from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
-    from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
-        ksft_setup, ksft_variants, KsftNamedVariant
+    from net.lib.py import ksft_disruptive, ksft_exit, ksft_metric, ksft_pr, \
+        ksft_run, ksft_setup, ksft_variants, KsftNamedVariant
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
     from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
@@ -43,8 +43,8 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
                "wait_port_listen", "wait_file", "ctl_file_write", "tool",
                "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
-               "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
-               "ksft_setup", "ksft_variants", "KsftNamedVariant",
+               "ksft_disruptive", "ksft_exit", "ksft_metric", "ksft_pr",
+               "ksft_run", "ksft_setup", "ksft_variants", "KsftNamedVariant",
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none",
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 591b1e6c7eea..d22f36b189e4 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -27,8 +27,8 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
         wait_file, ctl_file_write
     from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
-    from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
-        ksft_setup, ksft_variants, KsftNamedVariant
+    from net.lib.py import ksft_disruptive, ksft_exit, ksft_metric, ksft_pr, \
+        ksft_run, ksft_setup, ksft_variants, KsftNamedVariant
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
 
@@ -41,8 +41,8 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
                "wait_port_listen", "wait_file", "ctl_file_write",
                "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
-               "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
-               "ksft_setup", "ksft_variants", "KsftNamedVariant",
+               "ksft_disruptive", "ksft_exit", "ksft_metric", "ksft_pr",
+               "ksft_run", "ksft_setup", "ksft_variants", "KsftNamedVariant",
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none"]
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 71df5880b356..3d9e6f6b402c 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -8,8 +8,8 @@ from .consts import KSRC
 from .ksft import KsftFailEx, KsftSkipEx, KsftXfailEx, ksft_pr, ksft_eq, \
     ksft_ne, ksft_true, ksft_not_none, ksft_in, ksft_not_in, ksft_is, \
     ksft_ge, ksft_gt, ksft_lt, ksft_raises, ksft_busy_wait, \
-    ktap_result, ksft_disruptive, ksft_setup, ksft_run, ksft_exit, \
-    ksft_variants, KsftNamedVariant
+    ktap_result, ksft_disruptive, ksft_metric, ksft_setup, ksft_run, \
+    ksft_exit, ksft_variants, KsftNamedVariant
 from .netns import NetNS, NetNSEnter, UserNetNS
 from .nsim import NetdevSim, NetdevSimDev
 from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
@@ -24,8 +24,9 @@ __all__ = ["KSRC",
            "KsftFailEx", "KsftSkipEx", "KsftXfailEx", "ksft_pr", "ksft_eq",
            "ksft_ne", "ksft_true", "ksft_not_none", "ksft_in", "ksft_not_in",
            "ksft_is", "ksft_ge", "ksft_gt", "ksft_lt", "ksft_raises",
-           "ksft_busy_wait", "ktap_result", "ksft_disruptive", "ksft_setup",
-           "ksft_run", "ksft_exit", "ksft_variants", "KsftNamedVariant",
+           "ksft_busy_wait", "ktap_result", "ksft_disruptive", "ksft_metric",
+           "ksft_setup", "ksft_run", "ksft_exit", "ksft_variants",
+           "KsftNamedVariant",
            "NetNS", "NetNSEnter", "UserNetNS",
            "CmdExitFailure", "fd_read_timeout", "cmd", "bkg", "defer",
            "bpftool", "ip", "ethtool", "bpftrace", "rand_port", "rand_ports",
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 81287c2daff0..fb0865df86c9 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -4,9 +4,11 @@ import fnmatch
 import functools
 import getopt
 import inspect
+import json
 import os
 import signal
 import sys
+import threading
 import time
 import traceback
 from collections import namedtuple
@@ -16,6 +18,9 @@ from . import utils
 KSFT_RESULT = None
 KSFT_RESULT_ALL = True
 KSFT_DISRUPTIVE = True
+KSFT_METRICS = None
+KSFT_METRICS_START = None
+KSFT_METRICS_LOCK = threading.Lock()
 
 
 class KsftFailEx(Exception):
@@ -93,6 +98,39 @@ KSFT_DISRUPTIVE = True
     print(pfx, prefixed, **kwargs)
 
 
+def ksft_metric(name, value, *, shape, **labels):
+    """Record a timestamped metric with an explicitly described shape."""
+    with KSFT_METRICS_LOCK:
+        if KSFT_METRICS is None or KSFT_METRICS_START is None:
+            raise RuntimeError("ksft_metric() called outside of a test case")
+
+        metric = {
+            "name": name,
+            "shape": shape,
+            "value": value,
+            "time": round(time.monotonic() - KSFT_METRICS_START, 6),
+        }
+        for key, label_value in sorted(labels.items()):
+            if key in metric:
+                raise ValueError(f"Metric label uses reserved name: {key}")
+            metric[key] = label_value
+        KSFT_METRICS.append(metric)
+
+
+def _ksft_flush_metrics():
+    global KSFT_METRICS, KSFT_METRICS_START
+
+    with KSFT_METRICS_LOCK:
+        metrics = KSFT_METRICS
+        KSFT_METRICS = None
+        KSFT_METRICS_START = None
+
+    for metric in metrics or []:
+        payload = json.dumps(metric, allow_nan=False, separators=(",", ":"),
+                             sort_keys=True)
+        ksft_pr(f"ktap-metric-json: {payload}")
+
+
 def _fail(*args):
     global KSFT_RESULT
     KSFT_RESULT = False
@@ -400,7 +438,7 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
 
     totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
 
-    global KSFT_RESULT
+    global KSFT_RESULT, KSFT_METRICS, KSFT_METRICS_START
     if KSFT_RESULT is not None:
         raise RuntimeError("ksft_run() can't be called multiple times.")
 
@@ -411,6 +449,9 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
     stop = False
     for func, args, name in test_cases:
         KSFT_RESULT = True
+        with KSFT_METRICS_LOCK:
+            KSFT_METRICS = []
+            KSFT_METRICS_START = time.monotonic()
         cnt += 1
         comment = ""
         cnt_key = ""
@@ -450,6 +491,7 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
         if not cnt_key:
             cnt_key = 'pass' if KSFT_RESULT else 'fail'
 
+        _ksft_flush_metrics()
         ktap_result(KSFT_RESULT, cnt, name, comment=comment)
         totals[cnt_key] += 1
 
-- 
2.53.0-Meta

