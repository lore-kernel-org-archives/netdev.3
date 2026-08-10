Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF3B3DEAD6
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388132; cv=none; b=GspCDPxnVFY5OwgOcEKQBeJ3ZL2DoD6ciCrZYUTAoUrbCm/ZCXVfOa5OO8WdIdRmrRj9yPGSsq5DhNPJP3WCjYcee5Z6REKRj/ND+QGLgBPVbfLjXFrTiOn5RVyR43EuvPA9FqANQAoA10qdQnSvGU7PZGYUtQmTbyxTNsSnq2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388132; c=relaxed/simple;
	bh=e6eOL0FJC5ket9uPlrfy/upR4VpR9UnwvB9RfL7zehw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcfcrazgG+FhXwFECyaOStHvHPfTLuQbY8DdbIIZS2ZROCT19azEZJL55s8uF6w3hY6s20hE5Z/qCnDa2tCNvRq6cn3uKrNRtjdHkkkT1a6a1CQw1bTta5W3km6HnQR0SVgfZUsbqD+AZKsMb/IvnjgzWQhoWKtwcoSunuwRinI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so8496475e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786388129; x=1786992929;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eDPDzOSNgjKp5sZX+BjdxXLjvfDLRA/UmcvVnE0yrDg=;
        b=USRtd4vaY307ZCrbjsXjh5flNSnmz4dh79Uk/zX3m2PgcJTjPkU5EsaiFQWSb1EVVJ
         7yBL2k9CHiwwEmE2V+oJojPmMzT5rF0O1Kxbdt9x/uB7JVtQVpn0dx3NO723IyxWJ8YO
         fj58vt7YnTrTyhvKIqR/yvykCcnkPfMiB6eg1ozGWsuE6YsLolWPGQ4/7zKhoHNfSfG9
         Tl6T9ElAZHwkf068SaL/xbwxFRM2Jsl14Vd5d7p1vO2CUmd1z/On3QasCCbTaczcNEEM
         48Fs77GIU2JaErx+Yk8a26k0cBN0haA3u5gyj5v6q0TQ6kMO7cXZt1v8UV9n8KP0ZvAL
         8JwQ==
X-Forwarded-Encrypted: i=1; AHgh+RrN8xpsroh7W3xIOFIURTQY4ZCPEmzBGTVuvkp86PZGxF8fXYaA8TbkEe/2UsOBAnUHoqNP41I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVyo53dyGhCi6jmcch0Tgzs4Gddc0LQYMa8GHgYUOLRBedIRIW
	4Ej8Yr0lc1LJq1GjeXif7O6xcdsxwZ9qKBC5SpyhPjgphTI3AnOG4uEi
X-Gm-Gg: AR+sD12+y64jkvBtIglKRqQi5zPxAwLkHlW3b9LUKm++gNyEO3cGYZs7BL7m+BN+9Nt
	j8WSatZ+MxYZqF6XIUck1xJ5bDv8y9KtQH6PI0lsMUzykb52Nm5niDWjkurQEvcRYpSQ8wZuf27
	mPhYRxd9ETXetw2fGP3lopLkLBPgY+E0TxU7zm9RP9KA/mlXt1PZnhpeI93ybHTxO0RWV/NCL53
	33o/PhEb59wdpqNQRTiE9X3SzQAqo8eiQnXa1pRW6bj2eb7BrE5s10ziH4w2dLRBhWgrZhZkBMr
	yLONEqyh/pm+EeZsCqWGarZ8gGjYpVRjZGdkqjfFAg1pZMSAgxtWTe+8YT/CjE03pCTpkZ9O6ue
	NcGEMdEuUDt9I+drFbjinOpKhmFUl7w0+2ySULHHVL9GiYnsGNRvi9hmYFFNumlJmtLEG9qIfB4
	fZEEgDTRYHp/I3uZQPf2PBLT9crnRLyhbn/1BaXul8kAFTKpksygXlzy0ZviiIP+86P4ovXkVUT
	PHs02ISz4DIYWPJYQ==
X-Received: by 2002:a05:600c:6d90:b0:495:4a22:d684 with SMTP id 5b1f17b1804b1-49959e2f00emr346681905e9.10.1786388128609;
        Mon, 10 Aug 2026 11:55:28 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499740db139sm11106045e9.7.2026.08.10.11.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 11:55:28 -0700 (PDT)
Message-ID: <eea5d4c1-af06-4210-b7ac-b783dc44a819@ovn.org>
Date: Mon, 10 Aug 2026 20:55:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: core: propagate unreadable flag in
 skb_zerocopy
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, Jason Xing <kerneljasonxing@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@gmail.com>,
 Florian Westphal <fw@strlen.de>
References: <20260810180956.2348280-1-almasrymina@google.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260810180956.2348280-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/26 8:09 PM, Mina Almasry wrote:
> skb_zerocopy() fails to propagate the unreadable flag when copying
> devmem fragments, causing target skbs to appear as readable memory.
> 
> This patch fixes the flag propagation. Additionally, it returns -EFAULT
> if standard payload is mixed with unreadable devmem fragments during
> extraction, and clamps unreadable skb lengths in openvswitch
> queue_userspace_packet() to avert truncated invalid payloads.
> 
> Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
> Cc: Florian Westphal <fw@strlen.de>
> Cc: Aaron Conole <aconole@redhat.com>
> Cc: Eelco Chaudron <echaudro@redhat.com>
> Cc: Ilya Maximets <i.maximets@ovn.org>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> ---
> v2:
> - Return -EFAULT when mixing unreadable and readable frags (Pavel).
> - Clamp unreadable skb lengths for openvswitch queue drops (sashiko).
> v1: https://lore.kernel.org/r/20260801125308.1342897-1-almasrymina@google.com
> 
> Openvswitch maintainers: PTAL at the openvswitch changes closely. They
> are reported by sashiko as an also-need part of this fix:
> https://sashiko.dev/#/patchset/20260706155219.23757-1-fw%40strlen.de

Hmm.  FWIW, I do not see anything about openvswitch at that page.

> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index ae69b2cabab9e..7c663d7846174 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -480,6 +480,8 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
>  	}
>  
>  	skb_len = min(skb->len, cutlen);
> +	if (!skb_frags_readable(skb))
> +		skb_len = min_t(size_t, skb_len, skb_headlen(skb));

I'm not very familiar with the devmem and the unreadable frags, but if
there is really no way to read 'skb_len' bytes of the packet, it must not
be delivered to userspace.  Delivering truncated packet will confuse
ovs-vswitchd and the packet will be dropped or delivered truncated to the
destination.  We should return something like -EFAULT here and the caller
will drop the packet (MISS upcall) or continue processing if the failure
is not fatal (ACTION upcall).

This practically makes devmem incompatible with OVS, I suppose, as upcalls
are the primary mechanism for initial packet processing, before the datapath
flows are installed.

If there is a way to read this memory, we should make a full copy here.

Best regards, Ilya Maximets.
