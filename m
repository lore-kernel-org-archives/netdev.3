Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA76D346ADA
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204366; cv=none; b=Y0VhCMoBtdXRJ7hXLEbrc9RGtyxEaIL14aqOkbzWFiz23SrC1zryJRoityJ6bixw5dMAESUvIUtaWYrXhxA/RR7yIiZ97SqDx8zTrsdCLw62Z1XYL1ho2UM5NySaKm5DD4FWnlzoNIWUWqzBwVih+1IL4ge+2NBAnNNHpC3+nmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204366; c=relaxed/simple;
	bh=rFX7geEmRqao+jHy6XU21Vk1Al+BVVdkMxr5qx9i8V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfEnElVlVJiKjYZKdon3pqn9D7wfSqqTRG3/cUVBK6OxT2AkSp9jA7WPhBikbJkxGQ0X7ceGcaGg8+bZyOAxFcX6AKRKQeWpEFe3cn4g2ho9dWUMntyBtuKoIw/2KmM9hoSIUk7wPvcRRUb8ltq+GgLfJXplSUXSYxD2CWqL1o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jF/CacSV; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jF/CacSV"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8228ed0081fso6799097b3.2
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786204364; x=1786809164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f6avniWt0KYSUT1rJggrxMEdUFeAg0dFqmkqy+4409U=;
        b=jF/CacSVe4/nKTFPngCCBY13wPTEsuogZAsqLDsVF5Fm8u9P/uvGjJINTOsbYfZXPI
         zl8c69CgqSxSDr9BMlqAg3h3lPJOJYaIRx8UdLEI+tqwXgYtH7eagEhhbpIlbAv7lBp3
         AH2+r8DUvoKnDZqWwGuDStMlyhOd6KAsf2plysb8Zcw4v7qfkwZz9+0VEfVqHNptMgRS
         KBZ9S1Q+w2x7RdgjgtDrdLC5Ke3CGpS/De8iyN3evKXojy7RwU/vS74vxui5B8rj15eh
         6C+pmpLKttl/ZZn8e+wWiSuWcC0juc/rkVZbTheWpFUMofho0irGd6zxuICpPm1br2vG
         MEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786204364; x=1786809164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f6avniWt0KYSUT1rJggrxMEdUFeAg0dFqmkqy+4409U=;
        b=DH/P5Rd8ZnYIamPmVaA0ZZ9YeJVjZ62ksPVDjwTrqpVMwzYf9PTVnLsR+cp/vDzf4p
         S/evtZ2hGZYDqoodGWOShnkvAo6M7O50WqhIg9z4+ipVPTNEbSlx9p+yPq+zGHWlNrR6
         1pO9h+9bb4uJs2IUiACQKFSURn8MV809KJndNF8L8bvVJTdfBFcB5JCMZ5tEt04tV3LH
         kwKsMF8aFOAqZZB/1DuUtFl54oNp0dzKYion1XnQczQwhN+b73ZLS5yxD6ISXLPddQ0y
         SMV/Pi3lEWqBVkhfxlkt4vobMyRJ4gCVr58J2t+EJM6YuA0PxMunDPms345nqK9OlGOE
         MTDg==
X-Gm-Message-State: AOJu0Yw+V4TjsoWIn0WAdG3LZ6XCoslC3CIB/EuHd5hWljKFBQiiNvu8
	X+ebxdJ2bIaZ+zNMcwJJE90P0FLeUZloqn3quKZPpKZjUMQcnSGaELIvh0a8SQ==
X-Gm-Gg: AR+sD11SXo2WDLoz1P16NjEyG9H8yf8vRN8oanY09fPHOT8bG6pNlrNIWEhU3ciBAAi
	rGhhvEky31VrJwxLnpBf3wzwq0qxrWHNUqOfv1Kk4uMWiwSlkvNlVuvsHEm+sSuMSk2s4aG5kdQ
	/coUs8qf/Adn6Yc11a19MZNIigT+ftKLuyYAfPpc9JcIH6U/bewcux0ZoQRYBWl2bz6z7mZK/p7
	c8+2TswSlexRlTe0TqufQ5SAhwxTd2E71FVY2IPI7PshFYP8d6uoUNH0MhZfrEa+j9qEVKK+s6r
	HuP6rWrcRDrODAB7hGi4tDl2ACrgLTp2ZZbIO45FOHH+npzdudzQMoiR8x69NIjvcLQ1+l59oJH
	d17HT0ruYVcX5Zj5CEFmN3uw1RozMICu7clHMxVDmxNdvX97wxvjFXkZOiJHZJHO2u0FYdNEbcA
	xE8ljHkQBAsFx1NNPtDT0rQ61IdHJIfVjyECRUm2yi4VNvM+FsxNs0DmFYeQsf8GjK+/d4wuz2L
	8UCOK1aYhE87UQX1dzOdTCzYL1+Z5pL/tJIdo3ce5EHL2bi0buw5Y/kJVs=
X-Received: by 2002:a05:690c:6f02:b0:820:dd2:3c84 with SMTP id 00721157ae682-825778a524fmr57786887b3.22.1786204363840;
        Sat, 08 Aug 2026 08:52:43 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f79a6c6dsm27839747b3.48.2026.08.08.08.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:52:43 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v5 6/6] selftests: drv-net: extend so_txtime with hw offload
Date: Sat,  8 Aug 2026 11:51:44 -0400
Message-ID: <20260808155217.885299-7-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
References: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
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
 .../selftests/drivers/net/so_txtime.py        | 75 ++++++++++++++++++-
 2 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
index 951312e67b66..9028f9e5a411 100644
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
index adf6c848d6d8..24a686eda562 100755
--- a/tools/testing/selftests/drivers/net/so_txtime.py
+++ b/tools/testing/selftests/drivers/net/so_txtime.py
@@ -12,7 +12,9 @@ import time
 from lib.py import ksft_exit, ksft_run, ksft_variants
 from lib.py import KsftNamedVariant, KsftSkipEx
 from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
+from lib.py import RtnlFamily, NlError
 
+_HW_OFFLOAD_HORIZON_MS = 50
 
 def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
     """Main function. Run so_txtime as sender and receiver."""
@@ -32,10 +34,39 @@ def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
     expect_fail = not expect_success
     if slow_machine:
         expect_success = False
+        expect_fail = None
 
     with bkg(cmd_rx, host=cfg.remote, fail=expect_success,
              expect_fail=expect_fail, exit_wait=True):
-        cmd(cmd_tx)
+        cmd(cmd_tx, fail=expect_success)
+
+
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
 
 
 def _qdisc_setup(ifname, qdisc, optargs=""):
@@ -56,6 +87,7 @@ def _test_variants_fq():
             ["one_pkt", "a,10", "a,10"],
             ["in_order", "a,10,b,20", "a,10,b,20"],
             ["reverse_order", "a,20,b,10", "b,10,a,20"],
+            ["beyond_hw_horizon", "a,70", "a,70"],
         ]:
             name = f"v{ipver}_{testcase[0]}"
             yield KsftNamedVariant(name, ipver, testcase[1], testcase[2])
@@ -69,6 +101,39 @@ def test_so_txtime_fq_mono(cfg, ipver, args_tx, args_rx):
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
@@ -108,7 +173,13 @@ def main() -> None:
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
2.55.0.679.g6767b8d81c-goog

