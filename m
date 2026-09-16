Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2A449A3DC
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585481; cv=none; b=LSk27eTmTLnWSYYVRRY14vaauLurh8ayYNwtPuLbfJ/42lBzoJ3JiWMsqtewqHHG00fyTuojYEryUqtmP5KFwdbWg59tcymuZbMgBsSfWvfGeSyLku/jsSEncUf6RU6dOWXEZNAesF4NnqXuXfAzZOKmq54vVYjkVfUU8eDMkkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585481; c=relaxed/simple;
	bh=nSnk95aaIvGN+f13rbAEJ3+ZaZ0JxU2Lv0Wux32/gHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CG0aTE7iwKue0YnMW6u8r+PxfLXK8Fx5fvgr6JDLij7UzFa4wr9BMWIPwRwXgW/zQ95RM5a6mx4yDLX992BzDyGC0mR4GDNoKjJj88XPrJfK8zJxZRoEOo118gYhlKsro8X4EUF6R9HjDMH/7LaCGg/qknnFQdRLo4Z7ELkXu6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNgW4hbZ; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNgW4hbZ"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2dd8923e7abso482145ad.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789585454; x=1790190254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LaX3CRlRUq/4sg4AuqF0kOVU3P/TIIR3wKi3rCFJ4fw=;
        b=SNgW4hbZLwDivBzFZE9R3TuoCBEinpqp23VZQrOopiiRo3rbnabcateIYi7Ac9gRIm
         u1nIWeHuLSB8nX2GYsBTl7OuyMVE2HL4dY0APAd+YypEMHKb9AZrOKg3OLPXJ8AFpw/b
         lybtWMSzOPGYElPt0iLWL80jR0RNDGjrZJYcfadovNnalDBblj9vjWiEjUC6FFqycBx7
         LpgI5hAM3pEkh/xxVI/RthhiNrRvs0RfeVCpo4MwWlNf48lsdBpmN9jNpj34O+1m5eXF
         diDY14AcEv+31loQ9MU1Lux0LaGsPLRK4FNNenZ8RhcoC0kgUkUhwNxgUu/0LfPYmYkz
         NKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789585454; x=1790190254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LaX3CRlRUq/4sg4AuqF0kOVU3P/TIIR3wKi3rCFJ4fw=;
        b=AGZTe5XK77Y+mewoKB0Jw6/KU3tWBUgdTgVOOzeFh2C4jUJEosYLv+Th6dtAlf0qoH
         4Rf6YUfFc3OnlVH11RWO127IChNUhY+ddv017QbisVRKzo5KEdW16WoxXPKzZrLiw26o
         A9kI7lwSLd5VnYj/XhAUlSgVGJibZC5csJtYozi/jOejUhQxNPK3Tl7FIaEPeVE4J09+
         fxkfn5OPMlemnzBB+dEMTRaRn0HbQ61QHeVvRE5VsW/hmQT+JBlSapHKzGsjHsD84XHZ
         oD1mw5c1qQ8zyY2hYLN2Q/wysuBVtsFdcV8lpV1X/xVCHW6Boyif1NkAjdOhQGjQ6aS8
         LrqA==
X-Gm-Message-State: AFuF++m/Fa6XaGCdX6T5J1WFfK06kd91VC6aX+ZaoQmutrVGRsG+LePj
	ZEqHh3UoEOlDd0GKE6yPHczxGdvc1G4AgZ+hckxfalC+n2HE5g/r1WiTNGH+sj1q
X-Gm-Gg: AYBFou2h51XOMNc7kghV4NpacbBi6dclBg2dq96WZtA51e9UsMcL0+3ALBTbxaLolOU
	lOBE8FRKp757swNVwTN9KdMWO3v36QUtmDZgIuK1Roh8Qvt3scRHWlRSZs/NW4b25acMdoKlA0T
	hGU7x68Arza6+MU+0TsNzHRS4wpuq2RPy9ulTFOXJsAQ0s0qdO+6PjNhAn6DolWYKwKkNOicGwh
	dCgR3APXlNHz4zpXdQAcvtf1QrtHIa3arrg9Y9M/2TH6w3eIOyfHdvRqjmdxX9180EC0so7QPnU
	Rzm+ASen7qjLju1CSvXItl3f1TqsjYtuVRW0C4WdM33eMD4RvHe0gJMsAgWOfaiLnI0DWXepjYI
	IqfdPDHgZasDZEkN3ys+SFntdIOUrBkbZzbuETM5PFLFSeOtu0qOGGkDVsN06sVPGk93eMdAjQF
	qQDnhWeWVwpZ/z0IIbhJ4aAhnekHispJJ2tIHx9bZa6C0dlunnFWsla3a9EW2a2LBliQmfdzfa4
	Q==
X-Received: by 2002:a17:903:22cb:b0:2d7:1cee:3682 with SMTP id d9443c01a7336-2dd8dbf3be9mr77412905ad.5.1789585453032;
        Wed, 16 Sep 2026 12:04:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f249acsm16644425ad.79.2026.09.16.12.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:04:12 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC net-next 2/6] selftests: net: py: add metric policy output
Date: Wed, 16 Sep 2026 12:04:05 -0700
Message-ID: <20260916190409.1222272-3-sdf@fomichev.me>
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

Add ksft_metric_aggregate() to publish processing and display policy
without tying consumers to metric names. Emit each policy once and reject
conflicting or late registration.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../testing/selftests/drivers/net/README.rst  |  21 ++++
 .../drivers/net/hw/lib/py/__init__.py         |  11 +-
 .../selftests/drivers/net/lib/py/__init__.py  |  11 +-
 .../testing/selftests/net/lib/py/__init__.py  |   6 +-
 tools/testing/selftests/net/lib/py/ksft.py    | 114 +++++++++++++++++-
 5 files changed, 152 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index a6a8605844eb..03373d6cecb0 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -286,6 +286,27 @@ The helper does not infer the shape from the Python value, since an array may
 represent something other than per-CPU data. Metrics are measurements only and
 do not affect the pass or fail result.
 
+ksft_metric_aggregate()
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Use ``ksft_metric_aggregate()`` before the first matching observation to
+register processing, display, and regression policy for a metric. The policy
+is emitted once per test case rather than repeated in every observation. For
+example::
+
+  ksft_metric_aggregate("nic.rx.dropped", summarize="distribution",
+                        transform="rate", display_range={"min": 0})
+  ksft_metric("nic.rx.dropped", 0, shape="scalar", host="local")
+
+emits separate policy and observation records::
+
+  # ktap-metric-policy-json: {"display_range":{"min":0},"name":"nic.rx.dropped","summarize":"distribution","transform":"rate"}
+  # ktap-metric-json: {"host":"local","name":"nic.rx.dropped","shape":"scalar","time":1.234,"value":0}
+
+Consumers apply a policy to observations with the same metric name. The
+function docstring documents the supported summary, transform, aggregation,
+regression, and display options.
+
 ksft_disruptive
 ~~~~~~~~~~~~~~~
 
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 17e3daae10e2..349647c2307d 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -27,8 +27,9 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
         wait_file, ctl_file_write, tool
     from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
-    from net.lib.py import ksft_disruptive, ksft_exit, ksft_metric, ksft_pr, \
-        ksft_run, ksft_setup, ksft_variants, KsftNamedVariant
+    from net.lib.py import ksft_disruptive, ksft_exit, ksft_metric, \
+        ksft_metric_aggregate, ksft_pr, ksft_run, ksft_setup, \
+        ksft_variants, KsftNamedVariant
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
     from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
@@ -43,8 +44,10 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
                "wait_port_listen", "wait_file", "ctl_file_write", "tool",
                "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
-               "ksft_disruptive", "ksft_exit", "ksft_metric", "ksft_pr",
-               "ksft_run", "ksft_setup", "ksft_variants", "KsftNamedVariant",
+               "ksft_disruptive", "ksft_exit", "ksft_metric",
+               "ksft_metric_aggregate", "ksft_pr", "ksft_run",
+               "ksft_setup", "ksft_variants",
+               "KsftNamedVariant",
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none",
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index d22f36b189e4..afad9d5392ca 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -27,8 +27,9 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
         wait_file, ctl_file_write
     from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
-    from net.lib.py import ksft_disruptive, ksft_exit, ksft_metric, ksft_pr, \
-        ksft_run, ksft_setup, ksft_variants, KsftNamedVariant
+    from net.lib.py import ksft_disruptive, ksft_exit, ksft_metric, \
+        ksft_metric_aggregate, ksft_pr, ksft_run, ksft_setup, \
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
+               "ksft_metric_aggregate", "ksft_pr", "ksft_run",
+               "ksft_setup", "ksft_variants",
+               "KsftNamedVariant",
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none"]
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 3d9e6f6b402c..21d89ae76b49 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -8,7 +8,8 @@ from .consts import KSRC
 from .ksft import KsftFailEx, KsftSkipEx, KsftXfailEx, ksft_pr, ksft_eq, \
     ksft_ne, ksft_true, ksft_not_none, ksft_in, ksft_not_in, ksft_is, \
     ksft_ge, ksft_gt, ksft_lt, ksft_raises, ksft_busy_wait, \
-    ktap_result, ksft_disruptive, ksft_metric, ksft_setup, ksft_run, \
+    ktap_result, ksft_disruptive, ksft_metric, ksft_metric_aggregate, \
+    ksft_setup, ksft_run, \
     ksft_exit, ksft_variants, KsftNamedVariant
 from .netns import NetNS, NetNSEnter, UserNetNS
 from .nsim import NetdevSim, NetdevSimDev
@@ -25,7 +26,8 @@ __all__ = ["KSRC",
            "ksft_ne", "ksft_true", "ksft_not_none", "ksft_in", "ksft_not_in",
            "ksft_is", "ksft_ge", "ksft_gt", "ksft_lt", "ksft_raises",
            "ksft_busy_wait", "ktap_result", "ksft_disruptive", "ksft_metric",
-           "ksft_setup", "ksft_run", "ksft_exit", "ksft_variants",
+           "ksft_metric_aggregate", "ksft_setup", "ksft_run",
+           "ksft_exit", "ksft_variants",
            "KsftNamedVariant",
            "NetNS", "NetNSEnter", "UserNetNS",
            "CmdExitFailure", "fd_read_timeout", "cmd", "bkg", "defer",
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index fb0865df86c9..f0cbc7307117 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -20,6 +20,7 @@ KSFT_RESULT_ALL = True
 KSFT_DISRUPTIVE = True
 KSFT_METRICS = None
 KSFT_METRICS_START = None
+KSFT_METRIC_AGGREGATES = None
 KSFT_METRICS_LOCK = threading.Lock()
 
 
@@ -98,6 +99,105 @@ KSFT_METRICS_LOCK = threading.Lock()
     print(pfx, prefixed, **kwargs)
 
 
+def ksft_metric_aggregate(name, summarize="total", *, aggregation=None,
+                          transform=None, regression=None,
+                          display_range=None, display_scale=None,
+                          display_label=None):
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
+        summarize: Operation used to reduce the processed observations.
+            Supported values are ``last``, ``total``, ``p50``, ``p90``,
+            ``p99``, ``max``, and ``distribution``. ``distribution`` keeps
+            ``last`` for one scalar observation and produces p50, p90, p99,
+            and max for sampled observations. The default is ``total``.
+        aggregation: Optional operation applied to each transformed
+            observation before summarization. An aggregation may reduce a
+            structured value, such as an array, to a scalar.
+            ``busy-core-equivalents`` expects a CPU-indexed array and sums
+            transformed per-CPU rates. Without a transform, it treats values
+            as percentages and divides their sum by 100. The resulting series
+            measures concurrently busy cores.
+        transform: Optional operation applied before aggregation and summary.
+            ``rate`` calculates ``(current - previous) / elapsed_time`` from
+            timestamped cumulative observations. Counter decreases and
+            intervals with nonpositive elapsed time do not produce a rate.
+        regression: Optional regression-tracking policy dictionary:
+
+            ``compare``
+                Summary operation to compare: ``last``, ``total``, ``p50``,
+                ``p90``, ``p99``, or ``max``. This is independent of the
+                summaries selected for display.
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
+        ksft_metric_aggregate(
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
+        if KSFT_METRIC_AGGREGATES is None:
+            raise RuntimeError(
+                "ksft_metric_aggregate() called outside of a test case")
+        previous = KSFT_METRIC_AGGREGATES.get(name)
+        if previous is not None and previous != metadata:
+            raise ValueError(f"Conflicting aggregation for metric {name}")
+        if previous is None and any(metric["name"] == name
+                                    for metric in KSFT_METRICS):
+            raise RuntimeError(
+                f"Aggregation registered after metric {name} was recorded")
+        KSFT_METRIC_AGGREGATES[name] = metadata
+
+
 def ksft_metric(name, value, *, shape, **labels):
     """Record a timestamped metric with an explicitly described shape."""
     with KSFT_METRICS_LOCK:
@@ -118,13 +218,23 @@ KSFT_METRICS_LOCK = threading.Lock()
 
 
 def _ksft_flush_metrics():
-    global KSFT_METRICS, KSFT_METRICS_START
+    global KSFT_METRICS, KSFT_METRICS_START, KSFT_METRIC_AGGREGATES
 
     with KSFT_METRICS_LOCK:
         metrics = KSFT_METRICS
+        aggregates = KSFT_METRIC_AGGREGATES
         KSFT_METRICS = None
         KSFT_METRICS_START = None
+        KSFT_METRIC_AGGREGATES = None
 
+    metric_names = {metric["name"] for metric in metrics or []}
+    for name, metadata in (aggregates or {}).items():
+        if name not in metric_names:
+            continue
+        policy = {"name": name, **metadata}
+        payload = json.dumps(policy, allow_nan=False, separators=(",", ":"),
+                             sort_keys=True)
+        ksft_pr(f"ktap-metric-policy-json: {payload}")
     for metric in metrics or []:
         payload = json.dumps(metric, allow_nan=False, separators=(",", ":"),
                              sort_keys=True)
@@ -439,6 +549,7 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
     totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
 
     global KSFT_RESULT, KSFT_METRICS, KSFT_METRICS_START
+    global KSFT_METRIC_AGGREGATES
     if KSFT_RESULT is not None:
         raise RuntimeError("ksft_run() can't be called multiple times.")
 
@@ -452,6 +563,7 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
         with KSFT_METRICS_LOCK:
             KSFT_METRICS = []
             KSFT_METRICS_START = time.monotonic()
+            KSFT_METRIC_AGGREGATES = {}
         cnt += 1
         comment = ""
         cnt_key = ""
-- 
2.53.0-Meta

