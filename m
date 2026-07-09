Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8643D9025
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 06:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579372; cv=none; b=bjpo52p72xDLirHDmTGp+uiRd0djLu0DlrKdf7GwMcRBmlgKTt9h6pGVeEbUJYkq0MEQxhUkOyA+GbU4T4RyBQs1RwfC7AFHfpy9z47QG9tdHe4KrJjKlfxFndXAaCBAuNPILPSRFy1fbhBPWsAMVUSBYj6dwqkLZgYQ6VSLQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579372; c=relaxed/simple;
	bh=P5TH9CzfbS5dkSpvlLQ1d15P7EmXyIYvCH7xhBfxBOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NDHHL7OtV2l6CygWwHlSN1cdnXEaeXqnLuRW3XK86TfjVZa5ee2O+9ri0im1bEd4WQsFosNzNYgrPZ3+ltQqvXm1i57znruaI92kdeeISXwkI6FtJKI3WNB6aviaU7a2Mml+W03K+/KCPi3N+w4/9EH+wVXrtDynPcCR7c1qrHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ixW/GtEi; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ixW/GtEi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EED8C4E40D0D;
	Thu,  9 Jul 2026 06:42:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C3A475FF03;
	Thu,  9 Jul 2026 06:42:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D2F411BC2146;
	Thu,  9 Jul 2026 08:42:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783579357; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ix/aq7vTMxcCHYMxpuabfOhDU7m0NOPjq6CDnvxJ/Lc=;
	b=ixW/GtEioLptvQY2dPVrXXO2iqew3PnlBzeysnTSJwgEgZBX6u+Sb8JfYtzdcqtT3Nqn/N
	p0fGKIf3xrEgGlWhVPFR2xv8bsChznEZeJ2QE5GviezOIvjh+1qebgKLVuE9GU1rpkfQFJ
	BAvoXFhbCqM78jWyI7wh+kbDXdLfa8GTOj7EgVI8jw2fAzhuO/VxYQE4SEsKXja3T0noDO
	VE0rYZ0NmG8NBj+YXT18uqwyLJzHdT6KH0Qt1KX0oafzmPTCxJxpgjAQ52jhO9+vbaiw+o
	ImLsRhjzw/ymQdnPlgygMEVOPyifddC3PiioU+BBlqEbUdkQ/ZU5n6oF/juwvQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 09 Jul 2026 08:42:28 +0200
Subject: [PATCH net-next 02/10] net: dsa: microchip: split
 ksz8_config_cpu_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-ksz-new-ptp-v1-2-344f02fe739e@bootlin.com>
References: <20260709-ksz-new-ptp-v1-0-344f02fe739e@bootlin.com>
In-Reply-To: <20260709-ksz-new-ptp-v1-0-344f02fe739e@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

ksz8_config_cpu_port() is only called twice, once by ksz8_setup() and
once by ksz8463_setup(). It contains a ksz8463 branch that could be
avoided in the ksz8_setup() case and a ksz87xx/ksz88xx branches that
could be avoided in ksz8463_setup() case.

Create ksz8463_config_cpu_port() that only handles the ksz8463 case and
remove the ksz8463 specificities from the common ksz8_config_cpu_port().

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c | 73 +++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 5ed63f425013..3bbca6f9cfc5 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2029,6 +2029,50 @@ static void ksz88x3_config_rmii_clk(struct ksz_device *dev)
 		KSZ88X3_PORT3_RMII_CLK_INTERNAL, rmii_clk_internal);
 }
 
+static void ksz8463_config_cpu_port(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+	struct ksz_port *p;
+	u8 fiber_ports = 0;
+	const u32 *masks;
+	const u16 *regs;
+	int i;
+
+	masks = dev->info->masks;
+	regs = dev->info->regs;
+
+	ksz_cfg(dev, regs[S_TAIL_TAG_CTRL], masks[SW_TAIL_TAG_ENABLE], true);
+
+	ksz8_port_setup(dev, dev->cpu_port, true);
+
+	for (i = 0; i < dev->phy_port_cnt; i++)
+		ksz_port_stp_state_set(ds, i, BR_STATE_DISABLED);
+
+	for (i = 0; i < dev->phy_port_cnt; i++) {
+		p = &dev->ports[i];
+		ksz_port_cfg(dev, i, regs[P_STP_CTRL], PORT_FORCE_FLOW_CTRL,
+			     p->fiber);
+		if (p->fiber)
+			fiber_ports |= (1 << i);
+	}
+
+	/* Setup fiber ports. */
+	if (fiber_ports) {
+		fiber_ports &= 3;
+		regmap_update_bits(ksz_regmap_16(dev), KSZ8463_REG_CFG_CTRL,
+				   fiber_ports << PORT_COPPER_MODE_S,
+				   0);
+		regmap_update_bits(ksz_regmap_16(dev), KSZ8463_REG_DSP_CTRL_6,
+				   COPPER_RECEIVE_ADJUSTMENT, 0);
+	}
+
+	/* Turn off PTP function as the switch enables it by default */
+	regmap_update_bits(ksz_regmap_16(dev), KSZ8463_PTP_MSG_CONF1,
+			   PTP_ENABLE, 0);
+	regmap_update_bits(ksz_regmap_16(dev), KSZ8463_PTP_CLK_CTRL,
+			   PTP_CLK_ENABLE, 0);
+}
+
 static void ksz8_config_cpu_port(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
@@ -2036,7 +2080,6 @@ static void ksz8_config_cpu_port(struct dsa_switch *ds)
 	const u32 *masks;
 	const u16 *regs;
 	u8 remote;
-	u8 fiber_ports = 0;
 	int i;
 
 	masks = dev->info->masks;
@@ -2067,32 +2110,6 @@ static void ksz8_config_cpu_port(struct dsa_switch *ds)
 		else
 			ksz_port_cfg(dev, i, regs[P_STP_CTRL],
 				     PORT_FORCE_FLOW_CTRL, false);
-		if (p->fiber)
-			fiber_ports |= (1 << i);
-	}
-	if (ksz_is_ksz8463(dev)) {
-		/* Setup fiber ports. */
-		if (fiber_ports) {
-			fiber_ports &= 3;
-			regmap_update_bits(ksz_regmap_16(dev),
-					   KSZ8463_REG_CFG_CTRL,
-					   fiber_ports << PORT_COPPER_MODE_S,
-					   0);
-			regmap_update_bits(ksz_regmap_16(dev),
-					   KSZ8463_REG_DSP_CTRL_6,
-					   COPPER_RECEIVE_ADJUSTMENT, 0);
-		}
-
-		/* Turn off PTP function as the switch's proprietary way of
-		 * handling timestamp is not supported in current Linux PTP
-		 * stack implementation.
-		 */
-		regmap_update_bits(ksz_regmap_16(dev),
-				   KSZ8463_PTP_MSG_CONF1,
-				   PTP_ENABLE, 0);
-		regmap_update_bits(ksz_regmap_16(dev),
-				   KSZ8463_PTP_CLK_CTRL,
-				   PTP_CLK_ENABLE, 0);
 	}
 }
 
@@ -2332,7 +2349,7 @@ static int ksz8463_setup(struct dsa_switch *ds)
 	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
 			   storm_mask, storm_rate);
 
-	ksz8_config_cpu_port(ds);
+	ksz8463_config_cpu_port(ds);
 
 	ksz8_enable_stp_addr(dev);
 

-- 
2.54.0

