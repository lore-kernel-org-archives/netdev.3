Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCCC43DA27;
	Mon, 29 Jun 2026 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753836; cv=none; b=gfShpIK8YC3q6pTqTLB+vnvdgm504XHeQA6F+Uu0/2cY/pgI8m6TMug4tvTPCL8KGIfXnbtbEiUNCKRqkdz/VDwqqfHI6VQTH1PK6V/B/7UV5wvLtYhka+X4B43PzRMURytT8e7TfmWiSbZ2kmL0CUUj+hOhCSyFBz7DdF39Q/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753836; c=relaxed/simple;
	bh=f9pd5sfQd/b4Few40x+aRTW745nRwbGdQ11nESr9tpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QMF+WvsLC0c+ZgUlGjkX9hc4YHPiaTtW+CmV3RiR+GxjixcNNTTYByBnmO4+bpEw/R28CGWk76GKwStDy9sUb4syJcQlIwuL8fcD55rBgOer6e31Kmg7yh/lqJRNr8Db1TowytyBT8d+PHQqav7e9l+1mZ2HcneIJOcZaCgaE7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaQUB33W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaQUB33W"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1AC8C2BCF5;
	Mon, 29 Jun 2026 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782753835;
	bh=f9pd5sfQd/b4Few40x+aRTW745nRwbGdQ11nESr9tpY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aaQUB33W3g73rWbHJzDrJUh9jXOxI8DdVxYVhim145nFDKvYYLiT7jtcJd2uoE+SA
	 6hZ176j9yrN4s+gHnmqX5Eh9k4qecp6dQiiDRaS/IHwNar68G0XO2uSHdRAR7BZQim
	 zlffgTmimR+P2TejdESj+eMOj8NiGKSU4HQ9dJUtCTntEZVTMpC+tkJ0JnDgBucNmb
	 3Pqjp150ztsEJYBzeN4YeGMc/6oTYjkLCG2SxmSquhXTSol6mZ+2GIrZ0UZ7bSRntT
	 PfjWL28R9lbUsglGxpmRdZ9PfbRyabYNF8CZ6tN4gRtwQFMFbhn/SZ9qLJ7SqnOfkV
	 lC07U4qr5Lv1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C507C43638;
	Mon, 29 Jun 2026 17:23:55 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Mon, 29 Jun 2026 10:23:32 -0700
Subject: [PATCH net-next v6 02/15] net: phy: Helper to modify PHY loopback
 mode only
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-s2500-mac-phy-support-v6-2-18ce79500371@onsemi.com>
References: <20260629-s2500-mac-phy-support-v6-0-18ce79500371@onsemi.com>
In-Reply-To: <20260629-s2500-mac-phy-support-v6-0-18ce79500371@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782753817; l=3379;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=hMIbVwaKFuafgqzYxUbUppCDDkeDK8PcrFXQu+sNb/0=;
 b=EUA5cYQklRL1+fwztEoz0HVQpKShKK608HJyhyxWb18m3htklKK1vT+t+SPGXvfm0C7T709GJ
 ss5Ofne198eAH1KxgRgrkfBMhjGMXyw6qR3EdxngRxHOAVZbXhq6ISF
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Generic helper function to modify loopback bit of the PHY without
modifying any other bit. This will help the PHYs that may have fixed
speed, like 10Base-T1S or PHYs that don't need any other settings
to set them in loopback mode.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v6
  - No change
changes in v5
  - No change
changes in v4
  - Created a new genphy API to set the loopback. No other PHY
    registers touched.
---
 drivers/net/phy/dp83867.c    | 11 +----------
 drivers/net/phy/phy_device.c | 20 ++++++++++++++++++++
 include/linux/phy.h          |  2 ++
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 88255e92b4cd..01ea2e8dd253 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -991,15 +991,6 @@ static void dp83867_link_change_notify(struct phy_device *phydev)
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
@@ -1204,7 +1195,7 @@ static struct phy_driver dp83867_driver[] = {
 		.resume		= dp83867_resume,
 
 		.link_change_notify = dp83867_link_change_notify,
-		.set_loopback	= dp83867_loopback,
+		.set_loopback	= genphy_loopback_fixed_speed,
 
 		.led_brightness_set = dp83867_led_brightness_set,
 		.led_hw_is_supported = dp83867_led_hw_is_supported,
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b82b99d08132..11fd204eea16 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2842,6 +2842,26 @@ int genphy_phy_write_mmd(struct phy_device *phydev, int devnum,
 }
 EXPORT_SYMBOL(genphy_phy_write_mmd);
 
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
index 8266dd4a8dbe..61bcd71a3143 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2301,6 +2301,8 @@ int genphy_read_mmd_unsupported(struct phy_device *phdev, int devad,
 				u16 regnum);
 int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,
 				 u16 regnum, u16 val);
+int genphy_loopback_fixed_speed(struct phy_device *phydev, bool enable,
+				int speed);
 int genphy_phy_write_mmd(struct phy_device *phydev, int devnum,
 			 u16 regnum, u16 val);
 int genphy_phy_read_mmd(struct phy_device *phydev, int devnum,

-- 
2.43.0


