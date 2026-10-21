Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577142;
	b=VbNSMoF1b1gOMZVRxW4iBWh0KowzDJnHQalK01tHfUz4nHhtrwElaw8cZNBeUIPtiOf9
	 HKD/+j1KBi9UWP4m1DF1+y3JUeWWNI5fDT6whWetQDtaPPZQOhPDtCD/3mLlytQ1tmjCc
	 MhGmIYlpUTlXxBGE06Zfrt5R7ud1N0c2HkVqoQ2LNxim9HP19IGLT0GD8y88kkk6krJVy
	 zP8J32G3qwwb6Gfd6YEffSgrwG5zB+Lg6wBIJ5uAeEak3x9pnigzhHnC2W2W86LORzFH7
	 gC+FFq6vx3PvC6DMBrEG5ZH+Pp+LXUrgPtzrvA0LLme/akg+2tohm4wAXGElz0Io4oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577142;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=iUDzzhRFcuZwO+3SJb9cokijJmFOAGUdE5cEySuu2/I=;
	b=vEk9F5051NKHgtu6eSFaqXBcadhZT19YigRxpIppuMuEFmba2LB2sFIwU31Jg9mRoFNu
	 ziKK0Ka5IlSLh9Pok4VxLEhCkLvCJAE2zPstA3PrRKAVz7jncvPz60x7P8ZbjQ9+ATlKI
	 S+aZQyT4Id2mDRa68fJjo9pr5MKJsOrxcrxlPjr5a4aQMvVOrrOO4hzDfB/WUBrZPO4xM
	 /+QcwlxCqEYZXy3IwchxbPsuB1qlSVnZCtJ7baCj0FlQRiq3Sd1+jMy7IpkW1HWBtVzMe
	 kSIH2ov2L4Qh7smliTm2t4yRy8sb7Mf27syNAMGB2fv6/GvuDmZgrVVHm3MiJwqw4fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S3ppqjVO;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28322606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28322606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S3ppqjVO
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36681e85e87so1050974eec.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792577141; x=1793181941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iUDzzhRFcuZwO+3SJb9cokijJmFOAGUdE5cEySuu2/I=;
        b=S3ppqjVO5Up/IO5xwMxjpVzbPLekKp66yIvl9fr5oHE62Brpbq28NQndjTQdDfRwiJ
         Act9UDaWjQkeCmNpiUjk4e0nfMOJrRuDtmg6HyI8AlrnOo+Pbco2Cni36gtnNJGP7yk2
         BK4EvGStPSThsJWThVRZoEkZK+GM7JboIzM9rqotLl5iqmqhadYLM99u3pqFgyxqoLg2
         2sGQVX2nAiiApVvP1aG4i4lu+QDqQhQhVWVdtsTT5vJzeGdQThAt1kGiDvjbW6ToGVCS
         /IdS9NMVV7hWYVZ7FaOUa6xtD0OFhuh99DJfJr7nbJohyHasX/4wM8F7dWZ/VRvdPyGL
         fvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792577141; x=1793181941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iUDzzhRFcuZwO+3SJb9cokijJmFOAGUdE5cEySuu2/I=;
        b=G9+AHrSZL4xE1sWZxIbS2pgpHzlPv5wk+0+RKUtC5PyFAXK3DspC1GoBnwu9AAPYuf
         L+BIxbMq47Q8xZlB339x+EPHtze0690WPE6GQhZG4kk5IRFMUapcJ2Ipcnq8jlkzgw1P
         SpNKWtnDPR7tBfJlkwY5+l8PFswtp7K6vAV0xKca9Y3TnugikoRaMfTxTKm+0QNHSdvQ
         4B+ZqKkU/wTjcRNxGzPl2wdDhA+9+7Iw8QFvIINx5SXjF06Eoi9v3+DEJpfHF1IzD9TY
         C2qlY8qzehya9tFBoL5yAzbXCQvDW10W/ErfuZ11xJOn6ziIfauDjDtAjuUMVIA7ePMi
         xTUw==
X-Gm-Message-State: AFq9FYIj3npfpEzkfsrIsKFErGoL660//Ma1nPAK+Q52S8E7FFEVTJJY
	spBi3nnuEz6J8Iztvg6hHdvO0T7IPjRBHTItRNnq+B2/t1/04dys2lehL3PvdKRG
X-Gm-Gg: AYBFou1vW9x60YXT8mUERG4vA6B0lEWSzFgl24wMxp41rUEYI6fxifl4ClrBmiC6nCa
	yg3m/blP/QJ/BUK/wkK+Vbi6iL47qBZNuqGoL4DylgW0g9VcWFPkDdDxGnScHMKsGi7uTR01+HT
	EOWFC6MBCqhEzvApBLjeBMDBFJT6qky3fIN5YClRCzCunQSTtEmqQAjPjn6wRzVqXxbJVmV9S7I
	IcbTp9I9IhHo50zpZF+uHu7kbgQWoZz8PM7DrkC6SqfTAp8lM2Mb3um4xafCQWSfe8zY95TSQrF
	OhrGHzs+WTLlmpRMeKEK+JH94lStV2H0ApQtlAfAuyM/X675Fs5sKswTY2LX8k29tHQi5ukghsc
	0sC16pfmaWusXaVdYNE2IVoImdhZYjHnqO32wFnM9Q1BcERotgJWORFNshgN36D1DtchstW/9W/
	+6p0/enNV6gmPHwO7w2ErWQfVTPSu7Ia+CAfXsbM2fSPCDHGfabtE6aYGURPL1D6MxlkcvvfIx/
	c3cqzAApxWgvw8DQ3j9yRbuM6yfLsPKoFmtRpatavwXECXdAf1bWu6XCp1LMRjQw9UZTKaaQaNT
	v4fjEl5Mm6tSEFBY09I90g==
X-Received: by 2002:a05:7301:904:b0:35a:7020:c08a with SMTP id 5a478bee46e88-3674e04ffb6mr2357758eec.19.1792577140814;
        Wed, 21 Oct 2026 03:05:40 -0700 (PDT)
Received: from nbai25050026.. ([2403:8600:2090:6f:2a9a:891a:814a:9c01])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405ed295sm6579780eec.9.2026.10.21.03.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:05:39 -0700 (PDT)
From: SAYANTAN NANDY <sayantann11@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	andrew@lunn.ch,
	Chad Monroe <chad@monroe.io>,
	SAYANTAN NANDY <sayantann11@gmail.com>
Subject: [PATCH net v4] net: airoha: keep PPE offload when NPU refuses flow stats
Date: Wed, 21 Oct 2026 15:34:23 +0530
Message-ID: <20261021100423.9159-1-sayantann11@gmail.com>
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

From: Chad Monroe <chad@monroe.io>

With flow stats enabled, PPE offload setup requests flow statistics
from the NPU. If the running NPU firmware does not support flow
counters, the request fails and the current setup path aborts PPE
offload.

Treat flow statistics as an optional capability so that a failure to
set up the counters does not prevent normal PPE offload. Continue PPE
initialization when the NPU refuses the flow-statistics request.

Also treat a zero NPU statistics address returned by the firmware as a
refusal. The host-side DMA buffer (foe_stats_dma) is allocated by
dmam_alloc_coherent() in airoha_ppe_init() from system memory. The NPU
statistics address (npu_stats_addr) is a separate allocation from the
NPU firmware's internal SRAM pool. When that pool is exhausted, the
firmware replies with success and npu_stats_addr = 0. A zero address
does not provide a usable counter region and must not be passed to
devm_ioremap().

When flow stats entries are available, clear PSE_PORT6_SHARE_DIS so
that PSE port 6 (CDM3 path to the NPU) participates in shared-buffer
flow control. PSE_FC_CFG bits 26:16 control per-port whether flow
control considers the shared buffer pool. Bit 22 is port 6.

When flow statistics are unavailable, PPE continues to operate without
NPU flow counters while retaining normal offload functionality.

This combines the original SmartRG/Airoha fixes for:
- keeping PPE offload active when the NPU refuses flow statistics
- treating a zero NPU statistics address as a flow-statistics refusal

Add NULL checks on npu->stats so that stats reset, stats reads, and flow
updates do not dereference a NULL pointer when the NPU refuses to
allocate the counter region. Avoid redirecting flows to the NPU when
flow counters are unavailable.

Clear npu->stats at the start of airoha_npu_ppe_stats_setup() so that a
stale mapping from a previous setup does not persist after a refusal on
rebind.

Based on the original SmartRG/Airoha work by Chad Monroe:
5ce96ab ("SDG-9458: keep PPE offload when NPU refuses flow stats")
0ad8528 ("SDG-9458: airoha: treat a zero NPU stats address as a refusal")
Fixes: b81e0f2b58be ("net: airoha: Add FLOW_CLS_STATS callback support")
Tested-on: AN7581 with MT7992
Signed-off-by: Chad Monroe <chad@monroe.io>
Signed-off-by: SAYANTAN NANDY <sayantann11@gmail.com>
---

Changes since v3:
- Add NULL checks on npu->stats to prevent NULL pointer dereferences
  and avoid flow misrouting when the NPU refuses stats (sashiko).
- Clear npu->stats at the start of stats setup to prevent stale
  mappings on rebind (sashiko).
- Move PSE_FC_CFG and PSE_PORT6_SHARE_DIS to preserve register
  address ordering (sashiko).

Changes since v2:
- Drop flow_stats_cap flag entirely (Lorenzo).
- Keep airoha_ppe_get_num_stats_entries() unchanged (Lorenzo).
- Guard airoha_fe_clear() with sram_num_stats_entries > 0 (Lorenzo).
- Replace error assignment and goto with a direct check and dev_warn.

Changes since v1:
- Explain that npu_stats_addr is an NPU firmware SRAM allocation,
  distinct from the host-side foe_stats_dma buffer (Lorenzo).
- Use airoha_fe_clear() and shorten the warning message (Lorenzo).
- Add hardware testing information requested by netdev-bot.

 drivers/net/ethernet/airoha/airoha_npu.c  | 10 ++++++++++
 drivers/net/ethernet/airoha/airoha_ppe.c  | 18 +++++++++++++-----
 drivers/net/ethernet/airoha/airoha_regs.h |  3 +++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 4d3195eb00f7..42d48a4fab4c 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -441,6 +441,8 @@ static int airoha_npu_ppe_stats_setup(struct airoha_npu *npu,
 	if (!ppe_data)
 		return -ENOMEM;
 
+	npu->stats = NULL;
+
 	ppe_data->func_type = NPU_OP_SET;
 	ppe_data->func_id = PPE_FUNC_SET_WAIT_FLOW_STATS_SETUP;
 	ppe_data->stats_info.foe_stats_addr = foe_stats_addr;
@@ -450,6 +452,14 @@ static int airoha_npu_ppe_stats_setup(struct airoha_npu *npu,
 	if (err)
 		goto out;
 
+	/* The firmware reports success with a zero address when its SRAM
+	 * pool has no room left for the counters.
+	 */
+	if (!ppe_data->stats_info.npu_stats_addr) {
+		err = -ENOSPC;
+		goto out;
+	}
+
 	npu->stats = devm_ioremap(npu->dev,
 				  ppe_data->stats_info.npu_stats_addr,
 				  size);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 92611802801e..3147655e8ecc 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -144,6 +144,9 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 	sram_ppe_num_data_entries =
 		PPE_RAM_NUM_ENTRIES_SHIFT(sram_ppe_num_data_entries);
 
+	if (sram_num_stats_entries > 0)
+		airoha_fe_clear(eth, PSE_FC_CFG, PSE_PORT6_SHARE_DIS);
+
 	for (i = 0; i < eth->soc->num_ppe; i++) {
 		airoha_fe_wr(eth, REG_PPE_TB_BASE(i),
 			     ppe->foe_dma + sram_tb_size);
@@ -613,6 +616,9 @@ static void airoha_ppe_foe_flow_stat_entry_reset(struct airoha_ppe *ppe,
 						 struct airoha_npu *npu,
 						 int index)
 {
+	if (!npu->stats)
+		return;
+
 	memset_io(&npu->stats[index], 0, sizeof(*npu->stats));
 	memset(&ppe->foe_stats[index], 0, sizeof(*ppe->foe_stats));
 }
@@ -644,6 +650,9 @@ static void airoha_ppe_foe_flow_stats_update(struct airoha_ppe *ppe,
 	if (ppe_num_stats_entries < 0)
 		return;
 
+	if (!npu->stats)
+		return;
+
 	if (airoha_ppe_foe_get_flow_stats_index(ppe, hash, &index))
 		return;
 
@@ -1324,7 +1333,7 @@ void airoha_ppe_foe_entry_get_stats(struct airoha_ppe *ppe, u32 hash,
 	rcu_read_lock();
 
 	npu = rcu_dereference(eth->npu);
-	if (npu) {
+	if (npu && npu->stats) {
 		u64 packets = ppe->foe_stats[index].packets;
 		u64 bytes = ppe->foe_stats[index].bytes;
 		struct airoha_foe_stats npu_stats;
@@ -1454,10 +1463,9 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 
 	ppe_num_stats_entries = airoha_ppe_get_total_num_stats_entries(ppe);
 	if (ppe_num_stats_entries > 0) {
-		err = npu->ops.ppe_init_stats(npu, ppe->foe_stats_dma,
-					      ppe_num_stats_entries);
-		if (err)
-			goto error_npu_put;
+		if (npu->ops.ppe_init_stats(npu, ppe->foe_stats_dma,
+					    ppe_num_stats_entries))
+			dev_warn(eth->dev, "NPU refused flow stats\n");
 	}
 
 	airoha_ppe_hw_init(ppe);
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 442b48c9b991..1e949fa4407d 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -82,6 +82,9 @@
 #define PSE_SHARE_USED_MTHD_MASK	GENMASK(31, 16)
 #define PSE_SHARE_USED_HTHD_MASK	GENMASK(15, 0)
 
+#define PSE_FC_CFG			0x0098
+#define PSE_PORT6_SHARE_DIS		BIT(22)
+
 #define REG_GDM_MISC_CFG		0x0148
 #define GDM2_RDM_ACK_WAIT_PREF_MASK	BIT(9)
 #define GDM2_CHN_VLD_MODE_MASK		BIT(5)
-- 
2.43.0

