Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C84908B6;
	Fri, 14 Aug 2026 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726829; cv=none; b=tbsvWimKCYbJNxiz7TIoqDKV0QKInWMfsxxFO+eOVunEOuaM6CBLQJJw4YLOtp7+xKG+oAhOSbqkphr7RsZAS4pF3zC8b9hqh0BcslHNviHID73mQq09ghbnu8v70eGF/5zkD/r5Ohd5ddVqXv/zPhFBWuk0ZXj7p9d2uWxl7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726829; c=relaxed/simple;
	bh=6RBeCqShFjrmmMLQoKBTpxnQ4vzjHJes+sJbqNicTs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA/Cn95OwFnNuRr+uFzAdxzAhDjwOU9PB9ZXU4Gc+/Q9lgnOtKugR+as9ufRft2y99K6Xds2vPXoOT813eOhkrmecMEWrT7AGZdfymNzVhOwP+iLuAiwXDDg1SjvdtGmehNJW7v4emPTubz7u3UYkb4+vxg62hEvNJFjdrA1OPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYr4Y5Eh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYr4Y5Eh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1039E1F000E9;
	Fri, 14 Aug 2026 17:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786726818;
	bh=5h8TZyTAoXCJSe2JoTmpCYR1pmYfom6HhzPNs541mqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iYr4Y5Eh/+tycun1pMxUojBy/q6lPiP/keXRcHaBSkCOTsADvBhLlq+k7j88jjymh
	 DDXubt+0LZkSN6Z13OvJ3eigY9EN1hRhm0cim5eRZrl2weUSwJc/Sb35LlzlPTOOKF
	 Piycj7xXDFFeH49JTzrBnCtj1kvrd11LTxepjpWutUfA//aO4mCWwS807TwQzvsOOq
	 S7JaEOBq8CgJ8mrw0eBmcaAr/7wSxTYrVWUjv1yv9JF89Mn2z5yZDKFPsNgusYJsMH
	 rXsgxwZBSLlIydhx3Np+3edmXbhgfv+Hmg0esZ2rRDRS/VjQuGFDxrgntyW5z8Ld+3
	 UHJTvK91M4aTA==
Date: Fri, 14 Aug 2026 18:00:01 +0100
From: Simon Horman <horms@kernel.org>
To: phucduc.bui@gmail.com
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: xilinx: axienet: Propagate errors from
 optional IRQ lookup
Message-ID: <20260814170001.GQ265046@horms.kernel.org>
References: <20260813042012.17631-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813042012.17631-1-phucduc.bui@gmail.com>

On Thu, Aug 13, 2026 at 11:20:11AM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no optional IRQ is available, while other errors should be propagated.
> 
> Propagate all error codes returned by platform_get_irq_optional() other
> than -ENXIO.
> 
> Another call to platform_get_irq_optional() in the same function already
> handles the return value this way. Apply the same error handling to this
> call site for consistency.

It would be useful to explain how this problem was discovered,
and what testing the patch has seen. Please add an Assisted-by
tag if appropriate.

Link: https://docs.kernel.org/process/coding-assistants.html

> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index fcf517069d16..d23e9796725d 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -2957,12 +2957,16 @@ static int axienet_probe(struct platform_device *pdev)
>  			lp->tx_irq = irq_of_parse_and_map(np, 0);
>  			of_node_put(np);
>  			lp->eth_irq = platform_get_irq_optional(pdev, 0);
> +			if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO)
> +				return lp->eth_irq;
>  		} else {
>  			/* Check for these resources directly on the Ethernet node. */
>  			lp->dma_regs = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
>  			lp->rx_irq = platform_get_irq(pdev, 1);
>  			lp->tx_irq = platform_get_irq(pdev, 0);
>  			lp->eth_irq = platform_get_irq_optional(pdev, 2);
> +			if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO)
> +				return lp->eth_irq;
>  		}

The same check seems to have been added to both arms of the if/else
condition. So it seems to me that it could be moved out of that condition.

I would suggest placing it below the existing rx_irq/tx_irq condition
which appears a few lines below this hunk so that those and
dma_regs errors are still propagated.

>  		if (IS_ERR(lp->dma_regs)) {
>  			dev_err(&pdev->dev, "could not map DMA regs\n");
> -- 
> 2.43.0
> 
