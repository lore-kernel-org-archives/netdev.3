Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEF43D3CEA
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786289321; cv=none; b=LqEBVSihtqf9gooq0E09mfec4vFivXKCVgCUomEnMyuqh/M4uGN8rIBwSeB20CPv4EiaANVqxQ2k8taWKqTW1v3woVuyno/5wX5NwY2A4e6NXxmtukotyDIq7cJgAZxUGV11YmQebN9y/EiGSmfilH2MhbAOx6WtNOoT8CzoCQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786289321; c=relaxed/simple;
	bh=54+HeuKXn+PVq8WL55r/0bEYld0mIUea57a7Mu/8RlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ac4a+C17u92VS+iKI2DSpIkEDq0+HnGj8Uo0ohX5wMTkAAnWDNJc8zsVKvXdy0jLiODlR68fwIBLNHflru8kRka3PKUMCsRKdMEK6U5W+ywkQ3LIssEaDUR/aWc4V3qEeFEWDjrHNxCGR34lY4617mJ25Ti3CtiN3+/Q46ldiTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+R77xgu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+R77xgu"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48000c5d6d3so395017f8f.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 08:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786289318; x=1786894118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Du424wcgYsHlMuGkMQaZEV+CEPsWQYn2LKtn2mdtg4=;
        b=U+R77xguaKI3sAF453OKTOwDKJDOu4I2GyKkGbnnBTfr6u7aEdRLA87UVztdzlQhCM
         YQnw5luXaSI5Q6SHFWfyLcr+HhjZnKA7FGLk1C9wX4EeSCAxIlQG3O7sh/kcKQyCc7Ie
         kN1TjNE84M+KdFKX8tDwtp2Ar2wYXY5ckxh9HC6L6rh76o5/spHvs2x5y34T7gPIbsgD
         l6ypbccOVnH4kjYeheHBi3XJs/HokdybhSZhyLy+Lyyqj7ttcFcKkaMUo9CJYPfbOcvc
         4CoJYrhKHOUr3OHSM4xUj9QWARIcUfjNXdBqNbvFJizeZdYpcElP8KnwPzeHcFlXasNy
         qKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786289318; x=1786894118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Du424wcgYsHlMuGkMQaZEV+CEPsWQYn2LKtn2mdtg4=;
        b=IjA6mjYF9ZkXHipqGi1bTDiEXxw3mtHy1z4z0lfztxSO6SWNSaNzGGCuyqGMys8PhF
         EtV/MxOOReS79HYWSrkouZaWnGJ3Zign7vv9AHwvihS1HGOkzd/Pmm2Y9gX+8m1cNxkI
         h/OxWTYU5XIdkSGAqkrYGPm0lH38RuRvSp0qlPV8GYwaDpGyhlUuUo1FmeRX6xj6ibH4
         nEdXHS17Ym5by8ItRCxFRCzGZazhWHQjEZ8G81E1eOaFhGa42PURiurWCNG7TjSdNklz
         MctclY4TUQWGQwrI4H3ITZmQ5ibyTl8HWyJPkdN4/2W8DA2dxcsxmUZsMfA36pMPY6FB
         eJJg==
X-Gm-Message-State: AOJu0Yyvg37anfwhZyfoBk2jfLgWAzCDqY7lqnIXCG5ksMEGJwo49ODY
	IWDNA3LziLI8Lbxfoa+CuBCx85GsmxVQvkHc/KHR5tP1W3a+u20IDsVO2P3HtWiP
X-Gm-Gg: AR+sD123a2r8rvKGwFMBfOW4/L/nzH3XoYAjqKE8zZ25pNkEm+HO6qaSSefmjx2yhZq
	vOu9M06lwqxsTJKjrTil8Yx2xilapWBLNoATr7vWMN962o1WuEPLeSqhUxvnvDESAlith3OPf4P
	k8XSdXLeBcXCPf1BKc87bovcQPAXfHnVkx7VxM14aDKiSY4fCKb1J2ffa41dO7P/TLqvNS3pD1k
	g1bhaUcgs1dteXWcDbVRUaEisyCy8AzQzOSEdd4jD+kqHJIY/sJzAYjia6ssCJUOLlM3tczOxlo
	XmNM+NRto0ulZJuX2OgMIECAss88ygvQUA4GgntOzkCUj0LLwBDcnaEWmIHxvGXB6SEBbZu4gHw
	UmLMnKoTbe1vQRh5zWc09Fxuc/cFGYf3QsZhv4Kn3eHlfDRX8UXjwaCvdlI98me3wj0ktNzBPim
	706menhBFX1xaADPbJ1+zRC+1cPt/l92eSHVlaQb+YtGhxJx4NYcOa5o9wEkOHH0c1Cw==
X-Received: by 2002:a05:600c:1c19:b0:499:5a50:b022 with SMTP id 5b1f17b1804b1-4995e07f45bmr220387665e9.3.1786289318104;
        Sun, 09 Aug 2026 08:28:38 -0700 (PDT)
Received: from fedora ([46.205.218.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9eb1a0sm207379925e9.5.2026.08.09.08.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 08:28:37 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	win847@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH v6] net: airoha: npu: use coherent DMA for mailbox messages
Date: Sun,  9 Aug 2026 17:28:13 +0200
Message-ID: <20260809152813.585797-1-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox
buffer") switched airoha_npu_send_msg() to DMA_BIDIRECTIONAL so
non-coherent CPUs invalidate caches before reading NPU GET responses.

On EN7581 + MT7996 that change regresses probe: the mailbox completes
successfully, but WLAN_FUNC_GET_WAIT_NPU_VERSION still reads as 0.0 and
mt76 never binds NPU offload. Healthy boards report 0.1111.

airoha_npu_send_msg() is also used from PPE foe_commit under
spin_lock_bh(), so per-message dma_alloc_coherent(GFP_ATOMIC) is a poor
fit. Allocate one device-managed coherent bounce buffer per NPU core at
probe and reuse it under the existing per-core mailbox lock. That also
keeps the buffer valid if the NPU completes a write after a mailbox
timeout.

Introduce __airoha_npu_send_msg() with an optional reply pointer so GET
callers can copy the trailing response payload once. Keep
airoha_npu_send_msg() as a wrapper that copies the full response back
into the caller buffer, matching the old bidirectional mapping.

Verified on Quantum Fiber / Gemtek W1700K (EN7581 + MT7996).

Fixes: 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox buffer")
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260805070851.2885888-1-pawlik.dan@gmail.com/
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260806072601.1815487-1-pawlik.dan@gmail.com/
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260807064058.1117747-1-pawlik.dan@gmail.com/
Assisted-by: Cursor:composer-2
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
---
v6:
- use airoha_npu_send_msg() in ppe_stats_setup() again
- make airoha_npu_send_msg() copy the full response back into data
  (same as the old bidirectional DMA mapping)
- rename local core pointer from c to core

v5:
- use u16 for reply_len and split the reply length check
- drop inline from airoha_npu_send_msg() in the .c file

v4:
- drop rsp_off; copy trailing reply_len bytes into reply pointer
- split __airoha_npu_send_msg() + thin airoha_npu_send_msg() wrapper
  so SET callers stay unchanged
- fix reverse-christmas-tree local variable ordering
- constify data argument; clarify reply copy comment

v3:
- move coherent mailbox buffer into struct airoha_npu_core (buf/addr)
- allocate one buffer per core at probe
- add optional reply buffer to avoid the extra copy in
  airoha_npu_wlan_msg_get()
- document AIROHA_NPU_MBOX_SIZE vs ppe_mbox_data / WLAN payloads

v2:
- allocate one coherent mailbox buffer at probe and reuse it under the
  per-core lock instead of per-message dma_alloc_coherent(GFP_ATOMIC)

 drivers/net/ethernet/airoha/airoha_npu.c  | 67 +++++++++++++++++------
 include/linux/soc/airoha/airoha_offload.h |  3 +
 2 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index b679bed952de..c839e0a419aa 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -23,6 +23,12 @@
 #define NPU_EN7581_FIRMWARE_RV32_MAX_SIZE	0x200000
 #define NPU_EN7581_FIRMWARE_DATA_MAX_SIZE	0x10000
 #define NPU_DUMP_SIZE				512
+/*
+ * Mailbox DMA payload size. Covers sizeof(struct ppe_mbox_data) (28) and
+ * WLAN TLV messages (header + payload); largest in-tree WLAN payload today
+ * is 16 bytes (INODE_TXRX_REG_ADDR). Keep headroom for future commands.
+ */
+#define AIROHA_NPU_MBOX_SIZE			256
 
 #define REG_NPU_LOCAL_SRAM		0x0
 
@@ -160,23 +166,34 @@ struct wlan_mbox_data {
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
-	dma_addr_t dma_addr;
+	struct airoha_npu_core *core = &npu->cores[0]; /* FIXME: core */
+	u32 val, offset = 0;
 	int ret;
 
-	dma_addr = dma_map_single(npu->dev, p, size, DMA_BIDIRECTIONAL);
-	ret = dma_mapping_error(npu->dev, dma_addr);
-	if (ret)
-		return ret;
+	if (len > AIROHA_NPU_MBOX_SIZE)
+		return -EINVAL;
+
+	if (reply && reply_len > len)
+		return -EINVAL;
+
+	/*
+	 * Mailbox payloads are bidirectional (CPU request, NPU response).
+	 * On EN7581+MT7996, streaming DMA_BIDIRECTIONAL against the
+	 * caller kzalloc() buffer can leave WLAN_FUNC_GET_WAIT_NPU_VERSION
+	 * reading as 0.0 despite MBOX success. Reuse a probe-time coherent
+	 * bounce buffer under the per-core lock (also used from PPE
+	 * foe_commit under atomic context).
+	 */
+	spin_lock_bh(&core->lock);
 
-	spin_lock_bh(&npu->cores[core].lock);
+	memcpy(core->buf, data, len);
 
-	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(0) + offset, dma_addr);
-	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(1) + offset, size);
+	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(0) + offset, core->addr);
+	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(1) + offset, len);
 	regmap_read(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, &val);
 	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, val + 1);
 	val = FIELD_PREP(MBOX_MSG_FUNC_ID, func_id) | MBOX_MSG_WAIT_RSP;
@@ -189,13 +206,21 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 	if (!ret && FIELD_GET(MBOX_MSG_STATUS, val) != NPU_MBOX_SUCCESS)
 		ret = -EINVAL;
 
-	spin_unlock_bh(&npu->cores[core].lock);
+	/* Copy the trailing reply_len bytes of the response. */
+	if (!ret && reply)
+		memcpy(reply, core->buf + len - reply_len, reply_len);
 
-	dma_unmap_single(npu->dev, dma_addr, size, DMA_BIDIRECTIONAL);
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
@@ -497,9 +522,8 @@ static int airoha_npu_wlan_msg_get(struct airoha_npu *npu, int ifindex,
 	wlan_data->func_type = NPU_OP_GET;
 	wlan_data->func_id = func_id;
 
-	err = airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data, len);
-	if (!err)
-		memcpy(data, wlan_data->d, data_len);
+	err = __airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data, len,
+				    data, data_len);
 	kfree(wlan_data);
 
 	return err;
@@ -770,6 +794,15 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	for (i = 0; i < ARRAY_SIZE(npu->cores); i++) {
+		struct airoha_npu_core *core = &npu->cores[i];
+
+		core->buf = dmam_alloc_coherent(dev, AIROHA_NPU_MBOX_SIZE,
+						&core->addr, GFP_KERNEL);
+		if (!core->buf)
+			return -ENOMEM;
+	}
+
 	err = airoha_npu_run_firmware(dev, base, &res);
 	if (err)
 		return dev_err_probe(dev, err, "failed to run npu firmware\n");
diff --git a/include/linux/soc/airoha/airoha_offload.h b/include/linux/soc/airoha/airoha_offload.h
index 7589fccfeef6..16a988ad7467 100644
--- a/include/linux/soc/airoha/airoha_offload.h
+++ b/include/linux/soc/airoha/airoha_offload.h
@@ -173,6 +173,9 @@ struct airoha_npu {
 		/* protect concurrent npu memory accesses */
 		spinlock_t lock;
 		struct work_struct wdt_work;
+		/* Coherent bounce buffer for mailbox cmd/rsp */
+		void *buf;
+		dma_addr_t addr;
 	} cores[NPU_NUM_CORES];
 
 	int irqs[NPU_NUM_IRQ];
-- 
2.55.0

