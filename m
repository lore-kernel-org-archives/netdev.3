Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792856542;
	b=YKJJXHxeL7LuEfrbk5qibGQWjAAagc/SkQK1i1JUu1sMXKWI7P+Zf11k5AvnwV1ERT4B
	 5clH3ohShXviM99COjxxmPhFf9Qz52VtnFDH2Gz3E3lJK7Bg7Yn7irzMJtGKnizjecyMs
	 QNUu92HvecC6fWp6UxZFJpm1b/0ziDB0UEACdFRw1YipD+5eymxPvAEeDzGheCislLtTE
	 8kw0dt7sO6Htw6NdxAy+a1iyrucQlvh9F9NZS51KF42n9HPpo6xvfsK++I8NCwNq7+gu8
	 yPQF5LQpjuUrx/NtFHjY+LZDUCjl7dVye8WOCkpyYM9dY62HSxMWYuWHbH2k3S2QbWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792856542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tD2feZvStARhEioc5t9JjRKN0PpC4uBKpPB9fxOPNPo=;
	b=XFJb8N0ZlTprL9zxrCVQH2J4IOSncQESGBb+rHB3DYfIM6qX+yPHROIxskwFMTEKpvbQ
	 7ImhbKicxvBRZm9wnNuvbWdlmWsmuvIzHUigYQX8nUGlwJ76uRTGb/X/38NKQCzVAxCvX
	 CbnlkAaFFcrBeI9dFOAOe1aGfJCR7BcUEWjric2a84fmaZoAvikGGNxuhGMUCC4KZkmwJ
	 qZQHvplYBixhRzRXBt7zvR9ppnqIfwLbRhcJnNMMVdmFCc/p7nFyk3HMmBcKEQK5xnlmb
	 yvMafUyc1KTNIWhPe4JjYgF22J+j5FwvIsHWFlZC4yDo7SWfugNW0UBoAfKkonr4mDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZtbZRwUP;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6C6606A31E
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 15:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF6C6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZtbZRwUP
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36661f953e4so3195145eec.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792856541; x=1793461341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tD2feZvStARhEioc5t9JjRKN0PpC4uBKpPB9fxOPNPo=;
        b=ZtbZRwUPjVQiSvYWWtMu6dPTKilxoct/OWvipe27Jqf5G28IPqMi55WvuE+zmC1HFZ
         OL/Ws1vcN1cxGJpO+Encb1YRO3M6m7ZNiBAmayVlAcdZyFeDyQhifsfVwo9SDu6hSTPA
         TKIvnz8sRyd3ncvbREayOVyHYdssYPLAxON08pyahSkqyBOXzvbiavGi+fqdHUUdfod6
         HK/1coQjD6/w6rz3XnPKbUW/ynFejEsN1OyZb91Df29ZCCPys5qab05Vv/Ob8HkX2P68
         DHTLWYxdTt00EZ0Jh2N2krvQiRUSSrlNTmJwC0ujKCA3WmoSchFLq8pAwvMrKyQYRCSM
         SCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792856541; x=1793461341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tD2feZvStARhEioc5t9JjRKN0PpC4uBKpPB9fxOPNPo=;
        b=VuQzb6KqpV2WZYHhHY8brsdYDLRnxRbCbnd1wKiKvc3KGDPRDK666/xWAa2/P4Q80w
         AIEUggonFnosDo4MhPPbJrA4VjZ8v6P1ninedDp4VI8Kde/jjur60r5eXQMItMUOKJm7
         uFnNBhu7EOBzAwHAhe/PQadwuAfaimhiOhpw5t4mswPHHyPqcn+OhqAhnAPTCoHHaBz0
         owxkfLVASz/3V8MhwX5B3PzuVOgDG5aDz6G6hGXqByzqa+KypJMi5MHovavsoRBysBDp
         EEJvAu8crfkMc2RLXLnHg+jJDk06JiQaNR+cr1t93oESgqzMv8Wh9joyboyVlFTCIZVV
         UYHQ==
X-Gm-Message-State: AFq9FYInDyb4fUOIt5kcr1RfXU73JFoOQ13TSma81yIICsVHqS44h/Wn
	lZVzSwPeqxduAKPW+C41/5tycayZ9uMopBxyNbXBJ6qSHlCdt/NsEP0iy5m0NBfY
X-Gm-Gg: AYBFou2F5P78WjQBG6D/bL1+vLhsFf44QooowNTOnUmjkVhACx3d0KbeiUCPSnjcM5t
	+rApaoMo7RWwpG/jh07dYhurqmF3y2mTClZywDeaSEbO+YaZY1K3y31DB0sc0P+vLLxoNGitlpx
	dQQA28js0edOrKElLxxkrn89xLsYeLmpy9nxMMf5iRsiKe7XBOTXRVLnBPGmKVgw5tw/lK8lPiv
	ZSW3P9bRW1OavTocH5Cf4s+JMpqcLyfcT89pIctWPHLjbCo5JbtqGu0OfGa2a9YEM/IeG3ww2O0
	es+Wjvpw30pEimHhQLvjVIN0Rg6/7uqtcEHJnOzGU38hs3TT0nVsJYzsXR3jfp4jf4T3bFQ1Ish
	LkG/mRlS3+5znhNRR9KMQdefsuP5R/y6ASObU37hMR/DPipOgAQw56nOynweloQAK2aYvxfu4M2
	mNQIggHv/kcp599Bm1GUdU64D3ALwT3bKyXNEnJc2UUIDs464r3gTf60JlPQk32cRcDr0LSa52k
	RvNdqtu8VdqdJ82NoRidPl22tikNpsB1zlIobLpDkipOOAKuGGML8G4vw==
X-Received: by 2002:a05:7022:5f06:b0:151:2e62:fe8a with SMTP id a92af1059eb24-199379c8064mr3258864c88.40.1792856540859;
        Sat, 24 Oct 2026 08:42:20 -0700 (PDT)
Received: from plex ([2406:6d00:a27c:4200:aab8:e0ff:fe02:33c1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8daf444sm7766450eec.18.2026.10.24.08.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 08:42:20 -0700 (PDT)
From: Chris Scott <gilroyscott1970@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	pawlik.dan@gmail.com,
	zhengping.zhang@airoha.com,
	Chris Scott <gilroyscott1970@gmail.com>
Subject: [RFC net-next 3/3] net: airoha: npu: use coherent memory for mailbox messages
Date: Sun, 25 Oct 2026 01:41:50 +1000
Message-ID: <20261024154150.45733-4-gilroyscott1970@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024154150.45733-1-gilroyscott1970@gmail.com>
References: <20261024154150.45733-1-gilroyscott1970@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Pawlik <pawlik.dan@gmail.com>

airoha_npu_send_msg() maps the caller's kzalloc() buffer with
DMA_BIDIRECTIONAL. These buffers are small and not cacheline aligned,
so on arm64 the mapping bounces through swiotlb. On a 2 GiB EN7581
board the default swiotlb pool sits above 0xc0000000 (0xff6cf000 on
W1700K), outside the 0x80000000-0xbfffffff window the NPU can address;
higher addresses alias the lower 1 GiB. On W1700K + MT7996 this makes
WLAN_FUNC_GET_WAIT_NPU_VERSION read back 0.0 and mt76 does not bind
NPU offload.

Allocate one coherent buffer per NPU core at probe and reuse it under
the per-core mailbox lock. With the previous patch it comes from the
NPU DMA pool, inside the window. airoha_npu_send_msg() is also called
from PPE foe_commit under spin_lock_bh(), which rules out a per-message
GFP_ATOMIC coherent allocation.

Add __airoha_npu_send_msg() with an optional reply buffer so GET
callers copy only the trailing response payload; airoha_npu_send_msg()
keeps copying the whole buffer back, like the bidirectional mapping.

The original version of this patch was written with Cursor (composer-2);
it was rebased onto net-next and its commit message rewritten with
Claude (Anthropic).

Link: https://lore.kernel.org/r/20260809152813.585797-1-pawlik.dan@gmail.com
Link: https://lore.kernel.org/r/atCRsquzA1UxSpCc@mediatek.com
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
Signed-off-by: Chris Scott <gilroyscott1970@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_npu.c  | 65 +++++++++++++++++------
 include/linux/soc/airoha/airoha_offload.h |  3 ++
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 069fd60680..3d1aa63dd5 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -24,6 +24,12 @@
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
 
@@ -161,23 +167,32 @@ struct wlan_mbox_data {
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
+	 * The NPU only reaches DRAM at 0x80000000-0xbfffffff; a streaming
+	 * mapping of the caller buffer may bounce through swiotlb outside
+	 * that window. Use the probe-time coherent buffer, which comes from
+	 * the NPU DMA pool when one is declared.
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
@@ -190,13 +205,21 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
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
@@ -500,9 +523,8 @@ static int airoha_npu_wlan_msg_get(struct airoha_npu *npu, int ifindex,
 	wlan_data->func_type = NPU_OP_GET;
 	wlan_data->func_id = func_id;
 
-	err = airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data, len);
-	if (!err)
-		memcpy(data, wlan_data->d, data_len);
+	err = __airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data, len,
+				    data, data_len);
 	kfree(wlan_data);
 
 	return err;
@@ -794,6 +816,15 @@ static int airoha_npu_probe(struct platform_device *pdev)
 			return err;
 	}
 
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
 		return err;
diff --git a/include/linux/soc/airoha/airoha_offload.h b/include/linux/soc/airoha/airoha_offload.h
index 7589fccfee..16a988ad74 100644
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
2.53.0

