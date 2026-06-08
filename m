Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B834F49F
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939996; cv=none; b=pZEOhMMDMxoAK0d9ejtXzInFHwk1pi/cCLAF7TOV9rVAq5VQHjKwzGQNrcquY08DsjCPbc0QTGD3f1milyJJtGGSswHeXzusDULyHNtX9t1z4B6PM3cn7LZejbJhdErpYQ+jZVmXyRowxkifyO3p4t7UADLkU6wb22JJEfCC4zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939996; c=relaxed/simple;
	bh=NEDrT+tkMKqVoISpLEK7odi7OXlLCcqFV/Kbr8tJH3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3SpS2ZvD2kiSCwZTno18mnaj4uk1fHx0KOzTQhStlX5XRlHLVYATMfG7gcWfhtfEPfcsR6heeOhiRA8fjpqS459q3xaLYXoVDl8XsafQnsM5+2uuKr9WWDJxeXjpSRax0DZ7cH3rwPwbD1V44M/B0p6IWf7QUhmsB9YAMMB5kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSLXqfEY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSLXqfEY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263981F00898;
	Mon,  8 Jun 2026 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780939995;
	bh=s7X6UnisPEkqurWv3wNIstYO6ikwHJiSQVHVtg+i2cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MSLXqfEYiyTUVjJmie+s7YPBbZYGk39xpXTnUr09jTlPrQDzIEuTAMY6RHTRUP88l
	 ztBUQhoKiRFwXcCTiG9zunZPNuOccr2hq1O4WDaHVtWNeZhqR/YPP75YH61xgOj2eW
	 xv3QuWLwSZ5Q9I7V6PfIQ2Z+qDVo1MT0SZJJCAfG99z4VAf1+KBOBGEEAqdSCgncxH
	 J5bQjy45VCEIV0YVb1hipjmWzjGHolLOPeSG7fGK2ttShcQ6l2d3KdX158cfJJNau+
	 VfyckdTxdgg1rqHqZ6F/VtMoiLAFBTx02G1zR52DIEfF5Ele/fSZ7Po0DOY9MiKqts
	 PGyX/sPjyj/KQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] selftests: drv-net: so_txtime: remember to deploy the binaries
Date: Mon,  8 Jun 2026 10:33:04 -0700
Message-ID: <20260608173305.372987-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608173305.372987-1-kuba@kernel.org>
References: <20260608173305.372987-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test seems to be written with a single-host loopback
in mind. We need to deploy the binary to remote before
we run it. This is just fixing an obvious issue, but
more work will be needed to make the dual-host setup
work reliably. Most of the runs still fail with:

  FAIL: start time already passed

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/so_txtime.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
index 5d4388bfc6dd..ddcd2c0e06a8 100755
--- a/tools/testing/selftests/drivers/net/so_txtime.py
+++ b/tools/testing/selftests/drivers/net/so_txtime.py
@@ -18,14 +18,16 @@ from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
     """Main function. Run so_txtime as sender and receiver."""
     slow_machine = os.environ.get('KSFT_MACHINE_SLOW')
 
-    bin_path = cfg.test_dir / "so_txtime"
+    if not hasattr(cfg, "bin_remote"):
+        cfg.bin_local = cfg.test_dir / "so_txtime"
+        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
     tstart = time.time_ns() + (2000_000_000 if slow_machine else 200_000_000)
 
     cmd_addr = f"-S {cfg.addr_v[ipver]} -D {cfg.remote_addr_v[ipver]}"
-    cmd_base = f"{bin_path} -{ipver} -c {clockid} -t {tstart} {cmd_addr}"
-    cmd_rx = f"{cmd_base} {args_rx} -r"
-    cmd_tx = f"{cmd_base} {args_tx}"
+    cmd_args = f"-{ipver} -c {clockid} -t {tstart} {cmd_addr}"
+    cmd_rx = f"{cfg.bin_remote} {cmd_args} {args_rx} -r"
+    cmd_tx = f"{cfg.bin_local} {cmd_args} {args_tx}"
 
     expect_fail = not expect_success
     if slow_machine:
-- 
2.54.0

