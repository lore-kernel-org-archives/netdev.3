Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709847;
	b=sfZkQVRmTQLnFZbiXescyNOt85mCp17338fA70ut6OunXh4+FH6om/SKH1ZLFAhl6/s5
	 /X/h6xJBNv9yf6GELzC0nQGhUnmCC1Duyn5Y2/t5ZxFqv5/sERGIBRKRwsEoKLhTZLrQY
	 O9y5kvfOjLL6a8MCCs9VWE8gHuJDRPx1UtDS0Woczf9RSRp1fL2zp2ZDdUDm1y/RNz4Um
	 8BzcsWDgrx2bgjGPMF10s2vycT3XtYffZJjsC+qu+8Wazt5R7FrNfIzF0tXw2tgXnGX7u
	 XFGoHH1E7tbXkdvHmX9usEModGMz5ZBm3OGjcw1cavsbtL5z+IsESt1qctJ/z3YaG0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709847;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=WigrYeX8rfIc0uBYkqlaE73MENE+ioOdixBQzIPPQ94=;
	b=eneQFHi7zon4t0rRQpF1+bbi4i4Y9Q3J4obSz29PsndKGO5wPPcNjEzgz9GVN2JcIAen
	 mfbapIc/IA6IVkspzQvbiE6qZjoCpG0uYQKyforamWSvW9bYk5nXGXlvaCgiXepY6eRE/
	 T5xA/A7cnsQf166R/1TYWkMVGCH+ZPhQSXJGzPeUrKWPq7/0FjTNQP4RAcurPXKvzwVg6
	 ZYdEc09xU3aykF1a9ZZ7fMNb7tRJEn6jJus6JABxEdPZViJYbB+CfQd9qP5UC9ZV9b7rS
	 SmqVPrnbt2a0USH3IVlgvyiveMn9d3+e6WAemzefSuJfEZsE7wP18x3/Lalf4KUUE5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VmYwkCdl;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD2D60A3802
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDD2D60A3802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VmYwkCdl
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so283297a91.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792709846; x=1793314646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WigrYeX8rfIc0uBYkqlaE73MENE+ioOdixBQzIPPQ94=;
        b=J4dHZ4TCG0e9Ggv4kcZf2vKECz2bU5h7ILxbamL4KbOZ4ezhglifZuDB3yjtfCOEUZ
         xFRIsPzWlnjEDX/5CqUZ1p2rHnQP1zqIoux6wDXXfZod/wJznF0or6uJ/AgGS5gK+CpR
         Gw/mBbnQu6uOEIlxhkPKW/steq/zS/kWrp1XM/SETjE8FhdFjesidq8tERor4CeV00f+
         2+UbHhRAUb6aF27py/r6L4wCpFfwJ8ayxoGhX9fFrct3+viYK5N3dsdBcvv1efuHr6XH
         SANylB8owOLAWHBr3rtctAmxDlGpWsyzud/LILztFeCC6B5l68OMbzgtpIqg+QBx852T
         sjtw==
X-Gm-Message-State: AFq9FYIP5rxb8HlPxbLbbaaYZ7gx8qqqDfc4CeFsDHpnVurUfqlu4xZx
	DFMH/xqKRU2iib5bp+sLMIbaz12ROX0VbXWFE0LiY3DnTZXIA+hmbpBhwsO1GJNatVArLWQN4Ms
	F0pVX9Oxg1KR7p6BtfX398QkIsHcMXnrbDGjUqqZSiglOLQBVgdGAKkLLqu8JoDIt3nS8/vZee+
	0d1otgNfmz/vtmel18y4uaf1XENiNn6RgLprlnHynP7p9GBhxI6I5D7eC/HOqRqb3h0TJLHM+tR
	7uUbIq1btwuqafh
X-Gm-Gg: AYBFou2xXGgYPjTJMg8wSSvfKgTsgznG/StXxW58qp5cOFMDhzJFg+KHYC2Ov7beoL9
	gQXFdp9qp7EHj60GjaBiLgRIA/y5j16NQOy/YGM5dEXcB5iOcXLrccPviFgvFVxfd7w0P31z1gg
	feIlNI3EBNFSt68AAL7tsoI01NzsvPw5+Mqj8g/T6YRkR1BTneIubyqsch2qUKQSUjHsX17wBCK
	EgqGBAFUO6e6IkdVR27kK6JAPdOvb80BJZ2dlX7YtI3owANMAB3WftpGDDwfbiBnfolYNAND/Ri
	kjtIwJMKQbgcM3MiI/GRDU8vkrn6C4Ij34lS9AcfYFt+lXeYgEzXHqW+fzvn3Yg+w5nWDHdKaQZ
	iUeqJ4ntTwxY4qLJdLEjJRMteqwgJ06j75ysSyrtslPrb+2d0a1Nvu21bq3SvHRV1slMEif/8J/
	UYAtu6AcXMLHcS6YbMKkUIO+MQKIVpQAUYW0aOf+4H
X-Received: by 2002:a17:90b:224b:b0:3ab:2c2b:1026 with SMTP id 98e67ed59e1d1-3adce07f8b3mr304724a91.34.1792709846211;
        Thu, 22 Oct 2026 15:57:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3adcddf13b1sm148219a91.5.2026.10.22.15.57.24
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2026 15:57:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f2373e9b4so32701785a.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792709844; x=1793314644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WigrYeX8rfIc0uBYkqlaE73MENE+ioOdixBQzIPPQ94=;
        b=VmYwkCdl4XKs+YUrmZi3jDmtRs9GLsZ9Vgmmi1WHqIvIMYsa9EER6eezdnZD6R8BW1
         zMvAVhUIQWedBT6ZEbKfrbJCuSXLtHZOSMZKhRLUEW5vH4+EjbsXNoJUFRojyCiOzFua
         avnIe7PXzPoRCdSitfknqPe4uGRdDc6FSdpKQ=
X-Received: by 2002:a05:620a:6082:b0:93e:e2ec:3bf with SMTP id af79cd13be357-93f6fa10572mr142967685a.78.1792709844017;
        Thu, 22 Oct 2026 15:57:24 -0700 (PDT)
X-Received: by 2002:a05:620a:6082:b0:93e:e2ec:3bf with SMTP id af79cd13be357-93f6fa10572mr142964485a.78.1792709843241;
        Thu, 22 Oct 2026 15:57:23 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c395025d0sm4501656d6.5.2026.10.22.15.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:57:22 -0700 (PDT)
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
Subject: [PATCH net 5/6 RESEND] net: dsa: b53: report link state through the PCS
Date: Thu, 22 Oct 2026 15:56:55 -0700
Message-ID: <20261022225656.1387306-6-florian.fainelli@broadcom.com>
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

Decode the Clause 22 BMSR and link partner word with the phylink helper.
This respects the negotiation mode, reports the partner advertisement,
and resolves Clause 37 pause from the configured advertisement instead
of unconditionally accepting the vendor status register's result.

Notify phylink through phylink_pcs_change() from the SerDes port interrupt,
using live PCS status rather than MAC link status, which can be overridden
by mac_link_up/down(). Remove the now unused MAC notification helper.

Enable PCS polling as a fallback for optional port interrupts and for
negotiation completion after the initial link-change interrupt.

Fixes: 79396934e289 ("net: dsa: b53: convert to phylink_pcs")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 12 ------
 drivers/net/dsa/b53/b53_priv.h   |  1 -
 drivers/net/dsa/b53/b53_serdes.c | 72 +++++++++++++++-----------------
 drivers/net/dsa/b53/b53_serdes.h |  5 +++
 drivers/net/dsa/b53/b53_srab.c   |  2 +-
 5 files changed, 40 insertions(+), 52 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 09de3520e71a..b04f9d5f0525 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1522,18 +1522,6 @@ static void b53_adjust_5325_mii(struct dsa_switch *ds, int port)
 	}
 }
 
-void b53_port_event(struct dsa_switch *ds, int port)
-{
-	struct b53_device *dev = ds->priv;
-	bool link;
-	u16 sts;
-
-	b53_read16(dev, B53_STAT_PAGE, B53_LINK_STAT, &sts);
-	link = !!(sts & BIT(port));
-	dsa_port_phylink_mac_change(ds, port, link);
-}
-EXPORT_SYMBOL(b53_port_event);
-
 static void b53_phylink_get_caps(struct dsa_switch *ds, int port,
 				 struct phylink_config *config)
 {
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index cebbebe4ae0f..6028440e1358 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -519,7 +519,6 @@ int b53_br_flags(struct dsa_switch *ds, int port,
 		 struct switchdev_brport_flags flags,
 		 struct netlink_ext_ack *extack);
 int b53_setup_devlink_resources(struct dsa_switch *ds);
-void b53_port_event(struct dsa_switch *ds, int port);
 int b53_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
 		       struct netlink_ext_ack *extack);
 int b53_vlan_add(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/b53/b53_serdes.c b/drivers/net/dsa/b53/b53_serdes.c
index fc20e211e67e..c7f3e131f2de 100644
--- a/drivers/net/dsa/b53/b53_serdes.c
+++ b/drivers/net/dsa/b53/b53_serdes.c
@@ -291,50 +291,44 @@ static void b53_serdes_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 static void b53_serdes_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 				 struct phylink_link_state *state)
 {
-	struct b53_device *dev = pcs_to_b53_pcs(pcs)->dev;
-	u8 lane = pcs_to_b53_pcs(pcs)->lane;
-	int dig, bmsr;
-
-	dig = b53_serdes_read(dev, lane, B53_SERDES_DIGITAL_STATUS,
-			      SERDES_DIGITAL_BLK);
-	if (dig < 0) {
-		state->link = false;
-		b53_serdes_error(dev, lane, dig);
-		return;
-	}
+	struct b53_pcs *priv = pcs_to_b53_pcs(pcs);
+	struct b53_device *dev = priv->dev;
+	u8 lane = priv->lane;
+	int bmsr, lpa;
 
 	bmsr = b53_serdes_read(dev, lane, B53_SERDES_MII_REG(MII_BMSR),
 			       SERDES_MII_BLK);
-	if (bmsr < 0) {
-		state->link = false;
-		b53_serdes_error(dev, lane, bmsr);
-		return;
-	}
+	if (bmsr < 0)
+		goto error;
 
-	switch ((dig >> SPEED_STATUS_SHIFT) & SPEED_STATUS_MASK) {
-	case SPEED_STATUS_10:
-		state->speed = SPEED_10;
-		break;
-	case SPEED_STATUS_100:
-		state->speed = SPEED_100;
-		break;
-	case SPEED_STATUS_1000:
-		state->speed = SPEED_1000;
-		break;
-	default:
-	case SPEED_STATUS_2500:
-		state->speed = SPEED_2500;
-		break;
-	}
+	lpa = b53_serdes_read(dev, lane, B53_SERDES_MII_REG(MII_LPA),
+			      SERDES_MII_BLK);
+	if (lpa < 0)
+		goto error;
+
+	phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr, lpa);
+	return;
+error:
+	state->link = false;
+	state->an_complete = false;
+	b53_serdes_error(dev, lane, bmsr < 0 ? bmsr : lpa);
+}
+
+void b53_serdes_link_change(struct b53_device *dev, int port)
+{
+	u8 lane = b53_serdes_map_lane(dev, port);
+	int dig;
 
-	state->duplex = dig & DUPLEX_STATUS ? DUPLEX_FULL : DUPLEX_HALF;
-	state->an_complete = !!(bmsr & BMSR_ANEGCOMPLETE);
-	state->link = !!(dig & LINK_STATUS);
-	if (dig & PAUSE_RESOLUTION_RX_SIDE)
-		state->pause |= MLO_PAUSE_RX;
-	if (dig & PAUSE_RESOLUTION_TX_SIDE)
-		state->pause |= MLO_PAUSE_TX;
+	if (lane >= B53_N_PCS || !dev->pcs[lane].dev)
+		return;
+
+	/* Use the live PCS status, not latched BMSR or MAC override status. */
+	dig = b53_serdes_read(dev, lane, B53_SERDES_DIGITAL_STATUS,
+			      SERDES_DIGITAL_BLK);
+	b53_serdes_error(dev, lane, dig);
+	phylink_pcs_change(&dev->pcs[lane].pcs, dig >= 0 && (dig & LINK_STATUS));
 }
+EXPORT_SYMBOL(b53_serdes_link_change);
 
 static int b53_serdes_enable(struct phylink_pcs *pcs)
 {
@@ -440,6 +434,8 @@ int b53_serdes_init(struct b53_device *dev, int port)
 	pcs->dev = dev;
 	pcs->lane = lane;
 	pcs->pcs.ops = &b53_pcs_ops;
+	/* Port interrupts are optional and may precede AN completion. */
+	pcs->pcs.poll = true;
 	__set_bit(PHY_INTERFACE_MODE_SGMII, pcs->pcs.supported_interfaces);
 	__set_bit(PHY_INTERFACE_MODE_1000BASEX, pcs->pcs.supported_interfaces);
 
diff --git a/drivers/net/dsa/b53/b53_serdes.h b/drivers/net/dsa/b53/b53_serdes.h
index 2c2aa5eaa985..4016b24bcda4 100644
--- a/drivers/net/dsa/b53/b53_serdes.h
+++ b/drivers/net/dsa/b53/b53_serdes.h
@@ -119,8 +119,13 @@ struct phylink_pcs *b53_serdes_phylink_mac_select_pcs(struct b53_device *dev,
 void b53_serdes_phylink_get_caps(struct b53_device *dev, int port,
 				 struct phylink_config *config);
 #if IS_ENABLED(CONFIG_B53_SERDES)
+void b53_serdes_link_change(struct b53_device *dev, int port);
 int b53_serdes_init(struct b53_device *dev, int port);
 #else
+static inline void b53_serdes_link_change(struct b53_device *dev, int port)
+{
+}
+
 static inline int b53_serdes_init(struct b53_device *dev, int port)
 {
 	return -ENODEV;
diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index 77e81e1a414a..56da3dbaf997 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -374,7 +374,7 @@ static irqreturn_t b53_srab_port_thread(int irq, void *dev_id)
 	struct b53_device *dev = port->dev;
 
 	if (port->mode == PHY_INTERFACE_MODE_SGMII)
-		b53_port_event(dev->ds, port->num);
+		b53_serdes_link_change(dev, port->num);
 
 	return IRQ_HANDLED;
 }
-- 
2.53.0

