Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE8B1F0E29
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784409602; cv=none; b=lEmow4WHcuE+Oj1MXQpKjV5+uJvn/u2PsEpMglLh1vaMcc9RtqgX3BZN1Nd8J+BWax5z2ofsWaSdJlR+1hgzx5rAabQipX0GRc0hYhpxTg1Ni8aorETtuCu6DX20fLqlIdl3BMQuRP1/4SB/KbuJbGBcwXFiW3XnaitpfNkQw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784409602; c=relaxed/simple;
	bh=KNf/PNzmSyouw7qN+42WOVQgxoop9tvO0PJ6IzvGgsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBJkykRbgyzGgSZjHwb9Y2pjD8Ohw82VzQiumXH6G/GhGzxA2pAgVRiY4lP68n2TlsoDJkas5NQv2JPH0TfQZsKfwsSQBu/AwHsEUsOs9PGc5CTTRquWAV66BkxD4Mz1LLt71t0QwWwOqPt3pl7eO0z9eyFVuBok8AqDI3B5iso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rHAhXEPN; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rHAhXEPN"
Message-ID: <94bed211-037e-419b-ac99-13ad2294dace@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784409597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWQRt1yyWv2hQUZxsLlJUn3faeVrzl7c/ruwfvfePz4=;
	b=rHAhXEPNjC8i59ukjtLt0bteaiubxrFvYwn0v4I4sPOyv9evnqXNGiN0e1nf+A/sTc1hM7
	UKd7TlsKZ+7ub/G4bVQ8Qk60rTjfUd5FEK6VGJ/3dMSwEiYI+DeKPUP5YwpXDi+fTbuO5M
	Ae4W/KlHsLDjnx2KZzx1hnUAhObyGc0=
Date: Sat, 18 Jul 2026 22:19:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: stmmac: Simplify ioctl handling
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>
Cc: thomas.petazzoni@bootlin.com, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260718143848.677531-1-maxime.chevallier@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260718143848.677531-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18.07.2026 15:38, Maxime Chevallier wrote:
> Now that timestamping is controlled through an NDO, we can simply
> call phylink_mii_ioctl() to handle ioctls.
> 
> The only functional difference is that phylink_mii_ioctl() ->
> phy_mii_ioctl() can handle SIOCSHWTSTAMP, but this no longer happens
> as this ioctl is not longer dispatched to the ndo_eth_ioctl().
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> 
> Looking at this, I'm wondering if we can't just get rid of SIOCSHWTSTAMP
> handling in phy_mii_ioctl(). Looks like we can ?
> 
>   .../net/ethernet/stmicro/stmmac/stmmac_main.c   | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 2a0d7eff88d3..562d20830b94 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6371,28 +6371,17 @@ static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
>    *  @rq: An IOCTL specific structure, that can contain a pointer to
>    *  a proprietary structure used to pass information to the driver.
>    *  @cmd: IOCTL command
> - *  Description:
> - *  Currently it supports the phy_mii_ioctl(...) and HW time stamping.
> + *  Description: Forward the PHY ioctls to phylink
> + *  Return: Zero on success or negative error code.
>    */
>   static int stmmac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
>   {
>   	struct stmmac_priv *priv = netdev_priv (dev);
> -	int ret = -EOPNOTSUPP;
>   
>   	if (!netif_running(dev))
>   		return -EINVAL;
>   
> -	switch (cmd) {
> -	case SIOCGMIIPHY:
> -	case SIOCGMIIREG:
> -	case SIOCSMIIREG:
> -		ret = phylink_mii_ioctl(priv->phylink, rq, cmd);
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	return ret;
> +	return phylink_mii_ioctl(priv->phylink, rq, cmd);
>   }
>   
>   static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
