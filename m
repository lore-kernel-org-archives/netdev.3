Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA3D3AA1B8;
	Fri,  3 Jul 2026 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075115; cv=none; b=Yj7MYbdfVo2wdBEYOPNT5QqGYspULi+7GwxbB3VmHHi7JD2fjwuVzXiXp48dlGo7p72aAuOMkT38Tx9sUwGslyrtA7O9bpjWx2K1bAzFzon2PR92RIQtwpRr26ImSiIMi7HXYbRBAQxFbYm4lAdWaKYyBSrlSZIiSW1+a0eUFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075115; c=relaxed/simple;
	bh=mv4CUaiy20JyZBC9/HLhP4Ha5j9eN7ZFQXCrlOl4vdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKtYbueuAE5F4XNk38v3eHoFUOEXAuKu8j0Aa8OAsl/p4oi4pp1LAOzlYBMtW99ZXDjfcSkg70vb89Deaf2JBmfiOOq4nOLXqNQ2C7tLt2kGVP0vWTLritFOyIkDwmaS9rFRr/TztMVUymjhe76fuYbtFbFOND0FlNPJrB0CfL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=D0+YIm/9; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="D0+YIm/9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1783074915;
	bh=3kc0UcNiuVtfRj2fQEtSPouO3fYPUBpFP5bwSpld9GY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=D0+YIm/9YcIPIEvApekjRh4qCdw6jnH7ilyOvtm1xkDkRYXkFWHYdY6vgRvwT/gwm
	 Scwo6g7cOi8GY0F36VnEtpkGzGKmJRbRFrUj654rJQ8BiVuYya5tXs83ivvHoYiWUd
	 D4wViMyKEQha3LPxL10/2y0AXSJmdTG8RujH+i1Q=
Received: from [129.217.186.105] ([129.217.186.105])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 663AZDXs022820
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 3 Jul 2026 12:35:13 +0200 (CEST)
Message-ID: <c5c38842-861b-449b-8a32-f6b5e9e73593@tu-dortmund.de>
Date: Fri, 3 Jul 2026 12:35:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] tun/tap & vhost-net: multi-threaded
 network performance
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Brett Sheffield <bacs@librecast.net>
Cc: regressions@lists.linux.dev, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org
References: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
 <20260701165359-mutt-send-email-mst@kernel.org>
 <ef33f0a7-f0b7-4bc4-9263-10d2b480d717@tu-dortmund.de>
 <akZGg96-Xu9VeGrw@karahi.librecast.net>
 <20260702185420-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260702185420-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/26 00:55, Michael S. Tsirkin wrote:
> Maybe it's the supposedly rare case? Does this change anything
> for you?

In the "rare case" we would have packet drops, visible by iperf3 TCP
retransmissions. But these packet drops don't occur as I stated before.

Also, we are still not allowed to return NETDEV_TX_BUSY here, because
run_ebpf_filter() and pskb_trim() could have tinkered with the SKB.

> 
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index bfa49fa9e3a1..bacd89460078 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1018,7 +1018,6 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct netdev_queue *queue;
>  	struct tun_file *tfile;
>  	int len = skb->len;
> -	int ret;
>  
>  	rcu_read_lock();
>  	tfile = rcu_dereference(tun->tfiles[txq]);
> @@ -1064,19 +1063,24 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  		goto drop;
>  	}
>  
> -	skb_tx_timestamp(skb);
> -
> -	/* Orphan the skb - required as we might hang on to it
> -	 * for indefinite time.
> -	 */
> -	skb_orphan(skb);
> -
> -	nf_reset_ct(skb);
> -
>  	queue = netdev_get_tx_queue(dev, txq);
>  
>  	spin_lock(&tfile->tx_ring.producer_lock);
> -	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> +	if (__ptr_ring_check_produce(&tfile->tx_ring)) {
> +		spin_unlock(&tfile->tx_ring.producer_lock);
> +		netif_tx_stop_queue(queue);
> +		smp_mb__after_atomic();
> +		if (!__ptr_ring_check_produce(&tfile->tx_ring))
> +			netif_tx_wake_queue(queue);
> +		rcu_read_unlock();
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	skb_tx_timestamp(skb);
> +	skb_orphan(skb);
> +	nf_reset_ct(skb);
> +
> +	__ptr_ring_produce(&tfile->tx_ring, skb);
>  	if (!qdisc_txq_has_no_queue(queue) &&
>  	    __ptr_ring_check_produce(&tfile->tx_ring) == -ENOSPC) {
>  		netif_tx_stop_queue(queue);
> @@ -1087,18 +1091,6 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  	}
>  	spin_unlock(&tfile->tx_ring.producer_lock);
>  
> -	if (ret) {
> -		/* This should be a rare case if a qdisc is present, but
> -		 * can happen due to lltx.
> -		 * Since skb_tx_timestamp(), skb_orphan(),
> -		 * run_ebpf_filter() and pskb_trim() could have tinkered
> -		 * with the SKB, returning NETDEV_TX_BUSY is unsafe and
> -		 * we must drop instead.
> -		 */
> -		drop_reason = SKB_DROP_REASON_FULL_RING;
> -		goto drop;
> -	}
> -
>  	/* dev->lltx requires to do our own update of trans_start */
>  	txq_trans_cond_update(queue);
>  
> 
