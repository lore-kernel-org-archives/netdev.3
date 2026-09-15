Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA04416865
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 04:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789447120; cv=pass; b=EDkaGVC4zTUYOB1o1YBMtIr8knJk7If59pZAVghfBWscFpHTUX8QBWuG1gELnMHF8gVZDkzCAaVk9umu9IUzF8hFr3jOSZuSiUEMxlqW2jKe8gZ2URZgYn4T4ttG2mlBEuJav5/BRtWTcORKH1Uhyvg/tCDzx2tjp6cjjEED5cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789447120; c=relaxed/simple;
	bh=754RD20EUwPDktjEAbnVK3U6f50bDEtQHjripWS2SJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axV+yDs3AafZD6+JtzXi326qbjIvABgDG1SVyaTaJj5Qr3NkYEmZdXdmGFrKaoSz2AZv4NApvd0+nEO5Wji1z27L6cQxLRw+bPv72M6CThM/pmKwzEoJzXui48TJg8KJNCBklPXebyLcq7Zio/vhoyqk6elbXIkMDW1l9whuSlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEh/1y44; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEh/1y44"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-39647184c73so478782a91.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:38:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789447116; cv=none;
        d=google.com; s=arc-20260327;
        b=Td7q+K8Im33crXM+zsF44MEzJ1zKRZm1tAtlMxO7OmWn9dqJocmDnqfKlW5Yy97oOL
         CLiKFyVNwoQQF6bVaPJIE7LvENeudePioqmi9woIp8P/bBK59h2nSZHCfVNGShWYWaRO
         6lc4OrlabWuV2OFRuJ8U1Pexp+hjZgoxXVA6vHymLufLdAt2gv9elqSWeNf6rOmaPUJg
         iTaNzsXVt37RbI1wLh00LwGh5RFeYa22gZdLgpiG53/MtP57AQxaWkD+0QmNBpWwR632
         Ixm2KfK4pg0Ce0Gobx0WKKOfeLlnKuInTQbxMhx0DnNjdb9o9evM/mIPUOX+qR7xAq8q
         E+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BMKFmF5KCHiIlxIMpy44JXswv+h3NvvDCY+aouRDvjM=;
        fh=yO3HkAob2DQd3wesCFMBZ1GMGczKcalk1eJQzpivSZY=;
        b=dZ3TOTyxzdT9Ka4p/1WakKbKgmehqZp5hZrY7IbkrpNvsvnYeWyooN/Tgk3xWcQQnr
         TkRZxiTN91j5vSF2wDeT/A2i5yBIpz+FeS8soLrecpvI9UgIf5L62FP/jW39O7rWt+OM
         JryJv5lBAsyf7C8s5nlZBBimeVnMEG0BHCEUdSQLQz9Z7TeB1c4W35hV1HEzlaUaLL0T
         6F/0BDxyacT1XYQV523pZDefMF1Zwyi8p8uMqQ91lvulM0N/r/mBMl6Md19fPDiB8LtY
         dLdAXyaXwK2J09kDi6ZRAKsr191udfJq7jfEUjFqa9gp/3tG145DCD5dBzgM2zvBN7he
         sbXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789447116; x=1790051916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BMKFmF5KCHiIlxIMpy44JXswv+h3NvvDCY+aouRDvjM=;
        b=kEh/1y44O7797HmcCJE4P0JqKjrqsUNSIHvfO7AdlthdwdU8BSlXsto2B5AUfYMqma
         mMfXzNwtuR997C13u7RrLZ5Ll1Cuj2PG9razyAhnfwaSV4vJytgjdl07vT83OrNgFjUi
         8YIM/3mPiqi+xhfLO6N0A+tQC9XhoNG9/Oe4c6O4YV/0Vl9O8omgLfNvLoBqfhiJS0p1
         HEqLih0Qw8ZXh/jxn/KYAZFc7ovP++byK+xBDkEWfNgB1EYXDdISmBBWVzvbd7Rqspns
         eq1GrzrCiRPmfNUkb0zc7v+7KunBLGHPazgbBbjLZ5eZXvzWkIGWeNhtBbp/QNNIfOrj
         ypVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789447116; x=1790051916;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BMKFmF5KCHiIlxIMpy44JXswv+h3NvvDCY+aouRDvjM=;
        b=ebRVXwNipTTXpFmvCp1KRBF3D9szJGY/lRdA148c+q+B9O9J81BnLvkO20acI4dnG3
         ag3GFTlwGsfjqA9ngmfaYbCX5ZSjf7LNUpQqLdHFlc1m9sSnHMc2I939m+VAnEzijdOW
         nXp3SKzPbGSLnXzCeouL/lq0WPL+FbL6Dq19Syl2f5JB12Pjf5dNfmUtL8NEuxHCoDG+
         LdsibkPZfS3eNPxcSQmDvq4pi+rj9sPQOcGp07/ZlNkgmKtTOykA83/+i1xVuiHUS4ph
         K+DC8G07UYCbd3BYoTOwBTmn3tyores78q6fJ3i5dskUnIgg0E+omAglTfdMieJnkhPp
         3sYg==
X-Forwarded-Encrypted: i=1; AKwUvBySZB+5LqFDfN8kvLmNUuczt4ARIJi2pz17BJ/8wWRizQb9zSn+/UKbLuT4CKMsYTvqFXtBOE0=@vger.kernel.org
X-Gm-Message-State: AFuF++no1q8OgJ8H+6ba4zif955Sac4iz/vC087EQL+IANd8hJh8Kl7H
	+Fk2fsD51nxXluFJVRcsG2ruKcXT7WoYU99DxNx+lqMrOECuYH1PbAlGjA5qzaLojQ7O//0CDLb
	fh+FktWg+zspz8oruUgJUIbLqyDxN9o8ydzSU/oivxGW09gCqdzgX3WYgpvA=
X-Gm-Gg: AYBFou15QnJE9UiLrJeAwwb6nihvm42+QKNOSjv5nhMsaECi0/tAjwvSojnBJeRD+Mu
	sqZ57Pe6/Mskv54+kv0pKmveF1ZXt4DxUlec2tLNJv75CgiKen2O2FQxYXBXHm4xM031hCMIfph
	AiuPvSniNbRMZK236v4U5ChiRWQ1Y1HA4dBMZI1nLUlhbZXD/YZr0ugg3CHZAbkLwsF25qe4aT2
	HT3/YXXGvoK/hWzXlCVnzJapz3iqyVUVu55ob+oeWVcU9iRHHkM0DnBQlgBk9eEfXP48yug2il9
	xqBAnFDrJpO/BoayKsWspFfMtvlbRGLNg9v9CTM8c360sQresGdKAwAg1OOZqdAxjCZ1jkxRvqp
	4Yhkf1pGRDBONy9Z4d7owFF5pE6418Bl4p9NpZP1LKSzWzg0P9JsPIKymhS4529y7SkgE
X-Received: by 2002:a17:90b:2e49:b0:39d:e7c7:8044 with SMTP id
 98e67ed59e1d1-39dfe189a3bmr3550198a91.17.1789447115623; Mon, 14 Sep 2026
 21:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914011420.115556-1-kuniyu@google.com> <178943491051.22033.2295775938786012621@kernel.org>
In-Reply-To: <178943491051.22033.2295775938786012621@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 14 Sep 2026 21:38:24 -0700
X-Gm-Features: AcwNN1VHpfsfyFv1DP2jVX5HqQ_6qE0O5kwZzDWFd5ShsjI44XaZ-MA7Y9umAjs
Message-ID: <CAAVpQUCZgovYb9pOPry+o-sjV2SKEDt8Yd-gfJvt1F+zNJkUVw@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Don't call skb_clone_and_charge_r() for
 close()d listener in tcp_v6_do_rcv().
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, ncardwell@google.com, horms@kernel.org, kuni1840@gmail.com, 
	netdev@vger.kernel.org, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 6:15=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> - [High] Incomplete fix / residual TOCTOU race in tcp_v6_do_rcv(): the
>   new guard is a state *blacklist* (`!((1 << sk->sk_state) &=E2=80=A6
>
> --
>
> tcp: Don't call skb_clone_and_charge_r() for close()d listener in tcp_v6_=
do_rcv().
>
> The patch extends the guard in tcp_v6_do_rcv() so that
> skb_clone_and_charge_r() is skipped for TCP_CLOSE in addition to
> TCP_LISTEN, closing the window where a concurrent close() turns a listene=
r
> into TCP_CLOSE while the lockless listener path is running.  The commit
> message notes this is safe for non-listeners because tcp_rcv_state_proces=
s()
> drops the skb for TCP_CLOSE.
>
> No Link: tags are present in the commit header.
>
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index df9c29eb5c1f4..7fa4ed2fd4f16 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -1604,7 +1604,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff=
 *skb)
> >          by tcp. Feel free to propose better solution.
> >                                              --ANK (980728)
> >        */
> > -     if (np->rxopt.all && sk->sk_state !=3D TCP_LISTEN)
> > +     if (np->rxopt.all &&
> > +         !((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
> >               opt_skb =3D skb_clone_and_charge_r(skb, sk);
>
> [Severity: High]
> Is TCP_CLOSE the only other state the lockless listener path can observe
> here?
>
> tcp_v6_rcv() calls tcp_v6_do_rcv() without taking the socket lock when it
> samples TCP_LISTEN:
>
> net/ipv6/tcp_ipv6.c:tcp_v6_rcv() {
>         ...
>         if (sk->sk_state =3D=3D TCP_LISTEN) {
>                 ret =3D tcp_v6_do_rcv(sk, skb);
>                 goto put_and_return;
>         }
>
>         sk_incoming_cpu_update(sk);
>
>         bh_lock_sock_nested(sk);
>         ...
> }
>
> Only a socket reference is held across that call, so nothing pins
> sk->sk_state while tcp_v6_do_rcv() re-reads it.  Can user space move the
> same socket further than TCP_CLOSE inside that window?  inet_shutdown() o=
n
> a listener falls through to sk->sk_prot->disconnect(), i.e. tcp_disconnec=
t()
> -> tcp_set_state(sk, TCP_CLOSE), and a following connect() on the still-o=
pen
> fd sets TCP_SYN_SENT.

This is yet another bug due to the buggy transition we forbade
in 8cc3aef0cb19 but only in net-next.


>
> If TCP_SYN_SENT (or later TCP_ESTABLISHED) is what gets loaded at the new
> check, the blacklist passes and skb_clone_and_charge_r() runs with no soc=
ket
> lock again:
>
> include/net/sock.h:skb_clone_and_charge_r() {
>         skb =3D skb_clone(skb, sk_gfp_mask(sk, GFP_ATOMIC));
>         if (skb) {
>                 if (sk_rmem_schedule(sk, skb, skb->truesize)) {
>                         skb_set_owner_r(skb, sk);
>         ...
> }
>
> sk_rmem_schedule() and skb_set_owner_r() -> sk_mem_charge() ->
> sk_forward_alloc_add() perform a non-atomic read-modify-write of
> sk->sk_forward_alloc, which is the same accounting corruption behind the
> inet_sock_destruct() "sk->sk_forward_alloc" warning quoted in the commit
> message.
>
> Would a positive condition be more robust than extending the blacklist,
> for example bailing out of tcp_v6_do_rcv() when the lockless listener pat=
h
> observes sk->sk_state !=3D TCP_LISTEN?  That would also match the comment=
 at
> the top of the function:
>
>         /* The socket must have it's spinlock held when we get
>          * here, unless it is a TCP_LISTEN socket.
>          ...
>          */
>
> On the same window, does the TCP_ESTABLISHED fast path just below become
> reachable without the lock as well?
>
>         if (sk->sk_state =3D=3D TCP_ESTABLISHED) { /* Fast path */
>                 struct dst_entry *dst;
>
>                 dst =3D rcu_dereference_protected(sk->sk_rx_dst,
>                                                 lockdep_sock_is_held(sk))=
;
>
> The lockdep_sock_is_held() assertion, the RCU_INIT_POINTER()/dst_release(=
)
> of sk->sk_rx_dst and tcp_rcv_established() all assume the socket lock is
> held.
>
> Should the state reads on this path also use READ_ONCE() (or
> inet_sk_state_load()) instead of plain loads, given the socket lock is no=
t
> held?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260914011420.115556-1-kuniyu%40google.com
