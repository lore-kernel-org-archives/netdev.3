Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD83624B2
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 02:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997480; cv=none; b=ahB3Oa6JxBK9hxTPYYisg9aHp0vEB/AU1lqxMTMOKt3wpQ5hvpC+8CpzNGLhe0b0DbxmIy3DiBVCD+aYbo9sjk0Z1baBx8F1DcL3P6HZwNBUoshB1qPiq4Oer0ihHtemRielGnbx4JXhxIdyn9tzbNJMkMIST69SYuEC27rl3IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997480; c=relaxed/simple;
	bh=IhJKUha7Vru/eebXQzvCgZziJBMxY6hk2b1f6wSTowI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GlkO+hkLkNf7pB5EDZAjDA3qBzjC0UgQLYgzb3Qc+HadhkEVKhgdxViXt9KuZoTX5AtCinnEJ3MIL/11bmodmCpDNkt8paJuIiDZyyjYo3DKh19XZrghxptlu+1Gb8cJaLBCEN2nn8hN9FXsOrwrtMQwEFnfc285oEPGhnqYBaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QQz8sqWv; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QQz8sqWv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783997476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1rEnfawiH1rUI2ixdzp/X50M5aPlt9DKDjE68QCryO8=;
	b=QQz8sqWvGo25reDkdkR+CV3dThlr38KgDGv4EIeVdeRR+NcrRp0uQp2ijyp3lwrOHlmboF
	Er0wHUXKlhdYNutFT/9LwL7+7p1SLF0Vuc2QCOnN/Rgp9qFDIrNlxWIav18w1BUuBwdd2V
	ZRBrygMk6WTxmsXoUqYyWbacuVZEfHI=
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
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH net] i40e: xsk: fix multi-buffer XDP_PASS skb construction
Date: Tue, 14 Jul 2026 10:51:12 +0800
Message-Id: <20260714025112.284724-1-chenguang.zhao@linux.dev>
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
---
 - Fix memcpy source: use skb_frag_address() instead of skb_frag_page(),
   which was copying page metadata rather than packet data.

 - Fix frag attachment: pass the allocated struct page * to the skb frag
   helper instead of the page virtual address.

 - Use skb_add_rx_frag() so skb->len, data_len and truesize are updated
   when attaching copied frags.

 - On mid-loop dev_alloc_page() failure, go through the shared out path
   so previously attached pages are released via kfree_skb and
   xsk_buff_free() is still called.

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

