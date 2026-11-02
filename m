Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606695;
	b=Bk2Y0x7SFVbj8y1sYTx7E9eeI7cwkWpiyN4soFlIpf3p++gVoOwlNACOHZOUXvahNfD9
	 tFYg5vvgcy17Y35QEhPn9wIfwy/dNv4guyAqxA7RP8cVxZhfApc6Rl/VjHgzcQFEhXIJh
	 6b5K6hXRRbNq9kQtXiOtHeN5n5cYa99pOLHEBB1hdbn8prme1cwcvu0cB0AzMFe6e25xP
	 NsnEvSWYMGYK8NA0yao/j9DZeFy2flW7/ktp1tu7E1kAdRkj7pTowZa0TM+d8144kSgYZ
	 2Z+qRM44mnXgMFtuPU80GkU7E2pqIzes1WxaotoTU6PDFCbd781Rh8NvkzKnNAWWuVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606695;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy;
	bh=eEfGUM6vhzDXHxofy6JNKvz6IXGC+uZMf/dmhqlPCDg=;
	b=DGnFjmQplBUNxPBlS5tpCSaJRvk05dnqr2nUMQj3MOLh3LlPfRZaamzy/VeSsccSzzB6
	 F7aMrg61dLAWXT/XBqpW/FPVNlrgm7xwrpVC0d8CFqEor9l2rM0kCgS4BiG11JMD6qqo+
	 y5IJjOqZwb7noIfFs06uXZjiUV9eVTuJRvKiZ7idHaz9gkj3rFoz4X+DJ+n8YeeLwhrqP
	 A7T7LdTIDd7TVgDotyW829Xfmu28oBRPz3czBlJntpkv+cSunEZbrODZKymB/PpVIIWit
	 vZG3ATIuWhivRcE7Flu7tfa9kugdBp332x/Bq26/b0658UFe2VMwAkWumlEEY3XKJdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=HKpQ7AJw;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E354160A3814
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E354160A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=HKpQ7AJw
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id BE962207A4;
	Mon,  2 Nov 2026 09:04:53 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w78tEtaJEO5j; Mon,  2 Nov 2026 09:04:53 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 25AF0207BB;
	Mon,  2 Nov 2026 09:04:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 25AF0207BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793606693;
	bh=eEfGUM6vhzDXHxofy6JNKvz6IXGC+uZMf/dmhqlPCDg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=HKpQ7AJwPZZW4zzHzwi/eS0Mhh2/ZXnqkg4fIvs11+IuY88ZWbpvZ5AA0O/yPcBE+
	 c9fJigprrw62/PTigCOAdSCRLBYxgnWzO9AXFuTXZkDXZZbXgwXGyuDSu3GHAkU4Ud
	 46qKQhsKkf5eOikcfkj47jGLgkipSW0KosD37Mv7hYW2m7aAAvQZJV9lPAq7IKsZG3
	 5weinYxYTgQYYlUOmu0m0ctsLC5TbJlrg5Lkbs8Di2481TdVXLGJvNV3624byJFLDF
	 9tsBZRH/C0SXcqRVE016uW3bPIk+eKxpkwlafHFQxqvL9gLGL+ifFCta3k18IPqOOM
	 +FyXgZr1K6ukA==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 2 Nov
 2026 09:04:52 +0100
Received: (nullmailer pid 2505891 invoked by uid 1000);
	Mon, 02 Nov 2026 10:04:58 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 01/14] xfrm: retry inexact policy lookup after node reinsertion
Date: Mon, 2 Nov 2026 10:03:59 +0000
Message-ID: <20261102100451.2505200-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102100451.2505200-1-steffen.klassert@secunet.com>
References: <20261102100451.2505200-1-steffen.klassert@secunet.com>
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
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

From: Chengfeng Ye <nicoyip.dev@gmail.com>

An inexact policy lookup first records pointers to candidate hlist heads
and then traverses the lists.  A concurrent policy insertion can merge
inexact tree nodes between those operations:

  lookup                         policy insertion
  ------                         ----------------
  find inexact candidates
    save obsolete hlist head
                                 write_seqcount_begin(&bin->count)
                                 merge inexact tree nodes
                                   hlist_del_rcu(&policy->bydst)
                                   reinsert policy->bydst in survivor
                                 write_seqcount_end(&bin->count)
  evaluate saved candidate list
    miss the moved policy

The merge immediately reinserts the same hlist node into the surviving
tree node.  RCU keeps the policy alive, but it does not provide a
consistent view while its list node is moved.  A lookup that selected the
obsolete list can observe it empty.  A lookup already traversing a moved
policy can instead follow the next pointer rewritten by the reinsertion.
Either case can return an incorrect IPsec policy result.

The per-bin sequence counter already brackets calls to
xfrm_policy_inexact_insert_node(), including node merges.  The read side,
however, currently validates the counter only while searching an
individual rb-tree.  A successful search returns without validation, and
the later candidate-list traversal is outside that read-side section.

Snapshot the per-bin sequence before discovering candidate heads and
validate it after evaluating all candidate lists.   Retry the lookup if
the inexact policy tree changes while it is being searched.

Fixes: 9cf545ebd591 ("xfrm: policy: store inexact policies in a tree ordered by destination address")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 513c9f228334..f6f40ba713d5 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2157,6 +2157,7 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 	struct xfrm_pol_inexact_bin *bin;
 	struct xfrm_policy *pol, *ret;
 	struct hlist_head *chain;
+	unsigned int inexact_sequence;
 	unsigned int sequence;
 	int err;
 
@@ -2191,12 +2192,18 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 		goto skip_inexact;
 
 	bin = xfrm_policy_inexact_lookup_rcu(net, type, family, dir, if_id);
-	if (!bin || !xfrm_policy_find_inexact_candidates(&cand, bin, saddr,
-							 daddr))
+	if (!bin)
+		goto skip_inexact;
+
+	inexact_sequence = read_seqcount_begin(&bin->count);
+	if (!xfrm_policy_find_inexact_candidates(&cand, bin, saddr, daddr))
 		goto skip_inexact;
 
 	pol = xfrm_policy_eval_candidates(&cand, ret, fl, type,
 					  family, if_id);
+	if (read_seqcount_retry(&bin->count, inexact_sequence))
+		goto retry;
+
 	if (pol) {
 		ret = pol;
 		if (IS_ERR(pol))
-- 
2.53.0

