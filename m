Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3748C402
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028489; cv=none; b=m7HMFVYXQKLyPWTGJUMOAmbdtVwRoFvatdc7cqO5tL1JWKoQVBCGz9jHaxJbpt4pmS6Zm9bnLkss/mH1ZxTv6niCi3SrZ5ZOi7RqmQuYmGtMUbhpwvG9UZC7UeYpK8XaxqWg5hkzbB3kRbif3KckGR7/7D0gH3UmHcobdZIpnbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028489; c=relaxed/simple;
	bh=v1C9pUW++yD1b1MMk91kMJ7tKNuA+yFLmhcMJ1Kvi20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6lsOyVEQJstobQbnQW9+7n22yhGgupZi+LRcS7UTxrC62AESt2xHHcTPNmjYhQNLN0LFxxG9Fl4kgcUM/mVyyCTsxSRF50LE0P0F4f2X0Ld5IEJqaeR+DjX6pCR5Q2CEqbPfiRxnf/y0yv29ZdBECqEoNYTCvBmXCjYwawmM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZZhXFl3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZZhXFl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971E91F00898;
	Tue,  9 Jun 2026 18:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781028487;
	bh=KBXTlonJ2h3j7ixA6x35jePeFtGv8nmz0Rf0U9Ecpu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nZZhXFl3+wXCO3apX0xP2d6KTaFnW2vdSsb7dvs+E3fIZvzlf1/EEcejuCYuzjCd5
	 PsZFNzHlOv8Nrdyi55/fU4x/jQ+YJOkahTZriEvcvrlzrwIjjFLFiG0jPZRYONlwL+
	 z46Hut/v9joIMSC32T5VI9GtVoFmLQlOIspC9rqLmLHE9+yGd+mmACM83qGc/Boz1T
	 LaezUUgzgs3D2GR9dI3lMZhtKbOt1qc4Rreq6c1o6gi+OCIR+HgmR7fSTH3vAKeIXD
	 yia+bfZqfHnyZXNo7iYttTFoQr9zL/YJtPjQJ7NMXCqGm4PrN/e72mBrzbqEuYQKSi
	 VrFzSTKhhGKbA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 2/2] selftests: drv-net: so_txtime: check IP versions
Date: Tue,  9 Jun 2026 11:08:03 -0700
Message-ID: <20260609180803.1093428-3-kuba@kernel.org>
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

This test needs more work, and it fails in non-obvious way
when IPv4 connectivity is not available:

  # Exception| CMD[remote]: /tmp/vjquwblf/gukinuzqso_txtime -4 -c mono -t 1780939014114542914 -S None -D None a,0 -r
  # Exception|   EXIT: -15

Explicitly check for IPv4 support to make the future triage
less painful.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - add cfg.require_ipver(ipver) in test_so_txtime_fq_tai()
v1: https://lore.kernel.org/20260608173305.372987-3-kuba@kernel.org
---
 tools/testing/selftests/drivers/net/so_txtime.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
index abdd2371cc1a..adf6c848d6d8 100755
--- a/tools/testing/selftests/drivers/net/so_txtime.py
+++ b/tools/testing/selftests/drivers/net/so_txtime.py
@@ -64,6 +64,7 @@ from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
 @ksft_variants(_test_variants_fq())
 def test_so_txtime_fq_mono(cfg, ipver, args_tx, args_rx):
     """Run all variants of monotonic (fq) tests."""
+    cfg.require_ipver(ipver)
     _qdisc_setup(cfg.ifname, "fq")
     test_so_txtime(cfg, "mono", ipver, args_tx, args_rx, True)
 
@@ -71,6 +72,7 @@ from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
 @ksft_variants(_test_variants_fq())
 def test_so_txtime_fq_tai(cfg, ipver, args_tx, args_rx):
     """Run all variants of fq tests, but pass CLOCK_TAI to test conversion."""
+    cfg.require_ipver(ipver)
     _qdisc_setup(cfg.ifname, "fq")
     test_so_txtime(cfg, "tai", ipver, args_tx, args_rx, True)
 
@@ -93,6 +95,7 @@ from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
 @ksft_variants(_test_variants_etf())
 def test_so_txtime_etf(cfg, ipver, args_tx, args_rx, expect_fail):
     """Run all variants of etf tests."""
+    cfg.require_ipver(ipver)
     try:
         _qdisc_setup(cfg.ifname, "etf", "clockid CLOCK_TAI delta 400000")
     except Exception as e:
-- 
2.54.0

