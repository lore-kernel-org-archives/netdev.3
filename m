Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709840;
	b=pc4ZDOl2nGxws4Wzel2cevQPHulWR817LPkMSTJf6iO7F1D9cH6aVfXxUk/+GzsDaJgv
	 ugIGdNf1kBjwpRVFTZhouAJIjoPyQRtjtg0SDua2qcOyO8+qbPGwRF+y0ENPjfSKjNFN1
	 235dtgPxAJwFG3aTtGzWveTPYJotrmyBvLd0tLl51WySfAEKDUfyf35vyDt5d5h6JUtKk
	 0c+ca4HMZQT6v6SM1500IOAFIqKT9kuFXNQh0+QylvEymUwNR42mekZEDcShnPAoXa3f3
	 WZlTTsxWdI3Y2pFz964M3LJyZqmtseQigE4W4tjU4p5HM5p3De5d/kK2Mi6ELajAD2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709840;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=LZQ/9I91mNUcuhP0G3lEHnlf3oltqe6NJe/9E63RKNY=;
	b=Yg8K6tbCiEQ+Ah1yRIZhxITN5+1Sfno2o9M9k/jsvmNByhqyezSfUXJRsCeOnsxOT274
	 VD7P+Oa9PHf9W0xdOsNstlmdRwrckxjhZTatjeLYXTbZ8ZIRBxo9eXqUBqUdIfZl0npgR
	 WM1WXNN9Oqjc2e1u/yF4x5RhbtlqNisPlKFoZOouyrcLunToBFDNncsC24XY6l1Idw+QX
	 ackyjbTQhdO4GyLZWb1gL5xSq8N0O1lGOWPDx5F7DtwKDrUNF9zJn1ruZnkvtt9p2EcmB
	 K0rXjYBRWIX4qHZ3hL5mhy8TFoJQ+SBMNT5uJ2lCuS1NWi/aOqNikChON/5+iZzPC4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HA5KHy0t;
	arc=none smtp.remote-ip=209.85.161.99
Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7D8606A32C
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA7D8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HA5KHy0t
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-70b875f6f13so212744eaf.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792709839; x=1793314639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LZQ/9I91mNUcuhP0G3lEHnlf3oltqe6NJe/9E63RKNY=;
        b=gPRahO7WjmWCnp8yYMuDstRUAfeG5A3hU1oPddpyKvgJzcauTNEwv3X+lR0ljt4hs5
         p5T3rExqQYxugId+iBAdGBYa98IABOr55HnOkua6Q02YxoFobKsP92MsN+xj1rotJslP
         bYv6evC0HHKKAodhT0GzQKxIPcv2kb46Jo0iUs5OdYYODYSduaMi9PdmqIdNhADnOEMX
         1hlOu4ZZb+jRzH2yLRpmEcAi3GVl58/2Gmz1iojbR1wEfLAD2w3RkvOydm3IUOUrcUj+
         AMd49rdr86jOx/auQT7F0hT+EmVohBkJmHXENpKIf4hP6ny1IOhtB4plcX51Q5FAV5ik
         lGvQ==
X-Gm-Message-State: AFq9FYKGHfidIAD5XauDa7bkY2u91hVicPJHufjILpJ1kxicch/fGyfS
	x1LtRHUrkL3nObuHzNk9nC76wS7VopISwR8fnfHUUCaUb6UMnd6v7hP7S6goEZl+fTTH3ZTsVz7
	qK7mXSaAh3cV1/Bgm7oC7O2+sHcRnskhwu2c8Ep3aqDe4PQKuYEF87p43IHX8P/gDWMj5abN+OB
	KEbiAXmmbyOe912QtUhZDMxwJB0CramzqcrpFpeZA36VAN/obbeeHak0M5i72KJ/PsQ21xI33ut
	uHydW8wRduiEugL
X-Gm-Gg: AYBFou2CEEjWJ9W4mV+NTJYtAKuftqRswHK2okesq8gVoW6iO78oMTqdnXtdlmhrhJj
	hX6xiu/Y4HcQAZJhx/E+TI7y1q0rYhGFLFuwrEgVwSyZ6gQVX2XD7zrqOTw996+RRsccfyrns9U
	qsjc2uJsbhOSPhsLeg1rZeXL2EyrtgK4/kUzOUgOVeMcXv8zsrSjdr9dwkF6I3cAKvmYEmmaNsO
	KS2T+wnMV9T10OViV1P6bQLE2xBnDqdRkwNPrSvJOD+/WgeW5MKmycc8FoGfAjc0qVli+NbZQyY
	/i16ma/VdTUTIokURFN3A85a2m9pkHWYw+5l1kZc/HEKFQMUqxdooK0dSOJzfAVZt3xupnb6kU0
	npydgq0WGt4rgEqyfXCEFfXx7aVIY/KdG/nAIuOocur20zzgX0vJ9qr1zuO1OQFa8FROMS0NcOK
	wUu/nmvgbkDsdVXa8YhOaAPkDuByCwS6nkQTvS15ioPUs=
X-Received: by 2002:a05:6820:a111:b0:700:371e:ee11 with SMTP id 006d021491bc7-70b88b615c0mr407254eaf.78.1792709838761;
        Thu, 22 Oct 2026 15:57:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-84fbb28e27fsm3725a34.1.2026.10.22.15.57.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2026 15:57:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91b861c0618so6493436d6.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792709837; x=1793314637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LZQ/9I91mNUcuhP0G3lEHnlf3oltqe6NJe/9E63RKNY=;
        b=HA5KHy0tDbYh93rNm2fK8GiW7bg1d3sbZ/Oq+nku+aq/RfWAF8gpJzzzS8TKIIaqAC
         mGIcgXVFr1xmrmhi1YSchcgyuWQUV5bM4tnj2DFh1MeZfQEmSg25a3oxmBDEvzkUx2H6
         9RhVtJ5P43E2lB/ajCbIrNMWGS5xyApDXS4Z4=
X-Received: by 2002:a05:6214:2526:b0:91c:359a:3263 with SMTP id 6a1803df08f44-91c3a643b9emr4215816d6.7.1792709836807;
        Thu, 22 Oct 2026 15:57:16 -0700 (PDT)
X-Received: by 2002:a05:6214:2526:b0:91c:359a:3263 with SMTP id 6a1803df08f44-91c3a643b9emr4215546d6.7.1792709836304;
        Thu, 22 Oct 2026 15:57:16 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c395025d0sm4501656d6.5.2026.10.22.15.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:57:15 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 2/6 RESEND] net: dsa: b53: manage SerDes power through the PCS callbacks
Date: Thu, 22 Oct 2026 15:56:52 -0700
Message-ID: <20261022225656.1387306-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022225656.1387306-1-florian.fainelli@broadcom.com>
References: <20261022225656.1387306-1-florian.fainelli@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Powering down the SerDes from mac_link_down() prevents the PCS from
observing link recovery. This also ties PCS power management to in-band
802.3z mode, leaving SGMII and other negotiation modes inconsistent.

Implement pcs_enable() and pcs_disable() so that phylink controls the
lane lifetime independently of individual link transitions. Remove the
MAC-to-SerDes power callback and perform read-modify-write operations
under the register mutex.

Fixes: 0e01491de646 ("net: dsa: b53: Add SerDes support")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c |  8 ----
 drivers/net/dsa/b53/b53_priv.h   |  3 --
 drivers/net/dsa/b53/b53_serdes.c | 70 +++++++++++++++++++++++---------
 drivers/net/dsa/b53/b53_serdes.h |  2 -
 drivers/net/dsa/b53/b53_srab.c   |  1 -
 5 files changed, 51 insertions(+), 33 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 3f8f956aab82..09de3520e71a 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1630,10 +1630,6 @@ static void b53_phylink_mac_link_down(struct phylink_config *config,
 		b53_force_link(dev, port, false);
 		return;
 	}
-
-	if (phy_interface_mode_is_8023z(interface) &&
-	    dev->ops->serdes_link_set)
-		dev->ops->serdes_link_set(dev, port, mode, interface, false);
 }
 
 static void b53_phylink_mac_link_up(struct phylink_config *config,
@@ -1672,10 +1668,6 @@ static void b53_phylink_mac_link_up(struct phylink_config *config,
 		b53_force_link(dev, port, true);
 		return;
 	}
-
-	if (phy_interface_mode_is_8023z(interface) &&
-	    dev->ops->serdes_link_set)
-		dev->ops->serdes_link_set(dev, port, mode, interface, true);
 }
 
 int b53_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 29cca7945df7..cebbebe4ae0f 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -54,9 +54,6 @@ struct b53_io_ops {
 						      int port,
 						      phy_interface_t interface);
 	u8 (*serdes_map_lane)(struct b53_device *dev, int port);
-	void (*serdes_link_set)(struct b53_device *dev, int port,
-				unsigned int mode, phy_interface_t interface,
-				bool link_up);
 };
 
 struct b53_arl_entry;
diff --git a/drivers/net/dsa/b53/b53_serdes.c b/drivers/net/dsa/b53/b53_serdes.c
index c90894877626..87771e3788f7 100644
--- a/drivers/net/dsa/b53/b53_serdes.c
+++ b/drivers/net/dsa/b53/b53_serdes.c
@@ -107,6 +107,39 @@ static int b53_serdes_read(struct b53_device *dev, u8 lane,
 	return ret;
 }
 
+/* Return one if the register changed, zero if unchanged, or an error. */
+static int b53_serdes_modify(struct b53_device *dev, u8 lane, u8 offset,
+			     u16 block, u16 mask, u16 set)
+{
+	int ret, old;
+	u16 new;
+
+	mutex_lock(&dev->reg_mutex);
+	ret = b53_serdes_set_lane(dev, lane);
+	if (ret)
+		goto out;
+
+	old = b53_serdes_read_blk(dev, offset, block);
+	if (old < 0) {
+		ret = old;
+		goto out;
+	}
+
+	new = (old & ~mask) | set;
+	if (new == old)
+		goto out;
+
+	ret = b53_serdes_write_blk(dev, offset, block, new);
+	if (!ret)
+		ret = 1;
+out:
+	if (ret < 0)
+		dev->serdes_lane = B53_INVALID_LANE;
+	mutex_unlock(&dev->reg_mutex);
+
+	return ret;
+}
+
 static void b53_serdes_error(struct b53_device *dev, u8 lane, int ret)
 {
 	if (ret < 0)
@@ -202,32 +235,31 @@ static void b53_serdes_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 		state->pause |= MLO_PAUSE_TX;
 }
 
-void b53_serdes_link_set(struct b53_device *dev, int port, unsigned int mode,
-			 phy_interface_t interface, bool link_up)
+static int b53_serdes_enable(struct phylink_pcs *pcs)
 {
-	u8 lane = b53_serdes_map_lane(dev, port);
-	int reg;
+	struct b53_pcs *priv = pcs_to_b53_pcs(pcs);
+	int ret;
 
-	if (lane == B53_INVALID_LANE)
-		return;
+	ret = b53_serdes_modify(priv->dev, priv->lane,
+				B53_SERDES_MII_REG(MII_BMCR), SERDES_MII_BLK,
+				BMCR_PDOWN, 0);
+	return ret < 0 ? ret : 0;
+}
 
-	reg = b53_serdes_read(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
-			      SERDES_MII_BLK);
-	if (reg < 0)
-		goto out;
+static void b53_serdes_disable(struct phylink_pcs *pcs)
+{
+	struct b53_pcs *priv = pcs_to_b53_pcs(pcs);
+	int ret;
 
-	if (link_up)
-		reg &= ~BMCR_PDOWN;
-	else
-		reg |= BMCR_PDOWN;
-	reg = b53_serdes_write(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
-			       SERDES_MII_BLK, reg);
-out:
-	b53_serdes_error(dev, lane, reg);
+	ret = b53_serdes_modify(priv->dev, priv->lane,
+				B53_SERDES_MII_REG(MII_BMCR), SERDES_MII_BLK,
+				BMCR_PDOWN, BMCR_PDOWN);
+	b53_serdes_error(priv->dev, priv->lane, ret);
 }
-EXPORT_SYMBOL(b53_serdes_link_set);
 
 static const struct phylink_pcs_ops b53_pcs_ops = {
+	.pcs_enable = b53_serdes_enable,
+	.pcs_disable = b53_serdes_disable,
 	.pcs_get_state = b53_serdes_get_state,
 	.pcs_config = b53_serdes_config,
 	.pcs_an_restart = b53_serdes_an_restart,
diff --git a/drivers/net/dsa/b53/b53_serdes.h b/drivers/net/dsa/b53/b53_serdes.h
index 3d367c4df4d9..6c851838457e 100644
--- a/drivers/net/dsa/b53/b53_serdes.h
+++ b/drivers/net/dsa/b53/b53_serdes.h
@@ -107,8 +107,6 @@ static inline u8 b53_serdes_map_lane(struct b53_device *dev, int port)
 	return dev->ops->serdes_map_lane(dev, port);
 }
 
-void b53_serdes_link_set(struct b53_device *dev, int port, unsigned int mode,
-			 phy_interface_t interface, bool link_up);
 struct phylink_pcs *b53_serdes_phylink_mac_select_pcs(struct b53_device *dev,
 						      int port,
 						      phy_interface_t interface);
diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index 83a03fca142a..9988a83fa7b7 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -493,7 +493,6 @@ static const struct b53_io_ops b53_srab_ops = {
 #if IS_ENABLED(CONFIG_B53_SERDES)
 	.phylink_mac_select_pcs = b53_serdes_phylink_mac_select_pcs,
 	.serdes_map_lane = b53_srab_serdes_map_lane,
-	.serdes_link_set = b53_serdes_link_set,
 #endif
 };
 
-- 
2.53.0

