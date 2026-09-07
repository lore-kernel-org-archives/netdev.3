Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A154570EE
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773453; cv=none; b=CEfiSzgWZqH+n4be3duWLAvFu5Tm6J72HvljrS6ENt+/oGG45+IOLcKlQqL6HNJ7mMRj0thZU/GAwrhGYgKuAeDfTJR2/Bv/ozDtXxPMmgbxVgyrNtA5AlwOwvOz64cD0zHrTBuz6jmWxcYxdS/KnntJisbf4MCVhDi77WlmggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773453; c=relaxed/simple;
	bh=qvP8K4UKDa4M9oyjy2UbYcYy9RpgyFpceqn/yLEozbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVMf3I12j8DeiCc2Lr+RRZ9XpFffH5ebJcAaE6LtGVhouHG7byodtw4z7uMo07Ax8S2IjTs+KCVdoBebQ5ybx67LDZP3GWIWYo4IWATCyhya3XVWu9Utt74qkkKZg2KXJvMEcs4RZG/2mVUNzvoHYt6oV8N8ON0KnQEPmZWgWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=bklZBzOR; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="bklZBzOR"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5C528201D5;
	Mon,  7 Sep 2026 11:30:50 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mZajDtse4dZi; Mon,  7 Sep 2026 11:30:49 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 91EA420728;
	Mon,  7 Sep 2026 11:30:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 91EA420728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788773449;
	bh=yf4a79oMszL4kA9jPCJ5dDSZnduFmdrFw7qXHATDEag=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=bklZBzORfdwCwfDIj/EdmBQrdAN4ws7OcZW5fMd3VTvHrychhQnnsUFIeoN8TrKCu
	 Ib7LeYKF4bkOpqXgsvQxOUdY2S1Y6bH3dOnfeiBGlsgmfRM5wyeGlm3NdkXVQu06B/
	 5QjeVJj7tUCXBVHmzkOtnbYJaHPp4mUwso6NNFDNk24s5dE8sb8oj5IOse7YpFJ6kp
	 vOh2UVslzN9POZoFXuXsUZtEpJkU8ulCj1c6XyY647iZvLUsRrpSQfp4isSpKBXgbp
	 9V1lZICVG1egNlgFlUX8H+VS4fqPX/pNFNufg8MuQDEEB9VPHvaGrzPmqx8W/4tlMr
	 OoEaxUNvQEKdQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 7 Sep
 2026 11:30:48 +0200
Received: (nullmailer pid 2228832 invoked by uid 1000);
	Mon, 07 Sep 2026 09:30:24 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 11/12] xfrm: save input state data before secpath resets
Date: Mon, 7 Sep 2026 11:29:54 +0200
Message-ID: <20260907093020.2228346-12-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

From: Zhiling Zou <zhilinz@nebusec.ai>

xfrm_input() stores the current xfrm_state in the skb secpath while it
continues receive-side processing. Some input paths can reset that secpath
before xfrm_input() has finished dereferencing the state.

Receive callback users such as VTI and XFRM interfaces can reset the
secpath. The VTI receive path does so before checking whether the packet
crosses network namespaces, while the XFRM interface path does so only for
cross-network-namespace packets. The XFRM_MAX_DEPTH error path can also
reset the secpath before the final drop callback reports the current
state's protocol.

If secpath_reset() drops the last state reference while the state is
concurrently deleted, xfrm_input() can still dereference the freed state
when selecting transport_finish() or reporting the drop callback protocol.

Save the state protocol on the stack while the state is still valid,
and use the already saved address family for transport_finish(). A larval
XFRM_STATE_ACQ state has no type, so retain nexthdr as its protocol. This
preserves the existing drop-path fallback while avoiding the post-reset
state dereferences without adding an extra state reference to every
received packet.

Fixes: df3893c176e9 ("vti: Update the ipv4 side to use it's own receive hook.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_input.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 8f6109eada7e..5ed87d51392a 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -474,6 +474,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	struct xfrm_state *x = NULL;
 	xfrm_address_t *daddr;
 	u32 mark = skb->mark;
+	u8 xfrm_proto = nexthdr;
 	unsigned int family = AF_UNSPEC;
 	int decaps = 0;
 	int async = 0;
@@ -485,6 +486,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	if (encap_type < 0 || (xo && (xo->flags & XFRM_GRO || encap_type == 0 ||
 				      encap_type == UDP_ENCAP_ESPINUDP))) {
 		x = xfrm_input_state(skb);
+		xfrm_proto = x->type ? x->type->proto : nexthdr;
 
 		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
 			if (x->km.state == XFRM_STATE_ACQ)
@@ -592,11 +594,13 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
 		x = xfrm_input_state_lookup(net, mark, daddr, spi, nexthdr, family);
 		if (x == NULL) {
+			xfrm_proto = nexthdr;
 			secpath_reset(skb);
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOSTATES);
 			xfrm_audit_state_notfound(skb, family, spi, seq);
 			goto drop;
 		}
+		xfrm_proto = x->type ? x->type->proto : nexthdr;
 
 		if (unlikely(x->dir && x->dir != XFRM_SA_DIR_IN)) {
 			secpath_reset(skb);
@@ -604,6 +608,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			xfrm_audit_state_notfound(skb, family, spi, seq);
 			xfrm_state_put(x);
 			x = NULL;
+			xfrm_proto = nexthdr;
 			goto drop;
 		}
 
@@ -728,7 +733,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	} while (!err);
 
 	rcu_read_lock();
-	err = xfrm_rcv_cb(skb, family, x->type->proto, 0);
+	err = xfrm_rcv_cb(skb, family, xfrm_proto, 0);
 	if (err) {
 		rcu_read_unlock();
 		goto drop;
@@ -753,7 +758,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			xfrm_gro = xo->flags & XFRM_GRO;
 
 		err = -EAFNOSUPPORT;
-		afinfo = xfrm_state_afinfo_get_rcu(x->props.family);
+		afinfo = xfrm_state_afinfo_get_rcu(family);
 		if (likely(afinfo))
 			err = afinfo->transport_finish(skb, xfrm_gro || async);
 		if (xfrm_gro) {
@@ -776,7 +781,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 drop:
 	if (async)
 		dev_put(dev);
-	xfrm_rcv_cb(skb, family, x && x->type ? x->type->proto : nexthdr, -1);
+	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
 	kfree_skb(skb);
 	return 0;
 }
-- 
2.43.0

