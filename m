Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7C842B30D
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182736; cv=none; b=WlmHqm7UFeig/XophuB9T61xzWAThMTU048FC2KfTu1X+eSHVhbZVsU/Rcrkm3NdMnDeC7UcB2ZbTnQPD0fSJWNaGXPL4yJUMROGyus00flbHdP7t5CxF+ePb/uB0fAQn/CrIDpbvnpzFIxUObkK/e1JAXN7A1g6lgDxJ4B0VBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182736; c=relaxed/simple;
	bh=P/UMv5H6zbtVnNRcI0dxKxNZpVVHnXAJ61vPuF1fZAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iHtKrnwYgDcUYn839npuwMqicLIwkJUVr9SJxqygTt7b0hxujtiuAlWb3igt3LrbQ1eN7vesO5AARvWJme0f+NBjmMTzJokiF/1pmf9G9BLSVsxjfRXAK6UG7DZ2EqXSucb7YLKRYovOKQ0anXx7chXT2uTUOgGnvXizFonFSdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RnbH4I39; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RnbH4I39"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8D9A64E41488;
	Mon, 31 Aug 2026 13:25:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 61F2660231;
	Mon, 31 Aug 2026 13:25:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CF2E11C783F8;
	Mon, 31 Aug 2026 15:25:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788182732; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1MxpOXIUTCRRJoPPX0UBHlVCsOVhuvqrmli9AWb4L64=;
	b=RnbH4I39/xSljrZxoGq6o/9VemRF3WRMHUwsb/kKkRc+F+NJVrDwiPa6DUvFWI235RRY1+
	4lcUUQtwIcik8QAKcXJkw9Ak1wulfVhx+OFmmILoqXIvNuI5neqHMELZ4yDKGIKkoAa4Pr
	Afs7aP9vzKUUxHEXQEV4b70852emQo9VwA8hDYAWJJstMGS0DhLe0fNpjATqgT2zAItqVV
	vsPwYEraNIn/O1IC9CfoqI/Rg26Z4rrHEd4nqEYugNVs/En0ziC7tEfyjsK8z30eKwrJaR
	PK4OQDAcfTgnvIEkw1UFr2mreRWfI87OrDTpsp+OcXM3FivvRzB7ymFnvxtpYA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 31 Aug 2026 15:25:24 +0200
Subject: [PATCH net-next 02/10] net: dsa: microchip: add the number of
 periodic signals to chip infos
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ksz-perout-v1-2-14202db763b3@bootlin.com>
References: <20260831-ksz-perout-v1-0-14202db763b3@bootlin.com>
In-Reply-To: <20260831-ksz-perout-v1-0-14202db763b3@bootlin.com>
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

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 1 +
 drivers/net/dsa/microchip/ksz_common.h | 1 +
 drivers/net/dsa/microchip/ksz_ptp.c    | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 55d1e3e3c529..194c88cdd00b 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1195,6 +1195,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.wr_table = &ksz8563_register_set,
 		.rd_table = &ksz8563_register_set,
 		.n_pins = 2,
+		.n_per_out = 3,
 	},
 
 	[KSZ8795] = {
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

