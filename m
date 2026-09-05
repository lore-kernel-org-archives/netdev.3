Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1105F3C988B
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 07:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788593326; cv=none; b=H/JxKTndf44WCBK8U4h5Gk7R7m433va7NipOOP1u43d9NdHzq9QzjWl/LW65cf5WOt8E/3HJYDq/Qb+8DxHd4U2kq+SxlhzrBOPhHdcTuVHe+CjUbZYaffOwzUZ6wQbzUfKTeBNq72e7ctYgzlFQmUvKDlBSHqbHUiqBAIDV090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788593326; c=relaxed/simple;
	bh=yvO2xuF7yqeIG4o9Y1H7mEpJKouBvg/WAZv17RzBycU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DsQCa6Ec6P0NuzWSOUwyiNCnVfTZVYQTkRJuViB6z+sShhmbX0fAZkY59DPaeL2BUae+IIWLerA/qPrFUdDSXaAy9bPto3F1TvqqWCMKZQRoDAPrQwRatw3RpBHY8ZT9OJ4n7iyqE1dhuhC/nB8MJ8G1qG5KomT0uAoqJPCRvaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EQxouB3p; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EQxouB3p"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 379B44E41530;
	Sat,  5 Sep 2026 07:28:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EA37160580;
	Sat,  5 Sep 2026 07:28:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 94E6C11C787BD;
	Sat,  5 Sep 2026 09:28:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788593317; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=h4+27NX6f71aIYWGk8AUx1jZFXcAPxn0Psebvis+0mM=;
	b=EQxouB3pWOxWOJ1psr9a5YYC1X5PEYiJY/vlRQfgQND+bsUa8I3TeOTXoEIellRY7/lm9r
	arK8X9p3I9x0L32NiSChigzVJ1LxY9l7KuG7Z4QRQSznnji+nlHSMDg/65BLk5zDyKP2KY
	vuK1Pj8yGu4UT5EAqc02DvZAQVUGPK2mcl83cz7Yg+Ut/6PG4Wzf+q8Sq8PA21ldrqEUgu
	yR6vbxLVup82N2X+1zPvPl9T6h3RoFAQYR2h+LjXtLYIc7q1BSDuTXmKTvxmoCjlFM21PM
	mY5QbIjA4pXaTgMIS4sv1wfxYl/tBBzmMfXWAatoVSDYAPfwkI6dpv9AEvtFRQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Yao Zi <me@ziyao.cc>,
	Frank <Frank.Sae@motor-comm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next v2 0/3] net: phy: motorcomm: Enable analog frontend DAC on yt8531S
Date: Sat,  5 Sep 2026 09:28:25 +0200
Message-ID: <20260905072830.28986-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

This is V2 of TY8531S fixes for the YT6801 PCIe card.

It enables the analog frontend DAC at config_init() similar to what the
most recent vendor driver does.

Sashiko thought this would break after suspend/resume, this has been
tested and it's actually fine. This V2 just rewords a bit patch 3's
commit log, no other changes.

V2: No functional changes, updatede the commit log of patch 3 after more
    testing.

V1: https://lore.kernel.org/r/20260831073747.361482-1-maxime.chevallier@bootlin.com

Maxime Chevallier (3):
  net: phy: motorcomm: Split yt8521_config_init() page management
  net: phy: motorcomm: Add a dedicated .config_init for YT8531S
  net: phy: motorcomm: Enable analog frontend on YT8531S

 drivers/net/phy/motorcomm.c | 76 ++++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 22 deletions(-)

-- 
2.55.0

