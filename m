Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65690380FC5
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356160; cv=none; b=WclPCdeaVemDTgzxAjkozfD6gV7aHnbGovnIcSlgH/Q8VHQ3m3zGCqMunYxHgNy+MzoWXkDTnDVRsOnMuSlMtb2fcTizjMHYD7YGdAzteJ4G87cz7wG5jYcNOR9SGM6j8uuucOeWMD7haaQVpQg8cbn+zgzLtWbHdcLeTRggZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356160; c=relaxed/simple;
	bh=vVC6bFqLBN+Sc3MqkzfB4gj/onQ/NGJNYg/RvyeI9X0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kQlpkKOLdI7a7ekZnysnGRld6gKV+nkHgl56KF3l005Gg73fwtl0m4aesreJNKuMjDv4KaAg+EFmjzNLHGfgWO2YcUBgBzTbg1H3PguSJeaGDeBTIpfF51q5Jh9y5EjlcdhdWTRQF86nfdQFAyRC7AWAz5wxnETpCEi7XJSeSSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lx5Wrsk0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lx5Wrsk0"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1513956b3a.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 03:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786356155; x=1786960955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0wEYkzBcMdzXW3DkDjCq2S2tZx0eg9Z7Yp+aB3llSto=;
        b=lx5Wrsk0Iz9G36FNVXDwOYKDW7Tpwc36vv1F9/8yQXixqfl61J1ZR/KZg9yKYuNrMp
         ZvCbc7xTqTGVi5TVHrj5KeeMlmeH5jV38TFJBTo4UzFEqiJkjYOuQd5YR/xQDnvCEMLT
         gruPXZgJxAUKqq9F8yVtu7D4cavqpUTLFK37pZmGSKL5wo3vXfcItVrCPPNbBea6EiEk
         GZVkau/cFF0dGFyERVzus4c9eEhQ7wvDyazBdMjy9JobVfnnDLMJWOiBSKQPLvmqaCO1
         O3R0sqr8APMyCInXNnOaO2NlyMmo+7tH5FzQGluP4AwNIPwnLcPrdj+rV1k1XgXaKbej
         /2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786356155; x=1786960955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0wEYkzBcMdzXW3DkDjCq2S2tZx0eg9Z7Yp+aB3llSto=;
        b=UxXySlmbQI1+YW8zs9gc+BuwpO1cL4yAF+L8J3ajXQRae5Vd3UDQjK5QN7dzU+SqLD
         0qDVtRuPioamkh5GxLJrRdVmkricDiJTi35ByPzSazjFutETHRbs2gRIhOhviBpO85aG
         ahd/jyPRwt8mFNiTk6fjA/eIi8YLKikjkKy/EQW04qhufpxLE1UN3YwS8ukBrfENLj8u
         ZkAKDyuVvR6mBCbKneSMvu4dEUkHWZMn8X6GP3EEwMP80G75waCcmMWgcwepQbjKv5+J
         vXz4hjcY56oTREM9LMn15OedbQyyHZTCkO+dpo54SrolZrk0KZ6mIPGnpmf4+XM4oG+v
         pAiw==
X-Forwarded-Encrypted: i=1; AHgh+RqDVfWo+P6HRcu6bUOj/n23SrouE0IDa5mcX9nqHuEYCIW53d4ierzeWZ1SQu1SQ2RYtn39MQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeJuE79G3MVGyNvjxeFVR6xb07O+g61xGl17yBMpFTVa/CZkEy
	yrh8m36HiDiixVF7yQRuqIWO+DElkuSoaTBcAh1bwsWRi9J/cfOFMUYx
X-Gm-Gg: AR+sD10SkbBuFFUx8ig00N+2+rwEG7X3fQ+cnxNgxv+q+rAE2wn+exibRxGgg9RvAlc
	uuz8ivpmGQ0W0YrWopQWmHAt6OdoFZ4X83SldHulXzn3ttcXPtvS58vZMjrazrRrVPz0jDBsf84
	cHeQKTKg7M9C4e/LxDHd/ufG0b/UfcxVm9JWRrrvJOVFSZTvay89xciG2pHI/OpgvWJnLnEnVVY
	vMZabm3cirf7cWbG/t2QIgsQSqcDWBQMd4ZyKtfCQFtX2dAA4guTaRPeHOvNhF97YkY52dEPOmT
	26ml8VUxLSVkjoeYYOh6vwcEHp6xiGxwW/5OTTTHCCBYL45rBGNgY5LoLtSGFvbIOUqQiZVkIl0
	7nLcyvxxuEyDjdRPvkuZS3XtzR1z+mLjHF5nBNiL+X0GfgN5FOJYGeXURJA8RdibUVZMnDs2FNg
	yF0ZEhy9O18YLutRthCZmIlG8DRDinSWltsK13e7q9xD9GplcG0MSB01kmfDJ7mwowFY7aI0ILZ
	Y9h1g==
X-Received: by 2002:a05:6a00:c0ce:20b0:84f:72f7:de58 with SMTP id d2e1a72fcca58-84f72f7e7cemr11081899b3a.17.1786356155075;
        Mon, 10 Aug 2026 03:02:35 -0700 (PDT)
Received: from zhuxin.hobot.cc ([2409:8a28:54b5:7840:a4d2:402b:802:4ee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a58998bsm3604775b3a.55.2026.08.10.03.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 03:02:34 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	richardcochran@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net-next v2] net: stmmac: dwxgmac2: add XGMAC timestamp interrupt support
Date: Mon, 10 Aug 2026 18:02:21 +0800
Message-Id: <20260810100221.9166-1-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DWXGMAC2 uses XGMAC_TIMESTAMP_STATUS at offset 0xd20, while the
generic stmmac PTP handler reads the dwmac4 offset GMAC_TIMESTAMP_STATUS
(0xb20).  Before this change, the DWXGMAC2 and DWXLGMAC2 hwif entries
used &stmmac_ptp, whose timestamp_interrupt callback read the wrong
register and whose config_hw_tstamping callback never enabled the
XGMAC timestamp interrupt (XGMAC_TSIE was not in XGMAC_INT_DEFAULT_EN).
As a result, auxiliary snapshot events were never reported on XGMAC
platforms.

Add a dedicated DWXGMAC2 timestamp interrupt handler that:
- reads XGMAC_TIMESTAMP_STATUS before checking
  STMMAC_FLAG_EXT_SNAPSHOT_EN, so that the timestamp interrupt status is
  cleared even when auxiliary snapshots are disabled
- derives the pending auxiliary snapshot count from the persistent
  ATSNS field instead of the transient AUXTSTRIG status bit
- generates the corresponding PTP_CLOCK_EXTTS events

Also enable XGMAC_TSIE in XGMAC_INT_DEFAULT_EN and hook the new
handler into the DWXGMAC2 and DWXLGMAC2 hwif entries.

Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
v1: https://lore.kernel.org/netdev/20260806-dwxgmac2-timestamp-irq-v1-1-c051c79c9d90@gmail.com/
v2:
- reads XGMAC_TIMESTAMP_STATUS before checking
  STMMAC_FLAG_EXT_SNAPSHOT_EN, so that the timestamp interrupt status is
  cleared even when auxiliary snapshots are disabled.
- Drop the unnecessary (u64) cast in dwxgmac2_get_mac_tx_timestamp().
- Reword the changelog to describe the real problem: the generic handler
  read the wrong register offset (0xb20 vs 0xd20) and the interrupt was
  never enabled, so auxiliary snapshot reporting never worked on XGMAC.
- Update the comment to clarify that TXTSC is cleared by
  XGMAC_TXTIMESTAMP_SEC, not by XGMAC_TIMESTAMP_STATUS.
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 43 +++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  1 +
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 12 ++++++
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.h  |  1 +
 6 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 61b6d45a02f5..76e2860a9517 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -87,7 +87,7 @@
 #define XGMAC_TSIE			BIT(12)
 #define XGMAC_LPIIE			BIT(5)
 #define XGMAC_PMTIE			BIT(4)
-#define XGMAC_INT_DEFAULT_EN		(XGMAC_LPIIE | XGMAC_PMTIE)
+#define XGMAC_INT_DEFAULT_EN		(XGMAC_LPIIE | XGMAC_PMTIE | XGMAC_TSIE)
 #define XGMAC_Qx_TX_FLOW_CTRL(x)	(0x00000070 + (x) * 4)
 #define XGMAC_PT			GENMASK(31, 16)
 #define XGMAC_TFE			BIT(1)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f02b434bbd50..b849cebf9b29 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1154,6 +1154,49 @@ static int dwxgmac2_get_mac_tx_timestamp(struct mac_device_info *hw, u64 *ts)
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
+	/* Read XGMAC_TIMESTAMP_STATUS to get the AUX snapshot
+	 * count.  This read also clears the TSIS bit in
+	 * XGMAC_INT_STATUS.
+	 * TX timestamp polling may have already cleared TSIS
+	 * and AUXTSTRIG, so rely on ATSNS instead.
+	 * TXTSC is cleared by XGMAC_TXTIMESTAMP_SEC, not by
+	 * this register, so there is no conflict.
+	 */
+	ts_status = readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);
+
+	if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN))
+		return;
+
+	pending_snapshots = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, ts_status);
+	if (!pending_snapshots)
+		return;
+
+	acr_value = readl(priv->ptpaddr + PTP_ACR);
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 511b0fd5e834..9718582b8480 100644
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
index e6317b94fff7..818ab3daa91c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -671,6 +671,7 @@ extern const struct stmmac_desc_ops ndesc_ops;
 
 extern const struct stmmac_hwtimestamp stmmac_ptp;
 extern const struct stmmac_hwtimestamp dwmac1000_ptp;
+extern const struct stmmac_hwtimestamp dwxgmac2_ptp;
 
 extern const struct stmmac_mode_ops ring_mode_ops;
 extern const struct stmmac_mode_ops chain_mode_ops;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index b9a985fa772c..9d7d24259abd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -277,3 +277,15 @@ const struct stmmac_hwtimestamp dwmac1000_ptp = {
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
index 3fe0e3a80e80..dade09614163 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
@@ -103,6 +103,7 @@ int dwmac1000_ptp_enable(struct ptp_clock_info *ptp,
 
 void dwmac1000_get_ptptime(void __iomem *ptpaddr, u64 *ptp_time);
 void dwmac1000_timestamp_interrupt(struct stmmac_priv *priv);
+void dwxgmac2_timestamp_interrupt(struct stmmac_priv *priv);
 
 extern const struct ptp_clock_info stmmac_ptp_clock_ops;
 extern const struct ptp_clock_info dwmac1000_ptp_clock_ops;
-- 
2.34.1

