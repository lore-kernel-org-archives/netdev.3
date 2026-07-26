Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED4F37DAA3
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785097757; cv=none; b=bDXWr2SE1qDVEaobAsYZ8KWtFxnw2U+vm6K3ggkF5aCoHz1RAR/R0ji3SjsrDY8udwTrkMdOp57/rEZppW30qPYwg+95yNI9/vjgZMGQJKPbhZM9rW495MP5UzecT42qEIw4sXeH+58h+GSx2M0BYnM1Ih63n4ke/dyRlzvuT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785097757; c=relaxed/simple;
	bh=Bk17R38etkPhfJ64gDXhvBXjKJl18uksKPx479D4sFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H92iS7+7QLxq1Okgc/Nl2jjyoSUf28haiJHlcRqNizF1mBVev5tW7TT2Q/xPSbGpIZzjGYfSOzdpcCYSTHnKO2u1phi/nWxoFWu7bAj+BPUDbvXKGMEHesGtriX9jUrq1NmwqQE/FxMCJ2cahj7k1Bryp/WoB+qI50A4vjk9Sg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+j9bGDR; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+j9bGDR"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8114a4542b2so27808417b3.1
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785097755; x=1785702555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zxw4bTsqng7AjzrrhUYRjlXcqe4KZ+mwg+4z5C/5CBY=;
        b=M+j9bGDR0OIzJArdENx9ZlLS8Q5c/0IG8JMlEW8fOuAU9UmJtP6RHJTHVdvl2YvLTd
         i8uH3HXWwILsqCbSP2BUS4y16TtuW5Ls5GQefRus/9vV69sbBU8rA0CAbEOLhWi4qviz
         ijoAAKb0+oXOysXHO2JFl2Tq/N4WlGh0iFFB0UcHoFyi2SS59cQUCw5xvGxfL8MiVJS2
         fkMjzSESpC4jcrxoFX6+ZZXZJdlK5Hgiy15bE+8XjXuwe+lKsXHpB6Su7AGPlADAqjbk
         EYvvydfn85R2CpWBMLOX2wGlAU/BioWiylCwhmwP/G2ynTI9VVIMqrytD95cjUBYl69u
         +lXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785097755; x=1785702555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zxw4bTsqng7AjzrrhUYRjlXcqe4KZ+mwg+4z5C/5CBY=;
        b=DzqI1N9r9lzj00wXyf8V4XDysJIsbbglZkbRQjSHX1LBKY8OSsV6FiRc1ibB+mU8+7
         /+fFfyUmuYy8rRCk+seF070PKB06ZUHT9XUulRjl0vD0HVf45rlWS+L3O1QwCMkZxGpT
         9N7rOJkbK6MoZbhvAZLqGZ6CW5nK1jk2Ui+Hxr6UOrH1M5Ma0y4AvdepgOrngx3tpVmK
         O/MgZkum67YUjS9EyiJNeiWKQ0muWWe0u3hZr5dsomqjouXrqmLjiz6IFsKsHxDo5bxT
         lvt/BxZWxZt4Kj8C8CnaIfxmQliFNWxanXsh5FHGyi9uHC6yiqa5biZAdtsrF9mYahMH
         +PSQ==
X-Gm-Message-State: AOJu0Yyjp/lIz5qJFQ3YsYzQbhYLdAwkczZnHursh6Hk1gGv93CgRTji
	pKzeqL8VYknMEX+vaINMdhSd37VTeY5U1ODR7P5fIXUknwd2BgTGMKf+e6UrQ+G7
X-Gm-Gg: AR+sD115VMqf7SfPxnvd8bkWFENjta0JkO4pgbQv4mx3DAx0DNFQVGsKYB3r0uXrj31
	j20kL912hbJh+b2flMVCcxEW9Bv9PmBmqt3DqG4JvGJe16l24Ku6XX7kNJoHPJRCTltcFAGcGkq
	SrgBWSDETbaLL2VstOSK6XtcvkJxokuaNM/GO4SP9VmI3nF/RdAOIRxA2jeI7llNuW4UTxLFZKM
	R1aZiQWvw0+k+M1dFbl0gkr2W7/wKGGGUaFlL01ffnx6DIF1wyRwylrV/30nksiorSko24WdNZd
	2ZQ6DSCy2e7iE8R4g3mK/PZ49E2TniJM7//TJCITIYIJqLo+Ew46IT+yTsfaLPaawZb4Cn76Cxy
	6nJS1MPWwP6Du2snqLX2SqGXpT2rhUDMJbu+nmKk1yBmEMJSQrJyE1T7uE2pLq0g5WCnOlC38dC
	IvqJfM8OEAfQe6ym2MRhH5s9cHcoC5QJedewRgkRgtcKpJEn2Y5tvy1gvOLRm9Rhpv3wTvEQIZ
X-Received: by 2002:a05:690c:6e0c:b0:81e:c95e:2bfd with SMTP id 00721157ae682-81f69e6a577mr19536117b3.56.1785097754960;
        Sun, 26 Jul 2026 13:29:14 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657a14d9sm23339467b3.13.2026.07.26.13.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 13:29:14 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	mohsin.bashr@gmail.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 6/7] selftests: drv-net: extend so_txtime with hw offload
Date: Sun, 26 Jul 2026 16:28:50 -0400
Message-ID: <20260726202902.760552-7-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
References: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Add two pacing hardware offload variants

1. one that uses FQ to safely offload when within bounds.
2. one that uses pfifo_fast and thus forwards all packets.

Verify that the packets are paced in hardware with new flag '-h'.

Also move the ip version check to the main test_so_txtime callee,
rather than having to add checks to the new variants.

Also increase rcvtimeout significantly to reduce flakiness.

Hardware pacing offload can complete packets out of order. So the
reverse_order test is expected to pass with pfifo_fast too.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v2 -> v3
    - remove drivers/net/settings timeout change: superseded by recent commit
    - add reverse_order comment
  v2: https://lore.kernel.org/netdev/20260722204454.3234605-8-willemdebruijn.kernel@gmail.com/
  v1 -> v2
    - re-raise NlError from e (patchwork pylint)
    - simplify expect_pass test (patchwork pylint)
  v1: https://lore.kernel.org/netdev/20260706133433.3142805-7-willemdebruijn.kernel@gmail.com/
---
 .../testing/selftests/drivers/net/so_txtime.c |  2 +-
 .../selftests/drivers/net/so_txtime.py        | 72 +++++++++++++++++--
 2 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
index 5900ca97957c..6e64baa4c60d 100644
--- a/tools/testing/selftests/drivers/net/so_txtime.c
+++ b/tools/testing/selftests/drivers/net/so_txtime.c
@@ -375,7 +375,7 @@ static int setup_tx(struct sockaddr *addr, socklen_t alen)
 
 static int setup_rx(struct sockaddr *addr, socklen_t alen)
 {
-	struct timeval tv = { .tv_usec = 100 * 1000 };
+	struct timeval tv = { .tv_usec = 600 * 1000 };
 	int fd;
 
 	fd = socket(addr->sa_family, SOCK_DGRAM, 0);
diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
index adf6c848d6d8..7b75a33f5c43 100755
--- a/tools/testing/selftests/drivers/net/so_txtime.py
+++ b/tools/testing/selftests/drivers/net/so_txtime.py
@@ -12,10 +12,13 @@ import time
 from lib.py import ksft_exit, ksft_run, ksft_variants
 from lib.py import KsftNamedVariant, KsftSkipEx
 from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
+from lib.py import EthtoolFamily, NlError
 
 
 def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
     """Main function. Run so_txtime as sender and receiver."""
+    cfg.require_ipver(ipver)
+
     slow_machine = os.environ.get('KSFT_MACHINE_SLOW')
 
     if not hasattr(cfg, "bin_remote"):
@@ -38,6 +41,34 @@ def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
         cmd(cmd_tx)
 
 
+def _dev_setup_pacing_offload(cfg):
+    """Configure pacing-offload-horizon."""
+    ethnl = EthtoolFamily()
+
+    try:
+        rings = ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    except NlError as e:
+        raise KsftSkipEx('ring-get not supported by device') from e
+
+    if 'pacing-offload-horizon' not in rings or \
+       'pacing-offload-horizon-max' not in rings:
+        raise KsftSkipEx('pacing offload horizon not supported by device')
+
+    if rings['pacing-offload-horizon-max'] < 50_000:
+        raise KsftSkipEx('pacing offload max horizon too small')
+
+    cur_horizon = rings['pacing-offload-horizon']
+    new_horizon = 50_000
+    ethnl.rings_set({
+        'header': {'dev-index': cfg.ifindex},
+        'pacing-offload-horizon': new_horizon,
+    })
+    defer(ethnl.rings_set, {
+        'header': {'dev-index': cfg.ifindex},
+        'pacing-offload-horizon': cur_horizon
+    })
+
+
 def _qdisc_setup(ifname, qdisc, optargs=""):
     """Replace root qdisc. Restore the original after the test.
 
@@ -56,6 +87,7 @@ def _test_variants_fq():
             ["one_pkt", "a,10", "a,10"],
             ["in_order", "a,10,b,20", "a,10,b,20"],
             ["reverse_order", "a,20,b,10", "b,10,a,20"],
+            ["beyond_hw_horizon", "a,70", "a,70"],
         ]:
             name = f"v{ipver}_{testcase[0]}"
             yield KsftNamedVariant(name, ipver, testcase[1], testcase[2])
@@ -64,15 +96,42 @@ def _test_variants_fq():
 @ksft_variants(_test_variants_fq())
 def test_so_txtime_fq_mono(cfg, ipver, args_tx, args_rx):
     """Run all variants of monotonic (fq) tests."""
-    cfg.require_ipver(ipver)
     _qdisc_setup(cfg.ifname, "fq")
     test_so_txtime(cfg, "mono", ipver, args_tx, args_rx, True)
 
 
+@ksft_variants(_test_variants_fq())
+def test_so_txtime_fq_mono_hw(cfg, ipver, args_tx, args_rx):
+    """Run all variants of monotonic fq tests, with offload horizon."""
+    cfg.require_nsim(nsim_test=False)
+
+    _dev_setup_pacing_offload(cfg)
+    try:
+        _qdisc_setup(cfg.ifname, "fq", "offload_horizon 50ms")
+    except Exception as e:
+        raise KsftSkipEx("netdev does not support offload. skipping") from e
+
+    # Expect all tests to use only hw pacing, except beyond_hw_horizon.
+    hw_only = "-h" if args_tx != "a,70" else ""
+    test_so_txtime(cfg, "mono", ipver, f"{hw_only} {args_tx}", args_rx, True)
+
+
+@ksft_variants(_test_variants_fq())
+def test_so_txtime_pfifofast_mono_hw(cfg, ipver, args_tx, args_rx):
+    """Run all variants of monotonic tests, without fq pacing sw backup."""
+    cfg.require_nsim(nsim_test=False)
+
+    _dev_setup_pacing_offload(cfg)
+    _qdisc_setup(cfg.ifname, "pfifo_fast")
+
+    # Expect all tests to pass, except beyond_hw_horizon without sw fallback.
+    expect_pass = not args_tx == "a,70"
+    test_so_txtime(cfg, "mono", ipver, f"-h {args_tx}", args_rx, expect_pass)
+
+
 @ksft_variants(_test_variants_fq())
 def test_so_txtime_fq_tai(cfg, ipver, args_tx, args_rx):
     """Run all variants of fq tests, but pass CLOCK_TAI to test conversion."""
-    cfg.require_ipver(ipver)
     _qdisc_setup(cfg.ifname, "fq")
     test_so_txtime(cfg, "tai", ipver, args_tx, args_rx, True)
 
@@ -95,7 +154,6 @@ def _test_variants_etf():
 @ksft_variants(_test_variants_etf())
 def test_so_txtime_etf(cfg, ipver, args_tx, args_rx, expect_fail):
     """Run all variants of etf tests."""
-    cfg.require_ipver(ipver)
     try:
         _qdisc_setup(cfg.ifname, "etf", "clockid CLOCK_TAI delta 400000")
     except Exception as e:
@@ -108,7 +166,13 @@ def main() -> None:
     """Boilerplate ksft main."""
     with NetDrvEpEnv(__file__) as cfg:
         ksft_run(
-            [test_so_txtime_fq_mono, test_so_txtime_fq_tai, test_so_txtime_etf],
+            [
+                test_so_txtime_fq_mono,
+                test_so_txtime_fq_mono_hw,
+                test_so_txtime_pfifofast_mono_hw,
+                test_so_txtime_fq_tai,
+                test_so_txtime_etf,
+            ],
             args=(cfg,),
         )
     ksft_exit()
-- 
2.55.0.229.g6434b31f56-goog

