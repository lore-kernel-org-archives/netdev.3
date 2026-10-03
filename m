Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04170477990
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791043820; cv=none; b=dg+vnLwbeY36v3v5k83G/SA4c952M9pQ5kaAwUVs1gLKkbey69OTryV9vuQwNM4BGF3JVjpy824NAOpPALrymoQfp8RYQ3nr4EV1rmgi1x5UtDIpkTLtZx/qL2ikT7RtqoNoJMEC8NLtoXtRINYYruBOkj8kA4i6eAb/poaxJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791043820; c=relaxed/simple;
	bh=DBMvytce8oHVPSA21PCx3oY421BpRoUSzuBGAdxDgrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LK6hsPKAejyINqDw616Ystx/djwgbjPkifuCZamvsp09iLnDoRPDsTAKf8IgPhinr8mUrAHbl7/VxJFZUlnNEhnvwNC0xBxDbI09lPKbLpphtPu9TDEZikoC+mXOR4qqd7Nn/bw3Rz0rJXeb53qBlsX1yxVNLYtFh9zx+u3vwLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEdMId/I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEdMId/I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C221F0089B;
	Sat,  3 Oct 2026 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791043814;
	bh=wgt7/YW2Tr+KF7vbo5hF8/p9ESedj0wjH+qHcwXC9XM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VEdMId/ILsurnlSHdMzb7+TGx3Ha7dIN9lBKmVb01vxcb7G/IOJwAcqUEZ8lrWo91
	 kHxlOu+YnuITO3hdlyZ14WlqckpGsxeKLeyAp6YOYpKWRHF7/2Y3RHXhFDD+XlPmop
	 4Tvtmp7UxDmhlVfPQ/tzlz1oc7BDnrQbO+/RTy6+c/eomeCSiQvRoPEZZFtRE1A09P
	 RVvQ9fzf1zaAH260Alf9AHYf6MLI4I37e7RWUrPfRWwI/LVA3KRAO20tPcScfM5OoY
	 86Py1JUUCLT3LOWjAsqLAVKHRawIB9cYdE/7Ewuds0tZlrjaW8WCnBAj5B+DJ4i6zM
	 pxygM7pWgee0g==
Message-ID: <cec4b256-da83-40df-99d5-44710ab8ea63@kernel.org>
Date: Sat, 3 Oct 2026 18:10:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: ignore locked zero CWND route metric
To: bestswngs@gmail.com, ncardwell@google.com, netdev@vger.kernel.org
Cc: kuniyu@google.com, davem@davemloft.net, horms@kernel.org, xmei5@asu.edu,
 co+71b6509cb791e531@bugs.sh
References: <20261003153224.2683219-2-bestswngs@gmail.com>
Content-Language: en-US
From: Eric Dumazet <edumazet@kernel.org>
In-Reply-To: <20261003153224.2683219-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/26 17:32, bestswngs@gmail.com wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> A locked RTAX_CWND route metric of zero is copied into the TCP metrics
> cache and then into snd_cwnd_clamp. This sets the initial cwnd to zero.
> With a cached SSTHRESH metric, a later Reno ACK can reach a divide by
> zero in tcp_cong_avoid_ai(). A user with CAP_NET_ADMIN in a user-created
> network namespace can trigger the oops.
> 
> Ignore a zero cached CWND metric when applying the locked clamp, leaving
> the socket's initialized nonzero clamp in place.
> 
>    Oops: divide error: 0000 [#1] SMP KASAN NOPTI
>    RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)
>    Call Trace:
>    tcp_ack (net/ipv4/tcp_input.c:4440)
>    tcp_rcv_established (net/ipv4/tcp_input.c:6678)
>    tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
>    tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
>    Kernel panic - not syncing: Fatal exception in interrupt
> 
 > Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local 
cache.")> Reported-by: <co+71b6509cb791e531@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>   net/ipv4/tcp_metrics.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> index dc0c081fc1f3..ff41804ad086 100644
> --- a/net/ipv4/tcp_metrics.c
> +++ b/net/ipv4/tcp_metrics.c
> @@ -484,8 +484,11 @@ void tcp_init_metrics(struct sock *sk)
>   		goto reset;
>   	}
>   
> -	if (tcp_metric_locked(tm, TCP_METRIC_CWND))
> -		tp->snd_cwnd_clamp = tcp_metric_get(tm, TCP_METRIC_CWND);
> +	if (tcp_metric_locked(tm, TCP_METRIC_CWND)) {
> +		val = tcp_metric_get(tm, TCP_METRIC_CWND);

Please explain how we can come to this situation?

cwnd can never be zero, so how a save metric could contain zero?


> +		if (val)
> +			tp->snd_cwnd_clamp = val;
> +	}
>   
>   	val = READ_ONCE(net->ipv4.sysctl_tcp_no_ssthresh_metrics_save) ?
>   	      0 : tcp_metric_get(tm, TCP_METRIC_SSTHRESH);

