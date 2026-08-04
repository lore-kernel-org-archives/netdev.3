Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC92374A14;
	Tue,  4 Aug 2026 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813040; cv=none; b=L9MNWSIct+0NE379DaUAQZPBQLHetgZwYhCtfVBbrUAT2coHd9cbP1LWJiT/dGsuqHZyz+aA4ZEYN3Uj5Agxs/b8ndxJKOnFmj0cG1pYNGUoGmvUGa6CUM06Zj4x5816/p8Z3LpdKG23kNwMIeyYAKNFFTunwiQ0tApUNGZbOFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813040; c=relaxed/simple;
	bh=GdKytPm8PE1w0pM4tKYHNtnMYIpH/kri9vhWbP0FBX4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUlhBkgQ5EbXui+Zh3xD03gmHRhapsWhYRxZz4XhAIg6fRDWiA2ljJxiYtvAhGGuMOxaK2oUyin+orjb+Qn+5l2oG6MgZp6maCI24ZYcjT8N3cO7VWRlBPz+gHklvwyfh2Rmfd4Wwho6EL51cZfjfGRsF/PpTGUPrJAxYm5ZUts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wr5Xx-0000000044C-22wS;
	Tue, 04 Aug 2026 03:10:29 +0000
Date: Tue, 4 Aug 2026 04:10:26 +0100
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
	Landen Chao <Landen.Chao@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 1/6] net: pcs: mtk-lynxi: check regmap reads in
 mtk_pcs_lynxi_get_state()
Message-ID: <fce70657fc03bbaf60a04c0fbf2f418531135c4f.1785811140.git.daniel@makrotopia.org>
References: <cover.1785811140.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785811140.git.daniel@makrotopia.org>

mtk_pcs_lynxi_get_state() ignores regmap_read()'s return value; a
failed read leaves bm and adv holding uninitialized stack values
which are then decoded into the reported link state. The regmaps
backing the MT7531 SGMII PCS instances sit on an MDIO bus where
reads can fail. Check both reads and report the link as down on
error; phylink presets state->link before the callback, so a bare
return would leave a failed read reported as link-up.

Fixes: 4765a9722e09 ("net: pcs: add driver for MediaTek SGMII PCS")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2:
 * set state->link = false on the failed-read path so a read error
   reports the link as down instead of leaving phylink's preset
   link-up (Sashiko AI review)

 drivers/net/pcs/pcs-mtk-lynxi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index a753bd88cbc2..7290fc3e5d18 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -113,8 +113,11 @@ static void mtk_pcs_lynxi_get_state(struct phylink_pcs *pcs,
 	unsigned int bm, adv;
 
 	/* Read the BMSR and LPA */
-	regmap_read(mpcs->regmap, SGMSYS_PCS_CONTROL_1, &bm);
-	regmap_read(mpcs->regmap, SGMSYS_PCS_ADVERTISE, &adv);
+	if (regmap_read(mpcs->regmap, SGMSYS_PCS_CONTROL_1, &bm) ||
+	    regmap_read(mpcs->regmap, SGMSYS_PCS_ADVERTISE, &adv)) {
+		state->link = false;
+		return;
+	}
 
 	phylink_mii_c22_pcs_decode_state(state, neg_mode,
 					 FIELD_GET(SGMII_BMSR, bm),
-- 
2.55.0
