Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623819;
	b=W+2vMMaAIqt3A3lFjuq0kOYdN4J+YnsdzvYFXY3ACuSijdb6kijJrcQOXxr/S6IGCvPV
	 IKKeZgLbIz8DfUFhGjrqZQ8G6ZG0uCL87OuCSq9LfUinIQkiBgDIsgZ8El1L7aJKtEgIV
	 inlL/qJDkSbE87qXu36D5wl61LRNgyBFdtmrII/aXr1RhE5KDbnu5QOwzvofC0GasfsKK
	 JoQ1/qmytH6oPcALmXIyYiy7j9W4sYwdKY707qbsgzgrAVmXz1RNJHtJqms3dDaUdpapQ
	 eaHT5vuW4KgTgZ+RZ7ZNTZ2oSfP7N1D4hbsh3yHlLIS65IzKEbUTmx8mX+yrj+j9YLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623819;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZZdZbcoRwunYAo+fEkhgl4QhgPHfVIm/mKOxEVIGjHQ=;
	b=LAHpGj8OOisT7TRrCzPx6u5jMCWEjGhch2C8RhTwkcrohgGRYZZbR/nFf2UDamXxHmG5
	 9C5JkOX7n1BPOATjGXfmmVFXAd6dUbqVpvvp1YVPDe2uCLgj6BFRIZ2QJ/SDJrwNantDI
	 D3LO5gnScOpatHb4vUEK/2DE8nFiZgklxZM7Y+MGKvszYaFrKCY1gD602vhoAdttyLlsg
	 AhUV7yQkZp4+ApGyByQizSUKlWU+9umwnTmam5Z5uJgJU2cia3Dhfod3KXQwDJlYahhNI
	 nf/XapFBk/yNMJSkF27hfAFx1CN+w3iOAmM6VKDbRoisr6Rey2XvprjDVeGMVWvAGqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="LJPgwr7/";
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4860A2603
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FF4860A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LJPgwr7/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793623818; x=1825159818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gYfN1PhsRCiCnU2xf9y/9rcfdXCJCW2pHOt8oe8l670=;
  b=LJPgwr7/UzYtM2iWIWZwkNuwJJFxkVkG8HdeTg3rbIf3R97RYEfAHPqj
   arqYcBfWmu39GHJWJvJv8yeUH/ZkQmGh2SqxYJ7jFL0xOvz5Np3+Y379r
   ADTiiJFFIaqEjv2CpKKrtR28+we9D9h5KDi7bp+dQVUDRSscNPlaJpNgf
   C04UpSdgfNq5FnH7m9cmJyfddp3ZCIbpEPB4w+A8D3UIZXTH++cKKdFY8
   eItNQHpU0vgc2XEWzurK1vU6mrQlenMv5KsksCBaDGC73uq0npb+AGRjo
   dBiyrXxgm52fQLr0iNPM4raxKke1IhG1D/yGO5DThKuqdjVsQxp2IPowQ
   g==;
X-CSE-ConnectionGUID: 72p6w4nFSJ2PvTL8egqiCQ==
X-CSE-MsgGUID: rWB4hMYYStehCr8ee88/MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2191878"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2191878"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 04:50:18 -0800
X-CSE-ConnectionGUID: SNN1lIXiSB2JG2PrHvce7A==
X-CSE-MsgGUID: nLs5DVD+SUmSBLgN8cazFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7928515"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa013.fm.intel.com with ESMTP; 02 Nov 2026 04:50:16 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	zuomao338@gmail.com,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Patryk Holda <patryk.holda@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 7/9] i40e: xsk: fix multi-buffer XDP_PASS skb construction
Date: Mon,  2 Nov 2026 13:49:48 +0100
Message-Id: <20261102124950.958345-8-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261102124950.958345-1-maciej.fijalkowski@intel.com>
References: <20261102124950.958345-1-maciej.fijalkowski@intel.com>
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
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Patryk Holda <patryk.holda@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 57b0f520fbb2..5f5f33b2a097 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -320,22 +320,19 @@ static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
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
2.43.0

