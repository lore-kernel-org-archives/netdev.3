Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBD6386458;
	Fri,  3 Apr 2026 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775207278; cv=none; b=Fjo7ffQTPx06XU3vsu1ojhTb2CSXQskEXB95Fb1mRhCUW7liouDUTNww8ziEQu1pgk93wG1q+hW+IrKyqVC8l0bX0lzAop99tDEGBz2NhJxxIAbVfMoPVwPeAfODJAsAhu8cprq2NlC7Q0ZKEItQlu0M+c8g7VNz5TUXw5eJeoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775207278; c=relaxed/simple;
	bh=Ou3V0Yq9IiL+x5/jL9G2V0wQDpGIAZCQtkYrgVs3H8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkB6JBKG5ape+KmtjeA3AvFmwH2MvFZGNvxP5e8EbCgCP5XP04IPlgFDARWb0iC0kzCNAMnKjW5J5xfStdfvD4VnOqxtiYEnDXpKSLlyYGFfUjGaRK8adkmYv8umRWN8sWRmlJWTwxe71ONpBjlzzg9dHbn9FTshMUPO/r0XEQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=pPogtjpf; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="pPogtjpf"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C3DFA5896;
	Fri,  3 Apr 2026 11:07:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775207262; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=VUnhP9CIeSJarBTzcsknHlQTmW1S3OZHd1O3zU2CgGY=;
	b=pPogtjpftS4JJpyBp++vjU9BtfSe5s75m/w8PVxDcKWG23R9oxlrsPm6V5jRDORMA+7o2Q
	Z3frljFIbrOTtBHUyhc8GvzDJpGpi27aFDZEpjwEwpAgmWtj/p+YBjP8znWYPqGa8uEpuR
	gYge6pWBMcKC3LIqPIruwQrOcsKNaE8+c3PVz1v3MF5Ot4zQFu6Glncq8mhy/Re4OiVmMP
	JEzanRtJdXrNAEqTG0mM9LwxsikFFbt74ov3ifZfwMfnN7zCQerwB3zLyZi2zrMG4uLyR7
	dAC3F3Vo0kS8Z6uKAwleaxo18gAbFgDlSP4Do/b0hDQ9QIM6cpA/TV9drC+nmw==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Daniel Braunwarth <daniel.braunwarth@kuka.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Issam Hamdi <ih@simonwunderlich.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 3/3] net: phy: realtek: convert RTL8211F to .disable_autonomous_eee
Date: Fri,  3 Apr 2026 11:06:53 +0200
Message-ID: <20260403090656.733985-4-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260403090656.733985-1-nb@tipi-net.de>
References: <20260403090656.733985-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 023e47ad605b..b7c96b020baf 100644
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

