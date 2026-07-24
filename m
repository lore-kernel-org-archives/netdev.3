Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B013AFB1A;
	Fri, 24 Jul 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878622; cv=none; b=NYtBagUDFPAAPTjF06kdu1Ki0DLYzgp2hd+4XsEyoISkdoucZl9rsMDBRCo5cJlTrLm0CFvnUfClni8Qmkfwh96OaBf0nczteqMqyRSl1MlCA/l6M5lbDKSpajq3bAZS9nLqUFLdxrnJ13CwqQtGKsSGaUmVYVS44iMjJmDLdEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878622; c=relaxed/simple;
	bh=ab6Rr5GO91mjk8oKOpJcmX5aThprr1KeInjVzYkD4QE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WLpAlo6P8Z/aW5XqkCKQUyiCDc+/lQuFeu2S3rvHFWeLwKMYEE3at9F5ZmnU28+n+eaBv/K9L4YinA7Rqkml+MD2RAEuBHg5ArPGVR0gkxA5ABANM1CZb6qyOkxAamTUtrKhu5P88fChay3qI+iWW9O+QtZQDIOH3LVun/01PVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=1D9DxFSM; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=EUgloJFN; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="1D9DxFSM";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="EUgloJFN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878618;
	bh=ab6Rr5GO91mjk8oKOpJcmX5aThprr1KeInjVzYkD4QE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=1D9DxFSMqQ0tfg1VGpr5U3yHHYorFGKh6SlByaZdAZ27EJ9LoGxM4TTu3X9GozlPe
	 hcYPdpae90l0EnUyiIcORufjQUW015z3yRmCuEhSfE1raapzKR2YSVZDO1E9T1UdRN
	 YTfjWjWS+xiQPjfYABHGqMw7h4LX4F076xFk2ij4Rlqo28af22LIxrwHKm+BxFQPi/
	 oUm3n2iv9a4VvbOJ6ROHrTJr82ZsOEukb7JympYEqddVkB8Q8w80euHhyM3J0CrTLO
	 ske681338B2zGl5OJlbR/Ip8l1WSsYDW0oD/6Shg294VI4XFwJxVWFyfT3TJ+h80BR
	 N/649OeiCv0Lg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 378C449442; Fri, 24 Jul 2026 07:36:58 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878608;
	bh=ab6Rr5GO91mjk8oKOpJcmX5aThprr1KeInjVzYkD4QE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EUgloJFNQey5aBWJDHySQSkVhKfUFbXygaC1sHIF4vpk9MWhAW2P7CXkGFot8L8nl
	 6tZ/KjoemHB00BGDWrrhRJWREH2VIs2R6BJ18ykZx9xKCi3WbEhXh25k0fUbNDbn5I
	 SAff9Uzt0LtExvJpiV21bwFYKMeJb6DD2YooETtxW1KYjwy55Ek0T8DGVCARrU4uC+
	 NBROIkY9Dtv1kfCMzdrUQUEDzG2RbKT1+ir6PS52pKCWPwlGRv7oth/tyCb1cGe34P
	 RpGaIa3XBaaQsuAH9sWLygUJvT0x6cTV0MFg8wzNRRYUyyXWKj8ju7epqL9Q3XahxR
	 xQsA9zwnMwGuA==
Received: from DebianDesktop.lan (p200300c69f1c3c00ecd187824fbc6faf.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:ecd1:8782:4fbc:6faf])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 476D5493E6;
	Fri, 24 Jul 2026 07:36:48 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 24 Jul 2026 09:36:49 +0200
Subject: [PATCH net-next v3 06/13] ax88179_178a: EEE setup for
 AX88179A-based chips
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ax88179a-v3-6-bdde4f905883@birger-koblitz.de>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
In-Reply-To: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2

Add EEE setup for AX88179A-based chips. For these
chips we enable EEE by default. Adapt the ax88179_chk_eee()
EEE status verification function to also support AX88179A-based
chips in order to make sure the initial setup leads to
a correctly identified EEE status.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 60 +++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 136d1d39bf78658758d35372d4a9486e21befd87..8ea16d1231037832e12f74e2c5304ee4b7a54389 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -999,7 +999,17 @@ static int ax88179_set_link_ksettings(struct net_device *net,
 static int
 ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
 {
-	int val;
+	struct ax88179_data *ax179_data = dev->driver_priv;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = {};
+	int val, ret;
+
+	if (ax179_data->phylink) {
+		ret = phylink_ethtool_get_eee(ax179_data->phylink, data);
+		/* AX88279 MAC does not support 2500Mbit EEE */
+		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, mask);
+		linkmode_andnot(data->supported, data->supported, mask);
+		return ret;
+	}
 
 	/* Get Supported EEE */
 	val = ax_read_mmd(dev, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
@@ -1025,9 +1035,14 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
 static int
 ax88179_ethtool_set_eee(struct usbnet *dev, struct ethtool_keee *data)
 {
-	u16 tmp16 = linkmode_to_mii_eee_cap1_t(data->advertised);
+	struct ax88179_data *priv = dev->driver_priv;
+	u16 tmp16;
 
-	return ax_write_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, tmp16);
+	if (priv->phylink)
+		return phylink_ethtool_set_eee(priv->phylink, data);
+
+	tmp16 = linkmode_to_mii_eee_cap2_t(data->advertised);
+	return ax_write_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_ADV2, tmp16);
 }
 
 static int ax88179_chk_eee(struct usbnet *dev)
@@ -1037,6 +1052,7 @@ static int ax88179_chk_eee(struct usbnet *dev)
 
 	mii_ethtool_gset(&dev->mii, &ecmd);
 
+	priv->eee_active = 0;
 	if (ecmd.duplex & DUPLEX_FULL) {
 		int eee_lp, eee_cap, eee_adv;
 		u32 lp, cap, adv, supported = 0;
@@ -1054,10 +1070,8 @@ static int ax88179_chk_eee(struct usbnet *dev)
 			return true;
 
 		eee_adv = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_ADV);
-		if (eee_adv < 0) {
-			priv->eee_active = 0;
-			return false;
-		}
+		if (eee_adv < 0)
+			return true;
 
 		adv = mmd_eee_adv_to_ethtool_adv_t(eee_adv);
 		lp = mmd_eee_adv_to_ethtool_adv_t(eee_lp);
@@ -1065,16 +1079,13 @@ static int ax88179_chk_eee(struct usbnet *dev)
 			     SUPPORTED_1000baseT_Full :
 			     SUPPORTED_100baseT_Full;
 
-		if (!(lp & adv & supported)) {
-			priv->eee_active = 0;
-			return false;
-		}
+		if (!(lp & adv & supported))
+			return true;
 
 		priv->eee_active = 1;
 		return true;
 	}
 
-	priv->eee_active = 0;
 	return false;
 }
 
@@ -2667,14 +2678,27 @@ static int ax88179_reset(struct usbnet *dev)
 	ax179_data->eee_enabled = 0;
 	ax179_data->eee_active = 0;
 
-	ax88179_eee_config(dev, false);
+	if (ax179_data->chip_version < AX_VERSION_AX88179A) {
+		ax88179_eee_config(dev, false);
 
-	ax88179_ethtool_get_eee(dev, &eee_data);
-	linkmode_zero(eee_data.advertised);
-	ax88179_ethtool_set_eee(dev, &eee_data);
+		ax88179_ethtool_get_eee(dev, &eee_data);
+		linkmode_zero(eee_data.advertised);
+		ax88179_ethtool_set_eee(dev, &eee_data);
+	} else {
+		ax88179_eee_config(dev, true);
+		ax88179_ethtool_get_eee(dev, &eee_data);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, eee_data.advertised);
+		if (ax179_data->chip_version >= AX_VERSION_AX88279)
+			linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, eee_data.advertised);
+		ax88179_ethtool_set_eee(dev, &eee_data);
+	}
 
-	/* Restart autoneg */
-	mii_nway_restart(&dev->mii);
+	if (ax179_data->phylink) {
+		phylink_start(ax179_data->phylink);
+	} else {
+		/* Restart autoneg */
+		mii_nway_restart(&dev->mii);
+	}
 
 	usbnet_link_change(dev, 0, 0);
 

-- 
2.47.3

