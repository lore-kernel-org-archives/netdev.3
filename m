Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC18D43D501
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390471; cv=none; b=HgeX8koOlZHuTAWq1WRhAtX3TUb2aSwlDf3xD8pmzhIESsW0LDklAoFFBbxGJntjcpatcFHkUY88EO0ZiJdF5t/KgyvWpGMPR/1rNW3q2AXZCqlAulT47oSKjPfJJtMHdr0zvSzfSsojufiCuqTs/osO+q/JJggwbJjKbOMaKQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390471; c=relaxed/simple;
	bh=u7joOcgOzxYaaflQBw6fi/nmxweemJwXLMdeOrPrHog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAN99iKzxx5MwFEyY2h+ByNxdH7V5TaY+ltZEcs791p1R8VuX2og7ZHcZsfDeZ0qQD0OEevmMA1HBwzIVhmhDzQyVz/1o4Ja8b4GAqKGBMixSYW6pwdlHPxLbuk16zDpzOtAJZNgR7pAAWt09iMLNrKVtAZ7niNTXrOr40OPgFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6gcX3T7; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6gcX3T7"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4a45b3f0becso1211048b6e.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 16:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788390468; x=1788995268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4an3QHtrUZRmW1xplQbrBiHxTOwsbz4qUB+QkevuQm8=;
        b=O6gcX3T7als9C9S216AsD4CifMfr5nYyxs+Wvxn6xpKNYxMmnEd6N4JoAvmRFVsVQF
         XSBGOxnF/Qu/R7aynlJQO/Oqa6Lx5GDhcdGQMT9MpCb+S4TLnvZyVhSPe+u9yBRZSMzI
         UMZ+mc7j+Qy/guvBzTFZud50Q8LP4U6eeiNCpYzMovBIX48BfckBrxoQNAQvCRpuwF+5
         wknijoJ+3q2v3vBXBPuZQwoxUsakBA1YrkTruLTlmEGkGvD/LM0renTpRYdeHMp8U6DY
         ueDFLE1mOujnNAmJd39yAnONiBdHvbu5LDM27MCoVjzuwcFc65z7zbf6yEVqkFflIrTj
         EvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390468; x=1788995268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4an3QHtrUZRmW1xplQbrBiHxTOwsbz4qUB+QkevuQm8=;
        b=O2JGw5N7lFTY0I5zJ20GRnMsvKZ47x7Qf189GcpRadelKA0iuNqN6arZ4NgAWBbQjU
         xtEQWcl1kIUgPLhjwFTxYyuzzgCbuaNkkKFRSU4k8yJCETaUAzqma+f6qGuwEuiPvL/+
         3r5KEfD49vn+TKnx4RlLN10HHB/hVqUTAyklHNYaZIhr+zFNR0wVx0NhE0TnHLmTQhgW
         pD1Zx8AVG8q3wMLQvVYX2YdH5AYJ4MSxFnEHcpNi5dummY7Q7Bo3BI1kwYxzx0N9Ns/c
         t1KOP2fYBhIg7cuOdklSphLNMrXeLZfOQkMKCokZyMXWlw+cQ8QCnp6M/LYZuizb6sqC
         7Gkg==
X-Gm-Message-State: AFuF++nSgBmADKMfTCK4IVhRM3qyRy8Tcn+KlXeDB33VICMhQaQ/n8z7
	Y1ZaMbOMhvvpE9b2TbYuHK2O+3ikQ9Yc04fITfo7k5WmYpngOLGH9taI7fK4UsoS
X-Gm-Gg: AYBFou0V1rbMRLPkLrgzccf3FCVlhKUicRAu/qj49qRQwV7Q8qNUgwOE2Hn0S/DZQIX
	pToSLD8rqG1erZWuydShKH+DtCRzsEkPGZcCC0oAwbFe9PVCV8qPbxMS5VUdO7SB8E9vOIkauJv
	0iTu71NT9m3t1uGUCEnuUCvPE32pwTfl8o/QbE9fv6mCx79z+gV1mVikHdRkyRRCZk+JFT8Xn22
	Z9iFGB1P25E9zHlE033dotSCKGPG2c1436OXCNwUQtxKcE2UjV+8G+/EB+fCyIpVpvdsXs7aexe
	QRFWwVVdYuUnrii78pVPMUe9rWeU59bVQYhzsZoGvYG/Lv8svOYbcATtchfsqKnNI2yF0H96jo0
	zwIWC+6/635tTkCzLP8dKSY3SfiIV5uSOHvw0jaBPXxruHemiqxrV41tvJ9F9kCwpkjjmzViBCF
	tqCXc1i7BEmbk83el5SZUCpZPjv1/oZtEN23vjWR7pdh6bs5n/LFMxTO2rjw==
X-Received: by 2002:a05:6808:10d5:b0:4b5:a953:74c7 with SMTP id 5614622812f47-4b6bf9c3376mr6453410b6e.21.1788390468372;
        Wed, 02 Sep 2026 16:07:48 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:1c::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b69bd2800csm3354449b6e.17.2026.09.02.16.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:07:47 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	mohsin.bashr@gmail.com
Subject: [PATCH ethtool 2/3] ethtool: fbnic: Fix various TX and RX CSR fields decoding
Date: Wed,  2 Sep 2026 16:07:38 -0700
Message-ID: <20260902230739.2241212-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902230739.2241212-1-mohsin.bashr@gmail.com>
References: <20260902230739.2241212-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohsin Bashir <hmohsin@meta.com>

Align the TNI status and error bits, TCE interrupt status fields, and
TXB FIFO level width with the CSR definitions. Decode the previously
omitted TCE status fields and refresh the RX RBP double-bit error
value before printing it.

Fixes: a38a2d3a8271 ("ethtool: fbnic: ethtool dump parser")
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 fbnic.c | 133 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 100 insertions(+), 33 deletions(-)

diff --git a/fbnic.c b/fbnic.c
index e368c60..c9d217b 100644
--- a/fbnic.c
+++ b/fbnic.c
@@ -338,14 +338,25 @@
 #define FBNIC_TCE_TXB_BYTES_DEST_H(n)	(0x0402d + (n))	/* 0x100b4 + 4*n */
 #define FBNIC_TCE_TXB_BYTES_DEST_H_CNT		4
 #define FBNIC_TCE_INTR_STS		0x04031		/* 0x100c4 */
-#define FBNIC_TCE_INTR_STS_TBI_SOP_OVFL		CSR_BIT(26)
-#define FBNIC_TCE_INTR_STS_TTI_FRM_SOP_OVFL	CSR_BIT(25)
-#define FBNIC_TCE_INTR_STS_TTI_CM_SOP_OVFL	CSR_BIT(24)
-#define FBNIC_TCE_INTR_STS_TBI_QUIESCENCE	CSR_BIT(17)
-#define FBNIC_TCE_INTR_STS_TTI_QUIESCENCE	CSR_BIT(16)
+#define FBNIC_TCE_INTR_STS_TXB_CTRL_FIFO_ECC_MBE	CSR_BIT(31)
+#define FBNIC_TCE_INTR_STS_TXB_CTRL_FIFO_ECC_SBE	CSR_BIT(30)
+#define FBNIC_TCE_INTR_STS_TXB_DATA_FIFO_ECC_MBE	CSR_BIT(29)
+#define FBNIC_TCE_INTR_STS_TXB_DATA_FIFO_ECC_SBE	CSR_BIT(28)
+#define FBNIC_TCE_INTR_STS_TBI_QUIESCENCE	CSR_BIT(25)
+#define FBNIC_TCE_INTR_STS_TTI_QUIESCENCE	CSR_BIT(24)
+#define FBNIC_TCE_INTR_STS_TXB_ILLEGAL_PTP	CSR_BIT(21)
+#define FBNIC_TCE_INTR_STS_DATA_RX_BMC_UFLOW	CSR_BIT(20)
+#define FBNIC_TCE_INTR_STS_DATA_MC_UFLOW		CSR_BIT(18)
+#define FBNIC_TCE_INTR_STS_DATA_TX_BMC_UFLOW	CSR_BIT(16)
+#define FBNIC_TCE_INTR_STS_TBI_SOP_OVFL		CSR_BIT(13)
+#define FBNIC_TCE_INTR_STS_TTI_FRM_SOP_OVFL	CSR_BIT(12)
+#define FBNIC_TCE_INTR_STS_TTI_CM_SOP_OVFL	CSR_BIT(11)
 #define FBNIC_TCE_INTR_STS_BMC_ELSTC_OVFL	CSR_BIT(10)
 #define FBNIC_TCE_INTR_STS_TEI_ELSTC_OVFL	CSR_BIT(9)
 #define FBNIC_TCE_INTR_STS_TDE_ELSTC_OVFL	CSR_BIT(8)
+#define FBNIC_TCE_INTR_STS_CTRL_RX_BMC_OVFL	CSR_BIT(7)
+#define FBNIC_TCE_INTR_STS_CTRL_MC_OVFL		CSR_BIT(6)
+#define FBNIC_TCE_INTR_STS_CTRL_TX_BMC_OVFL	CSR_BIT(5)
 #define FBNIC_TCE_INTR_STS_DATA_RX_BMC_OVFL	CSR_BIT(4)
 #define FBNIC_TCE_INTR_STS_DATA_RX_TEI_OVFL	CSR_BIT(3)
 #define FBNIC_TCE_INTR_STS_DATA_MC_OVFL		CSR_BIT(2)
@@ -355,7 +366,7 @@
 #define FBNIC_TCE_INTR_SET		0x04033		/* 0x100cc */
 #define FBNIC_TCE_TXB_DATA_Q_LVL(n)	(0x04034 + (n))	/* 0x100d0 + 4*n */
 #define FBNIC_TCE_TXB_DATA_Q_LVL_CNT		5
-#define FBNIC_TCE_TXB_DATA_Q_LVL_VALUE		CSR_GENMASK(12, 0)
+#define FBNIC_TCE_TXB_DATA_Q_LVL_VALUE		CSR_GENMASK(11, 0)
 #define FBNIC_TCE_TXB_INGR_Q_LVL	0x04039		/* 0x100e4 */
 #define FBNIC_TCE_TXB_INGR_TXB_BMC_ELASTIC	CSR_GENMASK(23, 16)
 #define FBNIC_TCE_TXB_INGR_TXB_TEI_ELASTIC	CSR_GENMASK(15, 8)
@@ -962,15 +973,15 @@
 #define FBNIC_QM_TNI_TCM_CTL_CLS			CSR_GENMASK(3, 2)
 #define FBNIC_QM_TNI_TCM_CTL_MPS			CSR_GENMASK(1, 0)
 
-#define FBNIC_QM_TNI_TCM_STS_TCM_NOCIF_IDLE_DP		CSR_BIT(2)
-#define FBNIC_QM_TNI_TCM_STS_TDE_NOCIF_IDLE_DP		CSR_BIT(1)
-#define FBNIC_QM_TNI_TCM_STS_TDF_NOCIF_IDLE_DP		CSR_BIT(0)
+#define FBNIC_QM_TNI_TCM_STS_TCM_NOCIF_IDLE_DP		CSR_BIT(5)
+#define FBNIC_QM_TNI_TCM_STS_TDE_NOCIF_IDLE_DP		CSR_BIT(4)
+#define FBNIC_QM_TNI_TCM_STS_TDF_NOCIF_IDLE_DP		CSR_BIT(3)
 #define FBNIC_QM_TNI_TCM_STS_TCM_NOCIF_IDLE		CSR_BIT(2)
 #define FBNIC_QM_TNI_TCM_STS_TDE_NOCIF_IDLE		CSR_BIT(1)
 #define FBNIC_QM_TNI_TCM_STS_TDF_NOCIF_IDLE		CSR_BIT(0)
 
-#define FBNIC_QM_TNI_ERR_INTR_STS_TQS_FIFO1_UFLOW	CSR_BIT(3)
-#define FBNIC_QM_TNI_ERR_INTR_STS_TQS_FIFO0_UFLOW	CSR_BIT(2)
+#define FBNIC_QM_TNI_ERR_INTR_STS_TQS_FIFO1_UFLOW	CSR_BIT(5)
+#define FBNIC_QM_TNI_ERR_INTR_STS_TQS_FIFO0_UFLOW	CSR_BIT(4)
 #define FBNIC_QM_TNI_ERR_INTR_STS_TDE_ROB_DBE		CSR_BIT(3)
 #define FBNIC_QM_TNI_ERR_INTR_STS_TDE_ROB_SBE		CSR_BIT(2)
 #define FBNIC_QM_TNI_ERR_INTR_STS_TDF_ROB_DBE		CSR_BIT(1)
@@ -6672,6 +6683,7 @@ static int fbnic_dump_fb_nic_qm_rx_global(uint32_t **regs_buffp,
 				"  [0:0] RBP_SINGLE_BIT: 0x%02x\n",
 				bf_val);
 			m = FBNIC_QM_RNI_ERR_INTR_STS_RBP_DBE;
+			bf_val = FIELD_GET(m, reg_val);
 			fprintf(stdout,
 				"  [01:01] RBP_DOUBLE_BIT: 0x%02x\n",
 				bf_val);
@@ -7043,6 +7055,71 @@ static int fbnic_dump_fb_nic_tce(uint32_t **regs_buffp,
 			fprintf(stdout,
 				"FBNIC_TCE_INTR_STS: 0x%08x\n",
 				reg_val);
+			m = FBNIC_TCE_INTR_STS_TXB_CTRL_FIFO_ECC_MBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [31:31] TXB_CTRL_FIFO_ECC_MBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_TXB_CTRL_FIFO_ECC_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [30:30] TXB_CTRL_FIFO_ECC_SBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_TXB_DATA_FIFO_ECC_MBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [29:29] TXB_DATA_FIFO_ECC_MBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_TXB_DATA_FIFO_ECC_SBE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [28:28] TXB_DATA_FIFO_ECC_SBE: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_TBI_QUIESCENCE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [25:25] TBI_QUIESCENCE_DET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_TTI_QUIESCENCE;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [24:24] TTI_QUIESCENCE_DET: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_TXB_ILLEGAL_PTP;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [21:21] TXB_ILLEGAL_PTP: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_DATA_RX_BMC_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [20:20] TXB_DATA_FIFO_RX_BMC_UFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_DATA_MC_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [18:18] TXB_DATA_FIFO_MC_UFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_DATA_TX_BMC_UFLOW;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [16:16] TXB_DATA_FIFO_TX_BMC_UFLOW: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_TBI_SOP_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [13:13] TBI_SOP_FIFO_OVFL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_TTI_FRM_SOP_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [12:12] TTI_FRAME_SOP_FIFO_OVFL: 0x%02x\n",
+				bf_val);
+			m = FBNIC_TCE_INTR_STS_TTI_CM_SOP_OVFL;
+			bf_val = FIELD_GET(m, reg_val);
+			fprintf(stdout,
+				"  [11:11] TTI_CM_SOP_FIFO_OVFL: 0x%02x\n",
+				bf_val);
 			m = FBNIC_TCE_INTR_STS_DATA_TX_TEI_OVFL0;
 			bf_val = FIELD_GET(m, reg_val);
 			fprintf(stdout,
@@ -7068,45 +7145,35 @@ static int fbnic_dump_fb_nic_tce(uint32_t **regs_buffp,
 			fprintf(stdout,
 				"  [04:04] TXB_DATA_FIFO_RX_BMC_OVFL: 0x%02x\n",
 				bf_val);
-			m = FBNIC_TCE_INTR_STS_TDE_ELSTC_OVFL;
-			bf_val = FIELD_GET(m, reg_val);
-			fprintf(stdout,
-				"  [08:08] TXB_INTR_FIFO_TDE_OVFL: 0x%02x\n",
-				bf_val);
-			m = FBNIC_TCE_INTR_STS_TEI_ELSTC_OVFL;
-			bf_val = FIELD_GET(m, reg_val);
-			fprintf(stdout,
-				"  [09:09] TXB_INTR_FIFO_TEI_OVFL: 0x%02x\n",
-				bf_val);
-			m = FBNIC_TCE_INTR_STS_BMC_ELSTC_OVFL;
+			m = FBNIC_TCE_INTR_STS_CTRL_TX_BMC_OVFL;
 			bf_val = FIELD_GET(m, reg_val);
 			fprintf(stdout,
-				"  [10:10] TXB_INTR_FIFO_BMC_OVFL: 0x%02x\n",
+				"  [05:05] TXB_CTRL_FIFO_TX_BMC_OVFL: 0x%02x\n",
 				bf_val);
-			m = FBNIC_TCE_INTR_STS_TTI_QUIESCENCE;
+			m = FBNIC_TCE_INTR_STS_CTRL_MC_OVFL;
 			bf_val = FIELD_GET(m, reg_val);
 			fprintf(stdout,
-				"  [16:16] TTI_QUIESCENCE_DET: 0x%02x\n",
+				"  [06:06] TXB_CTRL_FIFO_MC_OVFL: 0x%02x\n",
 				bf_val);
-			m = FBNIC_TCE_INTR_STS_TBI_QUIESCENCE;
+			m = FBNIC_TCE_INTR_STS_CTRL_RX_BMC_OVFL;
 			bf_val = FIELD_GET(m, reg_val);
 			fprintf(stdout,
-				"  [17:17] TBI_QUIESCENCE_DET: 0x%02x\n",
+				"  [07:07] TXB_CTRL_FIFO_RX_BMC_OVFL: 0x%02x\n",
 				bf_val);
-			m = FBNIC_TCE_INTR_STS_TTI_CM_SOP_OVFL;
+			m = FBNIC_TCE_INTR_STS_TDE_ELSTC_OVFL;
 			bf_val = FIELD_GET(m, reg_val);
 			fprintf(stdout,
-				"  [24:24] TTI_CM_SOP_FIFO_OVFL: 0x%02x\n",
+				"  [08:08] TXB_INTR_FIFO_TDE_OVFL: 0x%02x\n",
 				bf_val);
-			m = FBNIC_TCE_INTR_STS_TTI_FRM_SOP_OVFL;
+			m = FBNIC_TCE_INTR_STS_TEI_ELSTC_OVFL;
 			bf_val = FIELD_GET(m, reg_val);
 			fprintf(stdout,
-				"  [25:25] TTI_FRAME_SOP_FIFO_OVFL: 0x%02x\n",
+				"  [09:09] TXB_INTR_FIFO_TEI_OVFL: 0x%02x\n",
 				bf_val);
-			m = FBNIC_TCE_INTR_STS_TBI_SOP_OVFL;
+			m = FBNIC_TCE_INTR_STS_BMC_ELSTC_OVFL;
 			bf_val = FIELD_GET(m, reg_val);
 			fprintf(stdout,
-				"  [26:26] TBI_SOP_FIFO_OVFL: 0x%02x\n",
+				"  [10:10] TXB_INTR_FIFO_BMC_OVFL: 0x%02x\n",
 				bf_val);
 		break;
 		case FBNIC_TCE_INTR_MASK:
-- 
2.53.0-Meta

