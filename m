Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9622E37B40A
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786199244; cv=none; b=sFh7dZQ2VCpO62qaBXo4ho5K/agKayAYSR1KOghEBOuX4jGIuePjeEbACJeCferOF5ekR/nojm2GRlasD1nXhHcjmAVnXnC/67MoPjTYIeaWJBMLk2IGZgmA1PEzJBpO+GsnTl3eOzxe+mvpYy3+H1tYofxtzFJragF3BQG85kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786199244; c=relaxed/simple;
	bh=HU3CFgOXsAqx/ViDg/f4k9lLDf71ii6Q338ZxMiC3mM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OsqqqHf28g5o84mAarpVeH5JDH4sBeD61fmvv/msw1d0hhVgkFa5s0btjqtoxHe3OKuj+XXNQcpI0uL15YI3dwlfVZX7JpncE9I2kXIPstdCVnY+24GcXR7uAEgnNSIWOcICdHRE5qM5ZWbKmrlZAOovGeE7xhtI0AFBZWzvYY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZ40umc0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZ40umc0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495437bb891so3700335e9.1
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786199241; x=1786804041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rVfmWdDuT2KhVf4CTGvop1Fo4MSH/UrlPEoJtglHb4s=;
        b=oZ40umc04TdEjNLvdIVwqvZv8ojGFQnniSs4AXfBi/ANEGgVXaja6l9MgTH37aBoBa
         BLkA8A9j9OF2XLOMxge6gJOcCM7QsHdyTS50TmSecXp2zys2NXzYhTc0s48FZWmQb2YD
         MZDhRxdstZ2kzOPx01PtXiP+dBZXqNqPy4/2EtYzWWyCfmtnPaZorxJdUE2EwzgV4uhM
         XEVF+dIwcgrTG5uX/7bhcANSsb+BJO67Xis/mVQCtEuCPjkEr3bzmo4JLncCwjvcKtPT
         wsgam+TP4qMeUa4mcgEnbLUvUdIacVakNihkxkai3ejVfkDnNSHgaowXM2Xb+CY8e+wT
         LOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786199241; x=1786804041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rVfmWdDuT2KhVf4CTGvop1Fo4MSH/UrlPEoJtglHb4s=;
        b=IGbC1X3fqWJOUnG8/pKsPn34si3KVf8LtAKscrTep/wsV7Q/cc4Zk4UW6HZdMUvvkW
         FUh0SlbXOIqe9Jm+QX0nQQJt1sk0g65k3Or/FlunEr63L0lpDbhNAN/tUr5S6czUfWnw
         fwN3H96sOaRkNyiQuGiT+J89fnRMJkB9vOx/JinCwl7kRgImiNfaD+RiCVnFUB6x3vD+
         nYAOvQFc7efGlE327qU4/FjNGrbHu8ZOrbEpJxaUEvOe21fccvqXI2TZriTTUuF/RYpG
         0f1vAsa3L5TPiBqYS+eDe8v6ruHjdQESeuMKcS7pLKG8s5lyt5nVR/+MdLehJoxouv4R
         sohg==
X-Gm-Message-State: AOJu0YyIBS9caCw/6E/sN+I5+2qCw0mYUPfNVT5gp4d9i/ZIn+3oS2a0
	bGGFvW+b+CuAQrD2fH7RoJ10nYsN05xgkqlnh+MAM1nCpTyjChDO0K51ZpKYxKDV
X-Gm-Gg: AR+sD137TGf13hQJDDPBzjpG4Dn7QLaSk0EVu6O6r47etBMOsMdToL5YJBvwR37WbNT
	xan51rldu/Dg34BnQx0SA3/yrYbKXPbK0zAei/4NBBJvAz8pZ+p+SF/40L276H7Vy0KGEpCTCEU
	4lpXxMzaGHyDmAHokz/l+cqGyJbB3PwhLLCkKI44alME4eKl6ydQjJ/Vr33V4a9TqPJ+Y2Rzem3
	L07aBt0xhAtZhshACKU+0Nr0OTE+7RbHnomm2BlTFWhNEq/IoqVYvBVyj7Q7F8T+zJgsZbaPCok
	9oLKWuEan0ihcC9YGX4SxjYbZdnWdTmodF06j3WkWugIwEMUAz36OdwS5LR3l3WJgCCVcxpbJSL
	RSi8iDnCUaX1wQaowIwV9cCXasOoLLnb8H8hI979Fv2PKZOiGaWPyISTsHH91Qq8uNpfsrVM24p
	iPVO5bBqlpRxNghKfXS5tGOyKDBSEe3FPHowROjMpbSAHKksY2S/HEDXbiSWbRqYvl
X-Received: by 2002:a05:600c:4714:b0:499:5f80:83ac with SMTP id 5b1f17b1804b1-49962473fd0mr61427325e9.7.1786199240544;
        Sat, 08 Aug 2026 07:27:20 -0700 (PDT)
Received: from fedora ([46.205.218.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995ea2dc4esm140041065e9.13.2026.08.08.07.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 07:27:19 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	win847@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH v5] net: airoha: npu: use coherent DMA for mailbox messages
Date: Sat,  8 Aug 2026 16:27:04 +0200
Message-ID: <20260808142704.1873849-1-pawlik.dan@gmail.com>
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
airoha_npu_send_msg() as a thin wrapper for SET paths that do not need
a response buffer.

Verified on Quantum Fiber / Gemtek W1700K (EN7581 + MT7996).

Fixes: 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox buffer")
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260805070851.2885888-1-pawlik.dan@gmail.com/
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260806072601.1815487-1-pawlik.dan@gmail.com/
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260807064058.1117747-1-pawlik.dan@gmail.com/
Assisted-by: Cursor:composer-2
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
---
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

 drivers/net/ethernet/airoha/airoha_npu.c  | 72 +++++++++++++++++------
 include/linux/soc/airoha/airoha_offload.h |  3 +
 2 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index b679bed952de..907e7ef6cf75 100644
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
+	struct airoha_npu_core *c = &npu->cores[0]; /* FIXME: core */
+	u32 val, offset = 0;
 	int ret;
 
-	dma_addr = dma_map_single(npu->dev, p, size, DMA_BIDIRECTIONAL);
-	ret = dma_mapping_error(npu->dev, dma_addr);
-	if (ret)
-		return ret;
+	if (len > AIROHA_NPU_MBOX_SIZE)
+		return -EINVAL;
 
-	spin_lock_bh(&npu->cores[core].lock);
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
+	spin_lock_bh(&c->lock);
 
-	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(0) + offset, dma_addr);
-	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(1) + offset, size);
+	memcpy(c->buf, data, len);
+
+	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(0) + offset, c->addr);
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
+		memcpy(reply, c->buf + len - reply_len, reply_len);
 
-	dma_unmap_single(npu->dev, dma_addr, size, DMA_BIDIRECTIONAL);
+	spin_unlock_bh(&c->lock);
 
 	return ret;
 }
 
+static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
+			       const void *data, int len)
+{
+	return __airoha_npu_send_msg(npu, func_id, data, len, NULL, 0);
+}
+
 static int airoha_npu_load_firmware(struct device *dev, void __iomem *addr,
 				    const char *fw_name, int fw_max_size)
 {
@@ -442,8 +467,9 @@ static int airoha_npu_ppe_stats_setup(struct airoha_npu *npu,
 	ppe_data->func_id = PPE_FUNC_SET_WAIT_FLOW_STATS_SETUP;
 	ppe_data->stats_info.foe_stats_addr = foe_stats_addr;
 
-	err = airoha_npu_send_msg(npu, NPU_FUNC_PPE, ppe_data,
-				  sizeof(*ppe_data));
+	err = __airoha_npu_send_msg(npu, NPU_FUNC_PPE, ppe_data,
+				    sizeof(*ppe_data), ppe_data,
+				    sizeof(*ppe_data));
 	if (err)
 		goto out;
 
@@ -497,9 +523,8 @@ static int airoha_npu_wlan_msg_get(struct airoha_npu *npu, int ifindex,
 	wlan_data->func_type = NPU_OP_GET;
 	wlan_data->func_id = func_id;
 
-	err = airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data, len);
-	if (!err)
-		memcpy(data, wlan_data->d, data_len);
+	err = __airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data, len,
+				    data, data_len);
 	kfree(wlan_data);
 
 	return err;
@@ -770,6 +795,15 @@ static int airoha_npu_probe(struct platform_device *pdev)
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

