Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C4A3BCD15
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957177; cv=none; b=OqQl9/nMle7psP0aX+VmYxfPT8C+1hSaLCkGJ2Gw59oS/3tXwQ0t1EOvOnRXpKr/1aHF8jwwssOlF1HqVDA8BAZzVaH+MC4ZG9myhzBGFzoN2PqoBgb0vnxji5lvPvaZrKOyTOJ45FQcG9gblVaD62w8FGEkFelVRVEu6pTNwLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957177; c=relaxed/simple;
	bh=/+yiRtlM3lZbtcuOCIRNVIUTsYFLb2VJRRdqrByUACI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FChMO2iKDhrz650+gAWi4qLlV/+Qx2XWvxt9CExey5wGCSki9I+ACA1St4KbZQsSF/wVAyfy6Gp/I1QkVf9umJyTP8FiwMo9U/Gs3678PHNKyDlpMefQCQWspk3YiiAhTdJOw3fO0ARXG7AgZhXyEl2oMTcqBJKxCB796sKCFXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS6rMxXv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS6rMxXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B721E1F00A3A;
	Mon, 17 Aug 2026 08:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786957176;
	bh=PJrhB+O19NMcqefe4p6lxO8h5wPhDbnoHNMTc9x3sls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fS6rMxXvuxpUrnhY1YQ3WrGhcBHNVFjti1gLUFLDGwerTa8wiY8LazAWB6K2kj7eF
	 gYkQv1vivrC8kUHbdDGE0Vd8/NwGMaQ/yGKE6eO4HNy8+fcTiZyw/ImFk/ow09HZRL
	 BJSlr2wiORlHtTFTedbuSz5coK3B0cJOL5caIW3p75Rz72FmxIJl7MqvakH3tkGXze
	 EJZKqkj5aDDtiKVzNQpPnEey76zwoPR0H9REIWlhmFHF9NyOZubzelp6IMJv28hdKs
	 GmMRB4AZ+PPT6JoW6yDU2Y2Ig/5IX1vBu0zGFHchJwN9r68SGpyY+dcHROBYrh7GIU
	 ZmaNs/aCIxthA==
Date: Mon, 17 Aug 2026 09:59:32 +0100
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next] net: wangxun: protect ring accesses with READ-
 and WRITE_ONCE
Message-ID: <20260817085932.GV265046@horms.kernel.org>
References: <20260813095141.88227-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813095141.88227-1-mengyuanlou@net-swift.com>

On Thu, Aug 13, 2026 at 05:51:41PM +0800, Mengyuan Lou wrote:
> In wx_update_stats(), the ring pointers wx->rx_ring[i] and wx->tx_ring[i]
> can become NULL during queue teardown or reconfiguration (e.g., via
> wx_free_q_vector()).
> 
> READ_ONCE should be used when reading rings prior to accessing the
> statistics pointer to ensure protected access. As well as the
> corresponding WRITE_ONCE usage when allocating and freeing the rings.

Hi Mengyuan,

As observed in an AI-generated review of this patch [1], this patch is
doing a bit more than adding READ_ONCE/WRITE_ONCE.  It also adds an RCU
read-side critical section (the most important part of the change, IMHO),
and some NULL checks. It might be nice to extend this description somehow.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260813095141.88227-1-mengyuanlou%40net-swift.com

> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c  | 20 ++++++++++++++++----
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c |  8 ++++----
>  2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 122c4952d203..096fe7f3d84f 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -2893,10 +2893,13 @@ void wx_update_stats(struct wx *wx)
>  
>  	spin_lock(&wx->hw_stats_lock);
>  
> +	rcu_read_lock();
>  	/* gather some stats to the wx struct that are per queue */
>  	for (i = 0; i < wx->num_rx_queues; i++) {
> -		struct wx_ring *rx_ring = wx->rx_ring[i];
> +		struct wx_ring *rx_ring = READ_ONCE(wx->rx_ring[i]);
>  
> +		if (!rx_ring)
> +			continue;
>  		non_eop_descs += rx_ring->rx_stats.non_eop_descs;
>  		alloc_rx_buff_failed += rx_ring->rx_stats.alloc_rx_buff_failed;
>  		hw_csum_rx_good += rx_ring->rx_stats.csum_good_cnt;
> @@ -2912,19 +2915,28 @@ void wx_update_stats(struct wx *wx)
>  		u64 rsc_flush = 0;
>  
>  		for (i = 0; i < wx->num_rx_queues; i++) {
> -			rsc_count += wx->rx_ring[i]->rx_stats.rsc_count;
> -			rsc_flush += wx->rx_ring[i]->rx_stats.rsc_flush;
> +			struct wx_ring *rx_ring = READ_ONCE(wx->rx_ring[i]);
> +
> +			if (!rx_ring)
> +				continue;
> +
> +			rsc_count += rx_ring->rx_stats.rsc_count;
> +			rsc_flush += rx_ring->rx_stats.rsc_flush;
>  		}
>  		wx->rsc_count = rsc_count;
>  		wx->rsc_flush = rsc_flush;
>  	}
>  
>  	for (i = 0; i < wx->num_tx_queues; i++) {
> -		struct wx_ring *tx_ring = wx->tx_ring[i];
> +		struct wx_ring *tx_ring = READ_ONCE(wx->tx_ring[i]);
> +
> +		if (!tx_ring)
> +			continue;
>  
>  		restart_queue += tx_ring->tx_stats.restart_queue;
>  		tx_busy += tx_ring->tx_stats.tx_busy;
>  	}
> +	rcu_read_unlock();
>  	wx->restart_queue = restart_queue;
>  	wx->tx_busy = tx_busy;
>  

A littler further down in this function there is a call to
wx_update_xoff_rx_lfc().

And since commit 22d95e93c05b ("net: wangxun: add Tx timeout process")
that function includes the following loop:


	for (i = 0; i < wx->num_tx_queues; i++)
		clear_bit(WX_HANG_CHECK_ARMED, wx->tx_ring[i]->state);

So I am wondering of this access to wx->tx_ring should be protected.
E.g. by extending the RCU read-side critical section to also cover
the call to wx_update_xoff_rx_lfc(), and by using READ_ONCE in
the loop above.

Observed with some assistance from Goose:gemini-3.1-flash-lite

...
