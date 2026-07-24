Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA5472617
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 01:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784858000; cv=none; b=glXxoRQrYmKePbGCZz6vK1Bqm9qrStQOHZ/NcnGYJqFuXJA1ykCB8jMel2Tf9saR97sg6ooMUdy90k6+sG9yoxQrEwoPHXun1Dnd9jen6d1wagiwglWDAgpssdVj5isGDgF1Ae4ExpcajBiKFexHNX9Z22BZKvo4RCt2n77BeKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784858000; c=relaxed/simple;
	bh=Eove07CpxompN1NQsYajPtjPSFWGLoXuxQn8ejEVdXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hNwQxp+6YKCzCrtBaNqoEWhhzfMy24t5EIZfr1xKDG7Q6ENHrQMHTEdGWrFQp5Cb8qNw2jaT9w/+r9cUB9skiBKmSJTRYSmM6sdh+4fw4a2dj+NJFowHaJIO2EEMXlrqG/xYcSssVE4XoO458yuV/u5pmGaM171cT1rZSXmHcBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XGmwujHp; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XGmwujHp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784857995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nNjK3hvgwMNMUihtBE78N4FCcg/RQUsG7TcoKGDaIyQ=;
	b=XGmwujHp3yE/szSv7OU2TTJpHMjn0V3gVDrX1t3Ll8xKSFvobA5GwWZ89cWMRmmJw8P1hV
	LcxoLzV/sRByejt9/AFLnmJN4TmvulggLKzwDgkKUsvq9if3TeQG/2CoHwnarOfYZ12r/4
	cX5XCdwuXl8DWr9ttVWkLMsUxLpGi2U=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net v3] i40e: xsk: fix multi-buffer XDP_PASS skb construction
Date: Fri, 24 Jul 2026 09:53:28 +0800
Message-Id: <20260724015328.229726-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

When AF_XDP ZC receives a multi-buffer frame and the XDP program
returns XDP_PASS, i40e_construct_skb_zc() copies frags into a new
skb. The copy used skb_frag_page() as the memcpy source (page
metadata instead of packet data) and passed a virtual address to
__skb_fill_page_desc_noacc(), which expects a struct page *.

Use skb_frag_address() for the copy, attach frags with
skb_add_rx_frag() so len/data_len/truesize are updated, and on
dev_alloc_page() failure free the skb via the shared out path so
xsk_buff_free() still runs and previously attached pages are
released by kfree_skb.

Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
---
v3:
 - To ensure backport compatibility for stable branches, this patch solely
   addresses bug fixes. The refactored version that replaces i40e_construct_skb_zc()
   with xdp_build_skb_from_zc() will be submitted to the -next tree. 
v2:
 - https://lore.kernel.org/all/20260717012416.168107-1-chenguang.zhao@linux.dev/
v1:
 - https://lore.kernel.org/all/20260714025112.284724-1-chenguang.zhao@linux.dev/

 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..a4247710c85b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -318,22 +318,19 @@ static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
 		goto out;
 
 	for (int i = 0; i < nr_frags; i++) {
-		struct skb_shared_info *skinfo = skb_shinfo(skb);
 		skb_frag_t *frag = &sinfo->frags[i];
+		unsigned int frag_size = skb_frag_size(frag);
 		struct page *page;
-		void *addr;
 
 		page = dev_alloc_page();
 		if (!page) {
 			dev_kfree_skb(skb);
-			return NULL;
+			skb = NULL;
+			goto out;
 		}
-		addr = page_to_virt(page);
 
-		memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
-
-		__skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
-					   addr, 0, skb_frag_size(frag));
+		memcpy(page_to_virt(page), skb_frag_address(frag), frag_size);
+		skb_add_rx_frag(skb, i, page, 0, frag_size, PAGE_SIZE);
 	}
 
 out:
-- 
2.25.1

