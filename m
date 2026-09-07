Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E65450406
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773458; cv=none; b=QfuF3KUOVILdQuYqXY9cCQkT6Vfze/Kjr0G14EDP1As0r9fSje0xJZfdPFnXch2Y803bbAbJzVoa3aaCrtg1vMPY5E5xLUqIl1IkGi51IA0ut0ijhnuyzj1ba0yojB19NLKVcJqxaIWfDHXsldSrgpHvwb7VKoIg3UxNFCNJ/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773458; c=relaxed/simple;
	bh=X+QYettS2Tv4/IiOLlQOCBffsaIwpbXmEzN9retcGu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jarm8ZFYzn4x1gUozCwK8qFBi8gz3/6umtaJOaMNAD3eGSlMGuE+agWl582j4YuEMsv8U9Wv2a2l7IK1gXA3TxRIAtFvtptDeReq5hQ5Cr2+MmHseep9iDgwaobZluszsWCNDEmTJOKiCt4dE4cmP/YKc5glCIII74BlytUyONg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=p8HqR02Z; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="p8HqR02Z"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5CE9120743;
	Mon,  7 Sep 2026 11:30:55 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id woS4Go1of6aW; Mon,  7 Sep 2026 11:30:54 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B348E201D5;
	Mon,  7 Sep 2026 11:30:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B348E201D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788773454;
	bh=BHWbHbfkX40QZY+Jc2Jka1pSXAA66JJcMia4AP2XxOQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=p8HqR02ZP29FwKoLD583uLPVMSCw20fwvmSxqs7/9SYQPZ+PLo5R5SsB6o5hlRjxr
	 tX95l/guabfYcXtfoq0FTd3R2nmBNQHxBKs5DzlCURyQtcRT+xFCp+INTymMqR9BLG
	 K+uUhTMLtIjei0LCnQC3oKPHzm9bWZC/xI2uODElBR5Zi5TOs5obAsRRxJB/LRlXl/
	 rPKIWaMI7VRj2Q20Xv1r+nrd1Aa/q5ZWu5cREz4acADkmlRO136wJ0HrENjGurCeoB
	 aqvIP+yxUUXpl6EmMmMIBtk0/j63D7e5nzqSM+RLRDTZpRSphP5bG5hhYbkCAxfpVo
	 O5YK5oiaeMs0w==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 7 Sep
 2026 11:30:54 +0200
Received: (nullmailer pid 2228826 invoked by uid 1000);
	Mon, 07 Sep 2026 09:30:24 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 09/12] esp: downgrade zerocopy managed frags before mutating skb frags
Date: Mon, 7 Sep 2026 11:29:52 +0200
Message-ID: <20260907093020.2228346-10-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907093020.2228346-1-steffen.klassert@secunet.com>
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

From: Maher Azzouzi <maherazz04@gmail.com>

On the out-of-place output path (esp->inplace == false) ESP rewrites the
skb frag array: esp_output_head() appends a trailer frag and
esp_output_tail() replaces the frags with a destination page, both
referenced with get_page().

When the skb carries zerocopy managed frags (SKBFL_MANAGED_FRAG_REFS) the
payload frags are owned by the ubuf and must not be referenced or
unreferenced individually, but ESP mutates the frag array without ever
downgrading the skb.  This breaks the managed-frag invariant two ways:

  - esp_ssg_unref() walks the source scatterlist and drops a page
    reference for every frag, including the ubuf-owned payload frags,
    pushing their refcount below the GUP pin bias while the pages are
    still pinned, i.e. a use-after-free of the zerocopy pages;

  - esp_output_tail() installs its destination page as frag 0 with
    get_page() but leaves SKBFL_MANAGED_FRAG_REFS set, so
    skb_release_data() takes the skip_unref branch and never drops that
    reference, leaking the x->xfrag page at packet rate.

Fix this the way every other frag-mutating site does (__ip_append_data(),
__ip6_append_data(), tcp_sendmsg_locked()) and call
skb_zcopy_downgrade_managed() before ESP touches the frag array: it takes
a real reference on each existing frag and clears SKBFL_MANAGED_FRAG_REFS,
so the per-frag unref in esp_ssg_unref() and the frag release in
skb_release_data() are both balanced and no mixed-ownership frag array is
left behind.

Fixes: 753f1ca4e1e5 ("net: introduce managed frags infrastructure")
Signed-off-by: Maher Azzouzi <maherazz04@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv4/esp4.c | 6 ++++++
 net/ipv6/esp6.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index dfc81ee969ae..faa48f5b9739 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -441,6 +441,12 @@ int esp_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 
 			esp->inplace = false;
 
+			/* Take real page refs and clear SKBFL_MANAGED_FRAG_REFS before
+			 * we mutate the frag array, so the per-frag unref stays balanced
+			 * for zerocopy managed frags (see __ip_append_data()).
+			 */
+			skb_zcopy_downgrade_managed(skb);
+
 			allocsize = ALIGN(tailen, L1_CACHE_BYTES);
 
 			spin_lock_bh(&x->lock);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 296b57926abb..a3a3857eed98 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -470,6 +470,12 @@ int esp6_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 
 			esp->inplace = false;
 
+			/* Take real page refs and clear SKBFL_MANAGED_FRAG_REFS before
+			 * we mutate the frag array, so the per-frag unref stays balanced
+			 * for zerocopy managed frags (see __ip_append_data()).
+			 */
+			skb_zcopy_downgrade_managed(skb);
+
 			allocsize = ALIGN(tailen, L1_CACHE_BYTES);
 
 			spin_lock_bh(&x->lock);
-- 
2.43.0

