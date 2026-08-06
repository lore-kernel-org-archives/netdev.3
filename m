Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C21490C0A
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786058972; cv=none; b=YqxH+c6FBhpPgYsbs4jIlRTvb4Au9Hw2tiYYbOSPXc4LZreYV4A5DYxc7hPVHHS+Zne/0/UGIPrFzJ+3thIXtP5emDOWtC0GT9OXUnZUfNDVTLf5w7q7moR8/WG8lR5VngbkryWFhTW1j2QNcc57SGMH1FiwYqOzrW4NPoGRXII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786058972; c=relaxed/simple;
	bh=rFX7geEmRqao+jHy6XU21Vk1Al+BVVdkMxr5qx9i8V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSc60MXAEyPHDNzy/TkuvtwY2hwIn0Dn+fpg19yFrJAgCfhRHgwc7CihJZWumYR5tZ937Bnzb+x11J9mIFxTFZSy5ZEhjnZBrl3vq+qDP5NFFyPLXzTLUUro1SPnsBHkNYnvTWcEAgv5CVaLG4pPfvbNUS1/qh81RgBlPMYJolY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQMQjTig; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQMQjTig"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-669944f60b3so3443246d50.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 16:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786058970; x=1786663770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f6avniWt0KYSUT1rJggrxMEdUFeAg0dFqmkqy+4409U=;
        b=gQMQjTigy9837KalcjDjXVzx7moDC6jjAZF8EM8zqruRLb7sagpKBmU3OuhbOcAsNZ
         Uhvoy7oCpebBhCMucvgOeqG2+iI30VMPXYlSzuriUT/PWkcc8BYm3aJa1iYgpK6kmHqz
         ft71Li9O46rfGJ4WJiMGnKheG7Wp3DPvU5O/sVcrdbxcVJNd1TSd2LJUd1SROWmL523R
         Bji//tXDcz0yKpnGpL7omFEwQjTUOROPHNr0rt5KD+Uq9jLrzc/Gm38hjzIOlRLYfxoZ
         vlAlZrVBJuFRbw1TNPzkSnr1Qmzj3kmdkWwY5b4LIT6AKndGDYgtcrsePQvbbTabeB92
         TxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786058970; x=1786663770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f6avniWt0KYSUT1rJggrxMEdUFeAg0dFqmkqy+4409U=;
        b=e1EFZneo9tKx1bDHAly0CJLSkB7o/3vabjTBUJutYEcnxo8IhpQmffqr6KdMWZ6y1K
         tK5fnt07L1dOqoYTUfVWUGHD4L0+mEU1f5u3vS3cnzB0HDBAFHsqT8bLKO0+AQXdd3th
         ajxEjNUxtQB3LrAWApAt8mMv7xNZm5kWU2+OxT2XJx5zt8ha2eupTxGKH31NlJOapRag
         DC++n2bqQ7UdqqH53wDz43IUf11gcyELLM0GFsSZ5tekCC1tPA1PXVgXtbarUJEDCAsq
         FRis5K3IY2ToGuUO8mcNcVl1GF+UWuMXwQjr5xtxUPqBW5l+5o/zUJJ45W47CuLiuvop
         gDpQ==
X-Gm-Message-State: AOJu0YzTsdNseJuwkdB9tTbVtznouqE2L+xXTrZO1GLluYeqxsE270wU
	aGcXopkb0SiU96ND2bugF0JV2MNY3JEKKNp92nSJIdSDcTiO83dP5ZnJsB2sbw==
X-Gm-Gg: AR+sD11SlUQX6e5CTg/2n3xGPGIVZ8TS33FGgVWSGFakNe8OoQJHg5wRwHpbBo620MD
	mwgfOgwe8T43+ysdFmAVrRuXYuuGZg2zHWH6hjQdp5/xZzEFEcFx8v6rzxHe0qJ18tWLPCvPcOj
	Fv72fMoAq006Ucv+1cKiDaqIxH9ikGkEdUvkHfmn5kpPUuwJegnToP1+19g+Ii7hcpFv5+Aifxf
	hsS4QisMRGYFGm5yATX5RUrgoRPkjyEt+vXksFp2sIkk7XvgtveEQsGUqVtaq09lyFgtYAkRLLl
	BHMm7s/boCutGGqs97ke7qcY+4mQ3K/s9EOt9ZCVPaBalIDBNMecEUd3LCKf/Q4Cemw+mMRxuZF
	xbjG7aE1m+w1pXmhXMrqbR0V03RMADRBfDMH+1LAQiBGJbN1dKqxxpBEwfztcTIdn3qm4fYbWl7
	SUOF14Nv0NUgEBmRc9VsxNFXgKirgDHrt97YKgAegqJS8vHX3EeBOXFBAaSap44JlpFQtuwFAv8
	YjFPd7YRJ+ZienV0mYV5bQRk+jg1Xdd6hsarqToUPF89KVUNJpqw5YGKOU=
X-Received: by 2002:a05:690e:445a:b0:668:713d:893 with SMTP id 956f58d0204a3-6699a91a8efmr8651954d50.4.1786058970362;
        Thu, 06 Aug 2026 16:29:30 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acacdbdf2sm209273d50.4.2026.08.06.16.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 16:29:29 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	joshua.a.hay@intel.com,
	przemyslaw.kitszel@intel.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v4 6/6] selftests: drv-net: extend so_txtime with hw offload
Date: Thu,  6 Aug 2026 19:26:03 -0400
Message-ID: <20260806232913.4020403-7-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
References: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
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

