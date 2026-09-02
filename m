Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A13943E087
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343084; cv=none; b=uyzmh4/2ERx1gJPrTvtZTimDmFAZpZHLOa5pf7b5vekCK4ZY8ew99ZL8nUTup+HygfvDuKIwK+J3awXX8YUMxwLqEvMxAafqp5Go/nQI0x26Y/07U2k5IeivcTGyxUjDlugiU3hn4wpC8vJLnTJVrlEoZjWQLpVTiY8vKXggo/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343084; c=relaxed/simple;
	bh=z/88C6UOJOWqBTiCoC/j3qGnCv8DSuX8Hilb0UR0JQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IE9j3umK4DqjXVUDCRXQPWFHCTEuttA11zlsbOgwLlfJHEaEK/M7G0jwPkhU8WRKWAoFTrr49p17ejjtDaJB8nfN0eHkGykRvgHDJkI3vMGCTIZTGEusu2DP+p8tZzjrU0PttOMsrdU+8wpY/yRtVMFvciuUZYjXuPQBTkOR8EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OF1y76gz; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OF1y76gz"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BACD41A195D;
	Wed,  2 Sep 2026 09:57:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8EEFB6053C;
	Wed,  2 Sep 2026 09:57:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EBB411C79352;
	Wed,  2 Sep 2026 11:57:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788343078; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Xhk3GUOqCGFdUbXj3wIq5uMSCGnlHq+Y3cCP6LHT7ZI=;
	b=OF1y76gzxLqaywfI2lIJWshFGlWgtExbfRm0qDqfK17u+t8dzb4ioSRBSmS/axxEgb2hQH
	vHl+VCygwhRsevQcjR6ZDNW1lVwaofyF1cVgQNDnENkDIvdh+jv/QPME9LDFNaMs+UAjV+
	ittS4tvOzZqGJkKG6zEs+0z7B3Wm1Imd9Hf7YncwKwJXQL4WUDjNw+X2AFu64iloanegRi
	OJpr/tDk97XfTvq8DNEbc1cg8gpa/EsNeigsE1dxnE6KoEopJbtUv1k64/yxZQEOZbyI3h
	+ydnsfALRQ5wCyYn2J+tvJIdpVamf4w5XzDE+pXGERNmMoEF1Lm5Ad7T3lIxLw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Wed, 02 Sep 2026 11:57:40 +0200
Subject: [PATCH net-next v2 10/10] net: dsa: microchip: add periodic output
 support for the KSZ8463
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ksz-perout-v2-10-6f277fcc9e68@bootlin.com>
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
 drivers/net/dsa/microchip/ksz_ptp.c     | 258 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_ptp.h     |   3 +-
 drivers/net/dsa/microchip/ksz_ptp_reg.h |  16 ++
 5 files changed, 279 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index f2a23e2e474a..6b08bb8fed5b 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2478,7 +2478,7 @@ static int ksz8463_setup(struct dsa_switch *ds)
 		if (ret)
 			goto free_girq;
 
-		ksz_ptp_set_caps(ds);
+		ksz8463_ptp_set_caps(ds);
 		ret = ksz_ptp_clock_register(ds);
 		if (ret) {
 			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 041bb4f96365..9e234ad71b72 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1161,6 +1161,8 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.supports_mii = {false, false, true},
 		.supports_rmii = {false, false, true},
 		.internal_phy = {true, true, false},
+		.n_pins = 12,
+		.n_per_out = 12,
 	},
 
 	[KSZ8563] = {
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 0a77b46cfad2..d33034892a8f 100644
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
+					u32 cycle_width_ns, u32 pulse_width_ns,
+					struct timespec64 const *target_time,
+					u8 index)
+{
+	struct ptp_pin_desc *pin = &dev->ptp_data.pin_config[index];
+	u16 cfg_base = KSZ8463_TRIG1_CFG + KSZ8463_TRIGN_CFG_SIZE * pin->chan;
+	u16 data;
+	int ret;
+
+	/* Hardware has only 32 bit */
+	if ((target_time->tv_sec & 0xffffffff) != target_time->tv_sec)
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
+			  target_time->tv_nsec);
+	if (ret)
+		return ret;
+
+	ret = ksz_write32(dev, cfg_base + KSZ8463_TARGET_SEC,
+			  target_time->tv_sec);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int ksz_ptp_configure_perout(struct ksz_device *dev,
 				    u32 cycle_width_ns, u32 pulse_width_ns,
 				    struct timespec64 const *target_time,
@@ -241,6 +325,58 @@ static u64 ksz_ptp_compute_perout_pulse(struct ksz_device *dev,
 	return min_t(u64, req_pulse_width_ns, max_pulse_width);
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
+	ret = ksz_ptp_compute_perout_cycle(dev, request, &cycle_width_ns);
+	if (ret)
+		return ret;
+	pulse_width_ns = ksz_ptp_compute_perout_pulse(dev, request,
+						      KSZ8463_MAX_PULSE_WIDTH);
+
+	ret = ksz_ptp_tou_pulse_verify(pulse_width_ns,
+				       KSZ8463_TRIG_PULSE_WIDTH_M);
+	if (ret)
+		return ret;
+
+	ret = ksz8463_ptp_configure_perout(dev, cycle_width_ns, pulse_width_ns,
+					   &ptp_data->perout_target_time_first,
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
+	ptp_data->tou_mode = KSZ_PTP_TOU_PEROUT;
+
+	return 0;
+}
+
 static int ksz_ptp_enable_perout(struct ksz_device *dev,
 				 struct ptp_perout_request const *request,
 				 int on)
@@ -845,6 +981,18 @@ static int ksz_ptp_restart_perout(struct ksz_device *dev)
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
@@ -871,6 +1019,41 @@ static int __ksz_ptp_settime(struct ksz_device *dev,
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
@@ -985,6 +1168,40 @@ static int __ksz_ptp_adjtime(struct ksz_device *dev, s64 delta)
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
@@ -1019,6 +1236,26 @@ static int ksz_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
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
@@ -1095,6 +1332,27 @@ static int ksz_ptp_start_clock(struct ksz_device *dev)
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
index 89716b31596b..92589cf373ac 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.h
+++ b/drivers/net/dsa/microchip/ksz_ptp.h
@@ -12,7 +12,7 @@
 
 #include <linux/ptp_clock_kernel.h>
 
-#define KSZ_PTP_N_GPIO		2
+#define KSZ_PTP_N_GPIO		12
 
 enum ksz_ptp_tou_mode {
 	KSZ_PTP_TOU_IDLE,
@@ -34,6 +34,7 @@ struct ksz_ptp_data {
 };
 
 void ksz_ptp_set_caps(struct dsa_switch *ds);
+void ksz8463_ptp_set_caps(struct dsa_switch *ds);
 int ksz_ptp_clock_register(struct dsa_switch *ds);
 
 void ksz_ptp_clock_unregister(struct dsa_switch *ds);
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

