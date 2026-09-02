Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B042FCAC
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343069; cv=none; b=RIG+ckJH48wDiUgLBvWMuiduC7FSh5xSZwyU7fDOWGl7BMylqoXMJ+IJDjLmzmztZ/thTJ9TK0oPc9Y2McGM7gokZc4/sl7Y8ukgE1jwQzpUPwOcBnowigZpbHNYCzI5LKYoLLf81UY5pN2PID41hmorFh1ibO7+F7oMelH8FbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343069; c=relaxed/simple;
	bh=wCstbV9bNtWGDbgW8FKQ9+urva+r4J4zQUILUT5ok8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pF6S1M6ASBYOP6JioLSkBzXebB+4BJIWx9qqPyYscJg5GiNTnh9qpGaMKoXIrREWHCIFErRIRaUuw41JhIY2zztHgQlfNKnGQcm22BswBizeUx4DiH03s8zLL2rS6L14esUTLvSPZzmBbd18RL3TqjdE4DTr1hpVY+s2A0RI6V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1vqY+pgY; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1vqY+pgY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7BD201A195D;
	Wed,  2 Sep 2026 09:57:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4F6E76053C;
	Wed,  2 Sep 2026 09:57:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 972D611C79321;
	Wed,  2 Sep 2026 11:57:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788343064; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BlT4DlPDgE82qA3Y46UcHC0kXIZUrf5Dya5wq4mWlu8=;
	b=1vqY+pgYs9WMcy7HdEVlKB7LoCtsYChJ85A0+/sp922fVp9I8+PYj97t87qHmnX2F4E3WA
	LylUQIwCjjnWznWHAfSLdz6xJExpF4wdGKyf8R9s9Bt8sZyQ0yWnJ9t3muDfoaErmzBlqm
	EGOwpjEHVKgcLg26xwm6ZMqOJvacXPNjVBniEZvAfgglLIjv7nbCNzcyYvucB+FIEAbJmk
	XRDwv3G27RpUzzKN0DD4Gaoi0C8nZNgm1xpX3ecYD94RbgR18wZ0KoAPIual2KaczuUrxy
	fleZvbA2ZDyuyyv8KlYUgka4LJdjFMjS7a6BdunUNhpmbf/0DRe+reCeVxRhIw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Wed, 02 Sep 2026 11:57:32 +0200
Subject: [PATCH net-next v2 02/10] net: dsa: microchip: add the number of
 periodic signals to chip infos
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ksz-perout-v2-2-6f277fcc9e68@bootlin.com>
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

The number of periodic signals available is hardcoded to 3 while
KSZ8463 can produce 12 different periodic signals.

Add an n_per_out attribute to the struct ksz_chip_data to make this
setting configurable.
Set it to 3 for all the PTP-capable switches.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 10 ++++++++++
 drivers/net/dsa/microchip/ksz_common.h |  1 +
 drivers/net/dsa/microchip/ksz_ptp.c    |  2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index d01fba253af5..041bb4f96365 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1195,6 +1195,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.wr_table = &ksz8563_register_set,
 		.rd_table = &ksz8563_register_set,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[KSZ8795] = {
@@ -1416,6 +1417,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.wr_table = &ksz9477_register_set,
 		.rd_table = &ksz9477_register_set,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[KSZ9896] = {
@@ -1547,6 +1549,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.gbit_capable = {true, true, true},
 		.ptp_capable = true,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[KSZ8567] = {
@@ -1585,6 +1588,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   true, true},
 		.ptp_capable = true,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[KSZ9567] = {
@@ -1620,6 +1624,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.gbit_capable	= {true, true, true, true, true, true, true},
 		.ptp_capable = true,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[LAN9370] = {
@@ -1652,6 +1657,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy = {true, true, true, true, false},
 		.ptp_capable = true,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[LAN9371] = {
@@ -1684,6 +1690,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy = {true, true, true, true, false, false},
 		.ptp_capable = true,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[LAN9372] = {
@@ -1720,6 +1727,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   false, false, true, true},
 		.ptp_capable = true,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[LAN9373] = {
@@ -1756,6 +1764,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   false, false, true, true},
 		.ptp_capable = true,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[LAN9374] = {
@@ -1792,6 +1801,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   false, false, true, true},
 		.ptp_capable = true,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[LAN9646] = {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index c678fc6597dc..1155b39350c2 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -140,6 +140,7 @@ struct ksz_chip_data {
 	const struct regmap_access_table *wr_table;
 	const struct regmap_access_table *rd_table;
 	const u8 n_pins;
+	const u8 n_per_out;
 };
 
 struct ksz_irq {
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index c92936bf78d3..f80015250e5a 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1051,7 +1051,7 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
 	ptp_data->caps.enable		= ksz_ptp_enable;
 	ptp_data->caps.verify		= ksz_ptp_verify_pin;
 	ptp_data->caps.n_pins		= dev->info->n_pins;
-	ptp_data->caps.n_per_out	= 3;
+	ptp_data->caps.n_per_out	= dev->info->n_per_out;
 
 	ret = ksz_ptp_start_clock(dev);
 	if (ret)

-- 
2.55.0

