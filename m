Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD41382F28
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130019; cv=none; b=QkBIGRM7B0o2rqE2tSWYXpBUrpyFkqCZUxT+m0hIXjEJ87OBEIHYMgv78zQyBgeYDoK8YdnP0IsjIge8Ci6syAD2NNRIToYklNqiBWTwdBgpq/7nYCgJgO5S8sZ5eSHNaTwtsR6ehhhC16dIWfQk8mF9PwuhPf1c2ekfZ4Zj1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130019; c=relaxed/simple;
	bh=uV7nskBIpDf7b1+sE//lNQT9qbsMS4sKk4qV93w23WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOE1IE3XX0kfmyarJrCIIGGwqwO1fUcmxymM35zgS1YHTa7NpkVLfutxgF3xgDK3iTvPzDD+3QbQaOdw11fehm7/JCrrWMjz0EdTkXzyF5p9024sqy1mCPtaZJ15t1RKzgyybzwG9tTPI15ZmEUNvyWThv9h4XmRcECByUBEf6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grFyNKhA; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grFyNKhA"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e25400so272702b3a.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790130017; x=1790734817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HRv54spnuBOKi0zqhyEPtOohGBUa24TYUK5n/dGkrGo=;
        b=grFyNKhAJhe9Ndg+uxNVvQ8Q204vzfb2H3ZdbgREsvyboDlRlBghfvBFbwTSUpa/+O
         c9uL+qqN6Ou2PV/gQCi3k3un2V7d94cquBlxSxbsImXRLnqiBe+OKgnhms+tm9jMd/Oa
         Q6bNAnQeVuXeHF67Fyu/2JPJ1tuSJ3bE533kS0bIgdnZc5y34H9Y9oKn3E2UyeWdxCn7
         tQNHLIIoHpSnYnfnLKF3vxtCC3ejgauBtjK00MdQEnzpzLOKojQEdH1imax6ajs3/SAg
         CmQfVpedckpUsLl2ghosKLlFkARec4zs3pS0neuxyzxR6Ausib66SHVKTNqogZKdQinA
         gFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790130017; x=1790734817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HRv54spnuBOKi0zqhyEPtOohGBUa24TYUK5n/dGkrGo=;
        b=F6pr1kHThdEVeM4N64nW/r8U5w/1R3B2CSXfb8A8cx2PJZGZvR88tVtJS5uEhSy/Nk
         w29BgbauFiN8avOi8BVcYF61HR3VCpW4NvmTCP22UvdLMSdjBo0WGFjtZUGSTKbpAr5e
         yUWSXbgOqoVqRkmSWascwScYzA8K9OKeOTv32sbyoZ8SzL+BnP1YGJ/Fm72VXNCoQu5W
         7oWxtE/uldQTjzps8Ry5dEzngKpJQhSmNGePcuNFqldmjBMH9Q4pm8ktfJrBYdDKuttU
         UxxUs2thY4CZvegyO8mQoObFUonPCrkDkKIiXeiLKrhj6G2kqEXMF9Eez5EBDNzad8mm
         GkyQ==
X-Gm-Message-State: AFuF++kQf66hQz1Hpex/SFq4l0l7jdm+dq9gaK+Wwu0OmkAaG/ehKHbc
	HqotyaJiJ93TF/wvtRdzRFHibmqnt4GQgE4B3xTojYaXmKZEx5HoogsKBtIXeA==
X-Gm-Gg: AYBFou38Vv+sgzbmTxaZGWOlEzzuhwjay8Kwe2dW1xLkfDUOHmY2Oo+llyLuqSN0kfU
	kYuE4+UnyRSxslOlk59C7IDatyLw/BDWQS8UTgq6LImmWMtW9LSqobIXxiLEEEJY9H6i0bDLmHR
	96uY+clrZ1LszaH7wknBxj9Tf6J9eXLkfMiV8L+SL5Ad96gMajKWJSlHHQzxqVso7ELof0BEEBx
	W30vm8xtV+6v83Olv4Km3HQ+kgJujugQRBnNtm2CHyQhjLSoP4oT4Q33feGx0zThF2QhVIHsysh
	wD2MTXy1gSQ1jYrORw/3/O6LYaV03nJMDCUSpwM12B4/2UMQF5ZoCeWwg5DPxZLntzAsqR+TaxW
	0PmCQx+E81a/0iBphjQN5aHhhy+9CloAK9Y7drrRKfLW2Ep52GXbQXclwsp2Y6fIWLYsD4ysY+8
	da2SB5/Cdhenv7W5O9EZ6AlqansFoeKn6nvpw4HwG5rX6G7OAjl4+8F5yj9rXcFUBRvADPQxYCJ
	8jYjRi9wd30/VpwQpRpvygSXTRMzs/O1lA=
X-Received: by 2002:a05:6a00:35c6:b0:858:b809:6ec0 with SMTP id d2e1a72fcca58-87d1b2b0ccamr1194044b3a.23.1790130017235;
        Tue, 22 Sep 2026 19:20:17 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e0f4fe8sm502924b3a.51.2026.09.22.19.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 19:20:16 -0700 (PDT)
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
Subject: [PATCH net-next v4 5/8] net: dsa: motorcomm: Introduce yt921x_speed
Date: Wed, 23 Sep 2026 10:19:37 +0800
Message-ID: <20260923021945.2203368-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923021945.2203368-1-mmyangfl@gmail.com>
References: <20260923021945.2203368-1-mmyangfl@gmail.com>
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
index f22c37e0b5bc..06e2c60b415f 100644
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
+	if (ps == YT921X_SPEED_INVALID)
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
index 3fb0c6a69dd8..30d131eb9844 100644
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
+	YT921X_SPEED_INVALID
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
+		return YT921X_SPEED_INVALID;
+	}
+}
+
 #endif
-- 
2.53.0

