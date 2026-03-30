Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DA639A06B;
	Mon, 30 Mar 2026 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774915073; cv=none; b=jt6IO7knLXIKkS1PLnXf1vfO9zVoe8HEetcwDVpixJGKcueEb/uB7OSNWjVdMZXl/rP/ZPzFjWc1Kz5CZC2qEqX8zrHWIVtpt8hvSC/lA8wu0eBv8NSqKabpNWCaMB2RClyLcIquZKO8yGEYRcCj2InWZRh3tVZYfUXO26pEymc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774915073; c=relaxed/simple;
	bh=MZz1I5KaghZg0i8pcba51NKrWGkSXqR+Xxz0HrXBaqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiJRoMhvMIBR6BADUwwMcbCFlnASHcCZwyXq2RcWcWpTZyV7UKlIrVztD55ehuYjoK+CBNMxHE7y9Hp5Kmv1pwwuPR4hak+kjUWGewnnNF3ASWoRqoWWqfEAxoBQO4Xn12Rzrf0U3FefkMM04plKx7hxFttjbqvVBc3n/e4HJn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVEIdvqS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVEIdvqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22500C4CEF7;
	Mon, 30 Mar 2026 23:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774915072;
	bh=MZz1I5KaghZg0i8pcba51NKrWGkSXqR+Xxz0HrXBaqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JVEIdvqStksBLcF3Nw1syKj5oRh1/5Rd7SxvIGNCU3KQCl1EqXuFoTVCsJtksFFRn
	 6SQWE/PnXMN7k3hd3AE3DvY1KmEijVJGDtufcZvPRpZyz/Te2A0jcFN9TPQeFWOTjA
	 4a8msI6oU5ZKk3hZMoNhqJbzeNhxr9+gClVrUYSHIEOkjOAecZMYeX6ldzlz0by4Y6
	 JysQL/zI0FfGagHISNSQl236kBK59z97l1QANqVzCbgfffd8ga9anpS6MtfkkCVDFa
	 K7QpNUZvQcvz1/ey8cD0FFmQF6u2s/TT1U1/hhGw38PVZpHNVlHWuNq0B2fSOPWxZg
	 lC9Qn/JjntlmA==
Date: Mon, 30 Mar 2026 16:57:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org,
 pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v6 09/12] net: bnxt: Add SW GSO completion and
 teardown support
Message-ID: <20260330165748.2edb501a@kernel.org>
In-Reply-To: <20260326235238.2940471-10-joe@dama.to>
References: <20260326235238.2940471-1-joe@dama.to>
	<20260326235238.2940471-10-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 16:52:28 -0700 Joe Damato wrote:
> @@ -4645,6 +4687,10 @@ static int bnxt_init_tx_rings(struct bnxt *bp)
>  
>  	bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
>  				   BNXT_MIN_TX_DESC_CNT);
> +	if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
> +	    (bp->dev->features & NETIF_F_GSO_UDP_L4))
> +		bp->tx_wake_thresh = max_t(int, bp->tx_wake_thresh,
> +					   BNXT_SW_USO_MAX_DESCS);
>  
>  	for (i = 0; i < bp->tx_nr_rings; i++) {
>  		struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
> @@ -13832,6 +13878,11 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
>  	if ((features & NETIF_F_NTUPLE) && !bnxt_rfs_capable(bp, false))
>  		features &= ~NETIF_F_NTUPLE;
>  
> +	if ((features & NETIF_F_GSO_UDP_L4) &&
> +	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
> +	    bp->tx_ring_size < 2 * BNXT_SW_USO_MAX_DESCS)
> +		features &= ~NETIF_F_GSO_UDP_L4;
> +
>  	if ((bp->flags & BNXT_FLAG_NO_AGG_RINGS) || bp->xdp_prog)
>  		features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);
>  
> @@ -13877,6 +13928,15 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
>  	int rc = 0;
>  	bool re_init = false;
>  
> +	if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP)) {
> +		if (features & NETIF_F_GSO_UDP_L4)
> +			bp->tx_wake_thresh = max_t(int, bp->tx_wake_thresh,
> +						   BNXT_SW_USO_MAX_DESCS);
> +		else
> +			bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
> +						   BNXT_MIN_TX_DESC_CNT);

Adding extra handling for min ring size all over the place looks a bit
messy. Can you factor something out of this logic?
