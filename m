Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492304;
	b=ePwf5ceOIrcIwamM1LUy8Dwau1AmZGn5nvynA+y3kLwGk8m5nh3q/E2kQwgj6Z9b/DkV
	 gS1nvrOc5m+NNLjFA33ICQ/v8Fl/g3+VTq1ozQFwuR/gqYKxJ97dLGqjxDnfHZByZ4vRV
	 tBGSaHvm5qJiTG+ucK43jnJIgQGLgkyM9KVMBVdHL+xzXFSHCxSxTA0yNJDXRhRKsNpPi
	 goUjwIxSPT0ijLAwyqnmfayElh/Gg+BwbI8jW7HYU0m0zFlYFD6eAEsoSwMWzPpoCLXQ4
	 iyao1suKhccC4vzIodzmVPcyAOoFxOjMWnyW4M004j9gZX4dx2gqkkHOzfrvIRs7G0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492304;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=aW+tUhGIytr6myAG/haqiFo8CoeHUsC4Au7jENp7FB0=;
	b=Stl5wCs28Hmd0nSs9d0xNKzRMaVuUVBoBfZsJmNKCN2s0gnkW4ThfnCLhlSZkXwdaTdB
	 bFCuOGXUlt+1mFL0HJyf/k4RPcHVv6X/9z7Gwr4/YT9qBMgucz7zwhONWiMZIgboXiNP6
	 FLWy6O9ju/AHJfAoXKGywYeaUL9kJHUb9DKTlwiy3p5KjHvSEpvELzJDzVsAbBQHXERl8
	 X5y6J8p0zFr/qDq0u+uIvlrpBBQiLJRCccftHxDnS5x/oRR8fYdFFliK1yX7Jkm+mKZXp
	 nCTo21kUu+6KteMDdOqQRAZWLSvG6bu1v1NlybuCM5USgzEyVaX/QT4tOU8WlXk7tMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdIsAXuY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE31606A31A;
	Tue, 20 Oct 2026 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdIsAXuY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FD21F000C4;
	Tue, 20 Oct 2026 10:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792492304;
	bh=aW+tUhGIytr6myAG/haqiFo8CoeHUsC4Au7jENp7FB0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fdIsAXuYNFCvTxZEqUFxtcgLs7ZMUHxO4dBU2zUuVXo8Y32rD52ephxinNlUuIu3u
	 gGBRPorpuUwTZnCjWKqEZMkSC1qPaYfr5ibX6PakxqzZZY+riitZKwvUSrF3t20u7T
	 h4UA9C6LIUYm80TkiBDiFtnzLPj9nAsZxAjm8h6gG2E+uizSFZ47WspBg+5VOTrXnk
	 wYuBOH4BF3oOpTgFtuDC8isv6h/R9eFPaXCp9DbmQTmK/EscMqfaPtR26bN4UxU0/t
	 38eo7Zotu521jTaRcxY09MfJsOLuG7CJFuC+xeWLONA3dyKCNLZjRcim0bVQTunTsB
	 wIY2MHR+aCLXg==
Message-ID: <f54da1f7-4ee2-4e19-b95c-c442f4f91a31@kernel.org>
Date: Tue, 20 Oct 2026 12:31:39 +0200
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
To: Kaho Jiang <kj2864@nyu.edu>, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 edumazet@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 co+71b6509cb791e531@bugs.sh
References: <20261019222531.1073-1-kj2864@nyu.edu>
Content-Language: en-US
From: Eric Dumazet <edumazet@kernel.org>
In-Reply-To: <20261019222531.1073-1-kj2864@nyu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/20/26 00:25, Kaho Jiang wrote:
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

No. Please do not hide bugs.

I repeat : Do not change tcp_snd_cwnd_set()

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

But is it really fixing anything ? I guess this is why you added the 
max() in tcp_snd_cwnd_set() because you did not understand the issue.

An unlocked CWND of zero is harmless.

I think a better fix would be:

diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
index 
ad40762a8b38379e4ccdc505e3885adb8dfff763..b7f8c47f72f9707adb4ef4dde5558af23b46a502 
100644
--- a/net/ipv4/metrics.c
+++ b/net/ipv4/metrics.c
@@ -60,6 +60,12 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
         if (ecn_ca)
                 metrics[RTAX_FEATURES - 1] |= DST_FEATURE_ECN_CA;

+       if ((metrics[RTAX_LOCK - 1] & (1 << RTAX_CWND)) &&
+           !metrics[RTAX_CWND - 1]) {
+               NL_SET_ERR_MSG(extack, "Locked cwnd metric must be non 
zero");
+               return -EINVAL;
+       }
+
         return 0;
  }




Note that my email address is edumazet@kernel.org

Make sure to refresh your git tree, because git should have handled the 
change automatically.

pw-bot: cr

