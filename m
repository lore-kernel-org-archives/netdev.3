Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD96217723;
	Thu, 30 Jul 2026 00:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785370500; cv=none; b=kW6BEbZ5Xwbjp/mJsWVb/IRR9hDAmF4le4Lk2wPSinpPIylOKWz8JHT5SBFm85ekiZH1MjqMjYW6gPY37xHuptwmrE0VIpJAERoanhirtTx9ywQMpJrQ3uR94eF8BOLj/sHMXaZ/ml7FyIL+N1hOScMDj89U8gAFrRpnI3P7GgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785370500; c=relaxed/simple;
	bh=Ux88rPlT64mc1DzpYFWfYdC54U3Kfck630XvxlvSlQU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1p3spZIZ4j4/N8FU/P+BkXbtaov+x4t0o94aHSphGJsJ/13ro5cfeKEd84GhmoekHtt9fZCvf6PWvgJZRwjWCgPUCsCoM7MTldqruBWm0YePEXvChsbdyScZrs6k4BtAecI/spPZSlSqlTNcCT2jtiYQ0ZjO9I/JAn1+kA85vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wpEQ6-000000002eZ-02Hr;
	Thu, 30 Jul 2026 00:14:42 +0000
Date: Thu, 30 Jul 2026 01:14:38 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sean Wang <sean.wang@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Landen Chao <Landen.Chao@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 1/5] net: pcs: mtk-lynxi: check regmap reads in
 mtk_pcs_lynxi_get_state()
Message-ID: <b58d5d99dddd67e35a6f14a14a6ad63d8b3fbadc.1785368701.git.daniel@makrotopia.org>
References: <cover.1785368701.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785368701.git.daniel@makrotopia.org>

mtk_pcs_lynxi_get_state() ignores regmap_read()'s return value; a
failed read leaves bm and adv holding uninitialized stack values
which are then decoded into the reported link state. The regmaps
backing the MT7531 SGMII PCS instances sit on an MDIO bus where
reads can fail. Check both reads and leave the state untouched on
error.

Fixes: 4765a9722e09 ("net: pcs: add driver for MediaTek SGMII PCS")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: new patch

 drivers/net/pcs/pcs-mtk-lynxi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index a753bd88cbc2..454f2924831c 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -113,8 +113,9 @@ static void mtk_pcs_lynxi_get_state(struct phylink_pcs *pcs,
 	unsigned int bm, adv;
 
 	/* Read the BMSR and LPA */
-	regmap_read(mpcs->regmap, SGMSYS_PCS_CONTROL_1, &bm);
-	regmap_read(mpcs->regmap, SGMSYS_PCS_ADVERTISE, &adv);
+	if (regmap_read(mpcs->regmap, SGMSYS_PCS_CONTROL_1, &bm) ||
+	    regmap_read(mpcs->regmap, SGMSYS_PCS_ADVERTISE, &adv))
+		return;
 
 	phylink_mii_c22_pcs_decode_state(state, neg_mode,
 					 FIELD_GET(SGMII_BMSR, bm),
-- 
2.55.0
