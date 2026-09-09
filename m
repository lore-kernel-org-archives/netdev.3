Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029C3B5302
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980775; cv=none; b=dzd8p4qJewTFr1OHsp0mpq0wzh2EQ0SUB5CtRBhUEosljb2NfUf2JeFmtbGtH63fGLqYB3dczYpWbVTRRxQZJjl3tiQsovAKRXgcUzo5tYPkFsm5NOXZ+0kKXIUQauegsfn9sqN+6JeyWvyBB0ltoREFCRNKFguEEzFMi7CbxxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980775; c=relaxed/simple;
	bh=fLDySpshRkuGFm1WodapEqEIoGCDqg3KQnzHh8vfc7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=korJpLPLO3uoU93ZNDQ+9COwj3FxxZUQ5zeKR5Vj+QGZlaF0Myew0xUg/4rbnCI/FCpoFMx/gLPSmVYCG6sdxOOtQWdysOPEybJD9nI86Lufbm/W9MZ+VYnPBxZIRYMnZnrRAQezKxqvNBEajtVpctd2myhM/7KAyE/HR0DR19w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq7ysE+W; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq7ysE+W"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ceab75934dso60211455ad.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 12:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788980773; x=1789585573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IkW5gvjleV3pVc79+myA5Hog7ljScbn4RX3/5Aixz34=;
        b=Oq7ysE+W5CWTlzZYK2dH4E36uAww1e6f+xwKFM9EOCzbNuTSzfd//SUhAjdBaDx33e
         bdC0cSLurPjhFlAZYf23UePqyFE/7Q/7UUAQXJ5pGQlDNWeRnYQzlzM7FvDbMMSC3NKB
         Ra23nzDhhBgpEHRE9OaOL1PZ7VEx3QjmQVk87EoxEecQA9ZJmTYJZiKW/OmrfDWoNvKL
         BSktc+boNRWGrWbHR0adXyS4VBI0r0kT8r4dZ7s1ucn1CADU2omcrohASddB8qIbimMr
         dpGpovC9RizydTD3aOb2OjseuYZcJVGJL7775TCIhPUsuMERaPSnruIAD5dvndVHVS9C
         rGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788980773; x=1789585573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IkW5gvjleV3pVc79+myA5Hog7ljScbn4RX3/5Aixz34=;
        b=a+YQEkgqTyDDcILGl1p2aLZxJsH2cXbLdDqvmZGDCkZAi42pVoL3Fb64vqROthm5IL
         pDH1E2ykH5pet3VMzi+DZQ2kFeVToUAmyXU9eI6DeutxnEHfhqTCrU61alB9DNFLLpRw
         F7d29L9Q8rCJNhzWEuPsZ1c6or63zoEK/ssl48VEk+Y44MfXe2y93HsSC8ED5ezYsBle
         ZK5gR6u+vgGjxf1RxuAaVa9iL9EHsy0VKCIPzHp47K0PNfOgJNy/uBk/XQ7guEatOuZq
         uLEfzugUvZVhzCxsJ6qzIgEMkr01Hfh4gq1io9q+HO4CuUVFPZ9Vmz8ogqWG2zbnNrWS
         tGxQ==
X-Gm-Message-State: AFuF++mMJMtQ+Gq08TvuTkPkcto4xDQRlvOf2flwQHfVpwG6uQpivQAS
	PTXMSaP/ruwvj1ct397x0iiGkP9hkjHaavETLCy4WBgsDSFfHLEC1cig+JK1HwWGoNc=
X-Gm-Gg: AYBFou3QIe0IcJt1F0FIDbkc53aGyHMJQiZ3F7trZDzji17FZXJKhjpQJZnZg0quqPr
	icoBdeCKv4FPgpjBtOv1NhFOiB4GutTwRL2IcZZsDIRuH9wG1UXqlgimqszUmNn9VkJ55mgnAeP
	J0DRY2JHV8gsisCpF1dZ4vtqCmT2noXFUa33pKU9pF1rzzmf0MBZomolDok2JxVcizm7dX9M3rV
	X/ZV5jWT8YWP7Rk9OYIzTFaJfKWh0dZXJOH+O4ADJJXGQs49vVgfkBNLtexueVKXz6eyH92Snx7
	wQfnNPfdtHPnfLituGmDtDpsFcKUeuEZW0WqHAo1nVUnMGrtLL4knhuG2NqYKWzECOSrDK6Yuje
	G5532DQALd+9BVSdmtUDSv87LuXrxqbQiumo/XZZqUVVjxIlNHKPVA9rBV/eeq+efZvoJZx8vau
	xdzmxN0WZq6+zSZvksX0AMzHjrhkmmUmjkSqf2XeOvwu/oI2wNLQ5DrzU8ILGNd3/Y1A24tByI3
	M85au172mFx3GrH1eFfBe+Y
X-Received: by 2002:a17:903:98d:b0:2d8:d4d0:792b with SMTP id d9443c01a7336-2db12831fddmr486539175ad.15.1788980772576;
        Wed, 09 Sep 2026 12:06:12 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4d0:7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dcffa9827dsm13988515ad.66.2026.09.09.12.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:06:11 -0700 (PDT)
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
Subject: [PATCH net-next 4/7] net: dsa: motorcomm: Introduce yt921x_speed
Date: Thu, 10 Sep 2026 03:05:32 +0800
Message-ID: <20260909190541.466476-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190541.466476-1-mmyangfl@gmail.com>
References: <20260909190541.466476-1-mmyangfl@gmail.com>
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
 drivers/net/dsa/motorcomm/chip.h | 61 +++++++++++++++++++++++--------
 2 files changed, 52 insertions(+), 71 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 53d0a85e9310..0635359787db 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -3776,29 +3776,15 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
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
@@ -3815,25 +3801,7 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
 
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
@@ -3855,25 +3823,7 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
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
index e87daf8c650b..dd121ef2cbf5 100644
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
@@ -1009,4 +1004,40 @@ struct yt921x_priv {
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
+static inline int yt921x_speed_to_ethtool(int speed)
+{
+	switch (speed) {
+	case YT921X_SPEED_10:
+		return SPEED_10;
+	case YT921X_SPEED_100:
+		return SPEED_100;
+	case YT921X_SPEED_1000:
+		return SPEED_1000;
+	case YT921X_SPEED_2500:
+		return SPEED_2500;
+	case YT921X_SPEED_10000:
+		return SPEED_10000;
+	default:
+		return SPEED_UNKNOWN;
+	}
+}
+
 #endif
-- 
2.53.0

