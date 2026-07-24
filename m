Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FAD43BDAC
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913980; cv=pass; b=M6YSa7CW6jWTYd2gR1sD1KslExMCjiFjhvL7LBN2l3ETPGd52Eb+bPSwFPKzzQgARxyYom3IZO+NR1kiHOu/GU4t/svLQ625VoWM0m5e0tiB8ogRtsrv9YeIoNaPUoEA0vgpxu50KlWHQwkcLwImKmi5CgFrf0UftOxDw9jsAt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913980; c=relaxed/simple;
	bh=aHYPbE/oBZ0kVltV3okhiPgNedRE9DhC6wGTTZk1z80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaJbPXl77PlL6Xw5o4kLdn8bMu2jr4ZXY1ezHAbhuzQL6BAup2lgyV5ju39QI2bw1lXwlv9QJQz00yPq0c43TJTv67I9Vfl4cz1gSCjCvK5R6k+iyMR9TtgF0Ae8328WCFuipk3lxkL1CMFvZ3p7RT3YYMPn7hvSyI/Uzn1cJMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rfrbd80C; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rfrbd80C"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ccdf36f63dso7745ad.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784913971; cv=none;
        d=google.com; s=arc-20260327;
        b=Eo87sDu1niaPsYtN5YnUs9K59HNqW8p+a9+wtBO8Wfj/K+2JA2U5n7DqZ44VL+opVv
         LYD9EzRBzII4VnncR1sc9yOzCspBS5EaMUebBp544C7JHXKcETrnzbTK7PCHcA5v/IOe
         HT1VOS0m+sI76xRre6YzjLnkuYsSeiU7HTXAALW1rTad4r/s/K4xhB99RNABNll9oKX2
         XH616P+rD6r5snYXDi+qrmApRwz4TJs46jxsXECaThOYXPTqD3Ze1ICblJRsZTArylMQ
         PD+aUh+4am13ujvUbxit7RTeMeg98ooysXGcxejI82SR6FiYaoz9N+VSNVdo2959zlyF
         hF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jxn3tGMGaHXd7qz9sNqVHuvHKSZJQEuwSe+HgOlTgII=;
        fh=PPLu39qsVdUKQDuNXwORK2LkXe63zs1IclJjnAEFTfU=;
        b=n8lsOPc/UwIpjcZQb6s5QQRekzXBaVu9E7I0YMaSDsnIrOcQzVwHkUOmPWKL553dCf
         03f+D4uGD2jDcZ3rz240vNfq9heDckktdmJXcMX1NjRj6hgIR3A2xBYwnkGnMYFVQYQt
         SFjg81T9Wov5m9/55wjfMtWv4YZpGuRES65ANk1e4JriXYrR57dc1rxPtivcJA1WPLTE
         feVCZ40z5+gJk+XQl3/54r3UbyKF015ZbhCGsxrGOmHk5JQ9ZwXHGz82TgXhs05mEaMC
         bD2y8Miw8LZYEO89OQYkyjdP5LWqD2B7t5gCgYoAPQq2nb8V//7wnYXT9F/9ErvXZ1ox
         G7KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784913971; x=1785518771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jxn3tGMGaHXd7qz9sNqVHuvHKSZJQEuwSe+HgOlTgII=;
        b=Rfrbd80C74V/LbQeRKaRbL/uYng2piPgsh47zE32uJMbSItPERJFyZw/99Yayx4ZGK
         iRqN3FGw3dlulTbUuLt1+pak2ZtK4JgqVTNVX57b8K8VerlNZ94XNdSxcFkVx+rCWHsJ
         ng9SFqUZinjII+YUHXPg8arOk9rUFgNIR7KTDq1x0WcAZC5yalEA2vMRfRmJOas1poxz
         MJ0kwqR95PLx/PEQtGC/fkkfT4txDkDyiX/xaP+XQmzGiq86eEGNoWmkVlwNUajhy8C6
         hKpcmi0WPIKLb/NXmkUIDV8elfZty3mhBGBfvQMSxoMIZkPeSAqfHk9bmzlSYGXWYTcM
         5J/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784913971; x=1785518771;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jxn3tGMGaHXd7qz9sNqVHuvHKSZJQEuwSe+HgOlTgII=;
        b=rYV64aul/kJ9g9qvxGKvrqh3xJLy6hcYKyofH1ef98pPNMajiqgcAyZSlTA6V4cILB
         OtZgcP/ugCCD11qW94adRvqXPXNdTjvPuW94eXk8R5ixF3Toj+4/wdEVTcrsjAbkshvK
         Z3ptq3yMfglmbN3pCKnLGLk9m6rBX6vVi5LO9KOp1+hVuXC5JxAKpUz+ulmsot4LqijJ
         ajf0JOI+Or3P3gh0GsbwyI1XhpQWyD04fdU6P4kbmBcRJD/VI+Tx9KB0I7ud2WKKvBxS
         EdOpPpXYlFJgXtvm1/B3xHIixGi6l9SdIKjuhIz8CdNMob3L53a8LP1iYQKZxmzJj2w1
         o6JQ==
X-Forwarded-Encrypted: i=1; AHgh+Roec1Ezu3Veaxso1vH/7uqJ05hilMiJ+diWdzBfOLZ5o2d5qBS1oq1/Uiahl9THMeDh4YU5ALU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqkcr1at2Kzl2u/HckPaYs/ytfCJnQ18xi9Ldclml9QgN0Dfss
	avcXMupcrFvw2Y1Ojglmtb7wLnZG6PnpH0vHTASBUJZtfK849ODu1W7VMkNXJVyg1qxGli7QcoI
	/cDJTJSdlmD/0wu6+TO1ZzJQ3C0QHJrCAQKx/SzH2
X-Gm-Gg: AR+sD11eXazKaLzirq/xjTB+JAEuk873jhK7brHZuMM9Pa2ofB6nwUFt6uCTzGLMuQW
	yGR1UmQXCaoOo55wOe3s4Ni9+vgjqEaI+OKOjfAJjskLSAAxT04kKXyk51Qij3+UlUDtt+p+coV
	aazQymieQOW/F5IMGlG/7YM07buSUKGMPTmerOHpXKBZmvKlBinULpTRgFp5bJ7vkFb2H1gjNAk
	OS0iKPloMOXFah2/T+T8G0Em3nHBzkmGRDMq+7udr6Jqrv55IrtVSsIAQJoVO7vdMs5p7dLxRnZ
	heQ1QXh2/vi2Q/s=
X-Received: by 2002:a17:902:f1d3:b0:2c7:9e6a:1a8d with SMTP id
 d9443c01a7336-2cfdb75acb4mr172415ad.12.1784913970689; Fri, 24 Jul 2026
 10:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <06f0d5ce07dd8593a69239cfa56745cb9c7d957c.1784717791.git.asml.silence@gmail.com>
 <CAHS8izPiZ_1aysWG-up6eW285+MzJN17L9QREfVWgRLkdqL5sQ@mail.gmail.com>
 <amJOXKql1nbskGZJ@devvm29614.prn0.facebook.com> <CAHS8izOAgMX4wSbyUpSLGD_uo7G01cSqnMvrXP9KDdhrYrjNCw@mail.gmail.com>
In-Reply-To: <CAHS8izOAgMX4wSbyUpSLGD_uo7G01cSqnMvrXP9KDdhrYrjNCw@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 24 Jul 2026 10:25:58 -0700
X-Gm-Features: AUfX_mw1qF044Nu5R0DF9LFJaOk4sD-GU2uFvOMxN7Z4oR-fkQDzkOTcut-_8bk
Message-ID: <CAHS8izOS9C63UMvVN=Z+enWkwFhPr9Aa69UZE4dkUOL_JyGUGQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: devmem: prevent net-iov / page mixing
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 11:35=E2=80=AFAM Mina Almasry <almasrymina@google.c=
om> wrote:
>
> On Thu, Jul 23, 2026 at 10:24=E2=80=AFAM Bobby Eshleman <bobbyeshleman@gm=
ail.com> wrote:
> >
> > On Wed, Jul 22, 2026 at 12:49:07PM -0700, Mina Almasry wrote:
> > > On Wed, Jul 22, 2026 at 3:59=E2=80=AFAM Pavel Begunkov <asml.silence@=
gmail.com> wrote:
> > > >
> > > > We should either have net_iov or page backed frags in a single skb,
> > > > otherwise it blows up down the stack. Don't allow mixing in
> > > > zerocopy_fill_skb_from_devmem().
> > > >
> > > > Fixes: bd61848900bff ("net: devmem: Implement TX path")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > >
> > > It's true that we don't support mixing niov types and doing so would
> > > blow up, but this is an unnecessary defensive check imo. The calling
> > > code should not (and does not, I hope) have an edge case where it
> > > tries to mix and match niov types.
> > >
> > > Maybe a DEBUG_NET_WARN_ON check to help catch bugs in the calling cod=
e
> > > may be fine?
> > >
> > > Also we don't really support mixing different niov sub-types in an sk=
b
> > > (like IO_URING + DMABUF) afaict, so might as well go the extra mile
> > > and check that it's all devmem niovs specifically.
> > >
> > > And might as well put the check in skb_add_rx_frag_netmem. It's the
> > > same situation on RX, we don't support mixing there (and I hope no
> > > code path leads to mixing today).
> >
> > Hey Mina and Pavel,
> >
> > I was able to confirm this mixing case does exist.
> >
> > It looks like in tcp_sendmsg_locked() when new message is non-devmem (z=
c
> > =3D=3D 0) and tcp_write_queue_tail is devmem, the skb collapsing is all=
owed
> > (though same-frag merge is disallowed).
> >
> > Adding a mode to ncdevmem that sends mixed devmem and non-devmem
> > messages, it can be caught hacking this in:
> >
> > /* DEBUG (DROP ME): detect a TX skb that mixes devmem (net_iov, unreada=
ble)
> >  * and non-devmem (page, readable) fragments. Such an skb must never ex=
ist.
> >  */
> > static bool tcp_dbg_skb_frags_mixed(const struct sk_buff *skb)
> > {
> >         bool readable =3D false, unreadable =3D false;
> >         int i;
> >
> >         for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++) {
> >                 if (skb_frag_is_net_iov(&skb_shinfo(skb)->frags[i]))
> >                         unreadable =3D true;
> >                 else
> >                         readable =3D true;
> >         }
> >         return readable && unreadable;
> > }
> >
> > static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb, ...=
)
> > {
> >         ...
> >         BUG_ON(!skb || !tcp_skb_pcount(skb));
> >
> >         WARN_ONCE(tcp_dbg_skb_frags_mixed(skb),
> >                   "DEBUG: TX skb mixes devmem+non-devmem frags (nr_frag=
s=3D%u len=3D%u)\n",
> >                   skb_shinfo(skb)->nr_frags, skb->len);
> >         ...
> > }
> >
> >
> > Resulting in:
> >
> > [   85.908005] DEBUG: TX skb mixes devmem+non-devmem frags (nr_frags=3D=
2 len=3D24)
> > [   85.908342] WARNING: net/ipv4/tcp_output.c:1570 at __tcp_transmit_sk=
b+0x9bb/0x1030, CPU#2: ncdevmem/278
> > [   85.910646] RIP: 0010:__tcp_transmit_skb+0x9c2/0x1030
> >    ...
> > [   85.915617]  tcp_write_xmit+0x47b/0x17d0
> > [   85.915802]  __tcp_push_pending_frames+0x38/0x100
> > [   85.916025]  tcp_sendmsg_locked+0xe51/0x1280
> > [   85.916244]  tcp_sendmsg+0x2c/0x50
> > [   85.916903]  do_syscall_64+0x11c/0x610
> >
> >
> > My feeling is that we should guard against this when
> > tcp_sendmsg_locked() is doing its "new segment or not" calculus.  In th=
e
> > zc =3D=3D 0 case, I think we need to check if the queue tail is unreada=
ble
> > and 'goto new_segment' if it is?
> >
> > This is a different case than Pavel's patch addresses though, where the
> > new sendmsg is devmem and write queue tail is readable.
> >
>
> :( Yep looks like we have a couple of bugs in the TX mixing. Sorry
> about that. We do indeed need to fix this ASAP.
>
> I don't think it's enough to check readable vs unreadable, no? Because
> I think appending io_uring niovs to a devmem skb will still blow up
> and vise versa, even though both are unreadable, right? Or is io_uring
> saved from this somehow in both cases?
>
> If io_uring is vulnerable to this as well, then fixing this becomes a
> bit more hairy because this is a TCP fast path. We don't have bits in
> the skb header telling us exactly what the skb memtype is (only
> readable vs not), so we'll have to check skb_frag_is_net_iov(frags[0])
> and netmem_to_net_iov(frags[0]->netmem)->niov_type to check the exact
> type of the skb memtype, and that may be a lot of cachelines to fetch
> in the fast path. :(
>
>

Responding to my question here:

So AFAICT we can't actually have io_uring net_iovs in this path.
IO_uring ZC deos not support TX, and (the LLM) thinks that if we
receive an io_uring zc rx packet and forward it, it's still not going
to hit the tcp_sendmsg_locked path.

So this seems sufficient to me, Reviewed-by: Mina Almasry
<almasrymina@google.com>

--=20
Thanks,
Mina
