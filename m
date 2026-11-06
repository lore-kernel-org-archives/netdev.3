Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794007140;
	b=jL6jyQo8YfX+DhH+3wslIBXT1Nm1EWpnLP8NQt9TwHinKPuXyL5cnjeC7eeUKhqX8GMR
	 WS89F5HxiTjnp1RxPdO7wy6dJqxOCq4EmCWRIVRb5WyelptSTRPOifuvBE3T7PU4B/Ooy
	 1wBa31WeRjfZgEosrOStCz2J0bMCb7gwOtOEWwxVNdDZWzVZrmgk+EbA4cZXz3TW8V5M3
	 g+T7UvWlfu7GEvxmlJcIPJaX4NCH/V6sybGAwPrBLkMoXHCIYMDELEXoh2HskV0Uv1P8w
	 47OPAm5avmSxbBPj43zHXU+nasOIENNQBLX3MKlNyTiYKFWLCPdQGXF91gfaZBzseSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007140;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=h5vXh23939zDZgdNv8k7wjuT6ZlEGeCBgyeIH3zt9CU=;
	b=HLT/xTPt7K4Ew+kQfyt2j5WLCqbZvpM/g12gRcrUP60sdIEezt1V/9Ph5ijtpBGql9Al
	 mNK/19AFanECh/Vbrk/eJyIoEsSrTSfVhWYF1k+ImXjdPLFrEcK55bce3F3TBoogMZOTR
	 WkSrsKRKfDBn1E8kk9y5waV4MzRl+fXXwxcxZEsrmDooCoDhlooSGP8Ca2GfXk7cbNbBd
	 YRx992ybwc8/ERw5PHkxjNFGa4ThykwDOyaDVLmGQUIITpdBHORuVdWYXPall0t/wxj/o
	 guULwomdPlAOkcDozesXp9A1xPGx9bHbXzLpLSjM7HbBU6UhhqIw9rCukzZznO6hdCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VuUSSF0t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2BA606D81E;
	Fri,  6 Nov 2026 23:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VuUSSF0t
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794007140;
	b=ZrEzoyku203h53/8wiGyv97cgCn9VRTQNNtfYdu0IP6jNGRi4J3jx9a4ALYhweMHHhnu
	 jmvrakx2maksQS+RPawJdsrr23rSttGMn9sryrSKoqhvjrKKlhoIzKGqZIEkn8yAczUuc
	 HOuBDDdrXAVrPd/JbX3FbWTV1x+1JU6/1iwI3o7kZ5Wju0f8G2ssd0JRTRBzkH/55M2Fa
	 ztFeyyreYC6WSllDFFySLOy/uv4Pe168xWRUAcf0ZbF16RqosZUqAC1xzykPhS0MUGgvL
	 QGe6YDhnHkE9kE00hXAq0qWTnEp6vG2Er8wiAvcM88sNjn5OT0w79jOGoy2w0HLBeBw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794007140;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=h5vXh23939zDZgdNv8k7wjuT6ZlEGeCBgyeIH3zt9CU=;
	b=168m+w88hmy6x7iw2AnnQApLJbGNAqHuwq1hm29MX9+KuiFNHASR0pBhGVihP1WEnSRs
	 XKC5K7Ui5qqmNYyzXdVxMz+0tS4gyVlO0ugZ65Sj5mL1Dvi0b9hBBlHQnwTj7kyRvmZS/
	 +EVirUQ+7YdmDaO7QmHo/S+19Y/lwewAGdQlMW2OjAARxbSgRVrSPkC5jK2icLEXAF9kv
	 mI/+Cuz5gSoZit8nXAXZK5EdD5rFM/Z1UkManhU9L2RGGwF31yeimjdyBc+1ZWQ9KPskA
	 Eoay0Hp9y4N8gVBtJUw/Jpujk0o1o1y0jsA8gvzUuHn6cdNVn/jTeKPRiQH0yiE8GQw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E5F2E1F00906;
	Fri,  6 Nov 2026 23:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794007140;
	bh=h5vXh23939zDZgdNv8k7wjuT6ZlEGeCBgyeIH3zt9CU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VuUSSF0tMY/CfC0yeFVMhsLvpSwfZ2SqlxT/2pVxX5UG6GCPg/+dGy3t8yR8t8V+9
	 IXk3husAwvzI83Y7EvSoE7Wtp2sixLfs3kmk1pSESzKPCwjdFTnTXZcM5lGMaSjF9i
	 C30VaEJCysk2gGHzpmIGi+dqMs+sIKAmjJFXpVPIYYWRtxB9myQwFGpQVA41YfQLaN
	 JLg0KrQv3+GS7wXcya7NpiYeZgKQO1OzImpxaLdQHaHTPao9e2ToBPpQi9NLAlEd3P
	 os/3qprTrxijZLeNIQMWGB8dwHHQt5nEgwWeya+YoHbllyzruHDgOmEyWOJpScvXJs
	 S2SbM3azE95bg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 86D8F47904;
	Fri,  6 Nov 2026 23:18:55 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 06 Nov 2026 15:18:57 -0800
Subject: [PATCH net-next v10 11/11] net: phy: ncn26000: Support for
 loopback
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-s2500-mac-phy-support-v10-11-31b5a69b85b7@onsemi.com>
References: <20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7@onsemi.com>
In-Reply-To: <20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794007133; l=4702;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=FSneJImmnVX4oXj9Hfm3wTCQItvR55UDG8WF8wwHYF4=;
 b=l/xBqtKQeNbFTGsHvUFItQdH4GGKPVfedvfNoW7y3brokWB7GZP8bPD/BFJ/KHkesE36pqoSp
 w+wsMy7XYgtDhH1S17vaZa/zzr+/7NqRZiawGxDioYejNOjEGCo3ENj
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 7bit

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
changes in v10
  - No change
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
index 0006e157917d..c115af6eda33 100644
--- a/drivers/net/phy/ncn26000.c
+++ b/drivers/net/phy/ncn26000.c
@@ -176,6 +176,7 @@ static struct phy_driver ncn26000_driver[] = {
 		.config_init           = ncn26000_config_init,
 		.config_aneg           = ncn26000_config_aneg,
 		.read_status           = ncn26000_read_status,
+		.set_loopback          = genphy_loopback_no_speed,
 		.set_plca_cfg          = ncn26000_c45_plca_set_cfg,
 		.get_plca_cfg          = genphy_c45_plca_get_cfg,
 		.get_plca_status       = genphy_c45_plca_get_status,
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 06c5a8c8cc2a..ffb6845d5b03 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2923,6 +2923,28 @@ int genphy_resume(struct phy_device *phydev)
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
index 21afc2082b17..6e57f83757bb 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2317,6 +2317,8 @@ int genphy_read_status(struct phy_device *phydev);
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


