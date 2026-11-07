Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794034488;
	b=C8IL1H4ons+sUy0lGT9nqcxwNU7OnDNHbeP1GX3eJlRxnsxVYdVUgrzXhT288N7qRIl/
	 19sEKitVALsNsBbgb3kNDeGOmBVPzGlnQdTehTV/OQuILDsWa5ego6klZ+cccEFRBiK0g
	 r+vkZD6P4m/0Vgi3AqKe6KEMcHaPVF6G77z+YzPxSGIProN0eyvnNub14c+135JmD80oH
	 u5N6AWrNw1leE5ahOspD4ZSMgygEhZcRBsaNFo5UcBkoOl5X/D1rxOZkyL6rpCXHL1mB9
	 HjxM/UlFXUZTbyXqBj5W4AxdsI0ZE4lV5C0QoFFlkpbHEC0h/ijI2lS0al60vYnihjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794034488;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=Q7byZT0uSBls4TZbWFIu4jBgVekwFAbwJ3Kw7AbsK00=;
	b=rnXCvtkKMqh8jkR9U3mA79CgNFES4ehUjXHFWnHPFQVKzMVNTxSejm3DNfNUtA1YRyXV
	 k3cdQCIxqFYqo6HPcJlWxUGa0z/KZ1jJO39ZbVnD3lcsNsRqoGWAVr61cDfl6pRU+2Ivn
	 7wjjgmHH0tfCXXPKqDsT/zJ/iugdsFTA+YWGifOFgWgnmkLVj/A98pChb+RzXKR2cYQbn
	 FnWYquIncQ2NKhN290uqKBticmz9OtetPbrjjUHsta/1I19sLBhBLG7rPP5KAEK+v6epR
	 Xm1FvvxguctCX0VthzP/mQ+7koa6d9GJ6gWUpKaeLzpEallaPwGFdsGrQONlW8NJeuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=UzYpnFD8;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3170606A33C;
	Sat,  7 Nov 2026 06:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3170606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=UzYpnFD8
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 53d65d8fd;
	Sat, 7 Nov 2026 14:54:38 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: micrel: Fix potential shared PHC use-after-free
Date: Sat,  7 Nov 2026 14:54:37 +0800
Message-ID: <20261107-0d0c29e10a-net-micrel-lan8814-1@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1b4c9abe803a1kunmd42b1c4382b6d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTUwZVkxNTkIaT04YSRlMQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0hKTE
	1DVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=UzYpnFD8m+B5zXtbmJKSMU4qnv4MwOHXcPeuSg3XeZrVPW9YPWkrdnqc0J2W6bS3J5rMBm2JO3VCZIlmN5+e/48nF966to+UFDf/fKndDrLa43Yh6JZeIap8wN6dtODBG2GelxBP+fXjoD5ayTBuRxKVEA8vmpNuYScyhqwhlBU=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=Q7byZT0uSBls4TZbWFIu4jBgVekwFAbwJ3Kw7AbsK00=;
	h=date:mime-version:subject:message-id:from;

The shared PHC outlives the first PHY's managed pin array and is not
unregistered before the package data is freed. Subsequent PHC operations
can therefore access released storage.

Keep the pins at package scope and select a remaining PHY for register
access when a member leaves. Unregister the clock before releasing its
storage on the last member's exit. Pair each member's registration with
cleanup that also runs on probe failure, and serialize clock access with
member removal.

This issue was found by our static analysis tool under development.
Validated by source review, x86-64 W=1 object builds and an extracted-code
lifecycle test with mocked services. Not tested on hardware.

Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Validation: x86-64 Clang W=1 micrel.o passed with allmodconfig,
allyesconfig and PTP disabled. An extracted-code test with mocked
services passed under GCC ASan/UBSan; this is not a kernel reproducer.
No hardware test or full linked-kernel build.
OpenAI Codex assisted with source review, patch implementation and
commit-message drafting. The submitter has reviewed the changes.

 drivers/net/phy/micrel.c | 177 ++++++++++++++++++++++++++++++---------
 1 file changed, 139 insertions(+), 38 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index d0b1ad21667b..8c48d00b0ccf 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -413,6 +413,10 @@ struct kszphy_type {
 /* Shared structure between the PHYs of the same package. */
 struct lan8814_shared_priv {
 	struct phy_device *phydev;
+	struct phy_device *members[PHY_MAX_ADDR];
+	bool lock_initialized;
+	bool coma_released;
+	bool clock_stopping;
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_info;
 	struct ptp_pin_desc *pin_config;
@@ -3257,7 +3261,13 @@ static int lan8814_ts_info(struct mii_timestamper *mii_ts, struct kernel_ethtool
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
 
+	mutex_lock(&shared->shared_lock);
+	if (!shared->ptp_clock || shared->clock_stopping) {
+		mutex_unlock(&shared->shared_lock);
+		return -ENODEV;
+	}
 	info->phc_index = ptp_clock_index(shared->ptp_clock);
+	mutex_unlock(&shared->shared_lock);
 
 	info->tx_types =
 		(1 << HWTSTAMP_TX_OFF) |
@@ -3539,11 +3549,12 @@ static int lan8814_ptpci_gettime64(struct ptp_clock_info *ptpci,
 {
 	struct lan8814_shared_priv *shared = container_of(ptpci, struct lan8814_shared_priv,
 							  ptp_clock_info);
-	struct phy_device *phydev = shared->phydev;
+	struct phy_device *phydev;
 	u32 nano_seconds;
 	time64_t seconds;
 
 	mutex_lock(&shared->shared_lock);
+	phydev = shared->phydev;
 	lan8814_ptp_clock_get(phydev, &seconds, &nano_seconds);
 	mutex_unlock(&shared->shared_lock);
 	ts->tv_sec = seconds;
@@ -3557,9 +3568,10 @@ static int lan8814_ptpci_settime64(struct ptp_clock_info *ptpci,
 {
 	struct lan8814_shared_priv *shared = container_of(ptpci, struct lan8814_shared_priv,
 							  ptp_clock_info);
-	struct phy_device *phydev = shared->phydev;
+	struct phy_device *phydev;
 
 	mutex_lock(&shared->shared_lock);
+	phydev = shared->phydev;
 	lan8814_ptp_clock_set(phydev, ts->tv_sec, ts->tv_nsec);
 	mutex_unlock(&shared->shared_lock);
 
@@ -3739,9 +3751,10 @@ static int lan8814_ptpci_adjtime(struct ptp_clock_info *ptpci, s64 delta)
 {
 	struct lan8814_shared_priv *shared = container_of(ptpci, struct lan8814_shared_priv,
 							  ptp_clock_info);
-	struct phy_device *phydev = shared->phydev;
+	struct phy_device *phydev;
 
 	mutex_lock(&shared->shared_lock);
+	phydev = shared->phydev;
 	lan8814_ptp_clock_step(phydev, delta);
 	mutex_unlock(&shared->shared_lock);
 
@@ -3752,7 +3765,7 @@ static int lan8814_ptpci_adjfine(struct ptp_clock_info *ptpci, long scaled_ppm)
 {
 	struct lan8814_shared_priv *shared = container_of(ptpci, struct lan8814_shared_priv,
 							  ptp_clock_info);
-	struct phy_device *phydev = shared->phydev;
+	struct phy_device *phydev;
 	u16 kszphy_rate_adj_lo, kszphy_rate_adj_hi;
 	bool positive = true;
 	u32 kszphy_rate_adj;
@@ -3772,6 +3785,7 @@ static int lan8814_ptpci_adjfine(struct ptp_clock_info *ptpci, long scaled_ppm)
 		kszphy_rate_adj_hi |= PTP_CLOCK_RATE_ADJ_DIR_;
 
 	mutex_lock(&shared->shared_lock);
+	phydev = shared->phydev;
 	lanphy_write_page_reg(phydev, LAN8814_PAGE_COMMON_REGS, PTP_CLOCK_RATE_ADJ_HI,
 			      kszphy_rate_adj_hi);
 	lanphy_write_page_reg(phydev, LAN8814_PAGE_COMMON_REGS, PTP_CLOCK_RATE_ADJ_LO,
@@ -3875,13 +3889,14 @@ static int lan8814_ptp_perout(struct ptp_clock_info *ptpci,
 {
 	struct lan8814_shared_priv *shared = container_of(ptpci, struct lan8814_shared_priv,
 							  ptp_clock_info);
-	struct phy_device *phydev = shared->phydev;
+	struct phy_device *phydev;
 	struct timespec64 ts_on, ts_period;
 	s64 on_nsec, period_nsec;
 	int pulse_width;
 	int pin, event;
 
 	mutex_lock(&shared->shared_lock);
+	phydev = shared->phydev;
 	event = rq->perout.index;
 	pin = ptp_find_pin(shared->ptp_clock, PTP_PF_PEROUT, event);
 	if (pin < 0 || pin >= LAN8814_PTP_PEROUT_NUM) {
@@ -4047,7 +4062,7 @@ static int lan8814_ptp_extts(struct ptp_clock_info *ptpci,
 {
 	struct lan8814_shared_priv *shared = container_of(ptpci, struct lan8814_shared_priv,
 							  ptp_clock_info);
-	struct phy_device *phydev = shared->phydev;
+	struct phy_device *phydev;
 	int pin;
 
 	pin = ptp_find_pin(shared->ptp_clock, PTP_PF_EXTTS,
@@ -4056,6 +4071,7 @@ static int lan8814_ptp_extts(struct ptp_clock_info *ptpci,
 		return -EINVAL;
 
 	mutex_lock(&shared->shared_lock);
+	phydev = shared->phydev;
 	if (on)
 		lan8814_ptp_extts_on(phydev, pin, rq->extts.flags);
 	else
@@ -4331,7 +4347,10 @@ static int lan8814_handle_gpio_interrupt(struct phy_device *phydev, u16 status)
 	int ret;
 
 	mutex_lock(&shared->shared_lock);
-	ret = lan8814_gpio_process_cap(shared);
+	if (shared->ptp_clock && !shared->clock_stopping)
+		ret = lan8814_gpio_process_cap(shared);
+	else
+		ret = -ENODEV;
 	mutex_unlock(&shared->shared_lock);
 
 	return ret;
@@ -4559,20 +4578,15 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 	phydev->default_timestamp = true;
 }
 
-static int __lan8814_ptp_probe_once(struct phy_device *phydev, char *pin_name,
-				    int gpios)
+static int lan8814_ptp_register(struct phy_device *phydev, char *pin_name,
+				int gpios)
 {
 	struct lan8814_shared_priv *shared = phy_package_get_priv(phydev);
 
 	shared->phydev = phydev;
 
-	/* Initialise shared lock for clock*/
-	mutex_init(&shared->shared_lock);
-
-	shared->pin_config = devm_kmalloc_array(&phydev->mdio.dev,
-						gpios,
-						sizeof(*shared->pin_config),
-						GFP_KERNEL);
+	shared->pin_config = kmalloc_array(gpios, sizeof(*shared->pin_config),
+					   GFP_KERNEL);
 	if (!shared->pin_config)
 		return -ENOMEM;
 
@@ -4612,13 +4626,12 @@ static int __lan8814_ptp_probe_once(struct phy_device *phydev, char *pin_name,
 	if (IS_ERR(shared->ptp_clock)) {
 		phydev_err(phydev, "ptp_clock_register failed %pe\n",
 			   shared->ptp_clock);
+		shared->ptp_clock = NULL;
+		kfree(shared->pin_config);
+		shared->pin_config = NULL;
 		return -EINVAL;
 	}
 
-	/* Check if PHC support is missing at the configuration level */
-	if (!shared->ptp_clock)
-		return 0;
-
 	phydev_dbg(phydev, "successfully registered ptp clock\n");
 
 	/* The EP.4 is shared between all the PHYs in the package and also it
@@ -4636,12 +4649,90 @@ static int __lan8814_ptp_probe_once(struct phy_device *phydev, char *pin_name,
 	return 0;
 }
 
-static int lan8814_ptp_probe_once(struct phy_device *phydev)
+static void lan8814_ptp_leave(void *data)
+{
+	struct phy_device *phydev = data;
+	struct lan8814_shared_priv *shared = phy_package_get_priv(phydev);
+	struct phy_device *next = NULL;
+	unsigned int i;
+
+	phy_package_lock(phydev);
+	mutex_lock(&shared->shared_lock);
+	shared->members[phydev->mdio.addr] = NULL;
+	for (i = 0; i < ARRAY_SIZE(shared->members); i++) {
+		if (shared->members[i]) {
+			next = shared->members[i];
+			break;
+		}
+	}
+	if (next) {
+		shared->phydev = next;
+		mutex_unlock(&shared->shared_lock);
+		phy_package_unlock(phydev);
+		return;
+	}
+
+	shared->clock_stopping = true;
+	mutex_unlock(&shared->shared_lock);
+	/* Unregister calls enable() to disable events, using the last PHY. */
+	ptp_clock_unregister(shared->ptp_clock);
+	mutex_lock(&shared->shared_lock);
+	shared->ptp_clock = NULL;
+	shared->phydev = NULL;
+	kfree(shared->pin_config);
+	shared->pin_config = NULL;
+	shared->clock_stopping = false;
+	mutex_unlock(&shared->shared_lock);
+	phy_package_unlock(phydev);
+}
+
+static int lan8814_ptp_join(struct phy_device *phydev, char *pin_name,
+			    int gpios)
+{
+	struct lan8814_shared_priv *shared = phy_package_get_priv(phydev);
+	int ret = 0;
+
+	phy_package_lock(phydev);
+	if (!shared->lock_initialized) {
+		mutex_init(&shared->shared_lock);
+		shared->lock_initialized = true;
+	}
+	if (!IS_ENABLED(CONFIG_PTP_1588_CLOCK)) {
+		phy_package_unlock(phydev);
+		return 0;
+	}
+	mutex_lock(&shared->shared_lock);
+	if (!shared->ptp_clock)
+		ret = lan8814_ptp_register(phydev, pin_name, gpios);
+	if (!ret)
+		shared->members[phydev->mdio.addr] = phydev;
+	mutex_unlock(&shared->shared_lock);
+	phy_package_unlock(phydev);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(&phydev->mdio.dev, lan8814_ptp_leave,
+					phydev);
+}
+
+static void lan8814_remove(struct phy_device *phydev)
+{
+	struct lan8814_shared_priv *shared;
+
+	if (!phydev->shared)
+		return;
+
+	shared = phy_package_get_priv(phydev);
+	if (shared->members[phydev->mdio.addr])
+		devm_release_action(&phydev->mdio.dev, lan8814_ptp_leave, phydev);
+}
+
+static int lan8814_ptp_probe(struct phy_device *phydev)
 {
 	if (!lan8814_has_ptp(phydev))
 		return 0;
 
-	return __lan8814_ptp_probe_once(phydev, "lan8814_ptp_pin",
+	return lan8814_ptp_join(phydev, "lan8814_ptp_pin",
 					LAN8814_PTP_GPIO_NUM);
 }
 
@@ -4747,6 +4838,7 @@ static void lan8814_update_meas_time(struct phy_device *phydev)
 static int lan8814_probe(struct phy_device *phydev)
 {
 	const struct kszphy_type *type = phydev->drv->driver_data;
+	struct lan8814_shared_priv *shared;
 	struct kszphy_priv *priv;
 	u16 addr;
 	int err;
@@ -4765,8 +4857,11 @@ static int lan8814_probe(struct phy_device *phydev)
 	 * phy address value
 	 */
 	addr = lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS, 0) & 0x1F;
-	devm_phy_package_join(&phydev->mdio.dev, phydev,
-			      addr, sizeof(struct lan8814_shared_priv));
+	err = devm_phy_package_join(&phydev->mdio.dev, phydev, addr,
+				    sizeof(struct lan8814_shared_priv));
+	if (err)
+		return err;
+	shared = phy_package_get_priv(phydev);
 
 	/* There are lan8814 SKUs that don't support PTP. Make sure that for
 	 * those skus no PTP device is created. Here we check if the SKU
@@ -4780,15 +4875,21 @@ static int lan8814_probe(struct phy_device *phydev)
 	priv->is_ptp_available = err == LAN8814_REV_LAN8814 ||
 				 err == LAN8814_REV_LAN8818;
 
-	if (phy_package_probe_once(phydev)) {
+	phy_package_lock(phydev);
+	if (!shared->coma_released) {
 		err = lan8814_release_coma_mode(phydev);
-		if (err)
-			return err;
-
-		err = lan8814_ptp_probe_once(phydev);
-		if (err)
-			return err;
+		if (!err)
+			shared->coma_released = true;
+	} else {
+		err = 0;
 	}
+	phy_package_unlock(phydev);
+	if (err)
+		return err;
+
+	err = lan8814_ptp_probe(phydev);
+	if (err)
+		return err;
 
 	lan8814_ptp_init(phydev);
 
@@ -6143,9 +6244,9 @@ static int ksz9131_resume(struct phy_device *phydev)
 
 #define LAN8842_PTP_GPIO_NUM 16
 
-static int lan8842_ptp_probe_once(struct phy_device *phydev)
+static int lan8842_ptp_probe(struct phy_device *phydev)
 {
-	return __lan8814_ptp_probe_once(phydev, "lan8842_ptp_pin",
+	return lan8814_ptp_join(phydev, "lan8842_ptp_pin",
 					LAN8842_PTP_GPIO_NUM);
 }
 
@@ -6213,11 +6314,9 @@ static int lan8842_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (phy_package_init_once(phydev)) {
-		ret = lan8842_ptp_probe_once(phydev);
-		if (ret)
-			return ret;
-	}
+	ret = lan8842_ptp_probe(phydev);
+	if (ret)
+		return ret;
 
 	lan8814_ptp_init(phydev);
 
@@ -6955,6 +7054,7 @@ static struct phy_driver ksphy_driver[] = {
 	.config_init	= lan8814_config_init,
 	.driver_data	= &lan8814_type,
 	.probe		= lan8814_probe,
+	.remove		= lan8814_remove,
 	.soft_reset	= genphy_soft_reset,
 	.read_status	= ksz9031_read_status,
 	.get_sset_count	= kszphy_get_sset_count,
@@ -7006,6 +7106,7 @@ static struct phy_driver ksphy_driver[] = {
 	.flags		= PHY_POLL_CABLE_TEST,
 	.driver_data	= &lan8814_type,
 	.probe		= lan8842_probe,
+	.remove		= lan8814_remove,
 	.config_init	= lan8842_config_init,
 	.config_intr	= lan8842_config_intr,
 	.inband_caps	= lan8842_inband_caps,

base-commit: 787268686c64be60023743b527645a907e38ccca
