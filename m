Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C940C48B385
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028488; cv=none; b=W3Ilv+24WHV4NPx/vKL+QmmtV7kktk6DhI8WqMSa/zx8W4sSSXYH2CJDRKZ50txgfD1Ii8CP11yh9o31Yb4RkzqD79U3NSVXngK9kQdmvP+n0DwxXMOynQVTCQfLybvJ4kKlORcU8yZaSgOiDmzJ/bfaJS8nGrmClBSxGONBmgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028488; c=relaxed/simple;
	bh=rsfCIjJKlomyyd/eAUHgcLyXPeNc20mIu+75scqSwRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyRwLZVE74QOLr/62fN2j7r52SKI9NvHYnKLca3I7XgMTULgEKeJAWfq3Ns7Sc4mQTDAoMmbsv+JP+J0NJSkGO2fwW/GuzXt4IZdjSuvS61RBpdPaU9GJRYx8j02Rz0fqk7oef39iS0egOKNVVUJRbJGep2zPy6kHANvCYk65Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvRJJKlL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvRJJKlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2451F0089A;
	Tue,  9 Jun 2026 18:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781028486;
	bh=vVDf4UOr86FVmnOEEutpECiXd2YrlIWDuaG/aK3l3zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PvRJJKlLymaTF6+UsO8QKnVOSVP8FwyRVJIB8CHr8zoeONjtK52RR7KHhZd5gYQ0s
	 C+iKajQNpHHpSqWb5ojgLAPPP1EGdX9huWeryd8SRGiujb3yaNxzSAu1uGtMIZSBZI
	 jISDXsJKm/j2dhlyaJQGgxDdwtOm1yEpCsjCd3psJtGg60TNCztCSSQ0Oa7/T88JVj
	 pitRnPWyVNX6rTgB+FgaZbyZ8+MrvCNhz+rcQvsXM/1OiBGnCkuY95vlzFcl7ptlVq
	 xxdGdngs/XEu2e8DhrIfh9aCr/NraFZyH4uIFc3CvwuVDEbHO1dvnHkLYlXncJL1tH
	 oH+LwfPOUwANw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 1/2] selftests: drv-net: so_txtime: remember to deploy the binaries
Date: Tue,  9 Jun 2026 11:08:02 -0700
Message-ID: <20260609180803.1093428-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609180803.1093428-1-kuba@kernel.org>
References: <20260609180803.1093428-1-kuba@kernel.org>
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

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/so_txtime.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
index b7be4cabbec2..abdd2371cc1a 100755
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

