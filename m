Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE18F3AA4ED
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211954; cv=none; b=S+r2pPQxaB///LJMWPQS5YuYxelGSZCQfO8q8aknBRCsBmd58upYz5W3Gs/uEFiluIGboq85KiQyiu79G1+yRRT4JcAkgucr21LFLSqA4jyjYmI8qq9yfYUVn34Xri+SCcofLcKMxrXGe4d+H5Fc6VMbmeIIRGnkn+zSLFhtYDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211954; c=relaxed/simple;
	bh=Ac2mMcI1WSpXmD4Uu9Okb5+ADIeNqYzGW3IJJ9hKR6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZqV9YDu1fbS3/Jyv4VAJ1dFDpjQaSQz246X9j85oAmwJgd45UHEAnEGuchz0EVEGGhABBOxXwvdtWZyfP3UB1EALhu9J35Zs2yw3j3fhpr/z3sDdxVOC+1A4a5J6XPx84t3bt3Pyl7Hah4Cu0uAbhSkXHJQQNeLo3IOzLRQcVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWH2Rdhf; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWH2Rdhf"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-867a943b149so16381657b3.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788211952; x=1788816752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d1DwzYMGKd1hUnBS5yxApVFJvIfWfBtMiVPVae3M6vA=;
        b=PWH2RdhfkbgRe+7mxKGul2tp7sNoNvoqAJkLyWyt2RJyCv/4zjrK1LhacVrmlyoXMf
         MRHAzn+GAQWAEV9ZPlVUUR0H2uDUfELlngNUedhbNhw3+vJJnpfkDNkmfJsnWIJ1uyyn
         /zmBt8lV7tXlALcb/VRi+PjXi0aABQPr2qkRiDYE0pOmQbw0xx18RfuQGdx2ewwV1qpW
         ecWL01uCPvk322tt6NHtwhZmQhYSlU9uNzFn/qauUfnmgTcN1BrQ0Ulg3ZDf3Vgw5hNX
         S3GuDbrpvWYds/hqox6JPl2H+2sZom+SayFVKIVd0I/Q1I3s31kvgM3oGGlLkAYw+cI3
         xmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211952; x=1788816752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d1DwzYMGKd1hUnBS5yxApVFJvIfWfBtMiVPVae3M6vA=;
        b=MGk/xsaWM6P6W7H6eomQoM38tLZG/edgo0FJ0u5xwBUUp4l4CNTmXlpVX6o5Ysk43g
         UHEZx1khHlmm+O2NLYaEDfZnoGpK4L5pcdfjuQWR5J0aVTfLedtq2/Zh1gTBxVaOO649
         tMgFUgA5JyAivVY/TWOw4x+kzQcOYOFhWXDuecRssc52SgctpXBB8VmObFvqDDs4Z6a8
         /oxFidmj7UvSAZGb+jp1HNj0zAl40pzM66tloIO+uDiiGx9UWf/6HhGpf6N7yyhxNjMI
         m02pjTF+Xlemz+VFH2A0cAih6LdU6b0GRrV3uw+tHqJlAQ4WMV7W5MwBg6BYV4PUSiCd
         oNWA==
X-Gm-Message-State: AFuF++kQm71MHEUiGPDnFaD82DB9WC42nAPvtoKjNHy3S9bJ+0jxthOD
	5e8gZl7Vjn+P5HKvS9VNg88tJsSBEJGavfSy+HYFNvJOAcaYQCmET/yksHV7NA==
X-Gm-Gg: AYBFou0EI3b2hBPClcwVurkwIn+pU9W6LjXC2AfYiwIeu99OCmPjMaXgBEtpjW7JaH5
	5I7kmh8yUesRQu1ICL14segWGd93eQW+R6vAGTU4+UWHzp+uMfyYsW+6gneUgoEf8xWsP8qBbKv
	E7mWkNFLvQqoJ9wCWzTvBF+obSa3H0EIGRnPdF6dIqPDhaT/DBdkXYdjTousHXpswoA7t9Ut9Gi
	gXfDXfr4wO/6vISFMDL91DggzepkW8MBaPHNOjpiVM4hXvqDGMd2lPc10N/DQ7rkKXMQzbRUV/8
	fm2yW/ShstkKCfvnUzuyeqBd58AoLz2IKXKa2AbQxJ5pc1ClzrH+UStYtqNeLVdUEZd5C4cQdDd
	p+HcPlhv2xJYyWFGWGeiFq9qgeGC9YhQ3Uq3JlZu3Hj7CmN3jYMqE1bw29RZDiHTt137v+SqEUY
	uvOEalysniQAvl/Aa++YEQwW7ElWbTuF/m+nm3DIoJSpeah0ndzf9dPCAELwiE4Ack41p/jQYKk
	Bfuumr82qrt5bmeo8JfFBuzVuuSfJCjLn7MQ+nsrl635/H7F1qgxCcmnxxCiOFW8KqZLUwIJFA=
X-Received: by 2002:a05:690c:93:b0:7bd:cf35:e33b with SMTP id 00721157ae682-868726e570emr17824707b3.17.1788211951605;
        Mon, 31 Aug 2026 14:32:31 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8616243a833sm45474307b3.13.2026.08.31.14.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:32:31 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v7 6/6] selftests: drv-net: extend so_txtime with hw offload
Date: Mon, 31 Aug 2026 17:26:15 -0400
Message-ID: <20260831213221.1370774-7-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260831213221.1370774-1-willemdebruijn.kernel@gmail.com>
References: <20260831213221.1370774-1-willemdebruijn.kernel@gmail.com>
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
2.55.0.897.gb25b4bd76c-goog

