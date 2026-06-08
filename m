Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA0352013
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939997; cv=none; b=gbxLMgJT/fWPV3R+JapPpOL17c/MXahmxDhIk1xZ8s1qHov6REd/mzbCXeuBSKvwF5zs/mPKoeLbhOTEyELMy3H1hKkJ8dfbCunA+TGvYJnb6xJirI70JokLKd7ZlubWYeSMa1GTTCtVKVwWAmbgSg0L0Vp64O9Qw5BqSD7VPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939997; c=relaxed/simple;
	bh=Eky4V1HhvRVfbg1RJIt+LIyGWm19sueySJ5hBLj8uRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDyVSfkkzCNOxng1fMsMB/hgWX8YTvK52aV/OOORhT4PyBNVVfJif7MXKNVK9DyHriv3ottG/AvAS/ZlPJ+6ql+g55WU64hqV1gXHMtbdZrNOLhgjNN9gtBN5JC+i0pCBfzEMArPVb5p9ZBJteUvQp1+YY2LV8fXXNhMNUSuBqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hpi+bsye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hpi+bsye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9637F1F0089B;
	Mon,  8 Jun 2026 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780939995;
	bh=QZGg6+zMOS1CYP+ntugAKQk1GIfcAEdDrsYd/TpBkvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hpi+bsyelz7NCSXV0wd04aXDpQ96En24/gMwHb/1jrjkYE5+1FzT7LNqEtwRBRidb
	 ZJA09yqxXS/JyTHfkP9u14TpmByu8ksQ9hQyig274EhwJNTn5/fqQCd39oINlmF7nF
	 vt5N1SR/86etMGOjG3f0rfn3U27+y0Bb+Qz8DNL0hpGAo2FX1Iv+gqG9Gd1HW97FXH
	 DRJbN79IcvnbY125EPNNH7r1mFOgsh05OwU/MWMXuNB7Ng8pSwkzwJ7mbycWmLd+45
	 PnQd4owl4yfV4He6Wv9Uz6xSpObWWUR827ofye3+SolozpbdLMJXry2UezO6+2d2FM
	 EOAqe1FpHSSkQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] selftests: drv-net: so_txtime: check IP versions
Date: Mon,  8 Jun 2026 10:33:05 -0700
Message-ID: <20260608173305.372987-3-kuba@kernel.org>
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

This test needs more work, and it fails in non-obvious way
when IPv4 connectivity is not available:

  # Exception| CMD[remote]: /tmp/vjquwblf/gukinuzqso_txtime -4 -c mono -t 1780939014114542914 -S None -D None a,0 -r
  # Exception|   EXIT: -15

Explicitly check for IPv4 support to make the future triage
less painful.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/so_txtime.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
index ddcd2c0e06a8..8fe061f52055 100755
--- a/tools/testing/selftests/drivers/net/so_txtime.py
+++ b/tools/testing/selftests/drivers/net/so_txtime.py
@@ -64,6 +64,7 @@ from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
 @ksft_variants(_test_variants_mono())
 def test_so_txtime_mono(cfg, ipver, args_tx, args_rx):
     """Run all variants of monotonic (fq) tests."""
+    cfg.require_ipver(ipver)
     _qdisc_setup(cfg.ifname, "fq")
     test_so_txtime(cfg, "mono", ipver, args_tx, args_rx, True)
 
@@ -86,6 +87,7 @@ from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
 @ksft_variants(_test_variants_etf())
 def test_so_txtime_etf(cfg, ipver, args_tx, args_rx, expect_fail):
     """Run all variants of etf tests."""
+    cfg.require_ipver(ipver)
     try:
         _qdisc_setup(cfg.ifname, "etf", "clockid CLOCK_TAI delta 400000")
     except Exception as e:
-- 
2.54.0

