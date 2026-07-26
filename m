Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D7935C1B0
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785079298; cv=none; b=MR6J5Irhw+UCUbFdYXF80etB8WfI5CVuziN1z36tWkmiGs/XR4EISKcF4eF1eGWCKAlErKQW/G6mWNKUUXssOV3woRMLo2eFC6E4hMb8bFl9QFVhnxzVl/zNT2JgBn1BEFut1gVAggWLODPvZwBATEMAqRHFz9jHiXtyYy9vnu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785079298; c=relaxed/simple;
	bh=VStyXSBMtKL4jedSVP/8kZlFwmOzHzy0ptu37r45/Cs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GWTZniILo74dO35YzdOkkVWspUTENzK0Z7pohno5tkDBtxXakbw//h0r4LTlxpsVKnYtEViyu5LvOxrzDZTzxnAb/UmPFF2Z3FbK1SrI3c8f+LTp82/gPegOXruqnTtCI5/hyhXshUdRGKwuE9EvdDl+2Vns8siRnonp/lSBnEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBpp7CqT; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBpp7CqT"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6611669cd16so2266338d50.0
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785079295; x=1785684095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yfebmrOJjs/YI1migiLgSfl402sv2ryj/1JH/2bg1IQ=;
        b=FBpp7CqTJiy0Q6Deo/nQULJxygUXLD68yZ0J6WDPuR9IZc8ffZ2KASW5jpBK5/6L5D
         yb90KS3ImKzgwV8EB0svT5NelCuB2b/KLTyJpjtaXXlzwSryaR+CxMMEvCu2loI5qJaj
         n08l1Js2y1Wkvd765RYdI/o4jYoKR20gU8OUthfn7npJyI2Lhyolb2EBM6FgjiMtFboZ
         zlgV4F9OcyuahZiT7HcQttGuspRy2px6mC3lBx/MGBEteXdF0kXYUFGT4gmVup0fizKs
         IuLMVrmRzkD9jmLspyQ5Mb+xu//nYDOCEz51V5YzmuTKECecmnRjI8nnw4FQ5ybxTck8
         SvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785079295; x=1785684095;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yfebmrOJjs/YI1migiLgSfl402sv2ryj/1JH/2bg1IQ=;
        b=OtiQ2Ckxy++ZzHLYkBTgWcZz1HH6zS5mcNyRWkWDmbAID703paB772Xg/fEu1+VWA4
         ewBzrZIeip6YJJFZ2oGiTCZkc0k62pMUY7enJ1DStlYX+/VN6gWI+wI/0sZCzvUXus68
         t4AwAbh8c7qBzLzDYwT+Fn9WY4hlC4ZiYpFTkBLDayzNR6UI0F+qJByL16/nOagkR1ke
         TkyE7CxHt1gZHglHWnQuKr6iEJLd/2wUQS0t2HgRC7Rp5eDdssFgYiQ/HUrcmPb5k166
         WyzyNAb5AQdKn0Y9NvUzpCTfPOCJDcWmj1ytA5ys7YdPdUSD4+SHXMUIwSme9BKlRe3u
         60Dg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5mQOhvhLp4Salkl4o9yGkC0np/q+Its18bIm2O0GEgedNdHEj3rhbjOrf61A2Tat25XCNuD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRCZG19DmvqCcjE3vsl1+NSWwm+iaL9MdDGb6eOOZ5mOGHpjMT
	xzT5pQI4kaS2m7QOvaImNzA4SPbXHTnQg8NKshuOk+HrPclZ/xAk2YP9
X-Gm-Gg: AR+sD13ZxCI8FqMT3c+Uf9Le5nbqDrSyEGz4gu5deXzHT6FoAFm/b1+rSWYVC9O944G
	WqUxOWiJTYayU93u8nfhsJt33I3BX3/gLvmEYUmi89RIcsNQGhwDsCWYMP1Kd3DDFwQX37T4yZ4
	a1Buvj5Tc+mT8AjO2bdVGeXB1VnZKqjqC+/GPbd1+1nm8pcrWyjKouDUdzEyfjVNgdbB+Fnegv+
	4NBCnUhy6leqz3SwfDOE2RF0Bl0nKFrDYZo9sYMnWY7w3Zodabjib0B3MHY03/0Mjpu2kIfa5Wa
	mRiEJ77bNsVin6gxVctNtFybl4GPuvegsRc/BYgGMCbJwJGgZB5k+nVu17ZYZoieXdw6df30LzW
	mtgoHuR3WCZkR/AYrqmobPNrjDfLe7W2zLVOMaWZTxEsOCk3GiH9VMDsaPrSm5pXbYu4vRSa5zk
	AEQyFNK/pU4CKwoLRHjWwllAA6j0XRr27PNlZPcaWqBYR6k07qmg==
X-Received: by 2002:a05:690e:440e:b0:664:f064:f663 with SMTP id 956f58d0204a3-668c79ea511mr1177910d50.28.1785079295171;
        Sun, 26 Jul 2026 08:21:35 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c706a639sm2045717d50.21.2026.07.26.08.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 08:21:34 -0700 (PDT)
Date: Sun, 26 Jul 2026 11:21:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qihang <q.h.hack.winter@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 daniel.zahka@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 stable@vger.kernel.org, 
 Qihang <q.h.hack.winter@gmail.com>
Message-ID: <willemdebruijn.kernel.328be8a5ee86b@gmail.com>
In-Reply-To: <20260726092110.80185-1-q.h.hack.winter@gmail.com>
References: <20260721084935.12312-1-q.h.hack.winter@gmail.com>
 <20260726092110.80185-1-q.h.hack.winter@gmail.com>
Subject: Re: [PATCH net v2] packet: use consistent header lengths in raw send
 paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Qihang wrote:
> packet_snd(), tpacket_snd(), and packet_sendmsg_spkt() read
> dev->hard_header_len multiple times while allocating and constructing an
> skb. Device reconfiguration can change this value concurrently, for
> example through bonding device type changes.
> 
> For SOCK_RAW, packet_snd() can save a larger value in reserve and later
> allocate headroom using a smaller value. Moving skb->data back by reserve
> then places it before skb->head, and the following copy from userspace can
> attempt an out-of-bounds write.
> 
> tpacket_snd() similarly uses independent values for allocation and for
> the skb_push()/skb_put() operations in tpacket_fill_skb(). The legacy
> packet_sendmsg_spkt() path also calculates its reservation and header
> offset from separate reads before dropping the RCU read lock to allocate
> the skb. A larger offset than reservation can move skb->data before
> skb->head, while mixed TX-ring values can also make
> copylen - hard_header_len negative.
> 
> Read hard_header_len once for each send operation and use that value for
> RAW allocation and construction. The trigger requires racing an
> AF_PACKET sender with privileged netdevice reconfiguration.
> 
> The separate SOCK_DGRAM consistency problem between hard_header_len and
> header_ops->create is not addressed here.
> 
> Fixes: b84bbaf7a6c8 ("packet: in packet_snd start writing at link layer allocation")
> Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")

Not sure whether a patch can have two fixes tags.
Maybe better two separate patches.

> Cc: stable@vger.kernel.org
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
> ---
> v2:
> - Cover packet_sendmsg_spkt().
> - Limit snapshot-based calculations to RAW construction; leave DGRAM
>   unchanged for a separate fix.
> 
> Link to v1: https://lore.kernel.org/netdev/20260721084935.12312-1-q.h.hack.winter@gmail.com/
> ---
>  net/packet/af_packet.c | 64 ++++++++++++++++++++++++++++++------------
>  1 file changed, 46 insertions(+), 18 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index e75d2932475a..d23898f24641 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1953,6 +1953,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
>  	struct net_device *dev;
>  	struct sockcm_cookie sockc;
>  	__be16 proto = 0;
> +	unsigned int hard_header_len = 0;

Please keep reverse xmas tree ordering when not too inconvenient.

>  	int err;
>  	int extra_len = 0;
>  
> @@ -1996,15 +1997,21 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
>  		}
>  		extra_len = 4; /* We're doing our own CRC */
>  	}
> +	if (!skb)

Why this branch?

> +		hard_header_len = READ_ONCE(dev->hard_header_len);
>
>  	err = -EMSGSIZE;
> -	if (len > dev->mtu + dev->hard_header_len + VLAN_HLEN + extra_len)
> +	if (len > dev->mtu + hard_header_len + VLAN_HLEN + extra_len)
>  		goto out_unlock;
>  
>  	if (!skb) {
> -		size_t reserved = LL_RESERVED_SPACE(dev);
> +		size_t reserved;
>  		int tlen = dev->needed_tailroom;
> -		unsigned int hhlen = dev->header_ops ? dev->hard_header_len : 0;
> +		unsigned int hhlen = READ_ONCE(dev->header_ops) ?

Why add this READ_ONCE? Other header_ops readers lack this.

> +				     hard_header_len : 0;
> +
> +		reserved = ((hard_header_len + READ_ONCE(dev->needed_headroom)) &
> +			    ~(HH_DATA_MOD - 1)) + HH_DATA_MOD;

Now that this file uses this three times, it might be worthwhile
creating an LL_RESERVED_SPACE_EX(dev, hhlen) wrapper. And have
LL_RESERVED_SPACE call that. (optional).
>  
>  		rcu_read_unlock();
>  		skb = sock_wmalloc(sk, len + reserved + tlen, 0, GFP_KERNEL);
> @@ -2569,6 +2576,7 @@ static int packet_snd_vnet_parse(struct msghdr *msg, size_t *len,
>  static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
>  		void *frame, struct net_device *dev, void *data, int tp_len,
>  		__be16 proto, unsigned char *addr, int hlen, int copylen,
> +		int hard_header_len,

Inconsistent unsigned int above vs int here. Dev field is unsigned
short. Int is fine.

>  		const struct sockcm_cookie *sockc)
>  {
>  	union tpacket_uhdr ph;
> @@ -2600,8 +2608,8 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
>  	} else if (copylen) {
>  		int hdrlen = min_t(int, copylen, tp_len);
>  
> -		skb_push(skb, dev->hard_header_len);
> -		skb_put(skb, copylen - dev->hard_header_len);
> +		skb_push(skb, hard_header_len);
> +		skb_put(skb, copylen - hard_header_len);
>  		err = skb_store_bits(skb, 0, data, hdrlen);
>  		if (unlikely(err))
>  			return err;
> @@ -2732,7 +2740,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  	void *data;
>  	int len_sum = 0;
>  	int status = TP_STATUS_AVAILABLE;
> -	int hlen, tlen, copylen = 0;
> +	int hard_header_len = 0, hlen, tlen, copylen = 0;
>  	long timeo;
>  
>  	mutex_lock(&po->pg_vec_lock);
> @@ -2779,8 +2787,10 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  			goto out_put;
>  	}
>  
> -	if (po->sk.sk_socket->type == SOCK_RAW)
> -		reserve = dev->hard_header_len;
> +	if (po->sk.sk_socket->type == SOCK_RAW) {
> +		hard_header_len = READ_ONCE(dev->hard_header_len);
> +		reserve = hard_header_len;
> +	}
>  	size_max = po->tx_ring.frame_size
>  		- (po->tp_hdrlen - sizeof(struct sockaddr_ll));
>  
> @@ -2817,7 +2827,12 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  			goto tpacket_error;
>  
>  		status = TP_STATUS_SEND_REQUEST;
> -		hlen = LL_RESERVED_SPACE(dev);
> +		if (po->sk.sk_socket->type == SOCK_RAW)
> +			hlen = ((hard_header_len +

Here and elsewhere: why special case this only for SOCK_RAW?
This complicates control flow.

> +				 READ_ONCE(dev->needed_headroom)) &
> +				~(HH_DATA_MOD - 1)) + HH_DATA_MOD;
> +		else
> +			hlen = LL_RESERVED_SPACE(dev);
>  		tlen = dev->needed_tailroom;
>  		if (vnet_hdr_sz) {
>  			data += vnet_hdr_sz;
> @@ -2835,10 +2850,14 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  						    vnet_hdr.hdr_len);
>  			has_vnet_hdr = true;
>  		}
> -		copylen = max_t(int, copylen, dev->hard_header_len);
> +		if (po->sk.sk_socket->type == SOCK_RAW)
> +			copylen = max_t(int, copylen, hard_header_len);
> +		else
> +			copylen = max_t(int, copylen, dev->hard_header_len);
>  		skb = sock_alloc_send_skb(&po->sk,
>  				hlen + tlen + sizeof(struct sockaddr_ll) +
> -				(copylen - dev->hard_header_len),
> +				(copylen - (po->sk.sk_socket->type == SOCK_RAW ?
> +				 hard_header_len : dev->hard_header_len)),
>  				!need_wait, &err);
>  
>  		if (unlikely(skb == NULL)) {
> @@ -2848,7 +2867,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  			goto out_status;
>  		}
>  		tp_len = tpacket_fill_skb(po, skb, ph, dev, data, tp_len, proto,
> -					  addr, hlen, copylen, &sockc);
> +					  addr, hlen, copylen, hard_header_len,
> +					  &sockc);
>  		if (likely(tp_len >= 0) &&
>  		    tp_len > dev->mtu + reserve &&
>  		    !vnet_hdr_sz &&
> @@ -2956,7 +2976,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>  	int offset = 0;
>  	struct packet_sock *po = pkt_sk(sk);
>  	int vnet_hdr_sz = READ_ONCE(po->vnet_hdr_sz);
> -	int hlen, tlen, linear;
> +	int hard_header_len = 0, hlen, tlen, linear;
>  	int extra_len = 0;
>  
>  	/*
> @@ -2996,14 +3016,17 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>  			goto out_unlock;
>  	}
>  
> -	if (sock->type == SOCK_RAW)
> -		reserve = dev->hard_header_len;
>  	if (vnet_hdr_sz) {
>  		err = packet_snd_vnet_parse(msg, &len, &vnet_hdr, vnet_hdr_sz);
>  		if (err)
>  			goto out_unlock;
>  	}
>  
> +	if (sock->type == SOCK_RAW) {
> +		hard_header_len = READ_ONCE(dev->hard_header_len);
> +		reserve = hard_header_len;
> +	}
> +
>  	if (unlikely(sock_flag(sk, SOCK_NOFCS))) {
>  		if (!netif_supports_nofcs(dev)) {
>  			err = -EPROTONOSUPPORT;
> @@ -3018,10 +3041,15 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>  		goto out_unlock;
>  
>  	err = -ENOBUFS;
> -	hlen = LL_RESERVED_SPACE(dev);
> +	if (sock->type == SOCK_RAW)
> +		hlen = ((hard_header_len + READ_ONCE(dev->needed_headroom)) &
> +			~(HH_DATA_MOD - 1)) + HH_DATA_MOD;
> +	else
> +		hlen = LL_RESERVED_SPACE(dev);
>  	tlen = dev->needed_tailroom;
>  	linear = __virtio16_to_cpu(vio_le(), vnet_hdr.hdr_len);
> -	linear = max(linear, min_t(int, len, dev->hard_header_len));
> +	linear = max(linear, min_t(int, len, sock->type == SOCK_RAW ?
> +					 hard_header_len : dev->hard_header_len));
>  	skb = packet_alloc_skb(sk, hlen + tlen, hlen, len, linear,
>  			       msg->msg_flags & MSG_DONTWAIT, &err);
>  	if (skb == NULL)
> @@ -3037,7 +3065,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>  	} else if (reserve) {
>  		skb_reserve(skb, -reserve);
>  		if (len < reserve + sizeof(struct ipv6hdr) &&
> -		    dev->min_header_len != dev->hard_header_len)
> +		    dev->min_header_len != hard_header_len)
>  			skb_reset_network_header(skb);
>  	}
>  
> -- 
> 2.50.1 (Apple Git-155)
> 


