Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD7438F926
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343067; cv=none; b=pv8GqXkR9ka0EZnyBTuAyRUn65QErNWg7uiiUnmZ2rJTb648WLRwz2nWTjSUTudoDX3bRQFcTAo4mJb7p/baM98662WG4DTjfd4KMrY86sv5mFqyKoe0PggmToyGrKaJXJyl297g4rk/QcE5XipY+9GTISeK+TptgC+XewdWq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343067; c=relaxed/simple;
	bh=I28qNWvUt4LC9kmZmythP4voD2ADlBgQIZ3P3FwpCqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pm6DNfJx6N5HonR/V1QHd8gXr+XomTYvydzW1e4Phewxk6XpMGosSk+Cf2jBW6kGOwngbODcoOaVGrbdwMIri3PwR2d9mglos5cjQVug0FyoWIgdEPmRrG2Fa3qbfHe55uE6uaL0n8PMro1aGUk7ylcGsqNX7TzzskMLNTTUnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m4dqfFoB; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m4dqfFoB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4BEE44E414C8;
	Wed,  2 Sep 2026 09:57:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 20B136053C;
	Wed,  2 Sep 2026 09:57:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CABF111C792F3;
	Wed,  2 Sep 2026 11:57:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788343062; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZR5x64Lg3Tk7Sqz9cGWUyByPFFb6+HVUsdxJ3gbitLM=;
	b=m4dqfFoBaKi5navwViTMIVt0x6YDw25siYSElUyQ7Em82JfbIKHBgUMzyTBC09amCKsuj3
	9GtlN48fMjhSyeK68rVcKu3T5Gzt+QkcSQDCYUTjAvvQtuA2P4Ghjk57uOyi4yPeG5KPfH
	fx6F9ttobbVb3PQBKoY6ejMPqaEtWCX4lXWjry7UZmENQkQ4TOgteNs0y8KFG6rKFxAlGk
	882hI8VzWaQ7cdcHmwojZMH0O+LQ3eUO2e0KslKkB6qEcq/cmx6k7GI1D1cj8SHpedZe28
	/vhBtU8EmQApB8wL2/7dEIbg+Bd6U8RNlR99SkVjWRQsJTlchLieTMo+Zw5mqA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Wed, 02 Sep 2026 11:57:31 +0200
Subject: [PATCH net-next v2 01/10] net: dsa: microchip: add the number of
 pins to chip infos
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ksz-perout-v2-1-6f277fcc9e68@bootlin.com>
References: <20260902-ksz-perout-v2-0-6f277fcc9e68@bootlin.com>
In-Reply-To: <20260902-ksz-perout-v2-0-6f277fcc9e68@bootlin.com>
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
index 1a9d6f83a023..d01fba253af5 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1194,6 +1194,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.ptp_capable = true,
 		.wr_table = &ksz8563_register_set,
 		.rd_table = &ksz8563_register_set,
+		.n_pins = 2,
 	},
 
 	[KSZ8795] = {
@@ -1414,6 +1415,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.sgmii_port = 7,
 		.wr_table = &ksz9477_register_set,
 		.rd_table = &ksz9477_register_set,
+		.n_pins = 2,
 	},
 
 	[KSZ9896] = {
@@ -1544,6 +1546,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy = {true, true, false},
 		.gbit_capable = {true, true, true},
 		.ptp_capable = true,
+		.n_pins = 2,
 	},
 
 	[KSZ8567] = {
@@ -1581,6 +1584,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.gbit_capable	= {false, false, false, false, false,
 				   true, true},
 		.ptp_capable = true,
+		.n_pins = 2,
 	},
 
 	[KSZ9567] = {
@@ -1615,6 +1619,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   true, false, false},
 		.gbit_capable	= {true, true, true, true, true, true, true},
 		.ptp_capable = true,
+		.n_pins = 2,
 	},
 
 	[LAN9370] = {
@@ -1646,6 +1651,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.supports_rgmii = {false, false, false, false, true},
 		.internal_phy = {true, true, true, true, false},
 		.ptp_capable = true,
+		.n_pins = 2,
 	},
 
 	[LAN9371] = {
@@ -1677,6 +1683,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.supports_rgmii = {false, false, false, false, true, true},
 		.internal_phy = {true, true, true, true, false, false},
 		.ptp_capable = true,
+		.n_pins = 2,
 	},
 
 	[LAN9372] = {
@@ -1712,6 +1719,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy	= {true, true, true, true,
 				   false, false, true, true},
 		.ptp_capable = true,
+		.n_pins = 2,
 	},
 
 	[LAN9373] = {
@@ -1747,6 +1755,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy	= {true, true, true, false,
 				   false, false, true, true},
 		.ptp_capable = true,
+		.n_pins = 2,
 	},
 
 	[LAN9374] = {
@@ -1782,6 +1791,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy	= {true, true, true, true,
 				   false, false, true, true},
 		.ptp_capable = true,
+		.n_pins = 2,
 	},
 
 	[LAN9646] = {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index cbe98494578c..c678fc6597dc 100644
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
index 39cc70d65900..c92936bf78d3 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1050,14 +1050,14 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
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

