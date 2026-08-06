Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ABA3D7D8E
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026517; cv=none; b=Ecotlb4E6z/eEI92uS0YbKAn31d0SLUptFLwZAHmzC4BDQDyPnH8U9XSGCmLupbgwdUoqsX/Cv7PNAcVbd1M1YJra42eLqu+yUd9+UOQju/Et40oEGRae1+M3Juo2HATIBwLtW0LY/p5KIB1E7MAjKCQYwH4u3K6CC/vEmLXrh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026517; c=relaxed/simple;
	bh=nQQlUsSZREMZmv/DBatiBecIEEQiHcUS0NnYho0Kh2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UpFV3FofM3fEmMpRhjfA0cK1cXXhS9VgImMytT4KkngR9aj7EiuJTqFtR+D25xPii99duJ7NET0Vgz5MeWo6kw2jS8ux7f0Huswk2igrBgDhcvlNc4JNfa5XTmGjxTp5/d+dIXrnrZT3xXm1La9aQg/26JwEk7B4SoW0YB5rTFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOg8PUvc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOg8PUvc"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-495590dde14so25997035e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786026513; x=1786631313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u9Cf19exgJUbhMN18jsPNMaqk2I9uUSBPntYyt77HUc=;
        b=JOg8PUvc2z0oiszYefrzBKeatjVNKdKonVY44Dz+rQIkrBArwoOfpa1YzANNgi6Fz+
         ReIuQvkOV4K6cEtDoZEFMRJjUypR79Gnz7CU9TTJUwPOtdEQP3495leFuG8ZdjGol1rX
         jqZKCaV5XQ0b9sFvM9EThLAOdAq8x2pfgjkLYRiYyznbcQ2dE6ka4CwawQ5E6jc9jJYB
         MHUvgDkrTzPUaOaNs96o+pg6s0/yE6Tx6Vuc99iWNbwWXifTkxgA7wcn4raOb/hHVsuo
         mh/ooOgMPonbyTc3JwO9zXO0h5+QgaaN42rUxpSVmQldU8Xl5smbQ3zwYgvD56P7dE1t
         zOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786026513; x=1786631313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u9Cf19exgJUbhMN18jsPNMaqk2I9uUSBPntYyt77HUc=;
        b=d8QQVQvsiHZNBYg//JKwrhumf18gNPjmRYD24UmOG2GR6GvIxZarUrRXVFpnoTa9g1
         af+9js6G8IK7FVPjezGksAKW/rrAGLd36/pPoBIbyfqO7jxq2E8ZVB9nxWTST333nRG3
         jWmXUpISIlqh6HTTfa8F8KGPgSy6dnUXY9ldG/SUV2EciFaOsqRF/CTVgWJWvqn+xJ6a
         d77sFvpayvWog8KeOFV9rkSXacQUi1fidt27LF3BVvvjMZdlJkpX3omkqQz6Oj0CnUc9
         BmQK+YsqdB2yUHSjP0zIv3q03PIn/zf1FPG/C2Fc35Ds/VKUw4xLyBmLXMyBSv1Vveoo
         eq5A==
X-Gm-Message-State: AOJu0YwLTVmul4mreb3/+JaUfsbXHepym6cOnuJERlhmj9vXjkltG9NH
	k8fBEcJfcQOwgHxfSPQ1vvV3lnHc9LhULTFpjexC66pS/pK+lRempu81elYqt3L4
X-Gm-Gg: AR+sD11dyhFrhwhIyeJ4APMn2ltCzigvAPaIH19k2334lEVy0yvPOtbETZklWmj1OUG
	K25uCi3552YcUBlDidFlgnY9Ff0nbQOm7qnPi2elpaNPNSBOKh1WNEc1x2IfG5t6W4X5jPQo5pO
	At1cs3AX0ugL74+aUFv03JIV+mHG8kVzQf2mmOjkBYMEsePnzSKdWivtW7zRRtmZbc70xDexJ/B
	Al/Sh4uBPsII5m5pEEFfuRSaRFgZTeJz0WAepT9slxjcreQ3kkYGra01lLV4Ta8a1ogEGQBI3uG
	5B7eNykLxDKMxu4WKYYOKzKWoh97gNI8GKJAo0g7X9PAmDu7ubE5Bh+rmuTP3fBFeiZeXRuhJwx
	bOSIW/h4lFsFy/8n0T8vS3Sa5ePGBjHUl73nGClypDRzivY4QaUWimduy1S0qPbTP+FFHYPQjxO
	t286K1gIq3IAgmCB6KKdBoDfmvCEeYgPZXuYhyGpHhuPXj7WXN2b4j0co=
X-Received: by 2002:a05:600c:1913:b0:499:5282:f8d1 with SMTP id 5b1f17b1804b1-4995282f8dfmr99990265e9.12.1786026513176;
        Thu, 06 Aug 2026 07:28:33 -0700 (PDT)
Received: from fedora ([46.205.219.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995422b741sm72692255e9.14.2026.08.06.07.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:28:32 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	win847@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH v3] net: airoha: npu: use coherent DMA for mailbox messages
Date: Thu,  6 Aug 2026 16:28:16 +0200
Message-ID: <20260806142816.511515-1-pawlik.dan@gmail.com>
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

Pass an optional reply buffer into airoha_npu_send_msg() so GET callers
(e.g. airoha_npu_wlan_msg_get) copy the response payload once instead of
bouncing through the request allocation.

Verified on Quantum Fiber / Gemtek W1700K (EN7581 + MT7996).

Fixes: 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox buffer")
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260805070851.2885888-1-pawlik.dan@gmail.com/
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260806072601.1815487-1-pawlik.dan@gmail.com/
Assisted-by: Cursor:composer-2
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
---
v3:
- move coherent mailbox buffer into struct airoha_npu_core (buf/addr)
- allocate one buffer per core at probe
- add optional reply buffer to airoha_npu_send_msg() to avoid the extra
  copy in airoha_npu_wlan_msg_get()
- document AIROHA_NPU_MBOX_SIZE vs ppe_mbox_data / WLAN payloads

v2:
- allocate one coherent mailbox buffer at probe and reuse it under the
  per-core lock instead of per-message dma_alloc_coherent(GFP_ATOMIC)

 drivers/net/ethernet/airoha/airoha_npu.c  | 67 ++++++++++++++++-------
 include/linux/soc/airoha/airoha_offload.h |  3 +
 2 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index b679bed952de..e1e0ddb92f03 100644
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
 
@@ -161,21 +167,32 @@ struct wlan_mbox_data {
 };
 
 static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
-			       void *p, int size)
+			       const void *req, int size,
+			       void *rsp, int rsp_off, int rsp_len)
 {
 	u16 core = 0; /* FIXME */
+	struct airoha_npu_core *c = &npu->cores[core];
 	u32 val, offset = core << 4;
-	dma_addr_t dma_addr;
 	int ret;
 
-	dma_addr = dma_map_single(npu->dev, p, size, DMA_BIDIRECTIONAL);
-	ret = dma_mapping_error(npu->dev, dma_addr);
-	if (ret)
-		return ret;
+	if (size > AIROHA_NPU_MBOX_SIZE ||
+	    (rsp && (rsp_off < 0 || rsp_len < 0 ||
+		     rsp_off + rsp_len > size)))
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
+	memcpy(c->buf, req, size);
 
-	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(0) + offset, dma_addr);
+	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(0) + offset, c->addr);
 	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(1) + offset, size);
 	regmap_read(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, &val);
 	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, val + 1);
@@ -189,9 +206,10 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 	if (!ret && FIELD_GET(MBOX_MSG_STATUS, val) != NPU_MBOX_SUCCESS)
 		ret = -EINVAL;
 
-	spin_unlock_bh(&npu->cores[core].lock);
+	if (!ret && rsp)
+		memcpy(rsp, c->buf + rsp_off, rsp_len);
 
-	dma_unmap_single(npu->dev, dma_addr, size, DMA_BIDIRECTIONAL);
+	spin_unlock_bh(&c->lock);
 
 	return ret;
 }
@@ -343,7 +361,7 @@ static int airoha_npu_ppe_init(struct airoha_npu *npu)
 	ppe_data->init_info.wan_mode = QDMA_WAN_ETHER;
 
 	err = airoha_npu_send_msg(npu, NPU_FUNC_PPE, ppe_data,
-				  sizeof(*ppe_data));
+				  sizeof(*ppe_data), NULL, 0, 0);
 	kfree(ppe_data);
 
 	return err;
@@ -362,7 +380,7 @@ static int airoha_npu_ppe_deinit(struct airoha_npu *npu)
 	ppe_data->func_id = PPE_FUNC_SET_WAIT_HWNAT_DEINIT;
 
 	err = airoha_npu_send_msg(npu, NPU_FUNC_PPE, ppe_data,
-				  sizeof(*ppe_data));
+				  sizeof(*ppe_data), NULL, 0, 0);
 	kfree(ppe_data);
 
 	return err;
@@ -386,7 +404,7 @@ static int airoha_npu_ppe_flush_sram_entries(struct airoha_npu *npu,
 	ppe_data->set_info.size = sram_num_entries;
 
 	err = airoha_npu_send_msg(npu, NPU_FUNC_PPE, ppe_data,
-				  sizeof(*ppe_data));
+				  sizeof(*ppe_data), NULL, 0, 0);
 	kfree(ppe_data);
 
 	return err;
@@ -411,7 +429,7 @@ static int airoha_npu_foe_commit_entry(struct airoha_npu *npu,
 					  : PPE_SRAM_SET_ENTRY;
 
 	err = airoha_npu_send_msg(npu, NPU_FUNC_PPE, ppe_data,
-				  sizeof(*ppe_data));
+				  sizeof(*ppe_data), NULL, 0, 0);
 	if (err)
 		goto out;
 
@@ -420,7 +438,7 @@ static int airoha_npu_foe_commit_entry(struct airoha_npu *npu,
 	ppe_data->set_info.size = sizeof(u32);
 
 	err = airoha_npu_send_msg(npu, NPU_FUNC_PPE, ppe_data,
-				  sizeof(*ppe_data));
+				  sizeof(*ppe_data), NULL, 0, 0);
 out:
 	kfree(ppe_data);
 
@@ -443,6 +461,7 @@ static int airoha_npu_ppe_stats_setup(struct airoha_npu *npu,
 	ppe_data->stats_info.foe_stats_addr = foe_stats_addr;
 
 	err = airoha_npu_send_msg(npu, NPU_FUNC_PPE, ppe_data,
+				  sizeof(*ppe_data), ppe_data, 0,
 				  sizeof(*ppe_data));
 	if (err)
 		goto out;
@@ -475,7 +494,8 @@ static int airoha_npu_wlan_msg_send(struct airoha_npu *npu, int ifindex,
 	wlan_data->func_id = func_id;
 	memcpy(wlan_data->d, data, data_len);
 
-	err = airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data, len);
+	err = airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data, len,
+				  NULL, 0, 0);
 	kfree(wlan_data);
 
 	return err;
@@ -497,9 +517,9 @@ static int airoha_npu_wlan_msg_get(struct airoha_npu *npu, int ifindex,
 	wlan_data->func_type = NPU_OP_GET;
 	wlan_data->func_id = func_id;
 
-	err = airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data, len);
-	if (!err)
-		memcpy(data, wlan_data->d, data_len);
+	err = airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data, len,
+				  data, offsetof(struct wlan_mbox_data, d),
+				  data_len);
 	kfree(wlan_data);
 
 	return err;
@@ -770,6 +790,15 @@ static int airoha_npu_probe(struct platform_device *pdev)
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

