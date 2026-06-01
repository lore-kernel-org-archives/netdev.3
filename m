Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E08F37F72E
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296614; cv=none; b=uE49AJtsqpwwxg9qg13AEzRmjsGj5zuXEoqAc/Zt6aX88tXtnlgBDHwMCw6CgJ7pjcEnuPiDjNzYST3p+ZAmuAotL2hlzXXnQgmtCiFYIf0Oxaeo3UBklqSQL7VmL1J39R36kw80mxaki+v9lUBYoh+C8us0sZK8kbdOnD4hTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296614; c=relaxed/simple;
	bh=vgCaYGakgdW5YqcZTBtWS+V2GugAvOWIridZQ/ZeXwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCBa8BD2EcBQk0ZShahco51lJLvNShauc5LKZN+G+xArxabU4QzTg6WTcXxrXSXvENWCmmQZMwaSi9LeQyLv77sj2ltzOlr4K0s48kvzM1AQdbRpLL2B/SyvkYRzxo5Uzwh22hiNtCm4XAaVKUlEZNWDteObMv/ichrKeJNqqCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IxWhHt4X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RBl4wSSN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IxWhHt4X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RBl4wSSN"
Date: Mon, 1 Jun 2026 08:50:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780296610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpJRlqzQnR1CjQYAnfmxKeICL6VJNyR6kHyAFMt7TKc=;
	b=IxWhHt4XWPFXlRSSKGR/1Qj6dcUkUdko9hT4QkAWTxTA6nebi+xalylwieY4n+mP0sd+Gy
	DeDoMnTsKJbKxogv4lQvREYjg1AX9N5EtavzR3l9KU7T2CXpEbukYopL6hOwWj7QRon4sp
	DdFB3xmtMyceSX9VHQ02THqvQOsFRU7nZqY1BD2ZKi22FbFjpExfCfrmqV98YgMAOmIaUy
	iK+OSndwuRVvOSdXkzPymrNcddl/xNhITnh3mh/XE9Q0BmQWF/KbSXAZBg3eA5/9A7M4Jx
	6Dnc4eXhALSXti91BD8xWp79IllZYdXy9bTT/E09TiW48a8GxQO3q5O3it9CmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780296610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpJRlqzQnR1CjQYAnfmxKeICL6VJNyR6kHyAFMt7TKc=;
	b=RBl4wSSN4XFQkDE1+P99i/6HrVLit13knWxvZYzV2RPIyGlieQU/ARKiWTtZzufMbXhX46
	3sNZt/ksb7QY8wAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzbot+e809069bc15f26300526@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net] tcp: Add preempt_{disable,enable}_nested() in
 reqsk_queue_hash_req().
Message-ID: <20260601065009.YBMkQ84z@linutronix.de>
References: <20260530055907.280160-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260530055907.280160-1-kuniyu@google.com>

On 2026-05-30 05:59:05 [+0000], Kuniyuki Iwashima wrote:
> 
> Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
> Reported-by: syzbot+e809069bc15f26300526@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a1a7bcf.0a9e871e.332604.000b.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv4/inet_connection_sock.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index dbcd37dfdc15..b546ce15ee03 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1145,6 +1145,8 @@ static bool reqsk_queue_hash_req(struct request_sock *req)
>  	if (!inet_ehash_insert(req_to_sk(req), NULL, &found_dup_sk))
>  		return false;
>  
> +	preempt_disable_nested();
> +
>  	/* The timer needs to be setup after a successful insertion. */
>  	req->timeout = tcp_timeout_init((struct sock *)req);

That tcp_timeout_init() has a BPF_CGROUP_RUN_PROG_SOCK_OPS() in it.
Could we move that preempt_disable_nested() a bit lower just before
mod_timer()?

>  	timer_setup(&req->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
> @@ -1155,6 +1157,9 @@ static bool reqsk_queue_hash_req(struct request_sock *req)
>  	 */
>  	smp_wmb();
>  	refcount_set(&req->rsk_refcnt, 2 + 1);
> +
> +	preempt_enable_nested();
> +
>  	return true;
>  }
>  
Sebastianc
