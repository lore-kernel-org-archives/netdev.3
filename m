Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26832503BC2;
	Mon, 28 Sep 2026 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790634325; cv=none; b=iKGPDAOK+PSsmN5VxVk2sdgPIA+LwKye8WdB+B+mjdomyVvrGF7fHXgygnpGhp6qKTWT/VSKAtMuLXTmTZFvkpnUqCeG0ntYcY9/dAhh+oSiBwt4tpr5zqvR/g24/xI+25+qhMFtXMLagMxMYdzTGQGsYl5m6AMNKq0DFDViM/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790634325; c=relaxed/simple;
	bh=Kyx96UT+vUpW+G3VAYfxLXH147lhZup63lxLaD8BqEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pcVXYniU6r7kloaFRa0Q/1U8ZJryNJFXeL1BGEh1ZRs02WeFBhotH8LxQ/+wJEc36Xnc1LGh6EItZ+NIa123UtmELKkNDCLmYRl+/4+O7jm5FbLJ1JtJcdud8aJqOaIDQPcihyFowxdNt1S5oL++UklZxSqBLW1W/amuMlCkfg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htDM5kXZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htDM5kXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD93BC4AF1C;
	Mon, 28 Sep 2026 22:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790634324;
	bh=Kyx96UT+vUpW+G3VAYfxLXH147lhZup63lxLaD8BqEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=htDM5kXZQKVoP7/HoBlBugYwJNa2b/dK7BGl/0K7h+S6UwY0b1IoEzXunKAqJatwk
	 +JNV5ZO7uCQbZbSTaxKaLLIQLwBxb9t1Jlz6BHRrnKYgGMbR5gryHNmBWnmmRZfhiR
	 D+c2prottoMCbiOIiCEbuIpgAkIeGyWXtt+Qy4e8yE0LyIPn3jOXnhTRmHqAUqzAj2
	 BlaAtRsXf7hz9YymhJNBtNQpafD6RTqQVutIf03QZgoQ06lovR+vIWEFq9MQQSeQwS
	 BGI7WxfRgOFVw77h9h//lSBgOC3BMYaTNwHn26z7PDvfm08zHdYrf7mSw2avONYP/t
	 3qGJgxCVqzhBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA01BCA5FA1;
	Mon, 28 Sep 2026 22:25:24 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Mon, 28 Sep 2026 15:25:16 -0700
Subject: [PATCH net-next v8 09/11] net: phy: ncn26000: Support for loopback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-s2500-mac-phy-support-v8-9-7e011aacc309@onsemi.com>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
In-Reply-To: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790634319; l=4389;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=lOEjUVu+sbtGOy+R7L3yJVmD0cVo5Vjh6MrNHClqnqw=;
 b=ZS2f7pdmHTjcRJKptqjPx/VMb9VUxvEcPrGpAwHsvTHu2Mp8qNOtHw3r21gd+7fxy96ub5AiD
 6modoVahROgBwM/iH733tLknKSfWF6ye/5QP14OZXEB2CwRobSxsxXk
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
the PHY only. So, added a generic helper function to modify
loopback bit of the PHY without modifying any other bit. This
will help the PHYs that may have fixed speed, like 10Base-T1S
or PHYs that don't need any other settings to set them in
loopback mode.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
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
 drivers/net/phy/phy_device.c | 20 ++++++++++++++++++++
 include/linux/phy.h          |  2 ++
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index a3cd5cb11ea0..38c17a68cf26 100644
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
+		.set_loopback	= genphy_loopback_fixed_speed,
 
 		.led_brightness_set = dp83867_led_brightness_set,
 		.led_hw_is_supported = dp83867_led_hw_is_supported,
diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index b362e85c7911..933cba6d00b5 100644
--- a/drivers/net/phy/ncn26000.c
+++ b/drivers/net/phy/ncn26000.c
@@ -178,6 +178,7 @@ static struct phy_driver ncn26000_driver[] = {
 		.config_aneg           = ncn26000_config_aneg,
 		.read_status           = ncn26000_read_status,
 		.handle_interrupt      = ncn26000_handle_interrupt,
+		.set_loopback          = genphy_loopback_fixed_speed,
 		.set_plca_cfg          = ncn26000_c45_plca_set_cfg,
 		.get_plca_cfg          = genphy_c45_plca_get_cfg,
 		.get_plca_status       = genphy_c45_plca_get_status,
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 5b13a74e2fa9..ca438d4e8fcb 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2775,6 +2775,26 @@ int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,
 }
 EXPORT_SYMBOL(genphy_write_mmd_unsupported);
 
+/**
+ * genphy_loopback_fixed_speed - Helper to modify the PHY loopback mode
+ * without affecting any other settings.
+ * @phydev: The phy_device struct
+ * @enable: Flag to enable or disable the PHY level loopback.
+ * @speed: Speed setting. Not expected to be set. Error if it is set.
+ *
+ * Returns: 0 if successful, negative error code on failure.
+ */
+int genphy_loopback_fixed_speed(struct phy_device *phydev, bool enable,
+				int speed)
+{
+	if (enable && speed)
+		return -EOPNOTSUPP;
+
+	return phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
+			  enable ? BMCR_LOOPBACK : 0);
+}
+EXPORT_SYMBOL(genphy_loopback_fixed_speed);
+
 int genphy_suspend(struct phy_device *phydev)
 {
 	return phy_set_bits(phydev, MII_BMCR, BMCR_PDOWN);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7c5098a0dd6c..c1b9bc305c82 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2327,6 +2327,8 @@ int genphy_read_mmd_unsupported(struct phy_device *phdev, int devad,
 				u16 regnum);
 int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,
 				 u16 regnum, u16 val);
+int genphy_loopback_fixed_speed(struct phy_device *phydev, bool enable,
+				int speed);
 
 /* Clause 37 */
 int genphy_c37_config_aneg(struct phy_device *phydev);

-- 
2.43.0


