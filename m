Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019223AE193
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954212; cv=none; b=Nf1JtW0m4E4YdTCHT134yx9AVFppNxr6rNwvDYfXjEk2K97vi9JrrLtnR6t4AlOK3HluYkdWSCY8yg276nbG6kUgw8PEk/DEQ/TKMoQb3ifllauVnxwXOzxxFp549ExjqoSL64AScVbJ+F9iueN4xdg/kV2RYpA+Pv6ijXjnAVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954212; c=relaxed/simple;
	bh=P9otRAYnG7XCLSbyj6KxHTdLPS7vEOu2xMzqKkt0Qjg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGA0eHqtI6pZNeCgJyKPQP92mqhzgRhJqs3uSHglSVuSo2b3uiNjt6OMsAbK4LUyA6navlEZnoJCsreNLTUgfrTsBkNqv73/1eBMpEcuobfdm0sQsbPE1gkaTIqHccxQFwS0dZDZ64AEqd9euiK2xCVLEeJoQS4Xo0ZVBZtiKaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=WvaGAsho; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="WvaGAsho"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 69CA7207B2;
	Mon, 17 Aug 2026 10:10:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t7MFCwpT630T; Mon, 17 Aug 2026 10:10:05 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 760D82082B;
	Mon, 17 Aug 2026 10:10:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 760D82082B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1786954205;
	bh=bzI199lj3GMaUYJwX/Bzbd+vq7lQgsDttuVruXqqYZw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=WvaGAshoxouhSbXeR5X/4mEldQG0oDFECBwULhQDsI9UkenrX07srkQ13wrv5/cGd
	 D9r3X9JTy32id1IF0rQ8ZeIz2+CeDkV86XY0Gl7+V9ef9sCGw96cp+oyrSRFHytDlX
	 0/R7Qoiy6Unb3g3ojb0cXekbUkbmrLoiCEEi+EbF0SgBtACOxRNAKp13MKAb3Pr1ub
	 lWWeUGmkrPucIgS8Tv8kpfyu6JWSUgEU+Xfdu0a2rELB34iqzEQSt8bQPVe62WYs4Y
	 bmVagFZuYV5z8yUIB+zB1C2hZQjjXq/ROWk8fQtb99/2AlCnopLVRiUsHQ/7IS7RsY
	 mJdDoI4ZVhC0g==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 17 Aug
 2026 10:10:04 +0200
Received: (nullmailer pid 2431245 invoked by uid 1000);
	Mon, 17 Aug 2026 08:10:03 -0000
Date: Mon, 17 Aug 2026 10:10:03 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <vega@nebusec.ai>
Subject: Re: [PATCH net v2 1/1] xfrm: save input state data before secpath
 resets
Message-ID: <aoLB21ws0-VUR5hc@secunet.com>
References: <e59b617d27acb3a38a3523649d52b90f022fa28d.1785288865.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e59b617d27acb3a38a3523649d52b90f022fa28d.1785288865.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [1]: [PATCH net v2 1/1] xfrm: save input state data before secpath resets ---
commit 00c0af70a4245da8443da16c81f86becd446039e
Author: Zhiling Zou <zhilinz@nebusec.ai>

xfrm: save input state data before secpath resets

This snapshots the current state's protocol into a local variable early in
xfrm_input() so the later xfrm_rcv_cb() calls no longer dereference x after
a secpath reset, and switches transport_finish() to use the already saved
family instead of x->props.family.

Link: https://lore.kernel.org/all/89be67de93958a00193c8c4bd668733c976e2aa9.1785135576.git.zhilinz@nebusec.ai/

> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index eecab337bd0a..3177fa33961c 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -474,6 +474,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  	struct xfrm_state *x = NULL;
>  	xfrm_address_t *daddr;
>  	u32 mark = skb->mark;
> +	u8 xfrm_proto = nexthdr;
>  	unsigned int family = AF_UNSPEC;
>  	int decaps = 0;
>  	int async = 0;
> @@ -485,6 +486,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  	if (encap_type < 0 || (xo && (xo->flags & XFRM_GRO || encap_type == 0 ||
>  				      encap_type == UDP_ENCAP_ESPINUDP))) {
>  		x = xfrm_input_state(skb);
> +		xfrm_proto = x->type->proto;
>
>  		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
>  			if (x->km.state == XFRM_STATE_ACQ)

Can x->type be NULL at this point?  The snapshot is taken before the
km.state check that immediately follows, and that check exists precisely to
handle XFRM_STATE_ACQ states.

x->type is only ever assigned in __xfrm_init_state():

net/xfrm/xfrm_state.c:__xfrm_init_state() {
	...
	x->type = xfrm_get_type(x->id.proto, family);
	if (x->type == NULL) {
	...
}

A larval ACQUIRE state never reaches that function, and xfrm_state_alloc()
uses kmem_cache_zalloc(), so x->type stays NULL.  xfrm_state_gc_destroy()
also guards with "if (x->type)", which suggests a NULL type is a legitimate
state for hash-reachable SAs.

On the GRO path, esp4_gro_receive() installs the looked-up state into the
secpath with only an x->dir sanity check and then calls xfrm_input() with
encap_type == 0, so no km.state or type validation happens before the new
dereference.

> @@ -592,11 +594,13 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>
>  		x = xfrm_input_state_lookup(net, mark, daddr, spi, nexthdr, family);
>  		if (x == NULL) {
> +			xfrm_proto = nexthdr;
>  			secpath_reset(skb);
>  			XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOSTATES);
>  			xfrm_audit_state_notfound(skb, family, spi, seq);
>  			goto drop;
>  		}
> +		xfrm_proto = x->type->proto;
>
>  		if (unlikely(x->dir && x->dir != XFRM_SA_DIR_IN)) {
>  			secpath_reset(skb);

Same question for this snapshot: it runs right after a successful lookup,
before the x->dir check, before spin_lock(&x->lock), and long before the
km.state != XFRM_STATE_VALID / XFRM_STATE_ACQ handling at the process:
label.

Does the lookup filter out larval states?  __xfrm_state_lookup() only
compares family, spi, proto, daddr and mark:

net/xfrm/xfrm_state.c:__xfrm_state_lookup() {
	hlist_for_each_entry_rcu(x, state_ptrs->byspi + h, byspi) {
		if (x->props.family != family ||
		    x->id.spi       != spi ||
		    x->id.proto     != proto ||
		    !xfrm_addr_equal(&x->id.daddr, daddr, family))
			continue;
	...
}

and xfrm_input_state_lookup() explicitly documents returning a state that
is "about to be destroyed".

An ACQ state becomes reachable through that hash during the normal IKE
flow, XFRM_MSG_ALLOCSPI -> xfrm_alloc_userspi() -> xfrm_find_acq(create=1)
-> xfrm_alloc_spi():

net/xfrm/xfrm_state.c:xfrm_alloc_spi() {
	...
	x->id.spi = newspi;
	h = xfrm_spi_hash(net, &x->id.daddr, newspi, x->id.proto, x->props.family);
	XFRM_STATE_INSERT(byspi, &x->byspi,
			  xfrm_state_deref_prot(net->xfrm.state_byspi, net) + h,
			  x->xso.type);
	...
}

So an inbound ESP/AH/IPCOMP packet whose SPI matches the just-allocated
larval SA, for example a peer data packet or retransmission arriving between
XFRM_MSG_ALLOCSPI and XFRM_MSG_UPDSA, would reach this dereference in
softirq context instead of taking the existing LINUX_MIB_XFRMACQUIREERROR
drop path.

Would deferring the snapshot until after the km.state validation, or writing
it as "x->type ? x->type->proto : nexthdr", keep the stated goal without
this change in behaviour?

[ ... ]

> @@ -776,7 +781,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  drop:
>  	if (async)
>  		dev_put(dev);
> -	xfrm_rcv_cb(skb, family, x && x->type ? x->type->proto : nexthdr, -1);
> +	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
>  	kfree_skb(skb);
>  	return 0;
>  }

This drops the "x && x->type" test that used to be here.  The commit message
describes saving the protocol on the stack and using the saved family, but
does not mention removing this guard.  Was the removal intentional, and if
x->type can never be NULL, could that be stated in the changelog so the
earlier snapshots are justified too?
