Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480551;
	b=TlP5L3AggseN7QxqAvyubtuAr8RDE8rkYk8fP6yNsae2xLdg+ia2hAqVtUiNmLK94er7
	 i/2KaV8fznvCV0WIGoL4x5ZoEF/iVw8wBaBDPEedR7t4fvhwQhGLfKnXTIJgjfHWBxO0r
	 ZYTbjwPeWTr0CZNcPFTPz3+s6ybDyERWS3/cHuIf2K7YqxcoNqONXq/NIfLq4ybfJ0wao
	 ccHu7mqFMlYXxjMTWt6R+Gf8wYovwuQRWS7VnS/E7Gg14+lb9LIr8Dj3MdyhwGasbreoH
	 X9nlOgPHIE30YLl+jtcScaJbAfjQRohyfyrkz/IDpCZdCxUUw94RyNqZruGOtjbqOWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480551;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MztN57ZxEX6YdGm4SMZs50eB6cZreH0724TGwHcvAIs=;
	b=Mh8o7vQwEmAVHNj4jMVZkUX6i3ziNpHaY4ZUHeK9EcJ8jOdL4lIW/UWl3924qnQky5ts
	 gwcxCHVL5l08nEnogXMeeBNpZGNpE8TwoPvXTCnb5OOWNJpAJ5bhMUGCOQ7O41BKt8vF+
	 j+6g+4kBHGQjzKL9+I+fwvdYS0pRpOXbll+7slnk1oYOl3TXFmWZg3MCSlElTB9MutQyO
	 p6+q5xaW0XhCwQFaBtz/PIB0M9O676QGdfm2k9BVbQEnlNgGx1BH1n2FAOaCjvos1xVfj
	 Nw2zz6FtBoN3otjF3rSOqXudaU0QGvk+V+ZnEMdKQQRsTDCkxbQ+JrP9CGyZbHlJzsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MnkvFNaU;
	arc=none smtp.remote-ip=91.218.175.34
Received: from mta0.migadu.com (out-34.mta0.migadu.com [91.218.175.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48DC606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E48DC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MnkvFNaU
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sGMQYUI0I9nh4YfHz7VZXb6Qjo1y+CI+m2fZL0ZglNk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792480548; v=1; x=1793085348;
 b=MnkvFNaU67zakbOaVCQFO29P+fHjeQX2m6aBC/sGigGvkoySIPuHEXUzHsHdBpDCwLcy5YYv
 /3vPhthqaf4ZEebGLXk9hQiGvokQpCGjtif+gjSf2Sqq3ESnAAWHhAP7jxBIjlXO/wBP9LUHwGO
 d5ZunYnEg3TbaXPVloMx++ts=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 806c637258654c2d;
	Tue, 20 Oct 2026 07:15:47 +0000
X-Mizu-Trace-ID: 806c637258654c2d
X-Migadu-Flow: FLOW_OUT
Message-ID: <9f049a1d-59ca-44f8-93d4-3abbf54fd185@linux.dev>
Date: Tue, 20 Oct 2026 15:15:41 +0800
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
Subject: Re: [PATCH net v5] net: ipv4: add zero check for snd_cwnd_clamp
To: netdev@vger.kernel.org
References: <20261019222531.1073-1-kj2864@nyu.edu>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261019222531.1073-1-kj2864@nyu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/20/26 6:25 AM, Kaho Jiang wrote:
> User can pass zero to snd_cwnd_clamp via RTAX_CWND type.
> This could lead to division of zero error if not checked properly.
>
> Oops: divide error: 0000 [#1] SMP KASAN NOPTI
> Call Trace:
>   <IRQ>
>   tcp_reno_cong_avoid (net/ipv4/tcp_cong.c:510 (discriminator 1))
>   tcp_ack (net/ipv4/tcp_input.c:3517 net/ipv4/tcp_input.c:3873 net/ipv4/tcp_input.c:4440)
>   tcp_rcv_established (net/ipv4/tcp_input.c:6685)
>   tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
>   tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
>   ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 1))
>   ip_local_deliver_finish (net/ipv4/ip_input.c:241 (discriminator 1))
>   ip_local_deliver (./include/linux/netfilter.h:325 ./include/linux/netfilter.h:319 net/ipv4/ip_input.c:262)
>   ip_rcv (./include/net/dst.h:481 (discriminator 6) net/ipv4/ip_input.c:492 (discriminator 6) ./include/linux/netfilter.h:325 (discriminator 6) ./include/li)
>   __netif_receive_skb_one_core (net/core/dev.c:6297 (discriminator 4))
>   __netif_receive_skb (net/core/dev.c:6410)
>   process_backlog (net/core/dev.c:6761)
>   __napi_poll.constprop.0 (net/core/dev.c:7830)
>   net_rx_action (net/core/dev.c:7893 net/core/dev.c:8050)
>   handle_softirqs (kernel/softirq.c:645)
>   __irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel/softirq.c:758)
>   irq_exit_rcu (kernel/softirq.c:775)
>   sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1062 (discriminator 35) arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
> RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)
>
> Fix by checking if user pass in zero as parameter,
> if so reject the value zero.
>
> Fixes: 814d488c6126 ("tcp: fix the timid additive increase on stretch ACKs")
> Cc: stable@vger.kernel.org
> Reported-by: co+71b6509cb791e531@bugs.sh
> Assisted-by: LLM
> Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
> ---
>   include/net/tcp.h  | 2 +-
>   net/ipv4/metrics.c | 4 ++++
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 4416cdf9bf30..9f605d9ecb35 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1522,7 +1522,7 @@ static inline u32 tcp_snd_cwnd(const struct tcp_sock *tp)
>   static inline void tcp_snd_cwnd_set(struct tcp_sock *tp, u32 val)
>   {
>   	WARN_ON_ONCE((int)val <= 0);
> -	WRITE_ONCE(tp->snd_cwnd, val);
> +	WRITE_ONCE(tp->snd_cwnd, max(val, 1U));
>   }
>   
>   static inline bool tcp_in_slow_start(const struct tcp_sock *tp)
> diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> index ad40762a8b38..cb36686973e5 100644
> --- a/net/ipv4/metrics.c
> +++ b/net/ipv4/metrics.c
> @@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
>   			NL_SET_ERR_MSG(extack, "Unknown flag set in feature mask in metrics attribute");
>   			return -EINVAL;
>   		}
> +		if (type == RTAX_CWND && !val) {
> +			NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater than zero");
> +			return -EINVAL;
> +		}
>   		metrics[type - 1] = val;
>   	}
>   

Have you checked the sashiko report listed in you previous version ?

https://lore.kernel.org/netdev/179236266579.3135.14593132945174653104@kernel.org/


