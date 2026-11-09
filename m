Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243160;
	b=hLDfEi6G4Vo1MdDt147CR+gvTedjm9Msrxlq9ohb/niQDSQm21Yyxp72cryKAyFQxi6F
	 khyYs+/Z9eBRFzUV6IYvIMf0lG0E9A1evqrKG5KIE3FQG091NkXA+LNsR76lOfisT+819
	 ZpfgXEKhZIuEe80rY5vBDdPwLwyQg+teF2oE7Ug9cdDJ4Q8tOJPsy8xMTx8zYCR6sx8ZM
	 S6SS6WS4bGbKcvgJRJAc42EBtYQjKm8+DPFsbDNmn0yWvmCrAPIPh9lPVajSagH4bHFar
	 DAasnE9KNJoYGqkuUNJkb5P5bMTTea27AADD6TEpx89bHwKK3Y9ZAyMLNsfYO9WrzTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243160;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WBEAXWn/Gapt4KuRgUjdXuXmF6aQgvDHYaPeKeySe5M=;
	b=AEm3c958KzKOveOvGi5ult5hdrEUJo2FCoF9aHcINa8MF5xgpwxm/15R5P7j8T+TbaWv
	 VSkWTjU+Fsc3o06gUidd7Qw/teWN1Duc3OIuBdCuNMS35DCocX1V3RJLETCZyvAuBqk8U
	 ym5eeOG+uqq6cs5xL6L2B7NvgZEyypoFNSPjiWTuCnZ7HHxsCVeCB+MCaBvo4oykYUU2I
	 YqcvmUBYT6PnwJUN292TRw+n7LgJOlqXIlMVRJVoU13xs6N0GuEFbUp0R0bUIwgSpegR7
	 cnwZshimm/rkL9InFQUdlohkEjb6F4DaK7JC5GqkFU7Q08z8oMPzXqYWpcCB6EHj4kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RiDATvMr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B325606EEB2;
	Mon,  9 Nov 2026 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RiDATvMr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF7A1F008A4;
	Mon,  9 Nov 2026 16:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794243159;
	bh=WBEAXWn/Gapt4KuRgUjdXuXmF6aQgvDHYaPeKeySe5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RiDATvMr5i+6a+a/3TSoFjEem7mY9e+KGFYsasZ3YUc+Rw8yN0EuQeD1kXOWu9fXW
	 cExmFrfntUc2ac0z86BKSjvl7FmL+KvI4boWTfTT8zUjyai0stzJkOFJF5pTvCeqZf
	 rMvx4g3ZqxyuP0hAqN5gY80niOdZ10INxgte3pm9I3kDedKTsG1NLgbGZUsII0RjJj
	 koCeqz1+qPnmOvFjAfal+mId6Ct8lT6dhBmMaOdHpA9MgKdLHsDz1iRy0OMTkXZrtb
	 83/gp2GuHwViHaPHJlXOENgaxxUULz++FZwv35N13/g8Pl7rU74mVtgit2y38IlUsS
	 1LmUTEwg6z9Qw==
Date: Mon, 9 Nov 2026 16:52:35 +0000
From: Simon Horman <horms@kernel.org>
To: laixiangwu <laixiangwu@cmss.chinamobile.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ti: icssg-prueth: Fix device_node refcount leak in
 prueth_probe()
Message-ID: <20261109165235.GR18859@horms.kernel.org>
References: <20261030085651.1944-1-laixiangwu@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030085651.1944-1-laixiangwu@cmss.chinamobile.com>

On Fri, Oct 30, 2026 at 04:56:51PM +0800, laixiangwu wrote:
> prueth_probe() takes references on the eth0_node/eth1_node device nodes
> with of_node_get() and stores them in prueth->eth_node[]. If either of
> the "ti,mii-g-rt" or "ti,mii-rt" syscon regmap lookups fails, probe()
> returns -ENODEV without dropping those references, leaking the device
> nodes.
> 
> Jump to the existing put_cores label so the error path releases the
> eth0_node/eth1_node references like all the other failure paths in the
> function do.
> 
> Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
> Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 591be5c80..9b971d1df 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -2258,13 +2258,15 @@ static int prueth_probe(struct platform_device *pdev)
>  	prueth->miig_rt = syscon_regmap_lookup_by_phandle(np, "ti,mii-g-rt");
>  	if (IS_ERR(prueth->miig_rt)) {
>  		dev_err(dev, "couldn't get ti,mii-g-rt syscon regmap\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto put_cores;
>  	}
>  
>  	prueth->mii_rt = syscon_regmap_lookup_by_phandle(np, "ti,mii-rt");
>  	if (IS_ERR(prueth->mii_rt)) {
>  		dev_err(dev, "couldn't get ti,mii-rt syscon regmap\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto put_cores;
>  	}
>  
>  	prueth->pa_stats = syscon_regmap_lookup_by_phandle(np, "ti,pa-stats");

Hi Laixianwu,

Thanks, this patch looks correct to me.
And I appreciate your feedback to the AI bots.

But I wonder if this nearby check also leaks a reference,
because while it drops one, wouldn't there be two if the
condition is met?

        if (eth0_node == eth1_node) {
                dev_err(dev, "port0 and port1 can't have same reg\n");
                of_node_put(eth0_node);
                return -ENODEV;
        }

Also, for future reference, it would probably be better to put
two similar fixes for related drivers in a two-patch patch-set,
rather than posting them separately.
