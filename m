Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9E302CD5
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599848; cv=pass; b=kGgMiyDuoHRE4i48E15vnTcgUVvURC5/yNVaP4oojQlv/W0fZ53mslGqLXmYI/eBUT0SXI2s9DoE3y32fhEcwwgzP1CT5eAB1okOZ8GiqzpguiBuvm74MzrWWTGY5nNtgVrDlm1pmCM930Y4BYYJ/LHsHH09lSWSnVy0+oZHDxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599848; c=relaxed/simple;
	bh=M+3dH1GSvevY6GhwOgUyNx+LoNjtxNBLo3OfUg6iUCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXqbvu8Uy3BqTx87t+t1pCKqmT9SjsGxAvLbW8MP9imkmiKiMhZ30YolFBo424bVQ9C2+YHpPWJWbRf99HFPFX4QzIfdWMYrOr1bxDItOplqBRZ5g1QAexa+vZoMnRx5cGYECe2OXl6wQ4kQYrAZWo0+O4jESmqwH/g9K84rm8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=atd6iq2N; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="atd6iq2N"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8e911e665so2247672e87.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 05:50:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790599843; cv=none;
        d=google.com; s=arc-20260327;
        b=lVhYZnXbbEArAb5V7lrWbTiI7G/0v1eY4fWDonIk8vuHR9vU89s9odrrbyVoZz4qgX
         R0TXPcKeXu23A1Oy7m9SwggfMGKhAf9F1gY+ERRXC5fD+PWVo/3zK/8AFSmsQdY3oifT
         kl14YTxZkt629R7yTKYzu69zo03ZivaCmFEKS+W7ZiFac2hg1UWeMjzXk7lzOQVXn6tt
         hN3omAqSBlBnp4WEihtZ6CIOP4flYeYpWWA1kx0nLviyG93NCBEdWHIVbwGEB/33j6HU
         XelKL3XfLptJ59xqE8CrcOTL/fJhMb5p15Ml+TrisI9Vbkg+GtedVd4m5w9CbbBDwdnO
         wzBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FkIpXBts567ERQCT9oesG3IDq3Wrsw1PQ3XnuZr6l40=;
        fh=GAyR6lNZnUJOAu0MJ0uW9kgx9B8LOluHCrlGObjv7fM=;
        b=JwsxPuExUXbMUBYdLAVGz8r1MyXBfa4B+7rkxdvZp8S4GpHbx5EvxhaLsCtly2DECx
         J3ztqj6Sw3xYGBGiiBMLDOXaLhaNchz4u6QD7JmGuURLnpoJq9AaR+xX3itkyzmBEzZe
         WDpcI80GB/P/qb3bjCzOH7C8MLavVSNi1pxnnc4KpdGpgRZrYbpdlFYk7bP6+6UsgI/X
         qUHa9QyuApX3Tcn2KWMAza17H88l4snY4Y5SFOuexGNnZdgGy9jHkIliu9NvDsvI7lKn
         EMJtIXBM662Trn3wn52OWhLefHjrc2S+oLQNiyve5cpDfGTCjzvmbO/apRrbCfgkprF5
         7HUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790599843; x=1791204643; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FkIpXBts567ERQCT9oesG3IDq3Wrsw1PQ3XnuZr6l40=;
        b=atd6iq2NjcHVw3ptP0o5HTXFlBIw2PfckmFwXJ2JDemLyNugFVIwMuoD3HHPwugQ+Z
         yiukOX0J72qbEsmJgdlcbM2Bc/McBkbV8Jf3Z0yP7aXk5WLMGZnjG6j1jIP/LJC6jfRU
         feWJGQoV8KWl1lJ0poEwKbeWOM/0Cqy+UlgayU1mxwjCRRxL8NKdYT27iXRSvJ+UjasN
         pu+/HXvvDfasCqgpDBsxtm4ep6Ig4Gg0NIpatuaqJ6VYr4agteQwOCPK4TLdcymUUmLF
         M+TizHWCjH2VbYFXBVaI6sqAn9q1waFfml3pD0XOV/b9Z6aIzRrzv1x5EsmdtsxlHnrW
         F3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790599843; x=1791204643;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FkIpXBts567ERQCT9oesG3IDq3Wrsw1PQ3XnuZr6l40=;
        b=rWD2Ia0robJRgKG6nOuEJx2E0kPmATi6XDxgSs0sjW32d++ymXcIOik7yzno7beJPP
         wAX84cnkgxIThRXDUhiZ3wMaiKfF+oQNCIf0NlCU69Bakr717ZWnQAxXG1UfSviYJX4e
         oF1XBTfKtCuFCoPwHdcZI/OeB8CbduNpTNeNL0hRKksPW4ZwPyKph06W1/PaPL448s9i
         D9wlpEi7SvrEVMhVZVwcbmLHSlcdhzi40ZPK0hCpH/aDg56I2VfX1MrDUMt2p6r+5X3D
         GmfUXNceYvNzaFipfNcnxPn+SGmbaN053hlyBrcasIDKTBFqCPm8QJZEuiupa//HBWgj
         ZEBw==
X-Gm-Message-State: AFq9FYIgTzeX3PL1nwt8jsEB+Pw4JzyLdYthckB4aJuoon0yjEyW1K86
	/SCk5M8Plip4YtVRKaK2auB+/WTsXnd654uwM9YIy/pSo7tiqErqlD8TQjrYOYgaulGaTZYj8pJ
	E6LaN6aCxVvmO5a1hSHIjKkJFv0qAFHLg2lbv0DhTOTg=
X-Gm-Gg: AYBFou30e6/NHvT+CnIGdl/XeF6X5HI9xHsTtlB7Pox19SxXxw6Hu64jJAQIWNYfiwK
	+m/Ou17POTxIJEu2xX/DgyYR4OAV8Qj2Mst9/i/mmWeE664l3tAQxWfB+4lmDixsIjD+rGhoBcD
	fmzTgWEKHZXRc/7Ql3Q/+I3tc42TcV3kcBhQ648MLgyZDZ0Q2A34QgnmK1Z8yttYAhhNohoi+Bx
	gCqEK6OoP484eDmaeaRy3MFLFoErb1mVH7bKKr+KqpDgI/+bJR7UkisJLkHi8YrXcXNeb1uGJ/B
	udSQ+6MLIP7JKCc+5BHjmqHmi9v08kt8tjdidHl2itHRRoBnUkqOZxZDxnu41B/T2nh6MlziQNm
	1sa7ZSpET2Q==
X-Received: by 2002:a05:651c:198e:b0:3a6:4917:dbbb with SMTP id
 38308e7fff4ca-3a64917e589mr27771821fa.5.1790599843212; Mon, 28 Sep 2026
 05:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2af9949fc349d17b53db432893abb4d2e97932ce.1790255682.git.zihanx@nebusec.ai>
 <20260928094944.815915-1-horms@kernel.org>
In-Reply-To: <20260928094944.815915-1-horms@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 28 Sep 2026 20:50:30 +0800
X-Gm-Features: AclHuK8LZn81RTv7sYp23KybCbUWmZsmLN5vA0Mzyb-pTREothGkyMtFiQbTFJc
Message-ID: <CAANe3eTdu7fEEYiCA38+SK9Ja9kO7GY9EX2o7fg1bbwVsT4R+g@mail.gmail.com>
Subject: Re: [PATCH net v12 1/1] llc: fix listener child socket leaks
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, vega@nebusec.ai, root@tr0jan.top
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:50=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email says "I'm forwarding this as it looks legit and the forwarding
> bot trigger seems to have timed out."
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2af99=
49fc349d17b53db432893abb4d2e97932ce.1790255682.git.zihanx@nebusec.ai?part=
=3D1
> ---
> llc: fix listener child socket leaks
>
> This patch reworks LLC listener passive-open handling. Child sockets
> created on SABME are now freed when setup fails or when the connection
> indication is dropped before accept(). Only SABME creates children, the
> listener sends DM responses for other commands, pending indications count
> against the accept backlog, and skb->dev is held for packets deferred to
> the socket backlog.
>
> > diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> > index 260460d50f54c..77044720f12ff 100644
> > --- a/net/llc/llc_conn.c
> > +++ b/net/llc/llc_conn.c
>
> [ ... ]
>
> > @@ -90,6 +91,8 @@ int llc_conn_state_process(struct sock *sk, struct sk=
_buff *skb)
> >                */
> >               skb_get(skb);
> >               skb_queue_tail(&sk->sk_receive_queue, skb);
> > +             if (sk->sk_state =3D=3D TCP_LISTEN)
> > +                     sk_acceptq_added(sk);
> >               sk->sk_state_change(sk);
> >               break;
>
> [Severity: High]
> This is a pre-existing issue and was not introduced by this patch. It is
> in the same area the commit message describes, though. Can a remote peer
> grow an unaccepted child's sk_receive_queue without bound here?
>
> The child stays hashed while its indication waits in the listener's
> queue. Suppose the peer sends DISC, which moves the child from NORMAL bac=
k
> to ADM, and then sends SABME again. llc_conn_handler() finds the child
> and takes the non-listener branch:
>
>     skb_orphan(skb);
>     sock_hold(sk);
>     skb->sk =3D sk;
>     skb->destructor =3D sock_efree;
>
> llc_conn_rcv(child) then handles ADM + SABME, which issues another
> connection indication. This case queues it on the child's own
> sk_receive_queue with no rmem or sk_rcvbuf check. The child is not
> TCP_LISTEN, so sk_acceptq_added() does not apply either. Each queued skb
> also holds a reference on the child.
>
> The new sk_acceptq_is_full() check in llc_conn_rcv_sabme() limits how
> many children are created. It does not limit how many indications build
> up on one child, and that memory stays pinned until the application
> accepts or closes the listener.

Confirmed. This is a pre-existing issue and is not introduced by this patch=
.
>
> [ ... ]
>
> > @@ -765,14 +768,124 @@ static struct sock *llc_create_incoming_sock(str=
uct sock *sk,
>
> [ ... ]
>
> > +static int llc_conn_rcv_sabme(struct sock *sk, struct sk_buff *skb,
> > +                           struct llc_addr *saddr,
> > +                           struct llc_addr *daddr)
> > +{
> > +     struct sock *newsk;
> > +     int rc;
> > +
> > +     if (sk_acceptq_is_full(sk))
> > +             goto drop;
>
> [Severity: Medium]
> Can sk_ack_backlog underflow, so that this check drops every SABME from
> then on?
>
> The counter only goes up in llc_conn_state_process() when sk_state is
> TCP_LISTEN at queue time. Other code resets it without looking at what is
> still queued:
>
> net/llc/af_llc.c:llc_ui_listen() {
>     ...
>     if (sk->sk_state !=3D TCP_LISTEN) {
>         sk->sk_ack_backlog =3D 0;
>         sk->sk_state       =3D TCP_LISTEN;
>     }
>     ...
> }
>
> llc_ui_connect() only rejects SS_CONNECTING. A listener with indications
> still in sk_receive_queue can therefore call connect(), and a DM or
> timeout then leaves it in TCP_CLOSE / SS_UNCONNECTED.
>
> A second listen() resets sk_ack_backlog to 0 while the old indications
> are still queued. Each accept() of one of those indications then calls
> sk_acceptq_removed() unconditionally in llc_ui_accept().
>
> The u32 counter wraps to 0xFFFFFFFF and sk_acceptq_is_full() stays true.
> Later listen() calls do not reset the counter because sk_state is already
> TCP_LISTEN. Is every new SABME then silently dropped here?

 Confirmed. The accept-queue counter can underflow as described.
>
> > +
> > +     local_bh_disable();
> > +     newsk =3D llc_create_incoming_sock(sk, skb->dev, saddr, daddr);
>
> [ ... ]
>
> > @@ -786,6 +899,10 @@ void llc_conn_handler(struct llc_sap *sap, struct =
sk_buff *skb)
> >               goto drop;
> >
> >       bh_lock_sock(sk);
> > +     if (unlikely(llc_sk_unhashed(sk)))
> > +             goto drop_unlock;
> > +     if (unlikely(llc_sk(sk)->state =3D=3D LLC_CONN_OUT_OF_SVC))
> > +             goto drop_unlock;
> >       /*
> >        * This has to be done here and not at the upper layer ->accept
> >        * method because of the way the PROCOM state machine works:
>
> [Severity: Low]
> This isn't a bug, but two comments still say the child is created in
> llc_conn_handler(): this one, and the one in the LLC_CONN_PRIM case of
> llc_conn_state_process() ("the newly created struct sock in
> llc_conn_handler").
>
> After this patch the child is only created in llc_conn_rcv_sabme(). When
> the listener is owned by the user, that happens later from
> llc_backlog_rcv(). Should both comments be updated?

Confirmed. The comments are stale.
>
> > @@ -795,11 +912,14 @@ void llc_conn_handler(struct llc_sap *sap, struct=
 sk_buff *skb)
> >        * in the newly created struct sock private area. -acme
> >        */
> >       if (unlikely(sk->sk_state =3D=3D TCP_LISTEN)) {
> > -             struct sock *newsk =3D llc_create_incoming_sock(sk, skb->=
dev,
> > -                                                           &saddr, &da=
ddr);
> > -             if (!newsk)
> > +             if (llc_conn_ev_rx_sabme_cmd_pbit_set_x(sk, skb)) {
> > +                     llc_listener_send_dm(sap, sk, skb, &saddr);
> >                       goto drop_unlock;
> > -             skb_set_owner_r(skb, newsk);
> > +             }
> > +             if (!sock_owned_by_user(sk)) {
> > +                     llc_conn_rcv_sabme(sk, skb, &saddr, &daddr);
> > +                     goto out;
> > +             }
> >       } else {
> >               /*
> >                * Can't be skb_set_owner_r, this will be done at the
> > @@ -813,13 +933,16 @@ void llc_conn_handler(struct llc_sap *sap, struct=
 sk_buff *skb)
> >               skb->sk =3D sk;
> >               skb->destructor =3D sock_efree;
> >       }
> > -     if (!sock_owned_by_user(sk))
> > -             llc_conn_rcv(sk, skb);
> > -     else {
> > +     if (sock_owned_by_user(sk)) {
> >               dprintk("%s: adding to backlog...\n", __func__);
> >               llc_set_backlog_type(skb, LLC_PACKET);
> > +             /* The backlog can outlive the RCU protection of skb->dev=
. */
> > +             backlog_dev =3D skb->dev;
> > +             netdev_hold(backlog_dev, NULL, GFP_ATOMIC);
> >               if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))
> >                       goto drop_unlock;
>
> [Severity: Critical]
> Can a listener SABME get into the backlog here with a foreign skb->sk
> still attached?
>
> Before this patch, the TCP_LISTEN branch always called
> skb_set_owner_r(skb, newsk), and that orphans the skb first.
>
> Now, when the listener is owned by the user, the SABME skips both
> skb_set_owner_r() and the skb_orphan() in the else branch. It goes
> straight to sk_add_backlog().
>
> llc_rcv() only calls skb_share_check(). A frame sent locally over veth
> from an AF_PACKET or AF_LLC socket can therefore still carry the sender's
> skb->sk and its sock_wfree destructor.
>
> If the listener leaves TCP_LISTEN before the backlog drains,
> llc_backlog_rcv() takes the non-listener branch:
>
>     } else if (unlikely(llc->state <=3D 1 || !skb->sk)) {
>         goto out_kfree_skb;
>     }
>     rc =3D llc_conn_rcv(sk, skb);
>
> The !skb->sk test is supposed to drop these ownerless deferred SABMEs,
> but the foreign skb->sk gets past it. llc_conn_state_process() then runs
> the state machine on llc_sk(skb->sk), which is the sender's socket. This
> path holds no reference on that socket, and it may not be an LLC socket
> at all.
>
> One way to leave TCP_LISTEN while the lock is owned is llc_ui_connect().
> It does not reject listeners and it sets sk_state =3D TCP_SYN_SENT. At th=
at
> point llc->state is SETUP, which is greater than 1. The backlog is then
> drained in llc_ui_wait_for_conn() or in release_sock().
>
> Should the skb be orphaned before it is backlogged in the listener case?

Confirmed. This is a regression introduced by the reviewed revision.
>
> [ ... ]
>
> > @@ -852,12 +976,33 @@ static int llc_backlog_rcv(struct sock *sk, struc=
t sk_buff *skb)
> >  {
> >       int rc =3D 0;
> >       struct llc_sock *llc =3D llc_sk(sk);
> > +     struct net_device *dev =3D NULL;
> >
> >       if (likely(llc_backlog_type(skb) =3D=3D LLC_PACKET)) {
> > -             if (likely(llc->state > 1)) /* not closed */
> > -                     rc =3D llc_conn_rcv(sk, skb);
> > -             else
> > +             /* Drop the reference acquired before the skb entered the=
 backlog. */
> > +             dev =3D skb->dev;
> > +             if (unlikely(sk->sk_state =3D=3D TCP_LISTEN)) {
>
> [ ... ]
>
> > +                     llc_pdu_decode_sa(skb, saddr.mac);
> > +                     llc_pdu_decode_ssap(skb, &saddr.lsap);
> > +                     llc_pdu_decode_da(skb, daddr.mac);
> > +                     llc_pdu_decode_dsap(skb, &daddr.lsap);
> > +                     rc =3D llc_conn_rcv_sabme(sk, skb, &saddr, &daddr=
);
>
> [Severity: Medium]
> Could this create two children for the same tuple?
>
> While the listener is owned, llc_conn_handler() backlogs SABMEs without
> creating a child. A retransmitted or duplicate SABME from the same peer
> can arrive before release_sock(). It finds no child in __llc_lookup(),
> resolves to the listener, and is backlogged as well.
>
> When the backlog drains, each SABME reaches llc_conn_rcv_sabme(). That
> function only checks sk_acceptq_is_full() before
> llc_create_incoming_sock() hashes a new child. The established tuple is
> not looked up again.
>
> Both children reach NORMAL, send UA and queue an accept indication.
> sk_nulls_add_node_rcu() adds at the head, so only the newest child gets
> traffic.
>
> The older child is still accepted by userspace but never receives frames.
> Its sends, and its DISC on close, use the same tuple as the peer's single
> connection.
>
> Before this patch, getting here needed two CPUs racing on the listener
> slock. With this patch, hitting the owned-listener window at all seems to
> be enough.

Confirmed. Duplicate deferred SABMEs can create duplicate children as descr=
ibed.
>
> > +                     goto out;
> > +             } else if (unlikely(llc->state <=3D 1 || !skb->sk)) {
> >                       goto out_kfree_skb;
> > +             }
> > +             rc =3D llc_conn_rcv(sk, skb);
>
> [ ... ]
