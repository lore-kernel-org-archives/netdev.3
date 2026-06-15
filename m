Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D0B340D90;
	Mon, 15 Jun 2026 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522534; cv=none; b=iTqwsCXF0t566DCel7ulKCUq8Q/mFD9cz6iaC3lvDFIX5CtzD4+G64O5QmDzrRqcO+mHriTndPhp+pD/RpExvupTkg4BFvNblGDg66ktzUCwo8JbdA1rQ1XZX88bumgWz5H84I9+sevQ5WL6ss1/loOly0zRMWRhOU7RZdshRao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522534; c=relaxed/simple;
	bh=/MuDaOiHF9DYQ0To4fpXzkTT9w/BiYVGRh6hDqbgQMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1wN6NOb+sXX2VJm8PDPVGfEAD6q/DKRm9H4jWIc+fn8y1XmvmLn6tH8k8ybzLIcMEJY4S9nivXFsdTqk+i1vFaB7LP7388cB8PlKU4VXLUQjvQvSs/NcNP9HV6aKZI6jn//Y2vSvvJkqtievPQp0jzypD/FJizTHr6D4GOz9nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVEy0/Tb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVEy0/Tb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434421F000E9;
	Mon, 15 Jun 2026 11:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781522532;
	bh=dWu3x3+fKrurpYN/VpyZ05LCbhYa2x74DLFqWmaIIE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GVEy0/Tb2dOviS+hlhbHFbd9rTD0S6QqlTRG1HpCLE5XSNN/VAX4FAkcYc2ugYp/y
	 gjkvEU5/TBn8sWML4BrWzWHPILxx4fj/OvOqeHXBUnnw3T+W0wMdcXQXOLcCG3/17N
	 75ktiJZOc6eZkP9XeNEUxhLjXY7/DnswX/8mvGQx2rFafJiHRqxN6DCv5MTNePE00r
	 aX3aMWTAFMzHqLGQaBhIe86q9Up8lnoIF4cCtcLVgMp0sz0C5CpcfPsbXY46gNEdJj
	 bhL2UVcwU64WpWkVBY2FEp3YlndZbIHlBTUfly5IEN4GTEGGE70o4EXWI8jKbENySq
	 GGclnvpXppB6A==
Date: Mon, 15 Jun 2026 12:22:08 +0100
From: Simon Horman <horms@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: pch_gbe: handle TX skb allocation failure
Message-ID: <20260615112208.GG712698@horms.kernel.org>
References: <20260613080043.873027-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613080043.873027-1-ruoyuw560@gmail.com>

On Sat, Jun 13, 2026 at 04:00:43PM +0800, Ruoyu Wang wrote:
> pch_gbe_alloc_tx_buffers() allocates an skb for each TX descriptor and
> then passes the returned pointer to skb_reserve(). If netdev_alloc_skb()
> fails, skb_reserve() dereferences NULL.
> 
> Make pch_gbe_alloc_tx_buffers() return an error when an skb allocation
> fails. On failure while bringing the device up, clean any TX buffers that
> were already allocated and release the RX buffer pool through a shared
> cleanup helper before unwinding the IRQ setup.
> 
> Fixes: 77555ee72282 ("net: Add Gigabit Ethernet driver of Topcliff PCH")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

...

> @@ -1887,7 +1902,13 @@ int pch_gbe_up(struct pch_gbe_adapter *adapter)
>  			   "Error: can't bring device up - alloc rx buffers pool failed\n");
>  		goto freeirq;
>  	}
> -	pch_gbe_alloc_tx_buffers(adapter, tx_ring);
> +	err = pch_gbe_alloc_tx_buffers(adapter, tx_ring);
> +	if (err) {
> +		netdev_err(netdev,
> +			   "Error: can't bring device up - alloc tx buffers failed\n");
> +		pch_gbe_clean_tx_ring(adapter, tx_ring);

I think that if pch_gbe_alloc_tx_buffers() fails then
it should handle cleaning up the ring buffer.

IOW, assuming it is safe to call pch_gbe_clean_tx_ring() like this,
I think that call belongs in error handling in pch_gbe_alloc_tx_buffers().

> +		goto freebuf;
> +	}
>  	pch_gbe_alloc_rx_buffers(adapter, rx_ring, rx_ring->count);
>  	adapter->tx_queue_len = netdev->tx_queue_len;
>  	pch_gbe_enable_dma_rx(&adapter->hw);

...
