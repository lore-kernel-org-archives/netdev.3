Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0083BBA03;
	Wed, 26 Aug 2026 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787748046; cv=none; b=ok0eHbfSDb/ruZGk19v3s0kvUrfzUCAbQeWGn+Gy5rEHpBQZHeH7kCsF+CwqnRwJXHaXdZT77qUBi8EYyI28p9VVSvi2Tbey8CtXXWNwjsFcTj38JI0Bnpi1mSLIOpsWWMxVaTxRo4P36TPLSjMVJXgBg4KRRYLqov+OdkDRGRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787748046; c=relaxed/simple;
	bh=dRBxpPPRSE7spEVVW2w697q79bkolnfQL+y7K0AfSY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPRx4lrtuoP/zmeOrI9TP2nbX78rVaOWbGGX8Z1poa8PbB7H70Eo1enruxw/ruBKVSmJ3tODcxrcpEg9sqwBmKAgxdgnxSjixHqPLn+fQ0b1Xdiqz7QspRFjOWmSLN4NIxpAmEz+MA1QsawRZMgZ30qTJXMr+x0mIl/+u2V+k2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMTKjAp5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMTKjAp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55AB1F000E9;
	Wed, 26 Aug 2026 12:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787748044;
	bh=FNoOq3oz5G+s13+NhOO66qzBqD+uiNVHdmgLhxAzmMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DMTKjAp54I08Bqf5A3Lr7YslbctXtPO/Ulyvinh7GpVblr2FOMfaDdCyN9j97PSIV
	 jdbBEp7dHXBivzQMA3tvVmwp9voJ7k2WaiGgmGnYwsJZmIK0A31kvBmjy2YUH70VFP
	 dvPiwkUiA+7GDpH823QMSQ55ynQSJLfhHllUU9r5U580h3LEHfKfhrIsgPnQhzJbT4
	 9acNl/vwM31cC4qkUEEvsFb0bkhVPz+DM2JxnoeoeWLS8d5sliVBZbrb0+ky+O7u70
	 o5/m4aM1pXnh8pg/JqKh7JEoalD6fmBg1/mAbn1lPj6W5VTx8O5Ju8C5U68aIIdPWE
	 amQnBZEQHY72A==
Date: Wed, 26 Aug 2026 13:40:40 +0100
From: Simon Horman <horms@kernel.org>
To: phucduc.bui@gmail.com
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: mvpp2: Fix IRQ error handling
Message-ID: <20260826124040.GB22033@horms.kernel.org>
References: <20260824100758.31622-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824100758.31622-1-phucduc.bui@gmail.com>

On Mon, Aug 24, 2026 at 05:07:58PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> irq_of_parse_and_map() returns 0 when parsing or mapping an IRQ fails.
> The current code does not handle this return value correctly.
> 
> Check for a zero return value and return -EINVAL when the IRQ lookup
> fails.
> 
> Fixes: 591f4cfab38a ("net: mvpp2: introduce queue_vector concept")
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index ccc24a1301f2..1c50174c9f1e 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -5874,7 +5874,7 @@ static int mvpp2_simple_queue_vectors_init(struct mvpp2_port *port,
>  	v->sw_thread_mask = *cpumask_bits(cpu_online_mask);
>  	v->port = port;
>  	v->irq = irq_of_parse_and_map(port_node, 0);
> -	if (v->irq <= 0)
> +	if (!v->irq)
>  		return -EINVAL;
>  	netif_napi_add(port->dev, &v->napi, mvpp2_poll);

Hi,

Thanks for your patch.

As pointed out by an AI-generated review [1], although the current
condition is unnecessarily wide, it does correctly catch the v->irq == 0
case.

So this is a clean-up rather than a bug fix.
And should be for net-next, without a Fixes tag, rather than net.

Please also note that net-next is closed for the merge window.
I expect it to reopen in early September. Please don't post
patches for net-next until it reopens.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824100758.31622-1-phucduc.bui%40gmail.com

-- 
pw-bot: changes-requested
