Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732485;
	b=u+sVQIJ4aZg+YxKl+rxy6lBby6tVDC0xkp5ynKFioDgIstb0+c5BVQrlBcDa9waq52qx
	 KbL+nyt5kfuUrdhuFJX6NxCnqdJMhMDpHbvxb9unsgx1d/PQL61vpRYGBlLo97o4NudxI
	 XjBobBPZL9OtLb0z/kEibrbUUISqzOrGVyylQkHW+9aNEmq4cNAgMeTgx47/Z3Iz+JPJi
	 Mmvv1vBbannWeL4prGnd0d9TWKe8GOuMZIlnGDcBHowp/MhQbLrp+HSh2iEODbs0aYmBW
	 BRCeNbYeRuDomF8FqwO1Nfbj+uZql4wo+SpcXWzsw5SK5c5Rpx5L7cGykAKKr+fwkgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732485;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=NSuyTmjniSWOejfY3uajWqbb5139rRgHsE5HWygA6Uw=;
	b=N/HZdvk+Qhf1iCWDWZ8wh8JTwowBodxEp6mHPjoM5f+RU7mdUD6GYUukj+YTNSXu4DFE
	 /dNGBJDeAhJizRcoP7Mt67LJLnRhS5Z+9IWF4/mRXnzbKSC4mRwIYP9zvhcDR6LKEE/VF
	 noqSpTJGu3opwn+xQb1/Sj/9p8qBEOmI1PR+VOT9E5CGdWXWw7Q/fnvf+nH2us0qW9p2U
	 6h/o534RShqGIY+zcwgybyQPtD6w4ogHG83iJlQkDDNlQ4OcGSUGVToMaQXgRH5ZsV3UO
	 McQKYWa4t32QrdXSkdMSd2cUz47Sb0aotHcFyeFvfloPmAAAqwRha+mtu4QKxOtdczQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=XkBGcSmq;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC993606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 19:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC993606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=XkBGcSmq
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 664C11A143C;
	Tue,  3 Nov 2026 19:01:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 330956046C;
	Tue,  3 Nov 2026 19:01:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AAB47103290E8;
	Tue,  3 Nov 2026 20:01:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793732478; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=NSuyTmjniSWOejfY3uajWqbb5139rRgHsE5HWygA6Uw=;
	b=XkBGcSmqFZvfwl52qeYrnL6utSSl/uLAqSp6mk3uMMSkoOIuoDz2IVUcxxAAs7mj5Yzq0g
	FT+wnxxv7cnbuV4c7qbLpbD6PmRJvAnr1xhxEYvvV+nRsc54RbalVDE/n/zoUqCEl5Tvgq
	kWILRETvf3z7HndMoPf49wumcjc4wDt1yIn8QKTm3vPxer/U8bUEh215wE1qVfVR/UnzEY
	cXXvmdmMkd9I8Ce19ZXEUBAabeMdjq16qf0GQj5g4LASm0r+KJ5HMYU6TFfDOaLYfdfOtI
	XN3THCCCDRQkS2vs5vJBVnUkxsJAFTaUoTgkmu1PnJDaEi5zqi7gAKU3ASoUXA==
Message-ID: <5d71380c-9549-4563-9caf-df0784c77516@bootlin.com>
Date: Tue, 3 Nov 2026 20:01:15 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 4/5] net: mvneta: unwind a failed mqprio setup
To: Josef Schlehofer <pepe.schlehofer@gmail.com>, netdev@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, w@1wt.eu,
 linux-kernel@vger.kernel.org
References: <20261103125021.70845-1-pepe.schlehofer@gmail.com>
 <20261103125021.70845-5-pepe.schlehofer@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261103125021.70845-5-pepe.schlehofer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/3/26 13:50, Josef Schlehofer wrote:
> A failed mqprio offload setup leaves part of its configuration in the
> hardware. For example, when one max_rate is not a multiple of
> 10 kbit/s, the command fails but the TX queues set up before it stay
> rate limited.
> 
> mvneta_setup_mqprio() returns on an invalid queue range or rate after
> it has already mapped RX queues, switched the rate limit mode and set
> the rates of some TX queues. The qdisc then fails to attach and the
> driver is not called again, so nothing removes them.
> 
> Undo the RX queue mapping, the rate limits and the traffic classes
> when the setup fails.
> 
> Tested on a Turris Omnia (Armada 385). After mqprio failed on a
> max_rate of 10001kbit, TX queues 0-3 stayed limited to 10 Mbit/s and
> the VLAN priority map stayed set. With this patch neither is left
> behind.
> 
> Fixes: e9f7099d0730 ("net: mvneta: Allow having more than one queue per TC")
> Fixes: 2551dc9e398c ("net: mvneta: Add TC traffic shaping offload")
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/marvell/mvneta.c | 28 +++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 75d46349df37..d3a6bf8f383e 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -5299,8 +5299,10 @@ static int mvneta_setup_mqprio(struct net_device *dev,
>  		for (rxq = mqprio->qopt.offset[tc];
>  		     rxq < mqprio->qopt.count[tc] + mqprio->qopt.offset[tc];
>  		     rxq++) {
> -			if (rxq >= rxq_number)
> -				return -EINVAL;
> +			if (rxq >= rxq_number) {
> +				ret = -EINVAL;
> +				goto err;
> +			}
>  
>  			mvneta_map_vlan_prio_to_rxq(pp, tc, rxq);
>  		}
> @@ -5311,29 +5313,39 @@ static int mvneta_setup_mqprio(struct net_device *dev,
>  		return 0;
>  	}
>  
> -	if (mqprio->qopt.num_tc > txq_number)
> -		return -EINVAL;
> +	if (mqprio->qopt.num_tc > txq_number) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
>  
>  	ret = mvneta_enable_per_queue_rate_limit(pp);
>  	if (ret)
> -		return ret;
> +		goto err;
>  
>  	for (tc = 0; tc < mqprio->qopt.num_tc; tc++) {
>  		for (txq = mqprio->qopt.offset[tc];
>  		     txq < mqprio->qopt.count[tc] + mqprio->qopt.offset[tc];
>  		     txq++) {
> -			if (txq >= txq_number)
> -				return -EINVAL;
> +			if (txq >= txq_number) {
> +				ret = -EINVAL;
> +				goto err;
> +			}
>  
>  			ret = mvneta_setup_queue_rates(pp, txq,
>  						       mqprio->min_rate[tc],
>  						       mqprio->max_rate[tc]);
>  			if (ret)
> -				return ret;
> +				goto err;
>  		}
>  	}
>  
>  	return 0;
> +
> +err:
> +	mvneta_clear_rx_prio_map(pp);
> +	mvneta_disable_per_queue_rate_limit(pp);
> +	netdev_reset_tc(dev);
> +	return ret;
>  }
>  
>  static int mvneta_setup_tc(struct net_device *dev, enum tc_setup_type type,

