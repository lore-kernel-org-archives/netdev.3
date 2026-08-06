Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B878261B70
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 07:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001179; cv=none; b=NUYlPm2L98AOllnB9keThhypRKhpxKKknFI3FAknDdYxPV+DJ63vYIkzIWvVzn4vB0IPgKqPUffa4s30X49xUidyz216cgAu89pMLG3qDDqO0z+8TtFI3UCGzHtXh5G8T9RflKv5SaiND6BDKop5JGbSZ9c1oZD1uhGmZTh/jcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001179; c=relaxed/simple;
	bh=DwLSILOJ14UgHDlR+2izyPNmb+RJMyL88SqW+3pc1Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbKy8YApASvrSH6s5pbHszlKEU25/hAbmLdk7BeAWTRKSTeI5DAs1KoLqjjKGOxhxAVsxUZQzIRBy/VHfGmnaNegCGLLncLxxoipZHlcG+SzaL0q/+jBqhFQUpP2IOqhNp1tmtOVcvjpQETnNhotjIKhBYrEwNvVOQSusZIHJ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlQKoMfE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlQKoMfE"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47de0093c42so1353201f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 00:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786001176; x=1786605976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KZGj/L3nadsNc5+G4zPPi1gGSB5LzCydIBvRZmooxYk=;
        b=YlQKoMfEwWhsnKMt8Pl3hlqskT9/BnxRXD3BsHQ3QBYeTdD6tuNuBOzOSzKzqqdKJ0
         Aqha4BXcZVU2PPIF0p+4PoHVWsRs2YzoRC2TQ5uKT00D5Ham1iIVLdT6sPe55J68sfiK
         Npam9wTybTF3bhglu9hAPu6exjCIzYG/NM9scNAih8xW2gU7ELtBgFTmeSAqM880fEk/
         YCSWaLW3PFtv3UdV93LLpowZndrEFXibzvMAO4WbQfSDy1M9v1yv3Baiqg6B6rJIl0q4
         h6m5VpNC7vU8cDMGg8mn8ToR8p0tetSLtirsf5e/eSqHLx/J641z/3WKgLAeJ7w0fR0P
         dV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786001176; x=1786605976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KZGj/L3nadsNc5+G4zPPi1gGSB5LzCydIBvRZmooxYk=;
        b=UQeVszlrEDS3QScnhDMSvUalFaAh524Hxg20bgsImnbOFs63LtcEKopymQnZAwhmZo
         xDjEl9mWhPH0tHCyonQsIyCedde7Eu1HMVh/2wlmuOBI4Q3onzAevPrCCii2drE2PUT2
         2yArX9UoE8cSnQqXwGq1EXwn7s1Up82HSTUzKuYiqOeD6QHL/zcGW58p9+3fd59Up9Fw
         /gXx8yPsDNNKYsu3Q8ZkHWkW8lAuCjNyZJ+K7EiliLcZ2NwSM0LQdaJloti3F79Ilw0n
         b5+7513arrKKwiH8Ur2nQvpHaSFgi+/42NMtRJVrhw0/2hznP2wkX+/Fogg975ZIuv/k
         xY3g==
X-Gm-Message-State: AOJu0YyVb2lMz1szh0EtknYRDfEyipkRu3XuDY9uIEtyVKPncesU10Ex
	shEhFrLj5K3C0qiqPs0hGI4ddKafH1ajvQ5H2kJDcPnv6B5YKCiftj6uanGmogsH
X-Gm-Gg: AR+sD11kBpvIgaQk13SgEEMZAXC+q+tME3Ehfba/ZWOx7fUZrERvXEVdmS9+LSxX+Qx
	MMojl2RcY6f0Fwlhd+8G038wn3O3GsFkLPMbmlKEb/WRCDpsD2f+npIzGQnVs9UE0AtdnT80KtV
	CsDkEQWoxtJaw4GRISvyABe6kbFKSND8vQrTX/MOuNSxpVkmhFEOhNYuB8XCjqtCMyGuAbMCcMc
	S6IATFy0DHz1XkXzKZeb0MDPOcUKpgG/AyMLUAh+a8O1Wi3WaP2oDvtVU3zA5C0lgv4YH8N2/8z
	Z7IGSYdWNAqXBPFlfd4tLhmRRVlWiOYRZnl6RPwHRdJQc1ejkcQZ21gLLLFarKxfmMrcORl1XyG
	qy4bcZ00AYVWoqPoXI+H4soBl8Rp6y28YXGQfpx6wMPZ8MAhvrmf1IvUuC8cBuv3G08DOV7PUbs
	NxsJJMLSPrAwRjFCpvJ0E1lyLZ7KtD3SZrkPbXTjg/cp5BFMwV+dJLAE4=
X-Received: by 2002:adf:e992:0:b0:47f:c648:e280 with SMTP id ffacd0b85a97d-47fec519539mr16086894f8f.18.1786001176240;
        Thu, 06 Aug 2026 00:26:16 -0700 (PDT)
Received: from fedora ([46.205.219.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b25b4asm3900021f8f.26.2026.08.06.00.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 00:26:15 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	win847@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH v2] net: airoha: npu: use coherent DMA for mailbox messages
Date: Thu,  6 Aug 2026 09:26:01 +0200
Message-ID: <20260806072601.1815487-1-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805070851.2885888-1-pawlik.dan@gmail.com>
References: <20260805070851.2885888-1-pawlik.dan@gmail.com>
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
fit. Allocate one device-managed coherent bounce buffer at probe and
reuse it under the existing per-core mailbox lock. That also keeps the
buffer valid if the NPU completes a write after a mailbox timeout.

Verified on Quantum Fiber / Gemtek W1700K (EN7581 + MT7996).

Fixes: 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox buffer")
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260805070851.2885888-1-pawlik.dan@gmail.com/
Assisted-by: Cursor:composer-2
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
---
v2:
- allocate one coherent mailbox buffer at probe and reuse it under the
  per-core lock instead of per-message dma_alloc_coherent(GFP_ATOMIC)

 drivers/net/ethernet/airoha/airoha_npu.c  | 31 +++++++++++++++++------
 include/linux/soc/airoha/airoha_offload.h |  4 +++
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index b679bed952de..dfa09fed907e 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -23,6 +23,8 @@
 #define NPU_EN7581_FIRMWARE_RV32_MAX_SIZE	0x200000
 #define NPU_EN7581_FIRMWARE_DATA_MAX_SIZE	0x10000
 #define NPU_DUMP_SIZE				512
+/* Enough for struct ppe_mbox_data and small WLAN TLV payloads */
+#define AIROHA_NPU_MBOX_SIZE			256
 
 #define REG_NPU_LOCAL_SRAM		0x0
 
@@ -165,17 +167,24 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 {
 	u16 core = 0; /* FIXME */
 	u32 val, offset = core << 4;
-	dma_addr_t dma_addr;
 	int ret;
 
-	dma_addr = dma_map_single(npu->dev, p, size, DMA_BIDIRECTIONAL);
-	ret = dma_mapping_error(npu->dev, dma_addr);
-	if (ret)
-		return ret;
+	if (size > AIROHA_NPU_MBOX_SIZE)
+		return -EINVAL;
 
+	/*
+	 * Mailbox payloads are bidirectional (CPU request, NPU response).
+	 * On EN7581+MT7996, streaming DMA_BIDIRECTIONAL against the
+	 * caller kzalloc() buffer can leave WLAN_FUNC_GET_WAIT_NPU_VERSION
+	 * reading as 0.0 despite MBOX success. Reuse a probe-time coherent
+	 * bounce buffer under the per-core lock (also used from PPE
+	 * foe_commit under atomic context).
+	 */
 	spin_lock_bh(&npu->cores[core].lock);
 
-	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(0) + offset, dma_addr);
+	memcpy(npu->mbox_buf, p, size);
+
+	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(0) + offset, npu->mbox_dma);
 	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(1) + offset, size);
 	regmap_read(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, &val);
 	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, val + 1);
@@ -189,9 +198,10 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 	if (!ret && FIELD_GET(MBOX_MSG_STATUS, val) != NPU_MBOX_SUCCESS)
 		ret = -EINVAL;
 
-	spin_unlock_bh(&npu->cores[core].lock);
+	if (!ret)
+		memcpy(p, npu->mbox_buf, size);
 
-	dma_unmap_single(npu->dev, dma_addr, size, DMA_BIDIRECTIONAL);
+	spin_unlock_bh(&npu->cores[core].lock);
 
 	return ret;
 }
@@ -770,6 +780,11 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	npu->mbox_buf = dmam_alloc_coherent(dev, AIROHA_NPU_MBOX_SIZE,
+					    &npu->mbox_dma, GFP_KERNEL);
+	if (!npu->mbox_buf)
+		return -ENOMEM;
+
 	err = airoha_npu_run_firmware(dev, base, &res);
 	if (err)
 		return dev_err_probe(dev, err, "failed to run npu firmware\n");
diff --git a/include/linux/soc/airoha/airoha_offload.h b/include/linux/soc/airoha/airoha_offload.h
index 7589fccfeef6..afd481233489 100644
--- a/include/linux/soc/airoha/airoha_offload.h
+++ b/include/linux/soc/airoha/airoha_offload.h
@@ -179,6 +179,10 @@ struct airoha_npu {
 
 	struct airoha_foe_stats __iomem *stats;
 
+	/* Coherent bounce buffer for mailbox cmd/rsp (airoha_npu_send_msg) */
+	void *mbox_buf;
+	dma_addr_t mbox_dma;
+
 	struct {
 		int (*ppe_init)(struct airoha_npu *npu);
 		int (*ppe_deinit)(struct airoha_npu *npu);
-- 
2.55.0

