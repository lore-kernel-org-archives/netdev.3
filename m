Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E36443D4FA
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753110; cv=none; b=Uf5Xv9SRrmm15P1xRjOD9MUJRcGf52STNCKJJenFE2HmGSZHjIUJ0MSONlQIvPRdME3pmeDrzlkT1VAH45Puh8NDe+N8dLcM0V9lARiFu8855HjQqsjJ0s106cT7/gBJq2BKgXuMSfWL2x4i1fWy5WsvzwtvOW8aChV4h71vAMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753110; c=relaxed/simple;
	bh=WQmy5xUeSuoG4Nss1sPUDLuCYQ41ZRzsQvjvmN1KkJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rM26e2EapRaTp8MfkXUi5Ucvan8BW15/vOB8JOUro8tv6zFWPnAxY/bOxqQQ2pVoMqIU7SvZ9gQAl7iB+68/wiMfWKygFrZ6UOTgMPGjl85gIvkyYVbNGhaFMXCpwuegui2bQfm5QgBspB9RQEUogYp5/zQccAnJE/edWNxZSOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFW54rlv; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFW54rlv"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81ef8255cccso50186737b3.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784753107; x=1785357907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0tHNmGL0A4NZRqhCdIhgDQTJ8oiVZseS5/1kyFYLVZg=;
        b=HFW54rlvZF/6k4oZU2bc/loUdTe5xDqQ5mIR81WGpDVCN/ee5+dxMOog5T6sfTx/mc
         WySiVcKSOXWhE2lll9HkT2NyJ6751rjS57gh702n/+HGnl1L5ViycHslUmtDsKbWYtAj
         vMUGw1Mh+ytUFgVo+V+CdaGDSG094ZP23l2yo/hXiPHLsR9+fSMdrk7tMZ1SoemaFgr8
         CAS23Myhbh7OPmw6GuDY8kEYn7z9SiQMtU4vW8HmQrJ55mTIkbkBGQyUCMJWPUGDe3Td
         y6hZqmXlhOtF3bGIoKR169ejPobsggOZuRhApG4OLuzd6gfzLRq4cFeQUWPUi5atrwcF
         53UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753107; x=1785357907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0tHNmGL0A4NZRqhCdIhgDQTJ8oiVZseS5/1kyFYLVZg=;
        b=Dt+3uVzr0+4qRN8h/gyn5mOjHhofVzhHLTmKjAxxYNm6ex9yeeDsI1UHgfcM4LaLS4
         FNQ51ZHiW4L9qT1mu5tdW/qIpBAV6ZF8SHMgSAykVCdkMD8zt4yrThXUPr7cARpAicDG
         PLruOyRiRNKwQo4d+tqU7fCpbY7yWNHENC61rAS96CMCiMu8JBM+so14/CJwfKqnRO3p
         KzkTcA/TKdlWJReQESm/IWDOyIIkMkDpamQCa6MKmfVLNIfY+YH93QX5nveTlhuncB0r
         9uxUMBufyA5NNzH55MwcR+vBF/jzQ3gdKshlFFcJJlImrla+7kjgKQjYlfs/HkD1AQb8
         6mCw==
X-Gm-Message-State: AOJu0Yzse9EtJ72jUgaSW6cPiIVNSxIUBaz0uM2I7drtzdTY+qsnfMwI
	de9gox6SZFjANYd/j49a2JogBk8t7YISHOc+8sPJxqN1/Q3xWd1ktsOor8WC09R0
X-Gm-Gg: AR+sD106+FwbVXXY73BV4zrFYOR60iRU8HZibojxw1gG7CnznyQ/gqGRuRcY8QERkMY
	d2eV4VHmclCr27NlxQZsWsrBCIOTApmgRxG9KEtKWDdCWovymKDche6WuC2Bk9nblRw8nJ5a/BA
	zVpLluFM+6+BGAGXFoNIx5pPUaSdKRm4QTCm9mK6jkCG01Acd0K6r2DdFNSkegwQwrCtsYGV/5o
	9gLj/t2rH5O9EsV7rQzouIm+wnuU6YqJDaJoL0Ydy5/B7J6DJod41wUX5tnlMEHisgz3N3z8xkn
	FEPeHpeKqEVR3wuqaCUHY3YlHvin0KAu1JBNoQPzaNOvjHdZtb1aYfzSw5Ny1zJmg0A9vD8TEY0
	qgqbAL80IwX4Kv3S/pyzjM9L31ucE0d2dn4Yh+o8t5kLhznNuFbYcebuLTamZ+rZurP7N4234iK
	JY74cP1nI3h/AS8nV71IH1+Qm71nNiWinqzBm/w0SnZPX6wJtZrtghKpaZ9+zqya4sR757rnOxI
	C3C9g==
X-Received: by 2002:a05:690c:9993:b0:806:b6ab:a410 with SMTP id 00721157ae682-81f4bf58c91mr818057b3.0.1784753107216;
        Wed, 22 Jul 2026 13:45:07 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33bf2df0sm19506797b3.6.2026.07.22.13.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:45:06 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 6/7] selftests: drv-net: extend so_txtime with hw offload
Date: Wed, 22 Jul 2026 16:43:52 -0400
Message-ID: <20260722204454.3234605-7-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
References: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
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

Also increase test timeout to 2 min. This suite now counts 58 tests,
which each take 2 sec to stabilize when run with KSFT_MACHINE_SLOW.
When increasing the bound, do so with a sizable headroom.

Also increase rcvtimeout significantly to reduce flakiness.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v1 -> v2
    - re-raise NlError from e (patchwork pylint)
    - simplify expect_pass test (patchwork pylint)
  v1: https://lore.kernel.org/netdev/20260706133433.3142805-7-willemdebruijn.kernel@gmail.com/
---
 tools/testing/selftests/drivers/net/settings  |  1 +
 .../testing/selftests/drivers/net/so_txtime.c |  2 +-
 .../selftests/drivers/net/so_txtime.py        | 72 +++++++++++++++++--
 3 files changed, 70 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/settings

diff --git a/tools/testing/selftests/drivers/net/settings b/tools/testing/selftests/drivers/net/settings
new file mode 100644
index 000000000000..b478e684846a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/settings
@@ -0,0 +1 @@
+timeout=240
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

