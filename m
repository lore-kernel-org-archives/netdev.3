Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646510;
	b=vALSAgfmDF68JI8JWPrFPWU0WUwhvdswiCmr9iolLg5i2N+pm9hnU8/BY3XAhrcNekKB
	 43Y4An3y00HdizxQIBPs4rhxoxsGf+b29WTdKSm0VbSC9uRoLi2QQEyHmSA3rzKwbhZxX
	 UCoXPQ3XFAASUdPVMN59F/C69ozNbshrkudHqRrojs6kBNdQ89PYqFFLqD8rvOh2ofnPC
	 Us07Q4w1XjrV7UgzLkGK3PPIXJknzznHhuD6AZTKpLb3Lkb+A8Sk+iIiqhxxlo2dUGxCM
	 CAo5YBqgbmxqwMdNyhBFpWHW5FjuFzmrSNlyg+3Z8JXHfsBZjQR000H/uuiTFk7WloQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4cR148pTaAKqSFAPEU1G+ActSQ1o680y1psWvOcIEFY=;
	b=QVN4CW6rQ1CH1QVcgxIh4fjCtkX6HQUao2JpoHk9M0Ve2gfCf00R/OJir+ZrDcVXtpFd
	 biWRFwcsdiGFnbSYg+9yFRzbJkmirVH0JQdGlV/1AEtdvGXcsYhFaLEwhSSNqxLQUClPU
	 1kiII6q48RReNodJ90vdagoBhLm/pQiD+jPu0pIfzGff8x4IYV7YLTlALWFkKQ3bnu8gj
	 54CkegW3dYUg2RhXyoccRw5nOq4gpu6Y9TJ/W9okxbsxojTYWrLaCZDnp87U+1C/PDIZH
	 5/EuoBVBHdv9wBi6bM+lnGZSV14/nPIO/aQ2U1/AwuiULqctb2kfZBuPzh3+C/l04SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g5L30llJ;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A79606D825
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90A79606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g5L30llJ
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-19305bcb6d5so899796c88.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646510; x=1794251310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4cR148pTaAKqSFAPEU1G+ActSQ1o680y1psWvOcIEFY=;
        b=g5L30llJ2en7oidN+Mzkz1lAmNbs3YpMcVmiXNFu15Nxg1TkjlXFfybxjKSv22WPeT
         ELC7GxO2pg9HRyJ5oN7cveifmt9J9HIv5Q15D+oFBLk+e8+XxN9dy650XSxoNKpLhfeb
         K8znUub6ne6h0V+SZvdjWLq61MY13Zs9r0ceQUFNqSLZpHnC7tHsCZ/sgfuZFYTfKcjg
         nA2kfOIqT1Qm1xlDTem+03nod8wdf291ElvmhPztKcCtBdsmooDdwtD64ssh6IKiEkgw
         JZJBX+baNgj7grYtTqm8LUqDLysDMJETcc5H3wkqCCUmRM+Tfcki29BGg6RAM6hFC4qX
         VeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646510; x=1794251310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4cR148pTaAKqSFAPEU1G+ActSQ1o680y1psWvOcIEFY=;
        b=tTFX2K0xiFpWEOGZ5qckL7D6L9fHGBv+qWoXtRTi0bAUKiaXMKs+ZvVj1PsIGrRQsn
         DY8F+96EvthdWbUBzBLEtEDLoF/l5+2FU2Xwg5UGwHr3jWC+LZTmgUdpjPEpEjA+h35l
         hRX/Pe3C65hrYPLF1HvooCJLM/zG7HoRRacM1wD148d+5zKuGnV/L0kIpsFhbMxNjA6T
         YAvA1H6z7dignX1c4thW4hQ/6SBAFdonR3qKMvnP2+6Tz6CBXC5Cz4v5QN0j1fMPrI4l
         6SV3NSvd2DXpZqOn6mVvXeOPeagodah6rrQykeHKpI3WV9PrUoTArqV260faj09BYmRX
         fGWQ==
X-Gm-Message-State: AFq9FYJlCEbmeELZsWgsiRRbkmLqWWBb3f8l19YJW5RNNDo01P0oCh4j
	40vtRTIIriAqasHP3eoQirXKotR85Hpir4fwVnCqrqrt96g+ddEVN9yAvJJ6ecdw
X-Gm-Gg: AYBFou0d51HXdHU+V/ig4kiUdI4KQBWPhW+pa5yhC+nh+l7NDfqXqVliDaXFmJKrjBf
	oBjQ7hOVLvBWHZbx1flkOt1si8N82bexk1FdCb9X+Mu8bneySyZ1LCY1b5MTJKD46IM1OWmz8Wk
	dzsMW5wk9ByVNkW8Ht9CN1//2t2se83qstNf3PPlmu/HIGNJ82wMCPhTRN4333jjtiBQJB6aQZh
	f7M1PUc2D+8/i84u1pxEk+HPYl1Q/jRr0aMrpa4kMDAP43B7yufT2D8kogpL+MR3q6ULuLVxNAC
	G/U5JT8LNlI+5P5VO6l8jL6lOCMioznrnCwDM/ehtqMpDZwnoTGAVY5hWRWI8NT56J4aDKiGFCO
	T3EaG/Xzp8AFVbYaOhsKsE7vaRFLHYDV+XmsXJL4iU/EmZ4Wuj8+jdyHXbdS/8BvkXumRCBBVqC
	AXBkG+cxQIMqb9CrHXuMjEdez0ghY9bShidUujRHCE5wtmS/A7qaRQZhyUz0fgchMwAiMR6vWcJ
	SYNWVsyL5ZascDd7M22KODB/Fbl5WLaIz2iLvXA04dIf3K3kpzdjUyrirwBoo5m/iMy9V1Qf0aY
	UxcJMgOVTdl4HzgAs4vhcmE=
X-Received: by 2002:a05:7022:1108:b0:165:90af:a25f with SMTP id a92af1059eb24-1ac60792334mr15502671c88.41.1793646509450;
        Mon, 02 Nov 2026 11:08:29 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:65::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b106edc7f8sm18744469c88.9.2026.11.02.11.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:08:29 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v3 1/4] selftests: net: py: add metric output
Date: Mon,  2 Nov 2026 11:08:24 -0800
Message-ID: <20261102190827.989117-2-sdf@fomichev.me>
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

Add ksft_metric() to report a numeric measurement of the current test case
as JSON, right before the test result. Each metric states its goal: higher
or lower for a performance metric, depending on which way is better, or
zero for an error metric, so a consumer can tell wins from regressions.

Values are plain numbers without a timestamp. A helper for other kinds of
values, or a timestamp for values sampled over time, can be added when a
test needs one.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
v2: https://lore.kernel.org/netdev/20261005201115.2690830-1-sdf@fomichev.me/
v1: https://lore.kernel.org/netdev/20260916190409.1222272-1-sdf@fomichev.me/
---
 .../testing/selftests/drivers/net/README.rst  | 17 +++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |  9 +++---
 tools/testing/selftests/net/lib/py/ksft.py    | 28 +++++++++++++++++++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index 3fe49bce4f3a..ab61bbc322fd 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -259,6 +259,23 @@ ksft_pr()
 
 Use ``ksft_pr()`` instead of ``print()`` to avoid breaking TAP format.
 
+ksft_metric()
+~~~~~~~~~~~~~
+
+Use ``ksft_metric()`` to report a numeric measurement of the current test
+case. Metrics are printed as compact JSON right before the test result. For
+example::
+
+  ksft_metric("throughput", 100.5, goal="higher")
+
+prints::
+
+  # ktap-metric-json: {"goal":"higher","name":"throughput","value":100.5}
+
+``goal`` tells a performance metric, which is better ``higher`` or ``lower``,
+from an error metric, which must be ``zero``. Metrics do not affect the
+result of the test.
+
 ksft_disruptive
 ~~~~~~~~~~~~~~~
 
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index e269a260d58e..b1696f432c7c 100644
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
index 81287c2daff0..3b97bdff4cbb 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -4,6 +4,7 @@ import fnmatch
 import functools
 import getopt
 import inspect
+import json
 import os
 import signal
 import sys
@@ -16,6 +17,7 @@ from . import utils
 KSFT_RESULT = None
 KSFT_RESULT_ALL = True
 KSFT_DISRUPTIVE = True
+KSFT_METRICS = []
 
 
 class KsftFailEx(Exception):
@@ -93,6 +95,31 @@ KSFT_DISRUPTIVE = True
     print(pfx, prefixed, **kwargs)
 
 
+def ksft_metric(name, value, *, goal):
+    """
+    Report a numeric measurement of the current test case.
+
+    Metrics are printed right before the result of the test case. They do
+    not affect the result.
+
+    Args:
+      name - name of the metric, e.g. "throughput"
+      value - the measured number
+      goal - "higher" or "lower" for a performance metric, depending on
+             which way is better, "zero" for an error metric, which must
+             be zero
+    """
+    KSFT_METRICS.append({"name": name, "value": value, "goal": goal})
+
+
+def _ksft_flush_metrics():
+    for metric in KSFT_METRICS:
+        payload = json.dumps(metric, allow_nan=False, separators=(",", ":"),
+                             sort_keys=True)
+        ksft_pr(f"ktap-metric-json: {payload}")
+    KSFT_METRICS.clear()
+
+
 def _fail(*args):
     global KSFT_RESULT
     KSFT_RESULT = False
@@ -450,6 +477,7 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
         if not cnt_key:
             cnt_key = 'pass' if KSFT_RESULT else 'fail'
 
+        _ksft_flush_metrics()
         ktap_result(KSFT_RESULT, cnt, name, comment=comment)
         totals[cnt_key] += 1
 
-- 
2.53.0-Meta

