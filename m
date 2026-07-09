Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB0F369D53
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783640758; cv=none; b=UVtYSF1gvKARWheEDTTc3kyRmnetjcpO2DkIyINaZqCOTG9rdZv6kTWtM/LbeHqsyy+RnwBdGzymSJ4yyf80teL3b9kjUDIKTEoU0TyNn+1yUEF6LzmWJB7JH7WHyZzGyuEh0RWrbWpJvMcYSnUzxOTgWhk6YmsaxzSLi4wo9VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783640758; c=relaxed/simple;
	bh=nlIg5x7anqDBQMu388OtksuLnLD8T3RGies+6A83+ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMnfzT4Zx+jRcyWqyrrBOZqLK2HyqCxbBx9SZYJRTO0jTY4xtMwLO4sh/A6/OkuUO1eIdDm6SW+h3QwlZ+eEJzQa6aU6iwXrmSK5TLjdYxD5Ta0bTLjjbVGr7a2oU6ZNEH/DPJNEPPC2Pn+Eh/nITaYJVhiLB7vJpyGWqrYJUBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vj+b+enF; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vj+b+enF"
Message-ID: <cbfa2b2b-0ae8-9c96-f177-b503239edbd0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783640744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wApSrp6MTVqs7aphdKyFAmDNEaX42wQebm1xD53pY4A=;
	b=Vj+b+enFOniBw0Z0bHOxrXpqqP8HpHA5AIcJ46O8owaLluPu33WFj6jRScMvhHX6y0oa4N
	Nne73IznojLbuZfbYxFHzVcMV2/MzaGxcF8Hnpu24VBAXaHSmx7Fz6qrvZX85gPWwsb22B
	gk7oUV73y/GXqqIV0GEpEFYkBLeL1iM=
Date: Thu, 9 Jul 2026 19:45:40 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: dpaa: always set a valid mode I/F mode
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260706121011.1948906-1-mwalle@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260706121011.1948906-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/6/26 08:08, Michael Walle wrote:
> Before converting to the phylink interface, the init function would have
> set the correct mode in the maccfg2.

So for reference, the old logic is

        if (iface_speed < SPEED_1000)
                tmp |= MACCFG2_NIBBLE_MODE;
        else if (iface_speed == SPEED_1000)
                tmp |= MACCFG2_BYTE_MODE;

which changes between nibble/byte mode depending on the max link speed
(e.g. phylink_interface_max_speed). Notably, neither is set for 2.5G.

Can you try moving this write to dtsec_mac_config? And check in the RM
whether this is configured based on the interface (in which case we should
remove it from dtsec_link_up) or the link speed. And please also check what
the correct behavior for 2.5G should be.

At one point I had the P-series RMs downloaded, but it appears I've misplaced
them...

--Sean

> After converting, init will just
> set 0 as the mode. According to the "QorIQ Data Path Acceleration
> Architecture (DPAA) Reference Manual", this is a reserved value. In
> fact, this will prevent the PCS to establish a link to a connected SGMII
> PHY. In turn, mac_link_up() is never called. Fix it by setting a
> non-reserved mode; mac_link_up() will then set the correct mode later.
> 
> Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> FWIW, I've tested this with a Marvell 88E1112 PHY.
> 
>   drivers/net/ethernet/freescale/fman/fman_dtsec.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
> index fe35703c509e..566921d3a884 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
> @@ -402,7 +402,10 @@ static int init(struct dtsec_regs __iomem *regs, struct dtsec_cfg *cfg,
>   	tmp |= MACCFG1_TX_FLOW;
>   	iowrite32be(tmp, &regs->maccfg1);
>   
> -	tmp = 0;
> +	/* write a non-reserved mode, otherwise the PCS won't establish a link
> +	 * and .mac_link_up() is never called.
> +	 */
> +	tmp = MACCFG2_NIBBLE_MODE;
>   
>   	tmp |= (cfg->preamble_len << MACCFG2_PREAMBLE_LENGTH_SHIFT) &
>   		MACCFG2_PREAMBLE_LENGTH_MASK;

