Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76063A6B6A;
	Fri, 24 Jul 2026 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878620; cv=none; b=llQwK1dKJjHg+6c//VKJS2J8cYmXOTI+eRusJPSe9qNiDpHlo9/UosRp8YlEoQRsiydU6oNsa15ltyRuNAh7bhA8FL08qvqO61gjNZ+5lyHC1CuTsNho7EsBFQQi1okw+IyVhE1WiHHHAmnOtP8S8FNOjxfi7JgDGwCAohbO8JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878620; c=relaxed/simple;
	bh=yS8ryxRoVmRaiU+ueTVr4cmgbVovhgnOfgoWXRpaOBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ddGZlAwMq9mdPrOao3kfnscvP5w9XGBQw3fljyIVRJk65Izg3WmmuYDB3v7icT7rN98Kr7gzfqlyjYjLphlQuNil64RrCL5K0TFL1Rm5eLH0YzU+Kt2Hmdrth64Fxb5px8fLkygL4Kxl/zj+4WKFKAFb10IwrGaFQCI8lKQxaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=XbaGcsDi; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=opIs15cI; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="XbaGcsDi";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="opIs15cI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878616;
	bh=yS8ryxRoVmRaiU+ueTVr4cmgbVovhgnOfgoWXRpaOBM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XbaGcsDiHrHfyZcM+kUUxuhKCUziECbD+PB1IkOgRlh9w+QkuTpW0HjVY+cfl2vCl
	 assB9m441QcNZ7+3yg+pfMQjo6I8cltFqsPO/fkdN/4lFWL4XPhd4DEGbo5GO+YTZ+
	 YdwpofrVTiZxnSsnVnFZ2SghhS791GIlztPtNcNc0vl87kwJKKywGE/kpVO7clYq7u
	 zMQobIjpGoIf/jMwTLesOHvdSGYM+QayyREOj1KQtRYeTnfkxSU6UWnVO1poexYzZI
	 810R9IPLHTFJtSBL/891KRaljO61p7E1QO/3v/ODNoOUNDHdyhbWhz4a8VLHmG2U/j
	 ZDVj2LE4CGw0Q==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id DC73A49448; Fri, 24 Jul 2026 07:36:56 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878607;
	bh=yS8ryxRoVmRaiU+ueTVr4cmgbVovhgnOfgoWXRpaOBM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=opIs15cIZ0l2EI/6DapLrmJ/ZP6PF4NP5xYWWaifa8Qha3WvjlTLk21s+OQfMbA1x
	 9Whnbw7N73js9qRhJH2Rapt054oi8ZjGk6Db7n9808P7CxQCVUEEqNXpxpZ/MDTpiA
	 Z57vmTVc9RuHEwJns+IJnj0/zOw9XmDLk8RjAaLoPxqjNKWMfVJF1y60lEy83rq+Mj
	 snxktaB1zi+VFf530W/gdxaSyo40BcUbv/chdjoLuTGEN3Gx17g4YQloFnpWAKViQN
	 CTsSM6XIzy+UJsVvB1AzncqFLACVpoGDWVO2uqn48vL+3NG2njFcEkDW1TKjDBuRP4
	 7Vq6RtP9PgpDg==
Received: from DebianDesktop.lan (p200300c69f1c3c00ecd187824fbc6faf.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:ecd1:8782:4fbc:6faf])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id AF4CA4932E;
	Fri, 24 Jul 2026 07:36:47 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 24 Jul 2026 09:36:47 +0200
Subject: [PATCH net-next v3 04/13] ax88179_178a: Add EEE HW configuration
 support for AX88179A
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ax88179a-v3-4-bdde4f905883@birger-koblitz.de>
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

The AX88179A uses a much simpler HW configuration for EEE
via a single EEE configuration register. Add support for
this register and replace the EEE enable/disable functions
with a single EEE configuration function which enables/disables
EEE in the hardware.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 71 +++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 39 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index b7837c7a89f9b5ee520ef1ae91bbc7619d1a12bd..2e2f96a97b8398ece7d70cf349c7db973959629f 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -36,6 +36,7 @@
 #define AX_RELOAD_EEPROM_EFUSE			0x06
 #define AX88179A_WAKEUP_SETTING			0x07
 #define AX_FW_MODE				0x08
+#define AX_GPHY_CTL				0x0F
 #define AX88179A_FLASH_READ			0x21
 #define AX88179A_FLASH_WRITE			0x24
 #define AX88179A_PHY_CLAUSE45			0x27
@@ -127,6 +128,9 @@
 #define AX88179A_VLAN_ID_DATA1			0x2D
 
 #define AX_RX_BULKIN_QCTRL			0x2e
+
+#define AX_GPHY_EEE_CTRL			0x01
+
 #define AX_CLK_SELECT				0x33
 	#define AX_CLK_SELECT_BCS	0x01
 	#define AX_CLK_SELECT_ACS	0x02
@@ -1061,46 +1065,35 @@ static int ax88179_chk_eee(struct usbnet *dev)
 	return false;
 }
 
-static void ax88179_disable_eee(struct usbnet *dev)
-{
-	u16 tmp16;
-
-	tmp16 = GMII_PHY_PGSEL_PAGE3;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
-
-	tmp16 = 0x3246;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  MII_PHYADDR, 2, &tmp16);
-
-	tmp16 = GMII_PHY_PGSEL_PAGE0;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
-}
-
-static void ax88179_enable_eee(struct usbnet *dev)
+static void ax88179_eee_config(struct usbnet *dev, bool enable)
 {
+	struct ax88179_data *priv = dev->driver_priv;
 	u16 tmp16;
 
-	tmp16 = GMII_PHY_PGSEL_PAGE3;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
-
-	tmp16 = 0x3247;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  MII_PHYADDR, 2, &tmp16);
-
-	tmp16 = GMII_PHY_PGSEL_PAGE5;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
-
-	tmp16 = 0x0680;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  MII_BMSR, 2, &tmp16);
+	if (priv->chip_version < AX_VERSION_AX88179A) {
+		tmp16 = GMII_PHY_PGSEL_PAGE3;
+		ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
+				  GMII_PHY_PAGE_SELECT, 2, &tmp16);
+
+		tmp16 = enable ? 0x3247 : 0x3246;
+		ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
+				  MII_PHYADDR, 2, &tmp16);
+		if (enable) {
+			tmp16 = GMII_PHY_PGSEL_PAGE5;
+			ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
+					  GMII_PHY_PAGE_SELECT, 2, &tmp16);
+
+			tmp16 = 0x0680;
+			ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
+					  MII_BMSR, 2, &tmp16);
+		}
 
-	tmp16 = GMII_PHY_PGSEL_PAGE0;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
+		tmp16 = GMII_PHY_PGSEL_PAGE0;
+		ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
+				  GMII_PHY_PAGE_SELECT, 2, &tmp16);
+	} else {
+		ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, enable, 0, NULL);
+	}
 }
 
 static int ax88179_get_eee(struct net_device *net, struct ethtool_keee *edata)
@@ -1122,13 +1115,13 @@ static int ax88179_set_eee(struct net_device *net, struct ethtool_keee *edata)
 
 	priv->eee_enabled = edata->eee_enabled;
 	if (!priv->eee_enabled) {
-		ax88179_disable_eee(dev);
+		ax88179_eee_config(dev, false);
 	} else {
 		priv->eee_enabled = ax88179_chk_eee(dev);
 		if (!priv->eee_enabled)
 			return -EOPNOTSUPP;
 
-		ax88179_enable_eee(dev);
+		ax88179_eee_config(dev, true);
 	}
 
 	ret = ax88179_ethtool_set_eee(dev, edata);
@@ -2661,7 +2654,7 @@ static int ax88179_reset(struct usbnet *dev)
 	ax179_data->eee_enabled = 0;
 	ax179_data->eee_active = 0;
 
-	ax88179_disable_eee(dev);
+	ax88179_eee_config(dev, false);
 
 	ax88179_ethtool_get_eee(dev, &eee_data);
 	linkmode_zero(eee_data.advertised);

-- 
2.47.3

