Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBD9316190
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781738395; cv=none; b=nEIzgY9knNvYDqT6VarmgKMMWN+eG4MO4qRX3Gb8h2P0ncciMEeBF5m+8ztXVwq1RtNFQv82unnufu+ZjL+TswbXzNm3I0p4ex16GXY0JDYbotsBsZn48Nu1Rkd9sw8IewO1ZsHlkXjoBKEeU9gp3Yfz4UFfQmIer1ZCvgC2bzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781738395; c=relaxed/simple;
	bh=ncPJv/ZQKsT9F9q2L+mNKzYQwm3HQR5oyGmUgGhwwsg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mB2RF25BKVy+OaIopfoPf+LN8ZINnhKIIFxSHG6M1/OaaAddVU5+IuWM2LlGOoESueZqYVW5vCBZA+uvlihoE35mELEjbua2qUpghUIxAeqZfCSiY5WoeU1tJMfwJlvpS1dTdOCT4NFcqweENnebrrhEYdPFm4mb1doE6jn0jn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrWJbfoY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrWJbfoY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A7C1F000E9;
	Wed, 17 Jun 2026 23:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781738393;
	bh=lwVDvYzjQxyECx1yVb/9X3JuzhEAdvMppJ0CKYONVrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SrWJbfoYeMhjv1FkuFksigLZtgltUzGa0+7XY9K5aysrUf+m+qvzNq1nt+IAszAdV
	 3zAZwMrMmVOMX7PmmkbKWHcb4DcO5059TI+hSkn8Rl1UzsAAzJ2R02pYBD4cDEt8kh
	 QumZ96mHoXVKTezMTYubxBCyrCNx686fuJCzTcihcQ0XDwz6O1tX6NItMnZp30qMku
	 89GnIzeYVo2Xioj1CwQw44AsfK5yVFQIlTAU4LV2L5gtEt/iJxPBPI0IPygeJrjxgX
	 QkMsH+zqRMo1vPhkTTAk4NEPlP9yijDaOFB+F0wB8EWpPpY3MlWETxwxNTcdXAWtKY
	 gRUwMHbC+9eBw==
Date: Wed, 17 Jun 2026 16:19:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: lorenzo@kernel.org
Cc: Wayen Yan <win847@gmail.com>, netdev@vger.kernel.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v3] net: airoha: Fix skb->priority underflow in
 airoha_dev_select_queue()
Message-ID: <20260617161951.52abe413@kernel.org>
In-Reply-To: <178161373805.2167512.2544164327472822616@gmail.com>
References: <178161373805.2167512.2544164327472822616@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jun 2026 07:30:54 +0800 Wayen Yan wrote:
> In airoha_dev_select_queue(), the expression:
> 
>   queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES;
> 
> implicitly converts to unsigned arithmetic: when skb->priority is 0
> (the default for unclassified traffic), (0u - 1u) wraps to UINT_MAX,
> and UINT_MAX % 8 = 7, routing default best-effort packets to the
> highest-priority QoS queue. This causes QoS inversion where the
> majority of traffic on a PON gateway starves actual high-priority
> flows (VoIP, gaming, etc.).
> 
> Fix by guarding the subtraction: when priority is 0, map to queue 0
> (lowest priority), otherwise apply the original (priority - 1) % 8
> mapping.
> 
> Fixes: 2b288b81560b ("net: airoha: Introduce ndo_select_queue callback")
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Reviewed-by: Joe Damato <joe@dama.to>
> Signed-off-by: Wayen Yan <win847@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 31cdb11cd7..d476ef83c3 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1933,7 +1933,7 @@ static u16 airoha_dev_select_queue(struct net_device *dev, struct sk_buff *skb,
>  	 */
>  	channel = netdev_uses_dsa(dev) ? skb_get_queue_mapping(skb) : port->id;
>  	channel = channel % AIROHA_NUM_QOS_CHANNELS;
> -	queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES; /* QoS queue */
> +	queue = skb->priority ? (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES : 0;

Hi Lorenzo, is there a reason we're subtracting 1 here in the first
place? Could be just me, but may be worth adding a comment here.

Intuitively if we are "narrowing" 16 prios to 8 queues it'd make most
sense to group the adjacent ones -- divide by two.

Please respin with some sort of an explanation..

>  	queue = channel * AIROHA_NUM_QOS_QUEUES + queue;
>  
>  	return queue < dev->num_tx_queues ? queue : 0;
-- 
pw-bot: cr
