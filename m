Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FB34749F3
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452921; cv=none; b=ZZ+CbDyOEPX/IrbjYorwcp7XtheqdcELwx5Q0C0z3B3SgK10xptyEisN0UTdsTac94JkmbKervtLaCrpK7SMMCLqAeafYulSIBwQ2Tob1MbVRmWh9AWc6/jLhfh+ENcYEXoqm6RE5/8J8Ar75b4iiuL6ooYVRGTOU2HHhqp1Sgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452921; c=relaxed/simple;
	bh=YRGYay7QoG29PFapg7AmLs4zCXRLS0ZSDJ4BjJStC8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z+zimmOunbffqdThiWCmim3uozyOLur8Y2irYYIyHpFgY/EHJcVk1wIxu+txurfCEtK9Tr7jqYtMFdeZBne77Jkya3TAEZRSawiklyhEMMRB6VFF51Kq0A2PZhZArQRmsWV9yCH27OPbVVbEAL6pktom3ckgsq3Kh6xVFxEWJ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1BBfBNs; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1BBfBNs"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-141395927feso4464505c88.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 02:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791452919; x=1792057719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7xX55VUfzLKlrT3hfK4oyi6LOjpzbgNl+xyMCeoTYMs=;
        b=h1BBfBNsS6+cQQXj6uc4K3Hoa4/m/+bnhiJt/SBzgCRFlCQacrWUXg0R7NKndc/6xG
         e6sMHqUBZhVW/UypsCs7ELHyGJGpFNJdpGZLNChlorbkZ6zpuVj8u2urTOta+3xJVhFr
         y5VF4siJeZn217lhMoajUz2BbEWeTRqYNi/TOTYqWT0WWcQ4ExsCb1w/Dh5/LY7WUDF1
         L4Kc0cI1gUc7RY7nopZpynK+s+inHkvGKPPBs7DZsryr7OeJY1tA6e1LKIXdqmLkPeHc
         YfKxHezmSVAU0klqRRazcK437b3E0bCxD86ufsis3CTjRTyKjmleT+hotkFw71fn0P3j
         qJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791452919; x=1792057719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7xX55VUfzLKlrT3hfK4oyi6LOjpzbgNl+xyMCeoTYMs=;
        b=GzPo3Lk+h94UZY7sSv8p9yrw9OgBhyEI1iADGLTgnsqf9PnS3fZnE91UgIMrguVFEJ
         Xq3HgAQ2npkM5+fy/vbK9wjP/NhAy2I1+7cXO4Diw8igOnah7IZ1yzbrngG24Tie6VsF
         kMmvqbROeBNj2NhjqacPfZwMIyRZIDhzCqfyswnL31hf9Z9oRG3y0Pij8d9HcugVIg1I
         JCmXo2r0ZrkZYAMSTCOOUbhIyHcbl4IibsiG3enxtrY0nqNVEoBUYuiaclr0IPwnNYxZ
         s3pJxJNN23ni1hZTDGhi4/+PA5friLLv5fxzD/fY+K5BQJvlDd1UGvQounowE0kLQeLk
         IsDA==
X-Gm-Message-State: AFuF++nwuax5n4E6fxTjXSWaZDB9UBGpomFhLhK3KqH4kiD1Pamn2RVj
	95gZ6VYers2jBRVxuR9fsWo8Kp0mjhrLitIzsW4Rp3ebvlbkHCeHID3RVK7NsbOF
X-Gm-Gg: AYBFou26VoqFFjDVw3KENCVD6dR0gbTVGuxy09NeGdyyCLnRwezbHqo7INtteYMSfVc
	AI51kXZ+hgC9HLgV1ZCMYkBZdcu8T2zTSP7EjEnLDj9iy4rZ7k3wmlVszCk9A9/tKgqdZFFVjdh
	IS+f8E8Jd+4Y3Xk3stzRNmlaByHY54xgTkxJic3MKHCL/DjTA+fmgtk57aSSsc+Q5ALtzQwtRY9
	N6/8GIXzMJDZSS4/C9XSssXRdr+RuKleT2kAW1YvY+52Zg0jFP53DqO4a48fa1hxwepPk+oBKiL
	bO38cM/YPkvQ8USjs2DZrj6xfvx2A9AHzhFSYfLV9g5Q6oPiC3HYQbPEKM8fWF4UDCIb5mQR2kr
	0eSK6a+TVuHev9YzrgfWmdXmoVoATI6nNcdDDOnDB/Wkf1mpk3fCGn7xzhjLEne90TJhHvtsQaF
	KGjc2jVnpuGhHUOT1i3dAeOn6bvVE2+353aU9bX5+UE1dEnU8QSHw8z+uegvl2yq70iJXD4a1Hw
	5+euyJnOJGSNzxSLScqT37+ZwIic9bBymbeaMf9BSKjmRzb7Q==
X-Received: by 2002:a05:7022:3d10:b0:143:297c:82e0 with SMTP id a92af1059eb24-16206c267aamr7410634c88.32.1791452918834;
        Thu, 08 Oct 2026 02:48:38 -0700 (PDT)
Received: from nbai25050026.. ([2403:8600:2090:6f:26c1:d3cd:9bcc:c4d3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1616a49546fsm13107565c88.18.2026.10.08.02.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:48:38 -0700 (PDT)
From: SAYANTAN NANDY <sayantann11@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	bread.hsu@airoha.com,
	sayantan.nandy@airoha.com,
	SAYANTAN NANDY <sayantann11@gmail.com>
Subject: [PATCH net] net: airoha: keep PPE offload when NPU refuses flow stats
Date: Thu,  8 Oct 2026 15:18:28 +0530
Message-ID: <20261008094828.15458-1-sayantann11@gmail.com>
X-Mailer: git-send-email 2.43.0
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
refusal. A zero address does not provide a usable counter region and
must not be passed to the address mapping path.

When flow statistics are unavailable, PPE continues to operate
without NPU flow counters while retaining normal offload functionality.

This combines the original SmartRG/Airoha fixes for:
- keeping PPE offload active when the NPU refuses flow statistics
- treating a zero NPU statistics address as a flow-statistics refusal

Based on the original SmartRG/Airoha work by Chad Monroe:
5ce96ab ("SDG-9458: keep PPE offload when NPU refuses flow stats")
0ad8528 ("SDG-9458: airoha: treat a zero NPU stats address as a refusal")
Fixes: b81e0f2b58be ("net: airoha: Add FLOW_CLS_STATS callback support")
Signed-off-by: Chad Monroe <chad@monroe.io>
Signed-off-by: SAYANTAN NANDY <sayantann11@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.h  |  1 +
 drivers/net/ethernet/airoha/airoha_npu.c  |  8 ++++++++
 drivers/net/ethernet/airoha/airoha_ppe.c  | 20 +++++++++++++-------
 drivers/net/ethernet/airoha/airoha_regs.h |  2 ++
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 8277c1c87bb3..bd5a94fce843 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -617,6 +617,7 @@ struct airoha_ppe {
 
 	void *foe;
 	dma_addr_t foe_dma;
+	bool flow_stats;
 
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
index 92611802801e..fbc200614de3 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -37,10 +37,7 @@ static const struct rhashtable_params airoha_l2_flow_table_params = {
 
 static int airoha_ppe_get_num_stats_entries(struct airoha_ppe *ppe)
 {
-	if (!IS_ENABLED(CONFIG_NET_AIROHA_FLOW_STATS))
-		return -EOPNOTSUPP;
-
-	if (airoha_is_7583(ppe->eth))
+	if (!ppe->flow_stats)
 		return -EOPNOTSUPP;
 
 	return PPE_STATS_NUM_ENTRIES;
@@ -144,6 +141,10 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 	sram_ppe_num_data_entries =
 		PPE_RAM_NUM_ENTRIES_SHIFT(sram_ppe_num_data_entries);
 
+	if (ppe->flow_stats)
+		airoha_fe_rmw(eth, PSE_FC_CFG, PSE_PORT6_SHARE_DIS,
+			      FIELD_PREP(PSE_PORT6_SHARE_DIS, 0));
+
 	for (i = 0; i < eth->soc->num_ppe; i++) {
 		airoha_fe_wr(eth, REG_PPE_TB_BASE(i),
 			     ppe->foe_dma + sram_tb_size);
@@ -1456,10 +1457,13 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 	if (ppe_num_stats_entries > 0) {
 		err = npu->ops.ppe_init_stats(npu, ppe->foe_stats_dma,
 					      ppe_num_stats_entries);
-		if (err)
-			goto error_npu_put;
+		if (err) {
+			dev_warn(eth->dev,
+				 "NPU firmware refused flow stats setup (%d), offload runs without flow counters\n",
+				 err);
+			ppe->flow_stats = false;
+		}
 	}
-
 	airoha_ppe_hw_init(ppe);
 	airoha_ppe_foe_flow_stats_reset(ppe, npu);
 
@@ -1608,6 +1612,8 @@ int airoha_ppe_init(struct airoha_eth *eth)
 	ppe->dev.priv = ppe;
 	ppe->eth = eth;
 	eth->ppe = ppe;
+	ppe->flow_stats = IS_ENABLED(CONFIG_NET_AIROHA_FLOW_STATS) &&
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

