Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5842586A
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753151; cv=none; b=LyDhzicTSdfic+IoW41QNRMZM4J1s/cVfOdIbzceWVJi6Bd2UC5fBz/jxpE3jJLnR/tkdB4x12h1KtrKgQSxv4RVWgHbkvOOuNCol1vY4cb8YzMJp82WV/h7fkZOrE5jZJXho7otVtWLaxF8Sd1xSEf06Un5ZEcawl4qUsP4/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753151; c=relaxed/simple;
	bh=eSFCFP0zuNBowA0TZRltKaMtk8o3TdazaBeRjmy0+zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRbgY+kal3S6KMiy/k0Dmic9TQVFr3/6dwY6U4CSWqRtwAs8NQ23eaMwcs1yGgGk8FbwMBF8G4m0ti7Ziq+Hf/yeMtRsPYwItTkkzt+Mt+HeLaOt1pv63E6CI4Dbdk75SgVNWob5CoA2U06uy2joy9+m3iTlrwAt5vwTupIXdYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=egoBnJPX; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="egoBnJPX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 085AB4E413AA;
	Wed, 26 Aug 2026 14:05:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CF529604EC;
	Wed, 26 Aug 2026 14:05:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 324CE11C781D1;
	Wed, 26 Aug 2026 16:05:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787753135; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=fQMkcPMV7Pc6LQCfAGg8QeshWvzbYRluiKAsXmZpmVA=;
	b=egoBnJPX8pVGNGJ/3jf09wwDrVpQYmxE6gK6/QaJtlZeKxJ+WJAIfQF2YrJLC7f6piN0F5
	lcV6WcOe6YGx1W0NDNsgFcATRifpBB4muA99d4y93wdedN1Z+S76KZ2v0ciqIZZJ+Up1EW
	CFyhdymQ9roAP6C9WeoMK1wWJkGzEF/QAm0DjnKJQelv5Bnpf2W4/jllHqX7LCtqs5EkhK
	tCiP4dpfIbxyS4XVAJPWmiHBpHzvFNN0UwDtKi4+BdRj5bRu140TDpuekylvhauMyqifwN
	fVL3P5dEpIFZUgT/EQFCs8dBcqGqwfgx5etPpsiVUzBHUcsXTymZbGPbe/ET8Q==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Minda Chen <minda.chen@starfivetech.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Jose.Abreu@synopsys.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net 4/6] net: stmmac: dwxgmac: Account for the primary MAC address for UC filtering
Date: Wed, 26 Aug 2026 16:04:56 +0200
Message-ID: <20260826140500.616466-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
References: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The same filter slots are used to store the main MAC address as well as
the address for the unicast filter. Let's account for that when deciding
whether or not to use promisc when programming the UC list in hardware.

Fixes: 0efedbf11f07 ("net: stmmac: xgmac: Fix XGMAC selftests")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 52054f31376d..fc6ddb51c682 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -532,7 +532,7 @@ static void dwxgmac2_set_filter(struct mac_device_info *hw,
 	dwxgmac2_set_mchash(ioaddr, mc_filter, mcbitslog2);
 
 	/* Handle multiple unicast addresses */
-	if (netdev_uc_count(dev) > hw->unicast_filter_entries) {
+	if (netdev_uc_count(dev) + 1 > hw->unicast_filter_entries) {
 		value |= XGMAC_FILTER_PR;
 	} else {
 		struct netdev_hw_addr *ha;
-- 
2.55.0

