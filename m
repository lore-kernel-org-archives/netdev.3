Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F24DD3DE
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231082; cv=none; b=nv0rSb0NS6gCHsGoHqNfgwed7yKqpdLitvwXk5gkDv/65HdyZt7sc0Z7rULNxD9QWzaMwzprGk+vnoKYBC7atxX6VCn/heeKXiUoEqBPNxS+rcTyWlPf/rC2/4+mZOl6+imZ1khjtUmbW0uZH/d0Fwidokorz7hOmkoXHKWDR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231082; c=relaxed/simple;
	bh=kDDq52QhcN6gOoA1x8WMnHSymnI0wwiZR1gR/QjrnHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sv6daJPyhxZtO06HcbR5OePPlbcfzMsuCuR4rE5xn0xevgkrzhYOPKN/cJ9QM623WpXZNesgacz+7vnK6mby+F868yQnKMCCFsIQW+bGhHRaNBJYYbliZx/MeuGfg3sq1SIpHzQjE3VSVJbM2ZrjAwEwXiQDeIOcFC3Zt+30Ck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTO52PW+; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTO52PW+"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-39569e136f9so542069a91.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791231078; x=1791835878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PY1YAY3LPCJbAJGZdwIvNZOOIF3ZebaSadsZgAuphD0=;
        b=FTO52PW+Uxg4Dp44AC+m6FVD30tZ9CB/8w87Rbabt8Yqlya6LI7o8kHTz0X8FM/1uW
         w1941YEZNs7DnUQJKblgJbLrSq23u/RwBx7cxSFKh2dRtsAjJlZYXtOE2vOxiRmEiRrv
         sYQaDIXNQX3ygOUQ/ZJCnRormLF/pqR/Vnhw04wYP/6gTuLZQy8MErsFhfU+YF04EdGY
         xcTHiswHU2MV5FuEC+fB3xX9DIlgFhUm1QER1Tq3bn0pwLLoUcMc+ponFIdYIdZdy33y
         4wdOQ8fTrbPDwXJ/6E8CvxZIe5NE5Ag+TWSJZkJbBt6JTI833F55LhhA0fbTltekJ4Xh
         4bTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231078; x=1791835878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PY1YAY3LPCJbAJGZdwIvNZOOIF3ZebaSadsZgAuphD0=;
        b=fh4edDWeCmZvg2ALF8ASeRKcWEe25KxEwjxsGwltuZ4OPycupcvGlzAgb7iJBcBVpG
         8bOwKp/ZoPQL503ECTeksy0p5+GiK6EvPWfcU0zvbJQ+VykuojOpqJAc2r9dPAE50hd1
         OdiaoBmjEgV7SqDCx5dX8DiE78IttJ0vljDtnZKDyy5HiLu0uvWolCPty06OWPMIPNPh
         9EfTJiS7TBS2TNleJbatgCnrQOchPqgSECVn0V0CsHWQMdBRv2fdS+OSi4pcORJDt4P+
         oOMemhfsnhEIvaHTW4quTZesnApgGQGdu90M11WmiBq2vDQNLU7SwShD8HgUYaEzKuHt
         ZaMA==
X-Gm-Message-State: AFq9FYKbjdPKsAvFjZqPh7lNDVccEEvniG9fqAygm0l+6BL/puHI5yNS
	BG0AERY375/Kk5yNF/n3aODWDKs+Disy9TYVTLrTXY5VzgjaS4iRYFtUTQYcU6lq
X-Gm-Gg: AYBFou2I8BRLx8Eq29PFeFH6w0/AvPbq8L57hgmbaqmLSOxBWK351HmSOusWKQrb/fe
	n/HX2kdgw7+TKpz5tYqMNnSYJY5DRL9W/fT4RMeXhGovwGzZRpVqAnSxnv+5ML2SHh/UW7IE0wn
	qwqJRUJ4gjQDF7BddWreLrZYFKdN0uar/yTnOkNHL77cq4qxwSCr35rHiCoAJ00oyu/8UOuMpG9
	klZoYYL9gqvwnjRBD0ehydeEPn0qgbu3dbwxF7H2xweVVpo94MAtAhcbCLF8RkQiirep8hRFFVE
	XfTpg4Qw1m7MOSyrtC5aKHDprquXAHg3kLsFD2waLupUlhRh57pGH7EBUmXZnFtBNlyzLlZDLB3
	MbJQg95/oG60DwwNb+rafWy8IKmCJoYu4UUm524ybdMGVo1IU85CQyj7/hur1s5UolQor+jQIZf
	2neInzNuVRtAudWluDZbvJxVwaBDX5k4XD+KxuwxembgYy697V20hkHMeGOP0TAmHW
X-Received: by 2002:a17:90b:3c51:b0:3a7:e126:4980 with SMTP id 98e67ed59e1d1-3a7e1264b20mr3211793a91.43.1791231078078;
        Mon, 05 Oct 2026 13:11:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a79e7c243csm5960515a91.0.2026.10.05.13.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:11:17 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC net-next v2 2/5] selftests: net: py: add metric policy output
Date: Mon,  5 Oct 2026 13:11:11 -0700
Message-ID: <20261005201115.2690830-3-sdf@fomichev.me>
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

Add ksft_metric_policy() so producers can describe metric processing,
display, and regression policy without name-specific consumer logic.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../testing/selftests/drivers/net/README.rst  |  21 ++++
 .../drivers/net/hw/lib/py/__init__.py         |  11 +-
 .../selftests/drivers/net/lib/py/__init__.py  |  11 +-
 .../testing/selftests/net/lib/py/__init__.py  |   6 +-
 tools/testing/selftests/net/lib/py/ksft.py    | 114 +++++++++++++++++-
 5 files changed, 151 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index 3e3cc028d77a..1b7264d40b79 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -287,6 +287,27 @@ The helper does not infer the kind from the Python value, since an array may
 represent something other than per-CPU data. Metrics are measurements only and
 do not affect the pass or fail result.
 
+ksft_metric_policy()
+~~~~~~~~~~~~~~~~~~~~
+
+Use ``ksft_metric_policy()`` before the first matching observation to
+register processing, display, and regression policy for a metric. The policy
+is emitted once per test case rather than repeated in every observation. For
+example::
+
+  ksft_metric_policy("nic.rx.dropped", summarize="max",
+                     transform="rate", display_range={"min": 0})
+  ksft_metric("nic.rx.dropped", 0, kind="scalar", host="local")
+
+emits separate policy and observation records::
+
+  # ktap-metric-policy-json: {"display_range":{"min":0},"name":"nic.rx.dropped","summarize":"max","transform":"rate"}
+  # ktap-metric-json: {"host":"local","name":"nic.rx.dropped","time":1.234,"type":"scalar","value":0}
+
+Consumers apply a policy to observations with the same metric name. The
+function docstring documents the supported summary, transform, aggregation,
+regression, and display options.
+
 ksft_disruptive
 ~~~~~~~~~~~~~~~
 
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 77e4ef34f8b9..cd771c00c074 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -27,8 +27,9 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
         wait_file, ctl_file_write, tool
     from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
-    from net.lib.py import ksft_disruptive, ksft_exit, ksft_metric, ksft_pr, \
-        ksft_run, ksft_setup, ksft_variants, KsftNamedVariant
+    from net.lib.py import ksft_disruptive, ksft_exit, ksft_metric, \
+        ksft_metric_policy, ksft_pr, ksft_run, ksft_setup, \
+        ksft_variants, KsftNamedVariant
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
     from drivers.net.lib.py import set_ethtool_feat
@@ -44,8 +45,10 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
                "wait_port_listen", "wait_file", "ctl_file_write", "tool",
                "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
-               "ksft_disruptive", "ksft_exit", "ksft_metric", "ksft_pr",
-               "ksft_run", "ksft_setup", "ksft_variants", "KsftNamedVariant",
+               "ksft_disruptive", "ksft_exit", "ksft_metric",
+               "ksft_metric_policy", "ksft_pr", "ksft_run",
+               "ksft_setup", "ksft_variants",
+               "KsftNamedVariant",
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none",
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index f744280dcc37..58c2877e7928 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -27,8 +27,9 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
         wait_file, ctl_file_write
     from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
-    from net.lib.py import ksft_disruptive, ksft_exit, ksft_metric, ksft_pr, \
-        ksft_run, ksft_setup, ksft_variants, KsftNamedVariant
+    from net.lib.py import ksft_disruptive, ksft_exit, ksft_metric, \
+        ksft_metric_policy, ksft_pr, ksft_run, ksft_setup, \
+        ksft_variants, KsftNamedVariant
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
 
@@ -41,8 +42,10 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
                "wait_port_listen", "wait_file", "ctl_file_write",
                "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
-               "ksft_disruptive", "ksft_exit", "ksft_metric", "ksft_pr",
-               "ksft_run", "ksft_setup", "ksft_variants", "KsftNamedVariant",
+               "ksft_disruptive", "ksft_exit", "ksft_metric",
+               "ksft_metric_policy", "ksft_pr", "ksft_run",
+               "ksft_setup", "ksft_variants",
+               "KsftNamedVariant",
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none"]
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 3d9e6f6b402c..db25602e4d57 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -8,7 +8,8 @@ from .consts import KSRC
 from .ksft import KsftFailEx, KsftSkipEx, KsftXfailEx, ksft_pr, ksft_eq, \
     ksft_ne, ksft_true, ksft_not_none, ksft_in, ksft_not_in, ksft_is, \
     ksft_ge, ksft_gt, ksft_lt, ksft_raises, ksft_busy_wait, \
-    ktap_result, ksft_disruptive, ksft_metric, ksft_setup, ksft_run, \
+    ktap_result, ksft_disruptive, ksft_metric, ksft_metric_policy, \
+    ksft_setup, ksft_run, \
     ksft_exit, ksft_variants, KsftNamedVariant
 from .netns import NetNS, NetNSEnter, UserNetNS
 from .nsim import NetdevSim, NetdevSimDev
@@ -25,7 +26,8 @@ __all__ = ["KSRC",
            "ksft_ne", "ksft_true", "ksft_not_none", "ksft_in", "ksft_not_in",
            "ksft_is", "ksft_ge", "ksft_gt", "ksft_lt", "ksft_raises",
            "ksft_busy_wait", "ktap_result", "ksft_disruptive", "ksft_metric",
-           "ksft_setup", "ksft_run", "ksft_exit", "ksft_variants",
+           "ksft_metric_policy", "ksft_setup", "ksft_run",
+           "ksft_exit", "ksft_variants",
            "KsftNamedVariant",
            "NetNS", "NetNSEnter", "UserNetNS",
            "CmdExitFailure", "fd_read_timeout", "cmd", "bkg", "defer",
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 1259bbb6d6c5..79cbdb6d98fe 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -20,6 +20,7 @@ KSFT_RESULT_ALL = True
 KSFT_DISRUPTIVE = True
 KSFT_METRICS = None
 KSFT_METRICS_START = None
+KSFT_METRIC_POLICIES = None
 KSFT_METRICS_LOCK = threading.Lock()
 
 
@@ -98,6 +99,104 @@ KSFT_METRICS_LOCK = threading.Lock()
     print(pfx, prefixed, **kwargs)
 
 
+def ksft_metric_policy(name, summarize="total", *, aggregation=None,
+                       transform=None, regression=None,
+                       display_range=None, display_scale=None,
+                       display_label=None):
+    """Register processing and presentation metadata for a metric.
+
+    The policy applies to every observation with ``name`` in the current test
+    case. It is emitted once as a ``ktap-metric-policy-json`` record before
+    the matching ``ktap-metric-json`` observations, so a consumer can process
+    the metric without recognizing its name. Register a policy before the
+    first matching :func:`ksft_metric` call. Registering the same policy more
+    than once is allowed; changing it or registering it after an observation
+    is rejected.
+
+    Args:
+        name: Metric name passed to :func:`ksft_metric`.
+        transform: Optional operation applied before aggregation and summary.
+            ``rate`` calculates ``(current - previous) / elapsed_time`` from
+            timestamped cumulative observations. Counter decreases and
+            intervals with nonpositive elapsed time do not produce a rate.
+        aggregation: Optional operation applied to each transformed
+            observation before summarization. An aggregation may reduce a
+            structured value, such as an array, to a scalar.
+            ``busy-core-equivalents`` expects a CPU-indexed array and sums
+            transformed per-CPU rates. Without a transform, it treats values
+            as percentages and divides their sum by 100. The resulting series
+            measures concurrently busy cores.
+        summarize: Operation used to reduce the processed observations.
+            Supported values are ``last``, ``total``, ``max``, and ``pXX``,
+            where ``XX`` is the requested percentile. The default is
+            ``total``.
+        regression: Optional regression-tracking policy dictionary:
+
+            ``compare``
+                Summary operation to compare: ``last``, ``total``, ``max``,
+                or ``pXX``, where ``XX`` is the requested percentile. This is
+                independent of the summary selected for display.
+            ``better``
+                ``higher`` or ``lower``, indicating which direction is an
+                improvement.
+            ``relative_tolerance``
+                Optional nonnegative fractional deterioration, for example
+                ``0.05`` for five percent.
+            ``absolute_tolerance``
+                Optional nonnegative deterioration in the processed metric's
+                native units. At least one tolerance is required; consumers
+                use the larger allowance when both are present.
+
+            The producer describes comparison semantics, while the consumer
+            selects historical baselines and determines regression status.
+        display_range: Optional graph range dictionary containing ``min``,
+            ``max``, or both. It describes displayed individual series. An
+            upper bound does not cap a post-aggregation total such as multiple
+            busy-core equivalents.
+        display_scale: Optional positive multiplier applied only when values
+            are displayed, after transformation. It does not alter stored
+            observations, aggregation, summaries, or regression comparison.
+        display_label: Optional nonempty axis label for displayed values.
+
+    Example::
+
+        ksft_metric_policy(
+            "cpu.time.usr", summarize="p90", transform="rate",
+            aggregation="busy-core-equivalents",
+            display_range={"min": 0, "max": 100},
+            display_scale=100,
+            display_label="Percent of one CPU")
+
+    Raises:
+        RuntimeError: If called outside a test case or after a matching metric.
+        ValueError: If the policy conflicts with an earlier registration.
+    """
+    metadata = {"summarize": summarize}
+    optional = {
+        "aggregation": aggregation,
+        "transform": transform,
+        "regression": regression,
+        "display_range": display_range,
+        "display_scale": display_scale,
+        "display_label": display_label,
+    }
+    metadata.update({key: value for key, value in optional.items()
+                     if value is not None})
+
+    with KSFT_METRICS_LOCK:
+        if KSFT_METRIC_POLICIES is None:
+            raise RuntimeError(
+                "ksft_metric_policy() called outside of a test case")
+        previous = KSFT_METRIC_POLICIES.get(name)
+        if previous is not None and previous != metadata:
+            raise ValueError(f"Conflicting policy for metric {name}")
+        if previous is None and any(metric["name"] == name
+                                    for metric in KSFT_METRICS):
+            raise RuntimeError(
+                f"Policy registered after metric {name} was recorded")
+        KSFT_METRIC_POLICIES[name] = metadata
+
+
 def ksft_metric(name, value, *, kind, **labels):
     """Record a timestamped metric with an explicitly described kind.
 
@@ -123,13 +222,23 @@ KSFT_METRICS_LOCK = threading.Lock()
 
 
 def _ksft_flush_metrics():
-    global KSFT_METRICS, KSFT_METRICS_START
+    global KSFT_METRICS, KSFT_METRICS_START, KSFT_METRIC_POLICIES
 
     with KSFT_METRICS_LOCK:
         metrics = KSFT_METRICS
+        policies = KSFT_METRIC_POLICIES
         KSFT_METRICS = None
         KSFT_METRICS_START = None
+        KSFT_METRIC_POLICIES = None
 
+    metric_names = {metric["name"] for metric in metrics or []}
+    for name, metadata in (policies or {}).items():
+        if name not in metric_names:
+            continue
+        policy = {"name": name, **metadata}
+        payload = json.dumps(policy, allow_nan=False, separators=(",", ":"),
+                             sort_keys=True)
+        ksft_pr(f"ktap-metric-policy-json: {payload}")
     for metric in metrics or []:
         payload = json.dumps(metric, allow_nan=False, separators=(",", ":"),
                              sort_keys=True)
@@ -443,7 +552,7 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
 
     totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
 
-    global KSFT_RESULT, KSFT_METRICS, KSFT_METRICS_START
+    global KSFT_RESULT, KSFT_METRICS, KSFT_METRICS_START, KSFT_METRIC_POLICIES
     if KSFT_RESULT is not None:
         raise RuntimeError("ksft_run() can't be called multiple times.")
 
@@ -457,6 +566,7 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
         with KSFT_METRICS_LOCK:
             KSFT_METRICS = []
             KSFT_METRICS_START = time.monotonic()
+            KSFT_METRIC_POLICIES = {}
         cnt += 1
         comment = ""
         cnt_key = ""
-- 
2.53.0-Meta

