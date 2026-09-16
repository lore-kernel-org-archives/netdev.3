Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318B48EBEF
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549379; cv=none; b=AaGN7QOsGRRMc/hI42qq1sxWK2ptt0tD2w/31/aeD5SsDHqx5LprD0+r1E6hYUsQ2gcvT84A6Oj3AVgnMdtjlgLFZesCqwrPJYvRlwd9SWFRzZKoBv7JhXaytl0gXDfYaTKWRmERZgJn9VIY99maKc+WuW16O4HhfNIy2N6kJ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549379; c=relaxed/simple;
	bh=oDdSwtrjQ8X7B2K6x4JHtkCI7kSJPnDbA6DGUG+W1sA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVmkv7qdmfJxFkaKxieKYti17sUtsYw3WBhAY95LDscBA38Yg6VK/udQDdhT/1J/atun1jgwOOdrL41JW7dF0m2pcPvR2BwtWNNGuvp1XXhDR28b4mZxk47PZw4ylHOC5tnKZMh8s5+T+YHJj8MTtLcGng+si2PymTzXw5WdHOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=xHbmW0bE; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="xHbmW0bE"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 60F7B20538;
	Wed, 16 Sep 2026 11:02:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GfVOy7lCKhaD; Wed, 16 Sep 2026 11:02:33 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B4D76201CC;
	Wed, 16 Sep 2026 11:02:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B4D76201CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1789549353;
	bh=yy9D/E9FeTmj7YViB3WIUnvD4lK2YNHANr/NhoeFwpc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=xHbmW0bE+RkyHrqgw5Xjp+qEwP0lsJAFKoJB2PHeAKi77JYsLV9clGlYyzEygqNLH
	 Z5myOX25uvxQoXH/nvmSHVM124QCqpUKTJeWvVE6LQcXwcfe6wru43Snuort0LQ2dP
	 i7xOI/K7o1nOvlKBW99NC4w8GwVrFGQKD7mywoNBVRUxMeiTc+ZoifH9z34NfS2NIM
	 zIpbGcikz8vf6W7UaGbTsi9dl9+pWzeMs6kzbQJc7/AP3VN9hXGB/RFK2a7CYPsOIn
	 0AnnHEkmztYInVGRpqqmiS1yzi/2d8w9r0PEbcEks6GHpsGgiMm/C1c6ejE854w2zs
	 wy7TmS5+eZWsw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 16 Sep
 2026 11:02:32 +0200
Received: (nullmailer pid 51204 invoked by uid 1000);
	Wed, 16 Sep 2026 09:02:32 -0000
Date: Wed, 16 Sep 2026 11:02:32 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Roshan Kumar <roshaen09@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, Christian Hopps
	<chopps@labn.net>
Subject: Re: [PATCH 01/12] xfrm: iptfs: fix stack OOB read in
 iptfs_skb_reset_frag_walk()
Message-ID: <aqpbKKiNcQFemUk0@secunet.com>
References: <20260907093020.2228346-2-steffen.klassert@secunet.com>
 <20260908224803.1587019-1-kuba@kernel.org>
 <aqfOg-hbkOP3kwW5@secunet.com>
 <178946111414.531190.8806329997967238720@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178946111414.531190.8806329997967238720@mail.gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Sep 15, 2026 at 08:31:54AM -0000, Roshan Kumar wrote:
> Hi Steffen,
> 
> I had a look at the review and it is right that the guard changes the
> len == 0 outcome, with one nuance worth splitting out.
> 
> The sharing branch needs a prepared frag walk, so the guard can only
> change behavior for skbs that are frag walk eligible (head_frag set, or
> all data in frags). For those, before the change
> iptfs_skb_can_add_frags() fell through the "while (len && fragi <
> walk->nr_frags)" loop and returned true, iptfs_skb_add_frags()
> returned immediately on its own " !walk->nr_frags || offset out of
> range" check, and reassembly continued with ra_wantseq++. With the
> guard the same input returns false, takes the copy branch, and
> skb_copy_seq_read(..., 0) returns EINVAL, so the in progress
> reassembly is dropped.
> 
> For linear skbs the frag walk stays NULL and this corner dropped
> reassembly before the change too: the copy branch runs either way and
> skb_seq_read at the end of the buffer fails the same way. I reproduced
> that part live on v7.3-rc3 today: a partial inner packet followed by
> an AGGFRAG basic header only block with block_offset 0xffff kills the
> in progress reassembly with and without the fix, so that part already
> existed rather than being something the guard introduces.
> 
> The review's suggestion closes the gap for the frag walk case: return
> true when len == 0, before the offset check. The dangerous walk in
> iptfs_skb_reset_frag_walk() is skipped entirely for len == 0, and
> iptfs_skb_add_frags() keeps its own bounds check for len > 0, so the
> out of bounds read cannot come back this way. The reassembly outcome
> stays identical to before the fix for head frag skbs, so there is no
> efficiency cost either.
> 
> Something like this on top of the patch:
> 
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ static bool iptfs_skb_can_add_frags(const struct sk_buff *skb,
>         if (skb_has_frag_list(skb) || skb->pp_recycle != walk->pp_recycle)
>                 return false;
> 
> +       /* len == 0: nothing to add, proceed as before the fix. */
> +       if (!len)
> +               return true;

That's ok with me. But drop the comment above, this does not
give any usefull information.

> +
>         /* Reject an @offset that is at or beyond the end of the walk's data
>          * before calling iptfs_skb_reset_frag_walk(), whose fragment-advance
>          * loop is otherwise unbounded and would index past walk->frags[].
>          * This mirrors the guard already present in iptfs_skb_add_frags().
>          */
>         if (!walk->nr_frags || offset >= walk->total + walk->initial_offset)
>                 return false;
> 
> The len == 0 drop for linear skbs existed before this change; I am
> happy to look at that separately once this series lands.

Thanks!

