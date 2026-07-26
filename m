Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9AD36402A
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072406; cv=none; b=BK6BolKMFS/Rl2E/vk4wE0x7hGOpw04EE4NFbemAXRAx9avoMy2otYuT1NVd7BqsYJy9a1DaHuEqBJDPmkXzrN2GeeHms3DWNbKEYt66a3xTD4/WwR5eH8qwnQwJeJzUmzefOInsmPijm9NOmMb+BYd87lve+O0tEtI9q4KPZdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072406; c=relaxed/simple;
	bh=WRtVa08OAx2n9+9xMZ8MOQ+sZEn5yJBRv/Uj0y+vARg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VwD3/456hx9NRWQ8qBp9jzc/03eZBDOI5ZZcBhxQP+G2oyTPPRkrUMbyM0nsS0KAEJ84J6ayROPg5zRRo/xEeQTtwVu2IoQ2D6QrRX/PMRGghs5SQCl8XLx+ukXt7HlxN/ly5k+eghlYtrx+ETqeO4UVGRgDY3nzGF9iHkLP69s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyPhcT1p; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyPhcT1p"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc73e322dbso18017365ad.1
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785072402; x=1785677202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nkX/QoeZrS0kRupcwaIPCrYydg188P1E6HxAusu+K+4=;
        b=lyPhcT1pP0tBw19lEvWEqlpH/alIWPywLl15thuI8V+nLtsK4fXX9+DPujxccP3uJo
         vpk3P36s71LeFKDcWxn4f5zlzF1tAU/wvchjDRR5xNaEmEfCre2GzvlUDXZnRw+FtScU
         yi6S0n/x1Btu3Cn5nwnOo4Mywu8FSDeoWVjqRm0t3OtpgpjOWE2atR/Vt1oKzLD4zLwk
         sQaKGwEUveskvSyuVxuPKILZv6yPsoHNTtEXTtr3JWlzq0LiG9gRiIAm1b8Q6oc1xwpt
         rL5h8EJIpDC5VR8AiB7i2+qhFaENl5g1uCRN9C/JpgEHXnSoswrbDmwC9BtP47ZIl3sA
         O1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785072402; x=1785677202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nkX/QoeZrS0kRupcwaIPCrYydg188P1E6HxAusu+K+4=;
        b=XaRLptB9hvFWcyiXU9znttzC81ZMU6nbR+/DYdlFlFyPNeXg5mMFHZavZ/mXQKrcTu
         TRXRjIhy5y9sXYy0xLWqcOtadiHcCkZ17/as9NIJwt3ZFfONR/Y26SIWDcTxGxwvAszH
         nApRl4+nRQ0XaBcoYjgo55b1jbz4+PTEnBPrnS7n5qQlAxugrrQ+Y2I3XjDXk7w72J24
         3zzWTxkJiYDSG8DPyzhs9wei064RaPM3qM5euNek7GzTI/hFZBKI4k/sNwMpHgbtlzP+
         3b8fv8PJlJLpXKnapphv+edCgKs01BnhNRi8EYhdTu/dp2/bChdChiObUP8VezsLzN85
         SC+w==
X-Gm-Message-State: AOJu0Yy81keYbdyCKBYT1KURMXu4eVt8UrMR56eYR4pd5PodRcc1oktN
	31a0KXxSlttm2/EAfRAch1rpBTfhoLg31eSrTGUBhJPmywyo220hQbYAxGq2j2/Y
X-Gm-Gg: AR+sD11tkdM0GmP797VT1zdcbgCB0vI8pr055raqhq0hKE5nDrYETGRHFoZ0indeWYU
	cm8KsiiO463SZ0M54v86M3EYxiSpQD8QoTkrzgpYrNYoGdonr8eFs+yOsXA8A4IvwK4JUDbbI0A
	8WgvG/csuMC7I9J5fmtQhtdiM/oZCAoKswKDfIP2PuSjk0R5S8xpywyKm/GVfFi8GuJ/yggm1jS
	X5uqSRlJYrkbc7k+9tOKPgd1reHgNEBW42VGaBmptytJc1r/D0MsftRPwjdINSZXNng/BgDS2AQ
	1rcZs4CWJC4TRxjjsGMXap3Wodofv1rFR0Rf8VTYyE8t0QwvRYYYpyTXZD3VqKeCbLonQ+lPVlW
	DH0vrrsudUq8/z6btby/9smmnGuOMCYDgfbxAiRVwMQr7NAmBoYMbZzhL18drbQWyF/z8IduakB
	+p
X-Received: by 2002:a17:902:c947:b0:2c9:b48c:fdec with SMTP id d9443c01a7336-2cfde7a949amr47216565ad.12.1785072401867;
        Sun, 26 Jul 2026 06:26:41 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bbdc2sm20677655ad.42.2026.07.26.06.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 06:26:41 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net-next v2 1/2] net: phylink: allow PHYs to be attached in 802.3z inband mode
Date: Sun, 26 Jul 2026 21:26:17 +0800
Message-Id: <20260726132618.3580612-2-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260726132618.3580612-1-zxyan0222@gmail.com>
References: <20260726132618.3580612-1-zxyan0222@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

Now that we have proper decision making for inband mode support which
makes it a "best efforts" feature based on the capabilities of the PHY
and PCS, we can relax whether we expect and permit a PHY to be
attached. This is especially true for the 2500BASE-X case which some
PHYs use without inband on their host side interface for 2.5G speeds,
but use inband for slower speeds switching to SGMII on their host side
interface.

We already have such a case for some qcom-ethqos setups, although
qcom-ethqos overrides phylink's inband settings by accessing the PCS
directly at the moment. This should allow qcom-ethqos to transition to
defaulting to inband when 2500BASE-X or SGMII is specified in its DTS.

Allow PHYs to be attached when inband mode has been specified, which
will be necessary to allow inband mode to be used on qcom-ethqos.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 drivers/net/phy/phylink.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a7f78c82913a..66dddce05afe 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1983,9 +1983,7 @@ EXPORT_SYMBOL_GPL(phylink_destroy);
  */
 bool phylink_expects_phy(struct phylink *pl)
 {
-	if (pl->cfg_link_an_mode == MLO_AN_FIXED ||
-	    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
-	     phy_interface_mode_is_8023z(pl->link_interface)))
+	if (pl->cfg_link_an_mode == MLO_AN_FIXED)
 		return false;
 	return true;
 }
@@ -2224,9 +2222,7 @@ static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
 {
 	u32 flags = 0;
 
-	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED ||
-		    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
-		     phy_interface_mode_is_8023z(interface) && !pl->sfp_bus)))
+	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED))
 		return -EINVAL;
 
 	if (pl->phydev)
-- 
2.34.1

