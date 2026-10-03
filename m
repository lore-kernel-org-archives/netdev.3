Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B22385D79
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791047360; cv=none; b=YJhYgPGuEw7LDXhJ9V8D/7q6d0YW/J7WOlV5I8/e6HSiMV4ITEvrKqlVK/wg4DEIhMxu/JK0mDj3ug1MX4VK1kgdkhhrfwoY11izEc0fZhZSAT2/fLzo2R0uHX/jKdj9zpU1y94u6NrXNG8p2d38CsexqqrHyHMxnR2ex/id6GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791047360; c=relaxed/simple;
	bh=bb9Xq74XszcTVaiev3mlqz1llwDU4cUF2AWD+8Xix9Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=s7klZEoqlPFcwDuFhQFzD1HK/9hchNZl+sch1BlgGQEErO6fchnIU61wVf6KceCAHCW4yU0Pudhc5EoYhrfkhy4Hoe07dYIO9TMqm1ytSpcn2+LeIT54+fCiW2vVJ9QjaThaFB9of/Rmfqi6G6NWbvhUEJIv3vMkfY/btH3kffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXlQiq4D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXlQiq4D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E7D1F0089B;
	Sat,  3 Oct 2026 17:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791047358;
	bh=uzZ/taEmxi+2HXzCFw2SEgL8M7EYrzX0npnubvZzz7Y=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=PXlQiq4DCjck4LydjrPuwSRqYFTTAS8b3BCanfuaR/7scYtt759OCm6CT08Q1Lq0d
	 +tSaJWXjWqQ9vbR0hvDOT3OxbzJkqY0t6K0cMK3o5A7jLynlftJPhPM6KJDujgsSbW
	 7Gpk6pRZVigQxRLgmLtowNK/dSwtI9CFbnJ2kfmj1ugxoDsGsJXujNH8evwqDC8ecw
	 wQu/ZFhFwy+ylD5g5ER8incp4JsRKH9PAyBFjHxMky4YaH9ILYAvPJviK+G1ZcsbWc
	 KNZijPL6uU2b2rGV0ahRG4rr7V4YwyB/h8NLAL+NAmSoGmqCPyqC8fRs+s1Gn8fEwN
	 vn5WBOCTHCmLQ==
Message-ID: <701a85ad-2403-41ff-8ef2-a5a71a7f068b@kernel.org>
Date: Sat, 3 Oct 2026 19:09:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: ignore locked zero CWND route metric
From: Eric Dumazet <edumazet@kernel.org>
To: bestswngs@gmail.com, ncardwell@google.com, netdev@vger.kernel.org
Cc: kuniyu@google.com, davem@davemloft.net, horms@kernel.org, xmei5@asu.edu,
 co+71b6509cb791e531@bugs.sh
References: <20261003153224.2683219-2-bestswngs@gmail.com>
 <cec4b256-da83-40df-99d5-44710ab8ea63@kernel.org>
Content-Language: en-US
In-Reply-To: <cec4b256-da83-40df-99d5-44710ab8ea63@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/3/26 18:10, Eric Dumazet wrote:
> 
> 
> On 10/3/26 17:32, bestswngs@gmail.com wrote:
>> From: Weiming Shi <bestswngs@gmail.com>
>>
>> A locked RTAX_CWND route metric of zero is copied into the TCP metrics
>> cache and then into snd_cwnd_clamp. This sets the initial cwnd to zero.
>> With a cached SSTHRESH metric, a later Reno ACK can reach a divide by
>> zero in tcp_cong_avoid_ai(). A user with CAP_NET_ADMIN in a user-created
>> network namespace can trigger the oops.
>>
>> Ignore a zero cached CWND metric when applying the locked clamp, leaving
>> the socket's initialized nonzero clamp in place.
>>
>>    Oops: divide error: 0000 [#1] SMP KASAN NOPTI
>>    RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)
>>    Call Trace:
>>    tcp_ack (net/ipv4/tcp_input.c:4440)
>>    tcp_rcv_established (net/ipv4/tcp_input.c:6678)
>>    tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
>>    tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
>>    Kernel panic - not syncing: Fatal exception in interrupt
>>
>  > Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local 
> cache.")> Reported-by: <co+71b6509cb791e531@bugs.sh>
>> Assisted-by: LLM
>> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>> ---
>>   net/ipv4/tcp_metrics.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
>> index dc0c081fc1f3..ff41804ad086 100644
>> --- a/net/ipv4/tcp_metrics.c
>> +++ b/net/ipv4/tcp_metrics.c
>> @@ -484,8 +484,11 @@ void tcp_init_metrics(struct sock *sk)
>>           goto reset;
>>       }
>> -    if (tcp_metric_locked(tm, TCP_METRIC_CWND))
>> -        tp->snd_cwnd_clamp = tcp_metric_get(tm, TCP_METRIC_CWND);
>> +    if (tcp_metric_locked(tm, TCP_METRIC_CWND)) {
>> +        val = tcp_metric_get(tm, TCP_METRIC_CWND);
> 
> Please explain how we can come to this situation?
> 
> cwnd can never be zero, so how a save metric could contain zero?

That is to say :

The right fix is in ip_metrics_convert(), one time instead of at each 
TCP session init.

diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
index 
ad40762a8b38379e4ccdc505e3885adb8dfff763..50a08e592b207e85ccc2bb6f917379de61af4579 
100644
--- a/net/ipv4/metrics.c
+++ b/net/ipv4/metrics.c
@@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
                         NL_SET_ERR_MSG(extack, "Unknown flag set in 
feature mask in metrics attribute");
                         return -EINVAL;
                 }
+               if ((type == RTAX_CWND || type == RTAX_INITCWND) && !val) {
+                       NL_SET_ERR_MSG(extack, "CWND metric must be 
greater than zero");
+                       return -EINVAL;
+               }
                 metrics[type - 1] = val;
         }

pw-bot: cr

