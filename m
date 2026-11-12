Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474366;
	b=bYOWvMagvgnncedQQf5PvPE04zhCYSnCt9aFfDx5lPTPwzSL+E7xyRqx9byMEKz72W+0
	 VKaLMKAA6oMPq2SWHToC+x2XjmQvkEhlwnCpoePHec2SFwPKI2FTbwCCwsyWoRz2GT1jr
	 IExhO/lrPGDca0qucUnJuLfiY3a7JtvmK/vqV4agVYLs1fVptWxugsiTSC9LtwwmKmOwX
	 scWdj1++rCKOl8zluh9AM3rnd3hK89tgklHpGSH5AXg0iE78SOiZ/wQhtiOhlMF+h8dRo
	 noSzKHwS9j6PJfXZxdTPQFNh/MyUvS4g43oE/ER7T7B7KOsV4aLJ+q7VgND/yj6zjNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474366;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=w+J4cfzvIkYfhSsRO9GW6mn6A7rg77PGWNHJk+zmkqw=;
	b=SUnG7ASfHcVvXofR3go/JmbkO8Uk/XtZnB54jaVt2me6ritvhW7KtrhLU5rvcUiE20Wd
	 feHFMcrTj1XHYoGPCLWtpR/dlNJVuaZl3DTUYGQmeFZcVePK12DWxMOgY5/8gDjFACrpR
	 oQvTJ9qlTw0zwqHUs8WGCKoyi6Hjvot35NZaXyc3JwdJsGLYG+YJwKZMLwBVdJ/zasY+R
	 Ervo1RQdpbQ8hNNj2OnDp1IVXur4rtsj7KMnGKpDtqy204hvXtPfaaEMHxNrYF0LK/CDM
	 M7ZkLLe40it6v1ANyow78mbZZbZ3/4pYe1TwN7Dqy74zDu8zRn++oU4lNmoCaXtzRmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=AQvRFziB;
	arc=none smtp.remote-ip=195.10.208.47
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org [195.10.208.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0D606A330;
	Thu, 12 Nov 2026 09:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8D0D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=AQvRFziB
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4jQDyB5BdRz3yG9;
	Thu, 12 Nov 2026 10:05:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794474354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+J4cfzvIkYfhSsRO9GW6mn6A7rg77PGWNHJk+zmkqw=;
	b=AQvRFziBUyqdb8x3QiU+/VyW2cW/0vmQl7GRPLMGskX9qdplkQ0OqBSdFfTfBBv4bKRDv7
	K5K4t9XZm07C6wddEjFikIsXJijAx9I+KZPJ57Z7dAU+oYkg4k/vlMZVZq1fLoBERMMH9o
	v8HxKhk3riOEOZ8NoijwUgDzrOR99/qpN/5H011E32pN/S1tAZEVuMs1DbBJDbM6vSsfkE
	M++qd1stt/HGE6narT/gMsef7TKfihT6Z9878qM5CmB9bvTyv7Fk96+mmNqXzKDe2X/T1F
	FjxEmX4dl98/L1hOQ4neaiG+HCeq9HLF7fMuHPyecunYtxXM4zHnQfvXR6nM/w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
Message-ID: <1d0d447f-f458-4eec-8b63-80119fee618b@mandelbit.com>
Date: Thu, 12 Nov 2026 10:05:51 +0100
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
Subject: Re: [PATCH net] udp_tunnel: don't treat IPv4 sockets bound to an
 address as wildcard
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Alice Mikityanska <alice.kernel@fastmail.im>, linux-kernel@vger.kernel.org
References: <20261110113306.3698438-1-antonio@mandelbit.com>
 <avVVzxL3pVZc6yQ5@google.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <avVVzxL3pVZc6yQ5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4jQDyB5BdRz3yG9

On 12/11/2026 07:02, Kuniyuki Iwashima wrote:
>> diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
>> index a128fe85620d..29581c94fdcf 100644
>> --- a/net/ipv4/udp_tunnel_core.c
>> +++ b/net/ipv4/udp_tunnel_core.c
>> @@ -62,10 +62,10 @@ EXPORT_SYMBOL(udp_sock_create4);
>>   static bool sk_saddr_any(struct sock *sk)
>>   {
>>   #if IS_ENABLED(CONFIG_IPV6)
>> -	return ipv6_addr_any(&sk->sk_v6_rcv_saddr);
>> -#else
>> -	return !sk->sk_rcv_saddr;
>> +	if (sk->sk_family == AF_INET6)
>> +		return ipv6_addr_any(&sk->sk_v6_rcv_saddr);
>>   #endif
>> +	return !sk->sk_rcv_saddr;
> 
> This is identical with inet_rcv_saddr_any().  As a follow-up
> in net-next, please move sk_saddr_any() to include/net/sock.h
> and use it everywhere.

Yes, indeed.
Ok, I'll add it to my todo list.

> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!


-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

