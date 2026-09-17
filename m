Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505B94DDB22
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671139; cv=none; b=QDW39iiP9Q9ylV2kHAQ7m6ByLuY9+K9tF5n+WgrO3R23TgWym0PJD2cQXZ5X+MvDLhAOAw1cOUZu0eqVWr7i/GQ76dgYUHudMVLpDacdH0YzqFBOUpd/3Ivl3khbfaHLkQR25mNDrlFIgNW7mpzpUr3hT+5RWBr7ber447ymZCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671139; c=relaxed/simple;
	bh=Y3hzZlH4RfTt1GSDjBmAJN7+/oFT0VzwaZE3x6JZ7f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=he8xRASxxm1a5OtqNAaCYuxFMVpyc85iSjVhHmY8VB39zoO1fYSBrwnL+dYRomXi75blTJQGRbKUaCKtWtsSgjCwcrIbxPPCSveSoGxUBJ9XwpfvdPaAO+kmkk7lWm+3cPYnkD5j+BIRFZJ/YF2aKVLmqBVNN9FY8LO51a5oZ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJRMIcx0; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJRMIcx0"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2ddaa08c890so6347545ad.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789671137; x=1790275937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3YyQU7Pqm4R021NqFKJm1m07kcj+3eESCj8W+bHOyKE=;
        b=EJRMIcx03qzMw/hsoIbFRnlja9xaSPAvWk3dZlWOvRI0wffVJ4bAounBzJcVIWvZAK
         yH0FYM3q9e9tt8nDo7Bp2KM6SdB4ZaXPiBBaogHwNO2tZw17pK6e5+IiZoEE+A8Q9Eh4
         LaKgwIUxFf3pYKFlR3jFYgLp1ljhqKJ74SnjzFKITOWklxQG6Z0RGZQM6fOubHcFYvNf
         Vzlo75pTLz6AIW7Qbs8yVhHI77mdaaKtNul9+ZjU6IJl1fg+z7wqcUnxeWk0C66/Cs70
         ACY9+ZUBj4HzQowHqloo4lankHwbOx8bGJ8e+28V5LQMnmaovUnqF3ZT7xleZw1JmWYs
         OukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789671137; x=1790275937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3YyQU7Pqm4R021NqFKJm1m07kcj+3eESCj8W+bHOyKE=;
        b=OR8gGU4lWACDU8UlozS0A97yTe0ocfbuQiu1TiwijHxuLtXjzZFXVIBW78lMd94Cal
         7yb6cMHbUpmRVGuoeyReRphgchjT052mbFvTW29mcNi2MTyO4/7QBNFweXVbtxm5bkTn
         iuFO9fN688xZRR2MUyjwfGPdtcLkBOB5wnon8FViDdb/Iv5pwKBSKPenlGwyeH37H5wv
         6FipsIjbCfAhsy791izZ0jkbqAlAyDFyohK46igw93hnfiftTi/iGbdXUkrPUmXMzmFC
         wF9V4I/sR0MBW6vD2ORYvYRQrCgWumyqB5J2EOQr8bft0i6UoOAwHQgVnEuY9Ut1VNuv
         LiTQ==
X-Gm-Message-State: AFuF++nGN29o3//2GGoMovcXODvuTNbpuSdqeLb+UXkoCRV9UFBGGAl/
	VBDfmcqpj+SBS6OuH+r/vMsNJMdWEOmT2jeCJ3DR50MmKo8oM5smncWa+nRBuEli
X-Gm-Gg: AYBFou2uUtuzniYJJ3YR8MZfxiNopsQBkzXPfxi25xq85lCWfofSDnZl7fDSdtGx5Sn
	/+l1SHLbBAFMljS08x6zv6lF7Z3uleS44YL7d0gp2+zldTd7QBiDA1sD2hjv+qGQv8RaA5vxR48
	i779DVafwVMKkFc0LoqelRKzcLYxYfDbFZ2Mk5s4Z90Z1kaLrHFDVLfPvkUa+UwwWcEWdwlF11O
	IlCTnV5QM9rd16BG4KKTTvYSKDIxiZjaScijs5oK86yuEfr8BGkYlZt3gLVJoSqjRky2s7guVyv
	r63iBScn8Q+wRErbKmSYD5Dijp9Mqek/fNBD/+lIdtd2c3dhs5HSbE/wkRmlqfpeHM1KfkpiQwY
	eOLWpQrDgijqbJBAW/Gc26RLqynwgu//2BcfwdqXz+ssSRyY2yvwDTn+76gxQdStlfgA0wc7nF2
	oEvYowmdN0utUHaAjnm9bSAfTpOmC7qDQZ2oMjvccu5VyOUOac3epc1MtXz1EJohS6HIze2j2A9
	/j+hynhmWguM3Nj9kwrmH5LZg==
X-Received: by 2002:a17:903:1b4e:b0:2d8:d4cc:be68 with SMTP id d9443c01a7336-2ddb1c15709mr1593525ad.21.1789671137547;
        Thu, 17 Sep 2026 11:52:17 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:1232::1d0:c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f331b7sm31032655ad.82.2026.09.17.11.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:52:16 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 5/8] net: dsa: motorcomm: Introduce yt921x_speed
Date: Fri, 18 Sep 2026 02:49:52 +0800
Message-ID: <20260917185010.3189199-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917185010.3189199-1-mmyangfl@gmail.com>
References: <20260917185010.3189199-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FIELD_PREP values cannot be used as case labels. Introduce enum for
future use.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 62 ++++----------------------------
 drivers/net/dsa/motorcomm/chip.h | 43 ++++++++++++++--------
 2 files changed, 34 insertions(+), 71 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 5049f4be8aa6..c99be2044fa2 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -3771,29 +3771,15 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
 {
 	const struct yt921x_info *info = priv->info;
 	struct yt921x_port *pp = &priv->ports[port];
+	int ps = ethtool_speed_to_yt921x(speed);
 	u32 mask;
 	u32 ctrl;
 	int res;
 
-	switch (speed) {
-	case SPEED_10:
-		ctrl = YT921X_PORT_SPEED_10;
-		break;
-	case SPEED_100:
-		ctrl = YT921X_PORT_SPEED_100;
-		break;
-	case SPEED_1000:
-		ctrl = YT921X_PORT_SPEED_1000;
-		break;
-	case SPEED_2500:
-		ctrl = YT921X_PORT_SPEED_2500;
-		break;
-	case SPEED_10000:
-		ctrl = YT921X_PORT_SPEED_10000;
-		break;
-	default:
+	if (ps == YT921X_SPEED_NUM)
 		return -EINVAL;
-	}
+
+	ctrl = YT921X_PORT_SPEED(ps);
 	if (duplex == DUPLEX_FULL)
 		ctrl |= YT921X_PORT_DUPLEX_FULL;
 	if (tx_pause)
@@ -3810,25 +3796,7 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
 
 	if (pp->serdes) {
 		mask = YT921X_SERDES_SPEED_M;
-		switch (speed) {
-		case SPEED_10:
-			ctrl = YT921X_SERDES_SPEED_10;
-			break;
-		case SPEED_100:
-			ctrl = YT921X_SERDES_SPEED_100;
-			break;
-		case SPEED_1000:
-			ctrl = YT921X_SERDES_SPEED_1000;
-			break;
-		case SPEED_2500:
-			ctrl = YT921X_SERDES_SPEED_2500;
-			break;
-		case SPEED_10000:
-			ctrl = YT921X_SERDES_SPEED_10000;
-			break;
-		default:
-			return -EINVAL;
-		}
+		ctrl = YT921X_SERDES_SPEED(ps);
 		mask |= YT921X_SERDES_DUPLEX_FULL;
 		if (duplex == DUPLEX_FULL)
 			ctrl |= YT921X_SERDES_DUPLEX_FULL;
@@ -3850,25 +3818,7 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
 		if (res)
 			return res;
 
-		switch (speed) {
-		case SPEED_10:
-			ctrl = YT921X_MDIO_POLLING_SPEED_10;
-			break;
-		case SPEED_100:
-			ctrl = YT921X_MDIO_POLLING_SPEED_100;
-			break;
-		case SPEED_1000:
-			ctrl = YT921X_MDIO_POLLING_SPEED_1000;
-			break;
-		case SPEED_2500:
-			ctrl = YT921X_MDIO_POLLING_SPEED_2500;
-			break;
-		case SPEED_10000:
-			ctrl = YT921X_MDIO_POLLING_SPEED_10000;
-			break;
-		default:
-			return -EINVAL;
-		}
+		ctrl = YT921X_MDIO_POLLING_SPEED(ps);
 		if (duplex == DUPLEX_FULL)
 			ctrl |= YT921X_MDIO_POLLING_DUPLEX_FULL;
 		ctrl |= YT921X_MDIO_POLLING_LINK;
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 3fb0c6a69dd8..b3670f1e1427 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -89,11 +89,6 @@
 #define  YT921X_SERDES_DUPLEX_FULL		BIT(3)
 #define  YT921X_SERDES_SPEED_M			GENMASK(2, 0)
 #define   YT921X_SERDES_SPEED(x)			FIELD_PREP(YT921X_SERDES_SPEED_M, (x))
-#define   YT921X_SERDES_SPEED_10			YT921X_SERDES_SPEED(0)
-#define   YT921X_SERDES_SPEED_100			YT921X_SERDES_SPEED(1)
-#define   YT921X_SERDES_SPEED_1000			YT921X_SERDES_SPEED(2)
-#define   YT921X_SERDES_SPEED_10000			YT921X_SERDES_SPEED(3)
-#define   YT921X_SERDES_SPEED_2500			YT921X_SERDES_SPEED(4)
 #define YT921X_PORTn_CTRL(port)		(0x80100 + 4 * (port))  /* Bit 7-0 shared with PORT_STATUS */
 #define  YT921X_PORT_CTRL_PAUSE_AN		BIT(10)
 #define  YT921X_PORT_CTRL_LINK_AN		BIT(9)
@@ -107,11 +102,6 @@
 #define  YT921X_PORT_TX_MAC_EN			BIT(3)
 #define  YT921X_PORT_SPEED_M			GENMASK(2, 0)
 #define   YT921X_PORT_SPEED(x)				FIELD_PREP(YT921X_PORT_SPEED_M, (x))
-#define   YT921X_PORT_SPEED_10				YT921X_PORT_SPEED(0)
-#define   YT921X_PORT_SPEED_100				YT921X_PORT_SPEED(1)
-#define   YT921X_PORT_SPEED_1000			YT921X_PORT_SPEED(2)
-#define   YT921X_PORT_SPEED_10000			YT921X_PORT_SPEED(3)
-#define   YT921X_PORT_SPEED_2500			YT921X_PORT_SPEED(4)
 #define YT921X_PON_STRAP_FUNC		0x80320
 #define YT921X_PON_STRAP_VAL		0x80324
 #define YT921X_PON_STRAP_CAP		0x80328
@@ -122,11 +112,16 @@
 #define  YT921X_MDIO_POLLING_LINK		BIT(3)
 #define  YT921X_MDIO_POLLING_SPEED_M		GENMASK(2, 0)
 #define   YT921X_MDIO_POLLING_SPEED(x)			FIELD_PREP(YT921X_MDIO_POLLING_SPEED_M, (x))
-#define   YT921X_MDIO_POLLING_SPEED_10			YT921X_MDIO_POLLING_SPEED(0)
-#define   YT921X_MDIO_POLLING_SPEED_100			YT921X_MDIO_POLLING_SPEED(1)
-#define   YT921X_MDIO_POLLING_SPEED_1000		YT921X_MDIO_POLLING_SPEED(2)
-#define   YT921X_MDIO_POLLING_SPEED_10000		YT921X_MDIO_POLLING_SPEED(3)
-#define   YT921X_MDIO_POLLING_SPEED_2500		YT921X_MDIO_POLLING_SPEED(4)
+
+enum yt921x_speed {
+	YT921X_SPEED_10,
+	YT921X_SPEED_100,
+	YT921X_SPEED_1000,
+	YT921X_SPEED_10000,
+	YT921X_SPEED_2500,
+	YT921X_SPEED_NUM
+};
+
 #define YT921X_SENSOR			0x8036c
 #define  YT921X_SENSOR_TEMP			BIT(18)
 #define YT921X_TEMP			0x80374
@@ -1004,4 +999,22 @@ struct yt921x_priv {
 	struct yt921x_acl_blk *acl_blks[YT921X_ACL_BLK_NUM];
 };
 
+static inline int ethtool_speed_to_yt921x(int speed)
+{
+	switch (speed) {
+	case SPEED_10:
+		return YT921X_SPEED_10;
+	case SPEED_100:
+		return YT921X_SPEED_100;
+	case SPEED_1000:
+		return YT921X_SPEED_1000;
+	case SPEED_2500:
+		return YT921X_SPEED_2500;
+	case SPEED_10000:
+		return YT921X_SPEED_10000;
+	default:
+		return YT921X_SPEED_NUM;
+	}
+}
+
 #endif
-- 
2.53.0

