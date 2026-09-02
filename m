Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8582438010;
	Wed,  2 Sep 2026 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343073; cv=none; b=K6GhbQEn1Ft1lCbep/KMPQ8TzU+YOcfb7HQZ7QpoHjf9jdFKNAx/kyVUO2otleAna1hJ8vl8foXGFsunI/Fo+WQIMw7VfsMaP5dZ4AeInBy/P6nu/RnRQBaT2llQbdLWkMfK3qqx9gBPoJae9yOZwD1M6P9DBrMAW/1Hf4SBXNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343073; c=relaxed/simple;
	bh=4ov+NSQSBX9Qvd8THsxWYSJTFFg1Yr0ldf+mlrYxNTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ElsftlEnz1Dhq+qoT+JbkTDtjQYx0UVFs+TNoVqfdLsSmqrZ8rOF00LkXiEhLDtQjoKxvFdLwTZDS9Es4VXhkJ2MJZwz5YAHsPWi+s2Njk5JSztgpxZibqEW90Ob8IOTsazDKwnTNlXbRvFvU7eYfJjnGldg/ekTStTs2b0NvhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=u6adEG5s; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="u6adEG5s"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3F9481A1953;
	Wed,  2 Sep 2026 09:57:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 13F786053C;
	Wed,  2 Sep 2026 09:57:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 83AA011C792F3;
	Wed,  2 Sep 2026 11:57:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788343068; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RZ7rb6VbA9/VWHZ6BBtewbfE+bCLAayiZRWpfJptYvM=;
	b=u6adEG5s1csP0qPRdW1eEReTkR6nzs5vg9t8eK+19v6wLiabD+XhqJt2Kp9UKopy+ezdpY
	83lZtWrI4TNlf4eAnEBe4HD7cZ1GEYjtPQvFttny4vFqfsLJuy/FX8ayyLa8KLSD75tj2g
	JDgBMVR5w90lEnFADcbxDbO9D4nFUqFE6PfHfVdZJWNBovCssGpY1Xeka7QtYytyDyZdlc
	KnEQPrXzNuHe1za1S5mBfAOHFP6indRXxgtQr3rnm0bkje34RA6oTfDT/ov8H1v7wlkpsQ
	ZUM8MLAkOYq1vV/hkch70pViYufoEgjwIN/qeQF02gaB0hvQkeGiRpgVTjQLNg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Wed, 02 Sep 2026 11:57:34 +0200
Subject: [PATCH net-next v2 04/10] net: dsa: microchip: extract PTP
 callbacks configuration from PTP registration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ksz-perout-v2-4-6f277fcc9e68@bootlin.com>
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

KSZ8463 also has periodic output capabilities but the way its outputs
are driven differs from the other switches. It will need its own set of
PTP callbacks to implements this behaviour.

Extract the PTP callbacks configuration in a dedicated function to be
called before the PTP registration to ease the use of others callbacks
when needed.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         |  2 ++
 drivers/net/dsa/microchip/ksz9477.c      |  1 +
 drivers/net/dsa/microchip/ksz_ptp.c      | 20 ++++++++++++++------
 drivers/net/dsa/microchip/ksz_ptp.h      |  2 ++
 drivers/net/dsa/microchip/lan937x_main.c |  1 +
 5 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 941ae9f66f70..f2a23e2e474a 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2478,6 +2478,7 @@ static int ksz8463_setup(struct dsa_switch *ds)
 		if (ret)
 			goto free_girq;
 
+		ksz_ptp_set_caps(ds);
 		ret = ksz_ptp_clock_register(ds);
 		if (ret) {
 			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
@@ -2775,6 +2776,7 @@ static int ksz8_setup(struct dsa_switch *ds)
 	}
 
 	if (dev->info->ptp_capable) {
+		ksz_ptp_set_caps(ds);
 		ret = ksz_ptp_clock_register(ds);
 		if (ret) {
 			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 3ee995545c57..72528a53b67d 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1781,6 +1781,7 @@ static int ksz9477_setup(struct dsa_switch *ds)
 	}
 
 	if (dev->info->ptp_capable) {
+		ksz_ptp_set_caps(ds);
 		ret = ksz_ptp_clock_register(ds);
 		if (ret) {
 			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 7bf83e0b5918..ea22601f6b26 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1028,17 +1028,12 @@ static int ksz_ptp_start_clock(struct ksz_device *dev)
 	return 0;
 }
 
-int ksz_ptp_clock_register(struct dsa_switch *ds)
+void ksz_ptp_set_caps(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
-	const u16 *regs = dev->info->regs;
 	struct ksz_ptp_data *ptp_data;
-	int ret;
-	u8 i;
 
 	ptp_data = &dev->ptp_data;
-	mutex_init(&ptp_data->lock);
-	spin_lock_init(&ptp_data->clock_lock);
 
 	ptp_data->caps.owner		= THIS_MODULE;
 	snprintf(ptp_data->caps.name, 16, "Microchip Clock");
@@ -1052,6 +1047,19 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
 	ptp_data->caps.verify		= ksz_ptp_verify_pin;
 	ptp_data->caps.n_pins		= dev->info->n_pins;
 	ptp_data->caps.n_per_out	= dev->info->n_per_out;
+}
+
+int ksz_ptp_clock_register(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+	const u16 *regs = dev->info->regs;
+	struct ksz_ptp_data *ptp_data;
+	int ret;
+	u8 i;
+
+	ptp_data = &dev->ptp_data;
+	mutex_init(&ptp_data->lock);
+	spin_lock_init(&ptp_data->clock_lock);
 
 	ret = ksz_ptp_start_clock(dev);
 	if (ret)
diff --git a/drivers/net/dsa/microchip/ksz_ptp.h b/drivers/net/dsa/microchip/ksz_ptp.h
index 7067ec9bd1e6..89716b31596b 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.h
+++ b/drivers/net/dsa/microchip/ksz_ptp.h
@@ -33,6 +33,7 @@ struct ksz_ptp_data {
 	struct timespec64 perout_period;
 };
 
+void ksz_ptp_set_caps(struct dsa_switch *ds);
 int ksz_ptp_clock_register(struct dsa_switch *ds);
 
 void ksz_ptp_clock_unregister(struct dsa_switch *ds);
@@ -65,6 +66,7 @@ struct ksz_ptp_data {
 	struct mutex lock;
 };
 
+static inline void ksz_ptp_set_caps(struct dsa_switch *ds) { }
 static inline int ksz_ptp_clock_register(struct dsa_switch *ds)
 {
 	return 0;
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 86ce3a86705f..3a209122fc7d 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -867,6 +867,7 @@ static int lan937x_setup(struct dsa_switch *ds)
 		}
 	}
 
+	ksz_ptp_set_caps(ds);
 	ret = ksz_ptp_clock_register(ds);
 	if (ret) {
 		dev_err(dev->dev, "Failed to register PTP clock: %d\n",

-- 
2.55.0

