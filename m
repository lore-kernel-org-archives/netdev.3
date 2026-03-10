Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A223BCED;
	Tue, 10 Mar 2026 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773103325; cv=none; b=Le+I6DTUsX6vpNSz4ORhUhiRlWiaGhpmh4ezttgElHSxUtKC/elc0h0x+DSTli55ha4p+yMhmrkqr8QDc3Vi9AnM/ZAEJvPA21RQdKubvXX53JUNH4uP6avlObuRjLLlg1uegsiTOYkIRwufOYmwT5yPnXLyeHnSlgwBISu9A3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773103325; c=relaxed/simple;
	bh=3UGAN9alfFAcKfXFuNs/0jsWd1TCRV+x1Qu8DY9QQsQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KYH0wpiulfweltzgIICWbsmoXiqLZtBhey1915xk09rIMofSQoM4ZFvGhxQaNTIypbk5HkVOPs57dO0H1CTqwR+1CZ1wzue0cyjGc1ynAacjnmETg16uziDLdZPiGSx/3THfhT6McP4nq73kvDwp/BItcdQ/PpMPNd3Myat8Uvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vzlAd-0000000084t-0cg9;
	Tue, 10 Mar 2026 00:41:59 +0000
Date: Tue, 10 Mar 2026 00:41:56 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: mxl862xx: don't set user_mii_bus
Message-ID: <0f0df310fd8cab57e0e5e3d0831dd057fd05bcd5.1773103271.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The PHY addresses in the MII bus are not equal to the port addresses,
so the bus cannot be assigned as user_mii_bus. Falling back on the
user_mii_bus in case a PHY isn't declared in device tree will result in
using the wrong (in this case: off-by-+1) PHY.
Remove the wrong assignment.

Fixes: 23794bec1cb60 ("net: dsa: add basic initial driver for MxL862xx switches")
Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mxl862xx/mxl862xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index b1e2094b58165..d7ab04f5afefd 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -149,7 +149,6 @@ static int mxl862xx_setup_mdio(struct dsa_switch *ds)
 		return -ENOMEM;
 
 	bus->priv = priv;
-	ds->user_mii_bus = bus;
 	bus->name = KBUILD_MODNAME "-mii";
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(dev));
 	bus->read_c45 = mxl862xx_phy_read_c45_mii_bus;
-- 
2.53.0
