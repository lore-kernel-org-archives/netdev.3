Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4666B3F6C24
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147664; cv=none; b=AC7jWx/1wk6gsWvB9YwVDTdNLVwxEDqctYE/orJE8nVNwTPxm0aIC4wI39LSxaRX1rNbYpc8ljgL1jZqmV8vziRYLTNH7QsqN0ZQjYi3jn/cggjxHb7yYilBKu+wnKa4Aqq98FvnPKpJwdqjEWsmTkOalpN5UJ39DhpGsclsNIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147664; c=relaxed/simple;
	bh=BIDRldgZwguuxTScvq7SIry4n11WrGF0Y9q5s1x/4pc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YN2pxTazuZpVkWQc8Z79TKbAvAsPoWBSEldZKwRiZoniC7s6pRQykyOvoVt0in44X2CL+Nr70z582bfXUhHhbbYRtLn+Oblr1SfSX3aNswGGafg3EOp980oVs0eUkS6AvQrQ9Eln0BTlGdIBtLenlVvgWNOHwIvAKq22WIsr/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V42x8F2I; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V42x8F2I"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A0F621A128E;
	Mon, 27 Jul 2026 10:20:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 74986601BE;
	Mon, 27 Jul 2026 10:20:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 016D211C131B5;
	Mon, 27 Jul 2026 12:20:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785147658; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ih3eQKvCXt+AE7A7jpmRaaKpONc/RrDX6tZZblgWFo4=;
	b=V42x8F2IBJwM5gHxDnr7YFECEDeUagYxbSWWmTmIkSrEhxNhNnkV3ceB0q4JoGEYXnu5+r
	JUCMXSo5P21KfzqlgHFgWIL/XAArMnRG9CVxNnEAE3yywsffhrZtK4ronfv/73vSqwzENG
	slQAKqO8Yz/3RETQBbV/Uq+BHytE46ACMc5Z8J8aDCeaJQl/yz8sFY1vPSDuqIk32hIHbu
	HiUEe8RLhd536SXd77+zCVvmJE5wUpBTD4Srd8L02w+OT529M9latpLdIawKEJj/X9IfZG
	xKxVmeYA/jgyWZAIvIrqKZPI7hmLz2bS1WujLC+kgWza1egq6KVCBML3HMYHuw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 27 Jul 2026 12:20:44 +0200
Subject: [PATCH net-next v3 02/10] net: dsa: microchip: split
 ksz8_config_cpu_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-ksz-new-ptp-v3-2-caba39e680e3@bootlin.com>
References: <20260727-ksz-new-ptp-v3-0-caba39e680e3@bootlin.com>
In-Reply-To: <20260727-ksz-new-ptp-v3-0-caba39e680e3@bootlin.com>
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
2.55.0

