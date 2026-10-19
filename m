Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792453176;
	b=D65FFt5gTXK5kNDPKFCeYNvkrtQTflqWwOOuYlHXxhTx43d8mMb9a2XNjwGTAZgdnXZC
	 GHZzBzvOOLSvPjRcz0HM27iFieODQCtFLpNEIMIiZTP1QRXNMdC1wUlOiNi/YOTK8K+Sw
	 nJzImdUEjny7P6ULZNmXJJJmMjtQsMMgWW3XfKoOVNN6RX7DVftqEpGsUNBgWUs2uRlf9
	 Pe0l928v6g1kZX8sw3h3DMOjM/Qxrq9ubeop0x5x8NRjiXXdOFPqaioMlX+5i7u/fa0mj
	 oxT9YbjaI+Vl7ahk6cLRYyHqY8YnyjGqQQLHu8XZ7OKqcLyCjDLiPBXPe3WXuIwHJlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792453176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A2XMj0MgDNNeDg+EibWO9ZwK+CGK7oGBq9Z2sZ3Ezdk=;
	b=PYwmJgx6oaWR5fv7wwDLSppzbCBiZviXYTozb7w52S4YqcrDz4TPnjunD5+C/FXgcRF/
	 2K/RrO5w9B17CJ/84rFexZeVQ42rM7Dfr8w32I5kC9vo1zumlOjYFvW5Bc+BysI701eCp
	 vfNkx0CcmJVb2qUjM0CYv7u9wUYw4iCuHRfY1hXpEP3UiOFBmPVPp7rGiNCVPhhectPjS
	 cUfPery68+gcroJMlls0bRM1xuQeyfV1FdBo0bOYxq8CY1MPrgsYWAAm4XLuk+VAE7Rg9
	 OzgQfbZnpa8P6L8jKHHTzLjUDBzPh4Uc4A9NlqmHK3/TgwmX+ygRzAUfopUy0lIo8Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="W/jkav5Y";
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01BE606A31B
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A01BE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W/jkav5Y
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eac48af23fso641978e0c.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792453174; x=1793057974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A2XMj0MgDNNeDg+EibWO9ZwK+CGK7oGBq9Z2sZ3Ezdk=;
        b=W/jkav5YZc5EOPkPBBpxqdU5uCjHa4Y+S5njK0UKinhmusxH5MMhec6fJH6ygzYLxx
         fY8KM50uL8eDcIZO/g1NUls00c63vvjL5FSCxj0nB68usyIfI4HD1740A7e0rPpSYf43
         C9++Ou3pcBXiBBdFhu8Mpl0HwqbCsuzJEgdT1T3Tc1Q4ZGiZDkdJ/DX6pZZ8+I8SEP9h
         SqpDK623YkIefr8eQ5aJ04OKYefVpjM5OFGgjOcRz7CSHj6Tt2MdGf48R9Y2m4DpDso7
         58WXRkfJXug4VZTc4Awmc4p7MH90MjQxuSsyjXV7erxSKFshOF0TCoxJObRk0+x428ZY
         PxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792453174; x=1793057974;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A2XMj0MgDNNeDg+EibWO9ZwK+CGK7oGBq9Z2sZ3Ezdk=;
        b=m7psKezSTE7rCFYwwendo9Q0QEDLzAZsNcs0/BPbPM1GLJTSqEwQ7IXJGW64WxhED9
         Y/EqX/DD117cjdovEQ3fWOtwGCPoNVb4s8cPhRCagLz29bE4Htyqxs/XtFSdCD3Um4Sr
         VXBa/2W1ibjk6xtu/VF6Nq3wVVWYV6LI5+swr64i9vxk/m9P3MGuCNerz5GTDX7exYhi
         vAxWrpzY21Apbe5SAjGzrayJFcByQizmaZE/h/MClOJuQ9HjDmGsx+gj9YxhTcq1GGaS
         D4DFnSKLTFIILpbr0xR6h+/FSP8uHjdconjvz4nyzTa2d7GA+pjxr9MKsXKBXbvSWSSO
         m2hg==
X-Forwarded-Encrypted: i=1; AKwUvBxbyaNzeOCA0g/sp8/kFKj+PN/PjlKPf4dfH2DeoaACOhGX944xBBCWYQnVbjTotu/bhcKZRjs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfpE5PjzWZ7HFxy3LncOwe8f7JA7DBXAESIqAvW4EJ6dmPTfQ7
	IGiZBpE/ICz/s2iFnT6Jdjxlyy5fnBc2IO1IgHwkxJet9bSkpvc9WTVM
X-Gm-Gg: AYBFou2VaunNbOaBKeYkcLZ+6drBzbn5TOs96Ufp6zd3JDTKK+jZeVd5jx6caChABlZ
	Gw/KcvAqTAmUfTxoPET5T89UyVbq6EE5iLCeD/GwvEKaUMUibU2fPjGQG5vPAq2y6oenbM7fUKb
	ByYYtg1WRGfayf62bS2VTC77Q1bUJVyJMOJLhDDPHDt1/01Txh8iBjxhCGLP9NRkZsfkfpyvZMo
	bXPkmcZWZE+GX/6/k7uY8LPgfw20MDajqZNTKHn3G7xN2YBXZe9e+Zfwc214//mYlcweGBvq3wl
	dwEM7vbw889qNN7GhfehVDGhx6z2Q3Ibc/OBVDjGF/8VG/dyJ+nyJxgeMXw+QVACx39Xwhqo6BY
	kT9pO68Uxwn4rbZBvIGEkPNQpJ564A/XJkvqG9vk3fU0wN5NQAA4fjxyeVmgySoaANuDmcN/78H
	IeHMrs3FXA7/eFiE89tRz1SDMbqRYD2bI3SPGSR1TRjuiRwMkyjUCtbPrMTGaxAvznKHF8YyZxn
	aRLb25+kRgXtUbabap99M2ZAerrqHIhFCz9bgCSU5elWQWY4cJfKQzd1q9WY4+70JBEFV2yeo3A
	NUnoJbDLPT7e62iUzUDzaFD74Z+wGHxJiJE78w==
X-Received: by 2002:a05:6123:107:b0:5ea:cd69:7cda with SMTP id 71dfb90a1353d-5eacd697dc2mr1189183e0c.7.1792453174590;
        Mon, 19 Oct 2026 16:39:34 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eac2c68171sm5412215e0c.8.2026.10.19.16.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 16:39:33 -0700 (PDT)
Date: Mon, 19 Oct 2026 19:39:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Josh Don <joshdon@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Josh Don <joshdon@google.com>
Message-ID: <willemdebruijn.kernel.ab2d1293d97d@gmail.com>
In-Reply-To: <20261019230758.2960779-1-joshdon@google.com>
References: <20261019230758.2960779-1-joshdon@google.com>
Subject: Re: [PATCH] udp: Add noinline_for_tracing annotation for
 udp{,_v6}_send_skb()
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

Josh Don wrote:
> We hook udp_send_skb() and udp_v6_send_skb() using BPF fentry programs
> to monitor UDP transmits. Both functions are static and have two
> callers: udp{,v6}_sendmsg() and udp{,_v6}_push_pending_frames().
> 
> After an FDO profile update, udp_v6_send_skb() is now inlined into
> udpv6_sendmsg(), while an out-of-line copy remains for
> udp_v6_push_pending_frames(). The fentry program still attaches
> successfully, but it is silently bypassed for all uncorked sends.
> 
> To address this, make both functions noinline explicitly for tracing,
> as was done for tcp_drop_reason() in commit dbd5e2e79ed8 ("net: tcp:
> Add noinline_for_tracing annotation for tcp_drop_reason()").
> 
> Assisted-by: LLM
> Signed-off-by: Josh Don <joshdon@google.com>

This would target [PATCH net-next]. But that is closed:

    https://netdev.bots.linux.dev/net-next.html

Please resubmit when the window opens.

The entire function is quite large (though the common hot path would
not be). For that, I expect adding the noinline will be okay.

> ---
>  net/ipv4/udp.c | 4 ++--
>  net/ipv6/udp.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index b090bd1f59e86..487c8cc8ab206 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1110,8 +1110,8 @@ void udp_set_csum(bool nocheck, struct sk_buff *skb,
>  }
>  EXPORT_SYMBOL(udp_set_csum);
>  
> -static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
> -			struct inet_cork *cork)
> +noinline_for_tracing static int
> +udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4, struct inet_cork *cork)
>  {
>  	struct sock *sk = skb->sk;
>  	int offset, len, datalen;
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 93478d1ad5769..fe92538835176 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1366,8 +1366,8 @@ static void udp6_hwcsum_outgoing(struct sock *sk, struct sk_buff *skb,
>   *	Sending
>   */
>  
> -static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
> -			   struct inet_cork *cork)
> +noinline_for_tracing static int
> +udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6, struct inet_cork *cork)
>  {
>  	struct sock *sk = skb->sk;
>  	int offset, len, datalen;
> -- 
> 2.56.0.212.g129ede20d9-goog
> 


