Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731913DB625
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216406; cv=none; b=TAC97ciY+GTZx+UcrRjqUPqsh4OBjKFEEg44wnY/xmCeV/vajiqaBzNo6SRoL0Te1LMCZgk7LKZ6XV3kbMSg/9L+VD0jdAhOfDyTT4GNZ8sX1XpYVb3u+NwhxYevcnQLoaf8ydWeeyuyNhnzvbFhmQ/3CTYe7ZIjSUmfpgfl7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216406; c=relaxed/simple;
	bh=cONKhTdYJ8/PqOJB0yMA4E6yHpI0oxGddegi8aQ256A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8S/q/wnL6K3+K+VuSYaGkjLSZh1T8EWKSkf9TtrRCQT5g2gJD/yqh8XzSP1WghAOJbGDNsaig5PyZ+kTfqCza2VU7oQmjampHyFIjfwZ2Sw7umdhjwEChyXctJuD0lIKbHwoRfOyymAkfJAeVowAWvpgtXp71YyJxA6qOpvY6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVD/tKqp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVD/tKqp"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49954b88fffso19948665e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787216403; x=1787821203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wVYZJVLed/RrGWFRSVBujog+j23nJPZnuYw3+qXXz+4=;
        b=oVD/tKqpa03uVT1rIC+UHM+5j01bzH79ZZUVwVRklYa86UsOYvFD7EQOMTtuWeMpIy
         tP2Qg4Y7qW3XunPc+xyU661+GEe60AOpbmWLyGCURnNH067eGHolyPZa3CN9hktDUKhz
         +h0f/adSVp89UbdBWzFh8G+teFRHlrxePS1PM6qQZwbNhss30vmzccukZKxjckAbSXeU
         gpSvhELuUNN/5yeDBVskdryM2+OxMOZLbx1kbN3EHj8HOUroSuA1I/SPrh958xFoAuaX
         xXe1fZEyEzlner5JIF5MgReJOj27OuumYNnMeGLFj0qwnzyI0AsqI/ZuN2YCqwITfJEn
         x/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787216403; x=1787821203;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wVYZJVLed/RrGWFRSVBujog+j23nJPZnuYw3+qXXz+4=;
        b=VxVGcDcUyThZP0ImPRQmIq0Ha2SQEn/bJrdOP9wTVOKLAMAjh0cMrsf40AXibUlNbl
         2IkEnjKLZa+HGLOMDtujkOSSRQpUUmlqVqrw3WzFfcus3hfoYkkbg+s/kQWEpgfoa/7q
         sIBPq+Mo9x3v5BxZPxugh7E7lTsVmerEb9DQRm2ItWdAmaD7iBu52n0uR60P3jIuiBbH
         DoQaFc+vtHPP7d58dxk7YFfmW25OCslGM38m8RtQUG5N5jq6H5LYM02v/HdngOU/EUeB
         kQ8jBz5tpUiyEw4eVhJ51OHa2CgY+ivsmGP1QIbUcm4CwxnkHRwie1vfOZoV/1BdUROy
         ECzQ==
X-Gm-Message-State: AOJu0YwbrXzN+573Q4lwnjIS7aerbh8pvToQHB5oLllkRyTrP7hT+e/A
	CH5CE+SXqwoHLLDu/X++seiDZCsx8wLibmfEp3d/kZDSG/C2qkYdZhFGZ3xY4uuB
X-Gm-Gg: AR+sD12RiNshRkwESEeDliqn5moogJPG/UPwQn7qLvW49/lw1qmtTJUG5HgTrkaV5ve
	towUj4CieUDjqPigtlYADfQGExdkNKUlea9GqpPETwLyrA2jnnG07HAiWG+qFlmTxymyza1rmYF
	qE7AnQHnRASOQ6roKbtHV+tROs3cJOhZIxo/dViJ67HVdUMuF8Q5lQH5P2+IcaHlUkco1Akk0rj
	OcmWvwO7nuvgR598Y5srHNwuQsY3mQu6UXoctFKVNXR4liTX9FYVfrkxzYoG/NAsiHdZUZL/xMQ
	WMNyKmfrI0X7VljewO15ioAD3PwgG/uNCH9RHQg7RiuCc1ZwJuEF69LoG5ix8bvTUj+i8NG08IO
	qovTFbbbyiWC8ebhJBiHvRC25an7SwaC66kCrw0QBbzcuSlNQ6huwZDDsj5AGcQBA64CuOdzXll
	QKNLZRvX5OUSv89dxMy19KvuqdTC9agZyOYqJend/AKwGxOQZ33GVYgRkMtERjRo6DSx81ZyqIb
	prjVQc81FrOAGbTYTkDHpn1v5dgoZTtzPgKefUSG6yyDBscnebwaWM=
X-Received: by 2002:a05:600c:3b8e:b0:495:7888:281c with SMTP id 5b1f17b1804b1-499aa0dcd47mr188111325e9.0.1787216402552;
        Thu, 20 Aug 2026 02:00:02 -0700 (PDT)
Received: from fedora ([46.205.218.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa1111b2sm176837215e9.5.2026.08.20.02.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:00:01 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kuba@kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	yangshiji66@outlook.com,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH v10 2/2] net: airoha: npu: use cacheline-sized buffers for mailbox DMA
Date: Thu, 20 Aug 2026 10:59:41 +0200
Message-ID: <20260820085941.380401-2-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820085941.380401-1-pawlik.dan@gmail.com>
References: <20260820085941.380401-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On non-coherent ARM64 (EN7581), the kernel's dma_direct_map_page()
forces swiotlb bounce buffering when:

  !IS_ALIGNED(phys | size, dma_get_cache_alignment())

The NPU mailbox buffers are 12-24 bytes, well below the 64-byte cache
line size, so this check always fails regardless of physical address
alignment. The swiotlb sync path itself works correctly, but the
EN7581 NPU cannot DMA-write to the swiotlb bounce buffer address
range — it reads commands fine (mbox_status=0x7 success) but never
writes responses back, leaving response fields as zeros.

This was confirmed through five boot traces on a Gemtek W1700K:

  - Boots 1-4: all streaming DMA through swiotlb (is_swiotlb=1),
    bounce buffer byte-identical to pre-map after NPU completion,
    even after explicit CPU cache invalidation (dcache_inval_poc).
    NPU version reads 0.0.

  - Boot 5: kmalloc'd cache-line-aligned buffer bypasses swiotlb
    (is_swiotlb=0 on all 169 mappings), NPU writes response data
    directly, version reads 0.1111, WiFi fully functional.

Fix by rounding mailbox buffer allocations up to
dma_get_cache_alignment() and mapping the rounded length. The original
payload size is still programmed into the mailbox length register.
kmalloc returns cache-line-aligned pointers on ARM64 for allocations
>= ARCH_KMALLOC_MINALIGN, so the IS_ALIGNED check passes and swiotlb
is not triggered.

Fixes: 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox buffer")
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260814110017.2795022-1-pawlik.dan@gmail.com/
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260809152813.585797-1-pawlik.dan@gmail.com/
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260805070851.2885888-1-pawlik.dan@gmail.com/
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 25 +++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 4045d1eb93ea..3416f921f961 100644
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

