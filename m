Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A3330216D
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 04:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792040238; cv=none; b=PHVTsXAJGMcJy1BAEf0futo9eKtUF0WfUtvvqyhRlJgy5wpLAdWLAsj+ijnKLpYhOkyYzEQAGIipPbvuELuWpvvMmlZrsWIFcETJq72VJpMiu0vyuJRAnQ3QfLHXbDdMQUuwjXqV7CIDbPCgiU5L7pJbDsUnFUYO47g8cUI5n38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792040238; c=relaxed/simple;
	bh=y67+C3aGktujq6DkWVCGAmqUWwxcRq1wp4izSmoo6v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpewndOqs8z6W3mp9UIY9O3YS+uK4xtc/8XHVpeuR+sbNpe28tqAUwvJ+Bpmwbs+pZr2WF+66XwDBK7VzSKDyZp3M3g4NI3oKepGGd3OsidMRKHGVXsrPB3LQTdxmg70G6W9JFGdKFzfTev0q+973oDTLDgoyd+Q+bVrM3ZiHjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qD5FVQQm; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qD5FVQQm"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-15168a20b47so3236319c88.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 21:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792040236; x=1792645036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CfsP/6oH0zltnAdyQZ1VafpTf7v+axGkkavJD+JKsTM=;
        b=qD5FVQQmAcRdOqg7tPSrurJXXf+GkCbIAB7Th24q+fOCJpUjjdl6Szwr+sfbHZrqlZ
         nfJUuMnsz2hd57KiZK74LAcOPQdMNXqxrneGizHTveTk7CMl1u2pz9JCuqFpAAReiO1L
         r8MIGsiyGkrRPkvOd85w8m+yK+BAnKK5XwukzXtBRE4TpoPEm9KqfFd2o3e/AK5TO6Q0
         Ui7kVe/1yRFqkabji1ifPil6z8uM6bYq198p2dOQ0228NCdUPMWBCGHW0WuSmyQQaTk2
         mt7TBndSvIQnqDYmm11S/vir5xNfnzQeXH6dVVrnASb/gw/KTxtzjbixDgEqzEPKhyrx
         EKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792040236; x=1792645036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CfsP/6oH0zltnAdyQZ1VafpTf7v+axGkkavJD+JKsTM=;
        b=gw8cS+a27vT2Dhf4vQK4GbmmNopRY/LqEpV8Uuo2Wh4+gi92zqBpe7WV2X/DULcWSW
         3xYmuBc49CQdqVEiv87GQAaQpHz4SmrokEB4/cHbDK5ExTZVGQ0eAs6jL1RcaHlATwUE
         rDifPYcoSgjztRHPA6fdN37mOjiNvYMyWOa5FPSRhJ4SKVdhqX3KUEl/PoF6JtHUPViI
         F3ni37ZgOnCHPSZy8QK3f6pTHOBpM7K25F9YX433BnK1+r3so8yOsCUl8L/wTbuizSMC
         4dvR2N4L6cOWYsZQzmZ76kBXzAdt/h7hTMUO58TLuDcODyZltjytRDNqfgzMNsOlSBGg
         tVeQ==
X-Gm-Message-State: AFq9FYKvsHLQjOAxgzeFnPcBnRcpRTrNQiKhbHLCMuru2CJsoTaNUSc4
	ecO1EUIZHDgmsgvwnRGHREIkBL3169Ld2DVBg3qT2wnDAfRG5WSwbO7juTPlu2/W
X-Gm-Gg: AYBFou1hIK+Yh+yl8EaG56DhuvH+ssbtEVfv341V9H4ZMi7fkP3QannTjjU/VYqNkcw
	JMcO717oR4Yej9azyv0JP/ycRE1o5JcVDFKsSfbo5HjC5+AeNSKXw6biBLuMOKSMLNFGqsy1S1u
	CpxD1D6jGwTeObzflMExob0UFZJwkVd+MPK8czsEvjhF8U2u4ChCz6398f4LbA6VG856KFyuQ1q
	BPF84KH3P1PnlEF+HJQP7+UAJxlScWDDoZwLS+tt1px2mxw/W9BVfrtR+WcOMNZjBpcUfOKXNWy
	lY/7tp+ysOZ9VhMuSloMNTx+zH55ca+Q+6k9IwrmykzWWzhiarP5Lw6QhrdjYTYbQO9Q6+fGjsv
	pI9We0UD7ztAvsG31x2RFGziDecCkwScqs6VoFhC+XeaQxJN2Iid8GxSLXR+I88BalHVq93XGV3
	o4ezBECX+ZuXGomOJSX13U0uGUzpISRVOuYtzn7Ks4KWDQjedf8Nj1BqJDoj4lAD9WrXDeFy2S7
	VhVN4MdIswiaxXjCRtIq77OTWOaKYswhu0FK4s=
X-Received: by 2002:a05:693c:2a13:b0:35f:a2ad:603 with SMTP id 5a478bee46e88-35fa2ad06cbmr82431eec.16.1792040236177;
        Wed, 14 Oct 2026 21:57:16 -0700 (PDT)
Received: from nbai25050026.. ([2403:8600:2090:6f:51d7:b8b7:d860:59b2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca329d9sm62391567eec.5.2026.10.14.21.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 21:57:15 -0700 (PDT)
From: SAYANTAN NANDY <sayantann11@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	bread.hsu@airoha.com,
	sayantan.nandy@airoha.com,
	SAYANTAN NANDY <sayantann11@gmail.com>
Subject: [PATCH net v3] net: airoha: keep PPE offload when NPU refuses flow stats
Date: Thu, 15 Oct 2026 10:26:07 +0530
Message-ID: <20261015045607.12999-1-sayantann11@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008094828.15458-1-sayantann11@gmail.com>
References: <20261008094828.15458-1-sayantann11@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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

Based on the original SmartRG/Airoha work by Chad Monroe:
5ce96ab ("SDG-9458: keep PPE offload when NPU refuses flow stats")
0ad8528 ("SDG-9458: airoha: treat a zero NPU stats address as a refusal")
Fixes: b81e0f2b58be ("net: airoha: Add FLOW_CLS_STATS callback support")
Tested-on: AN7581 with MT7992
Signed-off-by: Chad Monroe <chad@monroe.io>
Signed-off-by: SAYANTAN NANDY <sayantann11@gmail.com>
---

Changes since v2:
- Drop flow_stats_cap entirely (Lorenzo).
- Keep the original airoha_ppe_get_num_stats_entries() checks (Lorenzo).
- Guard airoha_fe_clear() with sram_num_stats_entries > 0 (Lorenzo).
- Replace the error assignment and goto with a direct if check and
  dev_warn() (Lorenzo).

Changes since v1:
- Explain the NPU SRAM allocation separately from the host-side DMA
  buffer (Lorenzo).
- Use airoha_fe_clear() and shorten the warning message (Lorenzo).
- Include hardware testing information requested by netdev-bot.

 drivers/net/ethernet/airoha/airoha_npu.c  |  8 ++++++++
 drivers/net/ethernet/airoha/airoha_ppe.c  | 10 ++++++----
 drivers/net/ethernet/airoha/airoha_regs.h |  2 ++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 4d3195eb00f7..b32a01dbe06b 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -450,6 +450,14 @@ static int airoha_npu_ppe_stats_setup(struct airoha_npu *npu,
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
index 92611802801e..74ac3791cb63 100644
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
@@ -1454,10 +1457,9 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 
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
index 442b48c9b991..aee06c058586 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -72,6 +72,8 @@
 #define PSE_CFG_OQ_RSV_MASK		GENMASK(13, 0)
 
 #define PSE_FQ_CFG			0x008c
+#define PSE_FC_CFG			0x0098
+#define PSE_PORT6_SHARE_DIS		BIT(22)
 #define PSE_FQ_LIMIT_MASK		GENMASK(14, 0)
 
 #define REG_FE_PSE_BUF_SET		0x0090
-- 
2.43.0

