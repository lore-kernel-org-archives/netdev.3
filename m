Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8E62D7398;
	Sun, 13 Sep 2026 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789261577; cv=none; b=Xm6EZz8cCG1VgV1bOgom927QcJnDa5fxT3pk/svHsA9e5Nu2FOq4bOjjIJq15aZqFQZGOXwNDID6Wun7Qgb7vCcApzZW1ToOEKTcloAXLKCzPh8SZby8RahTadhAGX8hCkUYJK/he20vAw52lfiyQTpxk0HnO32ehfvthEIix5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789261577; c=relaxed/simple;
	bh=tTnXx9x4oCktbdNyEAPt+I+sif3L5I2MaDmFMg7d+ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxHxTmqPxs8Uz/2B7m/0YLsbjPARlgnfODezQIJdVmHVpY8LHMcU8J0vyPXt6FdhLf+lyNuTQZivQpMwsNkw7mT4iFv7O6KSnMoS09yKWdQIL/pN0g88c8X8/sm9NNBoS0+5qwK1sISTj4xW0eO8Cn69Csf9f0gzn+K836Qmzos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSQVM3Hf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSQVM3Hf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368E11F000FF;
	Sun, 13 Sep 2026 01:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789261575;
	bh=wwoZKwd5H0soJUzCSdneGmKjoKT/hRGAyY4xXK6dSwY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZSQVM3Hfjxpuy21gGDin0P4ldfUTKTUqwFYE7slbAL2/6svB118QDMQHsZyE21pfs
	 bYgjiKl4rd5L38ZxIsh2IrJXL1+y4Ho/douls+tMXMo9dKsIIlaQED1iQ6LF5OQ7/S
	 RlqzuvN9FnFzeuEO3Nzmcet4BwERCsMl2fthfu60QPyjdH5VHPdg6XWLIl9zc2wS9U
	 r1z1mLKOgNgeuAqgTDq/zZXAhnMheQXMGlIK7qRVspPCoY21b2aH+wyX1TTxoIQIYJ
	 2f2hZsNWDu/6dlekkiv4XnZQty0u+gziWJ18+AhxYZIuUcU2YTk19inGU4uiV79gE3
	 iU11PxeQ06naQ==
Message-ID: <962171df-34e5-4c98-bd09-8cc7f8caf3bd@kernel.org>
Date: Sat, 12 Sep 2026 19:06:14 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fib_rules: add FRA_GOTO and FRA_L3MDEV to
 fib_rule_nlmsg_size()
Content-Language: en-US
To: Linkui Xiao <xiaolinkui@126.com>, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 tgraf@suug.ch
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20260911071241.2701784-1-xiaolinkui@126.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260911071241.2701784-1-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/26 2:12 AM, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> fib_nl_fill_rule() emits FRA_GOTO and FRA_L3MDEV, but
> fib_rule_nlmsg_size() reserves room for neither. Its only caller,
> notify_rule_change(), allocates the notification skb with that size and
> treats a failure as a bug:
> 
> 	/* -EMSGSIZE implies BUG in fib_rule_nlmsg_size() */

not really going to fail since the size has so many attributes that are
not applicable to this rule.

> 
> A rule that has both a goto target and l3mdev set needs 16 more bytes
> than are reserved. nlmsg_new() rounds the allocation up through
> SKB_DATA_ALIGN(), so the slack hides the mistake most of the time and
> the bug stays latent, but the accounting is wrong and the notification
> can still fail with -EMSGSIZE.
> 
> Reserve the two missing attributes, keeping the order used by
> fib_nl_fill_rule().
> 
> Fixes: 0947c9fe56d9 ("[NET] fib_rules: goto rule action")
> Fixes: 96c63fa7393d ("net: Add l3mdev rule")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  net/core/fib_rules.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
> index 7df216c17c67..5e84bc740191 100644
> --- a/net/core/fib_rules.c
> +++ b/net/core/fib_rules.c
> @@ -1133,7 +1133,9 @@ static inline size_t fib_rule_nlmsg_size(struct fib_rules_ops *ops,
>  			 + nla_total_size(4) /* FRA_SUPPRESS_IFGROUP */
>  			 + nla_total_size(4) /* FRA_FWMARK */
>  			 + nla_total_size(4) /* FRA_FWMASK */
> +			 + nla_total_size(4) /* FRA_GOTO */
>  			 + nla_total_size_64bit(8) /* FRA_TUN_ID */
> +			 + nla_total_size(1) /* FRA_L3MDEV */
>  			 + nla_total_size(sizeof(struct fib_kuid_range))
>  			 + nla_total_size(1) /* FRA_PROTOCOL */
>  			 + nla_total_size(1) /* FRA_IP_PROTO */


