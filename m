Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B243347C5;
	Sun, 19 Jul 2026 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784458469; cv=none; b=iDMdbiBbKbprNZHUFW37pdMYt91fvcbWhA/zbgLfJTwXVjNrUEud7ETtXbV5pi4/NJI0v9M0Qfu+GQY9YWIJ20qT1ZSsi5BzW3YH8FWYn3nwQgb0FVF0PVEjLrUjwxuiFOl+u7mKHpDCEXyajByLfrJ/Kky34bvxgWPWVHVDaVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784458469; c=relaxed/simple;
	bh=ritm/XWZBQgqFyF6+1biOaUI0sgx1ylKg+o4OEVSucY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=S2B8RDQEceu6XemEb92NqVjMzEqi1o6DqWa4xsPZU38voNubtNNslR7vW+6ifc0ipttympuvkwbo6IAuG+gcHtGSsZ4FQQJ5/OVGQWsfhfIz60H/qYCr7YkFzRCqNyGcciNwFhOZO9gdLMS1EEwPQsoSO2w1Nt4Ma+LE/7izfOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=byFYEUAu; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="byFYEUAu"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0E7CA5188;
	Sun, 19 Jul 2026 12:54:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784458466; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=s4dDpLABSIzeeir1TfYxMwOAYkWkN3D/SdZ9ELEpl9g=;
	b=byFYEUAuhXyRSmvpMf77YRwmTCXNRWCpwBGvcaQ6e91DtsonNrjUFAwXdd7zioLqXB0ZSe
	2fT/G02i6tvaRdNpams+PiHVVrjA3wopjS9X+K8VLjo7H5amz2CdCU7WMYDUybiQMx0YZ4
	cIb/+XBl3frBSyQZ41OOPJr5jGhQK70sRwpb01StcRlvK8kE7HV+cAN5RqB2SWqrHA34zj
	NMXhbE1Xzc6FhKbBufIJTEfvFPG4g8abAmNi1CWfccZqVOCC9SOxzEuwnpAQ7W1iBHmcfL
	9oP0NBi8W0YlK4l39TlR2i5vnwDzvjQ9qjs7mD4f1hZwWkHD9p7NU+oZpcw9XQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Jul 2026 12:54:25 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell
 King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Paolo Valerio
 <pvalerio@redhat.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 15/15] net: macb: use context swapping in
 .ndo_change_mtu()
In-Reply-To: <20260717-macb-context-v4-15-0acbe7f10cdb@bootlin.com>
References: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
 <20260717-macb-context-v4-15-0acbe7f10cdb@bootlin.com>
Message-ID: <92cbeee9aa88c7ecc3ec3d0477e5f4e2@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 17.7.2026 21:48, Théo Lebrun wrote:
> Use newly introduced context buffer management to implement
> .ndo_change_mtu() as a context swap: allocate new context ->
> reconfigure HW -> free old context.
> 
> This resists memory pressure well by failing without closing the
> interface and it is much faster by avoiding PHY reinit.
> 
> AT91 EMAC is handled differently as their buffer management is separate
> and they don't do NAPI. We refuse them (-EBUSY) to avoid implementing
> context swapping for them.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 5792647eb0a6..1de66f442c59 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3493,11 +3493,29 @@ static int macb_close(struct net_device 
> *netdev)
> 
>  static int macb_change_mtu(struct net_device *netdev, int new_mtu)
>  {
> -	if (netif_running(netdev))
> -		return -EBUSY;
> +	struct macb *bp = netdev_priv(netdev);
> +	bool running = netif_running(netdev);
> +	struct macb_context *new_ctx;
> +
> +	if (running) {
> +		/* Context swapping is not supported for AT91. */
> +		if (bp->caps & MACB_CAPS_MACB_IS_EMAC)
> +			return -EBUSY;
> +
> +		new_ctx = macb_context_alloc(bp, new_mtu,
> +					     bp->configured_rx_ring_size,
> +					     bp->configured_tx_ring_size);
> +		if (IS_ERR(new_ctx))
> +			return PTR_ERR(new_ctx);
> +
> +		macb_context_swap_start(bp);
> +	}
> 
>  	WRITE_ONCE(netdev->mtu, new_mtu);
> 
> +	if (running)
> +		macb_context_swap_end(bp, new_ctx);
> +
>  	return 0;
>  }

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
