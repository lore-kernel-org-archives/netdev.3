Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B016411F90;
	Wed, 14 Oct 2026 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791950634; cv=none; b=fL1sdj13KL+7e/ww1358h4OGfBglUpr+RQ5YoBkLUsF52CEKbtro+ae/CqBjSV+8ZHXsYroe9nJGQHRRCJQgd9hrUEHGCDfO5PpCtkh7Y2OObW1/q0F9dbaJrFzdMm00pzPpoT8CYM8zGKSfqEi8TR1ak8fbG6X92+3Imga9rEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791950634; c=relaxed/simple;
	bh=FcjLSPhR/pkggo8Ln8Ba+uAEi5Mr3VyEFw+YHTcPPIk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zar4CI7607KFJo12C9A8Tt4to4lqMXWosfVjER/9l8ACJcibpokMNfmlOm4XOPixHlTb9OP+bZ5bcCVK8UiiYBsFppbYmLX004kFe1601SLMZ7lpyQsQp7gmX/looJodDJQjLCnIK4Vn7QX0yBQzs6M8ZlBZpXNQM/OQCBojTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGOpXLmQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGOpXLmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FD81F000FF;
	Wed, 14 Oct 2026 04:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791950632;
	bh=wyiPssJl3JiX3owHqVugBEFvLmNp9oF1Gy5M6IM+UZU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TGOpXLmQ0KJgjdgQCb97HI1TcEiGlBZq5AqsdiPahJzXjpUcI0pwjDbl1QXpMfzKK
	 An4GNN/aElsLRdjrh+xPHc3yFN2Uf1DOpjXC1VL2RrsXdeZvk7uOMEihzZGLEMh4NW
	 Q1k2n6GPCtuXMsa9O8tEv78HJ+KcrLDsfHJYQlPPn06Eo6h/yQCN+kkUz1TxMajun2
	 CWVc3B0W5AmZmIco5nwZSnxF9l4EXVwkwYBUA99TjEuvyFSIFPyu/M5azP2cCY3CZC
	 FX7pdlF4V07i17drpC9Y0ntLw0GRJw7MaBnQ69tFrERJxgIYmIHKQpi9tKFkN7baiQ
	 22h8ryhPzbZyg==
Subject: Re: [PATCH net] kcm: defer receive parsing when the lower socket's
 read_sock may sleep
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, leitao@debian.org, zirajs7@gmail.com,
 runyu.xiao@seu.edu.cn, jiayuan.chen@shopee.com, brauner@kernel.org,
 sagi@grimberg.me, hare@suse.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 04:03:51 +0000
Message-ID: <179195063165.434549.13463545924832836566@kernel.org>
In-Reply-To: <20261013033920.2069285-1-rjethwani@purestorage.com>
References: <20261013033920.2069285-1-rjethwani@purestorage.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In net/kcm/kcmsock.c, psock_data_ready() now passes every
  data_ready event on a non-tcp_read_sock lower socket (for example, a…

--

kcm: defer receive parsing when the lower socket's read_sock may sleep

This commit changes psock_data_ready() so that strp_data_ready() runs
inline only when the lower socket's read_sock is tcp_read_sock(). Any
other read_sock, such as kTLS's tls_sw_read_sock(), is now deferred to
the strparser work via strp_check_rcv(). The goal is to avoid sleeping
in softirq context.

> diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> index 71af69d442f21..381a8f0b792e3 100644
> --- a/net/kcm/kcmsock.c
> +++ b/net/kcm/kcmsock.c

[ ... ]

> @@ -358,8 +359,19 @@ static void psock_data_ready(struct sock *sk)
>  	read_lock_bh(&sk->sk_callback_lock);
>  
>  	psock = (struct kcm_psock *)sk->sk_user_data;
> -	if (likely(psock))
> -		strp_data_ready(&psock->strp);
> +	if (likely(psock)) {
> +		struct socket *sock = sk->sk_socket;
> +
> +		/* strp_data_ready() calls sock->ops->read_sock() inline from
> +		 * this softirq callback. A ULP's read_sock, such as kTLS's
> +		 * tls_sw_read_sock(), may sleep, so hand anything other than
> +		 * TCP's own to the parser work, which runs under lock_sock().
> +		 */
> +		if (likely(sock && sock->ops->read_sock == tcp_read_sock))
> +			strp_data_ready(&psock->strp);
> +		else
> +			strp_check_rcv(&psock->strp);

[Severity: Medium]
Will this serialize all KCM-over-kTLS receive processing on a single
system-wide worker?

strp_check_rcv() only does queue_work(strp_wq, &strp->work). strp_wq is
created in strp_dev_init() as an ordered workqueue:

net/strparser/strparser.c:strp_dev_init() {
    ...
	strp_wq = create_singlethread_workqueue("kstrp");
    ...
}

So only one strparser work item can run at a time across the whole
system. KCM psocks, the sockmap strparser in net/core/skmsg.c and
espintcp in net/xfrm/espintcp.c all share this queue.

With this change, every data_ready event on a kTLS-backed psock ends up
in this path:

strp_work()
  do_strp_work()
    lock_sock()
    strp_read_sock()
      tls_sw_read_sock()
        tls_rx_one_record()   /* sync AEAD decrypt or crypto_wait_req() */
        tls_read_flush_backlog()

While one psock is decrypting or waiting there, do_strp_work() for every
other strparser instance waits behind it on kstrp.

Before this patch, the common case ran inline in softirq on the
receiving CPU, so several sockets could be processed in parallel. kstrp
was only used for the sock_owned_by_user() and -ENOMEM fallbacks.

Could this add receive latency for unrelated KCM, sockmap and espintcp
users? Each individual wait is bounded, but a local user who controls
KCM+kTLS sockets could keep the shared worker busy. Would a per-psock or
unbound workqueue for this deferred path be a better fit?

> +	}
>  
>  	read_unlock_bh(&sk->sk_callback_lock);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013033920.2069285-1-rjethwani%40purestorage.com
