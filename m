Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431CC43F0A6
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115589; cv=none; b=i1HyUrEoyRY5hcdc1KAySpKJaTMppSmvQmPb3HdFiuDAUFunJtKhl0uOomS/0F1i0wsCj7OVuc1663cN1KZG6GydK71t35rVvT1E0axwSAuCiNugUr35QWhOCeQuiLUge9vEic9GcXaD9aJ68nCBQWv9T0YGxY3twtlwnkNt7w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115589; c=relaxed/simple;
	bh=PPxfipGK6cBbIQzgHssUqjSUy6JQtvFPOzIqnMz90Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IombGNvMjqJVt6b4Nm806gQ9tLWTbNysS24yarwHPxYNgl3bEsSMOiXD9TfGduitjtuM+/UwcyXS5L4C5IcP3HsHJ/DLQGKgB5py1leGZQNOyCbMgUNugJzuNgFVIYYZiYF1bHIXqYy9WeDyEndQC79tz9jsqGoU4k2AcFbUrWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8AuMO1E; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8AuMO1E"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-398a5aad413so494105a91.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 05:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791115582; x=1791720382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HoUsQCnpzAhkZBf0cjpcTuGjeYvtMj/bviuftqvYWbk=;
        b=m8AuMO1EwIZ0zLKyNDqaZ+PnAf47OxJMDbmkHjGfSubIEyiJYhsGw4q8B6ZIloH2VE
         bHkIQWCOUIX5oF3gUwk+H/+v7SzJtTGTyqPP91cLzaVqizedQlekve4AvRGgK91uCe61
         MGC1pQbolRlbSePV+B4puKUeVYsc7XOSjZyxIb7F4rvuP+4HUZ3OwGexuur2Q3TzeFNz
         OSRGJKjDFUzMD5erNv6DgTdwYLA1cb/jBey61/m+MCVk4x5TuAvT8Ya1SYUjfhEgTCb2
         sEapzwus+Jbc2IbVKZZGPhRAmNfmn2u2NgcvcPxJPZ1gt1jioia0z8CJ7HZwCkb39jK/
         rDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791115582; x=1791720382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HoUsQCnpzAhkZBf0cjpcTuGjeYvtMj/bviuftqvYWbk=;
        b=fCaJ66UZWpYT0lubUIzXFe8+QYHvMGEBg17hT5z2NSKzmuk/Yto+eUMB6VWgbW3yW7
         aSgKo8PvVeLn6fvEDzFnOGIq9cuiyQ2FpJWddI4PrflUCGoKBcr0KikeT2IE8JLJQH7n
         7rlrou94V+DXa2bzfKMsFUF0uL62TYmtbwUK/nw9z4CJhBMaNQ4RrQal7TRGm3f2NS59
         keeHuYwOZj7w5lGnsxdcEceWNXyuhYBVHOh7k74zjUmNV3ImNk1T/B2qnU0qnrcGui2S
         ZpFVKWQS56KtEN703IlqeHRQzyQcmVLpp7g/JS+9tj4fM/55H0kgfND9mzcAecCJF/td
         AzzA==
X-Forwarded-Encrypted: i=1; AKwUvBwkVY86mnH0HUkIUZwqKOvE2vsu0DZOyA3mjFx8Lp4CNy1tAhcu/ALjcY6Ohs+EBRAAAcYb/bo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEydJqFaWI0GhVC1OwWYwB5mObA1iqmL4AVxgUtD/QPiGBuRTi
	OrRgZZPC9g22jvqYD3AZrspoXOSzamVRMTQ58HURhgAVMVZ3CcC2WiWd
X-Gm-Gg: AYBFou3VvNkulbO4tjtDucApeSrUnT79paTLKmRTyqnrd/DPcAuyx/dC8os5UAP+IMr
	7R5ZC1Pocfv1SbLj7PhETpLwTHmR6y6csQqFIJRb9qv1BplxUQYA0/hM090Dlw965fOE2onMUp+
	uGs3e1TV7KJChSjNKwvPFS4QbDQoLX4GKSiHnkPOjnmoNVMlc2Bp8TS4dpyAIu1qzj1k5Y6lSLe
	vY9nbyFxx6K9PIIad6wDYASRUE+mW7BljyaBH4GCo/S565xfeOaWSCB64geDN8mC+nXIDduFdF2
	+f3WxlETu+lgc8dWzFm7IwbNFzSFvNd+miB9vaTy0cI9pxzvg0ffSoRVhAy2VmlygM7VSeR67D4
	lc4OELOidxuCvRhBuOuOlJ+NbM8VCxpzv41rki4HuQpBU3amGvRWOtmrJJ4EB/FZkOrsBYwDs2h
	ToRxUmsbnx8CiGdY/flJDpyDXboM86LKU3r+sO4kE/ngKFCbxAJhURpBqao/WLrHXux8KLfA==
X-Received: by 2002:a17:90b:4b10:b0:3a7:db88:3495 with SMTP id 98e67ed59e1d1-3a7db883cc2mr906806a91.52.1791115582211;
        Sun, 04 Oct 2026 05:06:22 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a79e7c243csm2603661a91.0.2026.10.04.05.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 05:06:21 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	maxime.chevallier@bootlin.com,
	muhammad.nazim.amirul.nazle.asmade@altera.com,
	rohan.g.thomas@altera.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net-next v7 3/3] net: stmmac: dwxgmac2: add XGMAC timestamp interrupt support
Date: Sun,  4 Oct 2026 20:05:26 +0800
Message-Id: <20261004120526.2728564-4-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261004120526.2728564-1-zxyan0222@gmail.com>
References: <20261004120526.2728564-1-zxyan0222@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DWXGMAC2 hwif entries use the generic stmmac_ptp hwtimestamp ops,
whose timestamp_interrupt callback reads the dwmac4 offset
GMAC_TIMESTAMP_STATUS (0xb20) instead of the XGMAC register at 0xd20,
and whose interrupt enable mask XGMAC_INT_DEFAULT_EN omits XGMAC_TSIE.
The PTP clock nevertheless advertises the auxiliary snapshot channels
on XGMAC, so PTP_EXTTS_REQUEST succeeds but no PTP_CLOCK_EXTTS event is
ever delivered.

Fix this with a dedicated DWXGMAC2 timestamp interrupt handler that
reads XGMAC_TIMESTAMP_STATUS and reports the pending auxiliary
snapshots as PTP_CLOCK_EXTTS events.  The handler deliberately does
not gate its status read on XGMAC_INT_TSIS: TSIS is an aggregate,
read-to-clear bit that the TX timestamp completion path (which polls
the same register for TXTSC) clears before the handler can observe
it, while ATSNS and the snapshot FIFO still hold the aux events.  A
dwmac4-style TSIS gate would silently drop them.

XGMAC_TSIE is not added back to XGMAC_INT_DEFAULT_EN, which
30300d9f9150 ("net: stmmac: xgmac: Disable the Timestamp interrupt by
default") deliberately keeps clear.  Instead it is armed on demand from
the PTP_CLK_REQ_EXTTS enable/disable path of stmmac_enable(), through a
new optional stmmac_ops->timestamp_interrupt_cfg() callback implemented
only for DWXGMAC2/DWXLGMAC2 (on top of dwxgmac2_irq_modify()), like
dwmac1000 does with dwmac1000_timestamp_interrupt_cfg().  This keeps
platforms that do not use EXTTS at their current interrupt load and
leaves the other cores untouched: stmmac_enable() is shared with
dwmac4/dwmac5, whose timestamp interrupt stays always-enabled and is
relied upon by intel_crosststamp(), so a direct irq_modify() call
there is not an option; cores that do not implement the callback keep
their current behaviour.

The interrupt is only touched after the PTP_ACR_ATSFC FIFO clear has
completed, and the handler refuses to drain entries while that clear
is still in flight, so a stale snapshot is never reported as an event;
if the clear times out, the error is returned without changing the
interrupt state.  The handler also leaves the snapshot FIFO alone
while an internal cross-timestamp owns it: smtg_crosststamp() sets
STMMAC_FLAG_INT_SNAPSHOT_EN for the duration of the cross-timestamp,
raised and dropped under aux_ts_lock so concurrent requests cannot
lose it, and the handler then only clears the interrupt source,
mirroring the dwmac4 handler's treatment of intel_crosststamp().

The timestamp interrupt is also disarmed after ptp_clock_unregister(),
which drops STMMAC_FLAG_EXT_SNAPSHOT_EN as well.

On resume stmmac_rearm_timestamp_irq() redoes the EXTTS programming
stmmac_enable() performed on XGMAC: stmmac_hw_setup() reprograms
XGMAC_INT_EN from XGMAC_INT_DEFAULT_EN, which drops XGMAC_TSIE, and a
platform init callback may have reset the MAC and dropped the PTP_ACR
trigger as well.  It flushes the FIFO and re-programs the enabled
auxiliary snapshot trigger (recorded in ext_snapshot_num by
stmmac_enable()) under aux_ts_lock, re-validates the channel there,
and re-arms the interrupt only if the flush completed.

Fixes: 4bb7aff9e6d0 ("net: stmmac: Add PTP support for XGMAC2")
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  5 ++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 59 +++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  5 ++
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 12 ++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 51 ++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 23 +++++++-
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.h  |  2 +
 include/linux/stmmac.h                        |  1 +
 9 files changed, 159 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index c5f71bfc7cf4..9030cc1cc677 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -311,6 +311,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		return -EBUSY;
 
 	mutex_lock(&priv->aux_ts_lock);
+	priv->plat->flags |= STMMAC_FLAG_INT_SNAPSHOT_EN;
 	/* Enable Internal snapshot trigger */
 	acr_value = readl(ptpaddr + PTP_ACR);
 	acr_value &= ~PTP_ACR_MASK;
@@ -328,6 +329,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		acr_value |= PTP_ACR_ATSEN3;
 		break;
 	default:
+		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 		mutex_unlock(&priv->aux_ts_lock);
 		return -EINVAL;
 	}
@@ -344,6 +346,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	ret = readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,
 				 !(acr_value & PTP_ACR_ATSFC), 10, 10000);
 	if (ret) {
+		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 		mutex_unlock(&priv->aux_ts_lock);
 		netdev_err(priv->dev, "%s: Failed to clear snapshot FIFO\n",
 			   __func__);
@@ -368,6 +371,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 				 FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, v),
 				 100, 10000);
 	if (ret) {
+		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 		mutex_unlock(&priv->aux_ts_lock);
 		netdev_err(priv->dev, "%s: Wait for time sync operation timeout\n",
 			   __func__);
@@ -390,6 +394,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		read_unlock_irqrestore(&priv->ptp_lock, flags);
 	}
 
+	priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 	mutex_unlock(&priv->aux_ts_lock);
 
 	get_smtgtime(priv->mii, SMTG_MDIO_ADDR, &smtg_time);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 1a88cbaed70c..313c24e9a49d 100644
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
@@ -1154,6 +1160,57 @@ static int dwxgmac2_get_mac_tx_timestamp(struct mac_device_info *hw, u64 *ts)
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
+	if (priv->plat->flags & STMMAC_FLAG_INT_SNAPSHOT_EN) {
+		/* Read the status to clear the timestamp interrupt source;
+		 * the FIFO belongs to the cross-timestamp path.
+		 */
+		readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);
+		return;
+	}
+
+	/* Reading XGMAC_TIMESTAMP_STATUS clears the TSIS and AUXTSTRIG
+	 * bits, so the ATSNS count is the only reliable indication of
+	 * pending auxiliary snapshots.  TXTSC is cleared by
+	 * XGMAC_TXTIMESTAMP_SEC and is not affected by this read.
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
@@ -1413,6 +1470,7 @@ static int dwxgmac2_config_l4_filter(struct mac_device_info *hw, u32 filter_no,
 const struct stmmac_ops dwxgmac210_ops = {
 	.core_init = dwxgmac2_core_init,
 	.irq_modify = dwxgmac2_irq_modify,
+	.timestamp_interrupt_cfg = dwxgmac2_timestamp_interrupt_cfg,
 	.update_caps = dwxgmac2_update_caps,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
@@ -1468,6 +1526,7 @@ static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
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
index a8a5c8fdd5ed..14a47d68399f 100644
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
index 3ad9252bf6ae..53aaf2716c46 100644
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
@@ -894,6 +895,54 @@ static int stmmac_init_ptp_clk_freq(struct stmmac_priv *priv)
 	return 0;
 }
 
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
+	 * have dropped it since the gate check above.
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
@@ -8418,6 +8467,8 @@ int stmmac_resume(struct device *dev)
 		ret = stmmac_init_timestamping(priv);
 		if (ret)
 			goto error_stop_dma;
+
+		stmmac_rearm_timestamp_irq(priv);
 	}
 
 init_coalesce:
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 3bfcc9760dce..19fa79839e46 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -239,13 +239,20 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
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
@@ -255,6 +262,17 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 		ret = readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,
 					 !(acr_value & PTP_ACR_ATSFC),
 					 10, 10000);
+		/* Arm or disarm the timestamp interrupt only once the FIFO
+		 * clear has completed, so the handler does not observe a
+		 * snapshot that the clear is about to discard.
+		 */
+		if (!ret) {
+			stmmac_mac_timestamp_interrupt_cfg(priv, on);
+		} else if (on) {
+			mutex_lock(&priv->aux_ts_lock);
+			priv->plat->ext_snapshot_num = -1;
+			mutex_unlock(&priv->aux_ts_lock);
+		}
 		break;
 	}
 
@@ -355,7 +373,7 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 	if (pps_out_num)
 		priv->ptp_clock_ops.n_per_out = pps_out_num;
 
-	n_ext_ts = priv->dma_cap.aux_snapshot_n;
+	n_ext_ts = min(priv->dma_cap.aux_snapshot_n, PTP_ACR_ATSEN_NUM);
 	if (n_ext_ts)
 		priv->ptp_clock_ops.n_ext_ts = n_ext_ts;
 
@@ -394,6 +412,9 @@ void stmmac_ptp_unregister(struct stmmac_priv *priv)
 		pr_debug("Removed PTP HW clock successfully on %s\n",
 			 priv->dev->name);
 
+		stmmac_mac_timestamp_interrupt_cfg(priv, false);
+		priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
+
 		mutex_destroy(&priv->aux_ts_lock);
 	}
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

