Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792990528;
	b=lNol29XY61TwqoEsmA3pX3xiRYo3G26yYl4lg6ynpXjy/cP0Wok94FVLyrMJRDHbKDJs
	 v9BJY5CryNX+Drn3+Cf1lL8Rwn2rDGFbUEkz7KXrF85iWhJ6oY3dp+/mGHHqlEopsHTQR
	 gLxl1sQLR9SEskXzWdhmRiyTqdDcQ1V75B2HVsewbziygxGWqaEDBOTI5Wc5wKFn4eT1H
	 GFG4NRlxwRTbxnNvu0DQCvsC4wySep8FUzqf7Wyh0XaQPxy9qEeq9Z72qypjyQUDZGsZ7
	 k4pg02cdHWWVrsx2q08Z7HW3jOBHRSKKMjTxKyZX6i4hm/4eh7tSKW7wt+61aKbRKcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792990528;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dmLzoQgozplDu/9SBVmmpJh6hgrzZbLq/8nLkuZ66/g=;
	b=YumQsbBrMJ3VwRnXtYD4eyQpp0JPs+p6vDB9Nepj6soQ0yOuugB2R42hJWu2GnfJmj7Q
	 G6WW3rerCuu5Z6tQWrbKRhWHwULQQEHIAITgTClfCTzihcVhZisOEjVft3C9QIc0SY1Vi
	 K+cni9+2fFi01v0pWpf90RidZl9PdGzgBVowyzRu4+yFA+j0Njt2TW4OpXCclf1Af1VKC
	 5FeRfTz9XY0bHov6g+ixX8JVsn13nlj8I04QUKQ+0pqVmCCXmDYeSq1kjFdZwNOrbcAXT
	 JlP84wARpqS8e3N8h61Or030DuFlNWZgTdVWjVkaZtzZwDTbQQxcs1dv9ryF9pbMeWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Glivn+IV;
	arc=none smtp.remote-ip=91.218.175.138
Received: from mta0.migadu.com (out-138.mta0.migadu.com [91.218.175.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB24606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 04:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AB24606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Glivn+IV
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rNE07H/3FLm3aKovCPgIesMS7lML/QQJycGGoAF8aNg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792990524; v=1; x=1793595324;
 b=Glivn+IVA+KS0T4oP+WQjItXulnV8OW1h27MnRdJwZ/QU7RSyqF52BevVdbJjYAUzLaXAOb1
 OrZU68/qD6BVPF7fyNlO6n+NNcMIXYpu9VU/oE62rRAiLOoobYXBgmJYcTEP1EdDj/ksb5DozST
 WRY2wTCMJqwuX7fQaYDjSNcQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 907883841960f556;
	Mon, 26 Oct 2026 04:55:24 +0000
X-Mizu-Trace-ID: 907883841960f556
X-Migadu-Flow: FLOW_OUT
Message-ID: <7ba55644-0882-48d1-9abd-9f109996a5c1@linux.dev>
Date: Mon, 26 Oct 2026 12:55:21 +0800
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
Subject: Re: [PATCH v3 1/2] tcp: clamp return value of tcp_wmem_schedule() to
 non-negative
To: netdev@vger.kernel.org
References: <20261021185447.2914274-1-tavip@google.com>
 <20261021185447.2914274-2-tavip@google.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261021185447.2914274-2-tavip@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/22/26 2:54 AM, Octavian Purdila wrote:
> When sk_wmem_schedule(sk, copy) fails under TCP memory pressure and
> sk->sk_wmem_queued already reaches or exceeds sysctl_tcp_wmem[0],
> tcp_wmem_schedule() returns min(copy, sk->sk_forward_alloc).
>
> However, sk->sk_forward_alloc is a signed int that can transiently
> become negative when tcp_collapse() re-packs partially read or high
> payload-to-truesize SKBs in the receive queue and charges newly
> allocated SKBs via sk_mem_charge() before freeing the original SKB.
>
> If tcp_wmem_schedule() returns a negative value, tcp_sendmsg_locked()
> passes that negative copy length to skb_copy_to_page_nocache() ->
> copy_from_iter_full() -> check_copy_size(), where it is converted to an
> unsigned size_t > INT_MAX, triggering a WARN_ON_ONCE(bytes > INT_MAX)
> in production and returning -EFAULT instead of waiting for memory or
> returning -EAGAIN:
>
>    WARNING: CPU: 1 PID: 939331 at include/linux/thread_info.h:249 tcp_sendmsg+0x10c1/0x1530
>    Call Trace:
>     <TASK>
>     __sys_sendmsg+0x292/0x490
>     do_syscall_64+0x88/0x340
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Clamp the return value of tcp_wmem_schedule() to [0, copy] so callers
> treat negative sk_forward_alloc as 0 available bytes.
>
> Fixes: 849b425cd091 ("tcp: fix possible freeze in tx path under memory pressure")
> Assisted-by: LLM
> Signed-off-by: Octavian Purdila <tavip@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>   net/ipv4/tcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 87ef6d5cbfeba..0e062fcd94a6c 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1037,7 +1037,7 @@ int tcp_wmem_schedule(struct sock *sk, int copy)
>   	left = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[0]) - sk->sk_wmem_queued;
>   	if (left > 0)
>   		sk_forced_mem_schedule(sk, min(left, copy));
> -	return min(copy, sk->sk_forward_alloc);
> +	return clamp(sk->sk_forward_alloc, 0, copy);
>   }
>   
>   void tcp_free_fastopen_req(struct tcp_sock *tp)
