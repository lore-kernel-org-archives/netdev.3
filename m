Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089D33A2577
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678656; cv=none; b=sc1+S3lljsdaPJgu1Sy+NgVNTL4dODK9FwC3JmJ87tExNi/iVVg/qmZasbFEwV0V8nCUowqyynQEK8FAj5F2HYXT//KbhpsrKphx6LA/1zNtNeJFxGXn16KmvAud4OuCwIt93QNOFwGnla3x46Xthg2CySVmjaux8Shau013SXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678656; c=relaxed/simple;
	bh=rMNAi2AgDi1NBiTr89Ord7U5y/ThrBP3gmI618ezBrA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=oyipVvbUZyjWRNhfIIbtZRPiG9aZ/KNG/3tpw0988Expnh1g0D4IJeMNweJjBaBYMTbNSntiuCl/3auTYqcRrPvQ4jEmZN4nHPL52J8Deo2CB/Xqo3Q+9xhINvTl4SGnttCnPIJ4Otu/DveANvB44TQEHCr4pak1eApx5O6ja+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Y8A64Kl6; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Y8A64Kl6"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7128DA39EE;
	Mon, 16 Mar 2026 17:30:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773678651; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wpVHxs8zy+XUpbmCWveFnfH2aJvNj49E/UNL6+EVSHw=;
	b=Y8A64Kl6cB6XNboJ1u5EYtYKlwMpxgxRaai+tTDx9zaxHdP13lMiSjbxPuoxNUeD81lubq
	aKUjbQwmWxu/Vn9amCrIStnpqeDFGVsAmPK5WnunLdzCVFx1Z2v38JbJfCHo8+4LdzvTD8
	K0Tv8z9muoHCY5o8tEP+gF4t9cGLL7I/EHwubiOGDf8u1JUX/ccsMAUmtUw7ipOvNHtTVy
	sQb6Ffnk2yDiCJZRnu8cGinR5wnFV8rMcrDMtv8+KRS0pCm31PqtkXeI/VDD5vOvZaJFlk
	MdIPyfolZczfg1MzNrXB5kw/frDkxK2ikq+VgzYO8rDCpsOo5DazXUL7k7hWBw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 17:30:48 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Paolo Valerio <pvalerio@redhat.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v5 4/8] net: macb: use the current queue number
 for stats
In-Reply-To: <20260313201433.2346119-5-pvalerio@redhat.com>
References: <20260313201433.2346119-1-pvalerio@redhat.com>
 <20260313201433.2346119-5-pvalerio@redhat.com>
Message-ID: <500d698680fb51285f78fa68b6e41875@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 13.3.2026 21:14, Paolo Valerio wrote:
> gem_get_ethtool_stats calculates the size of the statistics
> data to copy always considering maximum number of queues.
> 
> The patch makes sure the statistics are copied only for the
> active queues as returned in the string set count op.
> 
> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 06ad8c8ec036..fbeaa85b4a9c 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3528,7 +3528,7 @@ static void gem_get_ethtool_stats(struct 
> net_device *dev,
>  	spin_lock_irq(&bp->stats_lock);
>  	gem_update_stats(bp);
>  	memcpy(data, &bp->ethtool_stats, sizeof(u64)
> -			* (GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES));
> +			* (GEM_STATS_LEN + QUEUE_STATS_LEN * bp->num_queues));

This is an out-of-bounds write, not just a cosmetic change.
gem_get_sset_count() returns GEM_STATS_LEN + QUEUE_STATS_LEN *
bp->num_queues, and ethtool allocates the data buffer based on that 
count.
The old memcpy with MACB_MAX_QUEUES (8) writes past the end of the
buffer on any GEM instance with fewer than 8 hardware queues.

KASAN confirms on RP1 (1 queue) without this patch applied:

   BUG: KASAN: vmalloc-out-of-bounds in gem_get_ethtool_stats+0x50/0x78
   Write of size 760 at addr ffffffc0822e7000 by task ethtool/922

The overflow stays within the vzalloc page slack, so the practical
impact is low - but it's still an out-of-bounds write that exists in
the current upstream code. Might be worth splitting this out as a
standalone fix targeting net with a Fixes: tag, and updating the commit
message accordingly?

>  	spin_unlock_irq(&bp->stats_lock);
>  }

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
