Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3356C3955FF
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674246; cv=none; b=a+obmUdLN8989m2AggBrfQbmMVEmYxQVpeio83QBIfxxog5qeYbp7k9pqd4VLo8sUwBQvV+6khpWX6qD6L4WAKh7HECryTcnXV7dP+CABZKDYdz83O94+rgXT1KJL9Y5pqKbofXoM9j0N149yIUI3Ud3OGZgmeXNJQii7EQBpeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674246; c=relaxed/simple;
	bh=b2l3YhKudcEcjWr+oVimTrGXaXQoqA9zz3+xcpmkarA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cau3DdtVzJi6EtrCPI8HhElFH4WiHeMeUhU08kyCi0o7LhjSKScFfMTr0ANl7T8570q/swBx4w4+Dd+dQdCUtVPlBVDVidcAeHsCLF/TjCTBObLBS+Wx8jzrLLRv5iN2yfUmaHtMItSiLl2aow/fGdbNetH9fTvFO11owPfuAYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=v2e92KDy; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="v2e92KDy"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D14CB207AC;
	Fri, 10 Jul 2026 11:03:56 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 07X6rXEDR68Q; Fri, 10 Jul 2026 11:03:56 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0552C205E5;
	Fri, 10 Jul 2026 11:03:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0552C205E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783674236;
	bh=HPAWE3t3rukmywq4/6GES7MwseQVXxki0W5I3Eo8mYk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=v2e92KDyFDfvHNWZXRRhqtyQ4KnPIyvwvWfshrdMTQYdtTcHVOxsXxuxOpRGtt16w
	 8PZmOMHebwfsoAwolA/HLEIBkuaRT59zUe8B/CedWLs7POPa3jUY+ymT9r/H/LP7AY
	 Gv4wY5Fb0aSyff/zeyYnX//fUxKguWHAs6Zc0+4XAsDjEzJET2mbmoRuCqcbwT6kex
	 G6aUcAo10MfHiz4gNQVdvRaOqHRqduM404+EW1mh6qE1klBQ2dApO+TC0f8Sl+IPdw
	 e8WkFBUvmQVspQjskyGam6bWQ98Y7X43dGpqkDqIeYjmK1UXlsH83kcS0WT0Motjn2
	 61iCi3dAgMR4g==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 11:03:55 +0200
Received: (nullmailer pid 343857 invoked by uid 1000);
	Fri, 10 Jul 2026 09:03:52 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 08/10] xfrm: iptfs: propagate SKBFL_SHARED_FRAG in iptfs_skb_add_frags()
Date: Fri, 10 Jul 2026 11:03:21 +0200
Message-ID: <20260710090349.343389-9-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710090349.343389-1-steffen.klassert@secunet.com>
References: <20260710090349.343389-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

From: Chen YanJun <moomichen@tencent.com>

When iptfs_skb_add_frags() copies frag references from the source
frag walk into a new SKB, it increments the page reference count via
__skb_frag_ref() but does not propagate SKBFL_SHARED_FRAG to the
destination SKB's skb_shinfo->flags.

If the source SKB carries shared frags (e.g. from a page-pool backed
receive path), the new inner SKB will appear to ESP as having privately
owned frags.  A subsequent esp_input() call for a nested transport-mode
SA then takes the no-COW fast path and decrypts in place, writing over
pages that are still referenced by the outer IPTFS SKB.  This causes
kernel-visible memory corruption and can trigger a panic.

All other frag-transfer helpers in the kernel (skb_try_coalesce,
skb_gro_receive, __pskb_copy_fclone, skb_shift, skb_segment) correctly
propagate SKBFL_SHARED_FRAG; align iptfs_skb_add_frags() with this
convention by setting the flag inside the loop immediately after
__skb_frag_ref() and nr_frags++, so every exit path that attaches a frag
unconditionally propagates SKBFL_SHARED_FRAG.

Fixes: 5f2b6a909574 ("xfrm: iptfs: add skb-fragment sharing code")
Signed-off-by: Chen YanJun <moomichen@tencent.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_iptfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index ad810d1f97c0..597aedeac26e 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -480,6 +480,7 @@ static int iptfs_skb_add_frags(struct sk_buff *skb,
 		}
 		__skb_frag_ref(tofrag);
 		shinfo->nr_frags++;
+		shinfo->flags |= SKBFL_SHARED_FRAG;
 
 		/* see if we are done */
 		fraglen = tofrag->len;
-- 
2.43.0

