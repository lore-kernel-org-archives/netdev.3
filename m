Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0431F03D2
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769268985; cv=none; b=daXkWZGP7TnYoqiEPfZiZKFNbJ73oNUJxVGHVUf7hD6E31kUO3uuWzFywOb7OdUh0zq9FQ1JSaS5098jolMdWl1u/nn/xVaTVmkSvA8qZjZyjUnufpz+o//EzDJdixVZGx9THHLyPu2IdshdTVl27QXsIKkJqNxNnuoqPEG5eCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769268985; c=relaxed/simple;
	bh=tt3ICgihB3ll2W95De8w+7bU3+Au6XTjFxYRLdmZUQ8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DILMt7ztOXTNClcq//DaM7ynEDQk48rUP6YK4fLeNp3aI5oMCQd3Q+Tmamz+kAIKAHwbr3STpTCflDTMZFiBiPUF1YxSPFU+IjbZLYc4cjHFlSzNnJ7sQLCBQVmQGsXD1FDgckQgUtIJefOR1PPi9KaY+w1czOzheYXnoHjb+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz1WmLTO; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz1WmLTO"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-790ac42fd00so32379777b3.3
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 07:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769268983; x=1769873783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZffbMRjY10Ecny24h62HzMsaRiu2djFlqj+rY4gDlM=;
        b=Lz1WmLTO/PVKudqfSumD5IznC583tqbXO7BwXpz6yJsjImGjGmgnL0oWM8ziAJAWaw
         t1HHngxHgDdfDJ/X/4/cd8VCXDnC2r2KJOQ5hfSAiz/BHXt0fkmlGHwlikF79PRMhPTI
         9WUWHk7pNsX2Mmqmgn5Otre2osvGsK9PPisWAfkgh2t7ZW17mbu04AQQueZb0zehQ5ji
         sIAu7Mz2ADZjJsR7NoYz2Rurl3I7JHDREDFXJRsRhUDeHR86Rd8RlastEkey2BOKK1NN
         lAkSyk+MMAcT1vof8C3hhxHBY/gNH71AINXkPLe9TW/RZkPdYulcBmciNkLuhu/CLc06
         kl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769268983; x=1769873783;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZffbMRjY10Ecny24h62HzMsaRiu2djFlqj+rY4gDlM=;
        b=A1v2QvnQ6OfRL/qnTcONQThoHr3TfEd4CHMeNHsdvthNQKpEH4e7absh+QLo47IU9u
         qIMuro0fZUMuvJLUDDTVD4rUxqMc4hgK+8weqIk7rCk4hm49XKKG8BJwNRUILk06BWBx
         0JrInBd1pSulX5l62EQgzLvHT89wX81spQs+TxlmFdQzCE/kxXJISZCL1K+pnxsqIglx
         QzPGSNJfOTdPOb0oZZFiHSSkXPOJY7IORTihTTbHsokeMOZGCSsShHthn3oUwf2Fjr8M
         qclf5avY0bRC8Lema930n5llCzy2nqp9Q4MLOlzCmh8hxH8o9QjkykqHCsXfs64Qblkb
         +cXw==
X-Forwarded-Encrypted: i=1; AJvYcCVYNaxiV9KQ0sJJQZK2OqWg2rsIU2pRParV3ecNnU0f6VGYzvi9CpfPoGAahSGVKgL08+5FPyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYTGzdvP2G9oOOrE3tMa5zievjv68D9PituMZAzFsqcx31hfQ/
	seqJsyMfWhdmTaOiSa9/5ZWfj6z7HXD11R1Mb0duSowbllDHtmJYfI5M
X-Gm-Gg: AZuq6aL+FrKcRFZEQ1QoiqDMAdZYBLUrrHvZVacydrZAp9PK2nmRFUrRBnGFB+m70BW
	7fIUaYH5m0B3bbbSStKgthcawzDMoMzTUHsplS9AewStbUSx11gP8AnZQSkmQMsqWFmuyP+KACq
	RSMCs1jLGfOV0x5IOQNrGaMwQsjBRPA/CIcFMOIPZ1w0vS7Op399JcAAyhQljZxLkPoK7n16gUm
	lb4qgrW94vexaz1mK0/koRLue/HNc9rHR/jV0aGbRFbDX0Oo+9YQFq+8+P9vFvOnWTJfzfilA8k
	eMouU05HRiYqprgK5vMryOVwtCMkDEimUwV3Gb2HY4AoH2NPWm0tp8TmIoF7SFOCjmW/WcxhMEI
	Sc9xMqpcndHWeXMHMWRP2vxstTtdZjFhL075h+PnC7qOZjoby6FKDTK125/O6KVoEDrhoXN2Ha9
	U2w4+4D4YNyJosWODPGFtUPDMKISpjPWn/Ax7uXutYCLHst5c5z3yvzPXKvsY=
X-Received: by 2002:a05:690c:e3eb:b0:793:c9d4:3c8c with SMTP id 00721157ae682-79439795ecamr128848537b3.0.1769268983284;
        Sat, 24 Jan 2026 07:36:23 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7943b2ba803sm25613717b3.39.2026.01.24.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 07:36:22 -0800 (PST)
Date: Sat, 24 Jan 2026 10:36:22 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Mahdi Faramarzpour <mahdifrmx@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 kshitiz.bartariya@zohomail.in
Message-ID: <willemdebruijn.kernel.1575664f1b7c9@gmail.com>
In-Reply-To: <05b086b3-c82d-4aba-b185-2d39ba968a72@redhat.com>
References: <20260122185357.50922-1-mahdifrmx@gmail.com>
 <willemdebruijn.kernel.1682586fd684e@gmail.com>
 <60ed19a1-97e1-4342-8dfc-a5db684afa6f@redhat.com>
 <willemdebruijn.kernel.2b69585efeb5a@gmail.com>
 <05b086b3-c82d-4aba-b185-2d39ba968a72@redhat.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in
 udp_prod_queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 1/23/26 3:41 PM, Willem de Bruijn wrote:
> > Paolo Abeni wrote:
> >> I think that doing the SNMP accounting in __udp_enqueue_schedule_skb()
> >> (for `to_drop`), __udp_queue_rcv_skb() and __udpv6_queue_rcv_skb() (for
> >> `skb`) is a little confusing and possible error prone in the long run.
> >>
> >> I'm wondering if something alike the following (completely untested, not
> >> even built! just to give the idea) would be better?
> > 
> > I don't see the error prone issue with the simpler patch.
> > But SGTM if you prefer this.
> It's not a big deal but if we need to update the UDP MIB someday having
> to look in different places could cause missing something.
> 
> The code I proposed could be made smaller with something alike the
> following (still completely untested), which in turn looks quite alike
> what this patch is heading, I guess. So really it's not a big deal.
> ---
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 1db63db7e5d4..431de8dda0d3 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1793,6 +1795,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk,
> struct sk_buff *skb)
>  		}
>  	}
> 
> +	atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
>  	if (unlikely(to_drop)) {
>  		for (nb = 0; to_drop != NULL; nb++) {
>  			skb = to_drop;
> @@ -1802,10 +1805,9 @@ int __udp_enqueue_schedule_skb(struct sock *sk,
> struct sk_buff *skb)
>  			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
>  		}
>  		numa_drop_add(&udp_sk(sk)->drop_counters, nb);
> +		return nb;
>  	}
> 
> -	atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
> -
>  	return 0;
> 
>  drop:
> @@ -2345,6 +2347,9 @@ static int __udp_queue_rcv_skb(struct sock *sk,
> struct sk_buff *skb)
>  	}
> 
>  	rc = __udp_enqueue_schedule_skb(sk, skb);
> +	if (likely(!rc))
> +		return 0;
> +
>  	if (rc < 0) {
>  		int is_udplite = IS_UDPLITE(sk);
>  		int drop_reason;
> @@ -2365,6 +2370,9 @@ static int __udp_queue_rcv_skb(struct sock *sk,
> struct sk_buff *skb)
>  		return -1;
>  	}
> 
> +	/* rc > 0, packets dropped after dequeueing from prod_queue */
> +	SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_MEMERRORS, rc);
> +	SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_INERRORS, rc);
>  	return 0;
>  }
> 
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 010b909275dd..df895096669e 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -793,6 +793,9 @@ static int __udpv6_queue_rcv_skb(struct sock *sk,
> struct sk_buff *skb)
>  	}
> 
>  	rc = __udp_enqueue_schedule_skb(sk, skb);
> +	if (likely(!rc))
> +		return 0;
> +
>  	if (rc < 0) {
>  		int is_udplite = IS_UDPLITE(sk);
>  		enum skb_drop_reason drop_reason;
> @@ -813,6 +816,9 @@ static int __udpv6_queue_rcv_skb(struct sock *sk,
> struct sk_buff *skb)
>  		return -1;
>  	}
> 
> +	/* rc > 0, packets dropped after dequeueing from prod_queue */
> +	SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_MEMERRORS, rc);
> +	SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_INERRORS, rc);
>  	return 0;
>  }
> 

Honestly, I don't see this plumbing of nb as simpler than incrementing
the counters right where nb is known. All it takes there is to make
the second arg to UDPX_MIB conditional on sk_family. But again I don't
care strongly, so SGTM if you do.
