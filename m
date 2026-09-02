Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453742CAF6
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373081; cv=none; b=dUaovBVjC7SPG1hT3lOonyOG5GLhoLYB0hthtGa0ros/RIHP43TAcp8Rk0a39IlpCbXpOoOdte9r0hp1SCMshWd6gqJj8UL93psLSU6hzmU6V4cj2yjlVuveqlAf9PEmxvM/hNmuSXm/grHDuJOoRbSBzJAfdr6uBudhTU4YtOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373081; c=relaxed/simple;
	bh=cKAybUfedBG7R6C1sQdUFcJFCJqmve2fJMd22+EZYBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAy5ebgyfT3bGLmKKXasZaZBaWDvYUXI5hsKXnVjy3CqTPyTbSwz5qGfqrRDfT0pUsC+6W7ivNaTxvX8SlUqOBLBxeh8Nm+wXAZJS8nILAuZrieBuQW+iole5WX2yLCk/YF3ZSnI19nJgZU63KtHQfTN8XUqbscp8RMivGcEcCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCBiz5Dq; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCBiz5Dq"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66f88b68518so996300d50.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 11:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373079; x=1788977879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F7bt3BBmYrF8QD1ipEyMfjTx4xvR14EnPRe9eEPnu6U=;
        b=GCBiz5Dqf1GC1fl2IF9Vy3+VwHcRadVbaUeb486i3DeMAT5355OD18qQB3vUKhbQC7
         L5gnLKR6rs2y9Blgednm4c1z+S3+E+/smP8c0YnoTrujilq+SLtgDDSDhlJytawV6Nbi
         BfRKuliOHVzJ2gdFkSY4KgUdURbRhfHFCe74GtWNNPxCztEP8JmmKetOFXsw3ebfqkXu
         3yBY+X/4setBQKkiUyv5mfHA9eBJDG2xLf/0DcvQqzVhZhm/TTNgfgBeO+dy9LEWqCbS
         MV4azk7/tFJIQc16X6af9rJ//uRBS29jCsWpm2xu875I+s+SxyMPoBHfQiQSl6TkC7pG
         FtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373079; x=1788977879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F7bt3BBmYrF8QD1ipEyMfjTx4xvR14EnPRe9eEPnu6U=;
        b=sxER9naFRzCrEQibqmeaQCBISJVQBFLdc8Iyq+mALTB3baCmQ9deU7k5ny9CArdR/m
         ofVm+5c5MEIY7KDoOtuFs38l+kTsWgXtesQ2l40T6Wf6gbf2MbQXi6epapF37c1+nRc5
         gqqP4IIRktX00NCe+++h3lyehQ+3lUiQmFo6kIdBX3kUzkD+fhxGmr79clZ9p4zxRbBX
         /6mKHHG+Bar40VUyQ/n514/9HFBLdEmrTXpYGmkxRZM1EXYo5WmIa4LoTNF99wSfppw5
         wtH/J0POLdBOMeGJNqqUPplyShW8J3Ckn7tUCQACFo6EIfsraQX3v3EI3m6hwTD5Hnk3
         As8Q==
X-Gm-Message-State: AFuF++lTAlVc38VVJJ0TvfWDklkQ9B+YBLV4xxzb3HLqWTAZPkY79PHO
	gNzU9WyjlxqLVsIRBY+wS6V91Dmm0Ehem5OGFVnQaX/6flD2Jg4ZyCMKLzWvGw==
X-Gm-Gg: AYBFou12mQ+DnLzIRRhzKvG901w6buV90XrUnl+nhk49mNjo7x1loOf2iEpRbSPkFew
	m4a7kz9McIWJ+l2FY/lSPLUqR7CP761yXCGgcVYHLix50m5pmjr6JKUalFXhTe/V/15pMFJLIW9
	tUR1w8DRzM5emGa7JiZeruWVT0p+9JwVJ/D1sxi0u/p1G6vKhFdqSsMGhsP30Sn7CvnaR8yHWg7
	vinjN/WvlIR/WVk/kAZakiE5VA3kl5CHJOqmAOqgnbkLVhvMaotxwfdZYP9ezZG4IIo8Q5QHn4w
	5Zj2enSzkjF5k4QEWrxzy26MD9yxrzTJcqmp9/nLHVnqj9mKxf3YUdKW/11BXWsW5yML9P27bPE
	QBH5T3xM9evBHbLszaSVu5DWAirlQW6SgQ3Fd3+D4PiSw/PqNGhMY+6Yf2XCmFbhCjX+03Gfzn1
	75jB5DQzbhS3GuhWtoQJyw5ocT2liLj2Fb9Cl5+Fe2+5oJiIavvL7jtwYicXsNQVULHNtRXi3q3
	K6rtpluOnccJfJLZKAqj0NqVVAD4M9ulQMX4vLNqTrxE/mHf+XGC04jrZhdALkOixatchAqzn4=
X-Received: by 2002:a05:690e:1505:b0:66e:606e:cc27 with SMTP id 956f58d0204a3-66f9b90b288mr2300769d50.5.1788373078954;
        Wed, 02 Sep 2026 11:17:58 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c1784192bsm23162297b3.30.2026.09.02.11.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:17:58 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v8 6/6] selftests: drv-net: extend so_txtime with hw offload
Date: Wed,  2 Sep 2026 14:17:16 -0400
Message-ID: <20260902181747.2483351-7-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
In-Reply-To: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
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
pacing_offload_horizon.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
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
 .../selftests/drivers/net/so_txtime.py        | 74 ++++++++++++++++++-
 2 files changed, 74 insertions(+), 4 deletions(-)

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
index a097fae0b335..873d5fd6a8eb 100755
--- a/tools/testing/selftests/drivers/net/so_txtime.py
+++ b/tools/testing/selftests/drivers/net/so_txtime.py
@@ -12,8 +12,9 @@ import time
 from lib.py import ksft_exit, ksft_run, ksft_variants
 from lib.py import KsftNamedVariant, KsftSkipEx
 from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
-from lib.py import CmdExitFailure
+from lib.py import CmdExitFailure, RtnlFamily, NlError
 
+_HW_OFFLOAD_HORIZON_MS = 50
 
 def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
     """Main function. Run so_txtime as sender and receiver."""
@@ -33,12 +34,41 @@ def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
     expect_fail = not expect_success
     if slow_machine:
         expect_success = False
+        expect_fail = None
 
     with bkg(cmd_rx, host=cfg.remote, fail=expect_success,
              expect_fail=expect_fail, exit_wait=True):
         cmd(cmd_tx)
 
 
+def _dev_setup_pacing_offload(cfg):
+    """Configure pacing-offload-horizon."""
+    rtnl = RtnlFamily()
+
+    try:
+        link = rtnl.getlink({'ifi-index': cfg.ifindex})
+    except NlError as e:
+        raise KsftSkipEx('getlink not supported by device') from e
+
+    if 'pacing-offload-horizon' not in link or \
+       'max-pacing-offload-horizon' not in link:
+        raise KsftSkipEx('pacing offload horizon not supported by device')
+
+    horizon = _HW_OFFLOAD_HORIZON_MS * 1000_000
+    if link['max-pacing-offload-horizon'] < horizon:
+        raise KsftSkipEx('pacing offload max horizon too small')
+
+    cur_horizon = link['pacing-offload-horizon']
+    rtnl.setlink({
+        'ifi-index': cfg.ifindex,
+        'pacing-offload-horizon': horizon,
+    })
+    defer(rtnl.setlink, {
+        'ifi-index': cfg.ifindex,
+        'pacing-offload-horizon': cur_horizon
+    })
+
+
 def _qdisc_setup(ifname, qdisc, optargs=""):
     """Replace root qdisc. Restore the original after the test.
 
@@ -61,6 +91,7 @@ def _test_variants_fq():
             ["one_pkt", "a,10", "a,10"],
             ["in_order", "a,10,b,20", "a,10,b,20"],
             ["reverse_order", "a,20,b,10", "b,10,a,20"],
+            ["beyond_hw_horizon", "a,70", "a,70"],
         ]:
             name = f"v{ipver}_{testcase[0]}"
             yield KsftNamedVariant(name, ipver, testcase[1], testcase[2])
@@ -74,6 +105,39 @@ def test_so_txtime_fq_mono(cfg, ipver, args_tx, args_rx):
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
+    test_so_txtime(cfg, "mono", ipver, f"-H {args_tx}", args_rx, expect_pass)
+
+
 @ksft_variants(_test_variants_fq())
 def test_so_txtime_fq_tai(cfg, ipver, args_tx, args_rx):
     """Run all variants of fq tests, but pass CLOCK_TAI to test conversion."""
@@ -123,7 +187,13 @@ def main() -> None:
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
2.55.0.970.g62bdec98f9-goog

