Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C242D3739;
	Thu, 18 Jun 2026 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795251; cv=none; b=M36wofEChOme4oj8A5fBk4QW1QYE0kQuojFl7lb0K6RwuG+GdFL4zFu+LK825lWWcwzWJP0uDk3hdbKsUx5qgUP7GvRqRRwMFxhapv54NwucRl0S+UFCY/xUPXMyGoXP4ztQsdyD4fLaNQ2To3y4q3TNC2qMvaws3zjoqPRVpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795251; c=relaxed/simple;
	bh=D5ImawvzLlxIMyPCUTgOUk06SN3nr2dO+r0vmLOqkps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AM0mglBkYFxOMvKUUbT9bOXf/p5mOn8TxJxNZLVCXskxp4qiANRfh7kCWOysaw2g01toAIc1gYXBgtXW3q8i1VAigI7+z0cmQRP/vKC28LfcbdxOdHD0CRauQiux6ZsNjHrvqECEAjgpFky9bzWlmLzdBXTh95KVgXgAQA1st8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGtmWOB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGtmWOB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3041F000E9;
	Thu, 18 Jun 2026 15:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795248;
	bh=9EUih94dotOKdCVH4Oy9EjLwrpJlgJ8SRBdHn8fbiYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lGtmWOB2xZGvQ1OcnoEFY0GtU1IcUA8Vf7YepuSkwmtrJq85kX4APQZ/NdOoDR5e7
	 ICenfkwVeN5Phen9S31jQDkZlT7hM3hvN7u3n3iF27jId22hp69f8hGOwZcMAMzXIR
	 ia++GliJjz0oVSqXwrAcIGklkqhoo/PxMTSaIIOkZ1P+H0xuvXjEMGnY/vtSHczZjA
	 uIdkBVwwUJAW9cpT/muHm6eImrlrXpRvEyWqDYNlXfrw5CoJaI1qd1zeKC5ygng4ac
	 izbgJ/k2rXjYwbdK3gbEgPB1CH9aPmM5d9mzob3Hhug8dar4vyEWuiGFQw1svIbOr7
	 0lOcVWWgIl7sw==
Date: Thu, 18 Jun 2026 16:07:23 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, hkelam@marvell.com, lcherian@marvell.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, sgoutham@marvell.com, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: Re: [PATCH net] octeontx2-af: fix CGX debugfs RVU AF PCI reference
 leaks
Message-ID: <20260618150723.GR827683@horms.kernel.org>
References: <20260617104525.1321395-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617104525.1321395-1-rkannoth@marvell.com>

On Wed, Jun 17, 2026 at 04:15:25PM +0530, Ratheesh Kannoth wrote:
> CGX per-lmac debugfs seq readers obtained struct rvu via
> pci_get_drvdata(pci_get_device(..., PCI_DEVID_OCTEONTX2_RVU_AF, ...)),
> which leaks a PCI device reference on every read. Store rvu and the CGX
> handle in debugfs inode private data when creating stats, mac_filter,
> and fwdata files (one context per CGX), and use debugfs aux numbers for
> fwdata so lmac_id matches the other CGX debugfs entries.
> 
> Fixes: f967488d095e ("octeontx2-af: Add per CGX port level NIX Rx/Tx counters")
> Fixes: dbc52debf95f ("octeontx2-af: Debugfs support for DMAC filters")
> Fixes: 49f02e6877d1 ("Octeontx2-af: Debugfs support for firmware data")
> Cc: Linu Cherian <lcherian@marvell.com>
> Reported-by: Yuho Choi <dbgh9129@gmail.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

The nit below not withstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  .../marvell/octeontx2/af/rvu_debugfs.c        | 77 ++++++++++---------
>  1 file changed, 42 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c

...

> @@ -2831,18 +2839,14 @@ static void rvu_dbg_npa_init(struct rvu *rvu)
>  
>  static int cgx_print_stats(struct seq_file *s, int lmac_id)
>  {
> +	struct rvu_cgx_lmac_dbgfs_ctx *dctx = s->private;
>  	struct cgx_link_user_info linfo;
>  	struct mac_ops *mac_ops;
> -	void *cgxd = s->private;
> +	void *cgxd = dctx->cgxd;
> +	struct rvu *rvu = dctx->rvu;

nit: It would be nice to preserve reverse xmas tree order - longest line to
     shortest - for local variable declarations. Likewise elsewhere in this
     patch.

>  	u64 ucast, mcast, bcast;
>  	int stat = 0, err = 0;
>  	u64 tx_stat, rx_stat;

...
