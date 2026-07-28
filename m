Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA6D32AABA
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254267; cv=none; b=PgVfMV3vm6XdHQMnzfZ8Ln+ts+Lyy7lCVQHyNWTFBGIAElgA70raEHxd2q8j4oMW6uUtxdqbBDwqJ3K1Dgt76RcJ6l+/NJZjGt2tlYcT9trWyMtSmdm6HEAG4TJ9KR2DRi2J8XmaocKBRpmWECFrc/7vRR3ELD/AtTDFJjZE/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254267; c=relaxed/simple;
	bh=/vIy1rng1IpBtF5NAwo6m7593DPfimAnZg90l6ceYRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RcpoyyPdTuUHaTZCQdn9RMIm0BpkDg5jcRh6Ih8hUQSx2hGkTpz9hyNsX/rEq3+DtN8/jjpusvHKf5HpKxrZQLesTZmBeFcCR6XnBKkmSelWW5PjzFbG3oYxiQnv4O6b3wMl9WHEYaHiVjw170KWGCjPQOHKxJAiQZGpdTGJGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eCcoP5rj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eCcoP5rj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4A0FA4E40FB1;
	Tue, 28 Jul 2026 15:57:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1AF10601BF;
	Tue, 28 Jul 2026 15:57:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D60711C142D9;
	Tue, 28 Jul 2026 17:57:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785254256; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=NX+Wy/vDiqR9J8JJ3ihFc2hXFzc/UpLSMUDAQjn3ZY0=;
	b=eCcoP5rj2l6Xhv5GPrVixILoLWrrfqlydlZfBNH5jI3VqxztFG9OJTcHx9jQRwhKb07OHr
	PL7HvRVg/rMbvSbyBpLWRnteB6H5kj+QcA99F75YrTNuDhtNhI83i08kjEHuWtePJWgiEk
	KYWxBs8oHnh4h7YC9ApTJYZGt2TFQjFUyJbhXkmbMMzmhi8goEFp2E/4RKXJmm0u0qZ0Sf
	PlDaMN9EuphIH0v3KLt44uR4cK6cxGNie+zplBZEFuhqMHDU5ixvuz5LqiqO+D809VKUHD
	0HikKlnwUZxdy5WyX+DEhD5/PE6cP8qakofy/BPTavq+Ypo/sbjyGDiVYYerwA==
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
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Zxyan Zhu <zxyan0222@gmail.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 0/2] net: stmmac: only use MAC loopback for selftests
Date: Tue, 28 Jul 2026 17:57:25 +0200
Message-ID: <20260728155728.1193169-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

stmmac selftests currently use PHY loopback when a PHY is attached, and
fallback to MAC loopback otherwise. PHY loopback however isn't ideal nor
necessary for the tests we are running, that only stress the internal
stmmac features.

Some PHYs bring the carrier state down when in loopback mode, which will
prevent any packet transmission even for ourselves, making selftests
fail for non-stmmac related reasons.

Let's rely only on MAC-side loopback for selftests, making it clear that
any problem found with stmmac selftests are indeed caused by the stmmac
driver, and not external factors.

This was tested on :

 - Cyclone V with RGMII link to KSZ9031
 - Cyclone V with 1000BaseX
 - imx8mp with RGMII link to KSZ9131
 - stm32mp157& with RGMII link to RTL8211F
 - Allwinner H2+ with an internal PHY

Maxime Chevallier (2):
  net: stmmac: Don't use PHY loopback for selftests
  net: stmmac: Don't rely on the PHY for flow-control testing

 .../stmicro/stmmac/stmmac_selftests.c         | 117 ++----------------
 1 file changed, 11 insertions(+), 106 deletions(-)

-- 
2.55.0

