Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972140DB3A
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027841; cv=none; b=PfffssLXJJSla+lgPgaZ7q3KOp952uz6p9FqxIeWQl0iuazjKGVegzNEFqGGDSgq8KKaD+kgtrbeebD+nmOr9sp0HOeQ3QvjUlHM/W73hTnzOVbUbuUkrSD7u2XQT+86tnZnfdsADx4djoJPnUyMH5gbYnfT6AOtK8+fOyd76qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027841; c=relaxed/simple;
	bh=9WBU4UV+7UtsnX768TqabQ63Pb0Bd1MZ4nCo0ppSUks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TCXucMTSkCWE022iUXtpY5VOxgY1m2EJhl7VWXZ05YMjlHSuhY6kpYHlhxTqBwdmveuxeATO59Db4DATqkuG9/G2RBt0uKzeBi7Eh+5q2eMdzJaBR2CALwHzhCBa0uc/IEUfxDoPSBATuBB+rcytcXBzQC8J5GNPcwQRQbC1DHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcaX0uwr; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcaX0uwr"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso726108a12.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 01:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789027839; x=1789632639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V7icB+mFn47r22Tll8dVKEqXUZ7IexWk6IFOaTVD/4o=;
        b=LcaX0uwrRcpUkDjAmwE/h2QwPXo3/iPOPyCd7Qgl9V16NuJbtbiFNuhFlnXaoJ3sTK
         kkDyUyWkoVGTaH/BaeJvAn5DNpklWVMuQ4XQHAYB7+32RywsFOS/rIM8fB+IPpOXwTSh
         nlMCXjMqWtUah6Laz09Yx64cKcqZD2/I3ZRruHaGQkQiwvyqJn9opSpjreCqfaxrc7ev
         lPsH4hIy5I4m3wY6HtV9FdeLtwzgFGwV+NoQZfuJ4Jio/JbM5c5dDgLyoY8gsofbaW9M
         +xAEQin+4M6DcL5waCWkOm5hZmNXOGeEdzelsI0n6KmKtwjtN4jUPXDiKmwIFboMcuUy
         c6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789027839; x=1789632639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V7icB+mFn47r22Tll8dVKEqXUZ7IexWk6IFOaTVD/4o=;
        b=hUe1NmRCoX4iD13nJC94hFUpsvKmH70xRwMg1dNr9XTRIzxon2uqGcesgksiLfna87
         mLdv9e0zcsbzJ1QOl7vN+NHp/HY6S9WhPGeOIxRVc6lZwCO7PI4kixGUkkToHQE9X4Go
         jd+CqIXrDEP+68MGRNrciLxWm4wdifNQhA4mzGESHqMpqZ6hvZMPI81u1Ec1rOCVTyT7
         uwKI5tr5AdVVFXjoN7UwTdu8g1PpvX5fsIdnnJEf0QC75IIMksbyFbn8DXMxMOrh4Dgf
         VZVnJUxhhz7hgAsMyNpG0miK40nWala5uzJlHiakP0LWsOXNZJGKp6vREO1eatwV4hgz
         iQ7w==
X-Forwarded-Encrypted: i=1; AKwUvBwJgQd/78iRlCfZUn/5QJo1ikV99SNjEbfv5+OGE1xaM8qsLe8jyFwEFXNArHVx/Pows9UZ3pM=@vger.kernel.org
X-Gm-Message-State: AFuF++niZaRx+6xZb/ths5bHZXQML5tde0yF/9AmrTKISDyeUWgpgN9t
	ZhWY54o27bUyktXAN2tX56FfhU9V9ok7/Fjd1BJt+KZa7nA8TOmlRfrI
X-Gm-Gg: AYBFou0R4jQ+AJrMAbzRzZtGJVFy1Pvq+zEs+BqupByllB7EvVrpsdK+69R48CVsf+O
	ixa6t03Ts11tVjciHz/IfC4TOMDplfGu4NFio++sQxkcypy/uPsBToiOLtelfnCtp2lSgsdo59j
	/cgwygnLrec9cbo/t7wpBcv+KPO9HN7kH37eGOgbBOT3vUnNMcS3Z6VB1p8jY4c9gq1PK8eqG3w
	Ax9sGPx6UtcNeLuy9jeASsdkl17JIOoUgEI3RQvLqOJBoGwtS0DLp9q+3XSszETkZM9PGMKIWJR
	Qy6gtNG1ROZw3feqyY/HJjVBp4n0ODu/H8Sr/9MFE55n03cOA0osfR1qQArFfMJhBgQ/xJHJB9o
	Zeqdy0UPj5/moxOMY4Q2+vgkzLFlntsuIzXAvPPnnUGcGxTSmLZ1CEwh8B9D3ZtLU0ZyS1Nve/V
	e7FeOJpvjnPTtCeLEJpS2AlsmwZz8gSgPZlreENJMFDo0Aw597tyJo0nlzoBMlEX6LEWHD2A==
X-Received: by 2002:a17:90b:1e51:b0:399:ecd:d68d with SMTP id 98e67ed59e1d1-39b26260f7dmr54760856a91.22.1789027839049;
        Thu, 10 Sep 2026 01:10:39 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d770bc9f5sm4442434a91.2.2026.09.10.01.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 01:10:38 -0700 (PDT)
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
Subject: [PATCH net-next v5 2/2] net: stmmac: dwxgmac2: add XGMAC timestamp interrupt support
Date: Thu, 10 Sep 2026 16:10:20 +0800
Message-Id: <20260910081020.86227-3-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910081020.86227-1-zxyan0222@gmail.com>
References: <20260910081020.86227-1-zxyan0222@gmail.com>
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
index f8ab347f7b5b..03cbae326995 100644
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
index 1a88cbaed70c..891b7ceea2d4 100644
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
index fe18f98fae45..5a308e79db4a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -672,6 +672,7 @@ extern const struct stmmac_desc_ops ndesc_ops;
 
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

