Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A0395AE4;
	Tue,  8 Sep 2026 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852481; cv=none; b=GSAqrNhd+beO/vLjLn1cVvVeNzSwq3daOgv56eXe1EDicxqefsnEbB5mFsjwVmWDNbIUYP1b+pSLTGci60UAv+tN3/vq0q84WAww8CW8OQnAdnIaB4j20WLQ8SVdPywqlDUHyzdBB2gUte3vmWTiz6gJ43BmRubQhGB/pkYdDrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852481; c=relaxed/simple;
	bh=wCstbV9bNtWGDbgW8FKQ9+urva+r4J4zQUILUT5ok8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kletaRJgVovSYiYAIY3WR/96tKo6aE1vPzkaXfgpTd2H7rDCT3kwlyWp+76lH/6WVQ80cRX08SFqAsTVKuud4OpPFwnxs4hWg9L6FOBXsiDydYtbKiWN0mRqV5fobsCEt0AiECW9dot2gdre0yULwLNqts52w/38BqTp3szfqIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I7sBqRM0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I7sBqRM0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8CCA61A1A53;
	Tue,  8 Sep 2026 07:27:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 61041603C4;
	Tue,  8 Sep 2026 07:27:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CBF3511C7AF2B;
	Tue,  8 Sep 2026 09:27:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788852470; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BlT4DlPDgE82qA3Y46UcHC0kXIZUrf5Dya5wq4mWlu8=;
	b=I7sBqRM0zx1AjCjDPZcmB37jd7aSwveYe09mdN7mwzVPE4xVthohNrG92Ff6qPdjIK52mg
	xrz0oJ1jPGrd7ODHio5M/lYUOxjw8q4EHSnlWeXIGIetZrsaGeRg4QcGBqXWBk9H7sFWZN
	AF6Dmp4ZHzaesxNE2jD8LBprJDvRI5OxmU8sKxyG8ffuyzxy5aLCUbOcaGweJCsvrU/jhQ
	EF7CjxnySU+7As8y4n/b//VBvzZHBZqZOzAqaGSVEnozW/OV5IWp7UHQP9yVqYCpduEZO6
	Ie3Mx0uoKTueV/sBP4Ud7kvmhv0sJzMKtlkzSWVmLFDUWqaAuJbZ9ae3Na45PQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 08 Sep 2026 09:27:42 +0200
Subject: [PATCH net-next v3 02/10] net: dsa: microchip: add the number of
 periodic signals to chip infos
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ksz-perout-v3-2-6722a3f1ca75@bootlin.com>
References: <20260908-ksz-perout-v3-0-6722a3f1ca75@bootlin.com>
In-Reply-To: <20260908-ksz-perout-v3-0-6722a3f1ca75@bootlin.com>
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

