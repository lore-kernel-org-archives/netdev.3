Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC2033A02B
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786586756; cv=none; b=CW0JplYnc7RWFkzXuyKfVvHns2QMVrLynjL9TNSk/HsHN+1cg+lTwC3AlsCwAVrLy6kAnhZdwbaUJlU0hfNF1fTrdAAm9zlxq56OtV4Y6UfheBk8aPq0Sxmp6giH33y9upTEjM3zTg1XedAWHEpJACQrtqWABmSI6AN9Reyic7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786586756; c=relaxed/simple;
	bh=LkKZjR+Bc2iP1rFsZxCDW2OHUIgpJ10lsb657RZ2OaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBpKuIAaR5SAOGCqR8uFJjZPLqxQ+0B0i3setMP8phdJBBraj7ZgX9+5bGaSLgY5LtBBG6WbGcqrhWxAW58woC/KoPn714k4JpVPQKViZpBFm0ru0njEj5BVADPKpmwnfV/ZMngMi+oBm5KYr6OFm+KempgsE7KwV5LzXUjKdxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cU890GIZ; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cU890GIZ"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66771ded50aso257509d50.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 19:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786586753; x=1787191553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uqI/XnmEozUwBHCt76Tc0iZ/eTSe9/KF9BnhyWfO9iI=;
        b=cU890GIZnoFeeHgcrBzeV6iDGUZdpN1KsQwBdEw17tizPXtbU26f4AWpfyA+zeC9Vw
         7x7t8uG+rEyuTuMW7OkRawn2YtgdF0VD0COnkp3/gKQbxVgyiysbyU1rtJ/qVb8W9gkO
         u2ggwu5JLCI4050pdV19NX7hSxX7TpDLJ5iJHeR9IEJ4JJGmM0gz76BQiRMx15QekLOZ
         Z0MAa2f38PYFApv5EL5Z/eBC7g5AagwN4OnrCVf7kp0fEaALnNmQLg8Qa23h8MuqkPa0
         jWRNdXsjKRZVUn3oP3aSQy816/pa7QQxAxQyqnB89FD3Jm3sjqoXVC+cMGLGozBQp7TK
         Cofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786586753; x=1787191553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uqI/XnmEozUwBHCt76Tc0iZ/eTSe9/KF9BnhyWfO9iI=;
        b=QRYT0xT06BIVs7z4H0/7kWcTtuWv7bCouTH4K/OtntyZqQhXEf4D1p+w/DjzGv9koE
         9cUAaLPyLIlVKcIdO2yyWy06IYWJk4eThyOIgPlCrB8gJX6D1ifmvWWkLBQ0cGuF/B0B
         fW0HBrTgfgas05ylWxvnUCThSgw2+l3PfkRo6YliaS+HIOMOVuaSjqUwscuWZqmiFMAm
         mWL/WgWvUoZjyNJjT7DBfTW4UL9u+t6+JK52WWzrZ03S1ESWDovI0Ync37nuAL4eJh8x
         NdOKRJM0PMQW93ft0R0qW6p83Dg5no/xunfEm+Kkjx7A8v83Xs2DVflXszA6Va+Aj5Pj
         ppKQ==
X-Gm-Message-State: AOJu0YyN0EuUYkEzr4Uk+aZkGMmh0f9DjVu4dXjC/83eGvwG8tl4iiCG
	CCN/1buTdbtWdWY5B1N58A7UXY/wQoWftinOArNF/7jUbIYwDl8NwNJgwJwcCg==
X-Gm-Gg: AR+sD12lhD8xbmqYvXsxaETU3gJ94UyjbH+yCuLuSmuorvI1DVqFn1HlzosCEP4/Wen
	+gz7L6ShbP9jv4WLQkg6XL7YrX5/mdGlKaE8GF0RU8yi3np/TZkvS2N+w6WvTJ1C19Ams6EfuSq
	yIBmLKJTqxFsuG3UL1wuFmi87nlcNbte7A2uMVeYb+iS5g8z2LLvxGH+0ZYKiyYNnm2YkfS/CC8
	NAqGKMTlrX5GDjqB5Kggw+bnRV5jxuekRAv+QFy6pzNvSMqVWdqaLZjPsvbbn51Tpnc+SbN8yJv
	fFcZOyF2Tj7OL7h0Kr6aGcQM/DPd3z7fCW28yhOusdnl/DFDFCj7e4fjO/9CFw2FEhBxZMlj6tr
	rapL1mmsM6LSNxym6fYcH1kWAq2ZDSMSlPzqWlTBnmH/P2G/zkNCJtgswDBVHqx7zQXlA9t0IzG
	hbIqI+IqFjROudkescuncPfYDVb0DHRgi0z8bgmLuzVDqK6Vpi3IJo4BfbluZx2gWuj3+M3yLud
	gh3DQo2inK0z8tVSfGzPOaITBeBlny802vIy+1Q0+9C2qPcKLxhx9L8RYkxtt9prUqXEQ==
X-Received: by 2002:a53:d90b:0:b0:66c:486c:aa07 with SMTP id 956f58d0204a3-66c51642401mr1017503d50.35.1786586753300;
        Wed, 12 Aug 2026 19:05:53 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c56e74870sm226899d50.6.2026.08.12.19.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 19:05:52 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v6 6/6] selftests: drv-net: extend so_txtime with hw offload
Date: Wed, 12 Aug 2026 22:04:01 -0400
Message-ID: <20260813020529.3506539-7-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
In-Reply-To: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com>
References: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com>
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
index c40e24cdef69..8c81160656fb 100644
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
@@ -379,7 +379,7 @@ static int setup_tx(struct sockaddr *addr, socklen_t alen)
 
 static int setup_rx(struct sockaddr *addr, socklen_t alen)
 {
-	struct timeval tv = { .tv_usec = 100 * 1000 };
+	struct timeval tv = { .tv_usec = 600 * 1000 };
 	int fd;
 
 	fd = socket(addr->sa_family, SOCK_DGRAM, 0);
diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
index a097fae0b335..a6ccaf134199 100755
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
+    expect_pass = not args_tx == "a,70"
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
2.55.0.691.gc56d675ccc-goog

