Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD252F3C26
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771541731; cv=none; b=ktFTFQHOlsqFKBWS+VX3tOFCPBDmbxufHbXaw7nYCeg4q2dKPvZ3Xwiee0l7WT07uEJ4CQofED2UGz+r2f/OE8l+3Kc/US91LQIMAFJ6Qh1O7QkNd71KnQsOQ0ehrdDTK+Z2nwBd4oDjzSkTstAWhp1KOMgMIn5xdrD5vK2JeuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771541731; c=relaxed/simple;
	bh=46FGtlC+F69jRzZYxcG+FruvpR/OUJin/9cTjRauVI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmwF77l7ibxXxb2tHkFjTRuzNmugkiapYsbJzBTfUwKf0tDYA5DUhj0hB9Ha/sFSXTVZHIFmtTofwL/UF48ovb2tjOQsMRb+15kInuWCnwQ25X/fGo6bezO4gMW1LeO37ftsnK0UtwFeBTIM6xnrLOTjQKS57MmgxK+MMj5JpWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQ3+KzrP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQ3+KzrP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8631C4CEF7;
	Thu, 19 Feb 2026 22:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771541731;
	bh=46FGtlC+F69jRzZYxcG+FruvpR/OUJin/9cTjRauVI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HQ3+KzrPv5IRK0CWWFDeRYZiac6e50qoWnwxdXTtel99UhqzB5I7CscdsHeDFphsI
	 G30NnOwQym/4quvDafcJ4QPZoEWHpjHUFmVPwMtNhPJi6rHZsmrRRYMzIQsUQTVL5u
	 KrdpigDR6hJ+ctDRFKmUJ/0S1bR5aNKjx0pAM29JB8hh3KLU3yL5HkIr/BzHczSKjL
	 QxiYYa1QZIWgIauoGPlfPhYMwqI3lCijiQzxQnnUBBYSNYqMSmJzpUwCSF6MM9NC8t
	 B/xuIE0rqjV9tijdgRTmvrGYZTIHz6HwZaQEDHquDrcfXf95oFc7t9g3WTy9qLjBBU
	 6OWhvka/8EWow==
Date: Thu, 19 Feb 2026 14:55:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
Cc: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
 <maciej.fijalkowski@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v4 2/2] xsk: Fix zero-copy AF_XDP fragment drop
Message-ID: <20260219145529.42b177d3@kernel.org>
In-Reply-To: <20260217211019.48280-3-nikhil.rao@amd.com>
References: <20260217211019.48280-1-nikhil.rao@amd.com>
	<20260217211019.48280-3-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Feb 2026 21:08:51 +0000 Nikhil P. Rao wrote:
> AF_XDP should ensure that only a complete packet is sent to application.
> In the zero-copy case, if the Rx queue gets full as fragments are being
> enqueued, the remaining fragments are dropped.
> 
> For the multi-buffer case, add a check to ensure that the Rx queue has
> enough space for all fragments of a packet before starting to enqueue
> them.
> 
> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
> ---
>  net/xdp/xsk.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f2ec4f78bbb6..f7f816a5cb80 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -167,25 +167,32 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  	struct xdp_buff_xsk *pos, *tmp;
>  	struct list_head *xskb_list;
>  	u32 contd = 0;
> +	u32 num_desc;
>  	int err;
>  
> -	if (frags)
> +	if (frags) {
> +		num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
>  		contd = XDP_PKT_CONTD;

[1]

> +	} else {
> +		err = __xsk_rcv_zc(xs, xskb, len, contd);
> +		if (err)
> +			goto err;
> +		return 0;
> +	}
>  
> -	err = __xsk_rcv_zc(xs, xskb, len, contd);
> -	if (err)
> +	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {

We can pull this check into the branch at [1]
It will let us preserve the existing flow.

Either that or handle the non-frag case fully upfront:

if (likely(!frags)) {
	err = __xsk_rcv_zc(xs, xskb, len, 0);
	if (err)
		goto err;
	return 0;
}

As is you have a weird mix of the two.

> +		xs->rx_queue_full++;
> +		err = -ENOBUFS;
>  		goto err;
> -	if (likely(!frags))
> -		return 0;
> +	}
>  
> +	__xsk_rcv_zc(xs, xskb, len, contd);

Personal preference perhaps but removing error checking always
gives me pause. Maybe:

	bool frag_fail;

	frag_fail = __xsk_rcv_zc(xs, xskb, len, contd);
	list_for_each...
		...
		frag_fail |= __xsk_rcv_zc(xs, xskb, len, contd);
	DEBUG_NET_WARN_ON_ONCE(frag_fail);

?

>  	xskb_list = &xskb->pool->xskb_list;
>  	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
>  		if (list_is_singular(xskb_list))
>  			contd = 0;
>  		len = pos->xdp.data_end - pos->xdp.data;
> -		err = __xsk_rcv_zc(xs, pos, len, contd);
> -		if (err)
> -			goto err;
> +		__xsk_rcv_zc(xs, pos, len, contd);
>  		list_del_init(&pos->list_node);
>  	}
>  
-- 
pw-bot: cr
