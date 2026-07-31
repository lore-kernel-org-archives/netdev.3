Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8E743CE54
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511459; cv=none; b=R+CooQBGUso1IuCm+fe1n6L+qn9+fUsXFj/9c/74XG7A/F3aFpVplTTUMOf2oo/KzKj4VzGXek/Y1RqI2/FkLlp+hgYFFVo2Hk56XToYvjVn5pNtMuYLuh1Didaz4+oDPNZPRtUPsSOj1kPHcw6VvYRi8gJn2A15lLN5u/2f9Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511459; c=relaxed/simple;
	bh=AnT9ykHGRiW9ML8tMoivB2MPdOWSnpohAXTeRpl5nGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6w2J58RgMjer/5nFre1yJvtpsAi8QqfEdcw9/BDHsHElfyHVmiRHINQRbh0QFVmsKTqVyco/nhfVf6r9oNYWtwU1fZRAEIahFvFVkkpBJwTlSVXe7rqbyYr6zQQliznokTfGotq7ZIQHksYo+yIrAV3SbHUieLmHLXdr1LPjF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=bQHhVxLy; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="bQHhVxLy"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15e62c695cso11927866b.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 08:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1785511453; x=1786116253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iG6P15z3YvY8fxNxjEcOAHCU39JcDX4FjPan6Psmb9Y=;
        b=bQHhVxLyEdTxV+yonELQS0YOh82LjULmV7bkj8RRWRxxm1PHrTV4xv6M8K6onLPGTb
         zhopTlaxKlhb1jnDTGcqJ2FdNjNAetJUfnnZ0Dk1/DBFmQ3xHAUlNgmHg41OzVb8500j
         2eC7d4jGJWiKY/dDM6GEqw3GHnWc/HZvEcROGOFNZsW9ZkBej25dLct0gbCkxioxwJu5
         0sBiWgd8Gt1IUpLhU8XPKb3GmXovJp4NejD7TACE8cULeiwhxEUL2as9ETsfO/tQtEvJ
         4o0IR5EMQFU6SFIuzi32QLBnwpSykP5zyBvG7qWo/N7vaN4JJ1KOgT+UVVgmyesgFsEk
         466g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511453; x=1786116253;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iG6P15z3YvY8fxNxjEcOAHCU39JcDX4FjPan6Psmb9Y=;
        b=B6zbZSU6UtEC9DiYiKIKXIYgAZzx0gF3LHoLY6jh6cBdqdIth+6rebnHz2nq2nUxqe
         KQIUCmMf/Bx8h8IN/aHwcsqwz9Octmo2sGEmIvcwfV1LwAP8LxRFgXUIG3tJ1hDreEmU
         KaIVIfK2GP6RGDs9rOWmP1krNIvVg3vRqTqLaasZyUAbhfvNOmLQSn2n33KC5xvGXxri
         YZSdanz0NnUPoEAnofU5779UcHrgRXiiMI5epIyTglw/+13qz9J8Ub1VnJdjmsw/C1gK
         62lxGidFvNOO89/tcwHHEVdInFCDRMOxb57DvgkM/Cas0HWzlimNY8uyaTXGImw1Pser
         bmgw==
X-Forwarded-Encrypted: i=1; AHgh+RohYBSWIoxTlD3+H5aotHyJxf0/munIHloi5cV/fs/e66r3W7mKuhDPJXrG+vRasMG2pqnAPI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPKHRl5PWZx45Rp0sdVbbVZIUmNluU0TXcQnpE+/qFcgHpgaiy
	/pGsAz1OUH295WCNyJ9NIxwsOEYlxpQ6yruXFg/kXwuvya9aD8d3UVsXyBgi0n5AjSw=
X-Gm-Gg: AR+sD114i3rEsIBSJLiYwz/Lk31gQCSSrOPsrLUuRIvZMLYYH/jAuMMTAsnW50LGtOZ
	jGoUhrfqa14yr07TMOsPAYkjtTBPTFnC68os+1M0r6HrMCgRjqwbQKgMjptzbccm1pvfmO4Z/0X
	j++8mp0y2whYTo5mAZCmhfmTK10C0ItBDn++VwVmd+a/oBvNYD+EzqziZCIA27jNrHqt6R3TfTj
	U4Yw/iaV2x6HU4/EcGf4jhTPEcprIYXjM0q5yx17bOZ0xYAJiEhxZ/sTju5FIUmzGQ9406TIjPz
	iJFeMsjvBwmGxNRWG6dM/omYPcPaPb8kbHjNlNgF4u+hIGqvjf+tY/DO2YS9YnM/Yc36slgEXjM
	vmYowd8onNklO84+LtjuT5IgfZiOfEnpHWP1GXrKa/va80ozsLLK6OpceZ1spbfLd1bDZGbT7Wy
	klrSFF/OXwmGy9ydrtrK6iCmPdADXDA28nVqvMQ5djNXgEXpPbhRl8RaiSsooEpvyxrDErgBkHk
	nC3Ej2Q/8fC7xrrChczkzzNy0RbbFT7gmj3gRWXrA==
X-Received: by 2002:a17:907:8749:b0:c16:1290:11a7 with SMTP id a640c23a62f3a-c1fe7c5fb22mr12970066b.1.1785511453406;
        Fri, 31 Jul 2026 08:24:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd445449asm175813866b.37.2026.07.31.08.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 08:24:12 -0700 (PDT)
Message-ID: <6eec5c20-88d2-4a82-84ff-da0d5ceb3905@6wind.com>
Date: Fri, 31 Jul 2026 17:24:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] ipv6: seg6: clear IPv4 control block in End.DT4
To: David Lee <david.lee@trailofbits.com>, andrea.mayer@uniroma2.it,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260731140832.567669-1-david.lee@trailofbits.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260731140832.567669-1-david.lee@trailofbits.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 31/07/2026 à 16:08, David Lee a écrit :
> The End.DT4 input path decapsulates an IPv4 packet and sends it
> directly to ip_route_input() and dst_input(). It therefore bypasses
> ip_rcv_core(), which normally clears IPCB. The skb still contains
> IP6CB data from the outer packet, and IPv6 extension-header offsets
> overlap the IPv4 option fields. This can make __ip_options_echo()
> copy beyond the allocation for saved options.
> 
> Clear IPCB after validating the inner IPv4 header and preserve the
> ingress interface as ip_rcv_core() does. This prevents outer IPv6
> metadata from being interpreted as inner IPv4 options.
> 
> Fixes: 664d6f86868b ("seg6: add support for the SRv6 End.DT4 behavior")
> Bug found and triaged by OpenAI Security Research and 
> validated by Trail of Bits.

There should be no empty line between tags.

> 
> Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> Trail of Bits has a reproducer for this bug that triggers a KASAN
> slab-out-of-bounds write in __ip_options_echo() and can share if needed.
> 
>  net/ipv6/seg6_local.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 2b41e4c0d..d03b377f5 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -1186,6 +1186,9 @@ static int input_action_end_dt4(struct sk_buff *skb,
>  	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
>  		goto drop;
>  
> +	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
> +	IPCB(skb)->iif = skb->skb_iif;
> +
>  	skb = end_dt_vrf_core(skb, slwt, AF_INET);
>  	if (!skb)
>  		/* packet has been processed and consumed by the VRF */
> 

End.DX4 also calls ip_route_input(). I guess the same problem exists. Am I wrong?

Regards,
Nicolas
