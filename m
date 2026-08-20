Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8E4854F5;
	Thu, 20 Aug 2026 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247715; cv=pass; b=B2ia+kCao59/RQzkYokc8xy2qNb6Xycs8H9iY4c6nrrE3JcVAAxMxCbeGZcimd13ay6h+fnKnhr3EBBW79/VwJ94FZTxSEcVafbSDjJ1QW4Yvgw/pu4xRzBkQZOIwju9TzFpRlPRZWiLkBHb6GXW6jfOP+opvtJUpLEXldSo5FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247715; c=relaxed/simple;
	bh=lpW4F1Tg770h1FZ7ZWN+DQWg3F1lV4PebUWjlWuNNqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T/5qPq2p0ZU5biieOxhPQJM2CR4kmWHQfbtXPgDoUdDIJw4JC5ZwmzkWl3ZcGfvVuhP9vBRNvLI45EIUUjMeXSjX0AKTjjW5GI+V8+Ue08NsjF7x6wbkw/bZflCrukoxT7ardlGU2+FthCG/TwQ4cgIoGYEePkUHEuxqwAGoyJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=QQwnKlsl; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="QQwnKlsl"
ARC-Seal: i=1; a=rsa-sha256; t=1787247702; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ite2VGp1mGg/Iw4XytWttLsfVTjrSt5F35YtgJRr8gWVbFCJgHOJGFJMDSi8dxNpgrgELUO6SAvBsU4o1LjDM6/qRCq6exLNO4gN85W8ptNGo7xfHY5VokrlWpWHoVy0i7cKPFvVpZCB2y1tBOBHut+jPHBzjeVylr9e/t70n3Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787247702; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4Drc+IWILadi1NxH9mp00UWP2ajdSuXyMwf0pasAkXM=; 
	b=LUfvjQwlhY7OaHJc2RkS+LBWYIUdc3G+3Brt5xOKFzfCx/DwkiUVLrANIV+N45MkssHRidfO9GNhdEML674g0JVEJfd6gc62NFeDjwA/NH90h5Zt1+TWpSZzMHE6KEafECZgbJUzngsyK2E/NQohTQiwNxEvaB9AO/oK6dy/RPo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787247702;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=4Drc+IWILadi1NxH9mp00UWP2ajdSuXyMwf0pasAkXM=;
	b=QQwnKlslpeslMO5Cntd+RNfYuNvOTzD7OTLHGS8GGgRnmyM64HPT3E7/WfLUeUIF
	UtzkCXElK7iNaeU2m+n57JkR2ssdDj09CBtAU4BAv6qzbK6UCyQ0nattAMWdSeox5Rc
	j4AF6KGzyqgTRoupC30naJL34oacYUgEhv1qP1sT8Czk/TWyn+CW30JNRVjJTV4nkdl
	6HQ9TrbqENIyYBX8So7b5oakzM4dsHA/2LyLHtfAwkfXbq1bhrRvVNY8ehBqfQ76Cq3
	Y9NTljWW1mlBZgt1N1YhN6D4zzBnb/QYDS8EoUCyC1L92V9nDX9JDXq142qTfOuSZVK
	WkKcusuVDQ==
Received: by mx.zohomail.com with SMTPS id 1787247700614866.2660382066529;
	Thu, 20 Aug 2026 10:41:40 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Fri, 21 Aug 2026 01:41:25 +0800
Subject: [PATCH] net: page_pool: Remove zone/policy GFP flags when
 allocating XArray entries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-page-pool-xa-drop-dma32-v1-1-6eab295c3478@rong.moe>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrB1oktKKVxEXk2TSTlETElsE8
 e5N7fJ78P4dCmfhAn2zQ+aPFIlLhWobcE9aHoziqyEYHUjbCyaqW4pxwo3Q55jQz2Q0OhXM1dK
 tU/YO9Z0yB9nO8jD+Xd72xW795eA4vnCqptR7AAAA
X-Change-ID: f32fa2b0-page-pool-xa-drop-dma32-c1f34ba681b7
To: Jesper Dangaard Brouer <hawk@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-1f2f7
X-ZohoMailClient: External

Net drivers request GFP flags according to both the current context and
the device constraints, but the XArray entry itself is by no mean used
by the device. Passing though device constraints to XArray allocation is
a bug and will be warned and fixed up by slab, e.g.:

    Unexpected gfp: 0x4 (GFP_DMA32). Fixing up to gfp: 0x82820 (GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC). Fix your code!
    CPU: 2 UID: 0 PID: 1071629 Comm: kworker/u80:1 Not tainted 7.2.0-rc7+ #1 PREEMPT(lazy)
    Hardware name: LENOVO 21Q4/LNVNB161216, BIOS PXCN27WW 10/20/2025
    Workqueue: mt76 mt792x_pm_wake_work [mt792x_lib]
    Call Trace:
     <TASK>
     dump_stack_lvl+0x6e/0x90
     kmalloc_fix_flags+0x4d/0x6a
     refill_objects+0x10a/0x330
     __pcs_replace_empty_main+0x292/0x5c0
     kmem_cache_alloc_lru_noprof+0x4c2/0x680
     ? __xas_nomem+0x3a/0x120
     __xas_nomem+0x3a/0x120
     __xa_alloc+0xd4/0x190
     page_pool_dma_map+0xef/0x400
     __page_pool_alloc_netmems_slow+0xed/0x480
     ? lock_release+0x280/0x490
     page_pool_alloc_frag_netmem+0xe0/0x3a0
     page_pool_alloc_frag+0xe/0x20
     mt76_dma_rx_fill_buf+0x1f6/0x580 [mt76]
     mt76_dma_rx_reset+0x1cf/0x230 [mt76]
     mt792x_wpdma_reset+0x183/0x1b0 [mt792x_lib]
     mt792x_wpdma_reinit_cond+0x5e/0xa0 [mt792x_lib]
     mt792xe_mcu_drv_pmctrl+0x28/0x60 [mt792x_lib]
     mt792x_mcu_drv_pmctrl+0x3e/0x90 [mt792x_lib]
     mt792x_pm_wake_work+0x2d/0x1d0 [mt792x_lib]
     ? process_one_work+0x20e/0x600
     process_one_work+0x230/0x600
     ? process_one_work+0x256/0x600
     worker_thread+0x1ec/0x3c0
     ? rescuer_thread+0x610/0x610
     kthread+0xf2/0x130
     ? kthread_affine_node+0x140/0x140
     ret_from_fork+0x2a5/0x380
     ? kthread_affine_node+0x140/0x140
     ret_from_fork_asm+0x11/0x20
     </TASK>

Currently mt76 and stmmac may allocate page pool pages with GFP_DMA32.

Fix it by removing zone/policy GFP flags when allocating XArray entries.
This is inspired by commit 96d578088085 ("iommu/dma: Use the gfp
parameter in __iommu_dma_alloc_noncontiguous()").

Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them when destroying the pool")
Signed-off-by: Rong Zhang <i@rong.moe>
---
 net/core/page_pool.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 50ee550fef73..8f8956fb061b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -484,6 +484,13 @@ static int page_pool_register_dma_index(struct page_pool *pool,
 	if (unlikely(!PP_DMA_INDEX_BITS))
 		goto out;
 
+	/*
+	 * Drivers request GFP flags according to both the current context and
+	 * the device constraints, but the XArray entry itself is by no mean
+	 * used by the device, so remove zone/policy flags.
+	 */
+	gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM | __GFP_COMP);
+
 	if (in_softirq())
 		err = xa_alloc(&pool->dma_mapped, &id, netmem_to_page(netmem),
 			       PP_DMA_INDEX_LIMIT, gfp);

---
base-commit: 91ec2035134982b98fab0609a9fd8480e8217dc1
change-id: f32fa2b0-page-pool-xa-drop-dma32-c1f34ba681b7

Thanks,
Rong

