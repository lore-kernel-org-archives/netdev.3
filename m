Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793945772;
	b=2GnUWa885/Hgpw//fpb9/WlrbLCONWr16jVepWHrqoiTfQqFNKsiq3X4SzHu0//KEE/W
	 wGSVtQrkeZnZi75OyTGCQCdPfLWifcdPLAZ3EtjfafEmSwYkUcyJDye5WjBH+Cih4LAhP
	 xJ34xTIWaYwV0C2LThWJ+XhWZ9SaICkOIeAZzM9ywEXljsu7Omb2tEMOgNuISCyPRZUrJ
	 l0jeFgVsHtkHfJPYhXGkbkhGj4/h1aL+ecfyN+J4QBUndU2Y3LyN+K5zV21KRAbkNw4u4
	 lhWj305W6IgzOOLiHnaa/Q6dLdc8LhUFJoTzPdGFK5q6sBvrd7hwldHjcYqfKvS3lNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945772;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QkdmBPlNQnGu105wggpDIUpINN7JTcBrIEM5l8eU7vE=;
	b=y1lTIq3STgSCVV4fk/K4Yaygczb0LgEnzNrcD+AGwoipVIxXOGR9QI6KN0MXw6p4xDn/
	 FHsgHiXttGC6cnSD/rY3sZoXesjdEWIVdxDOplvM7FGHo4lnbZdtB1vppUf2Yf1ii8UbI
	 +Ok8e6aiVneEQG5yX3X+eESAPYXBOHFTRnsJkAr1FFOzhBEUbVE59gKJI0+rcL+ldCzT3
	 EsqwqYiT4CrMDYaX7ELqkkv0AWo7INowgSBmfKUeTFtmicOoVHuzTKNtZM6dCQL6a+CwB
	 f5Cs8/Rjjz1ZorNk+SpCZMbt3E5iKvrkTcAHK4UzfzjUgYLy9BN7zFH67QEIW1R3RjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WN+AaxYC;
	arc=none smtp.remote-ip=95.215.58.83
Received: from mta1.migadu.com (out-83.mta1.migadu.com [95.215.58.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBB3606A328
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 06:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFBB3606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WN+AaxYC
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0SyDJ5tj5ftKMDHZLP0MehFmcA6JD/wW/tkhPu9aV8M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793945770; v=1; x=1794550570;
 b=WN+AaxYCgfkarFaymWhLI7abi+6MLVriGz67Sr6FSM3pi7CqkvtgVdUxjnE1UVZDdx+GapAL
 8KGR78Y1Xmiz2mDhrtd1ejsVThNux5S9dBjedwD+NfDNSy2e/ze23gJyHhGtgZi12CCZ0BsU/+e
 PIQWopAdx98UF6UElahndwgc=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1b0a039608d9a9ea;
	Fri, 06 Nov 2026 06:16:09 +0000
X-Mizu-Trace-ID: 1b0a039608d9a9ea
X-Migadu-Flow: FLOW_OUT
Message-ID: <e0f76fe6-dc65-4053-b949-b34d90adbf5d@linux.dev>
Date: Fri, 6 Nov 2026 14:15:56 +0800
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
Subject: Re: [PATCH net] net: protect negative destination advice with RCU
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
References: <20261104131744.1056562-1-edumazet@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261104131744.1056562-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/4/26 9:17 PM, Eric Dumazet wrote:
> From: Kyle Zeng <kylebot@openai.com>
>
> SO_CNX_ADVICE calls __dst_negative_advice() while holding the socket
> lock. Connected UDP sends can still invalidate or replace sk_dst_cache
> without that lock. A concurrent sk_dst_check() can drop the final
> destination reference and allow an RCU callback to destroy it while
> __dst_negative_advice() retains only a borrowed pointer. This can cause
> a use-after-free while accessing dst->ops or running the negative_advice
> callback.
>
> The writer-side ordering fixed by commit 92f1655aa2b2 ("net: fix
> __dst_negative_advice() race") does not protect this reader from an
> independent cache replacement.
>
> Hold an RCU read-side critical section across the lookup and callback.
> This follows the datagram release callbacks and covers IPv4, IPv6, and
> XFRM advice without changing cache-reset or reference-ownership rules.
>
> Fixes: a87cb3e48ee8 ("net: Facility to report route quality of connected sockets")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>  include/net/sock.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 173b37b2b8bb..0c1a6895d347 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2218,10 +2218,13 @@ sk_dst_get(const struct sock *sk)
>  
>  static inline void __dst_negative_advice(struct sock *sk)
>  {
> -	struct dst_entry *dst = __sk_dst_get(sk);
> +	struct dst_entry *dst;
>  
> +	rcu_read_lock();
> +	dst = __sk_dst_get(sk);
>  	if (dst && dst->ops->negative_advice)
>  		dst->ops->negative_advice(sk, dst);
> +	rcu_read_unlock();
>  }
>  
>  static inline void dst_negative_advice(struct sock *sk)
