Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210372EFDA4;
	Mon,  6 Apr 2026 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775459714; cv=none; b=gnU1oOtZGk1hm0z7ODhJ5vF6M9R3opHgFR+GCummzateFAcWs16pI+BsVuW4j3YamCA5X38yhrNL1Ghsj5+h5xYb4Spb5CNpPWcjn1R7Rxcab+0fnojXRjojTccX1VE0MuLHYLGn3T/54TE0CSkV6HRDc5aJ8Mcw7oXjMiMg8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775459714; c=relaxed/simple;
	bh=Pjf1imxacRlgp7F+6sqrlta9RQxhyVo8mmvv+p5eYFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EyTcxWjhbC3mX1YY3U8azk/xD/R8mTHEauBAVf93nxOIe5eUNaKEQ/WS/DBjQukttXU9XHm1eT9I6YM0g9VTtCuhQv4GDr7dWnBpTLDBeHKrobbcouc8R2v/6XB8RQoLh15OCK5NqX6gbnPAeA9fRgKxZsVrjkrVgZYsnUUtovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=YKSM50g2; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="YKSM50g2"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BC5CA58A2;
	Mon,  6 Apr 2026 09:15:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775459702; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=A8YKvQ1MvmfEeJEmpDewULi8pG3k+dSPUFy29NKHrJA=;
	b=YKSM50g2rQlPi2Vq7oN8Nl5hjlVQDK1A0rbn/rSi4QMNhXH8RlXOPSWahkKt/rZtCuKmTm
	mrqSirl/2pNKpIr5dRFEUIiy7N9weBqRUaOeeIkGMkudAyJRVJBtDTzktfILEDUErNpSI3
	li/9Cg+UCWnAbNX9gYiK4UImtTtTKAw4WUiAjkfnB7XnpsTES3kVl0ocEef82BY9k9/RXo
	mPy4/J/dlckft876irZqh3laS5yhUNy6tZB99ZJ3jIZz6hjTn5ZPygMFFrqqYeH9mCZn9H
	zmfyigXh1iu/lq1mgss2jVDXT1zCOyRkltih9KOj0cKZYC252Mja6ex2UnAJcQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 06 Apr 2026 09:13:09 +0200
Subject: [PATCH net-next 3/3] net: phy: realtek: convert RTL8211F to
 .disable_autonomous_eee
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-devel-autonomous-eee-v1-3-b335e7143711@tipi-net.de>
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

The RTL8211F previously unconditionally disabled PHY-mode EEE in
config_init. Convert this to use the new .disable_autonomous_eee
callback so it is only disabled when the MAC indicates EEE support
via phy_support_eee().

This preserves PHY-autonomous EEE for MACs that do not support EEE,
while still disabling it when the MAC manages LPI.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/realtek/realtek_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 023e47ad605bde57287d3da8b80c47d97d898b96..b7c96b020baf6f2ae8c5fe71d1fc3cbf7c6e2bc7 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -700,9 +700,8 @@ static int rtl8211f_config_aldps(struct phy_device *phydev)
 	return phy_modify(phydev, RTL8211F_PHYCR1, mask, mask);
 }
 
-static int rtl8211f_config_phy_eee(struct phy_device *phydev)
+static int rtl8211f_disable_autonomous_eee(struct phy_device *phydev)
 {
-	/* Disable PHY-mode EEE so LPI is passed to the MAC */
 	return phy_modify(phydev, RTL8211F_PHYCR2,
 			  RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
 }
@@ -730,7 +729,7 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 		return ret;
 	}
 
-	return rtl8211f_config_phy_eee(phydev);
+	return 0;
 }
 
 static int rtl821x_suspend(struct phy_device *phydev)
@@ -2324,6 +2323,7 @@ static struct phy_driver realtek_drvs[] = {
 		.led_hw_is_supported = rtl8211x_led_hw_is_supported,
 		.led_hw_control_get = rtl8211f_led_hw_control_get,
 		.led_hw_control_set = rtl8211f_led_hw_control_set,
+		.disable_autonomous_eee = rtl8211f_disable_autonomous_eee,
 	}, {
 		PHY_ID_MATCH_EXACT(RTL_8211FVD_PHYID),
 		.name		= "RTL8211F-VD Gigabit Ethernet",
@@ -2340,6 +2340,7 @@ static struct phy_driver realtek_drvs[] = {
 		.led_hw_is_supported = rtl8211x_led_hw_is_supported,
 		.led_hw_control_get = rtl8211f_led_hw_control_get,
 		.led_hw_control_set = rtl8211f_led_hw_control_set,
+		.disable_autonomous_eee = rtl8211f_disable_autonomous_eee,
 	}, {
 		.name		= "Generic FE-GE Realtek PHY",
 		.match_phy_device = rtlgen_match_phy_device,

-- 
2.51.0

