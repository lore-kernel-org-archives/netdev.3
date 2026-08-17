Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BDA3B8D4F
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957573; cv=none; b=FcLrcBYWvaErlI/QxNHPjavYLrrrCuyVpQJecKwXHgtLBf/DAslg/iXum4BBh8HipU6qxc4wZWjms6zxF/8ypCULIbs+GJKf0QJjxonno2VtAoi4sjirK1RfZKKC+tkeMDPygwmJa/bUzo7f46ubBrRspQtiWkAm8GkHBZgjdqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957573; c=relaxed/simple;
	bh=WnSj+ZUXzkrnDlULIBXKJ47oqWwhM6V3lsqmlOq87O4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HsLJ6o6qAkOzU+awE7/iSe2zw9+7TA9OipnE0ZVuVO5LtZJvaxqGZz8uFckfhEwLnpEF+259kZLsFi3i1exkYIZEeHpayGv5lNFmBSoVFSppUkhwOvlrA87HkUye5jtGrlwau69apUtHw2UP5TmCSNf2GWAeNeyzaOX4ps9bwmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTus5L/J; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTus5L/J"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47fecbbafdaso936626f8f.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 02:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786957570; x=1787562370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=luZ6/X1fUnmPIAGg7u9rfHAcCpIwRBZ6wNZmQs6CnhI=;
        b=gTus5L/Jk+IymhP97UE6+0h28ny954zXwdrsciP8PL7isc/uWPVXM/lA91YrpgYNbb
         IYn8t5+OS9GHVcFOOx+PRKFFu05+tAd5h2hb/dYJ/I72iQDwkXvdJk2BG44kdXS8U9vK
         gvRDHdBQOUMG/WgHHt1alrhRaCSqSOnzRa102oOmZ0WRwwJVClHnakfO+87pm9qFfqx0
         VQM0SowSZo8iU5MVuDkoyRshK/th/LQvJYH4uLG3JiGzWW3TwaGu5P0YHRjsym6WDQ66
         9/hCICMLWr6BYkDuftZL+JLP5Z0e0+HrNb7y4nt/ipcQJFADhmg1HnU1KYMFBj+VVbSW
         /3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786957570; x=1787562370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=luZ6/X1fUnmPIAGg7u9rfHAcCpIwRBZ6wNZmQs6CnhI=;
        b=b4efigg+E4tnYVDk8ABDwLyB0zz6LKgT3CIWDb6twvWGsmtZ4vJfbtLR9Of3qTXDrs
         KyzffWnC72YfC9r4/Vg6wHfiXyJkQS0PdqxE+nXYahZH9gWn+k5yVcLb8jynoWQ5tu6w
         mre/3i8JFLNIpaCoqXwFBOslLVfnFNTWGTCarGtmBmZzV6n1vn9ofdTN8/Lw1yrJuS45
         YGWh/cVzlcdNql4BTSnqVFHNoEiQRd4qrE9fLKo5YYQi/WSQ0//4yCVLvAZXKvXUvcqN
         lgD90KTg98WsO2i5a4/z4xxfPqQziAP6DfzN+cbW6NeaeUrganjAhWIhpnNcc0R4aRM4
         +4bA==
X-Gm-Message-State: AOJu0YwULkeip0OkBluQBLYGoJ+aeNcsZW9gq10FFVAJF1bIxiOWUsjJ
	FzA4MuD0ty8sHxLtYjuGgbtxFxwlTfAZjLfMCrJPeCH0X6YtUisfO55iBOHqNKyq
X-Gm-Gg: AR+sD13RuuFKy7Q/VNYC6ZVJIjgkR7QAUoTakO6TXSnx+n6noHbxqdrFB9Dt4keKht1
	JhjeP5JXrCGGSnB5y1fM3vJOQGR5s/QHaR1l0zSP/s5djwwUKLzWlFl9hnQipmvDtC11kK1yF7b
	kVyyBe+qdMWK6du2g4d8bHVHNA+qq2vM18ruo9apePg1cKTtdh5j0TFgryHfwEUkiVd++Q9FHkF
	KwpQRqEHj0XkvtyB6ec33nNLdnC4KaogC50d/78p8iyAFWDbaiOnMpPsTLH1WidxWEe6v+Gbjuh
	fkvj/mHPBwFPo0Cvc0afvgnVZ/kw8O3DU/S4vJl8sxCf2KkFCzOpkhNcqW6AxtGHj5nPMsAK+AI
	wyaqruAvktl3GKyYuU471MG7inAEoPaAC4XVSg2eAmpg3AvsZqs6w7Z5jE7eqICf6JcqOLF0xiX
	KJpau3FC8s1nI6SrRBC52Mp0p9wVmK5HpSTkqXMyREWPLNYib2497mruX9+GONhNAJtyMIjEsE5
	lgLpJgyVCmHuqGjuyy4w2qH3af5iLV27Nh0PSdXrGomie/uNh0sTJk=
X-Received: by 2002:a05:6000:230d:b0:47f:8ce7:8684 with SMTP id ffacd0b85a97d-481607100bdmr40751188f8f.6.1786957568437;
        Mon, 17 Aug 2026 02:06:08 -0700 (PDT)
Received: from fedora ([46.205.219.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b2e9sm2507130f8f.9.2026.08.17.02.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:06:07 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	win847@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH v8] net: airoha: npu: use cacheline-sized buffers for mailbox DMA
Date: Mon, 17 Aug 2026 11:06:01 +0200
Message-ID: <20260817090601.1256389-1-pawlik.dan@gmail.com>
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

Allocate at least SMP_CACHE_BYTES for each mailbox payload and map
ALIGN(len, SMP_CACHE_BYTES) with DMA_BIDIRECTIONAL while programming
the original payload length into the mailbox length register.

Tested on Quantum Fiber / Gemtek W1700K (EN7581 + MT7996), kernel
6.18.44, including two cold reboots and sustained WiFi use.

Fixes: 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox buffer")
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260814110017.2795022-1-pawlik.dan@gmail.com/
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260809152813.585797-1-pawlik.dan@gmail.com/
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260805070851.2885888-1-pawlik.dan@gmail.com/
Assisted-by: Cursor:composer-2
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 25 +++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index b679bed952de..d560b8763753 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -5,6 +5,7 @@
  */

 #include <linux/devcoredump.h>
+#include <linux/dma-mapping.h>
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
 #include <linux/of_net.h>
@@ -160,15 +161,21 @@ struct wlan_mbox_data {
 	DECLARE_FLEX_ARRAY(u8, d);
 };

+static size_t airoha_npu_mbox_size(size_t len)
+{
+	return ALIGN(max(len, SMP_CACHE_BYTES), SMP_CACHE_BYTES);
+}
+
 static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 			       void *p, int size)
 {
 	u16 core = 0; /* FIXME */
 	u32 val, offset = core << 4;
 	dma_addr_t dma_addr;
+	size_t map_len = airoha_npu_mbox_size(size);
 	int ret;

-	dma_addr = dma_map_single(npu->dev, p, size, DMA_BIDIRECTIONAL);
+	dma_addr = dma_map_single(npu->dev, p, map_len, DMA_BIDIRECTIONAL);
 	ret = dma_mapping_error(npu->dev, dma_addr);
 	if (ret)
 		return ret;
@@ -191,7 +198,7 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,

 	spin_unlock_bh(&npu->cores[core].lock);

-	dma_unmap_single(npu->dev, dma_addr, size, DMA_BIDIRECTIONAL);
+	dma_unmap_single(npu->dev, dma_addr, map_len, DMA_BIDIRECTIONAL);

 	return ret;
 }
@@ -333,7 +340,7 @@ static int airoha_npu_ppe_init(struct airoha_npu *npu)
 	struct ppe_mbox_data *ppe_data;
 	int err;

-	ppe_data = kzalloc_obj(*ppe_data);
+	ppe_data = kzalloc(airoha_npu_mbox_size(sizeof(*ppe_data)), GFP_KERNEL);
 	if (!ppe_data)
 		return -ENOMEM;

@@ -354,7 +361,7 @@ static int airoha_npu_ppe_deinit(struct airoha_npu *npu)
 	struct ppe_mbox_data *ppe_data;
 	int err;

-	ppe_data = kzalloc_obj(*ppe_data);
+	ppe_data = kzalloc(airoha_npu_mbox_size(sizeof(*ppe_data)), GFP_KERNEL);
 	if (!ppe_data)
 		return -ENOMEM;

@@ -375,7 +382,7 @@ static int airoha_npu_ppe_flush_sram_entries(struct airoha_npu *npu,
 	struct ppe_mbox_data *ppe_data;
 	int err;

-	ppe_data = kzalloc_obj(*ppe_data);
+	ppe_data = kzalloc(airoha_npu_mbox_size(sizeof(*ppe_data)), GFP_KERNEL);
 	if (!ppe_data)
 		return -ENOMEM;

@@ -399,7 +406,7 @@ static int airoha_npu_foe_commit_entry(struct airoha_npu *npu,
 	struct ppe_mbox_data *ppe_data;
 	int err;

-	ppe_data = kzalloc_obj(*ppe_data, GFP_ATOMIC);
+	ppe_data = kzalloc(airoha_npu_mbox_size(sizeof(*ppe_data)), GFP_ATOMIC);
 	if (!ppe_data)
 		return -ENOMEM;

@@ -434,7 +441,7 @@ static int airoha_npu_ppe_stats_setup(struct airoha_npu *npu,
 	int err, size = num_stats_entries * sizeof(*npu->stats);
 	struct ppe_mbox_data *ppe_data;

-	ppe_data = kzalloc_obj(*ppe_data, GFP_ATOMIC);
+	ppe_data = kzalloc(airoha_npu_mbox_size(sizeof(*ppe_data)), GFP_ATOMIC);
 	if (!ppe_data)
 		return -ENOMEM;

@@ -466,7 +473,7 @@ static int airoha_npu_wlan_msg_send(struct airoha_npu *npu, int ifindex,
 	int err, len;

 	len = sizeof(*wlan_data) + data_len;
-	wlan_data = kzalloc(len, gfp);
+	wlan_data = kzalloc(airoha_npu_mbox_size(len), gfp);
 	if (!wlan_data)
 		return -ENOMEM;

@@ -489,7 +496,7 @@ static int airoha_npu_wlan_msg_get(struct airoha_npu *npu, int ifindex,
 	int err, len;

 	len = sizeof(*wlan_data) + data_len;
-	wlan_data = kzalloc(len, gfp);
+	wlan_data = kzalloc(airoha_npu_mbox_size(len), gfp);
 	if (!wlan_data)
 		return -ENOMEM;

--
2.55.0

