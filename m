Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F12E42AFA9
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182736; cv=none; b=WOmUwRh816F1cVtCI/fjYrklavRQUimvedZ6/g3OqfWGuzhfmYlXjwABd9hlrhv0GieM4tlsZKzijQCkYmjA0F2yM+teqKIvtNBu19W9PNNNq1AnZjdJCpoP2B8gylXCT3zNHE3KK7nFSp3mS25xLHImTSwPUn/dXq2GzBaErdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182736; c=relaxed/simple;
	bh=d04wpqsohMxtT46GB5OwdPPMJTzhM7T/Scb1AeqpBKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AlDvSD/lvt3l87D40JYXOkBD9fZzuG5MDKUEzl4qrXhwG+7fkqIj7q1STq7+55FfxANr520MPOOaf9lRuV0rn5E4AHVjconHqQAKziHGfXWkgQnjdcfGO8I8NIsGRExUfLYhxaCxaM/JU+0Hrl9u0cGrk2DCGkRux2vKUjquiIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FfNhmqkV; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FfNhmqkV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BF1491A191B;
	Mon, 31 Aug 2026 13:25:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 94AD560231;
	Mon, 31 Aug 2026 13:25:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97AD411C78C5F;
	Mon, 31 Aug 2026 15:25:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788182730; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=44OE30qyZdWSpo3MMeDedIEJG4P6WUx7rEu5KOCgtO0=;
	b=FfNhmqkVRenbd+MRx+0pOFNtLNCvArdK4n95I8JZAMZlddSYPbI1KzNTd2Bqgva9LJLlnW
	5IfeMeOpt+h8LKhLJTPqy23ZxUmFr9dGEuFNRVsnzezPOailtzcFHvlIQWvlConMLzcz5v
	HfvQh+wKWCWsIAxkrJKFfE2njrOwfEXeU0H8f9tGLlUP8PmCs+q8Pv34uLEHgnzHcbXeoL
	CmSgiHU2Ks/W8nTY3SyM9EWqOMA0vbNXi6mQQ+ihfO7s+oiyDYvM7LfXXWsb69Qp/VsJ9R
	/WX34I8JDmpmjJXKz6hgJrtnY/lryRx1lVm2JMyQ2+1uV/N0dQCOrOR6VEJ5DA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 31 Aug 2026 15:25:23 +0200
Subject: [PATCH net-next 01/10] net: dsa: microchip: add the number of pins
 to chip infos
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ksz-perout-v1-1-14202db763b3@bootlin.com>
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

The number of periodic output pins available is hardcoded to 2 while
KSZ8463 has 12 pins that can be used as periodic outputs.

Add an n_pin attribute to the struct ksz_chip_data to make this setting
configurable.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 1 +
 drivers/net/dsa/microchip/ksz_common.h | 1 +
 drivers/net/dsa/microchip/ksz_ptp.c    | 4 ++--
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 1a9d6f83a023..55d1e3e3c529 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1194,6 +1194,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.ptp_capable = true,
 		.wr_table = &ksz8563_register_set,
 		.rd_table = &ksz8563_register_set,
+		.n_pins = 2,
 	},
 
 	[KSZ8795] = {
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

