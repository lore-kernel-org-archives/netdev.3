Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774083B1EFC
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780635399; cv=none; b=D1hOmtB1spQMGYJ+SZzqiubP25afA1rtxBJ3T1gU0+E8KBkL+bdFma1T6Ai+K+VAi2QPpS1eDqe5LX9mg3b8Ys2o25vOOzfSwxSxl0u3cggbBbpeNfrEzShvg/yDNZjk5V/euhuuKNjtm1S15YSgeuKrpNQPVEMSdVlCF0j6Rgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780635399; c=relaxed/simple;
	bh=6vvUpEnA3zuZyhkh5L9tx3acH0/PiR28xnODKHfdVgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cCu/0p+J+AxeL+lkiPhYgh9L4Ps/zPPTaY270TiclxQHDHxiCavV8Mx1V3DMZ6VChp+JUZMS5vMPCDZB8OB3XN9lpumwUioq+ixMQ8vXIAxkNJvnFl+UIhIZPZaaJGQxmX4qpa4+TkthzHDAHrHSPK4lkU3cx2upXa4pWKXzX5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUvjZSCK; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUvjZSCK"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7ddd3d67084so16806227b3.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 21:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780635397; x=1781240197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgdsNgCTJpv8k0KRcqQg2bYC+LqfZpfIBBy5KwRLQzE=;
        b=IUvjZSCKqNxxLckuZWHiMsSN+bUR9E/2GV2xQCubK1C1VoOewHO3ciDHb0+4wOfKz9
         2tDMOiK2V0YUL3E3jV8sU2K4Y7UUYwnrgX1Tqd499rvn8hvpu/2c6vZgwKq6ggBlF96n
         aWd1c7gMLjTQgA5kbZXsmu39NxYNR75QCaEFUdyTJAwH0rvNINIxUUZmAFQu2UHaedZf
         R2QR44RoLftPguvacnYyAajbmlcjSvSQXjmBCQ1i2dBm2Cc3NJcFLMuvSfx0IpmRIxjF
         XDyD30iD1JYOA3tgjk9NCpEuyiOyojWzlnTSpJ73DziM/JTYr+YNFsVrTrOyS/vDM7YI
         7idQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780635397; x=1781240197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rgdsNgCTJpv8k0KRcqQg2bYC+LqfZpfIBBy5KwRLQzE=;
        b=Neb+ropyC2Sy0E5Hu/OK6EDVeo0Q6kLo8m3gy2X/TFyYEIEmtdVxt+ujCgWsiytOR5
         rII4aK6kIsDOmaHpQaPXJmClj52KUB2mCBgYUZn9va5c2E7SSXiUVqJ7XEDpU/ah0/wZ
         /xqIFf2d3vfaxUQ7uwiDEz3OunLV0UnI7r/DQ57Piuv/WzlNbdVHLCYvnNi56pUNZN8G
         F8d9gNAZJjlMACEDpDC4iCtq4GRb472Rtw+ryGDqvrWAzryyIkyDPnnUfUuaf4dkTJPu
         mIjHcjmcHCqODFBkfp/JId+ucHjqt2GqxkeONOO1ur0QK1LdhH0Xz+dykPWd1AlxstpR
         9nFg==
X-Gm-Message-State: AOJu0YzZy6Cdsda090G4szU1BxwLrG/zU9uNRrX/PFlrpxqftzqsHBDq
	IMITWdybqIXvD3win6+G5wxFYODy1qGm4K5kuqQc0J7yeaQHW9KGqCch
X-Gm-Gg: Acq92OGkRAEV2/tok6t3jqvfkXXhZVPsjs09d1jYU5D62v63NFWNXkkwGq1pQ+mWsxX
	bntkBq+fE3aR3EcuE23QI/w/h5myCXMY3CbiGIsqluQI45/+CCvWvFpb92riMgf0ktPDtGMKpLH
	gP/nuoqAdUqascb+eRKheBG4FJ2BnF2IuW1AsdpwXI+QDKD6zUcm+AHRB6/rsonupFNY8nbaPZU
	GJUD3FpcWfYbx0v07HBMiOkRNPxHOkzbXVW9NsEuOlV7fE+c42xulEIxiWdDc/WNsPc3e8nYd0V
	KKbx+LgWzLYidPLRPmE4kxI2Uc7e3uudAKa/1Bm6OPF85bw79Cwl11sYec81fHgvinq+gSeU+TY
	sX1l75B2WCGzUTIV3eMS2oo6VIrSrys+fYe7qx3W4vy+8TYth/NvNR5BGOGi8Jxy+kYLhD+l9qy
	f8H9+WDAbLehfLJr7dc9hUxvpIGQ6QGfkcvrBf7H8UrDe+enJKYff2Kn3Z3Vq3
X-Received: by 2002:a05:690c:3602:b0:7db:f8b1:cd89 with SMTP id 00721157ae682-7ed0b874a8cmr19771617b3.10.1780635397541;
        Thu, 04 Jun 2026 21:56:37 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea215825d2sm45840207b3.16.2026.06.04.21.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 21:56:36 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 05 Jun 2026 01:56:09 -0300
Subject: [net-next PATCH v12 1/9] net: dsa: realtek: rtl8365mb: use ERR_PTR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-realtek_forward-v12-1-78eb7b31df72@gmail.com>
References: <20260605-realtek_forward-v12-0-78eb7b31df72@gmail.com>
In-Reply-To: <20260605-realtek_forward-v12-0-78eb7b31df72@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2

Convert numeric error codes into human-readable strings by using %pe
together with ERR_PTR() in dev_err() messages.  Also use dev_err_probe()
instead of checking for -EPROBE_DEFER.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 51 +++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 0da048da533a..2637884fe472 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -803,8 +803,8 @@ static int rtl8365mb_phy_read(struct realtek_priv *priv, int phy, int regnum)
 	ret = rtl8365mb_phy_ocp_read(priv, phy, ocp_addr, &val);
 	if (ret) {
 		dev_err(priv->dev,
-			"failed to read PHY%d reg %02x @ %04x, ret %d\n", phy,
-			regnum, ocp_addr, ret);
+			"failed to read PHY%d reg %02x @ %04x, ret %pe\n", phy,
+			regnum, ocp_addr, ERR_PTR(ret));
 		return ret;
 	}
 
@@ -831,8 +831,8 @@ static int rtl8365mb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	ret = rtl8365mb_phy_ocp_write(priv, phy, ocp_addr, val);
 	if (ret) {
 		dev_err(priv->dev,
-			"failed to write PHY%d reg %02x @ %04x, ret %d\n", phy,
-			regnum, ocp_addr, ret);
+			"failed to write PHY%d reg %02x @ %04x, ret %pe\n", phy,
+			regnum, ocp_addr, ERR_PTR(ret));
 		return ret;
 	}
 
@@ -1082,8 +1082,8 @@ static void rtl8365mb_phylink_mac_config(struct phylink_config *config,
 		ret = rtl8365mb_ext_config_rgmii(priv, port, state->interface);
 		if (ret)
 			dev_err(priv->dev,
-				"failed to configure RGMII mode on port %d: %d\n",
-				port, ret);
+				"failed to configure RGMII mode on port %d: %pe\n",
+				port, ERR_PTR(ret));
 		return;
 	}
 
@@ -1112,8 +1112,8 @@ static void rtl8365mb_phylink_mac_link_down(struct phylink_config *config,
 						     false, false);
 		if (ret)
 			dev_err(priv->dev,
-				"failed to reset forced mode on port %d: %d\n",
-				port, ret);
+				"failed to reset forced mode on port %d: %pe\n",
+				port, ERR_PTR(ret));
 
 		return;
 	}
@@ -1143,8 +1143,8 @@ static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
 						     rx_pause);
 		if (ret)
 			dev_err(priv->dev,
-				"failed to force mode on port %d: %d\n", port,
-				ret);
+				"failed to force mode on port %d: %pe\n", port,
+				ERR_PTR(ret));
 
 		return;
 	}
@@ -1299,8 +1299,8 @@ static void rtl8365mb_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *da
 						 mib->length, &data[i]);
 		if (ret) {
 			dev_err(priv->dev,
-				"failed to read port %d counters: %d\n", port,
-				ret);
+				"failed to read port %d counters: %pe\n", port,
+				ERR_PTR(ret));
 			break;
 		}
 	}
@@ -1652,7 +1652,8 @@ static irqreturn_t rtl8365mb_irq(int irq, void *data)
 	return IRQ_HANDLED;
 
 out_error:
-	dev_err(priv->dev, "failed to read interrupt status: %d\n", ret);
+	dev_err(priv->dev, "failed to read interrupt status: %pe\n",
+		ERR_PTR(ret));
 
 out_none:
 	return IRQ_NONE;
@@ -1725,10 +1726,13 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 	/* rtl8365mb IRQs cascade off this one */
 	irq = of_irq_get(intc, 0);
 	if (irq <= 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(priv->dev, "failed to get parent irq: %d\n",
-				irq);
-		ret = irq ? irq : -EINVAL;
+		if (!irq) {
+			dev_err(priv->dev, "failed to map IRQ\n");
+			ret = -EINVAL;
+		} else {
+			ret = dev_err_probe(priv->dev, irq,
+					    "failed to get parent irq\n");
+		}
 		goto out_put_node;
 	}
 
@@ -1790,7 +1794,8 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 	ret = request_threaded_irq(irq, NULL, rtl8365mb_irq, IRQF_ONESHOT,
 				   "rtl8365mb", priv);
 	if (ret) {
-		dev_err(priv->dev, "failed to request irq: %d\n", ret);
+		dev_err(priv->dev, "failed to request irq: %pe\n",
+			ERR_PTR(ret));
 		goto out_remove_irqdomain;
 	}
 
@@ -1966,14 +1971,16 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 
 	ret = rtl8365mb_reset_chip(priv);
 	if (ret) {
-		dev_err(priv->dev, "failed to reset chip: %d\n", ret);
+		dev_err(priv->dev, "failed to reset chip: %pe\n",
+			ERR_PTR(ret));
 		goto out_error;
 	}
 
 	/* Configure switch to vendor-defined initial state */
 	ret = rtl8365mb_switch_init(priv);
 	if (ret) {
-		dev_err(priv->dev, "failed to initialize switch: %d\n", ret);
+		dev_err(priv->dev, "failed to initialize switch: %pe\n",
+			ERR_PTR(ret));
 		goto out_error;
 	}
 
@@ -2091,8 +2098,8 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 
 	ret = rtl8365mb_get_chip_id_and_ver(priv->map, &chip_id, &chip_ver);
 	if (ret) {
-		dev_err(priv->dev, "failed to read chip id and version: %d\n",
-			ret);
+		dev_err(priv->dev, "failed to read chip id and version: %pe\n",
+			ERR_PTR(ret));
 		return ret;
 	}
 

-- 
2.54.0

