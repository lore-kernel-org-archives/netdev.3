Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465983;
	b=jE8F5Him2oSlD0XzROuZQeQKdxr+t8MhlGzFEHLybWdczPoqW+zX7cuQYpxMAW85FN8o
	 KL5deF5NDdQunin6I4LllbMhuyIyRfkdtWmCh2rfhcUGIVoDI+eVLWwwkREEbYXB0sowN
	 pG8itS3CLqQaGeMuM4B0IamXI56CtDaLYdpIlf9hVTpz4uB3wXu909GEyXqUIS+R3V1CM
	 1gSSBG5SW3gjlbFDvweAeKqmuYPTWUxRz0GV2ZUSOMOXfMXHkTdFYazKyEdfFFnlKqkZt
	 M4FgeGqnug20tWPjVUN3GB+xvM8tLbIU8cA3FeDDJClE/CNculpvtWN/rgcJzn5z8Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465983;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8vp1+uc0abbvdHBdCyhwDvYNDCnOgemx3ZrP8ySOog4=;
	b=aWcPxetmqc9hYMAYQbh3YtmO6l8dDT4AqAbfSyaGQw7BcANsChQJFvMbucIN3ah7567D
	 NE/ZTywn+JXM3tPFxmbs9W4xN4pL1+yVvPXrzfqWCTxxeVffzkUxCwdKYYjinjJb38CF7
	 AlYnpRtI/5o24vXilpUiitszsscjWSQXV7gDcfvm/4dZPRdDmVW024HxdIkezmhVznVdY
	 +yIibzEpJMn2jRyy44J8IpHBAV8G5NiP8wwF0immRxk07Ckwj2jScU5Ep6jPO/eFucfCd
	 SSm9q3e2pdpyWZbUH5ulk2zeaTxrxuJQCidh0UCGhDLhUV3FiahogN+WfCs8yVqHYvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NsLqQ/hT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857FE606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsLqQ/hT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A454E1F000C4;
	Tue, 20 Oct 2026 03:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792465983;
	bh=8vp1+uc0abbvdHBdCyhwDvYNDCnOgemx3ZrP8ySOog4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NsLqQ/hTQ111jtW/ctrQvanQEfS1jVTWVyIevDApfakms/kWZ7g3x4PDBcNjd0xIM
	 XAo6UnFTG9JEm/Ka492yrChQx+3nOPeuZzvZSC0FHFhRLQnL83Rpl/Ghl2wauC/vLk
	 Nyxr/VRWXHP+dKK07d6SiGG6xFSzImwk+Ts9G/Dt323O7GyrUyWnIsfRPrcKkOOf82
	 kuGTkwFly/TVwn2CCIoAr5VXmi5/1mNlDo9T5m2ijpnjLwY8vd6ksSBQjuQOPNrwAD
	 zrz9HtDXLEAetHCiTYYftfL9UheiMMkbcKjXCnkJjroN0GALg9nWGSCJ2ubvaa1Zq/
	 8xu4R2pKi/1xw==
Subject: Re: [PATCH net v2 1/2] kcm: defer receive parsing when the lower
 socket's read_sock may sleep
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Tue, 20 Oct 2026 03:13:02 +0000
Message-ID: <179246598215.3135.10799623566753910125@kernel.org>
In-Reply-To: <20261016025059.289202-2-rjethwani@purestorage.com>
References: <20261016025059.289202-2-rjethwani@purestorage.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] RX can stall indefinitely when kTLS RX is installed before the
  TCP socket is attached to KCM.

--

kcm: defer receive parsing when the lower socket's read_sock may sleep

This patch changes psock_data_ready() so that it only calls
strp_data_ready() inline when the lower socket's read_sock is
tcp_read_sock(). Any other read_sock, such as kTLS's tls_sw_read_sock(),
is handed to the strparser work through strp_check_rcv(), so it runs
under lock_sock() and not in softirq context.

> diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> index 71af69d442f21..ec7aaba17fe60 100644
> --- a/net/kcm/kcmsock.c
> +++ b/net/kcm/kcmsock.c

[ ... ]

> @@ -358,8 +383,12 @@ static void psock_data_ready(struct sock *sk)
>  	read_lock_bh(&sk->sk_callback_lock);
>  
>  	psock = (struct kcm_psock *)sk->sk_user_data;
> -	if (likely(psock))
> -		strp_data_ready(&psock->strp);
> +	if (likely(psock)) {
> +		if (psock_can_parse_inline(sk))
> +			strp_data_ready(&psock->strp);
> +		else
> +			strp_check_rcv(&psock->strp);
> +	}

[Severity: Medium]
Can receive stall on a kTLS psock when TLS_RX is configured before
kcm_attach()? The commit message tests this ordering and says there is
"no strparser need_bytes stall".

After this change, every read on a kTLS psock goes through do_strp_work().
That work is only queued again when psock_data_ready() runs, which means
when new TCP data arrives. do_strp_work() itself only requeues on -ENOMEM:

net/strparser/strparser.c:do_strp_work() {
    ...
	if (strp_read_sock(strp) == -ENOMEM)
		queue_work(strp_wq, &strp->work);
    ...
}

When a KCM message spans multiple TLS records, tls_sw_read_sock() calls
tls_rx_rec_done() before read_actor(). The ciphertext of the current
record has therefore already been consumed from the TCP queue:

net/tls/tls_sw.c:tls_sw_read_sock() {
    ...
			tls_rx_rec_done(ctx);
		}
    ...
		used = read_actor(desc, skb, rxm->offset, rxm->full_len);
    ...
}

kTLS does not override peek_len, so in __strp_recv() strp_peek_len() is
tcp_inq(). The current record is no longer counted in it:

net/strparser/strparser.c:__strp_recv() {
    ...
			if (stm->strp.full_len - stm->accum_len >
			    strp_peek_len(strp)) {
				...
				strp->need_bytes = stm->strp.full_len -
						       stm->accum_len;
				...
				desc->count = 0; /* Stop reading socket */
				break;
    ...
}

Won't this stop the read pass even when the next TLS records are already
fully queued in TCP? The commit message says the need_bytes check in
strp_data_ready() isn't meaningful for kTLS because it counts ciphertext.
This check uses the same TCP byte count, and it is still in place.

A second trigger looks possible as well. If tls_strp_read_sock() returns
-ENOMEM during tls_rx_rec_wait(), tls_strp_check_rcv() queues
tls_strp_work. The nonblocking reader returns -EAGAIN, desc.error stays 0
and kcm_read_sock_done() returns 0, so do_strp_work() does not requeue.

In both cases the next-record notification goes only through this path:

tls_rx_reader_release() or tls_strp_work()
  tls_rx_msg_maybe_announce()
    ctx->saved_data_ready(strp->sk)

tls_sw_strparser_arm() captured saved_data_ready before kcm_attach()
installed psock_data_ready:

net/tls/tls_sw.c:tls_sw_strparser_arm() {
    ...
	rx_ctx->saved_data_ready = sk->sk_data_ready;
	sk->sk_data_ready = tls_data_ready;
    ...
}

So saved_data_ready is sock_def_readable(), which never reaches the KCM
strparser. Would the last multi-record message of a burst then stay
undelivered until the peer sends more data or a FIN?

The peek check in __strp_recv() and the stale saved_data_ready both
predate this patch. With this patch, though, all progress depends on
psock_data_ready() being called again. Deferring everything to the
workqueue also means segments that arrive while the work is pending get
merged into one read pass, because queue_work() does nothing while the
work is already queued.

>  
>  	read_unlock_bh(&sk->sk_callback_lock);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016025059.289202-1-rjethwani%40purestorage.com
