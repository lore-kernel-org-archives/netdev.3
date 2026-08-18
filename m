Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426DE4772B7
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059678; cv=none; b=AgfZ9VBlqb6cspMe5JCJ0HEW2ZO1H+B45JtFLQiI1mW8yXUdJ4L/1TMaxZoykzkqvPK1Et1Pq8thOrg57iBn4oyFa77LCUCy0hqgMoRm26Mrv8Kagh2IZyyO/BXrvpJXZYQkhMRORt0Z5niQUnDMmDOW/iWuyWoYu4Rs0Ile+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059678; c=relaxed/simple;
	bh=7NJByljIoIPorv3/Xy4RQAnsrnQSGyXDo7PFeEhMbNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JTdYQeC8OfVNsM2Wn3SbrClFcDa5LZENAg0MY8m8ppLGkG88LSoSzu6iavWpRZReC+Ue21mjEUKWM6w+Hhcyc5vPZt5cRjAvSVabvR12PRsaCZul3PEEJDqArfHPZxvDA7N3fbzf3v3zbCgAVQOKsCdDKu7M0oIE1uBJU7OjLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmIx4K4y; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmIx4K4y"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f84023916so4398126f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 06:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787059674; x=1787664474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+3s0Ug7tKmBUVY9glqgI6hd1KhOLM6Z7RD4robd3dno=;
        b=JmIx4K4yGcxqwr/LGZZm+HrwQc15zBseTQ5v9gdGGfGzL5mwQR1G0dzcCLTThcSr3u
         G34J/MASz6WwZpBhKc4/UlUXq+KtyADEJGgiLL3fwdtKsLpIE/6GJmhcYhS1tUnYZuQu
         +AU1PWrlQ3gbJt0NuokTgPQ9XgHV6D1GIEzFCq1eOxxZqkj+nw8hBWWUBIoriF0inakI
         GpduzLQ8Xsj4FFtG5VOCKoYhLJk6ZqW8mtrZ0w2+Li5ITtfJzgS0m0nWgY719zt30giZ
         4fUQJ9uIw+oTBIPKo4rn3GWdcZamP2yLYPoX24lPBMg1qI+9lS/X09XKA2BiLwv9oDTi
         iwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787059674; x=1787664474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+3s0Ug7tKmBUVY9glqgI6hd1KhOLM6Z7RD4robd3dno=;
        b=JZ8CySTKvBJNj1ltnQ/OI7uD6rMiGlVFI2O+mCYtTnRgu9N3JXs97N47I/9h7w7j7l
         VXF9FcxqJ+VZOuw1p/wTBiWZgeRmVMqNTvtEn0dVLEWXs/uGAzdDf3/5voZBcNHLlTd5
         GE3vFyNpBD5rizprpSHbl6MFwKGqwDLgSLORofZiO42kYR6IynGbCGTEvUwwIGQDVwjE
         bAUL9AoY2gnegcZ4cX5g+QbVudMF62pRNzNm9EnSaVk68rUkpBCbOD8+jaROA0SpZ7yS
         DErW4aYHCJ+U2ka4taPXoRHzy2fkWMWPbAj2SIIGt8JaCV6sEv7bZ3ppWnhetCcm3Xxm
         plyQ==
X-Forwarded-Encrypted: i=1; AHgh+RoII1P565BrUVYNPKtNmriD2po1UgtXVkqzBEXTbgIkBvNAgic6nBOmSQOmb2tG2Z/khx7ElZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuJkqbH56P9xQMTQ2cRMoeV0okW9H0SwmZNXy+SM913PIaWMOz
	d1EDF/RZU0dgyV/SVP1J+JzAF/62yFXXjS/Mkrs6UAm/Hbl81l8O3EKy
X-Gm-Gg: AR+sD1304BClZQ/EoxCLlcnqMcuG0AN3Yv2E/Cy+FinIf6p8RUvAXCEYNPwXFhciMl9
	jYT23+C7zZkdTSncZqDEIWuiGyyn9mSvbwJ7fCQ66uhKvIk81oYyz7Dj3RaJ7cApBhRVuXQ+qzW
	00chJsdJIiI7pCx+JEZjI/dpZWXEUY2yxWi8Sw1wA1yOH7ejVuatLUHYof52T/a1iKIZAXisTTi
	tGd+sR27AxJCdLPNryTdsv71OT0x90QeJ9BLVLtABHzPV3e6VfQi74vwVFDq9oJgvdhhjkuoqsl
	Fu6TqkuqJRNcdQQGPRGsJPOS12mJD06tqZE4K7FZ7zg8pEblP7q5xThzpubWbRyGRd/u/ebx33K
	PCy4TX0Z+xGniP766WIA8Z61JU9H6+lND7jHk2Q9qlqVVc3Xc+clURY6OQHa1TMKQjWKtdNjCyJ
	MHje4REEz1PhnynkjYc2UdaoLCRg4vD691yuF8JGyqXHbQMLI83rfxtfq9adgH7eNSIvImVg==
X-Received: by 2002:a05:6000:25fe:b0:482:a9d7:7ced with SMTP id ffacd0b85a97d-482a9d77d37mr13957650f8f.14.1787059673878;
        Tue, 18 Aug 2026 06:27:53 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7c568sm12140145f8f.18.2026.08.18.06.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 06:27:53 -0700 (PDT)
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
	muhammad.nazim.amirul.nazle.asmade@altera.com,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net-next v3 1/2] net: stmmac: dwxgmac2: add XGMAC timestamp interrupt support
Date: Tue, 18 Aug 2026 21:27:21 +0800
Message-Id: <20260818132722.1852876-2-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818132722.1852876-1-zxyan0222@gmail.com>
References: <20260818132722.1852876-1-zxyan0222@gmail.com>
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

