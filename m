Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A66248FF7B;
	Fri, 18 Sep 2026 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726425; cv=none; b=oi5m9yRn4zSAwNum6lWwMo4Uuh6Bv4z5udtve3jJkUpYR5ob0YdQ6xr5KVkmnjnTDipx9+wbK3eui6ID6VehFI4hl0cAiWrf3fchKpWyglra5dI3kP2LE3LVSLla/OxVbTAdpnXmaefsRDzQN9tP6YoIWwI6+FMXyMTM7IZpkvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726425; c=relaxed/simple;
	bh=5Qale/Ilj9b/8mjIgh9mb41N/S68J+xOwIsrz/LDITE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=M+vBnOTlYjVBT8X2hbLBwNShceyyT4rLZyAzrjjbjWsmrGqmhFiu3UhbjAnkB1CvTbwGKnP+kJ9/B+BHJ9S4PirfatcQjb7KuCU8emnxncEBE8ZBKg8hq+WzLiITD7YYYRO5/FR5WQgKyQSynglc3LhWE8O6HFXREg1EhSU79KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=6BT2ZTqQ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="6BT2ZTqQ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A522CA50C5;
	Fri, 18 Sep 2026 12:13:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789726420; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ql9lOJNtMse9xksugkuRueN+D3id6VIg7IPYaozhjTU=;
	b=6BT2ZTqQQQuboX49AlF+EtgQtCg//MblUgile+hUJbC+y9fm6qS+BB9YGxZobYLREWAaHq
	3iLQyFKj65LEe72vSHqFRr9zzT/s3462qXxGqxe7qf+zwNM5QpOIPF+1SV0uJEBekZupiX
	r4EdUDtdG9TLIGh3FIxO/9fxFwmYe4Zs0NpTqE6EhWY3bkXe/zERxxAz9naDOEo6AWCY2I
	5fsHbn61xDxy6aPrWMZPTuAw9jHP/OmkWE5JAW5DsMqirLTBeULOArsiuzKSSojf03r09G
	gp1ecJ4jUGfQYYkC1SxBNky/5BLH7Ke5VURq4nmO2IX5SjLe0pXujuuIfduVdQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 12:13:40 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Cursor <cursoragent@cursor.com>, Doug Berger
 <opendmb@gmail.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/8] net: bcmgenet: initialize u64 stats seq counter
 for all queues
In-Reply-To: <20260918000732.276506-3-florian.fainelli@broadcom.com>
References: <20260918000732.276506-1-florian.fainelli@broadcom.com>
 <20260918000732.276506-3-florian.fainelli@broadcom.com>
Message-ID: <315932fa99bb7269bbd3da089289a09d@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 18.9.2026 02:07, Florian Fainelli wrote:
> bcmgenet_gstrings_stats statically defines ethtool statistics for 
> queues
> 0 through GENET_MAX_MQ_CNT (4). However, bcmgenet_probe() only 
> initialized
> the u64_stats_sync seq counter up to priv->hw_params->rx_queues and
> priv->hw_params->tx_queues.
> 
> Since priv->hw_params->rx_queues is 0 across all hardware versions (and
> priv->hw_params->tx_queues is 0 on GENET V1), rings 1..4 have 
> uninitialized
> u64_stats_sync structures. When ethtool -S is run on 32-bit kernels,
> bcmgenet_get_ethtool_stats() reads stats from rx_rings[1..4], causing
> lockdep warnings due to the uninitialized sequence counters.
> 
> Initialize the sequence counters for all GENET_MAX_MQ_CNT + 1 queues.
> 
> Fixes: ffc2c8c4a714 ("net: bcmgenet: Initialize u64 stats seq counter")
> Assisted-by: LLM
> Co-authored-by: Cursor <cursoragent@cursor.com>
> Change-Id: I6c3debbd9fa5e7a151789fccf3d9a38db184f434
> ---
>  drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 7b089de9484e..055e1362173b 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -4134,10 +4134,10 @@ static int bcmgenet_probe(struct 
> platform_device *pdev)
>  		priv->rx_rings[i].rx_max_coalesced_frames = 1;
> 
>  	/* Initialize u64 stats seq counter for 32bit machines */
> -	for (i = 0; i <= priv->hw_params->rx_queues; i++)
> +	for (i = 0; i <= GENET_MAX_MQ_CNT; i++) {
>  		u64_stats_init(&priv->rx_rings[i].stats64.syncp);
> -	for (i = 0; i <= priv->hw_params->tx_queues; i++)
>  		u64_stats_init(&priv->tx_rings[i].stats64.syncp);
> +	}
> 
>  	/* libphy will determine the link state */
>  	netif_carrier_off(dev);

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
