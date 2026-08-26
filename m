Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267E63C1090;
	Wed, 26 Aug 2026 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753132; cv=none; b=UOSiHwsh3TrpefT6rJrPofuB8DPCQxjAvM/Q9H44G7ckiJfOCJAZcmHzt/zh3DRmsNvt+0WGd8973Ro/klHdPSyH6q4PQwrqbtydogCMDA2Zp4fS6xmXmJhX59X/RyA/8WAROhj0L63708QfSWIbYpEyTC6ggwW1z7eaVa+/a9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753132; c=relaxed/simple;
	bh=wMZ3zdjuEmxaXf9Jx5bIuFR4PBN9IYnWOls2LFmIIBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bx4DZ0Fe+a6QGvSxBqOs6UGKgIEpLi1zx43jFWPj/VPMsSwxkl7MHoWr13e61cGs029OJsMv9CnbFhHXBbhz1PYkzbbsA4PBqYpzCsC2tCATqPGARDKNXuPKZTkGoNeKwtvLLg/V7j2wDgNk4RD8nFvIXdNOWARyeTxbRxurpts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FfjLbO66; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FfjLbO66"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 96F354E413C5;
	Wed, 26 Aug 2026 14:05:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 63D0C604EC;
	Wed, 26 Aug 2026 14:05:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF0B511C78266;
	Wed, 26 Aug 2026 16:05:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787753127; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Zzj4GVc4/x2SELeaKUar7dAIv8TFPTU4PPNQ7zCE1Ak=;
	b=FfjLbO664rsEBix13EAJ7rDB6BedWoXbIoLiMiDoGGVO9GskY0XSHj0MNByvCpwj/BC4MH
	H5q5XGbiBe/WvP8CGoLk1+m+OlWSAIhEiggprCjdKirInkVJekII270a1bc9Gi2twAk/aC
	Wu5fCfpKA2egZZol0QidPvAQipS15aUTMgs/VkS4ljodqE6bs/6i2JgUofj5E5WUJf1c96
	AjiDE3E8daeVA1fZv7QEGqQWT9b3Zz3l0QXZ0rW41JtZWWaRgtX844qbH/nEIv45mjx2+/
	xj/AJrxpYZUwynLVQMdss3HRmWj5uMRvP5ZVP1m9mgCjXqurDNKvCnwI4dXGig==
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
Subject: [PATCH net 2/6] net: stmmac: dwmac1000: Account for the primary MAC address for UC filtering
Date: Wed, 26 Aug 2026 16:04:54 +0200
Message-ID: <20260826140500.616466-3-maxime.chevallier@bootlin.com>
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

Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index caac85fc08f1..d4ace3924891 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -194,7 +194,7 @@ static void dwmac1000_set_filter(struct mac_device_info *hw,
 	dwmac1000_set_mchash(ioaddr, mc_filter, mcbitslog2);
 
 	/* Handle multiple unicast addresses (perfect filtering) */
-	if (netdev_uc_count(dev) > perfect_addr_number)
+	if (netdev_uc_count(dev) + 1 > perfect_addr_number)
 		/* Switch to promiscuous mode if more than unicast
 		 * addresses are requested than supported by hardware.
 		 */
-- 
2.55.0

