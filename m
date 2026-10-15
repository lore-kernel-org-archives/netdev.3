Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F228249AA2E
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054071; cv=none; b=nQi7UapGmwpec6QfHtG3sGPLdFF2LR6U1gas+KRFOHBjk6vMY1Lu8bjiieDZie43fKJUBq+xsS6NDPEYyobH6tZiKcnpoKAUwO78MJw9ECnx4AelwvZuOwlcLrJOYWVSZ32cPirFF062ds2G33il80BqPAIvr1mWN9RSXQOIbrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054071; c=relaxed/simple;
	bh=UGKBj/h6sbvEgkDPV05IVG/HSnc4PBVKluLbWb7zkDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cXy9vSx7zAasa4EdMy+FHLyE6+IkPEVC9uLdzcl19YxBiMutNdg2UGQixyaQ+Sdy03EU/nznGn2YnYAYoNtKVkd+gfxe6gMuPF3ho4VSE6NMnkpGkUHYJILN1TanqB0t+aKFttyKRgZh6y9Xfl2/DtlEeFazPVh31Qj9Ywufaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqPDEyxa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqPDEyxa"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a161d9b8c7so35221825e9.3
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 01:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792054068; x=1792658868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+LoAM7/O56qtCbczKVBsmCZ8BcqH8pl/3PC+hZvCjxc=;
        b=IqPDEyxanP3NJpe4pMcmtZNKXzn67Wa+0NE0HrRCc0dgoO7dw/3k+PC0gXzTQNjkIb
         MAKFqIypdSPkhHsHP9B100v+LVznxhW9g34uMYJ49zovMNrCUTD5AWkhR8fo4OdXzTlf
         WMNSnc+41kpJjh+83FaDI78U/bfIPR7rbV4MHGlU8A39cR4KYUwz/kI+ErUb0C4nzOCv
         cv7bKN3YtNO48c8x4TuYa/mLHMt3mIUGuwtGTsrtSMhqUVBORCDPhaA6tnr4KXFH3lwD
         L6HNV26VAmJ/eQf6t5TwktMgefc1pffFEn6CqsRved7Zh2gk1Nqn7CgGscNmy280asPp
         rkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792054068; x=1792658868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+LoAM7/O56qtCbczKVBsmCZ8BcqH8pl/3PC+hZvCjxc=;
        b=eUcThGJrArYY7wkxwhN6aa+W7+mPzsicv1+FXlyspgVytDMcy5W6LB8BhbqqjAkPbY
         15fxGSe9y5DNqur0AMXn1+3KX5KkFvi7nHjsOmAPMo51C8SrXRaF5SoUBmXNVhOmaZvL
         L4OlGileV60DusS0CmG07KdC76HWaouqnKJU4zH/PHpbInrlUw2DYLJWlzq/3JkQv1X4
         H30kFqzWcLyBluxmcV+MnddDOF9hZFYkIGUyIciUlSs33WVqk+fhTKMRNhxdkXkg/2Ln
         WjxwTZnWgd8UEb5gofzV1gAEXkZdIjn5YW8XX4xYaXKTxwDw8CBk6RXVCzgu13+rxUkc
         9j6g==
X-Gm-Message-State: AFq9FYKZsLppZF+9+rZrDJ4QiTGnoodDL6ITCMm3bhTZeaT7bDD4jQvi
	N9PL3L21w44itugjxyd73AvDYIr4mMU7HH0T309Ivkk3lPv43d0p7ZjI0nHDy6t2
X-Gm-Gg: AYBFou0SVoHOBjCBKfS5uek+6Pvqu9PqSH8cALs9AVXt9C/hSW5LMXd9uVQi04xYGV5
	4ikVSyvkwsmLxSE2fT/dS62/DCHA0CiJYOZwf6aspy8IOWDXXNMc7fAS0jQwkPqUWJo0b3Cj22z
	f21tUJmalfBz5BBDY+2pzs6kLhoTgv3wf95fmh7M7xr5eiZgtIC6LyOmrPKXcGao3/dfnYVpVwL
	oIBr8YuWgDImZ+iGh8nUd+swY3B98+kaG115kwke75aJs8N8BqanRAGGbm8m0cYT9WQXXMtsleK
	zI3GONcUYpOFaPAH18ME9w6uc0rwXEq4Z3lxhRkMhOP0QXPd7sbx+h64+dD0GJGTMCzo5xknZkl
	7GMhj8vw9FeRYaj0ms6KkTMtB7J2ydUEANhRcy34t64IPGmgXv7J65YP9J4v20NjVR+1FV6svyn
	ZdgBSCFfnUB/Ch0DC6ifY18ZXZfVZIajpCaeC/VjfOSGcBbarnE7KE9oNMJrE9f/CER77INyFz0
	pc3xScEFe/Caf+fE6nqnmqfvxA208A4KkxDpaiX13+Rulel/xVeJqN4ofTsHJ1VGO37r68D
X-Received: by 2002:a05:600c:4e12:b0:4a1:7f8e:6e5d with SMTP id 5b1f17b1804b1-4a18e4a393amr399094215e9.6.1792054067874;
        Thu, 15 Oct 2026 01:47:47 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bf63567esm76383725e9.10.2026.10.15.01.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:47:47 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org
Cc: radhey.shyam.pandey@amd.com,
	michal.simek@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	andre.przywara@arm.com,
	robert.hancock@calian.com,
	horms@kernel.org,
	joe@dama.to,
	suraj.gupta2@amd.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net-next] net: axienet: release every RX buffer in axienet_dma_bd_release()
Date: Thu, 15 Oct 2026 11:47:43 +0300
Message-ID: <20261015084743.1798326-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RX walk in axienet_dma_bd_release() stops at the first descriptor
without an skb, assuming that such a slot and all after it were never
filled.  That holds on the axienet_dma_bd_init() error path, but not once
the ring has been running: when axienet_rx_poll() fails to allocate or
map a replacement buffer it leaves the slot it emptied with a NULL skb,
in the middle of a populated ring, until a later poll refills it.
Closing the interface before then leaks the skb and the streaming DMA
mapping of every descriptor after that slot, which can be most of the
ring, and is most likely under memory pressure.

The walk also frees each skb before unmapping it.  With swiotlb, the
DMA_FROM_DEVICE unmap copies the bounce buffer back into the skb data
that was just freed, and on non-coherent platforms it invalidates cache
lines that may already belong to a new owner.

Skip empty slots instead of stopping at the first one.  An emptied slot
still has a non-zero cntrl but its buffer is already unmapped, so the
skip has to cover the unmap too, which it does by coming before it.
Then unmap before freeing, as axienet_rx_poll() does.

This was reported by the Sashiko AI review bot.

Tested on the AXI Ethernet MAC of an ADVA TimeCard X2 (PCIe card, with
the built-in AXI DMA): traffic passes after each of ten down/up cycles,
each running axienet_dma_bd_release(), so the unmap-then-free order is
exercised on every buffer.  A failed RX refill was not reproduced, so
the skip over an empty slot was not exercised.

Fixes: f26667a373f3 ("net: axienet: Fix DMA descriptor cleanup path")
Fixes: 7a7d340ba4d9 ("net: axienet: fix RX ring refill allocation failure handling")
Assisted-by: LLM sparse
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 919e644d9158..a8b8c0efa21f 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -247,13 +247,13 @@ static void axienet_dma_bd_release(struct net_device *ndev)
 	for (i = 0; i < lp->rx_bd_num; i++) {
 		dma_addr_t phys;
 
-		/* A NULL skb means this descriptor has not been initialised
-		 * at all.
+		/* A NULL skb means the descriptor holds no buffer: it was
+		 * never filled, or axienet_rx_poll() took its skb and could
+		 * not refill it, having already unmapped the old buffer.
+		 * Such slots can sit anywhere in a ring that has been running.
 		 */
 		if (!lp->rx_bd_v[i].skb)
-			break;
-
-		dev_kfree_skb(lp->rx_bd_v[i].skb);
+			continue;
 
 		/* For each descriptor, we programmed cntrl with the (non-zero)
 		 * descriptor size, after it had been successfully allocated.
@@ -264,6 +264,8 @@ static void axienet_dma_bd_release(struct net_device *ndev)
 			dma_unmap_single(lp->dev, phys,
 					 lp->max_frm_size, DMA_FROM_DEVICE);
 		}
+
+		dev_kfree_skb(lp->rx_bd_v[i].skb);
 	}
 
 	dma_free_coherent(lp->dev,
-- 
2.47.0

