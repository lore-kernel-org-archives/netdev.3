Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.19.166.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792610330;
	b=ZBmYXB7oX7DNdKRujROgGUtYzLP8IHFcuuampKz49EhXVkwbKEXYYx0tDaKgs7UKtZl+
	 hZPwTbnkIVsYIpzCUSB/kOpwtNQtWNIbASOlhylc9SPvWZtIpYgjbGsCffJxZisFjH/rs
	 Fjjq4Vs2wJn4onuU75ZvgHXtyIsgBB1/jkrHkWMZ1pFWwCU7/VPOjI1fVJloSPqMUBqpc
	 4cKP0izNX6ueddLfu3cMokar2JSy2Dw0e5TjHckgP7DR9vX2qpneCbRMRzkmHjqWBVNtz
	 GEUii+BNN6YvzmQbOnvgNz/ka7MOBE36iZq8lh3yCveS81sFJKubgT4qAs4gON0d5Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792610330;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OucDXYhGBdXsYkzJOkUEznMM0q6yUkDYhETeuLwQ0h8=;
	b=blTd/V5eIZbMDPaK4PxbuLL9fSyka739JYe9sjxnO6qTfa7XEnwHAOoTIvxtM+LHQeRT
	 goPKZsQF0wSRF6dBR6roByNwqupEixkWnIMSXm0yStPwuvFCRHPJLwRhwzxetN5Zq1Z4m
	 gnhu/T+2TI8mJsjkq6rYGANsON0cdDaefx/7OL/5HZnZAtK7OW4IsRClJssZu23RQBdS/
	 s3OBvishnwiDGIXigjJz9/XiTG/uPiS3xZ7YKiMg4E8SRabWfneUry6Vru0JkRDxAbsFR
	 x1e0yon3JHw3K40b3bS4LhdfmObfKxCH0+ZJRxCfu28B2pfuAuxsFk8jzKRqlUeqVxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=pU2qWWe3;
	arc=none smtp.remote-ip=192.19.166.231
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7522C606A31A;
	Wed, 21 Oct 2026 19:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7522C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=pU2qWWe3
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8C47CC0000F1;
	Wed, 21 Oct 2026 12:18:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8C47CC0000F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1792610314;
	bh=vWvEu/RfvOC0QwKLXxbS5OZwUmUR+Xg2d6zwPiE0S20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pU2qWWe38LLLCu4HsYEmZ7YHskv5aK+PSfARg7PnynP+cln/mndTuDdhBzwr3zOqi
	 XS+nBlyMS8NTkjhgbsxd7FfRvTPjmtFrFT6FvtnDvo2qIv/ezd3nt3VGeGnPurrJ4p
	 6WwxoV2cnYxCgMf39Pnsyq0/tQjHsUKyLZ2lyp/o=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 745CAAEA3;
	Wed, 21 Oct 2026 15:18:33 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 3/6] net: dsa: b53: constrain SerDes interfaces to initialized PCSes
Date: Wed, 21 Oct 2026 12:18:21 -0700
Message-ID: <20261021191824.752309-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021191824.752309-1-florian.fainelli@broadcom.com>
References: <20261021191824.752309-1-florian.fainelli@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Publish the supported interface bitmap on each successfully discovered
PCS and use it for capability reporting and PCS selection. Clear the
parallel interfaces inherited from the common switch code on ports whose
mux selects a SerDes. A failed discovery must not leave a usable serial
interface advertised without its PCS.

Stop advertising 2500BASE-X: the driver neither selects its baud rate nor
supports 2.5G in the MAC override code. The downstream robo SerDes speed
setter likewise only implements 10/100/1000. Keep SGMII and 1000BASE-X on
both lanes until a complete 2.5G programming path is available.

Report discovery failures at the SRAB port to make missing capabilities
diagnosable.

Fixes: 0e01491de646 ("net: dsa: b53: Add SerDes support")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_serdes.c | 28 ++++++++--------------------
 drivers/net/dsa/b53/b53_srab.c   |  9 +++++++--
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_serdes.c b/drivers/net/dsa/b53/b53_serdes.c
index 87771e3788f7..d521050d7c8f 100644
--- a/drivers/net/dsa/b53/b53_serdes.c
+++ b/drivers/net/dsa/b53/b53_serdes.c
@@ -273,24 +273,11 @@ void b53_serdes_phylink_get_caps(struct b53_device *dev, int port,
 	if (lane == B53_INVALID_LANE)
 		return;
 
-	switch (lane) {
-	case 0:
-		/* It appears lane 0 supports 2500base-X and 1000base-X */
-		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
-			  config->supported_interfaces);
-		config->mac_capabilities |= MAC_2500FD;
-		fallthrough;
-	case 1:
-		/* It appears lane 1 only supports 1000base-X and SGMII */
-		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-			  config->supported_interfaces);
-		__set_bit(PHY_INTERFACE_MODE_SGMII,
-			  config->supported_interfaces);
-		config->mac_capabilities |= MAC_1000FD;
-		break;
-	default:
-		break;
-	}
+	if (lane >= B53_N_PCS || !dev->pcs[lane].dev)
+		return;
+
+	phy_interface_copy(config->supported_interfaces,
+			   dev->pcs[lane].pcs.supported_interfaces);
 }
 EXPORT_SYMBOL(b53_serdes_phylink_get_caps);
 
@@ -304,8 +291,7 @@ struct phylink_pcs *b53_serdes_phylink_mac_select_pcs(struct b53_device *dev,
 	    !dev->pcs[lane].dev)
 		return NULL;
 
-	if (!phy_interface_mode_is_8023z(interface) &&
-	    interface != PHY_INTERFACE_MODE_SGMII)
+	if (!test_bit(interface, dev->pcs[lane].pcs.supported_interfaces))
 		return NULL;
 
 	return &dev->pcs[lane].pcs;
@@ -351,6 +337,8 @@ int b53_serdes_init(struct b53_device *dev, int port)
 	pcs->dev = dev;
 	pcs->lane = lane;
 	pcs->pcs.ops = &b53_pcs_ops;
+	__set_bit(PHY_INTERFACE_MODE_SGMII, pcs->pcs.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX, pcs->pcs.supported_interfaces);
 
 	return 0;
 }
diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index 9988a83fa7b7..77e81e1a414a 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -451,9 +451,11 @@ static void b53_srab_phylink_get_caps(struct b53_device *dev, int port,
 
 	switch (p->mode) {
 	case PHY_INTERFACE_MODE_SGMII:
+		/* The mux connects this port to a SerDes, not a parallel bus. */
+		phy_interface_zero(config->supported_interfaces);
 #if IS_ENABLED(CONFIG_B53_SERDES)
 		/* If p->mode indicates SGMII mode, that essentially means we
-		 * are using a serdes. As the serdes for the capabilities.
+		 * are using a SerDes. Ask it for the supported interfaces.
 		 */
 		b53_serdes_phylink_get_caps(dev, port, config);
 #endif
@@ -588,8 +590,11 @@ static void b53_srab_mux_init(struct platform_device *pdev)
 		case MUX_CONFIG_SGMII:
 			p->mode = PHY_INTERFACE_MODE_SGMII;
 			ret = b53_serdes_init(dev, port);
-			if (ret)
+			if (ret) {
+				dev_err(dev->dev, "port %d SerDes unavailable: %pe\n",
+					port, ERR_PTR(ret));
 				continue;
+			}
 			break;
 		case MUX_CONFIG_MII_LITE:
 			p->mode = PHY_INTERFACE_MODE_MII;
-- 
2.53.0

