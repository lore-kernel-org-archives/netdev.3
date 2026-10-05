Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57DD3290C9
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231079; cv=none; b=RaMsO7MdniIOdKG46k00e9VzFRpgULj76YSCtT2M4LPBc0KD4pDqV2S4arS7fznEXeBRb6/BK2n+Xb6nTstd+XQBz121IEcGGuf0ETcpTVih5kKYzglQOushWxphgk5v+bq2UCAysEH8zsylcSFAMbJqBzxEev1YKM6kzyYYqBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231079; c=relaxed/simple;
	bh=pBVHLUHklUyPIhpoQIot7pPyfxQbcgmJVh8RFH0Vevw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKZbH1aCx1Q9mCL9F5YqMP0mUERTSOuOuBp45hckgOSeez4z7zH0TNXD73Em+fQ/lxtUT345CBxXzOUK3l1KVavfGtC1IJGCUW3bZlLk4QZwQe2LeRNDem9XAvF3l4ND9ZiAD0uFxalykSPK2jEtcGVzXp1OIDTpw/80vvqfFxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB+HZxh6; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB+HZxh6"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3a84a12aa97so166190a91.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791231077; x=1791835877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c2LM2pkp7GHIUrcyX55T+iGrFwKF6iXV36SsTY5/cT0=;
        b=OB+HZxh6WgpV31rYF/tMY4VR++wzJy+II82AUaWxWMGYPRdI3XDnVD/9KKC0kHpkI2
         8firYAPfJweLrMZX+Nu3RRpj029+Hio4sKD4yYacHNapTMWoIOa8wpS6Jn7sp4oBzJNm
         QIW4n0L9dAPJ2369rLPrXzdzDEwnuHZWWrqukvogolMR8bTHkIH+QidnBkr8qWMdb3u5
         Rb06XegBNuq1H5984TBC01Beh/5Z8EWvJyZ/1/qlosYkGFwjAKBaDk5psy3SPkcwcK0M
         nUYnb05DaCqo5Ed3Zt0IXnFOLcAOj0xCFUqtVppzHEJFmASlyhh6oMU2Al0gaWNlWm96
         lNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231077; x=1791835877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c2LM2pkp7GHIUrcyX55T+iGrFwKF6iXV36SsTY5/cT0=;
        b=YsZVPVCu5nRnuFeU+Ac/6Pv6DL1NM65Fz289/qn3HKmi9c5H1Ui5AZNXM7GXx6A8cb
         fFThCqCJvB5GFvT5bfDESAQwoLER6kwzGQAzbuLEakeY7WKlqF4TIpIfKPbM6s5fcso8
         ssEJhg7AVIYgGgopKDzCJow9lGvXZznXm0MFGpKgmwWyHglI4Ym8QpQ/lDhp8bZScJtv
         H0EAllfo/Ps6B6RVvcjdq6As9CRpiUdIa5erf6gvMjdk4dG180S8ofT/f84d4IbCzTY4
         pqSU+PuTcKFSxZbYupCXqFZTdcFAi1N9OV6or3eO606/CkQ//cruAFiXpxnt6mtNoJ/s
         QuYA==
X-Gm-Message-State: AFq9FYI82Eyt6M8+sxQL/WpYBydsMc1REA4wxo7PH/EUEApwmSg4dtQX
	I9Q/DVaHAUWdLMSZGcEAfYss6Kdf077CJvBjOoM+zvvT1FF2oVJlSxWrL3KSn6TI
X-Gm-Gg: AYBFou2W1+1xCmOjoA4ibxnbaXtaYGTxS2Hp4YUUPiY1YGQMkFnNVDzvE7DhtRmEj98
	ujmBaiV9Xjl5CA0QHcolDjXip/jZ6UR48eCmNdtDdI2Z/HE3Yj+E8GGbWj6XLnCkrveD89D6BlS
	8r2KvTVSAG9hLoAdCnGo996Bgm1L004abE0Ex3QVsHHmznXwi3q4jx7KWM4oAufpu7UkuoMi1pk
	psZ0ffmz4TUpFIJ39DqV0WMF45NykdA4oRo9IRFKB/8FuaX8A0SRe8BPZ/bl48AziDXUHaA7awe
	JM19NPJzxvAuGpYHkfBxz8/HmD+3KSBXWA8PoarfgYZgKCCHWWyKIBD9ZlXqt89G9CFa+UCVXRl
	5L5kdAcgnc81rz6Spo3myInotU6Inm2t74/x5ToJoq9N2o+EGL7fwf0DJ2Hwsj1juK0kiSmdNub
	JlksCZBsqgI7hP4k5hZFUCSy658zU/vGjvcVjMF+MB7+Lf/U/2XxWmAFVF1Pt4YHeJ
X-Received: by 2002:a17:90b:1c10:b0:3a0:afc9:a51a with SMTP id 98e67ed59e1d1-3a78718429bmr7493560a91.12.1791231077038;
        Mon, 05 Oct 2026 13:11:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:59::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dd1142cdsm9551437a91.2.2026.10.05.13.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:11:16 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC net-next v2 1/5] selftests: net: py: add timestamped metric output
Date: Mon,  5 Oct 2026 13:11:10 -0700
Message-ID: <20261005201115.2690830-2-sdf@fomichev.me>
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

Add ksft_metric() to record timestamped JSON observations for the current
test case.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
v1: https://lore.kernel.org/netdev/20260916190409.1222272-1-sdf@fomichev.me/
---
 .../testing/selftests/drivers/net/README.rst  | 28 +++++++++++
 .../drivers/net/hw/lib/py/__init__.py         |  8 +--
 .../selftests/drivers/net/lib/py/__init__.py  |  8 +--
 .../testing/selftests/net/lib/py/__init__.py  |  9 ++--
 tools/testing/selftests/net/lib/py/ksft.py    | 49 ++++++++++++++++++-
 5 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index 3fe49bce4f3a..3e3cc028d77a 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -259,6 +259,34 @@ ksft_pr()
 
 Use ``ksft_pr()`` instead of ``print()`` to avoid breaking TAP format.
 
+ksft_metric()
+~~~~~~~~~~~~~
+
+Use ``ksft_metric()`` to report a numeric measurement for the current test
+case. The helper records the time relative to the start of the case and emits
+each observation immediately before the test result as compact JSON. For
+example::
+
+  ksft_metric("throughput", 100.5, kind="scalar")
+
+emits output similar to::
+
+  # ktap-metric-json: {"name":"throughput","time":1.234,"type":"scalar","value":100.5}
+
+When ``run_kselftest.sh`` nests the test output, its diagnostic prefix makes
+this ``# # ktap-metric-json: <json>``. A background sampler can call
+``ksft_metric()`` repeatedly. Pass ``kind`` explicitly; it is emitted as the
+``type`` field. Supported kinds are ``scalar`` for one numeric value and
+``per-cpu`` for an array indexed by CPU number, with ``None`` for a missing or
+offline CPU::
+
+  ksft_metric("cpu.utilization", [75.0, 22.0, None, 100.0],
+              kind="per-cpu", host="local")
+
+The helper does not infer the kind from the Python value, since an array may
+represent something other than per-CPU data. Metrics are measurements only and
+do not affect the pass or fail result.
+
 ksft_disruptive
 ~~~~~~~~~~~~~~~
 
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 4077f5f1a1be..77e4ef34f8b9 100644
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
     from drivers.net.lib.py import set_ethtool_feat
@@ -44,8 +44,8 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
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
index 40ccdcf0c378..f744280dcc37 100644
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
index 81287c2daff0..1259bbb6d6c5 100644
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
@@ -93,6 +98,44 @@ KSFT_DISRUPTIVE = True
     print(pfx, prefixed, **kwargs)
 
 
+def ksft_metric(name, value, *, kind, **labels):
+    """Record a timestamped metric with an explicitly described kind.
+
+    The kind is emitted as the ``type`` field. Supported kinds are ``scalar``
+    for one numeric value and ``per-cpu`` for an array indexed by CPU number,
+    with ``None`` for a missing or offline CPU.
+    """
+    with KSFT_METRICS_LOCK:
+        if KSFT_METRICS is None or KSFT_METRICS_START is None:
+            raise RuntimeError("ksft_metric() called outside of a test case")
+
+        metric = {
+            "name": name,
+            "type": kind,
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
@@ -400,7 +443,7 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
 
     totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
 
-    global KSFT_RESULT
+    global KSFT_RESULT, KSFT_METRICS, KSFT_METRICS_START
     if KSFT_RESULT is not None:
         raise RuntimeError("ksft_run() can't be called multiple times.")
 
@@ -411,6 +454,9 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
     stop = False
     for func, args, name in test_cases:
         KSFT_RESULT = True
+        with KSFT_METRICS_LOCK:
+            KSFT_METRICS = []
+            KSFT_METRICS_START = time.monotonic()
         cnt += 1
         comment = ""
         cnt_key = ""
@@ -450,6 +496,7 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
         if not cnt_key:
             cnt_key = 'pass' if KSFT_RESULT else 'fail'
 
+        _ksft_flush_metrics()
         ktap_result(KSFT_RESULT, cnt, name, comment=comment)
         totals[cnt_key] += 1
 
-- 
2.53.0-Meta

