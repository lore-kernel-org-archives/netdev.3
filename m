Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40595452AA
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060320; cv=none; b=iXkh6kyZI0orcCum5PaSy4VFfte00KPeujFeRCgwUut8ar9pm45M2odYXA8zl8v8bfOCK/xz1VTu+8xese7pEoOV1HYbRyXPVQbbQpIsyUl/TcQQrDwmFYklFrmW108K7/0JBprKh4IFwwNDasbi25tUckcmXo5jws519GTVSAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060320; c=relaxed/simple;
	bh=O3osIf01S31PT77PpMq1Y/AN9/GfVVkpCffj3kzepOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdhG+dGrUoTpjL5mTOU4+Iw9FW78qklV45ThB4UWKQB/eFDsLj5N6v37yf386+qnIjQCdBSwnbGkS+MWNnxJZdstgS5g2YLnRZOS+S2Pq0Qd3xPL5/2vInmT6TcLOxgTxIpfuhM4a0cCt9U/UqFPwaDXOkOOSpzR7VrYYLPGXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR4rOybQ; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR4rOybQ"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e50968489so1585647d50.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060302; x=1789665102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=em/i+ISpHotSC1hrqHaaGpDbOkTRs0bCg//keJjtI1M=;
        b=FR4rOybQwR2e2naN9j8ApsYIAsv/XQYPCG3sNU7Da0UIvrM3E438HhTkuMIYIZeNDT
         zSGiPv0u9vzgANYYb0LgOxo87ES7Qm/fcP7NYEq+jRbh6wEbYs9aVVgIYOQDz4C8+WoC
         TODNhRBjFHZ2xgh3gL0uCSA9HHbbGKNXEnApTR66S6m6AiwYrhiyfv2yuo47QgSZ5Z1W
         jNg3QsaZg+5srBXe5zsFBK6ySOUFOvlFf4oKmeIU7iPjorcqTS6jxJqKNdqWBGvYD7up
         VSys+ymirMgDNasEJxgjewTYt/p0CDoet9kvuVkUJtBcAcs4h57D2agQE2SElyGXtzel
         hRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060302; x=1789665102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=em/i+ISpHotSC1hrqHaaGpDbOkTRs0bCg//keJjtI1M=;
        b=cK+KVTL8eygcn2Mz5LQge77k2OMoBUnxqKrz70Mc6ktLDG3g/pTdP4bxQYiIfZa99Y
         6Aj/lSmaumUpIDxjW5CnIZAjYdrLyvCFSfPUKUJnBDe/HFNUrsv3lUHruOIL9myIJ9L6
         m1nMGdak1W48FF70rTYJBEPa/QkVu0zABKKXoo8BotuZB6cXMuIA+sex9li2aJzH2MnZ
         7yULzxh/uHRbSH7FWsoBUZii1QKHfdVHHroNTpwpxDSs81v7JUH78g3i7mztau3KY5Xp
         NxQItoQ9N3Ow+nxzGUJ3ARdjKH83LJn80QRPNbXgJq915jR3/Z63qXSTTZq4Lqvlj8/s
         2b9w==
X-Gm-Message-State: AFuF++kmcFWsV4K0U6PQsOEckYfBEVoIZzGM79ndqRgpnfp7tHOf3Hbp
	F6MI9wNozfSfFCa3cT1v0pNvOBwLNe77XCx0r5EvBxATsw5ZB98XSbAAc92p2g==
X-Gm-Gg: AYBFou3Q6awBTqzOTw8RhjtL2g3E/lvvPZ5vqg0C/nS+JxAVNc6oztVKMF844xV1P6+
	aipFcI8so/tT3/h0VZCo6h2+cwZz7jnZAaY5qrIi5l2nipF12TY/ferR3rDW5XePQLFDjjh8f1Q
	n99rLuSy24LzaQX+PN3NCVy9cdVo02Po5cfus2AigP+/w0wo4Cnv3N3hAWeA1mZ96sYkTdoQbYX
	Fr126Fps2uALAgDC69y4p62//rq3Th0guOSSzHFOjZ/b2kZ3u4uOQr7KEpkDuj7Ql4bzbLP0Z2C
	Dh+6XREo97JMqvOzX2QdFjyGbfrF3CNnehwMx9rKfju01/QsQ9ZcY6MUY6GUJER8nuE+RucIO1s
	fW2cursJ2Qe9pKohtxBEr0TONqS58ZVuNdJn5Rus0qbha3mR1cMQtHBjn6IYjV+80oIIIoZxdlf
	9Oc9UVN2qT9HjWPIL5XirtgjCg66Pz6bKXf2nYBO5DkBLG63cvI5EPWa14qLORw7vKpaKv5KZGW
	0vSTQsYGHw5AYspAapTl3yxxe/e+mdW0gtshUGqN5m+jVVep7Bo4WWDXxHK7YSNYXfYOXt4I/iE
	5phXr4JE0g==
X-Received: by 2002:a05:690e:4382:b0:66d:1eff:85f with SMTP id 956f58d0204a3-67124513295mr83615d50.6.1789060302418;
        Thu, 10 Sep 2026 10:11:42 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48ee9easm14059834d50.8.2026.09.10.10.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:11:41 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v9 7/7] selftests: drv-net: extend so_txtime with hw offload
Date: Thu, 10 Sep 2026 13:10:26 -0400
Message-ID: <20260910171131.2532487-8-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
In-Reply-To: <20260910171131.2532487-1-willemdebruijn.kernel@gmail.com>
References: <20260910171131.2532487-1-willemdebruijn.kernel@gmail.com>
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

Verify that the packets are paced in hardware with new flag '-H'.

Also increase rcvtimeout significantly to reduce flakiness. Especially
for the new beyond_hw_horizon test, which is close to the 100ms limit.
But update recv_verify_empty to take MSG_DONTWAIT. That last empty
check must not delay each testcase by the receive timeout.

Hardware pacing offload can complete packets out of order. So the
reverse_order test is expected to pass with pfifo_fast too.

Do not test ETF, which does not change its dequeue behavior based on
pacing_offload.

The pfifo_fast beyond_hw_horizon testcase expects a failure because
the packet exceeds the hardware horizon and is transmitted immediately,
violating receiver arrival bounds. On slow machines (KSFT_MACHINE_SLOW),
timing variance errors are suppressed by the receiver, so relax the
failure expectation only for this timing-sensitive case while preserving
deterministic checks for other tests (such as ETF invalid txtime).

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v8 -> v9
    - scope expect_fail relaxation to timing_sensitive tests
    - move beyond_hw_horizon slow machine rationale into commit message
    - update to pacing-offload (boolean enable)
  v7 -> v8
    - simplify "not a == b" test to "a != b" (ruff)
  v5 -> v6
    - do not suppress tx failures on expected failure:
      all expect the receiver process to signal failure
  v3 -> v4
    - replace ethtool with rtnetlink APIs
    - expect_fail: correctly handle negative test pfifofast beyond_hw_horizon,
      also when KSFT_MACHINE_SLOW suppresses timing errors
    - commit-msg: clarify that rcvtimeout increase is also needed for
      beyond_hw_horizon test
    - define the horizon (50ms) once, rather than three times
    - leave cfg.require_ipver in place
  v2 -> v3
    - remove drivers/net/settings timeout change: superseded by recent commit
    - add reverse_order comment
  v1 -> v2
    - re-raise NlError from e (patchwork pylint)
    - simplify expect_pass test (patchwork pylint)
---
 .../testing/selftests/drivers/net/so_txtime.c |  4 +-
 .../selftests/drivers/net/so_txtime.py        | 80 ++++++++++++++++++-
 2 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
index 9ebe9f91227c..5bb15498da30 100644
--- a/tools/testing/selftests/drivers/net/so_txtime.c
+++ b/tools/testing/selftests/drivers/net/so_txtime.c
@@ -155,7 +155,7 @@ static void do_recv_verify_empty(int fdr)
 	char rbuf[1];
 	int ret;
 
-	ret = recv(fdr, rbuf, sizeof(rbuf), 0);
+	ret = recv(fdr, rbuf, sizeof(rbuf), MSG_DONTWAIT);
 	if (ret != -1 || errno != EAGAIN)
 		error(1, 0, "recv: not empty as expected (%d, %d)", ret, errno);
 }
@@ -380,7 +380,7 @@ static int setup_tx(struct sockaddr *addr, socklen_t alen)
 
 static int setup_rx(struct sockaddr *addr, socklen_t alen)
 {
-	struct timeval tv = { .tv_usec = 100 * 1000 };
+	struct timeval tv = { .tv_usec = 600 * 1000 };
 	int fd;
 
 	fd = socket(addr->sa_family, SOCK_DGRAM, 0);
diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
index a097fae0b335..66a87205e02d 100755
--- a/tools/testing/selftests/drivers/net/so_txtime.py
+++ b/tools/testing/selftests/drivers/net/so_txtime.py
@@ -12,10 +12,12 @@ import time
 from lib.py import ksft_exit, ksft_run, ksft_variants
 from lib.py import KsftNamedVariant, KsftSkipEx
 from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
-from lib.py import CmdExitFailure
+from lib.py import CmdExitFailure, RtnlFamily, NlError
 
+_HW_OFFLOAD_HORIZON_MS = 50
 
-def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
+def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success,
+                   timing_sensitive=False):
     """Main function. Run so_txtime as sender and receiver."""
     slow_machine = os.environ.get('KSFT_MACHINE_SLOW')
 
@@ -33,12 +35,42 @@ def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
     expect_fail = not expect_success
     if slow_machine:
         expect_success = False
+        if timing_sensitive:
+            expect_fail = None
 
     with bkg(cmd_rx, host=cfg.remote, fail=expect_success,
              expect_fail=expect_fail, exit_wait=True):
         cmd(cmd_tx)
 
 
+def _dev_setup_pacing_offload(cfg):
+    """Configure pacing-offload."""
+    rtnl = RtnlFamily()
+
+    try:
+        link = rtnl.getlink({'ifi-index': cfg.ifindex})
+    except NlError as e:
+        raise KsftSkipEx('getlink not supported by device') from e
+
+    if 'pacing-offload' not in link or \
+       'max-pacing-offload-horizon' not in link:
+        raise KsftSkipEx('pacing offload not supported by device')
+
+    horizon = _HW_OFFLOAD_HORIZON_MS * 1000_000
+    if link['max-pacing-offload-horizon'] < horizon:
+        raise KsftSkipEx('pacing offload max horizon too small')
+
+    cur_offload = link['pacing-offload']
+    rtnl.setlink({
+        'ifi-index': cfg.ifindex,
+        'pacing-offload': 1,
+    })
+    defer(rtnl.setlink, {
+        'ifi-index': cfg.ifindex,
+        'pacing-offload': cur_offload
+    })
+
+
 def _qdisc_setup(ifname, qdisc, optargs=""):
     """Replace root qdisc. Restore the original after the test.
 
@@ -61,6 +93,7 @@ def _test_variants_fq():
             ["one_pkt", "a,10", "a,10"],
             ["in_order", "a,10,b,20", "a,10,b,20"],
             ["reverse_order", "a,20,b,10", "b,10,a,20"],
+            ["beyond_hw_horizon", "a,70", "a,70"],
         ]:
             name = f"v{ipver}_{testcase[0]}"
             yield KsftNamedVariant(name, ipver, testcase[1], testcase[2])
@@ -74,6 +107,41 @@ def test_so_txtime_fq_mono(cfg, ipver, args_tx, args_rx):
     test_so_txtime(cfg, "mono", ipver, args_tx, args_rx, True)
 
 
+@ksft_variants(_test_variants_fq())
+def test_so_txtime_fq_mono_hw(cfg, ipver, args_tx, args_rx):
+    """Run all variants of monotonic fq tests, with offload horizon."""
+    cfg.require_ipver(ipver)
+    cfg.require_nsim(nsim_test=False)
+
+    _dev_setup_pacing_offload(cfg)
+    try:
+        _qdisc_setup(cfg.ifname, "fq", f"offload_horizon {_HW_OFFLOAD_HORIZON_MS}ms")
+    except Exception as e:
+        raise KsftSkipEx("netdev does not support offload. skipping") from e
+
+    # Expect all tests to use only hw pacing, except beyond_hw_horizon.
+    # Do not pass -H to that test so that with sw pacing fallback it passes.
+    hw_only = "-H" if args_tx != "a,70" else ""
+    test_so_txtime(cfg, "mono", ipver, f"{hw_only} {args_tx}", args_rx, True)
+
+
+@ksft_variants(_test_variants_fq())
+def test_so_txtime_pfifofast_mono_hw(cfg, ipver, args_tx, args_rx):
+    """Run all variants of monotonic tests, without fq pacing sw backup."""
+    cfg.require_ipver(ipver)
+    cfg.require_nsim(nsim_test=False)
+
+    _dev_setup_pacing_offload(cfg)
+    _qdisc_setup(cfg.ifname, "pfifo_fast")
+
+    # Expect all tests to pass, except beyond_hw_horizon without sw fallback.
+    # It will send immediately, failing the receiver arrival bounds check.
+    expect_pass = args_tx != "a,70"
+    timing_sensitive = not expect_pass
+    test_so_txtime(cfg, "mono", ipver, f"-H {args_tx}", args_rx, expect_pass,
+                   timing_sensitive=timing_sensitive)
+
+
 @ksft_variants(_test_variants_fq())
 def test_so_txtime_fq_tai(cfg, ipver, args_tx, args_rx):
     """Run all variants of fq tests, but pass CLOCK_TAI to test conversion."""
@@ -123,7 +191,13 @@ def main() -> None:
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
2.55.0.1007.g17ff1f9808-goog

