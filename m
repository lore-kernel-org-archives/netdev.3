Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355370;
	b=xqnuaTABYUO9Hn1EHMPvwp4bQkAect5vXez0Ihet5BTtGyl9B9GkIJwOKXSpozqrk8Iq
	 Mn2sX8dBfHPdEnD7Im/cUc2BnPuanwWD3QKSq5hdXE2JtXDlaWXTKuNDL07WwZLG1zHCg
	 A8wkuUwGgmmYGF8SerhpTIMSRau7OOQ7jPhxP3xij8cepIU5Af6AwzaDtxlsPi+LvoVuW
	 ltJWytBePoKFr+7eyLKsblmo/OVNSMVFRg2sqWLqbC+Zz8JQvmUHbGtxyBtfUN8JyuyAq
	 q2KLujyPjL/+k4BkGgV1lVJ7s+JjSBKI8bI5NC7J4jb89aeyLbtE1gdRGHpj4EeBnYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WdB74nNCseque09+fE/lIsqNO43mU6v4td2ejwduf5Q=;
	b=D2hThxcExLPGCETsIQhrjKov+fRV+69qiL6EJJA5674ILqkqOEPJA2TI7Jyy2p/obDCj
	 N4JYe0HeZgzmNzrIknvGvsSeFeFc+ZFUzdJMFVR8/uS6H3NuPoKBBL17YqJoxeCgIOA+8
	 ypsHIRkfUuoE7ZZrbYzlXxZpwThJUmpeghZX3nrfP9Sun2xjB7V+qh2ABAz4Qkk0Vaqw4
	 wRPxInaRbPsDBQtM7smkRb9OPLlCGR3TVj635uZEfxCrQoLyQ5pAgSRt6QF8XAcKJ6pZs
	 eBgIMaDINaUWs1QczoQ+EFC03TwNwLr12jgRd7ma/wbwK3GY9mJ3wHezWsbLk4qLDxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mc7KTfl7;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE83606A325
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BE83606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mc7KTfl7
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36f936424f2so1018689eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355369; x=1794960169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WdB74nNCseque09+fE/lIsqNO43mU6v4td2ejwduf5Q=;
        b=mc7KTfl7etSwgrH1RXSMXZJKrFlmPqtXxf1+wY7EJlsMnM0WnWxFIM2l/Mrrk58ow+
         PU108Ef/OLIAEJbxaezNXL0zpRBvTF5JpqICGtBXcQ1Wym0WEgzNs6EGWwk1f4Z22Tmw
         wPlWzNYzltbP/vdRiioV6LGGP84/RXlxnbGNXo2HgXKwG2LCxbvS/9/JyBUb1SwI5rxD
         mD+0m2IlXLCmEn39jOYhuQ8Iu5Q54un7Z/XTFiJCnJ3w2FK3ydPpWwt5e4zGtToguBQl
         O6oRcWT5FidFxt2sMK+EK4Qb4jGt4jAhmH+jDsscgydxV0MvyASoqiMOmB8OqnMFLP32
         fYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355369; x=1794960169;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WdB74nNCseque09+fE/lIsqNO43mU6v4td2ejwduf5Q=;
        b=ZYWh6uhFniiLB+niPKiY4bXLwlWXvtbvHYjj3NDW0bN5vppboff1UxvEgONt42bQQ5
         PrR/f1+LcjA0ZLb8T0mYcY/u/vqUOQgkw3Kmj5D/xBZsBWcad8tVn2nwL+FpOGHyZMBL
         332baOTQvqkvnAy+YnSNTWafPSuqkg3JfNcql3my9/tqQ41GdBFs1l3wxH8W/LlsrZuq
         m4gjtzTFy9Huo5ls0uO+x51jC4X+fRdpcAsAoJWnV8+4kjG4dAKDND5wYtcv4GqCixN+
         smkS/McPvKaShlLV5foYMpdwY6uBeyHqBPJCegzrdt6rdPkl/dcwHtgOSE9Fd/nnmS3a
         KJ4w==
X-Gm-Message-State: APuU4Z9ff6uUvusHUIUdGUTV1dA4wdoJy0eTLXL3/GqvAL0AsERAYM5f
	dWzmfcOcYJmwwxBJIwfC13b1h7Ulk9V1qb7UddiyRoXJSGkTbZ3vPVxvoMynwigMJaw=
X-Gm-Gg: AYBFou3YE1S11SkzMElj1EerR3VKpyoGQkptNeZEByi8NbYwKgNV8Pe7o3ZqNEDb2AR
	x8LFmi65Cah8IIzb1Ia2hfSMMYE8b2jXnSlPM+kG7RHCbQ9eGSRNEsSCwPkcU9+pTYWDD1T1SS2
	UQQrMir82oyhc59yBAPck2B3HceytQnu50BEVVGQ+RUVlHv8J3b09Pn6uGw0W0TEBuuG/S80h4e
	zkUlgOuyLoDfaz8sH3CuezfXQCpFek+M4YBcQJ6wrZagYWtdSHCwG1O3vjxQzCi0I2cEy6zLadS
	dUCPGJzaIM8Lf379fxxeiyD/aQddH0RofSQ/Te38t1L/a3CBGOoB4Uao+EFthCHTvD5JBx7cet2
	0N7SqeQcKefhUTtaXI13vqL4bKuCCMJVU2HAI1HySIBJ7eFs6uA1hOi58Gt1JiZ8tIDEN8JFRiD
	6RajcdfzQ27EjWhxp2sdACPbHcHkZTNzHvAX2VLk8Zh6TQi8jbghPPJMrOeLyVfplp2XuA3sV8y
	UUzMZPwuBCt8GSCl8AvwX1PGRc23dOUhB0o7xV9Ke3glSDhZH3JXOPV+X55e0GlwXdHHcZKGxy+
	K5XDyHmedHsKeu1kLdiFqiM=
X-Received: by 2002:a05:7301:470c:b0:36a:12c4:8bd6 with SMTP id 5a478bee46e88-37686171f1bmr1236648eec.22.1794355369164;
        Tue, 10 Nov 2026 16:02:49 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:65::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e7d24sm15881126eec.22.2026.11.10.16.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 16:02:48 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH net-next v4 1/4] selftests: net: py: add metric output
Date: Tue, 10 Nov 2026 16:02:43 -0800
Message-ID: <20261111000246.962871-2-sdf@fomichev.me>
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

Add ksft_metric() to report a numeric measurement of the current test case
as JSON. Each metric states its goal: higher or lower for a performance
metric, depending on which way is better, or zero for an error metric, so a
consumer can tell wins from regressions.

Values are plain numbers without a timestamp. A helper for other kinds of
values, or a timestamp for values sampled over time, can be added when a
test needs one.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
v3: https://lore.kernel.org/netdev/20261102190827.989117-1-sdf@fomichev.me/
v2: https://lore.kernel.org/netdev/20261005201115.2690830-1-sdf@fomichev.me/
v1: https://lore.kernel.org/netdev/20260916190409.1222272-1-sdf@fomichev.me/
---
 .../testing/selftests/drivers/net/README.rst  | 16 +++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |  9 +++++----
 tools/testing/selftests/net/lib/py/ksft.py    | 20 +++++++++++++++++++
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index 3fe49bce4f3a..f651163c16c8 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -259,6 +259,22 @@ ksft_pr()
 
 Use ``ksft_pr()`` instead of ``print()`` to avoid breaking TAP format.
 
+ksft_metric()
+~~~~~~~~~~~~~
+
+Use ``ksft_metric()`` to report a numeric measurement of the current test
+case. Metrics are printed right away as compact JSON. For example::
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
index 81287c2daff0..572ee17b4f4f 100644
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
@@ -93,6 +94,25 @@ KSFT_DISRUPTIVE = True
     print(pfx, prefixed, **kwargs)
 
 
+def ksft_metric(name, value, *, goal):
+    """
+    Report a numeric measurement of the current test case.
+
+    Metrics are printed right away. They do not affect the result.
+
+    Args:
+      name - name of the metric, e.g. "throughput"
+      value - the measured number
+      goal - "higher" or "lower" for a performance metric, depending on
+             which way is better, "zero" for an error metric, which must
+             be zero
+    """
+    metric = {"name": name, "value": value, "goal": goal}
+    payload = json.dumps(metric, allow_nan=False, separators=(",", ":"),
+                         sort_keys=True)
+    ksft_pr(f"ktap-metric-json: {payload}")
+
+
 def _fail(*args):
     global KSFT_RESULT
     KSFT_RESULT = False
-- 
2.53.0-Meta

