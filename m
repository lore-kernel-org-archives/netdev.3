Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304D1359A6C;
	Mon, 24 Aug 2026 04:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547553; cv=none; b=WzC7K8Lob5L3kX6B2omFjjw9Ljk46fcmFbokUh8551Dq6G9CoExOiZx8MSNzF7ccAvyMU9eo5IH/JCaqSMzFNteR6Mjluh/sNiQ6idzBOkUIiQlXX+QGmb1cvfzNoGyyg+nLoedqNw/5XblVn2Qo+mgc6+jq6jQf7G0zKjKXkDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547553; c=relaxed/simple;
	bh=mXGG9q+THO9KOxOqNudrKA+jmd49OYRCkGi4ONweQq0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeBiWB6ea7+G7ex6Vfc5FdptgfqF5XyHNfvMtk61fyVK0UeGv2B3QZI+Y1SeH5BCpCYE3iROZdOkzI8Bj42beFemWJ2LZoADgRIpNat/FC9ehJ5PPnOjoghFQ7g7/uGcyriBn6jJeZ8K9pSFJ+S4ODt+oyMMFl3J+Sw0VPrGBgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=YPMeM1P7; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="YPMeM1P7"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 106F02053D;
	Mon, 24 Aug 2026 06:59:02 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 54JMrjtSxjv4; Mon, 24 Aug 2026 06:59:01 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B00D5207B3;
	Mon, 24 Aug 2026 06:59:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B00D5207B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787547540;
	bh=JTm1w23mxDXrqpcOFSDrL71we0REw6mbw6Pxu60MEks=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=YPMeM1P7Wj+kqazKmYgDybWTqIgtGFgOPPuERI4cl0nLXjl46w/D4aEgjso/BipmA
	 YCwXrTSemvd12mUz116GbvXZD60a3T4FLw3tUOg2jlnB1yWPJX7UBpDpQGWt82PZa1
	 hWDheITZrBZnRXHRoqSrvIId6CA2+2X0yxtk27eAH0tJYBH0QcAkVHo85dKKTHf+cs
	 YCtYQNHwgTiJl6ZT/1oaUv/l+awDiHqBQAC94uLSgexEk2hGZeTMaxRKou9lRKX6D4
	 9eEitFDXdfr+y1kHIWTS7bzkA37mSr7EOtMw9n9/bAr3DY1wkDoHkBvjjAYf4qpfrh
	 wOVm22iBJMZVw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 24 Aug
 2026 06:58:59 +0200
Received: (nullmailer pid 651190 invoked by uid 1000);
	Mon, 24 Aug 2026 04:58:58 -0000
Date: Mon, 24 Aug 2026 06:58:58 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Roshan Kumar <roshaen09@gmail.com>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	Christian Hopps <chopps@labn.net>, Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfrm: iptfs: fix stack OOB read in
 iptfs_skb_reset_frag_walk()
Message-ID: <aovPkmpvxHEwUIR9@secunet.com>
References: <20260728052608.2898018-1-roshaen09@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260728052608.2898018-1-roshaen09@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Jul 28, 2026 at 10:56:08AM +0530, Roshan Kumar wrote:
> iptfs_skb_reset_frag_walk() advances to the fragment containing @offset
> with an unbounded loop:
> 
> 	while (offset >= walk->past + walk->frags[walk->fragi].len)
> 		walk->past += walk->frags[walk->fragi++].len;
> 
> walk->fragi is advanced and walk->frags[walk->fragi] is dereferenced
> without ever checking fragi against walk->nr_frags. When the requested
> offset is at or beyond the total length spanned by the walk's fragments,
> fragi runs past nr_frags and off the end of the fixed-size on-stack
> frags[MAX_SKB_FRAGS + 1] array, reading out-of-bounds stack memory.
> 
> The two callers behave differently: iptfs_skb_add_frags() already guards
> against this with
> 
> 	if (!walk->nr_frags ||
> 	    offset >= walk->total + walk->initial_offset)
> 		return len;
> 
> but iptfs_skb_can_add_frags() has no such guard and calls
> iptfs_skb_reset_frag_walk() unconditionally, so it performs the
> out-of-range walk. Its own "fragi < walk->nr_frags" bound check runs only
> afterwards, too late to prevent the read.
> 
> This is reachable from the receive path: a crafted IP-TFS (AGGFRAG)
> payload delivered to an IPTFS SA drives iptfs_reassem_cont() ->
> iptfs_skb_can_add_frags() with an offset past the fragment total, e.g.:
> 
>   BUG: KASAN: stack-out-of-bounds in iptfs_skb_reset_frag_walk+0x235/0x250
>   Read of size 4 at addr ffff888008ad7210 by task repro/345
>    iptfs_skb_reset_frag_walk+0x235/0x250 net/xfrm/xfrm_iptfs.c:392
>    iptfs_skb_can_add_frags+0x155/0x310  net/xfrm/xfrm_iptfs.c:420
>    iptfs_reassem_cont+0xcf8/0x1140      net/xfrm/xfrm_iptfs.c:902
>    iptfs_input_ordered+0x552/0x670      net/xfrm/xfrm_iptfs.c:1280
>    iptfs_input+0x3d6/0xde0              net/xfrm/xfrm_iptfs.c:1741
>    xfrm_input+0x282f/0x6140             net/xfrm/xfrm_input.c:700
>    xfrm4_esp_rcv+0x93/0x120             net/ipv4/xfrm4_protocol.c:104
>    ip_rcv+0x278/0x2d0                   net/ipv4/ip_input.c:612
> 
> Give iptfs_skb_can_add_frags() the same up-front guard that
> iptfs_skb_add_frags() already has, so the walk is never entered with an
> out-of-range offset. When it triggers, the caller falls back to the
> existing linearize-and-copy path, which is safe.
> 
> Fixes: 5f2b6a909574 ("xfrm: iptfs: add skb-fragment sharing code")
> Reported-by: Roshan Kumar <roshaen09@gmail.com>
> Signed-off-by: Roshan Kumar <roshaen09@gmail.com>

Applied, thanks a lot!
