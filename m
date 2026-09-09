Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732092F549F
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 04:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929931; cv=pass; b=f7xHQB1SZLmGPm1QDH+2w4HGQhhKSZL7niYYvIAdY+zazeb8wxbISmA6puyYvNQtvAEVBvXe2Lq7MSWQKiZfjYQkpunLMqWyys26M1tHYJ1F+sjYlBLBuFD0tIq8dY5MJk7v2SwQTY/y3SUBbSDjVzD+q4msK6giX8+yOoFmf5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929931; c=relaxed/simple;
	bh=6BSVwfZXLQVl5JnJAKqT01FUDTNPH8UPXa4syTmMYh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omaFZL4TdUduAFrnQva5AldqCNTQ8HqKOfpaDWSWxiGH3qu535NfCU6MapBPGU37og4jN6xQWxfyYzuxGsMc30TA3QvVbJOXbM9CdKO19bdgW47P1UNTkvb/7UmuMfvLj1GAeMHl57kJL67LqvxqqSqBlBMpJ6pYGwHsw/w+pCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Wz2ZEf3a; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Wz2ZEf3a"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a3156692e3so6230781fa.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 21:58:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788929927; cv=none;
        d=google.com; s=arc-20260327;
        b=Evyclq/wi09J/1RBjasSU/AsEqX4rtVkhSybhp45J/nIUfqj/4K8rqJAjwlT2mOUQY
         dj58ucVQGOIaJbx4u7tCxH07drJ6OePMRxsonyXijudOh/Nzxu1RkY5jujdigW5vd77w
         YnOGVFymZ/D8sKI6qbDyD/PwzUdpSifAMPn73ZABwRatHNK7OziHiu0hL95z++I2tgeN
         z9Ldhye3zDD48CogKrLJgUB1oMAF6ysFZIFChtWNjnbgLBbDOcDsOQqaadCNin5x0zaM
         LsiJ6W9FlWeh0Ql2K/BYB+diVHcOGLVgm0T9mb/yw31oLSmgJXhO04npKO0qUJOOxAey
         rqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s9VFBDAskaJjI+w62/ArkmTkSfDF0OWlLydsynpPx70=;
        fh=eLfWDHN1hpQ28e+vs1zYuhZlnO5di00vTDtLQdFGLzk=;
        b=E2xS19m9AHMVA2+EkphOcFSS3dTUTI7r3Yrsgy/4Ls5bx61QSdPD+nbQGaDn/GrKBH
         vlrkC1Ty7RykRG8/gHo1krJETpdJP7ufUdSjs7pc48y5BOjT9Zla9OXE+jTysq38yRS4
         u0U+7aGbSnpVbm/4YiXxoe+Xrom+xillFsdAbLHFZy8N+/tZ5RS4LhhDaHSWmSguUbeG
         1hBOTXVVFTKQjtNO2w0Wv1EFuLgKb9TxTwm9LdACevyhJZYuesBg4y8IYvceQzTH2dDX
         K34Tw/EQqmvvY8EWl0TZcj7bqnpHhUkIBl/Iv7MIl6XXCjBr04jWh3seVjWOrkaZaATX
         bRhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788929927; x=1789534727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s9VFBDAskaJjI+w62/ArkmTkSfDF0OWlLydsynpPx70=;
        b=Wz2ZEf3alJY8lfT9VbS2GAYJIkGpbpIqZywjiMU1ePmzdADjIGSFi3k0tufwV8ritb
         +RL2qHBpvzW/+uvI4n3+GDedYx+MhG8q3xKQHG+ACoF6dnzKbl2MqAdFmdz3rBi+JD9N
         Dc5igON1tRBA0Dkm2jIiZ7/ScB/RVXSXP4ex+3sjb1dry0LsEMIj1Sb/1wfJSGI6tuAj
         Ma0zG13YxXuFUDV6K4MvKQl10Y1uC6+kz1ADechk4NrEmloKDMoQ41K59K2ly12lcBQ0
         ZUugN4qqb1N3aWkU+Nls8LbsnScbT2Jvuo/YqVinegP8lND8RoMwXwVFyhjhpa/4DgaV
         phOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788929927; x=1789534727;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s9VFBDAskaJjI+w62/ArkmTkSfDF0OWlLydsynpPx70=;
        b=QRntgqneRGs69znUZbw38xWQ0n0J4IbGvOdYd6uA3EW415xCexiw1afFbCEroCRUPD
         hSC/U7olZhgCBcIur6rqdpWiv4V22bauXYLj3qt3g9+n40PTYh23jH7+2dPzEdLSPpSS
         B4CQamKeO2uMkgkIqDTO3bTzjvXKYKBLzJ+0FEG34DiSFi7V9zCqb2mGLRoSQpxUrA87
         AlMQhNtvSuRYxCgZJcQka1G/3jn4b29TiTK48562XEwtk7FLXXQ9YyFzjTvHTVoJq/sn
         rFp9PTYlENdIgnriOK2sTV1ATMwHAGBeptuM1UHHaBpF1VRe2oOl/+4FGBOGpnXp27FD
         Z5Og==
X-Gm-Message-State: AFuF++nzx8KgRirHyUrp/fQDFsgjcZcRzVyYCcduYG0qpSR2v0aXQ27c
	C/tZihtm3oRYClxnlM7G49i2qODhncwuHVTOLebobquAtB6fAYaBlXMSD+1psyq/SZDP/DnUELe
	+HPgHF4rRwinCqqZDlO+818B6aAq0DWCWGi7euhoI+Hs=
X-Gm-Gg: AYBFou2CRal1XqtwJwUv1qF55jQnmyuEGnuYcpiBkzDHmZQSvbDn2RCjfThwode4Vvg
	q9pU6hj+II9K2wfpoMxXaZSsGIee+4dMuTVfOaqguRXoC78WQJymdLDDpycKW5IhR6SxLvC+q/Y
	fN5IuspbCQJmrUO+JSVXEDVxcMpY01kyc8eiQ4GORba2z3o8rDr1bX/61Kwr31eFrP73u3gq1lK
	3j8gEg5aD3fk03oK4VLUvBxtV49zJgrASDsP0DxZEaB1So1eJmqtXf2q/uNon+2asBf+SOxTchf
	4tuLJ7r+2fJCSapa4C19UBWfWX6SqVbpER9P6VwJvto2qukg6ngaCif1Lyohq6vEf1OMoPWHo1q
	IjsjFJI/bWsqI4NVgqSOP
X-Received: by 2002:a2e:bcd2:0:b0:39c:a24b:f0b8 with SMTP id
 38308e7fff4ca-3a4881c1db7mr11397781fa.2.1788929927221; Tue, 08 Sep 2026
 21:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a2bd6f3ed29919a7328363b548299ae583f052b0.1788539302.git.zihanx@nebusec.ai>
 <20260908121740.432088-1-horms@kernel.org>
In-Reply-To: <20260908121740.432088-1-horms@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Wed, 9 Sep 2026 12:58:35 +0800
X-Gm-Features: AcwNN1XLjO4F21biATQaD_969-WKwl2sd6yzBtfOuB3Ma_LEzaAoVfhJP4tHTRo
Message-ID: <CAANe3eSNAtgh0wiN56TEk_fKhDrLoJGJxhEA+ZBJ14-PK-rjvA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/1] rxrpc: fix encap_rcv skb accounting exhaustion
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, dhowells@redhat.com, marc.dionne@auristor.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 8:17=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/a2bd6=
f3ed29919a7328363b548299ae583f052b0.1788539302.git.zihanx@nebusec.ai?part=
=3D1
> ---
> > diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
> > --- a/net/rxrpc/io_thread.c
> > +++ b/net/rxrpc/io_thread.c
> > @@ -52,6 +50,19 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_b=
uff *skb)
> >       }
> >  #endif
> >
> > +     if (atomic_read(&udp_sk->sk_rmem_alloc) >=3D READ_ONCE(udp_sk->sk=
_rcvbuf) ||
> > +         !sk_rmem_schedule(udp_sk, skb, skb->truesize)) {
> > +             sk_drops_inc(udp_sk);
> > +             kfree_skb(skb);
> > +             return 0;
> > +     }
> > +
> > +     skb->dev =3D NULL;
> > +     skb_set_owner_r(skb, udp_sk);
> > +     skb_dst_force(skb);
> > +
> > +     skb->mark =3D RXRPC_SKB_MARK_PACKET;
> > +     rxrpc_new_skb(skb, rxrpc_skb_new_encap_rcv);
> >       skb_queue_tail(rx_queue, skb);
> >       wake_up_process(io_thread);
> >       return 0;
>
> [Severity: High]
> This borrows UDP's rmem accounting without borrowing the lock that
> protects it.
>
> rxrpc_encap_rcv() is called from the UDP receive path in softirq
> context with neither lock_sock(udp_sk) nor
> udp_sk->sk_receive_queue.lock held, and nothing serialises two CPUs
> delivering to the same local endpoint. Both new accounting calls in
> this hunk perform an unsynchronised read-modify-write on
> udp_sk->sk_forward_alloc: sk_rmem_schedule() reaches
> __sk_mem_schedule()/sk_forward_alloc_add(), and skb_set_owner_r()
> calls sk_mem_charge(), which is the same non-atomic
> WRITE_ONCE(sk->sk_forward_alloc, ...) update. The newly added
> skb_orphan() in rxrpc_io_thread() closes the loop from the kthread
> side: sock_rfree() -> sk_mem_uncharge() does the same non-atomic
> update concurrently with softirq enqueues on other CPUs. Note that
> only sk_rmem_alloc is atomic_t here; sk_forward_alloc is not, so the
> atomic_read() guard at the top of the hunk does not make any of this
> safe.
>
> The normal UDP path does not have this problem because
> __udp_enqueue_schedule_skb() performs the forward-alloc bookkeeping
> and the skb_set_owner_r() under sk->sk_receive_queue.lock, and
> udp_rmem_release() takes the same lock before reclaiming. The
> consequence of losing that serialisation is not confined to this
> socket: the drifted sk_forward_alloc is eventually handed to
> __sk_mem_reduce_allocated(), which subtracts it from the protocol-wide
> udp_prot memory_allocated counter, so a flood of RxRPC-shaped packets
> can skew global UDP memory accounting for every UDP socket on the
> machine. That is a worse failure mode than the unbounded rx_queue this
> patch is trying to fix.
>
> How do you want to serialise this? Options I can see are enqueueing
> via the existing UDP receive-queue locking rather than open-coding the
> charge, or holding local->rx_queue.lock across both the charge in
> rxrpc_encap_rcv() and the skb_orphan() in rxrpc_io_thread() so the
> charge and uncharge sides are mutually exclusive. Please say which you
> intend, and make sure the answer covers the I/O-thread uncharge path
> too, not just the two enqueue-side calls.

Thanks for the review. I agree this is racy: sk_forward_alloc is not
atomic, so a BH encap_rcv() on another CPU can update it while the
I/O thread orphans the skb.

I intend to keep the skbs on the RxRPC local queue and serialise UDP
rmem with sk->sk_receive_queue.lock, the same lock UDP uses:

- rxrpc_encap_rcv() already runs in BH, so it can take spin_lock()
  around sk_rmem_schedule() and skb_set_owner_r();
- the I/O thread takes spin_lock_bh() around skb_orphan() for PACKET
  skbs charged in encap_rcv(), so a concurrent BH charge cannot run
  at the same time.

I will not enqueue these packets on the UDP receive queue.

A v4 addressing this is coming shortly.
