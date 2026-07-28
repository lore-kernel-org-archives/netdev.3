Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B041F7E5
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229918; cv=none; b=VMW5Z5wIJf1a8aaCP8k14+jqj1PJ76KARLl8bu6VLxAJG5SM1X4TT4CLTQUbg1+hKwx0JEl0uoU1g2VgNgJzpCqfVCZ6D2pm1wtP5+O9ALX7kZjklcHxwgOX+oD2hHAefvrYxBNzmy2i6FD7yXrLPV54hESu9mKnpJCONTfb18Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229918; c=relaxed/simple;
	bh=Yb1FjSEuTVq61aetgw67xd+a8F3nUsSqGCu46l0BvHI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mprIIlny9NdE/3yi6Piqbv4VSC0cCDcm+SAhOi7yZxYatAO8yF5kfNR24izpbe8VmyvPKbdpK1AzqNwcddGp2sOiAB2XYpUeGp/XWHrGISlAihbcusW18HpOm86NFFKfyS08jBjMt0eY6G3l3HgLNjQtIrrfBc8rdoZVL/NPtKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=BJywmYPd; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="BJywmYPd"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1737C207B0;
	Tue, 28 Jul 2026 11:11:52 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OBYkOMWMdcrL; Tue, 28 Jul 2026 11:11:51 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5DD3C20539;
	Tue, 28 Jul 2026 11:11:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5DD3C20539
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785229911;
	bh=WiepvO7uuaPMEzEYjDFrKqdaLDmkwMPVE4KD1Hy2r84=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=BJywmYPdu0O2EwQeagEd46CwTZkOVH+RR3KX3ulrWQJmHzJiuJfXoUjYQp78zF18V
	 Mr2mXOqor0+kFuG8HaIocsqxipJ3/79yM6j0QNwO7xpMZmrISg4wMRWU4sgLPGcFp2
	 IITud0NObh3vqHq/IERSg1gDTSgGubAagdLzN8bG+lgZbuhlWugWDdV6K4lMibe75N
	 7dMCNNnD/LxJD4u8IndyLTiR3FZXV0frxwoIB34obhU6+MVbu3KfZogxIvBJXiFtkx
	 OApCrgLweU7NM5tsvFxmGGIRndb677IppSE6ffh9gmsWNGw2HjlIMoYl8n1iz9koUD
	 cdbFsM4ggy8NA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 11:11:50 +0200
Received: (nullmailer pid 719425 invoked by uid 1000);
	Tue, 28 Jul 2026 09:11:50 -0000
Date: Tue, 28 Jul 2026 11:11:50 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Ren Wei <enjou1224z@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <vega@nebusec.ai>, <zhilinz@nebusec.ai>
Subject: Re: [PATCH net 1/1] xfrm: hold input state around secpath resets
Message-ID: <amhyVgen1kaXVQtb@secunet.com>
References: <cover.1785135576.git.zhilinz@nebusec.ai>
 <89be67de93958a00193c8c4bd668733c976e2aa9.1785135576.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <89be67de93958a00193c8c4bd668733c976e2aa9.1785135576.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Jul 28, 2026 at 01:44:10AM +0800, Ren Wei wrote:
> From: Zhiling Zou <zhilinz@nebusec.ai>
> 
> xfrm_input() keeps the current state reference through the skb secpath
> while it performs final transport processing.  Some input paths can reset
> the secpath before xfrm_input() is done dereferencing that state.
> 
> Receive callback users such as VTI and XFRM interfaces can scrub packets
> that cross network namespaces by resetting the secpath.  The
> XFRM_MAX_DEPTH error path can also reset the secpath before the final drop
> callback reads the current state's type.  If that drops the last state
> reference and the state is concurrently deleted, xfrm_input() can still
> dereference the freed state.
> 
> Take a temporary state reference before invoking the receive callback and
> before resetting the secpath on the max-depth error path.  Release it after
> xfrm_input() no longer dereferences the state.
> 
> Fixes: df3893c176e9 ("vti: Update the ipv4 side to use it's own receive hook.")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> ---
>  net/xfrm/xfrm_input.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index eecab337bd0a7..f4deca8b4aab2 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -479,6 +479,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  	int async = 0;
>  	bool xfrm_gro = false;
>  	bool crypto_done = false;
> +	bool x_held = false;
>  	struct xfrm_offload *xo = xfrm_offload(skb);
>  	struct sec_path *sp;
>  
> @@ -585,6 +586,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  		sp = skb_sec_path(skb);
>  
>  		if (sp->len == XFRM_MAX_DEPTH) {
> +			if (x) {
> +				xfrm_state_hold(x);
> +				x_held = true;
> +			}
>  			secpath_reset(skb);
>  			XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
>  			goto drop;
> @@ -727,6 +732,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  		crypto_done = false;
>  	} while (!err);
>  
> +	xfrm_state_hold(x);

This adds an additional refcount on every received packet.
It might make more sense to save afinfo etc. on the stack
instead.

