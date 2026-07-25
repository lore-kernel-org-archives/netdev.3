Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F62F1FE3
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784965574; cv=none; b=E0DD82MJxr144jXu0XKnoXvFfG3T/TkBxSMjzVEOiKLjcmUyYT+zicavab66NwasPxXsMEEo5ehARyXb+osMJzo6+f6lTYev0QK2y+v40GG+0NlbA35HwM5X7jhclk2Iq88/GMjxxzWBE7i1uzPOZivLfVji23/klgasTgOjuF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784965574; c=relaxed/simple;
	bh=5OVQlVYe2jv+wEYK1liAv5L/mkNj8Al5Qnr2AyBTr+I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=h6x3bO/0XLfAHUQmCniyo4eNZSAT2vJaeixX+YapkUGRzg5wBL5WZzAPH/G2nZiBBlMc5SuBVtByjVnFq7K9DlDEqQq8XkW85G8dlMqF9BIX9HRM9IEaTRCaLSVHn/acA6VrOLVqxPcLlh4v36OBF6xoPVsfbHoCXebH7Y7vQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEBReZ8g; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEBReZ8g"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66843304cbaso1345140d50.2
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784965572; x=1785570372; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K5kSd1k8vO99vMXYvgUXMROeYIo+K1uhrvqwiQkFcJ4=;
        b=KEBReZ8gejgJ0vUOp6rKdrn8OYTZLicKJnyraak560maouyN5LqcjS5v4429Ift6L2
         gkGE0KiYNIs8joWlma2R2HhgFwm1LKIZiwathEAxCpHWY7bw6QZlMwLN1rvIx2vQ3ZvW
         Ihu8akQGQBxinsSAUlQT9J8Otjo86KWRQOWtIKxIjAGcSbc1yAVciIr8+LJP1Zol4bEY
         sT12pZGShkGdx3GT/sEbluhBIbwlwjPrWIfO8d7KfZ7RLp0Mot9NF4A+NTFHwRsW5u00
         y9voFSTgOJ9SmBBEeIhzWa8eHVYPrSD/WWPzLMyNOvN94bfxugA+ljL+jIPUFS0bQF8p
         aBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784965572; x=1785570372;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K5kSd1k8vO99vMXYvgUXMROeYIo+K1uhrvqwiQkFcJ4=;
        b=ih1kR0pufsQVGE/75803goVypFX7/VN+NqT1RqlGhKTfQ46k7Mzbpg1/8DbfHHY+8r
         g7j4D4QvpKDA/lMTpoCEuk53Yuec5R/XBvBlL+8CZ/EgP0q6t7MqH025yZhQesXNuUQk
         7zw4VInmFZhLoikYcVb0evvuv7MmplqjQGfUQJiEafZUm8j3wkdRBDD012XqDI0LDr6p
         +1abpbBNBiiFcL0mG64DNLWUF2jpnoHC9VEpB2CfUU0ExU4pZpWa0f+GL96l/JyngeL4
         fQBNoCqUN1MUCjOG5nyX8dt3QNmMjmcejlJXp08BTRS7Fy/CowjYqIO+pDwh4RxCkEsz
         bUPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRr6F0QgHDe93s36tVQ7qs8P3/wrEv+N2qKhdk8Cwd4LdOtSETlJZm+E9H+kGQ/VVg182B96E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE66TGGDXlqa9joiAvQXA2NxqbvvD4aniXYTlyfCv+6xztVA/y
	X+9Q2lZRhbZlgwKtcZKyVoS7teTyRRwvJaH/RYvXFjjgwdUl7Umhsar+
X-Gm-Gg: AR+sD13w99Za8xuFxzY+F7MFSlwz1t8AeSq0Xrr9vVLldA7090M8s0sAnUd2DsxH/MA
	EJxxvxvIAJO9rg3c8oNEKqQh4Bn9t/ktnOK8FsRhhbMy5rotvoxNV0J3o+g6bq7cIM4AEHYlU3A
	HbCb9lU3Dj+PyD9JLg19QLf0wW8G67Yd1WYpPHINVBQztBu5VlZhWPqdDi6uFJABj7atGKv32gw
	/Dq6QJ/dzR4cqo7R4HiU5mbEaeBpoMs+ICZjDlXaYXWzT9lMQQvE5bE1egPPVKV/gBjRS62Rl6c
	Am+5dcw3E8IK1Xt75qcS1UXSw6xLcJ8IOGe0M3PdoKqD5MUjFmn61c6zFgHeEofRnbkWFdLsLaK
	a8WcS6jiRpnG+MlZcQCceSqxYjQuManClzMuygiZ73K2j2uR+yPe3n+shZd51FivyVd4Vj7bkyg
	bEUGWZ6IV77hxEaNcZBZJywjAf0+uhrLLgF3baZRbNe0QOM0Chk04WGaGYQOlT5tYs2Q==
X-Received: by 2002:a53:d045:0:10b0:668:311a:d444 with SMTP id 956f58d0204a3-668c7c31410mr275480d50.106.1784965572388;
        Sat, 25 Jul 2026 00:46:12 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c70698b7sm535928d50.20.2026.07.25.00.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 00:46:11 -0700 (PDT)
Date: Sat, 25 Jul 2026 03:46:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Doruk Tan Ozturk <doruk@0sec.ai>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 sd@queasysnail.net, 
 Vladimir Oltean <olteanv@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.d5ba4e62d4d2@gmail.com>
In-Reply-To: <20260724144015.63219-1-doruk@0sec.ai>
References: <20260724144015.63219-1-doruk@0sec.ai>
Subject: Re: [PATCH net v2] net/packet: reset the MAC header on the
 packet-socket transmit path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Doruk Tan Ozturk wrote:
> packet_parse_headers() resets the MAC header only for a SOCK_RAW frame
> whose socket did not bind a protocol. A protocol-bound SOCK_RAW socket,
> any SOCK_DGRAM frame, and the legacy SOCK_PACKET path therefore leave
> skb->mac_header unset here.
> 
> For frames sent via __dev_queue_xmit() this is harmless: it resets the
> MAC header unconditionally. But the packet-socket PACKET_QDISC_BYPASS
> path uses dev_direct_xmit(), which does not, so the frame reaches
> ndo_start_xmit() with the MAC header unset. A driver that reads
> eth_hdr(skb) on transmit then dereferences skb->head + (u16)~0, an
> out-of-bounds access ~64 KiB past the head -- the same class fixed for
> one consumer in commit f5089008f90c ("macsec: do not read an unset MAC
> header in macsec_encrypt()").
> 
> packet_parse_headers() runs only on the transmit path, where skb->data
> points at the start of the L2 header for every packet-socket type
> regardless of its length: SOCK_RAW and SOCK_PACKET carry a user-supplied
> header and SOCK_DGRAM has one built by dev_hard_header(). Reset the MAC
> header unconditionally, mirroring __dev_queue_xmit(), so the frame is
> anchored on the bypass path too.
> 
> Found by 0sec (https://0sec.ai) using automated source analysis;
> verified against source and matched to the macsec KASAN report in
> f5089008f90c. Compile-tested.
> 
> Fixes: 75c65772c3d1 ("net/packet: Ask driver for protocol if not provided by user")

Link: https://lore.kernel.org/netdev/20260723020337.19040-1-doruk@0sec.ai/

and perhaps also

Link: https://lore.kernel.org/netdev/20260713194010.54642-1-doruk@0sec.ai/

> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Reviewed-by: Willem de Bruijn <willemb@google.com>

My slight caveat about variable length protocols remain (though
perhaps not, with the recent removal of ax25). But evidently this did
not matter for __dev_queue_xmit either. Probably because drivers for
such protocols did not incorrectly assume that mac hdr was set, unlike
the three drivers identified as vulnerable. In any case, fine to have
equivalence between dev_direct_xmit and __dev_queue_xmit. Over time,
these changes chip away at the whole point of a "fast path", but
that's a separate discussion.

> ---
> v2: address Willem de Bruijn's review -- clarify that __dev_queue_xmit()
>     already resets so only the dev_direct_xmit()/PACKET_QDISC_BYPASS path
>     is affected; note skb->data is the L2 start for all packet-socket TX
>     types regardless of L2 length; move the explanatory comment out of the
>     code into the commit log (kept one terse line).
>  net/packet/af_packet.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index e75d2932475a..5ae0511e89e3 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1924,11 +1924,12 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
>  {
>  	int depth;
>  
> +	/* On TX skb->data is the L2 header; anchor it for all socket types. */
> +	skb_reset_mac_header(skb);
> +
>  	if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
> -	    sock->type == SOCK_RAW) {
> -		skb_reset_mac_header(skb);
> +	    sock->type == SOCK_RAW)
>  		skb->protocol = dev_parse_header_protocol(skb);
> -	}
>  
>  	/* Move network header to the right position for VLAN tagged packets */
>  	if (likely(skb->dev->type == ARPHRD_ETHER) &&
> -- 
> 2.43.0
> 


