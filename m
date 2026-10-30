Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380880;
	b=wpgPb4Kr2Dvwknn+RUeJKgBNoOaX60uHJn1lhsjreRd4L2v2TqTzGleAQjr/YkzDperI
	 U7BT3kCTOYNrAi9LtO7RWeBbatzEJPy5VKpy/Qfx1IMekByEsxDcdZF5Sdf/FiWTziwFC
	 3jCKekfeoLZZXl1SZgXUPU+xDoj1VxnnknwHR51/kasQbD3g005M3U0DsuJbX+2XyuTqt
	 Xmm8t9THJMszwGQvj5OSHbT4aLRPwn1VEAfhKU1CSnjbWZ/PehZFC3ben/e9fu+nddG4X
	 MZ6d0q773qGxfW2XhCoSuydPFewzQM9hy/rnUTSqceQ2cIFL2gr81+EVOj86nlVeEpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VxyF/d0tbyiABUKo5yoe5ji6zMNg4n+kmjLnR2dR3BI=;
	b=nkPxZiCWa93cREJWNKXFUbYW/KjPESptqWYLF0jAEsuAJFoEJiaQmvOCrBMH4k1tk0kN
	 D08UYvowlRHrO+nJyzYAcdHFum+oIXeXcClCBMJ/t9akycD4IkEiluycmmZWQ3f53sg5Q
	 KGF/rdSRFJ8Hsns3Itehdmw/Gw30LJkgPmlkHty44nxvrLVlFCR1nDlaxEa2UN60F4txm
	 C1GsJerQMSIyfi0m5tVsTvOJ0sAX8FPopIK/h6tFPxfPz0VhDM0ZSOkUDvpc3AAcozG5e
	 htdSRXgKzOTw7bs9BYcVkpycoAGwfMvt3wVVGbkcPCU86VF7orGcghnZnThBhot5kqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bxbf21FW;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCFA606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 17:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BCFA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bxbf21FW
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eafb65e169so678843e0c.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793380879; x=1793985679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VxyF/d0tbyiABUKo5yoe5ji6zMNg4n+kmjLnR2dR3BI=;
        b=bxbf21FWR2WYewpid++ZNkYFvvsreelnK1V1ZNObX9hYbbAhlD+5jvz1t1qw9izRxJ
         IHVrb+VOWJQjHqKUWA4alLUiYec5YGz4/iBEx/64gW1nMtk7HP2zO0Zn9QSXNE4dv8M4
         OsMoXyxxqRPCNV+DI/vnHfoqB7MUoqy3nfC1E1tgG1J/cwB9ArwTo23oUbziHmZKlAvt
         7Oz+8STex4eHXGUjo6f2Zz9lkDdbYPGKZ9SXnibUDM7SH5RshWyoeXmJxVmMk4aYmFh7
         smhuNbWtSoLMnnYnbPqWspN3wuC+i7pzX52eQCJxAqZB4/ZJeBpLnVa0D/3uJKwwO3ZL
         V2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793380879; x=1793985679;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VxyF/d0tbyiABUKo5yoe5ji6zMNg4n+kmjLnR2dR3BI=;
        b=L4UmFaibtVZNiXrLDB1zNqEWMpB+62M9KuXlh/RlK0HNDQ04hn/YvWamGScO/ALBYu
         UZaYYKfHzsTTu1LCI4rF/HXd6UjU6VTQ85TJbmSPgtxkshT6fizXdv0tVnAILCeNW1Hy
         wm4ciF6Drg3aLWRcF6Aqn7ozpxMx8ZWV9oKD4PIrQGfcPm+LQbGmBpLVZYhTCZsemr7s
         JRG8vg/0bvJAUlKuOmVEabfwDVL4OJI8d8MN0vs2a+iHhhmIGmT+JhKG3R70m4ZGc+zt
         W7PJTaiflG6O0ebDpHHlu1tR/Cky9S8eq9WqWEz3VQed/bj4dKPOwXIg49BF109JhjE1
         AQxw==
X-Forwarded-Encrypted: i=1; AKwUvBxRKREgggfJZ3i8ryeK2f/5lv8ikHEYhRtB0ro6LHdK61Kh6J8/dXhSucFvX7IwgA+UFSJQUA8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOKQu5yCejXWzirYrJdIKJ1zLzFNEP/8cQFlubdX74C2Att4bG
	0KHiqaiTuvkujGnaQ6449E1umJUz6++uiLaQNdAc+aIzsDZgQptdMiuXyG7EDQ==
X-Gm-Gg: AYBFou3IKGn/pdvWx7oTQTlKe3/JDeXxdtTVsUOjsLIZs7FcEbSEyMApDIaDGjpy0fc
	PJepeZ/RC0h3+avWHI5t9hdrB41d9C/8nn+PW4jzEgQTgn0uiaaU4vNqH+DNsjzNvLxjFPd0nTG
	jNpujUvSXoRTs9piJt0SV1aaaNv4aFzmHUeNiITcxEA+qpWzp9RTrIyu64yrD8mgVczv9SAcIb7
	yFlmq2ksXII+feTI/rLyc4XPL2YS5U8jR/S//V9spTK9RxCsLIyamVBAN8kX6ZR5B8IajPzJFbg
	1L4t9I/5NtsuKoy3P7q3456g7wdz9kcG9eLy9SPxJ+y26x8RKhKoWcP/tE/4+LUdvSU8Xt1E1Sf
	1J3Qn8pe92B5MIEx1pxVNQZ/Y8R88eiXq40EBeqEpVlkbbcVPMF8bf54R2jrRu37gOrATYlaONN
	pn72PQp7hu1FrxE6YEz02TVAsWnXtak2krJHjYwANyYY61SwDQGU3zOVsjSMCWo2yg7IzTAQp9u
	vFtMSi29k+Oir69YVr2KKsXY74fET1TJ6w4Y3C6fha0K8M6DGZMPtUjF02PLSoSDn3z1AMZJPzt
	gC/tJE3vL4b/mE8Xs+rbV+trDm585y0cmak9ADO4FVj3L3Uib969VKI0MDkXNK1UinGHl59PuBu
	a/TxvXW6oAkjwA3lCdUsPL5pGqWnSkP0oW1aUPMibenzm8TPxBo4KfAdH5LQAyMFFn7U0
X-Received: by 2002:a05:6122:3a03:b0:5ea:c722:b3a with SMTP id 71dfb90a1353d-5ec6871d778mr1795867e0c.7.1793380879159;
        Fri, 30 Oct 2026 10:21:19 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69803be7sm3127076e0c.0.2026.10.30.10.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:21:17 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:21:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jingxuan Xie <jingxuanxie@deeproute.ai>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev
Message-ID: <willemdebruijn.kernel.17d3748debf8b@gmail.com>
In-Reply-To: <20261030081704.251652-2-jingxuanxie@deeproute.ai>
References: <20261030081704.251652-1-jingxuanxie@deeproute.ai>
 <20261030081704.251652-2-jingxuanxie@deeproute.ai>
Subject: Re: [RFC net v2 1/2] af_packet: prepare the virtio header before
 reserving an RX frame
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jingxuan Xie wrote:
> From: jingxuanxie <jingxuanxie@deeproute.ai>
> 
> An RX virtio-header conversion can fail after packet_current_rx_frame()
> has reserved space in a TPACKET_V3 block and increased its packet count.
> Releasing the copy lock on that error path does not remove the incomplete
> record from the block.

Can you give a little more detail on the exact bug: what state does
not get reverted on error, and how problematic is this.

> Prepare the header in a local variable before reserving a frame, and copy
> it to the reserved frame only after conversion succeeds. Keep drop
> accounting, notification and copy_skb cleanup on conversion failure.
> This also keeps conversion out of the receive queue critical section.
> 
> Assisted-by: LLM
> Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>
> ---
>  net/packet/af_packet.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 823e0911c910..7b3e1e27f777 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2273,6 +2273,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	__u32 ts_status;
>  	unsigned int slot_id = 0;
>  	int vnet_hdr_sz = 0;
> +	struct virtio_net_hdr vnet_hdr;
>  
>  	/* struct tpacket{2,3}_hdr is aligned to a multiple of TPACKET_ALIGNMENT.
>  	 * We may add members to them until current aligned size without forcing
> @@ -2375,6 +2376,14 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  			vnet_hdr_sz = 0;
>  		}
>  	}
> +	if (vnet_hdr_sz &&
> +	    virtio_net_hdr_from_skb(skb, &vnet_hdr, vio_le(), true, 0)) {
> +		drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
> +		atomic_inc(&po->tp_drops);
> +		sk->sk_data_ready(sk);
> +		sk_skb_reason_drop(sk, copy_skb, drop_reason);
> +		goto drop_n_restore;

Probably prefer a goto drop_n_account_unlocked rather than open coding
that here.

> +	}
>  	spin_lock(&sk->sk_receive_queue.lock);
>  	h.raw = packet_current_rx_frame(po, skb,
>  					TP_STATUS_KERNEL, (macoff+snaplen));
> @@ -2388,16 +2397,9 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  		__set_bit(slot_id, po->rx_ring.rx_owner_map);
>  	}
>  
> -	if (vnet_hdr_sz &&
> -	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
> -				    sizeof(struct virtio_net_hdr),
> -				    vio_le(), true, 0)) {
> -		if (po->tp_version <= TPACKET_V2)
> -			__clear_bit(slot_id, po->rx_ring.rx_owner_map);
> -		else
> -			prb_clear_blk_fill_status(&po->rx_ring);
> -		goto drop_n_account;
> -	}
> +	if (vnet_hdr_sz)
> +		memcpy(h.raw + macoff - sizeof(vnet_hdr), &vnet_hdr,
> +		       sizeof(vnet_hdr));
>  
>  	if (po->tp_version <= TPACKET_V2) {
>  		packet_increment_rx_head(po, &po->rx_ring);
> -- 
> 2.25.1


