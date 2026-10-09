Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC273D79E5
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522312; cv=none; b=OOYh8D+22FmsRSM7aqOdHFeWVSmnnK85XqKzKZ+EQRuYBVcjLe7iX3bEl5Lr9peLT/pJQf9IUY2sxIJSqR+zvm1iglkazQlpKrQxGzd17XXlB+UV0WX5xDHiKP46ywDhKd5ckMK5pY15mVpwY0VZOcetT/F1ev6iK++V2bV1LY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522312; c=relaxed/simple;
	bh=2jg0fx6X9ujL8YjJw6/r1qNL4/Zqam/+YxzIz26VasI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=katTIXxEzavMTpfHCf9QOozgDz/FucW3vZuAOFvy7M8alpnAX0sC7KRlLsk9egGJl0IqGI1Wnao1whqyEEVcsm0jdvNv/F5wKVcNLxphSNUj5CtWdmmniWwSWrdL0RAL5q1FOsDyLt8FBowgjRJT+6ijc7YH8plg1JgX475uYUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0GFmf9T; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0GFmf9T"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535a54bed9so1228374eec.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 22:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791522310; x=1792127110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WDt8xmkCjT/Lgq2VDXDSaI4X0hERcMtPjm6ARB67S9I=;
        b=Z0GFmf9TTMzf9E4u7528zC3Fp69pswo3wLwYz3atBwvbDz822ioHQPjv/Sf/5SCqLq
         x3Bt//kDaHbj0SIZaDeTh1tqaM0ErXknKfwod9AjUe+0y/gu/MMFfXhUlCOp8ZTUEv7j
         IH257gEzGyqunqPK54KH/Ywc0JFwhoPb/0BdZ26Zv7v5PacVqvD0PU7loxPRhDa/73a6
         FYuc2O2WLnR/bI6wRXOPKNUpE+b5LhbpOk2JAalPsqAX1oan3LPnFWpFKi6975Iau/p2
         Z54Gw5aTGFE0dBRj3YQic+82nLS2530umBXURGUijEXTOq45LUBZM39O1+2NOhWNlyiU
         1jRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791522310; x=1792127110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WDt8xmkCjT/Lgq2VDXDSaI4X0hERcMtPjm6ARB67S9I=;
        b=PTZkOiaektiEXTa8KXGXtxG5b/EYoCPLreqxRNbUVhSWcDo3OWHuFQQhQTSihNmsSk
         V/W7O2PbApbA63CrMHhgPlnzETaQnKa59laK7XOadH8MOM0xKbvjrMhyXsWXMC9qXg+5
         Aj9EiEXd39fhCemcPVeJRW0WO1Ix5KexiM0OtWgl47R5RSpNXopfUJZOAKQWiJUUd9hm
         LGkmFY2qi6DOejeW8rsSe0fhUOA7yN++H3xv73jXzbq42Ba4YJFSwxPqD9mJUccN+BRU
         WX09csH7SEdHcjpXEZGkjQ8yRoNvp3J7mZpuQkteXOkG6x4gvyZ3ltDqkP0cG/fz+zS4
         S2Zg==
X-Gm-Message-State: AFq9FYLlHCJO+4X2PujmnaRsB+pwTmUT4+f9R5HWIZhPsOWEC/yZENNK
	FRuSeyWE+12U5ctYKHBKotNLJtt9YBr0rt4Hj3hmRf4nfrFun7dvwxnuLnHVn+5x
X-Gm-Gg: AYBFou304FuhwWMb47D4Mpx5hWcvtDO8+pJmJAwCUmvxf+dJvybzbGueehevzOYq1p/
	I766lnuYnA7lEcmIM7rUZTRz/RHijZnA8AaGHlF93ngXjMWopkJ9oqfwAYLX9JvS2WspYntOkvv
	7iegCGQV6kO6sHI94b7p4K4Cq/sB5T2ALeyl0fYt69GctcAHORzFdu9XacT7iGwiFSAIH9cge3q
	RoziN/p7bSVLtZPOmq+UWrRZpV/FmEnz5rrNC6/4M97X4XPeA+1b3bWYEKldotj1SqVdzkC1IO6
	OloQMr3dtArzA5hYmBZCQgEXsE/B10x1aUyYRuK9ekjpKV7vK0nppqL749mraSj5SnbO0lZpUIM
	inhTNazZeNSnqWAqVJ0SJUgAR0AnRqN0NH59eh11q5WupdSdIfqihnYg4zF9InjUQW5U/f0yuia
	Twd+QymF1RLROoOhU8lca+RBPz1IviluES+MThv6eYsfC49dx9hK113TtopVSHD733rKMa7Kwqt
	xYotvqxccV3dTNhfO1A7bjaWltaaHlaM1Y2SDjB4Nlwx8VgWA==
X-Received: by 2002:a05:7300:4349:b0:351:62fe:62 with SMTP id 5a478bee46e88-3537e0b81famr1908803eec.19.1791522309753;
        Thu, 08 Oct 2026 22:05:09 -0700 (PDT)
Received: from nbai25050026.. ([2403:8600:2090:6f:a2c1:990e:e510:6920])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cab786fsm3505072eec.19.2026.10.08.22.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 22:05:09 -0700 (PDT)
From: SAYANTAN NANDY <sayantann11@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	bread.hsu@airoha.com,
	sayantan.nandy@airoha.com,
	SAYANTAN NANDY <sayantann11@gmail.com>
Subject: [PATCH net v2] net: airoha: keep PPE offload when NPU refuses flow stats
Date: Fri,  9 Oct 2026 10:33:22 +0530
Message-ID: <20261009050322.39060-1-sayantann11@gmail.com>
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
set up the counters does not prevent normal PPE offload. Record
whether flow statistics are available and continue PPE initialization
when the NPU refuses the flow-statistics request.

Also treat a zero NPU statistics address returned by the firmware as a
refusal. The host-side DMA buffer (foe_stats_dma) is allocated by
dmam_alloc_coherent() in airoha_ppe_init() from system memory. The NPU
statistics address (npu_stats_addr) is a separate allocation from the
NPU firmware's internal SRAM pool. When that pool is exhausted, the
firmware replies with success and npu_stats_addr = 0. A zero address
does not provide a usable counter region and must not be passed to
devm_ioremap().

When flow stats are available, clear PSE_PORT6_SHARE_DIS so that PSE
port 6 (CDM3 path to the NPU) participates in shared-buffer flow
control, which the counter traffic path needs.

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

Changes since v1:
- Rename flow_stats to flow_stats_cap (Lorenzo).
- Explain that npu_stats_addr is an NPU firmware SRAM allocation,
  distinct from the host-side foe_stats_dma buffer (Lorenzo).
- Explain why PSE_PORT6_SHARE_DIS is cleared for counter traffic
  (Lorenzo).
- Use airoha_fe_clear() and shorten the warning message (Lorenzo).
- Add hardware testing information requested by netdev-bot.

 drivers/net/ethernet/airoha/airoha_eth.h  |  1 +
 drivers/net/ethernet/airoha/airoha_npu.c  |  8 ++++++++
 drivers/net/ethernet/airoha/airoha_ppe.c  | 17 +++++++++++------
 drivers/net/ethernet/airoha/airoha_regs.h |  2 ++
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 8277c1c87bb3..da4a3ba69e3c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -617,6 +617,7 @@ struct airoha_ppe {
 
 	void *foe;
 	dma_addr_t foe_dma;
+	bool flow_stats_cap;
 
 	struct rhashtable l2_flows;
 
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
index 92611802801e..0957f331478a 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -37,10 +37,7 @@ static const struct rhashtable_params airoha_l2_flow_table_params = {
 
 static int airoha_ppe_get_num_stats_entries(struct airoha_ppe *ppe)
 {
-	if (!IS_ENABLED(CONFIG_NET_AIROHA_FLOW_STATS))
-		return -EOPNOTSUPP;
-
-	if (airoha_is_7583(ppe->eth))
+	if (!ppe->flow_stats_cap)
 		return -EOPNOTSUPP;
 
 	return PPE_STATS_NUM_ENTRIES;
@@ -144,6 +141,9 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 	sram_ppe_num_data_entries =
 		PPE_RAM_NUM_ENTRIES_SHIFT(sram_ppe_num_data_entries);
 
+	if (ppe->flow_stats_cap)
+		airoha_fe_clear(eth, PSE_FC_CFG, PSE_PORT6_SHARE_DIS);
+
 	for (i = 0; i < eth->soc->num_ppe; i++) {
 		airoha_fe_wr(eth, REG_PPE_TB_BASE(i),
 			     ppe->foe_dma + sram_tb_size);
@@ -1456,8 +1456,11 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 	if (ppe_num_stats_entries > 0) {
 		err = npu->ops.ppe_init_stats(npu, ppe->foe_stats_dma,
 					      ppe_num_stats_entries);
-		if (err)
-			goto error_npu_put;
+		if (err) {
+			dev_warn(eth->dev, "NPU refused flow stats (%d)\n",
+				 err);
+			ppe->flow_stats_cap = false;
+		}
 	}
 
 	airoha_ppe_hw_init(ppe);
@@ -1608,6 +1611,8 @@ int airoha_ppe_init(struct airoha_eth *eth)
 	ppe->dev.priv = ppe;
 	ppe->eth = eth;
 	eth->ppe = ppe;
+	ppe->flow_stats_cap = IS_ENABLED(CONFIG_NET_AIROHA_FLOW_STATS) &&
+			  !airoha_is_7583(eth);
 
 	ppe_num_entries = airoha_ppe_get_total_num_entries(ppe);
 	foe_size = ppe_num_entries * sizeof(struct airoha_foe_entry);
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

