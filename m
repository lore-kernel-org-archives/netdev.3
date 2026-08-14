Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0402445D1B9
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705243; cv=none; b=elpP0n7B/TdHUjvhp3pKELBVWFnQ4Q23R9UCuv3yr3j2AaPP8ICsd1LUjNbaji19D/rRdvjpQNec6rKSej5t532MG/QqZrUdNYuh8Ggmtst/v1KBlK7MHP5fH5IRpn2x78mmAIu2Em4akIrrwG3/hDjAF9hqJhb94fAMM2J0t+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705243; c=relaxed/simple;
	bh=5c1qzxn3eQTa/iff3NtZx81Q1PIOKP+L6PkEFSu6JWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JkjUIybWMKjO8xcynKxHQ13GJjfDHrO4kNnbpZ5/S6A5Vc9LiO5Azzu8TPDZc3m8YcKWIwsvh23KQ3Ct6cZG1isHVHSNQ7IqM3xH+qVBjNYAFrjsudLgU4lMAYqdlfg+M2VyKjl+bbqclXtLD9eq0laAidEz5v7h1TzbPsdN6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjBUwR3i; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjBUwR3i"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4956242332dso9083805e9.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 04:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786705234; x=1787310034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZWrUQY6MdEmAwjEPwEDco+lhwZ1hkXa6LAwLt7wwMi0=;
        b=AjBUwR3i+AQFDjsOatR8Zcd33zWRdlY6xijrfPWOjHccniHcEXpSQPoZRg0R9DmWJx
         iJFQyMzSWpy3oZom/CSjA6H/Sazah+ifEsQpCTwBZp9b3lXPUz09oYfA2XlV/MsdJO7B
         i5CTL6nBvUOAW26b6GU90SBQZevvFaAItqShYwMoRjlVZ7wltb/9N+Ec51OfFe6/fhSe
         SoiGZatvcKwM2soNvd2UxDMoIVz1c8PC+k+1y+xula7SmW0w/aZDdtOcaOe/udvWL3z/
         fqhHmxboaINEbwzH3Jue85V6zZAXluEnjKr4pDa7dDVERK0Tb7DzigndMppag+hX7hHs
         uY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786705234; x=1787310034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZWrUQY6MdEmAwjEPwEDco+lhwZ1hkXa6LAwLt7wwMi0=;
        b=CJr/Pd60S/lOINlyEL0YusYM+rVbO883pOpz1+X122FGyAJB6cxDfppwnRYArAsn9O
         tOrRvE1UTw0o3FJ0t4MRBGGC+vz5+OAs+DW8mStOB0G65POHLz8A58+tJXsuHytUE3iq
         R+AwTiKQyQYmGYilMeNmNdakLBJJdSxsknf2Rlr/6PP1VRALRiti3gCywUbUO/QIl+PG
         g26x93FyhhASggICDbYddXHSVVScqrGgGQnRkbosJNaDl1i9lBX4YLnVfhRNO9IZ6GIB
         fss768dn0+ROxDPTKqTps+Tdx6r/tKbjelCnvibQmGbi2f1JQp27s1CRRuJrlIBrOfqc
         Lmwg==
X-Gm-Message-State: AOJu0Yy/XtXDs0DpUTJIo/j2t0ErvXWhVgO/harZwgg7XuZsvdiFMfRR
	2Gb3qjuADaOADN7vzdiNt40XpYxR9hnvDSEj29tIn8N2s7V/Pf8Vuioqk0XyLrcn
X-Gm-Gg: AR+sD10Ug1aotoi20mvB3TAZka3vvwb+EeMrrZB568yDdwlKuaQ0yJ5KXSyb3tDfJj6
	nw9iQ4ihGW6u+gUn8h1ftxxcIDIplG66V4YCyURrj+beXr+hKrNMQolGtxAD4B2HJe2DTTDZF/r
	Phi/zGP8C+epNc3nDOOQLM2iXOs1iSILc3B/ZeGEom9VCN7bbkzPrhF1XWxBXvRFPCVikez7n1J
	BeK3gbPCDEghJFVWzNQy9Y8iW8aY2h6Ky07aA3Er0D+YNMH2MKx7EmqyEX3Jolw++WqHvXahxxw
	yu2jlcFwD03SSlQmWUbWT8M5zWpVgEdFJqync3G15wFM93sQEzQaB0GGyGnGyRPgwewg7GvRNI0
	x0V+VCmC9FR+ton1hXFRvVVnixBdnQxCTagMUun3zW4mW0SlFCUk4YE1e+l1yWQij1jLPIAVV0C
	vEUCIoB3FILQwpk5PHBrcvCqhI2f6AOmFVfWap3JiqWpgXccIjoGlxDZ/YOBWj/K4qFyaVx62L/
	xtNCIE+DWbNK2Hm3Ofbp4FqSja73kTGkT28npC6Fc0=
X-Received: by 2002:a05:600c:6dc3:b0:499:78b3:7b36 with SMTP id 5b1f17b1804b1-4998798091amr44356085e9.11.1786705234133;
        Fri, 14 Aug 2026 04:00:34 -0700 (PDT)
Received: from fedora ([46.205.219.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f200752sm7813507f8f.1.2026.08.14.04.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 04:00:33 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	win847@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH v7] net: airoha: npu: use aligned streaming DMA for mailbox messages
Date: Fri, 14 Aug 2026 13:00:17 +0200
Message-ID: <20260814110017.2795022-1-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On EN7581 + MT7996 (Gemtek W1700K), mapping small caller buffers with
DMA_BIDIRECTIONAL regresses NPU version probe: the mailbox completes
successfully but WLAN_FUNC_GET_WAIT_NPU_VERSION reads as 0.0 instead of
0.1111.

Bounce mailbox traffic through a per-core cacheline-aligned buffer
allocated at probe. Map ALIGN(len, SMP_CACHE_BYTES) with
DMA_BIDIRECTIONAL while programming the original payload length into the
mailbox length register. Copy the reply only after dma_unmap_single() so
the CPU sees the NPU-written payload on non-coherent DMA.

Introduce __airoha_npu_send_msg() with an optional reply pointer so GET
callers can copy the trailing response payload once. Keep
airoha_npu_send_msg() as a wrapper that copies the full response back
into the caller buffer, matching the old bidirectional mapping.

Tested on Quantum Fiber / Gemtek W1700K (EN7581 + MT7996), kernel
6.18.44, including two cold reboots and sustained WiFi use.

Fixes: 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox buffer")
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260805070851.2885888-1-pawlik.dan@gmail.com/
Assisted-by: Cursor:composer-2
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_npu.c  | 62 ++++++++++++++++++-----
 include/linux/soc/airoha/airoha_offload.h |  1 +
 2 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index b679bed952de..2ba78bf0e97b 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/devcoredump.h>
+#include <linux/dma-mapping.h>
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
 #include <linux/of_net.h>
@@ -23,6 +24,8 @@
 #define NPU_EN7581_FIRMWARE_RV32_MAX_SIZE	0x200000
 #define NPU_EN7581_FIRMWARE_DATA_MAX_SIZE	0x10000
 #define NPU_DUMP_SIZE				512
+/* Maximum mailbox DMA payload (PPE ~28 bytes, WLAN TLV up to 24). */
+#define AIROHA_NPU_MBOX_SIZE			256
 
 #define REG_NPU_LOCAL_SRAM		0x0
 
@@ -160,23 +163,33 @@ struct wlan_mbox_data {
 	DECLARE_FLEX_ARRAY(u8, d);
 };
 
-static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
-			       void *p, int size)
+static int __airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
+				 const void *data, int len, void *reply,
+				 u16 reply_len)
 {
-	u16 core = 0; /* FIXME */
-	u32 val, offset = core << 4;
+	struct airoha_npu_core *core = &npu->cores[0]; /* FIXME: core */
 	dma_addr_t dma_addr;
+	unsigned int map_len = ALIGN(len, SMP_CACHE_BYTES);
+	u32 val, offset = 0;
 	int ret;
 
-	dma_addr = dma_map_single(npu->dev, p, size, DMA_BIDIRECTIONAL);
+	if (len <= 0 || len > AIROHA_NPU_MBOX_SIZE)
+		return -EINVAL;
+
+	if (reply && reply_len > len)
+		return -EINVAL;
+
+	spin_lock_bh(&core->lock);
+
+	memcpy(core->buf, data, len);
+
+	dma_addr = dma_map_single(npu->dev, core->buf, map_len, DMA_BIDIRECTIONAL);
 	ret = dma_mapping_error(npu->dev, dma_addr);
 	if (ret)
-		return ret;
-
-	spin_lock_bh(&npu->cores[core].lock);
+		goto unlock;
 
 	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(0) + offset, dma_addr);
-	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(1) + offset, size);
+	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(1) + offset, len);
 	regmap_read(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, &val);
 	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, val + 1);
 	val = FIELD_PREP(MBOX_MSG_FUNC_ID, func_id) | MBOX_MSG_WAIT_RSP;
@@ -189,13 +202,23 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 	if (!ret && FIELD_GET(MBOX_MSG_STATUS, val) != NPU_MBOX_SUCCESS)
 		ret = -EINVAL;
 
-	spin_unlock_bh(&npu->cores[core].lock);
+	dma_unmap_single(npu->dev, dma_addr, map_len, DMA_BIDIRECTIONAL);
 
-	dma_unmap_single(npu->dev, dma_addr, size, DMA_BIDIRECTIONAL);
+	/* Copy the trailing reply_len bytes of the response. */
+	if (!ret && reply)
+		memcpy(reply, core->buf + len - reply_len, reply_len);
+unlock:
+	spin_unlock_bh(&core->lock);
 
 	return ret;
 }
 
+static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
+			       void *data, int len)
+{
+	return __airoha_npu_send_msg(npu, func_id, data, len, data, len);
+}
+
 static int airoha_npu_load_firmware(struct device *dev, void __iomem *addr,
 				    const char *fw_name, int fw_max_size)
 {
@@ -497,9 +520,8 @@ static int airoha_npu_wlan_msg_get(struct airoha_npu *npu, int ifindex,
 	wlan_data->func_type = NPU_OP_GET;
 	wlan_data->func_id = func_id;
 
-	err = airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data, len);
-	if (!err)
-		memcpy(data, wlan_data->d, data_len);
+	err = __airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data, len,
+				    data, data_len);
 	kfree(wlan_data);
 
 	return err;
@@ -770,6 +792,18 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	for (i = 0; i < ARRAY_SIZE(npu->cores); i++) {
+		struct airoha_npu_core *core = &npu->cores[i];
+		void *raw;
+
+		raw = devm_kmalloc(dev, AIROHA_NPU_MBOX_SIZE + SMP_CACHE_BYTES,
+				   GFP_KERNEL);
+		if (!raw)
+			return -ENOMEM;
+
+		core->buf = PTR_ALIGN(raw, SMP_CACHE_BYTES);
+	}
+
 	err = airoha_npu_run_firmware(dev, base, &res);
 	if (err)
 		return dev_err_probe(dev, err, "failed to run npu firmware\n");
diff --git a/include/linux/soc/airoha/airoha_offload.h b/include/linux/soc/airoha/airoha_offload.h
index 7589fccfeef6..f635766e3dba 100644
--- a/include/linux/soc/airoha/airoha_offload.h
+++ b/include/linux/soc/airoha/airoha_offload.h
@@ -173,6 +173,7 @@ struct airoha_npu {
 		/* protect concurrent npu memory accesses */
 		spinlock_t lock;
 		struct work_struct wdt_work;
+		void *buf; /* mailbox DMA bounce buffer */
 	} cores[NPU_NUM_CORES];
 
 	int irqs[NPU_NUM_IRQ];
-- 
2.55.0

