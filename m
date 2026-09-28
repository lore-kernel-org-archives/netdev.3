Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD3E4F7CB8
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633293; cv=none; b=eWiMOv1sUdYN4B/CIIaIJu5FSRVtd5iJX5ZxpV3Rq0YLuUjB8Q32dCsrUzxRqIUvRnFSgFO+EyUbQX2HYJL0YICYiv+FVqfhsg302j+dNnxNv1xANp5IfePLJFV8HqNhRZsewBPObDnjUyoDxNp9PpTYK37b4TKdeKGeBod33Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633293; c=relaxed/simple;
	bh=nlXgiiV99w8ZBfNrOPQjdiWpm2RFKdVvbnpO9GV2U6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aI3QeTS5kDxr+jSHBFIx3qQsYsE2iIY2X1duB5PLUWX/zVtmUTkZ7s0Y13rh4SKJhChIp09Y2fgB0jlqOVHmFu/sr18rDLC2+0FzhCTRExAfc9IY19BBtQ0jxare/9OYbyQx6RiQor0dRnIEOluGwioctEnfLl/RL4P/aJMxSg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p4fsg7w5; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4fsg7w5"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2da4eea067so295761266b.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790633290; x=1791238090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CfOyZrdRgBydy7uhLfSubYYuTbaNZt6oFV4VOnfbokY=;
        b=p4fsg7w5UMtXDA/ZZWJdCPAHCN+rUXFbho8En92fXK3YLKjFXwNR2iLGZ6bgcZ+srW
         zu2tXxHBwfyWxOQkJPgzqbqlPw1UBad0szUz3o4UXJQ2F74ldgpbT/+L6B92AqG3otqd
         c4bYLXV9Xr17iWfEjTloW1l9dt6Ccy0z/ijZeeNTjFY7rHJxQr0bZ4nQW6G4u1WWRxnf
         SSqgwHK4qtOfrX9nOgPs2mVpGnkNRzaPvobppPJ4lVozHB00X3Am4G+sevAvptI8Ow2y
         zVNJwEvYlXoIU6578XF/ncmIbOAmuqpZCKE/PC+Ro7EEysuuKPL1xMOFTWR7VGkcHvUP
         Frzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790633290; x=1791238090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CfOyZrdRgBydy7uhLfSubYYuTbaNZt6oFV4VOnfbokY=;
        b=r1Sagriahzl2p5Ub2MT83Wc6OBAlDF/ea/BwUtoDxWclrXdfq6+UNRAB/K2nCWE9yd
         haQ9aX5I3PSQq+QhJBoNM0Jg+x0v1lwaH+skR2+RZW2+NMdpDLUBmO2pfXTuap0jbAeB
         U9neLixPym2cpZieJ9LQa9rbgFvQT0917yYOZdo9E5ddWmdAoouG9lbT6o11Awb9NgcE
         q6tPcWFlqH+mhKcvga536WAMnTnWqS79zaFvUKLsdmzfWcP9KBkTV+5OerhyyLS5BJJ6
         ++nsu/WUyMHefZbe6tyN7wZUjWIh/flB6E3/dfS3KyXWxW4mVMqjfv3uQ7iiz3TNPhvw
         QNIA==
X-Gm-Message-State: AFuF++maCm0t5hW0KUbZe5+8HzuYi3lZnvX/oCKdyRQj2A3sm3gol5Bz
	n6sCapxFCy2J3LxDmHum37niZOs341t0eQRNmc4dyaAi6Ya8DfBV9Tvrc2zBYn4k63bbIw==
X-Gm-Gg: AYBFou1dCgEeKlPBblSV0x9L9OOprMQtYE9/vzJXrhkSvOQhwev93zDoaqZpQqWIn48
	jHwwDtwQfW5p9uFkXnug4rwgD12j7Lu1yprEPhULdUJEd/LzCIDQwj7/F+z8VNe40X6eUBW83+Y
	LqL4oMOeEQ3iu/bscuhp/IWqxZllrGqXO/gVE0vfz8xGJrEGxnOpYF9CxU+7wv6i4VrdJHHoDDF
	E/nF5wwdRYzs7tvBp0Fe7R5q2iCeceQhSTOOjInmt900pPCSoY5FHYdwbSGMgqjZ+zx3qYsZsFV
	Y4AWZ6FTisFpDq/ZgQUjK0YVopaJbkF/GJsHOy0cNe8PKQdPEVNHJQF/m3TH/xYISc/y367x87z
	Qu/j5c7hdaEtY1sFK590YbhO8VjY5YOIkPXP5OUcwLK3w0DhEYljBOdPrgGpqnhTplGYl0Y1Qgk
	8oUOJACsM/Rg+m3njTGwkBc/5MawkAZVuqsERI+3jlKWEyukWCxyj+z2xoj4Hv4FsBBdk3MxY4e
	zXcmgUcWx/4R7VWNAovt+r04wVyjpDzjDDKICiwdYcpAh30gpIatjj2
X-Received: by 2002:a17:907:c308:b0:c28:ec7c:27ae with SMTP id a640c23a62f3a-c2ac5396f65mr1136646966b.25.1790633290384;
        Mon, 28 Sep 2026 15:08:10 -0700 (PDT)
Received: from localhost.localdomain ([2a00:801:793:68fd:c07a:9093:1956:b4bf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd3bcac3sm335878966b.73.2026.09.28.15.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 15:08:10 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: qca83xx: read resolved QCA8337 link status
Date: Tue, 29 Sep 2026 00:07:49 +0200
Message-ID: <20260928220749.857-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read QCA8337's vendor status on each autonegotiated link check so the
reported speed matches the PHY after SmartSpeed changes negotiation.
Keep link down while that status is unresolved or encodes a reserved
speed; PHYLIB then notifies its consumers when valid status returns.
Forced mode continues to use the generic BMCR result.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
Assisted-by: LLM
---
Andrew suggested this in his review of RFC v3 4/5, where he noted that
read_status should report the real speed from the vendor register.
Thanks, Andrew. I mentioned this change in the same thread:
https://lore.kernel.org/netdev/20260924234814.1734-1-yongzhao.derek@gmail.com/

It does not depend on the qca8k series and applies to net-next on its own.

Testing: a model test compiles this function with the real
genphy_read_status(), phy_resolve_aneg_pause(), phy_read_status() and
phy_check_link_status() and covers 10/100/1000 in both duplexes,
unresolved and reserved speed codes, a speed change while the link
stays up, forced mode, pause resolution and MDIO read errors. W=1
builds for arm64 are clean. The same function is in my OpenWrt Linux
6.18.52 build for a Redmi AX5400 (QCA8337), including the build used
to test the at803x IPQ5018 fixes. I have not injected a real SmartSpeed
downshift on a user port.

 drivers/net/phy/qcom/qca83xx.c | 49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/phy/qcom/qca83xx.c b/drivers/net/phy/qcom/qca83xx.c
index bc70ed8efd8..b3f3183d4a4 100644
--- a/drivers/net/phy/qcom/qca83xx.c
+++ b/drivers/net/phy/qcom/qca83xx.c
@@ -92,6 +92,54 @@ static int qca83xx_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int qca8337_read_status(struct phy_device *phydev)
+{
+	int ret, ss;
+
+	ret = genphy_read_status(phydev);
+	if (ret)
+		return ret;
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		return 0;
+
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+	phydev->pause = false;
+	phydev->asym_pause = false;
+	if (!phydev->link)
+		return 0;
+
+	/* SmartSpeed can make the actual speed differ from the advertised modes. */
+	ss = phy_read(phydev, AT803X_SPECIFIC_STATUS);
+	if (ss < 0)
+		return ss;
+	if (!(ss & AT803X_SS_SPEED_DUPLEX_RESOLVED)) {
+		phydev->link = 0;
+		return 0;
+	}
+
+	switch ((ss & AT803X_SS_SPEED_MASK) >> 14) {
+	case AT803X_SS_SPEED_10:
+		phydev->speed = SPEED_10;
+		break;
+	case AT803X_SS_SPEED_100:
+		phydev->speed = SPEED_100;
+		break;
+	case AT803X_SS_SPEED_1000:
+		phydev->speed = SPEED_1000;
+		break;
+	default:
+		phydev->link = 0;
+		return 0;
+	}
+
+	phydev->duplex = ss & AT803X_SS_DUPLEX ? DUPLEX_FULL : DUPLEX_HALF;
+	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete)
+		phy_resolve_aneg_pause(phydev);
+
+	return 0;
+}
+
 static int qca83xx_config_init(struct phy_device *phydev)
 {
 	u8 switch_revision;
@@ -220,6 +268,7 @@ static struct phy_driver qca83xx_driver[] = {
 	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca83xx_config_init,
 	.soft_reset		= genphy_soft_reset,
+	.read_status		= qca8337_read_status,
 	.get_sset_count		= qca83xx_get_sset_count,
 	.get_strings		= qca83xx_get_strings,
 	.get_stats		= qca83xx_get_stats,

base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
-- 
2.43.0

