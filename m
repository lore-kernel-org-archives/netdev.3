Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDC73E717A;
	Fri, 24 Jul 2026 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884956; cv=none; b=hDcpvXcInEHbxR6wwd1b41PbV5637iCfcATn7ZeTe2rUF7akQIoccqBMeuLvpzwonyyh8n7wBdOsnbFvjPHN8yzM9jlcJ7iOLyPsem/BDjSUadnMlGbLPVnywM6XwjXfATkdxyvEKj/W7cW8gFgqMH+d8w0koqrKNYCAiBBYpgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884956; c=relaxed/simple;
	bh=E0jwxBHJYAbxCYS+Ax6F7jZ+bYcdSkfhurPycyPuLnU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LRlMrDRKW0cJvLoJPGJiSBaiX5Ev5B6inPjO87Gh4DgHSQI63z2v//x+cWUIpmdVbNwal5dLlS42sphoLZUKXaLQt9zUY8ZaRewLijUECkaWbYampemTYaiKUFLsvRMla22VqtxAAVThVj4jNmnaqy6IYumMEsuHFlWCcPKp9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=aHlQP0C3; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="aHlQP0C3"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7+Dqu5YcOu+zYJdF4FV3fs2X2wVuYG2pj296bIH+Ud4=;
	b=aHlQP0C3UdgmGg1gbApknMtGzRntvQ765yvNNBcztg4lrxaq2NoKzDN7KT3cItVQouoZlE9V0
	jamchpB43+Skl4lGFp1FxwQiHA2NJNTN8osir/r+i6ejR1oyjC+2pdUGR6E+SGEp+bke8QQC0u3
	02/wWgvypiLy42VUphtRpJw=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h62MQ1jcDzKm5m;
	Fri, 24 Jul 2026 17:12:50 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 9511040578;
	Fri, 24 Jul 2026 17:22:16 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 24 Jul 2026 17:22:15 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <almasrymina@google.com>,
	<toke@redhat.com>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net] net: page_pool: fix DMA index not cleared on xa_cmpxchg race
Date: Fri, 24 Jul 2026 17:21:35 +0800
Message-ID: <20260724092135.414699-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500018.china.huawei.com (7.202.195.199)

page_pool_release_dma_index() uses xa_cmpxchg() to atomically remove a
page from pool->dma_mapped.  When the cmpxchg loses the race (the entry
was already removed by a concurrent release path, e.g. page_pool_scrub()
during page_pool_destroy()), the function returns -1 *without* clearing
the DMA index bits stored in pp_magic.  Its caller then skips dma_unmap
based on that -1, which is correct, but the stale DMA index bits left
in pp_magic are wrong: the xarray entry they index no longer exists.
A page recycled back into the pool then carries a dangling DMA index,
and kernels that validate pp_magic in the return path surface this as
a WARN.

Move netmem_set_dma_index(netmem, 0) to execute unconditionally before
return, so both the winner and the loser of the xa_cmpxchg race clear
the DMA index bits.  The return value still distinguishes the two
cases (-1 loser / 0 winner), preserving the contract that exactly one
side performs dma_unmap.

The race window opens when page_pool_destroy() runs concurrently with
late page returns from SKBs held in per-CPU defer lists, TCP receive
queues or GRO hashes -- e.g. a driver reconfiguring channels/ring
depth while traffic is flowing.

Observed on arm64 (7.2.0-rc1) with the hns3 driver:

  WARNING: net/core/netmem_priv.h:18 at page_pool_clear_pp_info+0x20/0x38,
           CPU#83: iperf/3874878

Return path (CPU_B, process context, triggering the WARN).  The page
was held in a per-CPU SKB defer list and is being released through
tcp_recvmsg():

  page_pool_clear_pp_info+0x20/0x38
  page_pool_put_unrefed_netmem+0x11c/0x2e8
  napi_pp_put_page+0xf0/0x120
  skb_release_data+0x170/0x228
  skb_attempt_defer_free+0x7c/0x1f0
  tcp_recvmsg_locked+0x710/0x9a0
  tcp_recvmsg+0x74/0x1c8
  inet_recvmsg+0x2c/0xf0
  __sys_recvfrom+0xdc/0x198
  __arm64_sys_recvfrom+0x2c/0x48
  invoke_syscall+0x5c/0x120
  el0_svc_common.constprop.0+0xc8/0xf0
  do_el0_svc+0x24/0x38
  el0_svc+0x34/0x1e0
  el0t_64_sync_handler+0xa0/0xe8
  el0t_64_sync+0x1ac/0x1b0

Scrub path (CPU_A, racing with the return path, derived from code):

  page_pool_destroy
  -> page_pool_scrub
     -> xa_for_each(dma_mapped)
        -> __page_pool_release_netmem_dma
           -> page_pool_release_dma_index   <- race window

Debug approach and evidence:
Reproduced with a stability test that repeatedly reconfigures the hns3
channel count and ring depth (ethtool -L/-G) while running iperf3 with
multiple parallel streams, then closes the iperf3 sockets to release
the SKBs held in TCP receive queues and per-CPU defer lists.

On the unmodified kernel the WARN reproduces after hours to tens of
hours. To make the race window observable, a debugfs knob injects a
controlled udelay() right after the winning xa_cmpxchg() in
page_pool_release_dma_index(), widening the gap between the xarray
entry removal and the pp_magic cleanup.  With the delay injected the
WARN reproduces 4-5 times within about half an hour.

Instrumentation added to page_pool_release_dma_index() logs the per-
page pp_magic, DMA index, refcount and dma_addr at release time.  A
representative log line from a WARN-triggering page:

  PP_DMA_IDX: magic=0xdead0000000cbec0 idx=6525 refcnt=1 dma_addr=0x0

  magic=0xdead0000000cbec0  -> PP_SIGNATURE | (6525 << shift)
  idx=6525                  -> DMA index bits still set in pp_magic
  dma_addr=0x0              -> scrub already did dma_unmap + cleared addr
  refcnt=1                  -> inflight page, unrefed release path

The combination "dma_addr == 0 but DMA index != 0" is the signature of
the race: CPU_A (scrub) won the xa_cmpxchg, performed dma_unmap and
cleared dma_addr; CPU_B (return) lost the cmpxchg, returned -1 and
skipped netmem_set_dma_index(0), leaving the DMA index bits stale --
exactly the gap this fix closes.

With this fix applied the WARN no longer triggers under the same
workload (verified overnight), both with and without the debugfs
delay knob enabled.

Fixes: 95920c2ed02b ("page_pool: Fix PP_MAGIC_MASK to avoid crashing on some 32-bit arches")
Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them when destroying the pool")
Assisted-by: OhMyOpenCode:GLM-5.2
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 net/core/page_pool.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 21dc4a9c8714..6f86c96650d3 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -505,6 +505,7 @@ static int page_pool_release_dma_index(struct page_pool *pool,
 {
 	struct page *old, *page = netmem_to_page(netmem);
 	unsigned long id;
+	int ret = 0;
 
 	if (unlikely(!PP_DMA_INDEX_BITS))
 		return 0;
@@ -517,12 +518,18 @@ static int page_pool_release_dma_index(struct page_pool *pool,
 		old = xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
 	else
 		old = xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0);
-	if (old != page)
-		return -1;
+	if (old != page) {
+		/* xarray entry already removed by concurrent release path
+		 * (e.g. page_pool_scrub). Still clear DMA index bits to
+		 * keep pp_magic consistent. The winner of the xa_cmpxchg
+		 * race is responsible for dma_unmap.
+		 */
+		ret = -1;
+	}
 
 	netmem_set_dma_index(netmem, 0);
 
-	return 0;
+	return ret;
 }
 
 static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t gfp)

base-commit: 78f75d632f74b8de0f081a128588f7c37d0d1164
-- 
2.33.0

