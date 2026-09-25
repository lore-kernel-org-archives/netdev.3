Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0849A3A5
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336348; cv=none; b=TyhBb9XlQUrKdcICPkxaijtIfkg+Mc6QarYeBEZ2GKoS1+moAL4xzqUWDESbxio0HJJ7zo6/mhKRTxgtqjabb0uAP5v+zOAVQ9I+fNeqjonsihvpCVh8nnnc3fVG1Al5x4UsqNV/8CiM+IyOOTHCj2EgHq4k3MwkpLQ9rJrUsuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336348; c=relaxed/simple;
	bh=T7UE0gnImgbOuALNSrfHOI4vX5QfvDPOJs4k+ER11yY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iwSykS5ritn58C9MOCFZfDiod7sWB9T/DNnpmjrtYPOmA5Xit9c9P54eL2tdkqMbnUu2STCGvXNWwiujWxiR4F0EokA9moFs7i57TmMzppK8qg0HSYqBOrp89XSzyILFEUTZkPk+bymDv6dhCiK30sJSHnAeMGnK4paENZqMqjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UMO9/xli; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UMO9/xli"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BE7481A1020;
	Fri, 25 Sep 2026 11:39:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 92DE66073B;
	Fri, 25 Sep 2026 11:39:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 65E19103290D4;
	Fri, 25 Sep 2026 13:38:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790336340; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+NF8RyXSWFHXeDylfNL1aUVQjHWI8FbVDK+n17cU0to=;
	b=UMO9/xlijFfdqZUC+5BQtQWyxTdLGiTVhCoc+zRzfvh2WjOOaOOSY6D4NbPXxgz6UjtEuV
	IrYvRrCxykq1JuIIw5RcetfmLx1AkzwKWvWe6HNyxraeGCu5hUYw822uf48xPo6HY5NcOG
	eEqDRp32IWjksuwzi5SbB73IjLP6cW4mWIqcy8kAQj5ziZ+Rujva9bgABKg6holmQmYwTC
	XbnPIupG9/39tR/UKHAYl4UJvWdKwUpZzoBU3QgxVUUTDDAxYe5jHsSdbs+erozNsVYxKr
	AKg749DxmVbxc4s5E2mfj+C5mEcjt7MwZI2fAAJkTCMBtMqr7T+0s+nTBCQIEA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 25 Sep 2026 13:38:49 +0200
Subject: [PATCH net-next v4 03/11] net: dsa: microchip: add the number of
 periodic signals to chip infos
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-ksz-perout-v4-3-d675bd21ce49@bootlin.com>
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
index ac9a10a91d79..ea6db85e7e2b 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1209,6 +1209,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.wr_table = &ksz8563_register_set,
 		.rd_table = &ksz8563_register_set,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[KSZ8795] = {
@@ -1445,6 +1446,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.wr_table = &ksz9477_register_set,
 		.rd_table = &ksz9477_register_set,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[KSZ9896] = {
@@ -1611,6 +1613,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.gbit_capable = {true, true, true},
 		.ptp_capable = true,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[KSZ8567] = {
@@ -1649,6 +1652,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   true, true},
 		.ptp_capable = true,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[KSZ9567] = {
@@ -1684,6 +1688,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.gbit_capable	= {true, true, true, true, true, true, true},
 		.ptp_capable = true,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[LAN9370] = {
@@ -1716,6 +1721,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy = {true, true, true, true, false},
 		.ptp_capable = true,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[LAN9371] = {
@@ -1748,6 +1754,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy = {true, true, true, true, false, false},
 		.ptp_capable = true,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[LAN9372] = {
@@ -1784,6 +1791,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   false, false, true, true},
 		.ptp_capable = true,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[LAN9373] = {
@@ -1820,6 +1828,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   false, false, true, true},
 		.ptp_capable = true,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[LAN9374] = {
@@ -1856,6 +1865,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   false, false, true, true},
 		.ptp_capable = true,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[LAN9646] = {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 9b911f9aafd9..f1c0e89e13c1 100644
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
index 33416e59edc7..84c799959aaa 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1054,7 +1054,7 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
 	ptp_data->caps.enable		= ksz_ptp_enable;
 	ptp_data->caps.verify		= ksz_ptp_verify_pin;
 	ptp_data->caps.n_pins		= dev->info->n_pins;
-	ptp_data->caps.n_per_out	= 3;
+	ptp_data->caps.n_per_out	= dev->info->n_per_out;
 
 	ret = ksz_ptp_start_clock(dev);
 	if (ret)

-- 
2.55.0

