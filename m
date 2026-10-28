Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793172653;
	b=DKmq09UZBiWM/JihXM8NFBsIYlQsEkKR7d8dDEOLumtHKFtkjI0Ya0mKZRRLUKmX3A0B
	 BuZVpNFsI9cj8dpaTn9bfezDbRAmcwiz6VpxgEvt0eY5LQNCMIUKRosX1lo31K+eCTlwp
	 etyB+EA5RWOA4m0pjBgVrPYp01+pI8FEZchXNnQeP/M6yv4ZAE5XwCJLTcDhpDw8g32Y+
	 kfwbOYm9NkwGWHUpZR1uZlBp6SF7zci9c6H1uvzoPWvKEnwPiN9cKNrmXaKPn5Ph/ReSM
	 l63un+3GUZG8U72zOTN/FxHUfEjmnTo9jN9DDQQSPyw+Edfx+Bmz7gt1SMlS6Kn5b7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793172653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zov4u420zTtyxdsszpy0m/58XGeR28E9MNfOcUnPbTw=;
	b=OkC2HaYiP2FF8CitQLkUtA/AWAUV6vQ0GpfYx0O7opxnNOXrBxnpYOZiQiABq0vP3b5u
	 ptLfgGZ6iBp9ytR13th0zQqQf3wS68TjtEg5med4I9Wjsi2kqU+B1dWWE+W97rHPVKBia
	 3IUvx+pCwXy/KfoCjB37X6qIIQi34SbLf6DXFCs2l0GlgKS3WQ2k/C8w/Q+1RtNlXbTOz
	 W2EO739cpCmqZq4Y7Zl1Eip9ffC04awjJtLEvW0KDV5SNJAZwiCdi591DsUWwHXgZuwyO
	 oFd2Mf2gAK1UwFtlUyOzo8F14rHvr6uatk5YwR26Rz//yEclnkgmsC4DdrkgANMLFzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QNt1abaq;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2ED60A261A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 07:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A2ED60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QNt1abaq
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b060ec084so343020f8f.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793172651; x=1793777451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zov4u420zTtyxdsszpy0m/58XGeR28E9MNfOcUnPbTw=;
        b=QNt1abaq9ByIxbUfGJS9uvxbgE1Ezhf77KkYnX5kqOVrXQCcGZIC4KKZB5Ah4Ybn42
         1nsD3ZY1YOJgxec1zGSKnWhbbxEU19r0vrmMJqidvo6jK0R5qYPdPO2mxLczjXUP3gUB
         FW5LF76YlgJvBkRBpF+W6AyENVxfC4T4v9zo8tdr0FQZ+gRH/ayYKjv1VRIAJNpQG9gX
         14t6VR5oKDUxZY6ZvsmozTk5r3qw5EYSazBaG8+6ZZcyQQHgP2TBvZFIwgYSz28kOOcL
         paStggrE5eqxvw9928o5ylby8MfzKcm7YqQiEGSIjKHfEryABWFQdxtOQaF1umy9SuZV
         EMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793172651; x=1793777451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zov4u420zTtyxdsszpy0m/58XGeR28E9MNfOcUnPbTw=;
        b=YlP1ouQpnel6TNSnvJAVLZ8i9SQPSgCF22Rbt/j3Z2FbqF5Ycn1hmCnmgbz9F6t2kR
         lLRcPaRA5zWOpeKUOyxI8BBp7qaKT5TjT8U4g4r1P95iJKVE6gOq+jvrr4n9P4bOzf4E
         EXS/HUBczZ4yRY2F+vlleAowadpADbCd1Cr9f0SDUIbq2nLm00aby2T9zGZr1zYDeHSh
         tqpfj1dXMIVwXkbCiHT1pheo7QxOr7HTk7Gcq72y/lwoiMIygRQ9wwcmvzEsT7DB++7/
         294ea9818Lj/Yl/njGapS5EoRocnFr92YP5gB2sNn2s+6DHEpPt9NAO/GUfj1zdXxvT9
         082Q==
X-Forwarded-Encrypted: i=1; AKwUvByefcb0CT9wHe9oj3XhVLLimvsZePdakTwZxJiHWtp6wa00wzcChqlBV8JFy4/Z1oVPHAPi7uk=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+BJqjwsdgRFwsm+S8qkmikdYMskExGKfVmSmXCqohSEtm9KF5
	3o8yZd5gVmjAPS5LIiN9WhF7qCccx2BQCxFiRyfc7e2uem2zhKnyGKHk
X-Gm-Gg: AYBFou15yiFHgOBoqvymbxrmKdaVU8YNq9z86n23gsphWFk4UABuxLn+EI31Se/x6dX
	hwagq8Hbe4bXLfMh+gLi3UwXq8vJqENQYucoWYbi1hTuQYDgsWwqZ0n9M4dYHNrym7VPiD5Dtr9
	IWnt1JD30O5WJdmP7qbjwc40golTwbZF4gXjBoQwHyniVsDKeF6+G3KrLUGhNq932VbeULuV0AW
	/kAJOlMfpjbp57OluyK2i8mxsy2ex4jOp+VmlINyolTfUZeX5MsmObwhWLknJ3LnhaZ6MAkZhRa
	c0f2Y1359qU1411G94lzT1YIUtrxTSn6y9stk3X4b5nm2cNteY860m5Y0cGU1lCmmplGVbHNJbd
	RKd9dmpLWXEGD6dWWDlTiIlilOIzYDtuIZIQZP0HrnGTbpmQPQIvzV1oEo14RNx7it6ENNsS8Tu
	MTB1oH0EvF22ZBUCEsX7nMLVOrKNwqSziBZNxeqRDtfe1I4zHZ0U1+2NvkwMXEs8InbRQsTAIr3
	gmo5GrdjB6Ius0Xes2n8u1hNJLtUdxejkq0KlN5IUPPzEK1CBVdRmmrQKxSSEauAS+MgWxgH8J+
	NI+KE+Tr3ZGP2R1v1Ma+805AEfBIvuiKCOBg/xEnr91ylirXQYflaRnd9zimi4mgxLm037Eu5Qm
	aT7MtzrzPidguMGzNTBVeCwIUwOZGeb36Yw==
X-Received: by 2002:a05:6000:2488:b0:486:f6dc:52c8 with SMTP id ffacd0b85a97d-48e5d5a4030mr3795646f8f.37.1793172650648;
        Wed, 28 Oct 2026 00:30:50 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e542ed998sm12083088f8f.13.2026.10.28.00.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 00:30:49 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 3/4] net: phy: as21xxx: force C45 OPs for AUTONEG
Date: Wed, 28 Oct 2026 08:30:21 +0100
Message-ID: <20261028073024.25175-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028073024.25175-1-ansuelsmth@gmail.com>
References: <20261028073024.25175-1-ansuelsmth@gmail.com>
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

With further testing with 2.5G NIC, it was discovered that the PHY
require the C45 OPs to configure and restart ANEG or speed higher than
1G doesn't function correctly.

To force C45 OPs with generic PHY function, clear the C22 bit from
devices_in_package bitmask and implement a custom .config_aneg.

Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 67 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index f5968eec11c8..81e9827873bf 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -616,6 +616,13 @@ static int as21xxx_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	/* Even if PHY declare support for Clause 22 register,
+	 * Clause 45 register should be used for ANEG configuration
+	 * and restart. Clear the C22 bit for devices_in_package to
+	 * force C45 generic OPs in generic PHY ANGE OPs.
+	 */
+	phydev->c45_ids.devices_in_package &= ~BIT(0);
+
 	ret = aeon_ipc_sync_parity(phydev, priv);
 	if (ret)
 		return ret;
@@ -633,6 +640,56 @@ static int as21xxx_probe(struct phy_device *phydev)
 	return aeon_dpc_ra_enable(phydev);
 }
 
+static int as21xxx_config_aneg(struct phy_device *phydev)
+{
+	bool changed = false;
+	u16 ctl = 0;
+	int ret;
+
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		return genphy_c45_pma_setup_forced(phydev);
+
+	ret = genphy_c45_an_config_aneg(phydev);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	switch (phydev->master_slave_set) {
+	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
+		ctl |= CTL1000_PREFER_MASTER;
+		break;
+	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
+		break;
+	case MASTER_SLAVE_CFG_MASTER_FORCE:
+		ctl |= CTL1000_AS_MASTER;
+		fallthrough;
+	case MASTER_SLAVE_CFG_SLAVE_FORCE:
+		ctl |= CTL1000_ENABLE_MASTER;
+		break;
+	case MASTER_SLAVE_CFG_UNKNOWN:
+	case MASTER_SLAVE_CFG_UNSUPPORTED:
+		break;
+	default:
+		phydev_warn(phydev, "Unsupported Master/Slave mode\n");
+		return -EOPNOTSUPP;
+	}
+
+	ctl = linkmode_adv_to_mii_ctrl1000_t(phydev->advertising);
+
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN,
+				     AS21XXX_MDIO_AN_C22 + MII_CTRL1000,
+				     ADVERTISE_1000FULL | ADVERTISE_1000HALF |
+				     CTL1000_ENABLE_MASTER | CTL1000_AS_MASTER |
+				     CTL1000_PREFER_MASTER, ctl);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	return genphy_c45_check_and_restart_aneg(phydev, changed);
+}
+
 static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
 {
 	int status;
@@ -982,6 +1039,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21011JB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -994,6 +1052,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21011PB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -1006,6 +1065,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21010PB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -1018,6 +1078,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21010JB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -1030,6 +1091,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21210PB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -1042,6 +1104,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21510JB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -1054,6 +1117,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21510PB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -1066,6 +1130,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21511JB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -1078,6 +1143,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21210JB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -1090,6 +1156,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21511PB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
-- 
2.55.0

