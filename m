Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A528D19ADA4
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 23:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777331913; cv=none; b=EJxrbncSqil8XDN2JDfUUiJZ95hXWhH/UdaMUzVkGpXZHqnDGuZ5ZwL4JWN/+xQNC9e1iW2zqHDOWZNfiiCKs6shpNEYUOl/LLdzKtr9qR3zrOSU6N6Q9q4dxujbj6myF4ul5r8ZfirKPWkcLVdzmgocpr4ETVdNwTN3Mc6CUNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777331913; c=relaxed/simple;
	bh=uOUsZHf7MXs88DpVKjVuBJq40n2jLG9bDADPT0ODIqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXCvKPL4R0iXjhNAqlxeAzk9Knk4mVLO/xJ33zsujjFb0j+bLIuN1OQlrTFXeY16Jqh6XOO37vWIF/RH4Ssbyukj3RQGNaCm71wy+W7umhbLNLAMV54xTJfrE0P3nZKjq4roX24+en242Pb7Hecaw+p1c+0xQmo2gakLwPZPTvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Et7efEcJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Et7efEcJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52414C19425;
	Mon, 27 Apr 2026 23:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777331913;
	bh=uOUsZHf7MXs88DpVKjVuBJq40n2jLG9bDADPT0ODIqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Et7efEcJdnktHIBZpiswH6BHqnOMCo/7WEWB4OUssMcN0mqdD3epDsmrRiAbkMXrq
	 A1LZFM70enBmCylqr83dxZOR+GftRPMdjK+npd3VyeX71LkAQlfMj56QkEjg4jGQ9m
	 2kvYdgBK+aVcmzCTSaYWQkaU8XoV3LTcUQOF0P3wQkXR/cx8lebyRxXQnpC0nWVTUt
	 Ch5KMjOOzU+Fyen27q9/ACqOCNe0hLmxfSdf8mvrdsefgv8LZPgIWQvVgF7ZtnWQYP
	 xl/4jhNT9PM3/IardfC2FyxUCFb6nHhC5JXDc6Iww6ROmWhQ7hlPUfg4zhsas91u1q
	 CV0UhttaLSu8w==
Date: Mon, 27 Apr 2026 16:18:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 4/4] net/sched: speedup tc_dump_qdisc() when
 tcm_ifindex is provided
Message-ID: <20260427161830.78193ed9@kernel.org>
In-Reply-To: <20260427132555.1791636-5-edumazet@google.com>
References: <20260427132555.1791636-1-edumazet@google.com>
	<20260427132555.1791636-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 13:25:55 +0000 Eric Dumazet wrote:
>  static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
>  {
>  	const struct nlmsghdr *nlh = cb->nlh;
> +	const struct tcmsg *tcm = nlmsg_data(nlh);

nit: breaks reverse xmas tree

I added this tcm assignment after parsing:

        err = nlmsg_parse_deprecated(nlh, sizeof(struct tcmsg), tca, TCA_MAX,
                                     rtm_tca_policy, cb->extack);
        if (err < 0)
                return err;
+       tcm = nlmsg_data(nlh);

because nlmsg_parse validates the struct is in range of skb->len

>  	struct net *net = sock_net(skb->sk);
>  	struct nlattr *tca[TCA_MAX + 1];
>  	struct {
> @@ -1892,6 +1893,9 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
>  	if (err < 0)
>  		return err;
>  
> +	if (!ctx->ifindex)
> +		ctx->ifindex = tcm->tcm_ifindex;
> +
>  	s_ifindex = ctx->ifindex;
>  	s_q_idx = ctx->q_idx;
>  
> @@ -1899,8 +1903,13 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
>  		struct netdev_queue *dev_queue;
>  		struct Qdisc *q;
>  
> -		if (ctx->ifindex > s_ifindex)
> +		if (ctx->ifindex > s_ifindex) {
> +			if (tcm->tcm_ifindex) {
> +				ctx->ifindex = ULONG_MAX;
> +				break;
> +			}
>  			s_q_idx = 0;
> +		}

nit2: personal preference but I had before the loop:

	if (tcm->tcm_ifindex && !ctx->ifindex)
		ctx->ifindex = tcm->tcm_ifindex;

in the loop:

	if (tcm->tcm_ifindex && ctx->ifindex != tcm->tcm_ifindex)
		break;
