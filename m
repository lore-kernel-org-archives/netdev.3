Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E31D4B8271
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577043; cv=none; b=iEADAOSaK2ZyIJedVzr1b7sYRrRN+Qpcqz+JFOB+vIf1A0+z82LM9OsoAvuyVh6ZfPdPshwkbdRPu3cZH0qw0aHVJCOogBjGQjxuAJk5cDjNaTeSx66hhvDhHODG2TZxRzFUqwd5vYlF9sz4ZQgfg0L1QWu3Zs6OuShFbRoT9Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577043; c=relaxed/simple;
	bh=oxQfveLbn2/DQNzTnqZa8s/d01tWMQISQrNwQD1mY0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZFPYf1W6IPFR8/IGyChXImk5eDMRE3k+YXKxT01WfEP0iXiabTV3HQLt2yir/mG2lNAQNDeosxxdNdSHfaqDYtn1t07ADH47qRkwH0NTHQoRSm0ppNo8yxUOnYEp8Tkz/14KB3HH5Dz4QHWwvqK3glU0IwnwzvFn36ZP6FmPwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3h9qAUz; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3h9qAUz"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc502a179c1so1350422a12.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789577025; x=1790181825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tuN8aoHSWEa5dHkvtDyZOdX8Adpy+bSIBgKElfCoi4g=;
        b=d3h9qAUz9V4eGZ7hZevVjwLTRFqqxs1TmDZHHFAU8KYYu6l1IZ68oqfZyMUlWaM7cP
         g71w6CX7nL3TRzBvXri3XOdBBN+JxlLpGJ4UWwQobBtFAl99V4TgZDPSeVrcbPN5vVBt
         3L5IoQ5Pv+b5ulaRZkPxBPwRX51vX+0yoAOZWD5AyT8r6xq2T6aEiPVSRen/ZKItd6gF
         ZJlHIi6K+2NUrThp1fNgrA+HmKbCS6ewQKr4RX11IOLGuhSG479yUUw0Eo+XP2gIY6vs
         5av/FNDnC+DHdJMZYWVPXRcZO5ZxgXRhYX/ilQaFtVTKsQn7Dso5RBoEOFIIZW7oui//
         qRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577025; x=1790181825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tuN8aoHSWEa5dHkvtDyZOdX8Adpy+bSIBgKElfCoi4g=;
        b=kEw9743pkbFzeUt3NwiHdaU4diYFb6VQeIS/lOhGAm5E6D4VurOMbgBCm2GRnKo5sL
         i5qtgFJB9svrZC2Og5jTPTeFzmo2CoO/pLMR8Q+5HYyotkQ4Kfr7mod2pLbXH2kYLZlq
         pz2rLiPHyk66Fl9YgP0fZ+Od/A9Dh1hLGQcH9OaXJaY9m6EAkEuM2lIx+LsuWmv95eWl
         gK9Z8V4Om32PkuxKF0aY5jg7SGOTQ+tw2rqfRrQlxUMqi3qa5X9WAstM5mdnu3n2Isgr
         tpNOUA7hVoFKjtmGpWFMnKaJTXXYQWtILGBEdNSd7jWG1/KMEdI4OLuL8T6mUWsZrjuW
         Mf7g==
X-Gm-Message-State: AFuF++kwr3KxUuPkMFDnbUOXeaR7DPC1U9/hVrS52VD/WcLtmMJ9ZdAa
	jCZmLsic4zo/AIe9XtRsUtvNpckhRaslLGqCVf0zd+bLvvgUAl2RfFtOns3gve9mDms=
X-Gm-Gg: AYBFou3bffSXHjlHjYQ7H4RZrC/d8A3YgCkce1vywcnCfkX9KQsy9lAtqbpR+WNQDO6
	eNlvTNAS1mMiwmw6ofolfZy6Oez58uTieQQfh9NwFEPCMK3ISnoPPWT/pzUODQJFw6FkHmOzOcN
	B+zYQNyL3B2zB0EbsyK01FetgphDWikXe2coG5CQwC6ufBcQFnldWS4vmumY+JnbU0UnNC+evuw
	bvHmaipTV/IfUfAnWwz98BhnoHjztwMJITcqhPQXZparvIPsbUMMo3fg1jTKbp2RT3q7i7choDp
	FGkwRyWYi83QXWi+WmaUAG6STPTZQeJiaRej9ggnSprsrPPDkCyjKEv4jxnTz4pqbm8A5Q03NfO
	GGwzMEhEgvqAOoUdbeT8pqSKViqv3fuXO9BmN97WqsxqE5L7WTHnj7oSKWFPK0nWPJzpZWp6RyL
	VIvFdNK52iJRJIFXHCuZ6AOJO138Yj24FzfrX1EQ53LHOMY2VbBxAASRHH/fegPpMGdEWPXRezr
	Co9IyWuIJOh58qNrgdmHZB3Poqr92PBDol7Xg==
X-Received: by 2002:a05:6a00:4099:b0:842:3c77:5996 with SMTP id d2e1a72fcca58-87341085fd4mr330193b3a.1.1789577025130;
        Wed, 16 Sep 2026 09:43:45 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:1232::1d0:c5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50acc757csm1902278a12.32.2026.09.16.09.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:43:44 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/8] net: dsa: motorcomm: Introduce yt921x_speed
Date: Thu, 17 Sep 2026 00:43:05 +0800
Message-ID: <20260916164310.3168269-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916164310.3168269-1-mmyangfl@gmail.com>
References: <20260916164310.3168269-1-mmyangfl@gmail.com>
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
index 3a8efffb3f97..aac550bb4f72 100644
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

