Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA2E4052D7
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786430290; cv=pass; b=eo2T+we4Ks2ou6F3vtZz7okpvXusSLC9j45ys80mmCH+1Xf+ypOk04SFUQEC09hKIW/S174ghqL4dWX0LmBqwUOJDT7SiIm1xrZGS+Bp+Opqg6rOppXYdIZdQCEtR8iw2oj3rLX0MfVeKDZ0TQDCkhWr8BYuk8/Zt26Rz/J2T/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786430290; c=relaxed/simple;
	bh=Zh0ReCO8tn7/M+oIdfPoqQstXfdGnrLygh0IoANt7LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrFJHbf69IlwdVZQZDMlmN/I9KocUK5tv0FMmafkOCbG33C5u95k8PHCGutTFWFeRhELDBX760WplszfN/phkvXEH/eeU+LRDyAb4YAiIFwuN3SDR2q0dHVt6ZwfCKotHqlZFpG5MI8EvNzRfnSxCmic2pzbeI/qOXg+BelUrKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VsT+m5VT; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VsT+m5VT"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso3254847a91.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 23:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786430275; cv=none;
        d=google.com; s=arc-20260327;
        b=kOUXtITd3Blet8zqJyjMPL76zpvNkROSPI7c3dH+T/KnKqlcNSHMblu3EC5WOIne7n
         C9f3HvOcoZPv+rdpUlTDHotuUba28mwWAkgGHxh8/lpXOXcwtsw4XCPaQ+bHXewZlSIc
         O/bRYudchjSNzK6127oJeg4HafVL74ZfAw5gruONP5wWckmzvY/gs9rjHC5BOSPGAwcw
         JCgXrBoY5JvETZSr9kUxQeCna2f58ixkDfh6s19EWcnb3uM13YgMadYRqAsGfkE/v8N+
         Ef/ufAaVnuSN3FYLsSwOk6kcHakhPGNN2x6/TJi8yw0gEsnJIx6sVCAgfDb6Sk3dRBp+
         C5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZB/s4/aRCVLVr2j5qEoUY0hqCjPRYQeiCHNsJ2HNwOA=;
        fh=kjyJp+fXOhYIecY1Tbac6YXyNBPCkJkWLPb8JtSxco4=;
        b=ryNBvzvsPwL7rwA9h/dG6s+CN8B/EGxlCFJmiDyP/XoFSH8zKI16mOny+ueEB7+BGP
         z4qeRwHYDBVAo8PzFCMO4CzrgT0tgNC5zRD0UuTox3JwnEpZX15dZN/DCeEjJImsBhBd
         AYPj3Jf9+gT3pOCW1PDMiz45rQW9CzuxfljHhq/gl3DzAT8IZzxSFWqTVp+pgqiEbule
         xW2KNjnIJDDyGiPDPGW6t/u6OTC4zPmMRm3gimpp9d4G9pJi4ibfSCPZL0vYWxJ+jNen
         OlA383jq56d5ssY4YvQ1QC6yYoTkTkfQASWQMQpEqRjdP/oppHTfnLYvH+EKIMssoUew
         SDhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786430275; x=1787035075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZB/s4/aRCVLVr2j5qEoUY0hqCjPRYQeiCHNsJ2HNwOA=;
        b=VsT+m5VTYI8ABbCtVNaIbNAcfwTUL5D3/puNGfoqkX1BNxT/KDf3kJh6bG47oO0PaV
         S/CJgAFsHzAJw7hYg5rf0AzFvnYRg1G38c2wWzWUobklqc4w/MxazGlYnpklrYP4MIob
         3Xjdu64i+vOOLLosjGapBkScjaQT/B0pMb02ofCyRZAVhTbZsXGrHjEv0/lNkHNrOo7k
         UdxwgF8ajvy342AJMqtqpFxoNTj/EMwzIj7Axbx1NJXZ6FajWEfX/Hb7vataHyDxPbSL
         aqpQqTuzhlMtXwM3N3Pl0iCb6BoDhP9IJFeE5f0oNcBkzErmdUz/iel5bJJJB/cSDjGw
         DALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786430275; x=1787035075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZB/s4/aRCVLVr2j5qEoUY0hqCjPRYQeiCHNsJ2HNwOA=;
        b=KC0dYC88SEUSzPDNng8+k6T8+1+A4V1QOim+YndK+kxtjQe4mMDeurldowCfkkyGLT
         iIefa87qYv8iL2xTE/FvTs0kbOvKTQF/2qJTtwNt0rNrTuf6h8P031lOk3un/AsmK81q
         vLm1B8S4v8fzWE/yw10H2S1zusFoJ7ee0dk5mTwbC8nQEv7VRiy4lAswBnYtuvKlZ+MK
         51W38ldfIg55QJqZroAnD5qKg3XtAhPW83CWNKljAPlH1A5oGXEsPdM6XT46CJoS60fc
         y4L+DTxHuB0DdNqDnTU9Zms1Wlsel0cQyRML3hXc6cDzntzmSSEV/35if/p+TvE8Se8s
         c+OA==
X-Forwarded-Encrypted: i=1; AHgh+RoPmJccT7VIGG30LW/Ee/4Ul1VeRiykY0kHih41dkdiOFPECo33E44V4KpaFuQm99jHj2Xcvm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVT97tmyat1rW0l3L7o1Gfuguhuv0uC3cYgsBMl4J1iirX2to9
	Bi5cg9PWubbMkQIDgSS3vgrJEEW9Xxf98Ib9lDaBBqC17905oxjn+QzMMD7RBRR2w0YDBAedVJr
	5KzXh3X0pDcmJdVXz5GXbvvuBvdRwrEpS24pnDLhq
X-Gm-Gg: AR+sD13cDYVZnXHW3InguTkBFwsXNLjnqgDb/6SuC+rF5quvLzN0ea7UnU4Jsax3wz2
	ajqASgnwro6zeregfQlx8AK7/OCpw0kn7tprjAchH6tV+gEc5JIK+KffkUrD4DMQbAIt8i/tyhi
	XrfhgKMtQKmIcxS2+Pu0sImZeTB2DrHCHwHJLnrUprD4qwbltSqqTmwtE6N5f74UzMLV15kxzIh
	Du3ALyQ5aqpwRkbCmoFnR1zZKlIUNSjzVigExpVp0ngSJcI3Q4ieqXC6FqokAZiGDFkZO1vQCiB
	6K7ZIacclr4Yy3KUZJhsB6D2e4BajkDIAni/fFmgk8XKOPb9jPgSgQdkE5O6QwewBtsJs89nJtg
	M9z5I7wLXhwzZV36K9/htHTAElTh94yuhRtVU1F1vTEDhni34D/k2joDS6P9N2nG+nmEyHXyNyX
	OeBJmA1T02Pl1sqbmH8RvFthpc
X-Received: by 2002:a17:90a:d2c6:b0:380:7688:fbe9 with SMTP id
 98e67ed59e1d1-392ec50d0eemr1203812a91.8.1786430274675; Mon, 10 Aug 2026
 23:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810205642.1611338-1-ast@fiberby.net>
In-Reply-To: <20260810205642.1611338-1-ast@fiberby.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 10 Aug 2026 23:37:41 -0700
X-Gm-Features: AUfX_myuORM4_TTay9la_BUP_d63ySucdaQn_4RJibiLt3uKswUtb14idbALtWQ
Message-ID: <CAAVpQUDGPtKhv9XfiKgKg7NOqHGzSb4vs7ApQ=rf-RzbaCDQWA@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: reset late connection after listening socket close
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kristian Nielsen <knielsen@knielsen-hq.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 1:57=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <a=
st@fiberby.net> wrote:
>
> In commit c82199061009 ("task_work: remove fifo ordering guarantee")
> Eric removed the ordering guarantee, thereby changing it from a
> guaranteed FIFO to currently LIFO ordering, in an effort to reduce
> jitter.
>
> This significantly increases the probability for a race to occur
> between a TCP handshake and the closing of the listening socket.

I looked into the repro, and the description above is too specific
to your reproducer working on localhost.

In your repro, a server creates a listening socket, accept()s
some child connections to get multiple file descriptors, and
exit()s the process, which close()s file descriptors from listener
(smaller fd) to child fds.

The last fput() queues each fd to the delayed work, which is
currently executed in LIFO ordering.

The child fd sends RST to the client and later the listener is
TCP_CLOSE'd.

On the client side, it tries to detect the server's exit() by checking
RST on the established connections (child fds on listener), and then
creates a new connection, which creates a reqsk with the alive listener
but the last ACK will hit TCP_CLOSE'd listener.

I checked the last ACK generated by the repro fails at
__inet_inherit_port() OR inet_csk_reqsk_queue_add().

That's why reverting c82199061009 prevents reproduction because
it's too late to create a new connection when the client notices the
listener's exit() via RST of child connections; new connection's SYN
always gets RST with the revert.

So, I would drop the description above and simply explain it like

"When __inet_inherit_port() returns -ENOENT, the new connection
 is dropped silently."


>
> In that case the client sees the connection as ESTABLISHED, however in
> tcp_v{4,6}_syn_recv_sock() the call to __inet_inherit_port() returns
> -ENOENT, and the new connection is dropped silently by put_and_exit.
>
> A client may therefore hang indefinitely on a blocking read() if the
> used data communication protocol is initiated by the server, like SMTP
> and the reporter[1]'s MariaDB protocol both are.
>
> Had the new connection been processed before the listening socket was
> closed, it would have been in the accept queue,

or inet_csk_reqsk_queue_add() should have sent RST.

> and been notified when
> inet_csk_listen_stop() was run, and the client would have got a reset.
>
> The call to __inet_inherit_port() returns -ENOENT because
> inet_csk(sk)->icsk_bind_hash is NULL, after inet_put_port() has been
> called by tcp_set_state(sk, TCP_CLOSE).
>
> This patch adds a check on the return value of the __inet_inherit_port()
> call, and jumps to a new label, where it resets the new connection,
> before proceeding with the put_and_exit label.
>
> The blamed commit was identified by testing on ancient Debian stable

This commit should be more appropriate since __inet_inherit_port()
did not fail (except for OOM) before this commit:

Fixes: c2f34a65a61c ("tcp/dccp: fix potential NULL deref in
__inet_inherit_port()")


> releases to get a rough scope of where to look, then identifying in
> which release between v3.16 and v4.19 it broke, and finally bisecting
> v4.2..v4.3 on a fresh Debian then-stable (jessie) VM with tooling from
> that era, and confirmed by reverting it from v4.3, v5.10.y and net.
>
> Additionally the race can be reproduced back to v3.6, by backporting
> the blamed commit. Beyond v3.6 there are too many conflicts.
>
> Reproducer:
>   https://files.fiberby.net/ast/2026/kernel/socket_teardown_test.c
>
> Reported-by: Kristian Nielsen <knielsen@knielsen-hq.org>
> Link: https://lore.kernel.org/87sf0ldk41.fsf@urd.knielsen-hq.org # [1]
> Fixes: c82199061009 ("task_work: remove fifo ordering guarantee")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> ---
>
> While the blamed commit properly only made the race observable, then
> the commit that made the race possible is less realistic to track down,
> and I don't think is worth the time to continue to the search for it
> somewhere before v3.6.
>
> I'm not submitting a selftest at this time, as I have only found an
> efficient way to often detect the issue, not disprove it, and I would
> need more test data from different systems, before I can reliably
> disprove it with a low runtime budget, without getting false negatives.
>
> Changelog:
> v2:
>   - Use return from __inet_inherit_port() to trigger send_reply()
>   - Use req->rsk_ops->send_reset.
>   - Clarity commit message, and update to reflect the changes.
>   (Thanks Kuniyuki)
> v1: https://lore.kernel.org/20260807194513.1263310-1-ast@fiberby.net
>
>  net/ipv4/tcp_ipv4.c | 8 +++++++-
>  net/ipv6/tcp_ipv6.c | 8 +++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index b8887cdd66c5..e0fba4579a57 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1690,6 +1690,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock=
 *sk, struct sk_buff *skb,
>         int l3index;
>  #endif
>         struct ip_options_rcu *inet_opt;
> +       int ret;
>
>         if (sk_acceptq_is_full(sk))
>                 goto exit_overflow;
> @@ -1756,7 +1757,10 @@ struct sock *tcp_v4_syn_recv_sock(const struct soc=
k *sk, struct sk_buff *skb,
>                 goto put_and_exit; /* OOM, release back memory */
>  #endif
>
> -       if (__inet_inherit_port(sk, newsk) < 0)
> +       ret =3D __inet_inherit_port(sk, newsk);
> +       if (ret =3D=3D -ENOENT)
> +               goto send_reset_and_exit;
> +       else if (ret < 0)
>                 goto put_and_exit;

nit: Please move the -ENOENT branch inside (ret < 0)

if (unlikely(ret < 0) {
        if (ret =3D=3D -ENOENT)
                goto send_reset_and_exit;
        goto put_and_exit;
}


>         *own_req =3D inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
>                                        &found_dup_sk);
> @@ -1784,6 +1788,8 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock=
 *sk, struct sk_buff *skb,
>  exit:
>         tcp_listendrop(sk);
>         return NULL;
> +send_reset_and_exit:
> +       req->rsk_ops->send_reset(newsk, skb, SK_RST_REASON_TCP_STATE);

Sorry, I think this can be direct call, tcp_v4_send_reset().

Also please pass the listener instead of newsk, it's more
like a call in tcp_check_req().

Same remarks for IPv6.

Thanks

>  put_and_exit:
>         newinet->inet_opt =3D NULL;
>         inet_csk_prepare_forced_close(newsk);
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 9e9155b1b3aa..021c93de2273 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1400,6 +1400,7 @@ static struct sock *tcp_v6_syn_recv_sock(const stru=
ct sock *sk, struct sk_buff *
>         int l3index;
>  #endif
>         struct flowi6 fl6;
> +       int ret;
>
>         if (skb->protocol =3D=3D htons(ETH_P_IP))
>                 return tcp_v4_syn_recv_sock(sk, skb, req, dst,
> @@ -1512,7 +1513,10 @@ static struct sock *tcp_v6_syn_recv_sock(const str=
uct sock *sk, struct sk_buff *
>                 goto put_and_exit; /* OOM */
>  #endif
>
> -       if (__inet_inherit_port(sk, newsk) < 0)
> +       ret =3D __inet_inherit_port(sk, newsk);
> +       if (ret =3D=3D -ENOENT)
> +               goto send_reset_and_exit;
> +       else if (ret < 0)
>                 goto put_and_exit;
>         *own_req =3D inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
>                                        &found_dup_sk);
> @@ -1547,6 +1551,8 @@ static struct sock *tcp_v6_syn_recv_sock(const stru=
ct sock *sk, struct sk_buff *
>  exit:
>         tcp_listendrop(sk);
>         return NULL;
> +send_reset_and_exit:
> +       req->rsk_ops->send_reset(newsk, skb, SK_RST_REASON_TCP_STATE);
>  put_and_exit:
>         inet_csk_prepare_forced_close(newsk);
>         tcp_done(newsk);
>
> base-commit: dd057113ac7ba5bdd2aed3d9405305911152f911
> --
> 2.55.0
>
