Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9FB2E5D17;
	Wed, 21 Jan 2026 02:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962234; cv=none; b=OEYU9upbGVqAiObQ187cI+bwMH2omm8m7WHwxLIdFWbxdeMJptQDT8Hhx9kdc/3TAYEjg+px9HqEMkjGcMVqYav9UGe/o9UHmR1kB2gL59IwFgkchfw2Ahj27qHR5Ehe1/ndusQtwGpbqOyEnvW7rva1JHqtnXzPDM+IqF95u0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962234; c=relaxed/simple;
	bh=CKOHjyop5bzBcQ7AWiafp4LeVOsqvMElzBYKbYY7Qk8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NNCinwPdcSqD+gSx0nu6e6Df3wezbzrLE1ViCePSUtTWtcYsuc4lbE5LXvKJHFaDZ5m8zcVwF38v+DI+ik6vcS+pIFkdX1Rsfeg25EqOrH1SOHzJOyt0HEL0G8B253IZ6AmMrNf9wl5EeEGI7REFWSQ14Zj9Hc6vbtggl8sZHaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1viNsX-000000008F4-1FWG;
	Wed, 21 Jan 2026 02:23:29 +0000
Date: Wed, 21 Jan 2026 02:23:17 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Axel Gembe <axel@gembe.net>, Josh Bendavid <Josh.Bendavid@cern.ch>
Subject: [PATCH net] net: pcs: pcs-mtk-lynxi: report in-band capability for
 2500Base-X
Message-ID: <b1cf26157b63fee838be09ae810497fb22fd8104.1768961746.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It turns out that 2500Base-X actually works fine with in-band status on
MediaTek's LynxI PCS -- I wrongly concluded it didn't because it is
broken in all the copper SFP modules and GPON sticks I used for testing.

Hence report LINK_INBAND_ENABLE also for 2500Base-X mode.

This reverts most of commit a003c38d9bbb ("net: pcs: pcs-mtk-lynxi:
correctly report in-band status capabilities").

The removal of the QSGMII interface mode was correct and is left
untouched.

Link: https://github.com/openwrt/openwrt/issues/21436
Fixes: a003c38d9bbb ("net: pcs: pcs-mtk-lynxi: correctly report in-band status capabilities")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/pcs/pcs-mtk-lynxi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 149ddf51d7856..87df3a9dfc9bc 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -93,12 +93,10 @@ static unsigned int mtk_pcs_lynxi_inband_caps(struct phylink_pcs *pcs,
 {
 	switch (interface) {
 	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
 	case PHY_INTERFACE_MODE_SGMII:
 		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
 
-	case PHY_INTERFACE_MODE_2500BASEX:
-		return LINK_INBAND_DISABLE;
-
 	default:
 		return 0;
 	}
-- 
2.52.0
