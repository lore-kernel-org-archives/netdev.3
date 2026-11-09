Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243548;
	b=BBw6LX4CjRkXqVvTsjqZZsN3yWww2AtKy6LWrF2auiCPTcvl+u3GNzFMWZsN/AZeBsWi
	 2DjHq8osNJArTTl2HMHyi4iXTb6men/ywCw0Jz9Y+fz+gRn8fsCptqmTCMU65De9+hg8c
	 ZJoUucKQDen8EJ0/Ih8EuHXHRrv0LxE9rzPqi8AqAbm11N2GDKKbey0nHQ0SmqD+Vj1Kc
	 BA1ktju1i15eewOphpNwIyPYEowwbg3SnTCbfhMJX9j/KQyB0HT/qtH96TBgpgPO9qmfr
	 fJEhStiMfdrssAlmo314T/HuQFrOJzSpcob9okpikDDFC6aOJ+skUp2noDGsu4R9ptQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243548;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0LtJx1KBdKZ3ZI9o+1o9OL4PdjTAWomKB8/BPDT/SD0=;
	b=PRxzpoY0+7uCp+BWIRl6iiVt9MyPZcM9670Sz9X/N4vs5+dKzRPGkxgEIeCQDE3V4WzR
	 yWVM8rWBT2WDOXJ4ZJSA7kmWmu62VgAwyjZ0jZlQg4IP3TQjnRuomZ3fo7jnHNCxTt+MY
	 d6sHl++38BWqrNtsHpdQVkDa7Qx5N+4JFWQxvgdTx/1w7AknvHjlyIZVJHqmp1aPN+Ars
	 4pxEwbPz7hK1JZ0H/qG/1li3OLs27JJk/mD9sgiuy/mCuNYNDkOrcsyiVL1MKYIHZ/5gG
	 cUIBz5Pr6BcMu7JoxWuHm/UOzUSRi8uRi2t+NPhakmXKTZ6O7pJUyMMptb/ywpXU1Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YkdDtHy+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE974606A31C;
	Mon,  9 Nov 2026 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YkdDtHy+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206DA1F0089F;
	Mon,  9 Nov 2026 16:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794243547;
	bh=0LtJx1KBdKZ3ZI9o+1o9OL4PdjTAWomKB8/BPDT/SD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YkdDtHy+qUXMzro+ShPKwWhd+3eoje6rcc8REtdlq+GzPlEKx/FX1XLP8HJIzjnCS
	 LBzu6hM+FMkCAkNgSRLhp9l6Pv5At6OagWFMo5D0n7dMk1bcXI/PAyvNiqkbro8AS5
	 22gVeGaFzTTOufvA9GvJQlafIp3J+EYshbU4T8AcT6v2WBoy6NgFBf+/Yy5uNgpc9A
	 qDPeOCMd52uH0/k32oJlx86dZWI6wimi5fyp3QaiPWHuoqjtpWHyHGTxd1jkQ+bQYn
	 SRWwmnAdKIO1wFUtG33y5asWMHolyYpQH1ImqXgZ2of5Nc/J7z40oXXsJFC33OBD0j
	 krQH/VG9PHmwA==
Date: Mon, 9 Nov 2026 16:59:02 +0000
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
Message-ID: <20261109165902.GS18859@horms.kernel.org>
References: <20261030085651.1944-1-laixiangwu@cmss.chinamobile.com>
 <20261109165235.GR18859@horms.kernel.org>
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
In-Reply-To: <20261109165235.GR18859@horms.kernel.org>

On Mon, Nov 09, 2026 at 04:52:35PM +0000, Simon Horman wrote:
> On Fri, Oct 30, 2026 at 04:56:51PM +0800, laixiangwu wrote:
> > prueth_probe() takes references on the eth0_node/eth1_node device nodes
> > with of_node_get() and stores them in prueth->eth_node[]. If either of
> > the "ti,mii-g-rt" or "ti,mii-rt" syscon regmap lookups fails, probe()
> > returns -ENODEV without dropping those references, leaking the device
> > nodes.
> > 
> > Jump to the existing put_cores label so the error path releases the
> > eth0_node/eth1_node references like all the other failure paths in the
> > function do.
> > 
> > Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
> > Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
> > ---
> >  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> > index 591be5c80..9b971d1df 100644
> > --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> > +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> > @@ -2258,13 +2258,15 @@ static int prueth_probe(struct platform_device *pdev)
> >  	prueth->miig_rt = syscon_regmap_lookup_by_phandle(np, "ti,mii-g-rt");
> >  	if (IS_ERR(prueth->miig_rt)) {
> >  		dev_err(dev, "couldn't get ti,mii-g-rt syscon regmap\n");
> > -		return -ENODEV;
> > +		ret = -ENODEV;
> > +		goto put_cores;
> >  	}
> >  
> >  	prueth->mii_rt = syscon_regmap_lookup_by_phandle(np, "ti,mii-rt");
> >  	if (IS_ERR(prueth->mii_rt)) {
> >  		dev_err(dev, "couldn't get ti,mii-rt syscon regmap\n");
> > -		return -ENODEV;
> > +		ret = -ENODEV;
> > +		goto put_cores;
> >  	}
> >  
> >  	prueth->pa_stats = syscon_regmap_lookup_by_phandle(np, "ti,pa-stats");
> 
> Hi Laixianwu,
> 
> Thanks, this patch looks correct to me.
> And I appreciate your feedback to the AI bots.
> 
> But I wonder if this nearby check also leaks a reference,
> because while it drops one, wouldn't there be two if the
> condition is met?
> 
>         if (eth0_node == eth1_node) {
>                 dev_err(dev, "port0 and port1 can't have same reg\n");
>                 of_node_put(eth0_node);
>                 return -ENODEV;
>         }

Sorry, one more thing. Which is not strictly related.  But as we're on the
topic of error paths in this function, I am not convinced of the validity
of the value of reg being used even when the call to of_property_read_u32
fails in this loop:

        for_each_child_of_node(eth_ports_node, eth_node) {
                u32 reg;

                if (strcmp(eth_node->name, "port"))
                        continue;
                ret = of_property_read_u32(eth_node, "reg", &reg);
                if (ret < 0) {
                        dev_err(dev, "%pOF error reading port_id %d\n",         
                                eth_node, ret);
                }

                of_node_get(eth_node);

                if (reg == 0) {
                        eth0_node = eth_node;
                        if (!of_device_is_available(eth0_node)) {
                                of_node_put(eth0_node);
                                eth0_node = NULL;
                        }
                } else if (reg == 1) {
                        eth1_node = eth_node;
                        if (!of_device_is_available(eth1_node)) {
                                of_node_put(eth1_node);
                                eth1_node = NULL;
                        }
                } else {
                        dev_err(dev, "port reg should be 0 or 1\n");
                }
        }

> 
> Also, for future reference, it would probably be better to put
> two similar fixes for related drivers in a two-patch patch-set,
> rather than posting them separately.
