Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83A449B454;
	Fri, 25 Sep 2026 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336362; cv=none; b=LhBdLvlgUKnL0+xXKG4JB7evpykJDq1HEWn3mWecR+LBbmfhUF5lRFKCjhKq5dy9G7M+kF1w0wNaTwRL0x2Bb1jgZw4wGdauVRFKrk89Q/gjNetekv5SLDGyJgYVdHyMtWjmkz5ohODiPT0GnnbaIkf8C6pZLetkCjw0jl3NITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336362; c=relaxed/simple;
	bh=aAX2+RP52M8YyMvIXC/lMT8ARIjI4eJ4pU1UnxT0uEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NUmpdVieLQ5CzOwm/YfgrQo9wV+xzwPjJt7laDknhPGdWhdQtvw+3F+ot5qY5qrhu2i5Bdd+sDqe2o0+gQRSJamhbwtu8mvkPUIM7/8Wbl+znHub71ERx+PqTwwaXdEjW6ZGRPl0ofemjSTCRv5u4NzzEige7Set+/vFFAnQD38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AffHLnol; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AffHLnol"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B06BAC13992;
	Fri, 25 Sep 2026 11:40:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DCE006073B;
	Fri, 25 Sep 2026 11:39:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79252103295D0;
	Fri, 25 Sep 2026 13:39:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790336357; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hr1bHRzaPY6pIKKzJUYJIKvMhd3noUvM7lIDTFq/kPE=;
	b=AffHLnoldF3oXgrbkau9WC2PFWUHRLJfa4JJeVT38lYauR+8q8qBtPH4rFFX0tv6rZGql3
	lOkRZzaJnsYq96jfQhAMzh1euw5V8vBZ7PIlFCrDV7cfy596UfYb4YQnJVq2IeNR6qwDoe
	KacRWOENWEq5tqQR5uBGOHLC7qQ7ai1KnMCx/R4YtGYGf1jHbKCf5xZECoceteYtm61S4P
	kD9N1VEe5FVc3o3yrDdO2CS+vcsUhdg+GPfz9uXmia/SqaC5X3kJZ9E1ZPfXhHvUVN2muC
	evZRNC+QqDzxQTrj4MqPcvJ5fTE9TtyeRUn8qtLFjnefVN+rTDnbo6NfcQTLBA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 25 Sep 2026 13:38:57 +0200
Subject: [PATCH net-next v4 11/11] net: dsa: microchip: add periodic output
 support for the KSZ8463
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-ksz-perout-v4-11-d675bd21ce49@bootlin.com>
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

KSZ8463 has several periodic outputs. The way it handles them differ
from the other KSZ switches:
 - KSZ8463 has one set of registers for each of its 12 units while others
   switches share on set of configuration registers for all their units.
 - Maximum size of the KSZ8463 pulse width is smaller
 - KSZ8463 has 12 outputs while others only have 2

Add support for the KSZ8463 periodics outputs through a set of KSZ8463
specific functions.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c        |   2 +-
 drivers/net/dsa/microchip/ksz_common.c  |   2 +
 drivers/net/dsa/microchip/ksz_ptp.c     | 261 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_ptp.h     |   4 +-
 drivers/net/dsa/microchip/ksz_ptp_reg.h |  16 ++
 5 files changed, 283 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 37b681d9e20f..3c96dd4581cf 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2589,7 +2589,7 @@ static int ksz8463_setup(struct dsa_switch *ds)
 		if (ret)
 			goto free_girq;
 
-		ksz_ptp_set_caps(ds);
+		ksz8463_ptp_set_caps(ds);
 		ret = ksz_ptp_clock_register(ds);
 		if (ret) {
 			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index ea6db85e7e2b..767c8fe8e819 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1175,6 +1175,8 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.supports_mii = {false, false, true},
 		.supports_rmii = {false, false, true},
 		.internal_phy = {true, true, false},
+		.n_pins = 12,
+		.n_per_out = 12,
 	},
 
 	[KSZ8563] = {
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index c1c4c781bca7..1c59428b159b 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -26,6 +26,7 @@
  */
 #define KSZ_MAX_DRIFT_CORR 6249999
 #define KSZ_MAX_PULSE_WIDTH 125000000LL
+#define KSZ8463_MAX_PULSE_WIDTH 500000LL
 
 #define KSZ_PTP_INC_NS 40ULL  /* HW clock is incremented every 40 ns (by 40) */
 #define KSZ_PTP_SUBNS_BITS 32
@@ -63,6 +64,17 @@ static int ksz_ptp_tou_gpio(struct ksz_device *dev)
 			 LED_SRC_PTP_GPIO_1 | LED_SRC_PTP_GPIO_2);
 }
 
+static int ksz8463_ptp_tou_reset(struct ksz_device *dev, u8 unit)
+{
+	int ret;
+
+	ret = ksz_rmw16(dev, KSZ8463_TOU_SW_RST, BIT(unit), BIT(unit));
+	if (ret)
+		return ret;
+
+	return ksz_rmw16(dev, KSZ8463_TOU_SW_RST, BIT(unit), 0);
+}
+
 static int ksz_ptp_tou_reset(struct ksz_device *dev, u8 unit)
 {
 	u32 data;
@@ -120,6 +132,28 @@ static int ksz_ptp_tou_target_time_set(struct ksz_device *dev,
 	return 0;
 }
 
+static int ksz8463_ptp_tou_start(struct ksz_device *dev, u8 unit)
+{
+	u16 data;
+	int ret;
+
+	ret = ksz_rmw16(dev, KSZ8463_TOU_EN, BIT(unit), BIT(unit));
+	if (ret)
+		return ret;
+
+	ret = ksz_read16(dev, KSZ8463_TOU_ACTIVE, &data);
+	if (ret)
+		return ret;
+
+	if (!(data & BIT(unit))) {
+		dev_err(dev->dev, "%s: Trigger unit%d error!\n", __func__,
+			unit);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int ksz_ptp_tou_start(struct ksz_device *dev, u8 unit)
 {
 	u32 data;
@@ -147,6 +181,56 @@ static int ksz_ptp_tou_start(struct ksz_device *dev, u8 unit)
 	return 0;
 }
 
+static int ksz8463_ptp_configure_perout(struct ksz_device *dev,
+					struct ptp_perout_request const *request,
+					u32 cycle_width_ns, u32 pulse_width_ns,
+					u8 index)
+{
+	struct ptp_pin_desc *pin = &dev->ptp_data.pin_config[index];
+	u16 cfg_base = KSZ8463_TRIG1_CFG + KSZ8463_TRIGN_CFG_SIZE * pin->chan;
+	u16 data;
+	int ret;
+
+	/* Hardware has only 32 bit for the second field */
+	if ((request->start.sec & 0xffffffff) != request->start.sec)
+		return -EINVAL;
+
+	data = KSZ8463_NOTIFY_BIT |
+	       FIELD_PREP(KSZ8463_PATTERN_M, TRIG_POS_PERIOD) |
+	       pin->index;
+	ret = ksz_write16(dev, cfg_base + KSZ8463_PATTERN_OFF, data);
+	if (ret)
+		return ret;
+
+	ret = ksz_write32(dev, cfg_base + KSZ8463_CYCLE_WIDTH_OFF,
+			  cycle_width_ns);
+	if (ret)
+		return ret;
+
+	/* Set cycle count 0 - Infinite */
+	ret = ksz_write16(dev, cfg_base + KSZ8463_CYCLE_CNT_OFF, 0);
+	if (ret)
+		return ret;
+
+	/* KSZ8463 uses a 8 ns unit value to compute the pulse width */
+	data = (pulse_width_ns / 8);
+	ret = ksz_write16(dev, cfg_base + KSZ8463_PULSE_WIDTH_OFF, data);
+	if (ret)
+		return ret;
+
+	ret = ksz_write32(dev, cfg_base + KSZ8463_TARGET_NSEC,
+			  request->start.nsec);
+	if (ret)
+		return ret;
+
+	ret = ksz_write32(dev, cfg_base + KSZ8463_TARGET_SEC,
+			  request->start.sec);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int ksz_ptp_configure_perout(struct ksz_device *dev,
 				    u32 cycle_width_ns, u32 pulse_width_ns,
 				    struct timespec64 const *target_time,
@@ -242,6 +326,61 @@ static int ksz_ptp_compute_perout_cycle(struct ksz_device *dev,
 	return 0;
 }
 
+static int ksz8463_ptp_enable_perout(struct ksz_device *dev,
+				     struct ptp_perout_request const *request,
+				     int on)
+{
+	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
+	u64 cycle_width_ns;
+	u64 pulse_width_ns;
+	int pin;
+	int ret;
+
+	pin = ksz_ptp_get_pin(dev, request);
+	if (pin < 0)
+		return pin;
+
+	ret = ksz8463_ptp_tou_reset(dev, request->index);
+	if (ret)
+		return ret;
+
+	if (!on) {
+		ptp_data->tou_mode = KSZ_PTP_TOU_IDLE;
+		return 0;
+	}
+
+	ret = ksz_ptp_compute_perout_cycle(dev, request,
+					   KSZ8463_MAX_PULSE_WIDTH,
+					   &cycle_width_ns, &pulse_width_ns);
+	if (ret)
+		return ret;
+
+	ret = ksz_ptp_tou_pulse_verify(pulse_width_ns,
+				       KSZ8463_TRIG_PULSE_WIDTH_M);
+	if (ret)
+		return ret;
+
+	ret = ksz8463_ptp_configure_perout(dev, request,
+					   cycle_width_ns, pulse_width_ns,
+					   pin);
+	if (ret)
+		return ret;
+
+	ret = ksz_ptp_tou_gpio(dev);
+	if (ret)
+		return ret;
+
+	ret = ksz8463_ptp_tou_start(dev, request->index);
+	if (ret)
+		return ret;
+
+	memcpy(&ptp_data->perout_request, request,
+	       sizeof(struct ptp_perout_request));
+	ptp_data->tou_mode = KSZ_PTP_TOU_PEROUT;
+
+	return 0;
+}
+
 static int ksz_ptp_enable_perout(struct ksz_device *dev,
 				 struct ptp_perout_request const *request,
 				 int on)
@@ -853,6 +992,18 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
 	return ksz_ptp_enable_perout(dev, &request, 1);
 }
 
+static int ksz8463_ptp_restart_perout(struct ksz_device *dev)
+{
+	struct ptp_perout_request request;
+	int ret;
+
+	ret = ksz_ptp_prepare_restart_perout(dev, &request);
+	if (ret)
+		return ret;
+
+	return ksz8463_ptp_enable_perout(dev, &request, 1);
+}
+
 static int __ksz_ptp_settime(struct ksz_device *dev,
 			     const struct timespec64 *ts)
 {
@@ -879,6 +1030,41 @@ static int __ksz_ptp_settime(struct ksz_device *dev,
 	return 0;
 }
 
+static int ksz8463_ptp_settime(struct ptp_clock_info *ptp,
+			       const struct timespec64 *ts)
+{
+	struct ksz_ptp_data *ptp_data = ptp_caps_to_data(ptp);
+	struct ksz_device *dev = ptp_data_to_ksz_dev(ptp_data);
+	int ret;
+
+	mutex_lock(&ptp_data->lock);
+
+	ret = __ksz_ptp_settime(dev, ts);
+	if (ret)
+		goto unlock;
+
+	switch (ptp_data->tou_mode) {
+	case KSZ_PTP_TOU_IDLE:
+		break;
+
+	case KSZ_PTP_TOU_PEROUT:
+		ret = ksz8463_ptp_restart_perout(dev);
+		if (ret)
+			goto unlock;
+
+		break;
+	}
+
+	spin_lock_bh(&ptp_data->clock_lock);
+	ptp_data->clock_time = *ts;
+	spin_unlock_bh(&ptp_data->clock_lock);
+
+unlock:
+	mutex_unlock(&ptp_data->lock);
+
+	return ret;
+}
+
 static int ksz_ptp_settime(struct ptp_clock_info *ptp,
 			   const struct timespec64 *ts)
 {
@@ -993,6 +1179,40 @@ static int __ksz_ptp_adjtime(struct ksz_device *dev, s64 delta)
 	return 0;
 }
 
+static int ksz8463_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct ksz_ptp_data *ptp_data = ptp_caps_to_data(ptp);
+	struct ksz_device *dev = ptp_data_to_ksz_dev(ptp_data);
+	struct timespec64 delta64 = ns_to_timespec64(delta);
+	int ret;
+
+	mutex_lock(&ptp_data->lock);
+
+	ret = __ksz_ptp_adjtime(dev, delta);
+	if (ret)
+		goto unlock;
+
+	switch (ptp_data->tou_mode) {
+	case KSZ_PTP_TOU_IDLE:
+		break;
+
+	case KSZ_PTP_TOU_PEROUT:
+		ret = ksz8463_ptp_restart_perout(dev);
+		if (ret)
+			goto unlock;
+
+		break;
+	}
+
+	spin_lock_bh(&ptp_data->clock_lock);
+	ptp_data->clock_time = timespec64_add(ptp_data->clock_time, delta64);
+	spin_unlock_bh(&ptp_data->clock_lock);
+
+unlock:
+	mutex_unlock(&ptp_data->lock);
+	return ret;
+}
+
 static int ksz_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
 	struct ksz_ptp_data *ptp_data = ptp_caps_to_data(ptp);
@@ -1027,6 +1247,26 @@ static int ksz_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	return ret;
 }
 
+static int ksz8463_ptp_enable(struct ptp_clock_info *ptp,
+			      struct ptp_clock_request *req, int on)
+{
+	struct ksz_ptp_data *ptp_data = ptp_caps_to_data(ptp);
+	struct ksz_device *dev = ptp_data_to_ksz_dev(ptp_data);
+	int ret;
+
+	switch (req->type) {
+	case PTP_CLK_REQ_PEROUT:
+		mutex_lock(&ptp_data->lock);
+		ret = ksz8463_ptp_enable_perout(dev, &req->perout, on);
+		mutex_unlock(&ptp_data->lock);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
 static int ksz_ptp_enable(struct ptp_clock_info *ptp,
 			  struct ptp_clock_request *req, int on)
 {
@@ -1103,6 +1343,27 @@ static int ksz_ptp_start_clock(struct ksz_device *dev)
 	return 0;
 }
 
+void ksz8463_ptp_set_caps(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+	struct ksz_ptp_data *ptp_data;
+
+	ptp_data = &dev->ptp_data;
+
+	ptp_data->caps.owner		= THIS_MODULE;
+	snprintf(ptp_data->caps.name, 16, "Microchip Clock");
+	ptp_data->caps.max_adj		= KSZ_MAX_DRIFT_CORR;
+	ptp_data->caps.gettime64	= ksz_ptp_gettime;
+	ptp_data->caps.settime64	= ksz8463_ptp_settime;
+	ptp_data->caps.adjfine		= ksz_ptp_adjfine;
+	ptp_data->caps.adjtime		= ksz8463_ptp_adjtime;
+	ptp_data->caps.do_aux_work	= ksz_ptp_do_aux_work;
+	ptp_data->caps.enable		= ksz8463_ptp_enable;
+	ptp_data->caps.verify		= ksz_ptp_verify_pin;
+	ptp_data->caps.n_pins		= dev->info->n_pins;
+	ptp_data->caps.n_per_out	= dev->info->n_per_out;
+}
+
 void ksz_ptp_set_caps(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
diff --git a/drivers/net/dsa/microchip/ksz_ptp.h b/drivers/net/dsa/microchip/ksz_ptp.h
index b23040f47b9c..22898a22723c 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.h
+++ b/drivers/net/dsa/microchip/ksz_ptp.h
@@ -12,7 +12,7 @@
 
 #include <linux/ptp_clock_kernel.h>
 
-#define KSZ_PTP_N_GPIO		2
+#define KSZ_PTP_N_GPIO		12
 
 enum ksz_ptp_tou_mode {
 	KSZ_PTP_TOU_IDLE,
@@ -33,6 +33,7 @@ struct ksz_ptp_data {
 };
 
 void ksz_ptp_set_caps(struct dsa_switch *ds);
+void ksz8463_ptp_set_caps(struct dsa_switch *ds);
 int ksz_ptp_clock_register(struct dsa_switch *ds);
 
 void ksz_ptp_clock_unregister(struct dsa_switch *ds);
@@ -66,6 +67,7 @@ struct ksz_ptp_data {
 };
 
 static inline void ksz_ptp_set_caps(struct dsa_switch *ds) { }
+static inline void ksz8463_ptp_set_caps(struct dsa_switch *ds) { }
 static inline int ksz_ptp_clock_register(struct dsa_switch *ds)
 {
 	return 0;
diff --git a/drivers/net/dsa/microchip/ksz_ptp_reg.h b/drivers/net/dsa/microchip/ksz_ptp_reg.h
index 65ea8577af75..16f117fa5d49 100644
--- a/drivers/net/dsa/microchip/ksz_ptp_reg.h
+++ b/drivers/net/dsa/microchip/ksz_ptp_reg.h
@@ -51,6 +51,22 @@
 
 #define REG_PTP_UNIT_INDEX__4		0x0520
 
+#define KSZ8463_TOU_ACTIVE		0x202
+#define KSZ8463_TOU_EN			0x206
+#define KSZ8463_TOU_SW_RST		0x208
+
+#define KSZ8463_TRIGN_CFG_SIZE		0x20
+#define KSZ8463_TRIG1_CFG		0x220
+#define KSZ8463_TARGET_NSEC		0x000
+#define KSZ8463_TARGET_SEC		0x004
+#define KSZ8463_PATTERN_OFF		0x008
+#define KSZ8463_NOTIFY_BIT		BIT(8)
+#define KSZ8463_PATTERN_M		GENMASK(6, 4)
+#define KSZ8463_PULSE_WIDTH_OFF		0x00A
+#define KSZ8463_TRIG_PULSE_WIDTH_M	GENMASK(15, 0)
+#define KSZ8463_CYCLE_WIDTH_OFF		0x00C
+#define KSZ8463_CYCLE_CNT_OFF		0x010
+
 #define PTP_GPIO_INDEX			GENMASK(19, 16)
 #define PTP_TSI_INDEX			BIT(8)
 #define PTP_TOU_INDEX			GENMASK(1, 0)

-- 
2.55.0

