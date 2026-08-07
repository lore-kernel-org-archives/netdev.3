Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A644A71D
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786084874; cv=none; b=kiIyT/RwxcVqsddTHGwPJ9AzcoiNdAdLwzpfWEgTl10N1bB6B1Bbho1I8evaGcKJOQhVtr+qZsY/Qdm1sFa1CnpUYTtWYIXb8pS3KB6+DxRMpYsqGBxYJweyuVPBk0+/UxT8yPlC3/EjELbVjhNV2duZ8pE9abONjclpFKi9MWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786084874; c=relaxed/simple;
	bh=LgAEFqD6cspmUMspuqb4+xSAz9g19LhmIr6XP/jdxEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mp9T+Q1K232cLKX5PJ6pmZlIEbuiXEdpbnnp0xCvK2093AfsndehOiT36Ea7HNpa9yxFNvy0el6XxnICia+uZ750lxnbgrRILhhQWdCIYQN6XNni9P1fNgaWn43mrcuyMgrN58U8/b5Vl49qv6RTqVUuHhmVTpUhlQrTzCSFqJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbfWkUBX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbfWkUBX"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-476a130c138so2571580f8f.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 23:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786084870; x=1786689670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cfbg4OKMiHxX0/fCplY4WZEaCh6mteG/jz44Jr9wKjY=;
        b=bbfWkUBXLuOF1X0fqUuoo9/g4fX+Vg/HNrEgF/bDpIh/Br3vz4li0ZI59jAtOF8ARQ
         oCW87sYdl4Q8lFv8VqHYCyF04m8C8CLF+GFRZnJg9GtepcGq9/J305SqfadABb0bcC5Y
         6KYFs8O48hMMTKfeLn17PRN04hCYrkQal1XAwcaV1biVtj8OTKZSAaKeoGWF5c2/ybsl
         gY1FlDdv/iGKi1D5/xy3OXt/LEikQBRjySxMdJ61QgD5fuPFdauOy4W4pv/BnzjoEpMn
         comIcyH2y0hOO52XVNi19KYV5RAGB/AKoIG6hTAmIewHvKsbypVWqgYWJYgAnYK/b3M5
         X6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786084870; x=1786689670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cfbg4OKMiHxX0/fCplY4WZEaCh6mteG/jz44Jr9wKjY=;
        b=BJnfH6PppXpD/oKGUZSZyERefoKhnsNZjepVK7d8V1FMtJnyv0qX+b3dcyPCGwK10C
         sbBwzUUU/RLSqV+2UbXWMNzIMsG5NPTI5opqcyoTJgCciIqGfIwIxhyfC6fcS1NRVrnI
         NhvuoYXawYH6+2IHgHeaV11i7iAGC6DRefLtQMs1X8vy+FJ65VGlnNqh7Bgb4gMNhkgH
         ObrRYcs5yeyfC2vKBqLf2wqrIqhop/Fboa0PZH6GJ9mt6CJbE+EOniAGVCQ7VEzd6Xw4
         3sI9z8VaUxarOShotWhPbsNIOlcNWfrMzhr5DMhcyUkWvN2l6dfJEVxdpqFc9xAAqTCI
         3tmg==
X-Gm-Message-State: AOJu0Yw/BKKN/qu/4kCLL28rE7tmGoEXyowdJg7NBCkTNHl8lE/UOmde
	SYLCkbDklI0OJPdFZ+GuS7J3xgxvc2XhTyjTlRx33o7psqB2bdu0a4Ga+wM4M58s
X-Gm-Gg: AR+sD10voVA7KYeqpIAwptifHV8Zg60acaICxEP3fDgwTjMhjQ3ZD8gUgrNr+otjaBi
	sM/8GQtLMzEPr7PsExYeyBTin6hRQs4LRynvkd5q1HeG5D3jEU9TON5UaQnDPTi5YejZHClmr5E
	BT8X1cKb5WGfbeQkG4G6yPUTWqX3ur4yqtqnLImFrooH3lTSvG/2bneAU1uH9WMEir3AFHX2z5q
	Y+Mnyei9kssVQN07OQe0pj8q1JCrcMAfm9DlGjh74PDdm7IQhVFR9c0mny3mpWQOg1jSG996Ni0
	yIuRuC8EQTJ08wUY27ZBGCcIj1O8kz2v9GHmd/2XoRvob043qYeVe288aL3vfPRzcstz40y1DhR
	AIaErzv1uk9i3ovju1bpON7iLFvZGYcHlwkwNxqBI6U4KmawB40R+HV/Gd8FmLVtmAGCJXz1tp8
	J2e9vlQ6KH+1rXsg7CibIFA7FI6hDptsxZKJ3r7UZqQ92hMqlo0Xmbp9k=
X-Received: by 2002:a05:6000:2981:20b0:476:7036:f854 with SMTP id ffacd0b85a97d-47ffd93cfadmr8835774f8f.21.1786084870270;
        Thu, 06 Aug 2026 23:41:10 -0700 (PDT)
Received: from fedora ([46.205.219.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002150804sm2655044f8f.13.2026.08.06.23.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 23:41:09 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	win847@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH v4] net: airoha: npu: use coherent DMA for mailbox messages
Date: Fri,  7 Aug 2026 08:40:58 +0200
Message-ID: <20260807064058.1117747-1-pawlik.dan@gmail.com>
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
airoha_npu_send_msg() as a thin wrapper for SET paths.

Verified on Quantum Fiber / Gemtek W1700K (EN7581 + MT7996).

Fixes: 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox buffer")
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260805070851.2885888-1-pawlik.dan@gmail.com/
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260806072601.1815487-1-pawlik.dan@gmail.com/
Assisted-by: Cursor:composer-2
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
---
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

 drivers/net/ethernet/airoha/airoha_npu.c  | 70 +++++++++++++++++------
 include/linux/soc/airoha/airoha_offload.h |  3 +
 2 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index b679bed952de..74da3c4d06e4 100644
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
 
@@ -160,23 +166,32 @@ struct wlan_mbox_data {
 	DECLARE_FLEX_ARRAY(u8, d);
 };
 
-static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
-			       void *p, int size)
+static int __airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
+				 const void *data, int len, void *reply,
+				 int reply_len)
 {
-	u16 core = 0; /* FIXME */
-	u32 val, offset = core << 4;
-	dma_addr_t dma_addr;
+	struct airoha_npu_core *c = &npu->cores[0]; /* FIXME: core */
+	u32 val, offset = 0;
 	int ret;
 
-	dma_addr = dma_map_single(npu->dev, p, size, DMA_BIDIRECTIONAL);
-	ret = dma_mapping_error(npu->dev, dma_addr);
-	if (ret)
-		return ret;
+	if (len > AIROHA_NPU_MBOX_SIZE ||
+	    (reply && (reply_len < 0 || reply_len > len)))
+		return -EINVAL;
 
-	spin_lock_bh(&npu->cores[core].lock);
+	/*
+	 * Mailbox payloads are bidirectional (CPU request, NPU response).
+	 * On EN7581+MT7996, streaming DMA_BIDIRECTIONAL against the
+	 * caller kzalloc() buffer can leave WLAN_FUNC_GET_WAIT_NPU_VERSION
+	 * reading as 0.0 despite MBOX success. Reuse a probe-time coherent
+	 * bounce buffer under the per-core lock (also used from PPE
+	 * foe_commit under atomic context).
+	 */
+	spin_lock_bh(&c->lock);
+
+	memcpy(c->buf, data, len);
 
-	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(0) + offset, dma_addr);
-	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(1) + offset, size);
+	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(0) + offset, c->addr);
+	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(1) + offset, len);
 	regmap_read(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, &val);
 	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, val + 1);
 	val = FIELD_PREP(MBOX_MSG_FUNC_ID, func_id) | MBOX_MSG_WAIT_RSP;
@@ -189,13 +204,21 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 	if (!ret && FIELD_GET(MBOX_MSG_STATUS, val) != NPU_MBOX_SUCCESS)
 		ret = -EINVAL;
 
-	spin_unlock_bh(&npu->cores[core].lock);
+	/* Copy the trailing reply_len bytes of the response. */
+	if (!ret && reply)
+		memcpy(reply, c->buf + len - reply_len, reply_len);
 
-	dma_unmap_single(npu->dev, dma_addr, size, DMA_BIDIRECTIONAL);
+	spin_unlock_bh(&c->lock);
 
 	return ret;
 }
 
+static inline int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
+				      const void *data, int len)
+{
+	return __airoha_npu_send_msg(npu, func_id, data, len, NULL, 0);
+}
+
 static int airoha_npu_load_firmware(struct device *dev, void __iomem *addr,
 				    const char *fw_name, int fw_max_size)
 {
@@ -442,8 +465,9 @@ static int airoha_npu_ppe_stats_setup(struct airoha_npu *npu,
 	ppe_data->func_id = PPE_FUNC_SET_WAIT_FLOW_STATS_SETUP;
 	ppe_data->stats_info.foe_stats_addr = foe_stats_addr;
 
-	err = airoha_npu_send_msg(npu, NPU_FUNC_PPE, ppe_data,
-				  sizeof(*ppe_data));
+	err = __airoha_npu_send_msg(npu, NPU_FUNC_PPE, ppe_data,
+				    sizeof(*ppe_data), ppe_data,
+				    sizeof(*ppe_data));
 	if (err)
 		goto out;
 
@@ -497,9 +521,8 @@ static int airoha_npu_wlan_msg_get(struct airoha_npu *npu, int ifindex,
 	wlan_data->func_type = NPU_OP_GET;
 	wlan_data->func_id = func_id;
 
-	err = airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data, len);
-	if (!err)
-		memcpy(data, wlan_data->d, data_len);
+	err = __airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data, len,
+				    data, data_len);
 	kfree(wlan_data);
 
 	return err;
@@ -770,6 +793,15 @@ static int airoha_npu_probe(struct platform_device *pdev)
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

