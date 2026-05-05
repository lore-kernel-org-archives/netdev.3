Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934BB3B2FCC
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 05:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777959428; cv=none; b=ElKR8rqvq30hN7jsMKt39L6LhLIvGNGoJ0Cc8Z4f354OWTuewXjimJlrGo2q9M2XydS2rpC+9ZcyYbRtyw0YmpDxy8QO8W3rk83jipEM1ruVhnEap6NxCtSIzniEIq7DtYGztNX7AG2MMgFfQIQ1z72FbThBtHVfcj3L3dNdSWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777959428; c=relaxed/simple;
	bh=w7dQK57+pO4cmDbX9FAl4uLfSMH4ddaq1KgiB3tb0+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYHu2VM4SvSChbMGptncmzgOrrWeHvgZk7FG7houE9k6O1rkvNkU7HvQWFVYV9x2hIyuHkCZAx1gB0ZCBaEcNF6ZAZx7ZDN3iehTIe4WMmmuxVNEUzPNitcuDViyDV94IYkBe+w6ECNwvg+NrFyZTVO5UABjROE1orAenDY/Kcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMKGNkLX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMKGNkLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FD9C2BCB4;
	Tue,  5 May 2026 05:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777959428;
	bh=w7dQK57+pO4cmDbX9FAl4uLfSMH4ddaq1KgiB3tb0+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TMKGNkLXRidii1NpLdfVStwvVqd/ZEqEf3zEbyy9/gCaeZpf82yg5OHn/QSY29kHs
	 xr+NHdYVwj0ta4m77b5TxFMz+oTW64lkR9nMbWOCDfjBCgXBIDRxI+jnR0PmawokC7
	 bOvvd67+J8RL/9l6paZBow5hb0dRGk8BEMP7fBSG+gf7aRTWdGztYSHJJSPya7OTtb
	 OofBCWpkhWsCa/MjGufIYmme2DMcD3nRV/Yq9OBEltGzRik7aKHaxvBRQuKneg2ikY
	 +A8NURQHyKqYHx+bAg1NIU5EVEmBrF+Bw51trnz1XE0ZQdCvfVJcLPKgO9yHV+c8st
	 270lBMnEIu4vQ==
Message-ID: <3e1a653b-81bc-4008-8f84-77c823aeef49@kernel.org>
Date: Tue, 5 May 2026 07:37:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
To: Holger Brunck <holger.brunck@hitachienergy.com>, netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, andrew+netdev@lunn.ch, qiang.zhao@nxp.com,
 horms@kernel.org
References: <20260504161145.2217950-1-holger.brunck@hitachienergy.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260504161145.2217950-1-holger.brunck@hitachienergy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/05/2026 à 18:11, Holger Brunck a écrit :
> When cleaning up the resources we need to iterate over the
> tx_skbuf array to free pending TX messages.
> 
> Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
> Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
> ---
>   drivers/net/wan/fsl_ucc_hdlc.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index adf3863463f5..68f78aeabdc3 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -739,6 +739,8 @@ static int uhdlc_open(struct net_device *dev)
>   
>   static void uhdlc_memclean(struct ucc_hdlc_private *priv)
>   {
> +	int i;
> +
>   	qe_muram_free(ioread16be(&priv->ucc_pram->riptr));
>   	qe_muram_free(ioread16be(&priv->ucc_pram->tiptr));
>   
> @@ -769,6 +771,11 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
>   	kfree(priv->rx_skbuff);
>   	priv->rx_skbuff = NULL;
>   
> +	for (i = 0; i < TX_BD_RING_LEN) {
> +		kfree(priv->tx_skbuff[i]);

I don't think you can just kfree() an skb like this.

I think you have to call dev_kfree_skb_any() instead.

Christophe


> +		priv->tx_skbuff[i] = NULL;
> +	}
> +
>   	kfree(priv->tx_skbuff);
>   	priv->tx_skbuff = NULL;
>   

