Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491AD455629;
	Fri,  9 Oct 2026 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565947; cv=none; b=qY11xM7IB36/cx8WbFV+BKO1q1Tffrzwq8TzToaRhtfMrVCnJQ+axYHre4sm8+9FBZI04icEuWfjm+xqBKTrpKqxozQQSNDzvQ8Y7nBJVNSybmI417rNxrNUrCkYxHtqVxNZcDomBdreGCds5kziOFdOFIhwnju4X3qKTzCjKg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565947; c=relaxed/simple;
	bh=GX6eB15GhoLmG5kfNk6Y4EN25aJZHpNXijcGtsblGjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sps2A7qS+ef2/EmWamkM2BFg2CY8dXET8sYbQvZefF37VBgBZyvIzb8/7Q3e6ULt1vrKeIdjCVYvtcssi4B4Mr2j87yYg7YzfTsWCEnzBzXn7WIw66eZxM7Jg49UQremMO/caN81SQBAu5RQntySc6c269fUcN4vyVEOaMv6vnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3/zqYUE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3/zqYUE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D18DEC4DDF8;
	Fri,  9 Oct 2026 17:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791565946;
	bh=GX6eB15GhoLmG5kfNk6Y4EN25aJZHpNXijcGtsblGjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=k3/zqYUErzkGE9I0RincxzMAiWwkiWCm5KgjMpe20g+KFHFMMoQRZkWgt8BybNlIj
	 Vzg55VS7gzqlYuwTy1aqCccYE2w0QUGZWuGM0nHTzgjq2yRI3y6bDtqBWt6TBnsSR5
	 PHz0Ia0K/2y8MI/QzX2xLGIy+RGFAXxIjVkTGBrC4RrGf/+FkSHROaY+Q4pu7J5HGe
	 M1WJwE6cVCuLhTlGT0hA5iNzeprJq02dFjuUa2xJ5f1M3bdXekJJlUD6+VZpuR3HMI
	 rNSqlC0VR8YyJuJeR+t9IufZkQJUJs2DkDO+yuvc4RSW7tOKFjK8EN+Ckim+jThffr
	 QmWJIGenK7thA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7312CA9EBE;
	Fri,  9 Oct 2026 17:12:26 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 09 Oct 2026 10:12:31 -0700
Subject: [PATCH net-next v9 11/11] net: phy: ncn26000: Support for loopback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-s2500-mac-phy-support-v9-11-dcefe1d0bf0d@onsemi.com>
References: <20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d@onsemi.com>
In-Reply-To: <20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@kernel.org>, 
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791565943; l=4676;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=9ZJxd6nzeh5RKc2O1fpSz5xPc3nBv1Df11hJFSZ3Tcs=;
 b=yUQI66Jb3qZBm3ggYqGcZlo5a4ogveyq08mYEo9/tGH30+NaCz52C/fQNmvTUBvjG6T6yTLx0
 /Zs3GxcYDTXDIBnrjZzzBwBrxRlg5FDFpEtvzX4JfVCgRrXfr56dvfR
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Adding loopback support for S2500 internal PHY to help running
loopback test through ethtool.

This instance requires only manipulating the loopback bit in
the PHY, without setting the speed. So, added a generic helper
function to modify loopback bit of the PHY only. This will
help the PHY drivers, like 10Base-T1S or any other PHYs that
want to handle loopback bit only.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v9
  - replaced "fixed_speed" with "no_speed" for the API.
  - Improved the comments to be specific about not setting the
    speed.
changes in v8
  - No code change. Changes were in two different patches.
    Merged into one.
changes in v7
  - No change
changes in v6
  - No change
changes in v5
  - No change
changes in v4
  - Moved the onsemi implementation to a new, genphy API to
    make it vendor agnostic.
changes in v3
  - Addd loopback functionality for onsemi's PHY driver
  - First patch
---
 drivers/net/phy/dp83867.c    | 11 +----------
 drivers/net/phy/ncn26000.c   |  1 +
 drivers/net/phy/phy_device.c | 22 ++++++++++++++++++++++
 include/linux/phy.h          |  2 ++
 4 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index a3cd5cb11ea0..a62667606422 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -1058,15 +1058,6 @@ static void dp83867_link_change_notify(struct phy_device *phydev)
 	}
 }
 
-static int dp83867_loopback(struct phy_device *phydev, bool enable, int speed)
-{
-	if (enable && speed)
-		return -EOPNOTSUPP;
-
-	return phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
-			  enable ? BMCR_LOOPBACK : 0);
-}
-
 static int
 dp83867_led_brightness_set(struct phy_device *phydev,
 			   u8 index, enum led_brightness brightness)
@@ -1292,7 +1283,7 @@ static struct phy_driver dp83867_driver[] = {
 		.resume		= dp83867_resume,
 
 		.link_change_notify = dp83867_link_change_notify,
-		.set_loopback	= dp83867_loopback,
+		.set_loopback	= genphy_loopback_no_speed,
 
 		.led_brightness_set = dp83867_led_brightness_set,
 		.led_hw_is_supported = dp83867_led_hw_is_supported,
diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index a33ebb2a7ece..de0fafda3876 100644
--- a/drivers/net/phy/ncn26000.c
+++ b/drivers/net/phy/ncn26000.c
@@ -178,6 +178,7 @@ static struct phy_driver ncn26000_driver[] = {
 		.config_aneg           = ncn26000_config_aneg,
 		.read_status           = ncn26000_read_status,
 		.handle_interrupt      = ncn26000_handle_interrupt,
+		.set_loopback          = genphy_loopback_no_speed,
 		.set_plca_cfg          = ncn26000_c45_plca_set_cfg,
 		.get_plca_cfg          = genphy_c45_plca_get_cfg,
 		.get_plca_status       = genphy_c45_plca_get_status,
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index bfce8b893644..03419f645587 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2791,6 +2791,28 @@ int genphy_resume(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(genphy_resume);
 
+/**
+ * genphy_loopback_no_speed - Helper to modify the PHY loopback mode
+ * without setting speed. Some PHYs, like 10Base-T1S, don't support
+ * auto-negotiation and therefore setting the speed isn't supported.
+ *
+ * @phydev: The phy_device struct
+ * @enable: Flag to enable or disable the PHY level loopback.
+ * @speed: Speed setting. Not expected to be set. Error if it is set.
+ *
+ * Returns: 0 if successful, negative error code on failure.
+ */
+int genphy_loopback_no_speed(struct phy_device *phydev, bool enable,
+			     int speed)
+{
+	if (enable && speed)
+		return -EOPNOTSUPP;
+
+	return phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
+			  enable ? BMCR_LOOPBACK : 0);
+}
+EXPORT_SYMBOL(genphy_loopback_no_speed);
+
 int genphy_loopback(struct phy_device *phydev, bool enable, int speed)
 {
 	if (enable) {
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7c5098a0dd6c..ea3505e49316 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2307,6 +2307,8 @@ int genphy_read_status(struct phy_device *phydev);
 int genphy_read_master_slave(struct phy_device *phydev);
 int genphy_suspend(struct phy_device *phydev);
 int genphy_resume(struct phy_device *phydev);
+int genphy_loopback_no_speed(struct phy_device *phydev, bool enable,
+			     int speed);
 int genphy_loopback(struct phy_device *phydev, bool enable, int speed);
 int genphy_soft_reset(struct phy_device *phydev);
 irqreturn_t genphy_handle_interrupt_no_ack(struct phy_device *phydev);

-- 
2.43.0


