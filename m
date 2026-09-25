Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3684A3B9937;
	Fri, 25 Sep 2026 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790355466; cv=none; b=pyMfP9lVcnmYz2vyxJvIttDUUjDbhQnLxA6rJW87iPniF2wnvCCYw6OC6EG9HvjjNLsp/4FGm6MBD/lCngcazVZnEzb7V+UjW8QUui1aAuNYm8zXRQcIHeBDyRLY7Zl3eJQbT1Zqo9xEARZiVROUPqvAtDteS48Qd+tOmkjdZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790355466; c=relaxed/simple;
	bh=8Z9jQC7c9SbujGPqpgreY5GWmzvf1NnsyeKaLPGSss8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I75fikIvazo/p38ArTCPp4A4/ORFwb+o1bvOH36IWLaNyn04ziMUAbj7j+y0GYuR9SDKir1R8P472YDN9Yn8b/m6CnQGg7obya0D8PX8SwLghGTVwvP/XYt9/izQgQH5fzoMg5xmK1xUtw993hEKqfUMRqwlkGVJ0ixtVk+B0KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouDwAx21; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouDwAx21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA401F000FF;
	Fri, 25 Sep 2026 16:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790355456;
	bh=YeSPjrYOhleyKBr6GOceUk+K4eAhVh006L6OWdIYess=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ouDwAx21oV+FOcNd4ThT90yV4SfLGFI/YL6KOaHLl8YPUd/oOaK2Au1xRW2/N4Rz5
	 v7B1bUrwz44SgaEgBgWk9vvBq+GixJlOiPfBgD9KBgSOo4hJwUlw0u2CWHlGZW5SUR
	 IQe/CEM9CN53Fs5dvSejF2tR2J1+fo5WhsQf6YntkAmMjPOXxAQaUQFlydXg8APSK4
	 gJcySXOj/f/fkpqxcEpHRosYnOlODVlSBjLx4YBew44b3A5jYW/4wcguQOZMOOkH/a
	 Pf/sFDD5DcD8vNJQOL3Y/pXVAHcsBaYqmQhQ3Za7Q+EQkb/zSFKadmXWleCc1RoRQV
	 x0kfbcOpkyI5A==
Date: Fri, 25 Sep 2026 17:57:32 +0100
From: Simon Horman <horms@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Justin Chen <justin.chen@broadcom.com>, kmehltretter@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: allocate RX buffers as page fragments
Message-ID: <20260925165732.GR13925@horms.kernel.org>
References: <20260924101922.2675127-1-nb@tipi-net.de>
 <20260925134714.GM13925@horms.kernel.org>
 <890feb51a8204e6e9f486bcee8e4f819@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <890feb51a8204e6e9f486bcee8e4f819@tipi-net.de>

On Fri, Sep 25, 2026 at 03:59:57PM +0200, Nicolai Buchwitz wrote:
> Hi Simon
> 
> On 25.9.2026 15:47, Simon Horman wrote:
> > On Thu, Sep 24, 2026 at 12:19:21PM +0200, Nicolai Buchwitz wrote:
> > > Since the page_pool conversion every RX buffer is a whole page and the
> > > skb truesize is the page, although the hardware writes at most 2 KiB
> > > of
> > > it. On 64 KiB pages a packet therefore counts 65792 bytes against the
> > > socket buffer where it used to count 2752. As a result a UDP socket
> > > with the default buffer starts to drop after three packets, and the RX
> > > rings pin 16 MiB for 512 KiB of buffers.
> > > 
> > > Fix this and allocate the buffers as page fragments, so the truesize
> > > is
> > > what a packet occupies. 4 KiB pages stay one buffer per page.
> > > 
> > > Sync each buffer in the refill path, as page_pool can only sync a
> > > whole
> > > page on recycle. On 4 KiB pages that is twice what the hardware wrote.
> > > 
> > > Fixes: 7bc054c2d4ed ("net: bcmgenet: convert RX path to page_pool")
> > > Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
> > > Closes: https://lore.kernel.org/all/20260924065839.56793-1-kmehltretter@gmail.com/
> > > Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> > 
> > ...
> > 
> > > @@ -2254,11 +2257,12 @@ static int bcmgenet_rx_refill(struct
> > > bcmgenet_rx_ring *ring,
> > >  			      struct enet_cb *cb)
> > >  {
> > >  	struct bcmgenet_priv *priv = ring->priv;
> > > +	unsigned int size = GENET_RX_BUF_SIZE;
> > > +	unsigned int offset;
> > >  	dma_addr_t mapping;
> > >  	struct page *page;
> > > 
> > > -	page = page_pool_alloc_pages(ring->page_pool,
> > > -				     GFP_ATOMIC);
> > > +	page = page_pool_dev_alloc(ring->page_pool, &offset, &size);
> > 
> > I think it is not so important either way, but I'm wondering
> > if you considered using page_pool_alloc_frag() here.
> 
> Yes, I did, but page_pool_alloc() seemed a better fit as it hands back
> the usable size in *size. Also it falls back to a whole page above half a
> page and avoids an underestimate at the end of a page.

Thanks for the clarification.
All looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

