Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500802;
	b=yc9woyyx4aXGXi0DlvE4PzhRzYN2eIpFA7j0lfHJqP/vPLx3zc2T146ucL5L4eOw3ocA
	 T2feVtzg9ipfrjMhKWoLPzMeXRCZkuBXvHlGLycABF2z2dpZep2VOiMMGdmLhMhSw8Ipr
	 6Y95q3vwNyEhC5nJl4RFZBBa46Slh6VgJrvrjw1RUVzXEKD6glH8aeI9FZQ690Kd+jgfQ
	 XjeQxKA1kl2L1cBIyT7KXitzjXm5xu19zx+zJ2+emNhgwDqB8gIf66InQAigvgLPfh/DL
	 KI3BhVmg1iOnysAI1r11q9dn8ABkKTA9gEKjsxSPBtv+TNV4XJRKYUQLoWmr19Zf3/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500802;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:From:
	 Content-Language:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ug3gxgTRAmLwJZ9jlDeZvtL+FD9HT2QhKSrhIo50A4o=;
	b=10rtHRONI/HxBOZaDp4hSW3vkkJ1RyDfcQwNZwwSiBYLf0BpoqVatoWjYK5bef5pFSwO
	 NZUeqNvQ+y3DT3JulRQxzXOfP70XnXzNM+Qn6reswZro1JmNJ2sDnejrqb1ecvT+kGfv1
	 lngKMVocdtGjghxND1PCswjIEhADm1ctuhnc8SdJNf16OM0bXwXaViS44rkXs7URzi41A
	 beicG5Iyb87EUVxlsJfRhB98ZuZXWmi3nIa9EViRA9z1+57IlZQzpTwTFOKRaq6F6a0u9
	 0oF9fXkVjebSNCV9jTcwxHA1OeQrUSAVp7AYj8SXwzxg9jwHOMBuM0VYfIeFd+9A1MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=6wind.com;
	spf=pass smtp.mailfrom=6wind.com;
	dkim=pass header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=bKL3u6dI;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61B606A331
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA61B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=bKL3u6dI
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c50737c64c8so20094066b.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1794500800; x=1795105600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ug3gxgTRAmLwJZ9jlDeZvtL+FD9HT2QhKSrhIo50A4o=;
        b=bKL3u6dIu0++rEZtas/JwemFgjhK543MBrZqIi6nlnUlmVTr84ugl6hhyXAH3LMga6
         cCxfIqUlK81TzFbcfollEP13jViCJkS6smiwmRThA36Ie/9iw7M4QmWypzOX2KfhXooA
         jyR2S7vjGUhDnpT0Mw2EeZYXGRR6fDJz69jI0yiPdNhCVhZ6r5DJ6O00JcpMZ11IRS9q
         R6m6FxzU+QkC01VFl6wxruWB3fUPxWJ5dbkV0TTP2fuxRth6nPAKzcXFbsA6cFKBFRT8
         xRc37e9pWeuuJrvKjC3WdIxl5rpcdHJ90QP1J9+aNKjsFsoq9o65fslzmGjbUUYwDG3W
         5hZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500800; x=1795105600;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ug3gxgTRAmLwJZ9jlDeZvtL+FD9HT2QhKSrhIo50A4o=;
        b=F0SOqWVgUpcQNY89ZN6AfuoW7DIwr9BkmoXC+QJAVhE1Ccvpe+ZOSUXxYi+cbv0XGy
         XlJzYBPl8ad0bIReFYXi+kAxluWPGJPzOi8yTP/NwXXFkG/a4ZtnNV00wvh3RXbhBC6A
         F8lhqr2Vv2WDV70lgD6JpbxkBxKqDo5CFQnsk+9jzhkZGdtrq/OZNZe7L+9F4Dk11bYY
         mXjvxHy/eZtlgKdRR4hqttUYbLTl03xj9N19ud1FO47LJtxYRUKhB1H+b8U0T0+NejLE
         ygfO5wvQ0+qihIpfMlBpEEA27qoq7daL4faDooeva6me3i4N41yX1b4fezuVQ+uzj9Dv
         YOyQ==
X-Gm-Message-State: APuU4Z/jaF/VfogkDJW6NWfDMODM+N2AzfvYfywlhcbix+YALQ+iDOt4
	exSrjgXkzhR8w6WbFP7sewOzlXHRDH10ok0nER8riSC9MBIagtV2EobrfaRDRIKlO0/5Oxu3kEN
	i40UZmhg=
X-Gm-Gg: AYBFou24Z24Atxvd5xyG8sfu/MSgCVbLUGDr5oD0i+3NqEI1jW61Tv/kP0vdR/Sf5Y1
	WRM7yVGBKD5e6pF8jOg4xlVMX5+biiRULn2xawKskcd5fkzKyFH/OexE8sAyCmNRyeES+8E5u5T
	os31OhPVTDZ1SN9pmbtJVLWnplt6TpOvSxoIE2DpmhRFqStJOm9J9ZTSU35tTuSf7PZz5RrUwsv
	+o7O8XHTibBy0pUblsmUo2nOPQXiuE/4Ie4ZEULu3TqsStb7rlz0VpDhKTImB2SkxeZoO+s7Eld
	SSxUOdmILVhttcMAsTyYzo3IBe/oj42KdwQUs4HMQJIleiKY9kkvSZy8o2meKnRzAmgiYGO2B12
	4bjc34qx2sXtwX2FKjlpOgfJwrlGFIR0WNCZWirKJe7veSGHcBOLyxtDy9AyKlEXMAPBc2r+lAJ
	nLn06AdPcfHOF72SoeBnD7R32R1ni4ubpscH/VyAH/e/Toql/1TGX30YlvM85X9mpHdWsApziUV
	xM8kS1wXdebrKLR785TJBS53UDNZ4Laj4kJBbreWk7svmXh87YLcELLGcNp/rRiT2bK8/Z60Et9
	IdqW7+wPTos0ovxu3vpES9BuZ/4rGeBJfeo/AK5dgHBObbb857zXzudZ7LHOs5q4U9tJI+mNN5r
	NZMU67zMbLCijqX4Um73q1wdxthGp
X-Received: by 2002:a17:907:60a:b0:c46:ae89:cd3c with SMTP id a640c23a62f3a-c5066966d74mr520801966b.1.1794500799989;
        Thu, 12 Nov 2026 08:26:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f782396sm117814f8f.24.2026.11.12.08.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 08:26:39 -0800 (PST)
Message-ID: <8db41fd4-6c07-4f15-9cd9-5525913968ae@6wind.com>
Date: Thu, 12 Nov 2026 17:26:38 +0100
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
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] ipv6: reset all.force_forwarding when disabling
 all.forwarding
To: Gabriel Goller <g.goller@proxmox.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261109-ipv6_reset_all-v1-1-815dfd508246@proxmox.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20261109-ipv6_reset_all-v1-1-815dfd508246@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 09/11/2026 à 16:53, Gabriel Goller a écrit :
> Disabling all.forwarding resets force_forwarding on every interface, but
> leaves all.force_forwarding set:
> 
>   # sysctl -wq net.ipv6.conf.all.forwarding=1
>   # sysctl -wq net.ipv6.conf.all.force_forwarding=1
>   # sysctl -wq net.ipv6.conf.all.forwarding=0
>   # sysctl net.ipv6.conf.dummy1.force_forwarding
>   net.ipv6.conf.dummy1.force_forwarding = 0
>   # sysctl net.ipv6.conf.all.force_forwarding
>   net.ipv6.conf.all.force_forwarding = 1
> 
> Writing 1 to all.force_forwarding afterwards is ignored because the
> value did not change, so the interfaces are not re-enabled.
> 
> Reset all.force_forwarding too and notify netconf listeners.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> ---
>  net/ipv6/addrconf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index d9d13e78bf13..9007a58039e6 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -905,6 +905,14 @@ static int addrconf_fixup_forwarding(const struct ctl_table *table, int *p, int
>  						     net->ipv6.devconf_dflt);
>  
>  		addrconf_forward_change(net, newf);
> +		/* Disabling all.forwarding also resets all.force_forwarding */
> +		if (newf == 0 && net->ipv6.devconf_all->force_forwarding) {
> +			WRITE_ONCE(net->ipv6.devconf_all->force_forwarding, 0);
> +			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
> +						     NETCONFA_FORCE_FORWARDING,
> +						     NETCONFA_IFINDEX_ALL,
> +						     net->ipv6.devconf_all);
> +		}
>  		if ((!newf) ^ (!old))
>  			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
>  						     NETCONFA_FORWARDING,

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
