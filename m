Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A1E318BA4;
	Mon,  6 Apr 2026 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775459712; cv=none; b=NzkPvybpGSVI9qrZ10v0/oOMzxmFDczyGDu5VcYsGzFJqvSgrx25U6fINx5YyO+d8EL1TH8bGbZ8/wnqzm0SAZRMoUTbY0PPHVVBQdZ6YOa5i3sekaplAqwZVaZmqRh5WHvn+iLJ7V21ZftmFAt7q97b8buVgzjGpvhW3JNiR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775459712; c=relaxed/simple;
	bh=oluNBLJIAf7pgfFcAVZ2vBDg8WBqD3uI1uGdZwky+mE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kOnmMIeOXY2pzPXO0ayYMh6dbCkgfb7hQpSgKrJ+O3Ri1CqnSBimW4mcv6gQx2HGsLLPTmX1bcus2T7EhTkOEc1vmdeyeieNeC2fd5MoBgAP3No1qaqGeMXpdJXYZiRNaqXGT2Y7GvOSUN9AyPbs4JJ2fWr6JSKQx/WedPT7geI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=c+bzaFE/; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="c+bzaFE/"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9947DA589F;
	Mon,  6 Apr 2026 09:15:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775459702; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YshDxVGpw6ziDI13UG9S1kJ/62BST6CYMZsBO712L7o=;
	b=c+bzaFE/gkBdakr7ZOOOBQGaA/9tpVxOywokKLQdtUQC3ka6GLh4hEzc31KqYT4txHUMjq
	wXIE1k9gFfXbL0rka0iTcQPitrmK2VYrhDpNbZ93N60H0Hn4UWB7tm6DT3WK6EOVS0AKIA
	hTeD9w1l/gAYwL5oojT7rUSsyZOOmbW07FUFupxIkPmjbXxcoMMKAdACj7+Z2MNHOOAzKR
	1RVKkTXmXa9CB0P/m5aRk9n0VVt231eVFG9qdyV8f2i25vqoKFbvt1GgvFKGnM/ReEllvz
	5qfKiQJQsNVuDqfaYptZot9Ebg5ROfq97AYU9eJmSfpWWKpFl7Wrdcoj78XLCA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 06 Apr 2026 09:13:08 +0200
Subject: [PATCH net-next 2/3] net: phy: broadcom: implement
 .disable_autonomous_eee for BCM54xx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-devel-autonomous-eee-v1-2-b335e7143711@tipi-net.de>
References: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>
In-Reply-To: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Implement the .disable_autonomous_eee callback for the BCM54210E.

In AutogrEEEn mode the PHY manages EEE autonomously. Clearing the
AutogrEEEn enable bit in MII_BUF_CNTL_0 switches the PHY to Native
EEE mode.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/broadcom.c | 7 +++++++
 include/linux/brcmphy.h    | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index cb306f9e80cca6f810afcab967923dd1896638dd..bf0c6a04481ee23110e249118bbe086ffe8e7a8f 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -1452,6 +1452,12 @@ static int bcm54811_read_status(struct phy_device *phydev)
 	return genphy_read_status(phydev);
 }
 
+static int bcm54xx_disable_autonomous_eee(struct phy_device *phydev)
+{
+	return bcm_phy_modify_exp(phydev, BCM54XX_TOP_MISC_MII_BUF_CNTL0,
+				  BCM54XX_MII_BUF_CNTL0_AUTOGREEEN_EN, 0);
+}
+
 static struct phy_driver broadcom_drivers[] = {
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_BCM5411),
@@ -1495,6 +1501,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.get_wol	= bcm54xx_phy_get_wol,
 	.set_wol	= bcm54xx_phy_set_wol,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
+	.disable_autonomous_eee	= bcm54xx_disable_autonomous_eee,
 }, {
 	PHY_ID_MATCH_MODEL(PHY_ID_BCM5461),
 	.name		= "Broadcom BCM5461",
diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 115a964f3006965e9bfd247eb969b9ca586ae675..174687c4c80a8b12eb841cdb4e8865813bb34adc 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -266,6 +266,9 @@
 #define BCM54XX_TOP_MISC_IDDQ_SD		(1 << 2)
 #define BCM54XX_TOP_MISC_IDDQ_SR		(1 << 3)
 
+#define BCM54XX_TOP_MISC_MII_BUF_CNTL0		(MII_BCM54XX_EXP_SEL_TOP + 0x00)
+#define  BCM54XX_MII_BUF_CNTL0_AUTOGREEEN_EN	BIT(0)
+
 #define BCM54XX_TOP_MISC_LED_CTL		(MII_BCM54XX_EXP_SEL_TOP + 0x0C)
 #define  BCM54XX_LED4_SEL_INTR			BIT(1)
 

-- 
2.51.0

