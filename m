Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8992549B1F6
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336343; cv=none; b=NEvxc84hDUUR3xiaqiqdn84kl71bYYoWOcIAau1jWr5um+vbqCI7BMnt0tffo/tTq5GNcix1lmwMOri6eO/3nx+NGjC6GB7u4050dPofrqNy/susqw1qkZOStKIeAwfrLTGKYRHbMUe4gU/NRR/eOytxJ+/pfzaK92YUQEhizrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336343; c=relaxed/simple;
	bh=JzjfA9Eb7py/ey7RpiWHN2hF14RXEbPHd66kp7u+HWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vs9Eku/G39g065SHjesHkFTB7kkAXyQ19LFa3o8yBrK+oc5NQCOPuwTBUyD5Qv4nr6lHV9ExAofxGGnr0k96yVq15sln9h3QfqK7bJpphl42Ci3k2re7jtgInEvJQQfiLuSN7Tm0X716hbKBL5A67Q2YUae7t0Ar/r3uywRTOi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=r2UzJwKN; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="r2UzJwKN"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2F6FE1A101C
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:39:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 043266073B;
	Fri, 25 Sep 2026 11:39:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3DE33103295BD;
	Fri, 25 Sep 2026 13:38:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790336339; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=y7Pag5diP3dKywVjmr56QgZ4XxqjFLvdFfdgGvGh5mU=;
	b=r2UzJwKNNebfSAJhwIuaFaeI8J22WjzgNjjsWeAn7LDTSTljRWh1/R76BKdWjVeVBs8MIF
	ktOTqPf5NLIh/Fa+XWSkaIy8PCVH2CwmZ9jbj/zDZDwF6oHywPxtfjaBFc1c7SXj+TAg0Y
	XL/x28otVShKsS2Mv7oc5zqP6N7lmPhDhuFAZhhpQlfKTo1gykUpE+/9/vOK4iYqzQF7aK
	t3wezZV6M2qkXYHV3dpel9JlxSlyb3EL5y2rZs0VA+HRQ+ISFh5fuovyBU0eJr661pFvtz
	RmOrOGeQrgVhLFqXwo+EELaywWcndkvkBRBzTFvdXUWJkj07S2+yJjzdeFMdAg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 25 Sep 2026 13:38:48 +0200
Subject: [PATCH net-next v4 02/11] net: dsa: microchip: add the number of
 pins to chip infos
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-ksz-perout-v4-2-d675bd21ce49@bootlin.com>
References: <20260925-ksz-perout-v4-0-d675bd21ce49@bootlin.com>
In-Reply-To: <20260925-ksz-perout-v4-0-d675bd21ce49@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The number of periodic output pins available is hardcoded to 2 while
KSZ8463 has 12 pins that can be used as periodic outputs.

Add an n_pin attribute to the struct ksz_chip_data to make this setting
configurable.
Set it to 2 for all the PTP-capable switches.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 10 ++++++++++
 drivers/net/dsa/microchip/ksz_common.h |  1 +
 drivers/net/dsa/microchip/ksz_ptp.c    |  4 ++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index f1b53439ff58..ac9a10a91d79 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1208,6 +1208,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.ptp_capable = true,
 		.wr_table = &ksz8563_register_set,
 		.rd_table = &ksz8563_register_set,
+		.n_pins = 2,
 	},
 
 	[KSZ8795] = {
@@ -1443,6 +1444,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.sgmii_port = 7,
 		.wr_table = &ksz9477_register_set,
 		.rd_table = &ksz9477_register_set,
+		.n_pins = 2,
 	},
 
 	[KSZ9896] = {
@@ -1608,6 +1610,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy = {true, true, false},
 		.gbit_capable = {true, true, true},
 		.ptp_capable = true,
+		.n_pins = 2,
 	},
 
 	[KSZ8567] = {
@@ -1645,6 +1648,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.gbit_capable	= {false, false, false, false, false,
 				   true, true},
 		.ptp_capable = true,
+		.n_pins = 2,
 	},
 
 	[KSZ9567] = {
@@ -1679,6 +1683,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   true, false, false},
 		.gbit_capable	= {true, true, true, true, true, true, true},
 		.ptp_capable = true,
+		.n_pins = 2,
 	},
 
 	[LAN9370] = {
@@ -1710,6 +1715,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.supports_rgmii = {false, false, false, false, true},
 		.internal_phy = {true, true, true, true, false},
 		.ptp_capable = true,
+		.n_pins = 2,
 	},
 
 	[LAN9371] = {
@@ -1741,6 +1747,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.supports_rgmii = {false, false, false, false, true, true},
 		.internal_phy = {true, true, true, true, false, false},
 		.ptp_capable = true,
+		.n_pins = 2,
 	},
 
 	[LAN9372] = {
@@ -1776,6 +1783,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy	= {true, true, true, true,
 				   false, false, true, true},
 		.ptp_capable = true,
+		.n_pins = 2,
 	},
 
 	[LAN9373] = {
@@ -1811,6 +1819,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy	= {true, true, true, false,
 				   false, false, true, true},
 		.ptp_capable = true,
+		.n_pins = 2,
 	},
 
 	[LAN9374] = {
@@ -1846,6 +1855,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy	= {true, true, true, true,
 				   false, false, true, true},
 		.ptp_capable = true,
+		.n_pins = 2,
 	},
 
 	[LAN9646] = {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 091cfbdc486f..9b911f9aafd9 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -139,6 +139,7 @@ struct ksz_chip_data {
 	u8 sgmii_port;
 	const struct regmap_access_table *wr_table;
 	const struct regmap_access_table *rd_table;
+	const u8 n_pins;
 };
 
 struct ksz_irq {
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 47cf397481d5..33416e59edc7 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1053,14 +1053,14 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
 	ptp_data->caps.do_aux_work	= ksz_ptp_do_aux_work;
 	ptp_data->caps.enable		= ksz_ptp_enable;
 	ptp_data->caps.verify		= ksz_ptp_verify_pin;
-	ptp_data->caps.n_pins		= KSZ_PTP_N_GPIO;
+	ptp_data->caps.n_pins		= dev->info->n_pins;
 	ptp_data->caps.n_per_out	= 3;
 
 	ret = ksz_ptp_start_clock(dev);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < KSZ_PTP_N_GPIO; i++) {
+	for (i = 0; i < dev->info->n_pins; i++) {
 		struct ptp_pin_desc *ptp_pin = &ptp_data->pin_config[i];
 
 		snprintf(ptp_pin->name,

-- 
2.55.0

