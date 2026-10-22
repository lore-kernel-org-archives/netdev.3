Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709845;
	b=C2IZ//7c8AmjiXWLuUjIKm44McyHajcjPrCoJ3SvuPApDEWGj4+SW5FNsv+r7rXt9lfm
	 Xc9LMmgiQy/G2II4ISen2k/ndoiCwtjjni0OcW/AqVjqNgDmgcvUWdvwRX8JfuTGkihmN
	 jxivyQXEK+SL1jHokeCQH96TfWfvQh+SyFdP83T2XsyKPMjRjrpRn667JOY4JRV7iDvGy
	 uYAIF8BoYVy0ACVe6eYlqpboBwLWuKUbKf3HQBEoLMql6jyZQgmSCrbLCm/ToI+jL/qNf
	 hmtwSli4+y0fghkghDy+SFyiAKk/ov7q+DOOU0o4j0Pea8atdWdWxmoY979lagX0fkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709845;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=aSf7v2rxYowjbHfTF1igam6+hD/KB7/9ZuB9AjIMtM4=;
	b=ApBRbHjGq1cg4DmpzOCVfbZIwg6tulwE08r4xR/ZalA52UZV0LC86tq+KmfwOHgKputg
	 qrTI+Nd3lJkEdvltfwYTjytxO1sHEDxl/uj5rMBBn+91bkyZ5zlYb/oSFIbpcGX3LQpzR
	 gv3pavRK2eun8dBcBpUeNzP7r7Anwnyb65eqxqGHU1trKXsEIKWaTuZiwYejYG5E4mZao
	 4vWjlnCnkiXGhbOOSf6k6t7tY9yg/kPNW0ApGLGZs6nrZqAwv86AyBVvI2hp9lReScUdF
	 7OZPPsSEerCBG9ee8o790olWGuFGmrQfIxidJKM+wX5tKWOlg1HlROaHo99SfKf/GDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=FX5T7wFz;
	arc=none smtp.remote-ip=74.125.82.225
Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com [74.125.82.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646260A2625
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B646260A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=FX5T7wFz
Received: by mail-dy1-f225.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso542021eec.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792709844; x=1793314644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSf7v2rxYowjbHfTF1igam6+hD/KB7/9ZuB9AjIMtM4=;
        b=LDBG+7Kl698prXbc3f6tYopZB4y+ftjZYoarGlDnyIRqxvk88aXxvfiCkFWpn5u0O0
         SSR9z1dmlxez9K/IEFKH1c+slF9S8h1ZulHdU467pFwMcN2/PBCJ7mDk9AN+dFOjWgcr
         pYKmC5a+31B9IiRU9FeAdPeZheuJhEbbVbeMonD9K3KUfb+P7kXzqXtJSoo9h6phtsjJ
         5N+Hflp6JdIRG+WdvvBtc1zJbfU+ZYnsk8mUpGFpIA49pxc1Y+wHckMHureh2go35/fw
         0Xv6GXD+Ili1eW0iwAPieLog5+cMa5KK9HfeyPK6eDpPvyg25jIIQt8Cyk+EzLANpOJ6
         UBbQ==
X-Gm-Message-State: AFq9FYLJ1UhzCk4XFET2oz0VAnZLS3YPGu+iCj62+8omGspM10ubYauv
	VYbT7VYT+hbb7/X3NewO41gQYNXkh+zOX7GNfRgSufi4F9m+KyWcL1GbKySxH2QQj7PL2IiLWjA
	53/BgWapgjAuqVYRcDnyosj2LdcLJI6QTQt5pVL8rBYyY5p3IbuZUbhFTtUWR2Gz1lhMDloAYnt
	mgmKZuCBliKeSO8UZLbUuSWVFXjx69pusZOWN6p6a+dx3lWlSwDH7+j+47vmP90F+dGP8fgzyWO
	z9csOTCr1G6qbgr
X-Gm-Gg: AYBFou07gmmzT0bbvm9fyUMe8WJ2yqzH/QU8Or12u1UkBGke46iUcdkEIIYKbYVfxfK
	tLS7f48PGWfBaM028bWTk8Tiys0lexqMiOhHYWIUEOMOf+xhh99LXriq5WmNtJQsOetrH/bjjHD
	1Z/N+CB1z9ms+FrKuCTvttYsn0cKwod2G6NPyu4/6eqejr0VqFtxQL+51ni4lFSyDNq+72jeSn/
	IVS1nAqeZsGfOwgYtRZYqdipEEkfVJ3E9/PLHZqsGTq+37J8MjnaZzuhLom9NUIToIJfstRFUNw
	PMrJ6q4iXcoUGtwFAi+cB3JCdUh+9c4J8SPR5dRhHZ8EImVipC7imryvHlfl5mzNCL0LgBpyzja
	krNC6Unn5eOKxA1qQkaPUEl8N/1e1eHiOrDL6wZ4WRQw0c8qCf7E7KgHLbFfWVIp8jyNJSjobOh
	w5yfGaWrC1v8kgg49L/+Vg8yNc9Y5sIZNtQH59xz8ZN4Y=
X-Received: by 2002:a05:7300:b1aa:b0:368:2548:c089 with SMTP id 5a478bee46e88-369d90ea370mr721804eec.5.1792709843393;
        Thu, 22 Oct 2026 15:57:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-369d9e2959asm7735eec.23.2026.10.22.15.57.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2026 15:57:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93909014c85so55995685a.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792709842; x=1793314642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aSf7v2rxYowjbHfTF1igam6+hD/KB7/9ZuB9AjIMtM4=;
        b=FX5T7wFzJPLEShF9NVLC+dPC9aH3FtQ/4rhEsEPIfzgJcQvd3Z0KObAls1ChxVBPKT
         Oy+VG/gRdxwyYjTlwJW0ukK1sBaWSKMrDnm27vrwrWL2X1Sl87L+tJbKodRxPVOLl+I8
         RSDhHfTy1POEEO7ottUEZuYuah+eJXds/6fsY=
X-Received: by 2002:a05:620a:1a05:b0:93e:4bbf:cc32 with SMTP id af79cd13be357-93f6f7c2d49mr173784485a.35.1792709841758;
        Thu, 22 Oct 2026 15:57:21 -0700 (PDT)
X-Received: by 2002:a05:620a:1a05:b0:93e:4bbf:cc32 with SMTP id af79cd13be357-93f6f7c2d49mr173780785a.35.1792709841105;
        Thu, 22 Oct 2026 15:57:21 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c395025d0sm4501656d6.5.2026.10.22.15.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:57:20 -0700 (PDT)
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
Subject: [PATCH net 4/6 RESEND] net: dsa: b53: configure PCS negotiation and forced link parameters
Date: Thu, 22 Oct 2026 15:56:54 -0700
Message-ID: <20261022225656.1387306-5-florian.fainelli@broadcom.com>
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

pcs_config() currently only selects fiber mode. Configure the Clause 37
or SGMII advertisement and BMCR autonegotiation enable from phylink's
negotiation mode, clear isolation, disable protocol auto-detection and
select the MAC side of SGMII explicitly. Report changes to phylink so it
can restart negotiation, and expose the supported in-band modes.

Implement pcs_link_up() for forced speed and duplex when in-band
negotiation is disabled. Use the receiver hold and TX FIFO reset sequence
from the downstream robo SerDes driver, clear its vendor speed override,
and restore the receiver and FIFO even if programming fails.

Leave analog and PLL initialization to the existing firmware setup.

Fixes: 0e01491de646 ("net: dsa: b53: Add SerDes support")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_serdes.c | 187 ++++++++++++++++++++++++-------
 drivers/net/dsa/b53/b53_serdes.h |   6 +
 2 files changed, 151 insertions(+), 42 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_serdes.c b/drivers/net/dsa/b53/b53_serdes.c
index d521050d7c8f..fc20e211e67e 100644
--- a/drivers/net/dsa/b53/b53_serdes.c
+++ b/drivers/net/dsa/b53/b53_serdes.c
@@ -75,22 +75,6 @@ static int b53_serdes_set_lane(struct b53_device *dev, u8 lane)
 	return 0;
 }
 
-static int b53_serdes_write(struct b53_device *dev, u8 lane,
-			    u8 offset, u16 block, u16 value)
-{
-	int ret;
-
-	mutex_lock(&dev->reg_mutex);
-	ret = b53_serdes_set_lane(dev, lane);
-	if (!ret)
-		ret = b53_serdes_write_blk(dev, offset, block, value);
-	if (ret)
-		dev->serdes_lane = B53_INVALID_LANE;
-	mutex_unlock(&dev->reg_mutex);
-
-	return ret;
-}
-
 static int b53_serdes_read(struct b53_device *dev, u8 lane,
 			   u8 offset, u16 block)
 {
@@ -147,44 +131,161 @@ static void b53_serdes_error(struct b53_device *dev, u8 lane, int ret)
 				    lane, ERR_PTR(ret));
 }
 
+static unsigned int b53_serdes_inband_caps(struct phylink_pcs *pcs,
+					   phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+	default:
+		return 0;
+	}
+}
+
+static int b53_serdes_force_link(struct b53_pcs *priv, int speed, int duplex)
+{
+	struct b53_device *dev = priv->dev;
+	u8 lane = priv->lane;
+	u16 bmcr = mii_bmcr_encode_fixed(speed, duplex);
+	u16 mask = BMCR_SPEED100 | BMCR_SPEED1000 | BMCR_FULLDPLX;
+	int old, misc, rx, fifo, ret, err;
+
+	old = b53_serdes_read(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
+			      SERDES_MII_BLK);
+	if (old < 0)
+		return old;
+	misc = b53_serdes_read(dev, lane, B53_SERDES_DIGITAL_MISC1,
+			       SERDES_DIGITAL_BLK);
+	if (misc < 0)
+		return misc;
+	rx = b53_serdes_read(dev, lane, B53_SERDES_RX_CONTROL, SERDES_RX_BLK);
+	if (rx < 0)
+		return rx;
+	fifo = b53_serdes_read(dev, lane, B53_SERDES_DIGITAL_CONTROL(3),
+			       SERDES_DIGITAL_BLK);
+	if (fifo < 0)
+		return fifo;
+
+	if ((old & mask) == bmcr && !(misc & FORCE_SPEED_MASK) &&
+	    !(rx & RX_SEQ_START) && !(fifo & TX_FIFO_RST))
+		return 0;
+
+	/* Hold the receiver and TX FIFO while switching the forced speed,
+	 * following the downstream robo SerDes programming sequence.
+	 */
+	ret = b53_serdes_modify(dev, lane, B53_SERDES_RX_CONTROL,
+				SERDES_RX_BLK, RX_SEQ_START, RX_SEQ_START);
+	if (ret < 0)
+		goto release;
+
+	ret = b53_serdes_modify(dev, lane, B53_SERDES_DIGITAL_CONTROL(3),
+				SERDES_DIGITAL_BLK, TX_FIFO_RST, TX_FIFO_RST);
+	if (ret < 0)
+		goto release;
+
+	ret = b53_serdes_modify(dev, lane, B53_SERDES_DIGITAL_MISC1,
+				SERDES_DIGITAL_BLK, FORCE_SPEED_MASK, 0);
+	if (ret >= 0)
+		ret = b53_serdes_modify(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
+					SERDES_MII_BLK, mask, bmcr);
+release:
+	/* A failed write may have reached the device. Release both holds. */
+	err = b53_serdes_modify(dev, lane, B53_SERDES_RX_CONTROL,
+				SERDES_RX_BLK, RX_SEQ_START, 0);
+	if (ret >= 0)
+		ret = err;
+	err = b53_serdes_modify(dev, lane, B53_SERDES_DIGITAL_CONTROL(3),
+				SERDES_DIGITAL_BLK, TX_FIFO_RST, 0);
+	if (ret >= 0)
+		ret = err;
+
+	return ret < 0 ? ret : 1;
+}
+
 static int b53_serdes_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 			     phy_interface_t interface,
 			     const unsigned long *advertising,
 			     bool permit_pause_to_mac)
 {
-	struct b53_device *dev = pcs_to_b53_pcs(pcs)->dev;
-	u8 lane = pcs_to_b53_pcs(pcs)->lane;
-	int reg;
+	struct b53_pcs *priv = pcs_to_b53_pcs(pcs);
+	struct b53_device *dev = priv->dev;
+	u8 lane = priv->lane;
+	int adv, ret, changed;
+	u16 ctrl, bmcr;
 
-	reg = b53_serdes_read(dev, lane, B53_SERDES_DIGITAL_CONTROL(1),
-			      SERDES_DIGITAL_BLK);
-	if (reg < 0)
-		return reg;
-
-	if (interface == PHY_INTERFACE_MODE_1000BASEX)
-		reg |= FIBER_MODE_1000X;
-	else
-		reg &= ~FIBER_MODE_1000X;
-	return b53_serdes_write(dev, lane, B53_SERDES_DIGITAL_CONTROL(1),
-				SERDES_DIGITAL_BLK, reg);
+	if (!test_bit(interface, pcs->supported_interfaces))
+		return -EINVAL;
+
+	adv = phylink_mii_c22_pcs_encode_advertisement(interface, advertising);
+	if (adv < 0)
+		return adv;
+
+	ctrl = interface == PHY_INTERFACE_MODE_1000BASEX ? FIBER_MODE_1000X : 0;
+	/* Select the protocol explicitly and act as the MAC in SGMII mode. */
+	ret = b53_serdes_modify(dev, lane, B53_SERDES_DIGITAL_CONTROL(1),
+				SERDES_DIGITAL_BLK,
+				FIBER_MODE_1000X | AUTODET_EN | SGMII_MASTER_MODE,
+				ctrl);
+	if (ret < 0)
+		return ret;
+	changed = ret;
+
+	ret = b53_serdes_modify(dev, lane, B53_SERDES_MII_REG(MII_ADVERTISE),
+				SERDES_MII_BLK, 0xffff, adv);
+	if (ret < 0)
+		return ret;
+	changed |= ret;
+
+	if (interface == PHY_INTERFACE_MODE_1000BASEX &&
+	    neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED) {
+		/* The baud rate must be set before waiting for PCS link-up. */
+		ret = b53_serdes_force_link(priv, SPEED_1000, DUPLEX_FULL);
+	} else {
+		ret = b53_serdes_modify(dev, lane, B53_SERDES_DIGITAL_MISC1,
+					SERDES_DIGITAL_BLK, FORCE_SPEED_MASK, 0);
+	}
+	if (ret < 0)
+		return ret;
+	changed |= ret;
+
+	bmcr = neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED ? BMCR_ANENABLE : 0;
+	/* phylink requests Clause 37 restarts separately, but not SGMII. */
+	if (bmcr && changed && interface == PHY_INTERFACE_MODE_SGMII)
+		bmcr |= BMCR_ANRESTART;
+	ret = b53_serdes_modify(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
+				SERDES_MII_BLK,
+				BMCR_ANENABLE | BMCR_ISOLATE | BMCR_ANRESTART, bmcr);
+	if (ret < 0)
+		return ret;
+
+	/* The MAC applies phylink's resolved pause policy in mac_link_up(). */
+	return changed | ret;
 }
 
 static void b53_serdes_an_restart(struct phylink_pcs *pcs)
 {
-	struct b53_device *dev = pcs_to_b53_pcs(pcs)->dev;
-	u8 lane = pcs_to_b53_pcs(pcs)->lane;
-	int reg;
+	struct b53_pcs *priv = pcs_to_b53_pcs(pcs);
+	int ret;
 
-	reg = b53_serdes_read(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
-			      SERDES_MII_BLK);
-	if (reg < 0)
-		goto out;
+	ret = b53_serdes_modify(priv->dev, priv->lane,
+				B53_SERDES_MII_REG(MII_BMCR), SERDES_MII_BLK,
+				BMCR_ANRESTART, BMCR_ANRESTART);
+	b53_serdes_error(priv->dev, priv->lane, ret);
+}
 
-	reg |= BMCR_ANRESTART;
-	reg = b53_serdes_write(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
-			       SERDES_MII_BLK, reg);
-out:
-	b53_serdes_error(dev, lane, reg);
+static void b53_serdes_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
+			       phy_interface_t interface, int speed, int duplex)
+{
+	struct b53_pcs *priv = pcs_to_b53_pcs(pcs);
+	int ret;
+
+	if (interface != PHY_INTERFACE_MODE_SGMII ||
+	    neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+		return;
+
+	ret = b53_serdes_force_link(priv, speed, duplex);
+	b53_serdes_error(priv->dev, priv->lane, ret);
 }
 
 static void b53_serdes_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
@@ -258,11 +359,13 @@ static void b53_serdes_disable(struct phylink_pcs *pcs)
 }
 
 static const struct phylink_pcs_ops b53_pcs_ops = {
+	.pcs_inband_caps = b53_serdes_inband_caps,
 	.pcs_enable = b53_serdes_enable,
 	.pcs_disable = b53_serdes_disable,
 	.pcs_get_state = b53_serdes_get_state,
 	.pcs_config = b53_serdes_config,
 	.pcs_an_restart = b53_serdes_an_restart,
+	.pcs_link_up = b53_serdes_link_up,
 };
 
 void b53_serdes_phylink_get_caps(struct b53_device *dev, int port,
diff --git a/drivers/net/dsa/b53/b53_serdes.h b/drivers/net/dsa/b53/b53_serdes.h
index 6c851838457e..2c2aa5eaa985 100644
--- a/drivers/net/dsa/b53/b53_serdes.h
+++ b/drivers/net/dsa/b53/b53_serdes.h
@@ -22,6 +22,11 @@
 #define B53_SERDES_MII_REG(x)		(0x20 + (x) * 2)
 #define B53_SERDES_DIGITAL_CONTROL(x)	(0x1e + (x) * 2)
 #define B53_SERDES_DIGITAL_STATUS	0x28
+#define B53_SERDES_DIGITAL_MISC1		0x30
+#define  FORCE_SPEED_MASK		GENMASK(4, 0)
+
+#define B53_SERDES_RX_CONTROL		0x22
+#define  RX_SEQ_START			BIT(15)
 
 /* SERDES_DIGITAL_CONTROL1 */
 #define  FIBER_MODE_1000X		BIT(0)
@@ -92,6 +97,7 @@
 #define  TXFIFO_ERR_DET			BIT(15)
 
 /* Block offsets */
+#define SERDES_RX_BLK			0x80b0
 #define SERDES_DIGITAL_BLK		0x8300
 #define SERDES_ID0			0x8310
 #define SERDES_MII_BLK			0xffe0
-- 
2.53.0

