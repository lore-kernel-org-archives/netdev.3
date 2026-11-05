Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882598;
	b=iEb4EPefSKjFWiyvjZQpxQm0RqlAkA9F4JGVUVvmL4Dzwc/a68HaB5H8TmXxx5MVxfSm
	 YR8t38kG2Q5lD6+E2z1YfENw7ejpaZkuQuUbImhcimRq9xbqLlnUkRFPzoH33rJvFx9HV
	 YIwGS3gdVUnhhpaE3jPbNyXv2y/UA1lFRW34JYTFkfVMJHq+Tnf8iOJGbbjvpN4tqbfN/
	 M9HrHAeYVx+u31UkRJii8gPOSne1BacYkTsxBfHhQuZFc2HqEdZqjT1/HI22TR64nTjZH
	 qq/DpRiLQKLnas2kALXdsdenp3QKTH4XJciyavKnGh7uRK4urEnO8w/vxrROEwc1gLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=xnR9E2n+Azq4Tige4GthhylmNTRpKTTqGP56EUkM9kU=;
	b=kmBwcy29W2ZprGSdJpoVax/5dFdSOs5gKWImLuyuqeuoq3md8ieHEWMzcNw0WCwib8Ya
	 0/QmCQxFyizbqxH4ghflkVHFlX97m1i7zksnSJV7FAE0ZTVFrE4lBzWhM5qMbnbn/NJ+K
	 n0+97Ghztf21b1ynNhFco9jm9V/+c37+OIEQdR0PImbw8W7RNVVmQ/bwIbyv9iRgiF28N
	 7D0ecAR/qtUAqF3z6ablOgjy/VdM8WsESachVlSiPQ1qESoAJ3kCHuAdyGdXNQLJLQ/1H
	 ydg8OfPBNTYZVfOkcfWlZikzZKP3ZSWwdZIYuNtcHx+qMwxqkuZO3UWVMFdv0ieByqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=peEvLJsJ;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3D6606A331
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 12:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E3D6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=peEvLJsJ
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so1219471a91.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 04:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793882597; x=1794487397; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xnR9E2n+Azq4Tige4GthhylmNTRpKTTqGP56EUkM9kU=;
        b=peEvLJsJq9elNJkOSpl4oVJp5CRGdRJTM2Wn6Ohn/VVyD4WluUyGQocKfwgM+aWqKO
         4UwCJUfrcmA9B7pMzCxuhwuQ7X7LGTv6XE8hbMNIICRVdNpySPB0UkMZGCSL2HTTRktQ
         wX3accB4pDhxAQZYl26Z+uAo1JcQqZuYbjnD40VVPDIgTZypBwsBaqT3/b++7F/ptiVx
         JjIdendZ4dwgSrLq9Unkh1oiBPUDenS6DHhKs1QaAN88KXtMw9WlFxkdpoITypT0OZJl
         yCOLQAaOR18sKzymHAKp7W1pVV4RTClzMQUN5YcAizsiO5JPvclbTxGvwONaEzQ6ZLOf
         q7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793882597; x=1794487397;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xnR9E2n+Azq4Tige4GthhylmNTRpKTTqGP56EUkM9kU=;
        b=tula3IIEwofI8ypMJ4Q96TrsbNKD9scTqVTI3PbtCZvpn+g5B4oF5QDE5qdcWK9hhw
         hfM5FwtMjZQNVXxKrb6ZkUmjGqgDeTzls8l4mN/iX2NNtmnHZpaNctXCEUMMxRZJaOH1
         FGcaF1GUHiIpFGNJla1F2Wr+jfN0WVM+Nz3aR3mwE6ujaFxeDVAv7rA7J+//6T4dad6w
         ROuooRqb8WH7U9oUtw7/8gIvHSMIcTWgDvvy3u0AMsPyQnxUYBuG42XtA+pPPcc/Zm4W
         d/g1RRIhaf0+A66P+YfHUaAacuKNzu4/3b7wW/SifiAgGGV5DcKTNmfeE3u0FfWD6323
         61tQ==
X-Forwarded-Encrypted: i=1; AKwUvBypqTgsk5Yb3hwpxyeBmCVYPaLob4HA02DjRZWGOj606DseQjVN+w/ck5jh7ue95CxyBX71ktM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qcc7GUAGhJU0UuA8Q8fKEuf0O+vzAmKjlHLEGrc5Gn5vVEPYV
	43whOG3quq0BKBc95rEqpg2FkuVd+OcOCy+DGl85dBG7joxu6zHYxbGT
X-Gm-Gg: AYBFou0Ff0m+64OxFDQuk/TC2T9+HJ2HbZKQBtKxKNeck3c2dEff6C37XxOlFEEWcR3
	YqHoSRse2cUJvGPLWh28A6Hh6TGCYVEz7bzgbZoPYerKkKFRKQ5KqueepGS+gTzIm8Sx1eGLB/o
	tv37tO81+HYCftTOYL5u7LpV0U8UoOrrz+JAdQCk68PCAonXONlV/EqSBNYEoLWDIY8Spbif1Os
	Hs0/rRx0cZwprwoftwts4G+m+vbLrqws/EPyOYcpsEtEy1XPdtRB2r3SjaHf/LWuk7+aFWijI6H
	KWYNGdxkvXJ2BtznxzCFw5/WlZdm8e/TjC6O7QJW/nyhBcKe2dPsqDiKbLxgCojGPMmgF+1eDFq
	X2yji1KLLFPnyRHp2VMkfNggomnfE5whUfiQzpQL70WGWncwb8VLDqrOfjisgjICO8WgK7VxSeJ
	WfY6GaE+IVAUKgCTnhTFwm6ovCkTWldFEmX0FbcaJqYGMc0LCPQaoPCFmA/enDzeX/Xjn96mksC
	Eo8q4m7pR1vSolnSS8gA9njvkbqV1oesWJ3n4jai/vd/7HU5+qlB8eI0RzuRQa5W/JrKKsOdVFu
	7WWwp8+SPOayh3eAIvxhZ2unRvztuZeWNE+JCBtFD2gX2Rc=
X-Received: by 2002:a17:90b:1cc5:b0:3a0:bbd8:5ba7 with SMTP id 98e67ed59e1d1-3ae89879e16mr17198920a91.62.1793882597400;
        Thu, 05 Nov 2026 04:43:17 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b31638fdsm3858348a91.8.2026.11.05.04.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:43:16 -0800 (PST)
Date: Thu, 5 Nov 2026 21:43:12 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, john.fastabend@gmail.com,
	sd@queasysnail.net, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] tcp: do not coalesce segments after FIN
Message-ID: <aux54OxzGtGvCFc8@v4bel>
References: <auxx1bK0QJfUvcB7@v4bel>
 <CAL4Wiir3EBEfr6JWxRnp5UM1+MSqsFQcu-8PMtMBxsrvoEkk8w@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL4Wiir3EBEfr6JWxRnp5UM1+MSqsFQcu-8PMtMBxsrvoEkk8w@mail.gmail.com>

On Thu, Nov 05, 2026 at 01:22:12PM +0100, Eric Dumazet wrote:
> Le jeu. 5 nov. 2026 à 13:09, Hyunwoo Kim <imv4bel@gmail.com> a écrit :
> >
> > A FIN consumes a sequence number. If another FIN segment is coalesced
> > into an skb that already carries FIN, end_seq advances to account for
> > the additional FIN, but tcp_flags still contains only one FIN bit.
> >
> 
> Yeah, we have been working lately on this issue (initial report from
> Chris Mason)
> 
> For some reason Kuniyuki has not sent his patch yet.
> 
> > When the preceding gap is filled and tcp_ofo_queue() processes the
> > coalesced skb, rcv_nxt advances to the skb's end_seq. When the receive
> > path consumes all data in the skb, copied_seq advances by the data
> > length and one sequence number for FIN. If three or more FIN segments
> > have been coalesced into one skb, tcp_inq() can still return a positive
> > value after the receive queue becomes empty and the SOCK_DONE adjustment
> > is applied.
> >
> > Software kTLS receive is one consumer affected by this state. When
> > strp->copy_mode is false, tls_strp_msg_consume() calls the TCP helper
> > tcp_read_done() to consume the current TLS record. In the reproducer,
> > tcp_read_done() consumed the record data and one FIN before freeing the
> > receive skb.
> >
> 
> TCP_ZEROCOPY_RECEIVE is another one: tcp_zerocopy_receive() takes its
> length from tcp_inq() and follows skb->next without checking for the
> end of the receive queue. Please mention it in the changelog.
> 
> 
> > When kTLS looked for the next record, tcp_inq() reported at least
> > TLS_HEADER_SIZE bytes even though the receive queue was empty.
> > tcp_recv_skb() returned NULL, so tls_strp_load_anchor_with_queue() hit
> > WARN_ON_ONCE() and returned without updating the anchor.
> >
> > Since tcp_inq() had reported at least TLS_HEADER_SIZE,
> > tls_strp_read_sock() proceeded to tls_strp_check_queue_ok().
> > skb_shinfo(strp->anchor)->frag_list still pointed to the freed receive
> > skb. tls_strp_check_queue_ok() then read TCP_SKB_CB(first)->seq through
> > the stale pointer, causing a use-after-free.
> >
> > The reproducer followed this call path:
> >
> >   tls_rx_rec_done()
> >     tls_strp_msg_consume()
> >       tcp_read_done()                       // frees the receive skb
> >     tls_strp_check_rcv()
> >       tls_strp_read_sock()
> >         tls_strp_load_anchor_with_queue()   // returns after WARN_ON_ONCE()
> >           tcp_recv_skb() == NULL
> >         tls_strp_check_queue_ok()
> >           TCP_SKB_CB(first)->seq            // reads the freed receive skb
> >
> > KASAN reported:
> >
> >   BUG: KASAN: slab-use-after-free in tls_strp_check_queue_ok.isra.0+0x5f/0x100
> >   Read of size 4 at addr ffff888103169ca8 by task ktls-server/71
> >   ...
> >   Call Trace:
> >    <TASK>
> >    ...
> >    tls_strp_check_queue_ok.isra.0+0x5f/0x100
> >    tls_strp_check_rcv+0x2a9/0x400
> >    ...
> >    tls_sw_recvmsg+0x3ce/0xa10
> >    ...
> >    sock_recvmsg+0xea/0x100
> >    __sys_recvfrom+0x142/0x1f0
> >    ...
> >    __x64_sys_recvfrom+0x76/0x90
> >    do_syscall_64+0xdd/0x4a0
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >    ...
> >    </TASK>
> >   ...
> >   Freed by task 71:
> >    ...
> >    napi_skb_cache_put+0x24/0xf0
> >    skb_attempt_defer_free+0x183/0x3b0
> >    tcp_read_done+0x2d4/0x340
> >    tls_strp_msg_consume+0x45/0x80
> >    tls_sw_recvmsg+0x3c4/0xa10
> >    ...
> >
> > In tcp_ooo_try_coalesce() and tcp_add_backlog(), skip coalescing when
> > the destination skb already carries FIN. This still allows a FIN
> > segment to be coalesced into an skb without FIN when the other
> > coalescing checks pass.
> >
> > Fixes: e93a0435f809 ("tcp: allow segment with FIN in tcp_try_coalesce()")
> > Fixes: 4f693b55c3d2 ("tcp: implement coalescing on backlog queue")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  net/ipv4/tcp_input.c | 3 ++-
> >  net/ipv4/tcp_ipv4.c  | 1 +
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index e1f2d9765f810..1f9f86028da73 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -5314,7 +5314,8 @@ static bool tcp_ooo_try_coalesce(struct sock *sk,
> >                              struct sk_buff *from,
> >                              bool *fragstolen)
> >  {
> > -       bool res = tcp_try_coalesce(sk, to, from, fragstolen);
> > +       bool res = !(TCP_SKB_CB(to)->tcp_flags & TCPHDR_FIN) &&
> > +                  tcp_try_coalesce(sk, to, from, fragstolen);
> 
> Please put the check in tcp_try_coalesce() itself.
> 
> The receive queue callers can not hit this today (tcp_fin() purges
> the ofo queue, and tcp_rcv_state_process() drops anything at or after
> rcv_nxt in CLOSE_WAIT/CLOSING/LAST_ACK), but the check costs nothing
> there, and it keeps the rule "nothing coalesces after a FIN" in one
> place.
> 
> Also, since TCP_SKB_CB(to)->tcp_flags & TCPHDR_FIN should almost never
> be true, it should come after the more relevant tests, just before
> skb_try_coalesce():
> 
>         if (TCP_SKB_CB(from)->seq != TCP_SKB_CB(to)->end_seq)
>                 return false;
> 
>         if (!tcp_skb_can_collapse_rx(to, from))
>                 return false;
> 
>         /* Nothing follows a FIN. */
>         if (unlikely(TCP_SKB_CB(to)->tcp_flags & TCPHDR_FIN))
>                 return false;
> 
>         if (!skb_try_coalesce(to, from, fragstolen, &delta))
>                 return false;
> 
> 
> >
> >         /* In case tcp_drop_reason() is called later, update to->gso_segs */
> >         if (res) {
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index a7f9242f1e429..ef01768292fbc 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -1949,6 +1949,7 @@ enum skb_drop_reason tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
> >         thtail = (struct tcphdr *)tail->data;
> >
> >         if (TCP_SKB_CB(tail)->end_seq != TCP_SKB_CB(skb)->seq ||
> > +           (TCP_SKB_CB(tail)->tcp_flags & TCPHDR_FIN) ||
> 
> 
> Same remark: please move this after the other tcp_flags tests, with a
> short comment:
> 
>             /* Nothing follows a FIN, see tcp_try_coalesce() */
>             (TCP_SKB_CB(tail)->tcp_flags & TCPHDR_FIN) ||
> 
> Checking only the tail is the right thing to do. It keeps the common
> case where the last data+FIN segment is merged onto a data tail,
> which happens on every connection close while the socket is owned by
> the user.

Understood. I'll send a v2 addressing your comments.


Best regards,
Hyunwoo Kim
