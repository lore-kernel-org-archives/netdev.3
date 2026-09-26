Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6613939B0;
	Sat, 26 Sep 2026 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790448573; cv=none; b=hLcRfwR21nnOlvC+9cFtR5ipC/aGxGR7soO50unwOG8qHmNcfKMDAQuyszl4HkMcKHLcPY7kFn0ZTH1CW4f7O9SybJjv0epsjvQYLyOoFq0hO4H1PQ4zHFBQvGfhHPTcP1XFZG0r3BMJOHHSes4e0pr4q2CUuseFpfxSKuu8EZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790448573; c=relaxed/simple;
	bh=rCVS1dbiTfDS0jhswukM+1RiwECpWcMv6BbMGC+gQvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BirIG59vBRruLQgapLlKywMG+QA08Qlw/iVGb8/cRbFM+P5an5ci6nwe7Z/qItvj/x3Pu0XFd8x2HgCuHEK0jBRhSgnMEpjmwEJjpUIjL7vC9LqNvrZqsWOX7pkzUvdnVaiWjskoIGPyMe7IjWbAjT5gpoUnWqLIsaStsY13ieQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk8nG90X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk8nG90X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EB91F000FF;
	Sat, 26 Sep 2026 18:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790448571;
	bh=FhCUAjMTRdSu2iwGOuY7sgjoyeuf9oIgvabf6YO920g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dk8nG90X527poEz1klXfdOz+Wnmw0tBcxK2RwoQHKC3xf0DyjuKwe46FuFlNksp0S
	 DSJK+JI7Xdnx6WPszQg7Ifc+BansRWyQAyfrmLFPQblF/vLk81cvw4mduxnH1ZPXJY
	 diUCheqe8HKPTsNpfvh9JCM+tDxzQ3XzBTM+lMWuVqqasH+XkxRGuteiWmdOlcuIlH
	 MLAKxgKzMHI+1ECC67Why3cpwYYowqbywzt1n5b6pRR+Q++UDZs1IEdiAJnXzpJb1S
	 OQ4+Vb3OnPTiDdPVZUEXnYfdHGMag+4wWCqlRZRqjix76Kiu9H6KoimKp4SGEdIy7K
	 4w+KtoULo3Vxw==
Date: Sat, 26 Sep 2026 19:49:26 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: bhargava.marreddy@broadcom.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com, dharmender.garg@broadcom.com
Subject: Re: [PATCH net-next v2 1/6] bnge: Extract bnapi allocation and
 cleanup into helpers
Message-ID: <20260926184926.GC13925@horms.kernel.org>
References: <20260922052904.59237-2-bhargava.marreddy@broadcom.com>
 <179026966721.2160803.3672240762098051468@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179026966721.2160803.3672240762098051468@kernel.org>

On Thu, Sep 24, 2026 at 05:07:47PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).

In the interest of moving things along I will respond to this.

> 
> - [Medium] The commit message describes the three new NULL guards as
>   preparatory hardening ("add NULL guards for rx_ring and tx_ring in…
> 
> --
> 
> bnge: Extract bnapi allocation and cleanup into helpers
> 
> This moves the bn->bnapi allocation and free code out of
> bnge_alloc_core()/bnge_free_core() into bnge_alloc_bnapi_mem() and
> bnge_free_bnapi_mem(), and adds NULL checks for bn->rx_ring and
> bn->tx_ring in the ring cleanup helpers.
> 
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> > index a4288f0258f87..c1810a3098883 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> > @@ -825,6 +825,9 @@ static void bnge_free_tpa_info(struct bnge_net *bn)
> >  	struct bnge_dev *bd = bn->bd;
> >  	int i, j;
> >  
> > +	if (!bn->rx_ring)
> > +		return;
> > +

The check above appears to be purely defensive.
I do not believe it can ever be true.
If so, please remove it.

> >  	for (i = 0; i < bd->rx_nr_rings; i++) {
> >  		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
> >  
> > @@ -881,6 +884,9 @@ static void bnge_free_rx_rings(struct bnge_net *bn)
> >  	struct bnge_dev *bd = bn->bd;
> >  	int i;
> >  
> > +	if (!bn->rx_ring)
> > +		return;
> > +
> >  	bnge_free_tpa_info(bn);
> >  	for (i = 0; i < bd->rx_nr_rings; i++) {
> >  		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
> > @@ -1024,6 +1030,9 @@ static void bnge_free_tx_rings(struct bnge_net *bn)
> >  	struct bnge_dev *bd = bn->bd;
> >  	int i;
> >  
> > +	if (!bn->tx_ring)
> > +		return;
> > +
> 
> [Severity: Medium]
> Are these three new NULL checks really just preparation, or do they fix a
> reachable NULL pointer dereference that exists today?

It seems to me that the two hunks above do fix a bug,
can could manifest under memory pressure..
And thus should be broken out as a separate patch for net.

> 
> The commit message says only:
> 
>     Prepare the driver to move bnapi allocation out of the open/close path,
>     and add NULL guards for rx_ring and tx_ring in core driver cleanup paths.
> 
> Before this patch, bnge_alloc_core() allocates bn->bnapi, then bn->rx_ring,
> then bn->tx_ring, and every failure goes to err_free_core: which calls
> bnge_free_core(). bnge_free_core() unconditionally calls
> bnge_free_tx_rings() and bnge_free_rx_rings(), so if the bn->rx_ring
> allocation fails both pointers are still NULL:
> 
> drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:bnge_free_tx_rings() {
> 	for (i = 0; i < bd->tx_nr_rings; i++) {
> 		struct bnge_tx_ring_info *txr = &bn->tx_ring[i];
> 		...
> 		bnge_free_ring(bd, &ring->ring_mem);
> }
> 
> and bnge_free_ring() dereferences that near-NULL address right away:
> 
> drivers/net/ethernet/broadcom/bnge/bnge_rmem.c:bnge_free_ring() {
> 	if (!rmem->pg_arr)
> 		goto skip_pages;
> 
> The rx side looks the same: bnge_free_rx_rings() -> bnge_free_tpa_info()
> reads rxr->rx_tpa_idx_map, and bnge_free_rx_rings() itself calls
> page_pool_destroy(rxr->page_pool), both off a NULL bn->rx_ring.
> 
> Since bnge_alloc_core() runs from the ndo_open path, an allocation failure
> during "ip link set dev ethX up" would oops instead of returning -ENOMEM.
> git blame points the affected loops at commit 0259379037cab9 ("bng_en: Add
> initial support for RX and TX rings"). Would it make sense to split these
> guards into their own patch with a Fixes: 0259379037cab9 tag, so it can be
> picked up for stable? No commit in this series (10cfa109c8..63494c308b19)
> carries such a tag or mentions the crash.
> 
> Note that bnge_free_rx_ring_pair_bufs() already had the same
> if (!bn->rx_ring) return; check, which suggests the guard is functional
> rather than cosmetic.
> 
> >  	for (i = 0; i < bd->tx_nr_rings; i++) {
> >  		struct bnge_tx_ring_info *txr = &bn->tx_ring[i];
> >  		struct bnge_ring_struct *ring;
> 
> [ ... ]
> 
> > @@ -1241,6 +1254,19 @@ static int bnge_alloc_core(struct bnge_net *bn)
> >  		nqr->ring_struct.ring_mem.flags = BNGE_RMEM_RING_PTE_FLAG;
> >  	}
> >  
> > +	return 0;
> > +}
> > +
> > +static int bnge_alloc_core(struct bnge_net *bn)
> > +{
> > +	struct bnge_dev *bd = bn->bd;
> > +	int i, j, rc;
> > +
> > +	rc = bnge_alloc_bnapi_mem(bn);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = -ENOMEM;
> >  	bn->rx_ring = kzalloc_objs(struct bnge_rx_ring_info, bd->rx_nr_rings);
> >  	if (!bn->rx_ring)
> >  		goto err_free_core;
> 
> This is the branch that reaches bnge_free_core() with both bn->rx_ring and
> bn->tx_ring still NULL.

I will add that they way that this code relies on unwind functions,
such as bnge_free_core(), that can unwind from both a fully and partially
initialised state is not the preferred approach.

E.g. while having bnge_free_core() fully clean up state the taredown
patch is fine, the probe path should have a goto ladder that unwinds
incrementally based on where initialization failed.

For a bug fix, a minimal approach, that adds some conditions, is probably
best. But perhaps there are more cases than are covered by this discussion.

-- 
pw-bot: changes-requested
