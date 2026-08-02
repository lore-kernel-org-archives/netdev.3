Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D122F3AC0FD;
	Sun,  2 Aug 2026 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785670849; cv=none; b=NfATbCzlAUGX49rxg6PtimyuTkNpB+T482mrxtcPH8dqb0Ra/hQeoFk2VTFw4rO4g1g7ZxKFCreL9ZeM8IQDBURF2wk6CculiCwwrqfDWn8SKdJ6DOhitCkS3c6B9jPtU4Zh7V1QESQtfwjjX1da5Osz1WF4UQSqOhbpDLBm0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785670849; c=relaxed/simple;
	bh=Vjy6vcEm26EQ3ME0NeL54LP3nL8x1XKhpziD1b0fIbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OSMU+e0f0/3ivPcXjbCcwgGH1u7or1SfOFLA19CjXskG/6sNyUgRc1Auxr5VRW9e9eO+T2JGcMaYubdwseDZkAtv6M3EGCPl2P8jOTkn2pk8NXZmyOhF/zb6Vk84wpE7q0Vb3EG3KJJNB6H0+H5b5x2SwpP7zSSG3AxmvXGKhMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JaqMTTBD; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JaqMTTBD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BEFF44E4109E;
	Sun,  2 Aug 2026 11:40:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 73C526029B;
	Sun,  2 Aug 2026 11:40:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 71A1311C1757D;
	Sun,  2 Aug 2026 13:40:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785670825; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=VxVdnKc+/FhAvBYsYt2BDF3N409QLaiV2tmViDCNuLY=;
	b=JaqMTTBDcaKTn/CzASTnwfG/jYpGkbF/IzGwgYv7uZOk7FDd8hwdoly7MQFTI+rZ/gM46B
	2Af2aKmlqwDp7jVFpFMXQ3TQGCjG9iazVMW/Kwc2QsEVwHQgAafKlV9OxeHzQFjf+fNzPI
	HKywCTO814Ka+P5rw5JbrxHikVI2N8bgzVpwy4IHvIsXaZSJJXLRoLnWZ4+eNvDoOdVXt4
	yjDiNddKZ57mBUGH6sTSRs4errjxeYl+fmW3eNKOc1lo4L3VmkMntTIvNsTpHhGdltgMaJ
	sGl/2tbfcBgETDq9GdPnzMRGy8ltOGI7gbiaHM00zpmL7H/FFQ+b/mH5zc/jrQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 0/2] net: stmmac: Cleanup rx coalescing computation when using RIWT
Date: Sun,  2 Aug 2026 13:40:12 +0200
Message-ID: <20260802114015.214212-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Currently when configuring interrupt coalescing on devices that relies
on the Receive Interrupt Watchdog Timer feature of dwmac, the
computation of the RIWT timings leads to off-by-one values when
reporting the timings back to userspace.

RIWT works by arming a watchdog timer upon receiving frames with the RI
bit not set in the descriptor. The timer duration is expressed in units
of 256 stmmac clock ticks, and therefore requires a bit of computation
to derive it :

riwt = (rx_usecs * n_clk_ticks_per_usec) / 256

and conversely

rx_usecs = (riwt * 256) / n_clk_ticks_per_usec

This computation as-is leads to a consistent off-by-one when setting
then getting back the rx-usecs value due to rounding errors (by truncation):

ethtool -C eth1 rx-usecs 42
ethtool -c eth1
 -> reports rx-usecs: 41

Let's use DIV_ROUND_CLOSEST instead for the computations. It does have
one side effect, the accepted boundaries for rx-usecs also shifts by one
now, going from [16us, 246us] to [15us, 245us]. For that reason, I'm not
targeting the net tree here, and it's overall a very small issue.

Maxime

Maxime Chevallier (2):
  net: stmmac: ethtool: Comment the magic numbers in RIWT computation
  net: stmmac: ethtool: Address off-by-one when reading the coal
    rx-usecs

 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.55.0

