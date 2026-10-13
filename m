Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E0547F3A7
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862350; cv=none; b=FIQP94kucGLriqMDDtuMXIL0EH3d1XBknKaurMadnPEpKE9zeTpmk4TqmnNtjitiKN0y9eLEqCTKwi3gZRvX2CP/u/Kb0EVIStbnf+rBWlkoSP+RTfNCF69AhK/gV3kZLhLa78BFgWEx9fIQ1ViLaPQyPHByTGlmndAl4JQOwvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862350; c=relaxed/simple;
	bh=nVQn6twahBTMsB4V8PcHUtN26tjabxKhBgY5NrYtpA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XrrhKOELaZJrd09Gk5d4jVMjYwy5jn+nwysDWkLW16aHT0ltFqlDyrRpjgZRUm2jyM6lBd7MdAaFnwSbaMlxSHwIZaM62bOoewAzebrYwuivVWgyDsiKpYzUq2FLIBqVQdpfXbDpNrybj5q/FKzf2oGEuYQRq6bhxawcbi1+SCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrEdsu+x; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrEdsu+x"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ab33730821so1352388a91.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 20:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862348; x=1792467148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJ0JW0GgMQPSXOlKMUREDr9mLZGpyv0hM8FhCAPs+z8=;
        b=RrEdsu+xUaRYczgeo7791AMKH4mn2DNNgX/X+fauIgM/hZx9A6LsmPNEqOPftyXZST
         DHGkBJTcPlvGouNUSZjaSufyAhG5NJUnij1nJKnT0P+WaAAr9EEKlBkklIT0Xhb48Few
         cvDdmXmMA4LJJrX5iwojlrVYlfouq+n5LfhMmmcjbdEVXdmQgmR7kxSRSUTCrjhDU6EV
         w5qX0yN4QuASII+kGjAkJv7vORCLKA4JLpET5X8Xn0LqEaqme6jtPFWhmENlU5MefB7U
         1JrmJtRjOolDT+rDbPzJ/+uFK0U9EYsip1NxQ/hOrvXvsvDlZCJ/DkuMLHbfXBLqWAya
         TsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862348; x=1792467148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DJ0JW0GgMQPSXOlKMUREDr9mLZGpyv0hM8FhCAPs+z8=;
        b=UgDx8UPDMN1D4wWGu+FvV1NVi9Y69KH5e/pq0B6sGRtjE3Zo0dTGw7wRBYRpeQ+93A
         pGQDNI1yL4U+nNBGsZVaiONClbZu/Vy+4PHI3TCRj4YK5gS/l+7HRM4i866RRcK9i5IB
         wPVG122EiUwsbyESazbZ410856yvhcuYb0MfnlZlGJIxwJLjr4ofFuF7kjhrNNqluM+G
         xTnKNa7p3n4VmNqn83kgeWfkRV2FsBAnLMN/9Z7mFWfsVr6TsEHamy44I6JtRrfboVXU
         PDEtBCfvDVjsPle1MLPEcEAn1KVMhyUI2FZvgd0I9MleSjmzdZJ8eS6KRySOJYegFwjF
         1vTQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/O7yXNryu+NzuYtbam3x9SFSX86XyEpya7vBQpt8g0Lw5FflHtoaCf2oX6XaPZp4/26WTApE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiCpS3B2OyUGouZfc92ircS17zOam3yukI8SVnjzH2PRxcPVqP
	4x/FBCHqERGvp2kjyDeUOywIJhWBmA5Tewa5Hbr2/Ws0ArsQdJxlrj0L
X-Gm-Gg: AYBFou3CNuyOKTNjhR3HC2Di2eGUfuxa8jVBHao9bD04Jxg8EiOm24CsgG48Ap4F3Kv
	dySk8Lq768Fdov4oJrf9huxvDgvEZPCwT6LixL088Wmo0ONVnKNP1mW0BTFD0HGgw9ndJ8CUuIX
	FORoIGUD//odhZS/8WfFyeN1vDwZC2POCRTo7wsOlOiQ4orcHLAW9ZuI+VxLKP6FBpZGeLr4KQT
	VGFk7E6zqPYTXlMg0sRiTZBG0RVuccn+mgKYxcCrSX3MUbUdeb23HXkQLBRzGi1ID9C2YAvj6G8
	cU8MXwLZjNpOUA46GK7g+JF9TM3tmA/BwUWnvHRwD79DYoHXKi3Uk20JuXJKkuOKpL2B2gSY4JA
	d5Xze4FZEttYogRfRhDUUKLKcjx3A6ZmwT/qa8dFakhHJqxUKixgIurMaenKhtfHGSaorspLi4E
	oP+4b2AobkzdjLpQBDvDjCGlJprypaq7oTtxWe2X0K8VFo/SwrIS5InKmS+79wfllrYqvTeA==
X-Received: by 2002:a17:90b:4b09:b0:3a2:b16d:928b with SMTP id 98e67ed59e1d1-3ab3a79dd3emr9074294a91.46.1791862347541;
        Mon, 12 Oct 2026 20:32:27 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36fdc75esm19541303a91.12.2026.10.12.20.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:32:26 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	muhammad.nazim.amirul.nazle.asmade@altera.com,
	rohan.g.thomas@altera.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net-next v8 3/3] net: stmmac: dwxgmac2: add XGMAC timestamp interrupt support
Date: Tue, 13 Oct 2026 11:32:07 +0800
Message-Id: <20261013033207.1684328-4-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013033207.1684328-1-zxyan0222@gmail.com>
References: <20261013033207.1684328-1-zxyan0222@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DWXGMAC2 hwif entries use the generic stmmac_ptp hwtimestamp ops,
whose timestamp_interrupt callback reads the dwmac4 register instead of
the XGMAC one and whose enable mask omits XGMAC_TSIE.  The PTP clock
still advertises the auxiliary snapshot channels, so PTP_EXTTS_REQUEST
succeeds but no PTP_CLOCK_EXTTS event is ever delivered.

Add a DWXGMAC2 handler that reads XGMAC_TIMESTAMP_STATUS and reports
the pending auxiliary snapshots as PTP_CLOCK_EXTTS events.  It
deliberately does not gate on XGMAC_INT_TSIS: TSIS is an aggregate,
read-to-clear bit that the TX timestamp completion path clears before
the handler can observe it, while the ATSNS count and the FIFO still
hold the events, so a dwmac4-style TSIS gate would drop them.

XGMAC_TSIE is not re-added to XGMAC_INT_DEFAULT_EN.  It is armed on
demand from the PTP_CLK_REQ_EXTTS enable/disable path through a new
optional stmmac_ops->timestamp_interrupt_cfg() callback implemented
only for DWXGMAC2/DWXLGMAC2, since stmmac_enable() is shared with
dwmac4/dwmac5, whose timestamp interrupt stays always-enabled and is
relied upon by intel_crosststamp().

The handler drains the FIFO only while XGMAC_TSIE is enabled: it runs
on every MAC interrupt, and PTP_ACR_ATSFC is only ever set while
XGMAC_TSIE is disabled, so this both keeps it off the FIFO on unrelated
interrupts and stops it racing a FIFO flush.  The interrupt is armed
only after the FIFO clear has completed, with aux_ts_lock held across
the whole enable so the arm cannot interleave with a concurrent suspend.
A failed enable is rolled back in hardware and software, leaving the
interrupt disarmed.

While an internal cross-timestamp owns the FIFO
(STMMAC_FLAG_INT_SNAPSHOT_EN, raised and dropped under aux_ts_lock),
the handler only clears the interrupt source.  smtg_crosststamp() calls
stmmac_sync_timestamp_irq() after raising the flag and the disable path
calls it after disarming, so no handler that is already past its check
can still use the FIFO.

aux_ts_lock is initialised in probe and destroyed in remove, so it is
valid for the whole device lifetime.  At unregister the clock is
invalidated under the lock before ptp_clock_unregister(), after which
the enable path and smtg_crosststamp() refuse to arm.

On resume stmmac_rearm_timestamp_irq() reprograms the enabled channel
under aux_ts_lock and re-arms the interrupt only if the FIFO flush
completed; otherwise, and whenever the timestamping setup cannot be
redone, the EXTTS state is dropped rather than advertised.
stmmac_suspend() disarms the interrupt and drains an in-flight handler
under aux_ts_lock before the clocks are gated.

Fixes: 4bb7aff9e6d0 ("net: stmmac: Add PTP support for XGMAC2")
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  16 +++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  61 ++++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   5 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   1 +
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c |  12 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 106 +++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  68 ++++++++---
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.h  |   2 +
 include/linux/stmmac.h                        |   1 +
 10 files changed, 258 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index ee79b74bf21b..93c1092237fc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -311,6 +311,18 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		return -EBUSY;
 
 	mutex_lock(&priv->aux_ts_lock);
+	/* Refuse to arm once the clock has been invalidated by
+	 * unregister.
+	 */
+	if (!priv->ptp_clock) {
+		mutex_unlock(&priv->aux_ts_lock);
+		return -ENODEV;
+	}
+	priv->plat->flags |= STMMAC_FLAG_INT_SNAPSHOT_EN;
+	/* Wait for a handler that is already past the flag check before
+	 * taking over the snapshot FIFO.
+	 */
+	stmmac_sync_timestamp_irq(priv);
 	/* Enable Internal snapshot trigger */
 	acr_value = readl(ptpaddr + PTP_ACR);
 	acr_value &= ~PTP_ACR_MASK;
@@ -328,6 +340,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		acr_value |= PTP_ACR_ATSEN3;
 		break;
 	default:
+		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 		mutex_unlock(&priv->aux_ts_lock);
 		return -EINVAL;
 	}
@@ -344,6 +357,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	ret = readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,
 				 !(acr_value & PTP_ACR_ATSFC), 10, 10000);
 	if (ret) {
+		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 		mutex_unlock(&priv->aux_ts_lock);
 		netdev_err(priv->dev, "%s: Failed to clear snapshot FIFO\n",
 			   __func__);
@@ -366,6 +380,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 				 FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, v),
 				 100, 10000);
 	if (ret) {
+		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 		mutex_unlock(&priv->aux_ts_lock);
 		netdev_err(priv->dev, "%s: Wait for time sync operation timeout\n",
 			   __func__);
@@ -388,6 +403,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		read_unlock_irqrestore(&priv->ptp_lock, flags);
 	}
 
+	priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 	mutex_unlock(&priv->aux_ts_lock);
 
 	get_smtgtime(priv->mii, SMTG_MDIO_ADDR, &smtg_time);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 1a88cbaed70c..3b98cd82ec2d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -42,6 +42,12 @@ static void dwxgmac2_irq_modify(struct mac_device_info *hw, u32 disable,
 	spin_unlock_irqrestore(&hw->irq_ctrl_lock, flags);
 }
 
+static void dwxgmac2_timestamp_interrupt_cfg(struct stmmac_priv *priv, bool en)
+{
+	stmmac_mac_irq_modify(priv, en ? 0 : XGMAC_TSIE,
+			      en ? XGMAC_TSIE : 0);
+}
+
 static void dwxgmac2_update_caps(struct stmmac_priv *priv)
 {
 	if (!priv->dma_cap.mbps_10_100)
@@ -1154,6 +1160,59 @@ static int dwxgmac2_get_mac_tx_timestamp(struct mac_device_info *hw, u64 *ts)
 	return 0;
 }
 
+void dwxgmac2_timestamp_interrupt(struct stmmac_priv *priv)
+{
+	u32 ts_status, pending_snapshots, acr_value, channel;
+	struct ptp_clock_event event;
+	unsigned long flags;
+	u64 ptp_time;
+	int i;
+
+	/* Runs on every MAC interrupt: only touch the FIFO when the
+	 * timestamp interrupt was armed, and leave it to the
+	 * cross-timestamp path while that owns it.
+	 */
+	if (priv->plat->flags & STMMAC_FLAG_INT_SNAPSHOT_EN) {
+		readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);
+		return;
+	}
+
+	if (!(readl(priv->ioaddr + XGMAC_INT_EN) & XGMAC_TSIE))
+		return;
+
+	/* Reading XGMAC_TIMESTAMP_STATUS clears TSIS, so use the ATSNS
+	 * count to see the pending snapshots.
+	 */
+	ts_status = readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);
+
+	if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN) || !priv->ptp_clock)
+		return;
+
+	pending_snapshots = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, ts_status);
+	if (!pending_snapshots)
+		return;
+
+	acr_value = readl(priv->ptpaddr + PTP_ACR);
+	/* Entries observed while the FIFO is being flushed are stale. */
+	if (acr_value & PTP_ACR_ATSFC)
+		return;
+	channel = FIELD_GET(PTP_ACR_MASK, acr_value);
+	if (!channel)
+		return;
+	channel = ilog2(channel);
+
+	for (i = 0; i < pending_snapshots; i++) {
+		read_lock_irqsave(&priv->ptp_lock, flags);
+		stmmac_get_ptptime(priv, priv->ptpaddr, &ptp_time);
+		read_unlock_irqrestore(&priv->ptp_lock, flags);
+
+		event.type = PTP_CLOCK_EXTTS;
+		event.index = channel;
+		event.timestamp = ptp_time;
+		ptp_clock_event(priv->ptp_clock, &event);
+	}
+}
+
 static int dwxgmac2_flex_pps_config(void __iomem *ioaddr, int index,
 				    struct stmmac_pps_cfg *cfg, bool enable,
 				    u32 sub_second_inc, u32 systime_flags)
@@ -1413,6 +1472,7 @@ static int dwxgmac2_config_l4_filter(struct mac_device_info *hw, u32 filter_no,
 const struct stmmac_ops dwxgmac210_ops = {
 	.core_init = dwxgmac2_core_init,
 	.irq_modify = dwxgmac2_irq_modify,
+	.timestamp_interrupt_cfg = dwxgmac2_timestamp_interrupt_cfg,
 	.update_caps = dwxgmac2_update_caps,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
@@ -1468,6 +1528,7 @@ static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
 const struct stmmac_ops dwxlgmac2_ops = {
 	.core_init = dwxgmac2_core_init,
 	.irq_modify = dwxgmac2_irq_modify,
+	.timestamp_interrupt_cfg = dwxgmac2_timestamp_interrupt_cfg,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
 	.rx_queue_enable = dwxlgmac2_rx_queue_enable,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 265671170bf6..eba87410f985 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -258,7 +258,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwxgmac210_dma_ops,
 		.mac = &dwxgmac210_ops,
 		.vlan = &dwxgmac210_vlan_ops,
-		.hwtimestamp = &stmmac_ptp,
+		.hwtimestamp = &dwxgmac2_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
 		.tc = &dwmac510_tc_ops,
@@ -280,7 +280,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwxgmac210_dma_ops,
 		.mac = &dwxlgmac2_ops,
 		.vlan = &dwxlgmac2_vlan_ops,
-		.hwtimestamp = &stmmac_ptp,
+		.hwtimestamp = &dwxgmac2_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
 		.tc = &dwmac510_tc_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 2e63614d93a4..498529433d2c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -317,6 +317,8 @@ struct stmmac_ops {
 	void (*update_caps)(struct stmmac_priv *priv);
 	/* Change the interrupt enable setting. Enable takes precedence. */
 	void (*irq_modify)(struct mac_device_info *hw, u32 disable, u32 enable);
+	/* Arm or disarm the timestamp interrupt on demand (optional) */
+	void (*timestamp_interrupt_cfg)(struct stmmac_priv *priv, bool en);
 	/* Enable the MAC RX/TX */
 	void (*set_mac)(void __iomem *ioaddr, bool enable);
 	/* Enable and verify that the IPC module is supported */
@@ -420,6 +422,8 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, update_caps, __priv)
 #define stmmac_mac_irq_modify(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, irq_modify, (__priv)->hw, __args)
+#define stmmac_mac_timestamp_interrupt_cfg(__priv, __args...) \
+	stmmac_do_void_callback(__priv, mac, timestamp_interrupt_cfg, __priv, __args)
 #define stmmac_mac_set(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, set_mac, __args)
 #define stmmac_rx_ipc(__priv, __args...) \
@@ -672,6 +676,7 @@ extern const struct stmmac_desc_ops ndesc_ops;
 
 extern const struct stmmac_hwtimestamp stmmac_ptp;
 extern const struct stmmac_hwtimestamp dwmac1000_ptp;
+extern const struct stmmac_hwtimestamp dwxgmac2_ptp;
 
 extern const struct stmmac_mode_ops ring_mode_ops;
 extern const struct stmmac_mode_ops chain_mode_ops;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 08b68441f9c8..06d687697e76 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -408,6 +408,7 @@ int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
 void stmmac_mdio_lock(struct stmmac_priv *priv);
 void stmmac_mdio_unlock(struct stmmac_priv *priv);
+void stmmac_sync_timestamp_irq(struct stmmac_priv *priv);
 int stmmac_pcs_setup(struct net_device *ndev);
 void stmmac_pcs_clean(struct net_device *ndev);
 void stmmac_set_ethtool_ops(struct net_device *netdev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 2a076e228e9a..4b906bc33d26 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -280,3 +280,15 @@ const struct stmmac_hwtimestamp dwmac1000_ptp = {
 	.get_ptptime = dwmac1000_get_ptptime,
 	.timestamp_interrupt = dwmac1000_timestamp_interrupt,
 };
+
+const struct stmmac_hwtimestamp dwxgmac2_ptp = {
+	.config_hw_tstamping = config_hw_tstamping,
+	.init_systime = init_systime,
+	.config_sub_second_increment = config_sub_second_increment,
+	.config_addend = config_addend,
+	.adjust_systime = adjust_systime,
+	.get_systime = get_systime,
+	.get_ptptime = get_ptptime,
+	.timestamp_interrupt = dwxgmac2_timestamp_interrupt,
+	.hwtstamp_correct_latency = hwtstamp_correct_latency,
+};
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 56d89a696272..c22f3dd40fca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/skbuff.h>
@@ -894,6 +895,88 @@ static int stmmac_init_ptp_clk_freq(struct stmmac_priv *priv)
 	return 0;
 }
 
+/**
+ * stmmac_sync_timestamp_irq - wait for an in-flight timestamp handler
+ * @priv: driver private structure
+ * Description: called after the timestamp interrupt has been disarmed or
+ * handed over, to make sure a handler that is already past its checks has
+ * finished before the caller takes over the auxiliary snapshot FIFO.
+ */
+void stmmac_sync_timestamp_irq(struct stmmac_priv *priv)
+{
+	synchronize_irq(priv->dev->irq);
+	if (priv->wol_irq > 0 && priv->wol_irq != priv->dev->irq)
+		synchronize_irq(priv->wol_irq);
+}
+EXPORT_SYMBOL_GPL(stmmac_sync_timestamp_irq);
+
+/**
+ * stmmac_drop_extts_state - drop the recorded EXTTS channel
+ * @priv: driver private structure
+ * Description: clears the software EXTTS state so the PTP clock stops
+ * advertising a channel whose interrupt can no longer be armed.
+ */
+static void stmmac_drop_extts_state(struct stmmac_priv *priv)
+{
+	mutex_lock(&priv->aux_ts_lock);
+	priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
+	priv->plat->ext_snapshot_num = -1;
+	mutex_unlock(&priv->aux_ts_lock);
+}
+
+/**
+ * stmmac_rearm_timestamp_irq - re-arm the timestamp interrupt
+ * @priv: driver private structure
+ * Description: this re-arms the on-demand timestamp interrupt if an
+ * auxiliary snapshot channel was left enabled.
+ */
+static void stmmac_rearm_timestamp_irq(struct stmmac_priv *priv)
+{
+	u32 acr_value;
+	int ret, num;
+
+	if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN) ||
+	    !priv->ptp_clock)
+		return;
+
+	/* Flush the FIFO, re-program the enabled auxiliary snapshot
+	 * trigger and re-arm the interrupt only if the flush completed.
+	 */
+	if (priv->plat->core_type != DWMAC_CORE_XGMAC)
+		return;
+
+	mutex_lock(&priv->aux_ts_lock);
+	/* Snapshot the channel under the lock: a concurrent disable may
+	 * have cleared it.
+	 */
+	num = priv->plat->ext_snapshot_num;
+	if (num < 0) {
+		mutex_unlock(&priv->aux_ts_lock);
+		return;
+	}
+	acr_value = readl(priv->ptpaddr + PTP_ACR);
+	acr_value &= ~PTP_ACR_MASK;
+	acr_value |= PTP_ACR_ATSFC;
+	writel(acr_value, priv->ptpaddr + PTP_ACR);
+	ret = readl_poll_timeout(priv->ptpaddr + PTP_ACR, acr_value,
+				 !(acr_value & PTP_ACR_ATSFC), 10, 10000);
+	if (!ret) {
+		acr_value |= PTP_ACR_ATSEN(num);
+		writel(acr_value, priv->ptpaddr + PTP_ACR);
+		stmmac_mac_timestamp_interrupt_cfg(priv, true);
+	} else {
+		/* The trigger could not be restored, so drop the software
+		 * state rather than advertise a dead channel.
+		 */
+		priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
+		priv->plat->ext_snapshot_num = -1;
+		netdev_err(priv->dev,
+			   "%s: Failed to restore auxiliary snapshot channel\n",
+			   __func__);
+	}
+	mutex_unlock(&priv->aux_ts_lock);
+}
+
 /**
  * stmmac_init_timestamping - initialise timestamping
  * @priv: driver private structure
@@ -8191,6 +8274,7 @@ static int __stmmac_dvr_probe(struct device *device,
 	stmmac_napi_add(ndev);
 
 	mutex_init(&priv->lock);
+	mutex_init(&priv->aux_ts_lock);
 	rwlock_init(&priv->ptp_lock);
 
 	stmmac_fpe_init(priv);
@@ -8324,6 +8408,7 @@ void stmmac_dvr_remove(struct device *dev)
 
 	destroy_workqueue(priv->wq);
 	mutex_destroy(&priv->lock);
+	mutex_destroy(&priv->aux_ts_lock);
 	bitmap_free(priv->af_xdp_zc_qps);
 
 	pm_runtime_disable(dev);
@@ -8378,6 +8463,17 @@ int stmmac_suspend(struct device *dev)
 		pinctrl_pm_select_sleep_state(priv->device);
 	}
 
+	/* Disarm the timestamp interrupt while suspended and drain an
+	 * in-flight handler before the clocks are gated;
+	 * stmmac_rearm_timestamp_irq() restores it on resume.
+	 */
+	mutex_lock(&priv->aux_ts_lock);
+	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN) {
+		stmmac_mac_timestamp_interrupt_cfg(priv, false);
+		stmmac_sync_timestamp_irq(priv);
+	}
+	mutex_unlock(&priv->aux_ts_lock);
+
 	mutex_unlock(&priv->lock);
 
 	rtnl_lock();
@@ -8497,12 +8593,18 @@ int stmmac_resume(struct device *dev)
 	}
 
 	if (priv->ptp_enabled) {
-		if (stmmac_init_ptp_clk_freq(priv))
+		if (stmmac_init_ptp_clk_freq(priv)) {
+			stmmac_drop_extts_state(priv);
 			goto init_coalesce;
+		}
 
 		ret = stmmac_init_timestamping(priv);
-		if (ret)
+		if (ret) {
+			stmmac_drop_extts_state(priv);
 			goto error_stop_dma;
+		}
+
+		stmmac_rearm_timestamp_irq(priv);
 	}
 
 init_coalesce:
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 3bfcc9760dce..f41988f5927a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -226,6 +226,13 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 		u8 channel;
 
 		mutex_lock(&priv->aux_ts_lock);
+		/* Refuse to arm once the clock has been invalidated by
+		 * unregister.
+		 */
+		if (!priv->ptp_clock) {
+			mutex_unlock(&priv->aux_ts_lock);
+			return -ENODEV;
+		}
 		acr_value = readl(ptpaddr + PTP_ACR);
 		channel = ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
 		acr_value &= ~PTP_ACR_MASK;
@@ -239,22 +246,49 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 				return -EBUSY;
 			}
 
+			if (rq->extts.index >= PTP_ACR_ATSEN_NUM) {
+				mutex_unlock(&priv->aux_ts_lock);
+				return -EINVAL;
+			}
+
 			priv->plat->flags |= STMMAC_FLAG_EXT_SNAPSHOT_EN;
+			priv->plat->ext_snapshot_num = rq->extts.index;
 
 			/* Enable External snapshot trigger */
 			acr_value |= PTP_ACR_ATSEN(rq->extts.index);
 			acr_value |= PTP_ACR_ATSFC;
 		} else {
 			priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
+			priv->plat->ext_snapshot_num = -1;
 		}
 		netdev_dbg(priv->dev, "Auxiliary Snapshot %d %s.\n",
 			   rq->extts.index, on ? "enabled" : "disabled");
 		writel(acr_value, ptpaddr + PTP_ACR);
-		mutex_unlock(&priv->aux_ts_lock);
-		/* wait for auxts fifo clear to finish */
+		/* Keep the lock across the FIFO clear so the arm below
+		 * cannot interleave with a suspend.
+		 */
 		ret = readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,
 					 !(acr_value & PTP_ACR_ATSFC),
 					 10, 10000);
+		if (ret && on) {
+			/* Roll the failed enable back so no half-enabled
+			 * channel is left.
+			 */
+			acr_value = readl(ptpaddr + PTP_ACR);
+			acr_value &= ~PTP_ACR_ATSEN(rq->extts.index);
+			writel(acr_value, ptpaddr + PTP_ACR);
+			priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
+			priv->plat->ext_snapshot_num = -1;
+		}
+		/* Arm the timestamp interrupt only after the FIFO clear,
+		 * so the handler cannot see a snapshot that is about to be
+		 * discarded.
+		 */
+		stmmac_mac_timestamp_interrupt_cfg(priv, on && !ret);
+		/* Drain an in-flight handler before the channel is freed. */
+		if (!on)
+			stmmac_sync_timestamp_irq(priv);
+		mutex_unlock(&priv->aux_ts_lock);
 		break;
 	}
 
@@ -355,7 +389,7 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 	if (pps_out_num)
 		priv->ptp_clock_ops.n_per_out = pps_out_num;
 
-	n_ext_ts = priv->dma_cap.aux_snapshot_n;
+	n_ext_ts = min(priv->dma_cap.aux_snapshot_n, PTP_ACR_ATSEN_NUM);
 	if (n_ext_ts)
 		priv->ptp_clock_ops.n_ext_ts = n_ext_ts;
 
@@ -365,8 +399,6 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 	if (priv->plat->crosststamp)
 		priv->ptp_clock_ops.getcrosststamp = stmmac_getcrosststamp;
 
-	mutex_init(&priv->aux_ts_lock);
-
 	priv->ptp_clock = ptp_clock_register(&priv->ptp_clock_ops,
 					     priv->device);
 	if (IS_ERR(priv->ptp_clock)) {
@@ -376,8 +408,6 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 
 	if (priv->ptp_clock)
 		netdev_info(priv->dev, "registered PTP clock\n");
-	else
-		mutex_destroy(&priv->aux_ts_lock);
 }
 
 /**
@@ -388,12 +418,22 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
  */
 void stmmac_ptp_unregister(struct stmmac_priv *priv)
 {
-	if (priv->ptp_clock) {
-		ptp_clock_unregister(priv->ptp_clock);
-		priv->ptp_clock = NULL;
-		pr_debug("Removed PTP HW clock successfully on %s\n",
-			 priv->dev->name);
+	struct ptp_clock *clock;
 
-		mutex_destroy(&priv->aux_ts_lock);
-	}
+	if (!priv->ptp_clock)
+		return;
+
+	/* Tear the hardware state down and invalidate the clock before
+	 * releasing the lock, so a concurrent request cannot re-arm a
+	 * clock that is going away.
+	 */
+	mutex_lock(&priv->aux_ts_lock);
+	clock = priv->ptp_clock;
+	priv->ptp_clock = NULL;
+	stmmac_mac_timestamp_interrupt_cfg(priv, false);
+	priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
+	mutex_unlock(&priv->aux_ts_lock);
+
+	ptp_clock_unregister(clock);
+	pr_debug("Removed PTP HW clock successfully on %s\n", priv->dev->name);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
index 3fe0e3a80e80..a2082e1299b8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
@@ -81,6 +81,7 @@
 #define	PTP_ACR_ATSEN3		BIT(7)	/* Auxiliary Snapshot 3 Enable */
 #define	PTP_ACR_ATSEN(index)	(PTP_ACR_ATSEN0 << (index))
 #define	PTP_ACR_MASK		GENMASK(7, 4)	/* Aux Snapshot Mask */
+#define	PTP_ACR_ATSEN_NUM	4	/* Aux Snapshot 0-3 */
 #define	PMC_ART_VALUE0		0x01	/* PMC_ART[15:0] timer value */
 #define	PMC_ART_VALUE1		0x02	/* PMC_ART[31:16] timer value */
 #define	PMC_ART_VALUE2		0x03	/* PMC_ART[47:32] timer value */
@@ -103,6 +104,7 @@ int dwmac1000_ptp_enable(struct ptp_clock_info *ptp,
 
 void dwmac1000_get_ptptime(void __iomem *ptpaddr, u64 *ptp_time);
 void dwmac1000_timestamp_interrupt(struct stmmac_priv *priv);
+void dwxgmac2_timestamp_interrupt(struct stmmac_priv *priv);
 
 extern const struct ptp_clock_info stmmac_ptp_clock_ops;
 extern const struct ptp_clock_info dwmac1000_ptp_clock_ops;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 00be2df63d22..487dd492c4b1 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -351,6 +351,7 @@ struct plat_stmmacenet_data {
 	u8 vlan_fail_q;
 	bool provide_bus_info;
 	int int_snapshot_num;
+	int ext_snapshot_num;
 	int msi_mac_vec;
 	int msi_wol_vec;
 	int msi_sfty_ce_vec;
-- 
2.34.1

