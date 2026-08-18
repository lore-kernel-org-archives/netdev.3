Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E99A2F8E86
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787034124; cv=none; b=bO8VEtYrd5ptuoxNICleSy5lxzwDenJJ2+pTrNcs1RjZLyNhy1FZe1ZeBnvZDYG+sPX4eojYVsPwzf5kiYfcwAaIiDWuB4ksaMjKa8Yzc3/3NaYqFi1NgTfHZ8eYB7jqqRBRA4Nl1edHgT/82U7VuS8yVzRrdBouqQ8IWurkTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787034124; c=relaxed/simple;
	bh=ihpRQwiIlz3oZeQ0e0mKkjZCwd80lTT3yc9FPKQ5/g4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uw/BqUFSFp4uWmG+upvOR3V4dQ6pJlwUdmKySsGbhii4eUSybyNAqTHDC84TESZLZx3Sv235Def/skT2LoNmsyhQHsdu+oBiMctXE2+owHvEmPWa7o9i0tf3CuGw+NfzEc/gb+ox6BE/uEikOg5kdIHMLbYwgAbAmyK/yU/u5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWhi4Py0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWhi4Py0"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so4258512f8f.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 23:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787034120; x=1787638920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pHr4Y8C7R5Apz3Ajw29/NxHZ11lFDdErrS4WW8DaORk=;
        b=rWhi4Py0rl4DKmkMhwCRcSPEuQcLqJ5aPDxVz8Gg3UMmdIuB42vnFruPP6I5kXR1Dk
         tIq+Lag0I88WSwVgLcck0MLbpc31uaUh9wJbZobhUxE2YSfIw3EdWlkfwZ2/XrKY4UEF
         VdGhxaaygEArSqf1Pw/UyQZkdjSOMj33KeNAs4iq08QTvqCdomMmMzy7qCMHWFDpgTkd
         SiCoWH98UVZ7Z3hjGOmnXIRK6peOBlzsdgNgO7TuYSyXRhtmCBYhXqitXb+XnxtlW2lF
         36V8SHJ+1HpR00gLuhG2Xk+2Pgk3Wq+M0hfin/1LyZAxE46Mt8eDbSrccKVpxzGugBbY
         xn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787034120; x=1787638920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pHr4Y8C7R5Apz3Ajw29/NxHZ11lFDdErrS4WW8DaORk=;
        b=bcHiVDg16c3tX0McHuKPZUS2RVc5xFv6fPXbrfbTtRL0d4jjlWCEvUKDf7IDAf6C/v
         RFZ0omLmHR/et7kPgHmI+ODwECWVezaMT5PeN28dlIj5TJWSaQIxgtXh3v0AjaHO1oOZ
         nQnACllLDa0rzY0/Q91AdiXLLkAZZOhZUQrEcl3sknVW0hQFpB46r2Pra7y+T8j4Zk+v
         KmjYCRaVEyk2AMX7I2/3niir0RrLZIY5MORWrzMtYVY2befAYRNs95T/Hdf6f98vQpv2
         VPf7grm1QCXl9XwIczZmvDujUfpC057Nmu6T0TUVlIicdUSD3CDaCe22IEAfaczbqxLr
         InPg==
X-Gm-Message-State: AOJu0Yx29Z4cYS/56lXLLQFoBpbNH7EJTmMRB2Cy5ZXmQ0TRW0FjpilK
	LDrJ513VU6KqeQAaPiyyZ601U9aAV9gGozkdd32TaIHXMDtS10MwoXvUDsZzklRE
X-Gm-Gg: AR+sD10A740OuZBr8gWHgrxEXq7WrVVkd5z8iVNeM+EP1kdCf8FWwqtF9M6z+WGEqPW
	31dpXqSvow2Zf5M3M0iKdZpqA4Y6cTIJRmqHBDgTTF+YbBVnYZctzWY/gUpdRkYvRDNsaAu7bLF
	1kg+YAWdYN+otuQBEOQ5QrxGg0y2V4NA+AOOQ+Xek6qzrKcFWttia96BP4dFypfMZK/w6PuBwlK
	mqxzgLRPLY1UdglTQZfdn4v0ebQfEfkeAwt+Fi9+MY8ZT4DsmVgaaSN8E+aP3bCH73gQil3Jtve
	33VAG6+LZ/DULBBPZNJ+w4DRVJpUyaYvQKzm/MqeiuRwrNjnqEfWZBwF9NdZtHkT5F7COMPx0GT
	KRyq3kKeVlF6f3W2FDhwifLKYT/WI96fhKCE+m+zDEjmRWXaBI/oc9Jj923IXhDT7oQtgJTriSW
	WoxAkdMgDEmxy+UII1Py3JVIFLPV4j+7C1qQujtc0NaZzJKAUlkvgp60DCBUtd+De1HugXdFxcn
	oVei14U7nQEEN9S8tmvMshUcLFZHL2WbAIRxctAOGM=
X-Received: by 2002:a05:6000:46d4:b0:481:5ba5:9927 with SMTP id ffacd0b85a97d-48160705dcemr32728199f8f.9.1787034119642;
        Mon, 17 Aug 2026 23:21:59 -0700 (PDT)
Received: from fedora ([46.205.218.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b660sm9346196f8f.15.2026.08.17.23.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:21:59 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	win847@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH v9] net: airoha: npu: use cacheline-sized buffers for mailbox DMA
Date: Tue, 18 Aug 2026 08:20:38 +0200
Message-ID: <20260818062038.1599651-1-pawlik.dan@gmail.com>
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

Round mailbox payload allocations up to dma_get_cache_alignment() and
map the same rounded length with DMA_BIDIRECTIONAL while programming
the original payload length into the mailbox length register. On EN7581
the rounded map length is required for GET responses to be visible;
mapping only the payload size regresses probe back to 0.0.

Tested on Quantum Fiber / Gemtek W1700K (EN7581 + MT7996), kernel
6.18.44, including cold reboot.

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
index b679bed952de..9c95ddd7002e 100644
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
+	return ALIGN(len, dma_get_cache_alignment());
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

