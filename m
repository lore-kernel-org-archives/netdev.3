Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C54456DEF
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 23:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390473; cv=none; b=JVzmyEctpoUk57rrwQFMWPOawPKcYpwtlQCumFz1IHjI1V1HyYuhneYNBxJifXgxbvPPoZk0di1WE/lqFfeaiJmTgJS0XTDi+825uogMiK8qL1JwHiBn/C0UhnFgWW9KGbms8XLppWUhgD63B3pxg61bnpxDVLgDewGyLw3tqow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390473; c=relaxed/simple;
	bh=naD5BjNGGB+bxQetb0UlrNejEPDdAxulrt9+L82dSnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9e7eg1LHRhA2zKLn+HFzSGnL71iNPhYe1u8wuqU5Ag5Q6qBY7TzVgtWUMBf2xpfsrL5EF3wfPEy3ht62N3NlWqqeblAeiD6WhoMvJrT80ZfuvKZJ4QfaOKGmutc7C6yn3gTNEi5+gbynq2C0fIez/Bhf7lFE9dlrdYqtPBnm/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQGfdslS; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQGfdslS"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f18c0e03e3so908921a34.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 16:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788390471; x=1788995271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fIY2QzXkNI9nauKaEMM+WiBsvMZTTniLfYMvT2cfCLk=;
        b=EQGfdslStWfXxYxKuyAa6QlSDojMkdMCisYBkdbvKyQSS8L3ZLZA7oNtPJQyjZZKVo
         ML5DMQSdBz7H9XvMWp/IGXACkdeB8XhyAPtyR5vx46m2LObDNRO3MBNqBCKInSZVUt63
         LD5d07KbRZ9mclh4eDf8prRDT80mc0YeDcHyGcTRK+gG/Ij2E2qW3WmktSafSDZcFJJZ
         NhJ5aQSrh1r2yj+u2Jg3n1qc2sjWXx4EAdGf1e91qeIycjQh5ZHpAhUVTrOQg5w+NQhj
         ccuKVMkD9oMZH+CCS4lWoW575s0AU7d/ikw+RRPT1qVczjX4At8wnpvLkplt6ZpM0Va7
         SMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390471; x=1788995271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fIY2QzXkNI9nauKaEMM+WiBsvMZTTniLfYMvT2cfCLk=;
        b=nDb0ggDxA9R9O2E8ysIVmT9PfYlXf5CZWBN6tOJQ88eGcOfp+dRFSebtIBf/+ev4Ay
         hRsbOdpWXf13CXwjZW8s802feoGaLjvk0swaxDqedoCfiQ3K+x7uFmF2ebmReXzLs8ym
         dt/u+FrnYmmQk0NOEFCYzvwglbKpD8AZSDhjSPIBYEto/tDBp8ZlcqAG/LFx2GA4geYE
         lOQ6ED9y9JCaOxD+ARN/nYpquEasebggRaddSOz21vGT4gTJvjHV4hasgPq9Zz6kCov6
         OmW1Mh1zOGhKGaLYJI0HXBCQ2Nl6EnReFeIYXZbCuR2QVvBpKRQDzrG0LuCJEREaeRUk
         fwpA==
X-Gm-Message-State: AFuF++nuNt8Hp1zNgAGuwgymKigbvLA/ieoLwKT5/3RwQMenxeBF45Vs
	KDYRQ54gDAiacQWH2EdLPjIC1kkb0q0o7fNW0BJXCHBBmeIdQQBmuE+I4QjmeaK/
X-Gm-Gg: AYBFou2vBMbyiRLa2TmBvU8moUVlxRInXRXveTelxv+lOPbG70j3Zy3FGIFR525Ka3X
	J1JuaffeYzYic87EHDkxxSBfo4ITFuRMCKFhBOkcA3JgJUSb7tIRbcX3QRvU4m4qndPSGg5Zw/K
	iMz2FdrDp971wSZTEHLzMRD6ESp6jBU9HluuiKI9FmUZMNBuKOfS8pU4Tip6u76pZt/Uq+KnCqy
	dmqJgU/cNjkZ1AycrD1R1EhBQsjxP65lP86NOBkM1YC07CJykUJM8bav5ZbLkmjevtvLgZ/9xHA
	xWYw3t2oedbGqT9Av/JfGY/0Am4/jlX1Zj/rkMRNVXCjVWSfQwic1PGJWxR0UGcB+KztWZIFoDa
	v0NtSx+ipgsGQ8gCNAjd7EprwzWrw5+Ir52nVGcSC6VvUSEj59LgtEEpL/W4WWcVe2U/pecLVoc
	ALkbW5cNEtIY1fGCoWgKcHf7afbl/0tJT0l6n4LbdIxWVXLppp6O2pv/9z/A==
X-Received: by 2002:a05:6830:6d50:b0:7d7:ea9f:c0f9 with SMTP id 46e09a7af769-7f77c3da0c5mr8911907a34.0.1788390470973;
        Wed, 02 Sep 2026 16:07:50 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f74d1b2042sm3606890a34.8.2026.09.02.16.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:07:50 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	mohsin.bashr@gmail.com
Subject: [PATCH ethtool 3/3] ethtool: fbnic: Fix register dump names and bit labels
Date: Wed,  2 Sep 2026 16:07:39 -0700
Message-ID: <20260902230739.2241212-4-mohsin.bashr@gmail.com>
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

Use the hardware register names for the TQS global and TNI status registers.
While at it, print full-width status values, and fix the incorrect bit-range
and field labels.

Fixes: a38a2d3a8271 ("ethtool: fbnic: ethtool dump parser")
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 fbnic.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fbnic.c b/fbnic.c
index c9d217b..e946ee3 100644
--- a/fbnic.c
+++ b/fbnic.c
@@ -5944,7 +5944,7 @@ static int fbnic_dump_fb_nic_qm_tx_global(uint32_t **regs_buffp,
 		break;
 		case FBNIC_QM_TQS_MTU_STS_0:
 			fprintf(stdout,
-				"FBNIC_QM_TQS_MTU_STS_0: 0x%08x\n",
+				"FBNIC_QM_TQS_GLOBAL_STS0: 0x%08x\n",
 				reg_val);
 			m = FBNIC_QM_TQS_STS0_TXB_MC_FIFO_CRDTS_USED;
 			bf_val = FIELD_GET(m, reg_val);
@@ -5953,7 +5953,7 @@ static int fbnic_dump_fb_nic_qm_tx_global(uint32_t **regs_buffp,
 		break;
 		case FBNIC_QM_TQS_MTU_STS_1:
 			fprintf(stdout,
-				"FBNIC_QM_TQS_MTU_STS_1: 0x%08x\n",
+				"FBNIC_QM_TQS_GLOBAL_STS1: 0x%08x\n",
 				reg_val);
 			m = FBNIC_QM_TQS_STS1_TXB_BMC_FIFO_CRDTS_USED;
 			bf_val = FIELD_GET(m, reg_val);
@@ -6188,7 +6188,7 @@ static int fbnic_dump_fb_nic_qm_tx_global(uint32_t **regs_buffp,
 		break;
 		case FBNIC_QM_TNI_TCM_STS:
 			fprintf(stdout,
-				"FBNIC_QM_TNI_TCM_STS: 0x%02x\n",
+				"FBNIC_QM_TNI_STS: 0x%08x\n",
 				reg_val);
 			m = FBNIC_QM_TNI_TCM_STS_TDF_NOCIF_IDLE;
 			bf_val = FIELD_GET(m, reg_val);
@@ -6670,7 +6670,7 @@ static int fbnic_dump_fb_nic_qm_rx_global(uint32_t **regs_buffp,
 			m = FBNIC_QM_RNI_STS_RCM_IDLE_DP;
 			bf_val = FIELD_GET(m, reg_val);
 			fprintf(stdout,
-				"  [02:02] RCM_NOCIF_IDLE_DP: 0x%02x\n",
+				"  [05:05] RCM_NOCIF_IDLE_DP: 0x%02x\n",
 				bf_val);
 		break;
 		case FBNIC_QM_RNI_ERR_INTR_STS:
@@ -7194,7 +7194,7 @@ static int fbnic_dump_fb_nic_tce(uint32_t **regs_buffp,
 				i, reg_val);
 			m = FBNIC_TCE_TXB_DATA_Q_LVL_VALUE;
 			bf_val = FIELD_GET(m, reg_val);
-			fprintf(stdout, "  [12:00] FIFO_LEVEL: 0x%05x\n",
+			fprintf(stdout, "  [11:00] FIFO_LEVEL: 0x%05x\n",
 				bf_val);
 		break;
 		case FBNIC_TCE_TXB_INGR_Q_LVL:
@@ -7578,11 +7578,11 @@ static int fbnic_dump_fb_nic_tce_ram(uint32_t **regs_buffp,
 				bf_val);
 			m = FBNIC_TCE_RAM_TCAM3_MCQ_MASK;
 			bf_val = FIELD_GET(m, reg_val);
-			fprintf(stdout, "  [06:06] MCQ MASK: 0x%02x\n",
+			fprintf(stdout, "  [07:07] MCQ MASK: 0x%02x\n",
 				bf_val);
 			m = FBNIC_TCE_RAM_TCAM3_VALIDATE;
 			bf_val = FIELD_GET(m, reg_val);
-			fprintf(stdout, "  [31:31] MCQ MASK: 0x%02x\n",
+			fprintf(stdout, "  [31:31] VALIDATE: 0x%02x\n",
 				bf_val);
 		break;
 		default:
-- 
2.53.0-Meta

