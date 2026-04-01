Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F44C78F29;
	Wed,  1 Apr 2026 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775005406; cv=none; b=Dad6koqer2jPqnhGo/+Iq1IOeaN5vqygQnzEwWf8x4J9up4fFqy7P2ahtk23GfHj/m8m2gi+X9ef3Npkxq5uTZWBKAhLfmtvRRgZpXNv50obp5lEqYvu1KI4wB+3x6Zw7+VKphQcEz4aQO4TvLVELG6IGxgdPFB6p1t6gjPPmhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775005406; c=relaxed/simple;
	bh=gSBOKF15xTkXoWnGImza/uHwk/U2Eu+SRo8aF2kLJ7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gz9M7VJlBJllOJZDxICPlFi0gLDFaWnA2tYHEFF/X82qG021qYnW2+Wl+UEXmaaQfrn+L/eJtS5xgPG7UrgXrKJnlWgiVmr+gfFKCNUaSYFnrIoMsZspJJWhxwb9aFUgsYzWJiU3CSc1ylNffCZrZe0XP3LUXX+uwsvG6xHyzgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv713AbJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv713AbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5E3C2BCB0;
	Wed,  1 Apr 2026 01:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775005406;
	bh=gSBOKF15xTkXoWnGImza/uHwk/U2Eu+SRo8aF2kLJ7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fv713AbJIVO1z6gyGkgBdczkj9YKfw8YD24BreHCR0OLucD5WyKJZPtinjdUTXf5K
	 32QZuMipe5VQUBHcSHXGLtrKqtGATn5pDS0V5lUOpqOvKf9VQz08eDFUO6jJDeS6US
	 UbTjbo2lY2o7WTCeHY27NzmKKFkz1mO80PAoL4ER9VaYXn9KvA+3iRSsqFltaoo0nW
	 LKDKz8vc5nK+R6k6F/L2Qvafhxot038/+XQsK3Diq+U1onVYgpZroNRKxP5DZlInJ6
	 s649NW9aMnCKbkIaT54X7mtAD7cmnt2Soi0BIK5BVK0VpRZM87FR8X3ExCOkarLnBX
	 Xz5oMOUx9SJOA==
Date: Tue, 31 Mar 2026 18:03:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org,
 pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v6 09/12] net: bnxt: Add SW GSO completion and
 teardown support
Message-ID: <20260331180324.728190c5@kernel.org>
In-Reply-To: <acw5IWuRiLV0yHVe@devvm20253.cco0.facebook.com>
References: <20260326235238.2940471-1-joe@dama.to>
	<20260326235238.2940471-10-joe@dama.to>
	<20260330165748.2edb501a@kernel.org>
	<acw5IWuRiLV0yHVe@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 14:14:09 -0700 Joe Damato wrote:
> > > +	if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP)) {
> > > +		if (features & NETIF_F_GSO_UDP_L4)
> > > +			bp->tx_wake_thresh = max_t(int, bp->tx_wake_thresh,
> > > +						   BNXT_SW_USO_MAX_DESCS);
> > > +		else
> > > +			bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
> > > +						   BNXT_MIN_TX_DESC_CNT);  
> > 
> > Adding extra handling for min ring size all over the place looks a bit
> > messy. Can you factor something out of this logic?  
> 
> Could add something like:
> 
>   static int bnxt_min_tx_desc_cnt(struct bnxt *bp)
>   {
>       if (!(bp->flags & BNXT_FLAG_UDP_GSO_CAP) &&
>           (bp->dev->features & NETIF_F_GSO_UDP_L4))
>           return BNXT_SW_USO_MAX_DESCS;
>       return BNXT_MIN_TX_DESC_CNT;
>   }
> 
> and then when setting the tx_wake_thresh, it becomes:
> 
>   bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
>                              bnxt_min_tx_desc_cnt(bp));
> 
> and fix_features can use the same helper.

Something along these lines looks reasonable.

> Question then is just do we still want to bump BNXT_MIN_TX_DESC_CNT (as per
> your previous comment)?

No, sorry, I sent that one before looking at the relevant part of
the diffs
