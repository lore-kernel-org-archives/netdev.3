Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD8D411661
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787292598; cv=pass; b=pJA8lNZ3frRfhgOzlUwVUcqyIVvaNthpn/ZV/Ai7pz2XQO7wxx+LqXmrbJivJTIPvxSwGL4AZpuEcV3kM7IK7TK2mMVzx7TOwRYTI2RNGgidvP1nNPu3uj+1eCyfwupEHx+AEjQhJr9A8k+EPmGe0+oUH0dzB1L/bMure4HEKbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787292598; c=relaxed/simple;
	bh=qINiJeK8gf7WWMdQn7bvp8PbhJF8uZmcvzWfQq6lEnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFNXigneOEPYiKnAgIXpQjqrfYVKm5RWj8sHUOx1G432pDvOQzE7NTUe7FYpJyIzczJsD7AferhDpIp3L7qoiV8w9viAC9uwl3Pim/Z9fzsqzcpUxTNSU3eXf9xir77XIo+5kpSC4cCr/YVT+I8LjEQVIrC3H94FrSm9NavU2PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=XuA64bT8; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="XuA64bT8"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c95395230so6707441fa.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 23:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787292594; cv=none;
        d=google.com; s=arc-20260327;
        b=BvDKrhQwYqgQlRoK8zZhRZ+59K977ecjIn1eOBdkOJs42iCuXiBzBhifvM17wHwyuW
         u7scafsIJSHYx0gQtKV5W6e7vdL7bShqgu44WyloDmqUujfVnFlDQv9l3bPRf8jfG4DD
         wBvoOOPqu0ZqkhaStfiqXjqdBOgouwumB34GP4NAp+ZAiUn15W4d40XWOYw65w4rO/eg
         RKy4ZyiC9AhE4no/CIAHzN6FckFRE1JsoPCZwmAp9kY2oqo2BrvIeoSe5dmOAwbVHU/N
         fUvAzks8nwSRgfcYHDeGj6gYyOMPHkMM4B7mG4II8hQ/OyCzezdo43KqlQX4KmgF6wj/
         Edww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qHxBIUoedvF7H6OgQMIps85oSlzWAQYmOdXnskUCRyM=;
        fh=DJkk7NaUU48foF6t+REuNBbTcMUdr5Mb9flnVwh37lo=;
        b=OoEebxyl333yrkKH+agWacwLFnarYWTqi5V/Sa4ZAZvrXyhAhRdfGSyT/DYtokJ4SV
         69sZVyk09EDuxH2rlWr4Ee4v8gFoO1/qTZWQQ3zQoHFVpQ2Kp9JRpa1RhhLMEReXOjMd
         GInrCZceMTbI02wsjB1/uXMBLsM56uxkBWm+2T5GPmRISclGy6GVXady9a6kG0JcOiwq
         kwOt8LgDYJP6DjmUs44VaqpuvowC+mIJGhTCCEdpY4efwGExrZjCHRsBg/qi93zqgJha
         RD4+A3FgpJATbgGyAmcE422B+tB5I0I4gsoWGnGW6qcSzgAG4dy20VrmWvLy1SoXfMav
         2dvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787292594; x=1787897394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qHxBIUoedvF7H6OgQMIps85oSlzWAQYmOdXnskUCRyM=;
        b=XuA64bT8O+ZU2vKCok3kb3kebQ3l28Pi9HBPpdTChYwhyUS20+WJOHTJm7jms9AEhw
         4DIKuCisqkwM4kDUudKPuoOzRNrx6Xp4yrViYSLSId/Y6Pj02SQ41+rajg/y0GZKi6HU
         DsONdOmchYKwYQ32qF+w6WpUckJgmYW5KJD6oyh9PyEvJzLqs4HH4eIZsSAUqiMVcEz+
         4m8jFiWQR1gvk2+OWdrsI2V39A739pJfbe+p1KucT5SsrwvZP5AXRjDXZ2oCVvvJ4P9R
         k4G6hss6ubmdhq+yYD9FsQj1xRRrodixkKm0GXvWDRxpgK2S804keXb81DSK8oI/LS72
         OOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787292594; x=1787897394;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qHxBIUoedvF7H6OgQMIps85oSlzWAQYmOdXnskUCRyM=;
        b=h9y32qRUcsLG0r4pYAuHij73/8lZcSdiFG/3Wfa9uruVRBzQ/ZRMMc0SBGDl7ngsm6
         ZtaRtW0o7+7pLg4d7VEujAlJZIHF2d37Ze9QtX/tJdTgsgq88TbBg9dby/zdQgFuhhEc
         eqpN8Y0YAZwxbO/rlgikMbL3Zr4cIRlBFse/H1oZiGu8D8USa6niQwtrfp5U6hpSu5mb
         JHO69xZKdSribndVHLqGaV1OdWZ3TWwcd0byRpYg48IEtgPwPvQt3M+oagt31QUf8dOK
         Zi6X3ae1w1nuzpwkBqkJLMyOzIqte1WYbddb4e3duh6dYmR9GWITMqGhvVk4b+0/tETY
         6wTQ==
X-Gm-Message-State: AFuF++mOjHokMQdrMDZJqD/pCJHiS20aaFpcNOpKXEScRVVuMXtIshrC
	YJXvaM7xjsoGm/WqhH6zdCKuxxSFfCD2Au3xSmLQhQjpzu58Oab4yYFI7aNszq2P9WLqo9bsN7B
	7nBY45Ojgxd6vCqQJeMaQDB2xZEW8ie5O0wBhQGvRTDs=
X-Gm-Gg: AR+sD137m8itWgIb71iGVyHadljJDMk/5d/pRHxLvmTiagwJdmr2rkJq/18ukwcXUDO
	c/eGEgz+9c4npZNHiVFQor1+39aC2GYNsFgmfROpF421TCPmOCec8NInmJLGmXsvV8WExua+W4j
	VOGvC+T7AYGPClEgeYVvUjEHbYXW82ga4q1IfpMT69UAszn3Z9MTAhFRI7DDB25yhXlW62CZyU8
	yy+uAGEtEzOcH4MC4n+TkAduoWwrv4TITV9uPQPK9M/L2b9P7AiM2AsvntHRkQFQkQn1KDyvT93
	pmR/LrysNxwaUeVciYJs16CLHUMJ7EAZThg0nXxtHniyJazxrtQl23tlUPFKlXPUBhESBXDgIMV
	Q
X-Received: by 2002:a2e:b88c:0:b0:3a1:90f8:c14c with SMTP id
 38308e7fff4ca-3a1aec4c6a3mr8791761fa.11.1787292593386; Thu, 20 Aug 2026
 23:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814185843.4748-2-zihanx@nebusec.ai> <20260820203242.1134165-1-kuba@kernel.org>
In-Reply-To: <20260820203242.1134165-1-kuba@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Fri, 21 Aug 2026 14:09:40 +0800
X-Gm-Features: AcwNN1UZaceZYpyHAnPxYQ5Zarf-SLThBJNDkM-RkVUll85gz5OG7yC1lEm_dIQ
Message-ID: <CAANe3eTMXkJ-s5Uy1N4oYV17row_6kBgc5KgYVvaByQyo5Xugg@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] llc: fix listener child socket leaks before
 passive open completes
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, kees@kernel.org, leitao@debian.org, 
	tim.bird@sony.com, shuangpeng.kernel@gmail.com, ernestas.k@iconn-networks.com, 
	luoxuanqiang@kylinos.cn, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 4:32=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> llc: fix listener child socket leaks before passive open completes
>
> This changes llc_conn_handler() so that a child socket is only created fo=
r
> SABME commands, answers the other listener-side cases with a directly bui=
lt
> DM response, and adds an atomic incoming-child lifecycle so unaccepted
> children are released on direct, backlog and listener-close failures.  Th=
e
> final child teardown is deferred to a work item so timers can be stopped
> synchronously in process context.
>
> A few questions below.
>
> > diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
> > index b0447c33dbf09..837b8e0348637 100644
> > --- a/net/llc/af_llc.c
> > +++ b/net/llc/af_llc.c
> > @@ -206,6 +207,9 @@ static int llc_ui_release(struct socket *sock)
> >               llc->laddr.lsap, llc->daddr.lsap);
> >       if (!llc_send_disc(sk))
> >               llc_ui_wait_for_disc(sk, READ_ONCE(sk->sk_rcvtimeo));
> > +     listener =3D sk->sk_state =3D=3D TCP_LISTEN;
> > +     if (listener)
> > +             sock_set_flag(sk, SOCK_DEAD);
>
> [Severity: High]
> This isn't a leak introduced by this patch, since unaccepted children lea=
ked
> in every case before it, but does this branch leave one reachable case
> unfixed?
>
> The cleanup is gated on the socket's current sk_state, so a socket that w=
as
> a listener but has since left TCP_LISTEN skips both llc_release_incoming_=
children()
> calls.
>
> llc_ui_listen() leaves sock->state as SS_UNCONNECTED, and llc_ui_connect(=
)
> rejects only addrlen, family, sk_type and sock->state =3D=3D SS_CONNECTIN=
G:
>
> net/llc/af_llc.c:llc_ui_connect() {
>         ...
>         rc =3D -EALREADY;
>         if (unlikely(sock->state =3D=3D SS_CONNECTING))
>                 goto out;
>         ...
>         sock->state =3D SS_CONNECTING;
>         sk->sk_state   =3D TCP_SYN_SENT;
> }
>
> So connect() on a listening socket that already has an LLC_INCOMING_QUEUE=
D
> indication on its receive queue is allowed and moves sk_state away from
> TCP_LISTEN.  llc_ui_accept() then refuses to consume the indication becau=
se
> it requires sk_state =3D=3D TCP_LISTEN, and at close time listener is fal=
se.
>
> llc_sk_free() only does skb_queue_purge(&sk->sk_receive_queue), which fre=
es
> the indication skb but never calls llc_release_incoming_sock() for the ch=
ild
> it referenced.  Does the child then stay in the SAP tables forever, holdi=
ng
> the dev_hold() reference taken in llc_create_incoming_sock() (blocking
> netdev unregistration) and the new sock_hold() on the closed listener?
>
> >       if (!sock_flag(sk, SOCK_ZAPPED)) {
> >               struct llc_sap *sap =3D llc->sap;
> >
> > @@ -214,16 +218,20 @@ static int llc_ui_release(struct socket *sock)
> >                */
> >               llc_sap_hold(sap);
> >               llc_sap_remove_socket(llc->sap, sk);
> > +             if (listener)
> > +                     llc_release_incoming_children(sk);
> >               release_sock(sk);
> >               llc_sap_put(sap);
> >       } else {
> > +             if (listener)
> > +                     llc_release_incoming_children(sk);
> >               release_sock(sk);
> >       }
>
> [Severity: High]
> Is it safe to call llc_release_incoming_children() here with softirqs
> enabled?  This path holds only lock_sock(sk), and lock_sock_nested() ends
> with spin_unlock_bh(), so softirqs are on.  llc_release_incoming_children=
()
> then takes the child's slock with a plain spin_lock():
>
> net/llc/llc_conn.c:llc_release_incoming_children() {
>         ...
>                 if (newsk !=3D sk)
>                         bh_lock_sock_nested(newsk);
>         ...
> }
>
> The same slock is taken from softirq context by the receive path and by t=
he
> LLC timer callbacks:
>
> net/llc/llc_c_ac.c:llc_conn_tmr_common_cb() {
>         ...
>         bh_lock_sock(sk);
>         ...
> }
>
> While that child lock is held the child is still published in the SAP has=
h
> (llc_sap_remove_socket() only runs later inside llc_release_incoming_sock=
())
> and llc_estab_match() still matches it, so can a NET_RX softirq on the sa=
me
> CPU look up that child and spin on the held lock?
>
> The window is even opened from inside the critical section:
> llc_release_incoming_sock() -> llc_sap_remove_socket() does
> spin_unlock_bh(&sap->sk_lock), whose local_bh_enable() runs pending softi=
rqs
> while the child's plain spin_lock is still held:
>
> llc_ui_release()
>   llc_release_incoming_children()
>     bh_lock_sock_nested(child)
>       llc_release_incoming_sock(child)
>         llc_sap_remove_socket()
>           spin_unlock_bh(&sap->sk_lock)   /* runs softirqs */
>             llc_rcv() -> llc_conn_handler() -> bh_lock_sock(child)
>
> Elsewhere LLC wraps such acquisitions in local_bh_disable(), for example
> llc_lookup_established().  Would a lockdep inconsistent softirq-on /
> in-softirq usage report also fire here on CONFIG_PROVE_LOCKING?
>
> [ ... ]
>
> > diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> > index 260460d50f54c..bc05a5f66f95f 100644
> > --- a/net/llc/llc_conn.c
> > +++ b/net/llc/llc_conn.c
> > @@ -354,7 +360,8 @@ static int llc_conn_service(struct sock *sk, struct=
 sk_buff *skb)
> >       struct llc_sock *llc =3D llc_sk(sk);
> >       int rc =3D 1;
> >
> > -     if (llc->state > NBR_CONN_STATES)
> > +     if (llc->state < LLC_CONN_STATE_ADM ||
> > +         llc->state > NBR_CONN_STATES)
> >               goto out;
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but could this hunk be split o=
ut
> with its own changelog?  The added lower bound looks like it fixes a
> distinct, remotely reachable out-of-bounds access that the commit message
> does not mention.
>
> Without it, llc_qualify_conn_ev() indexes element -1 when llc->state is
> LLC_CONN_OUT_OF_SVC (0) and then calls function pointers read from there:
>
> net/llc/llc_conn.c:llc_qualify_conn_ev() {
>         struct llc_conn_state *curr_state =3D
>                                         &llc_conn_state_table[llc->state =
- 1];
>         ...
> }
>
> State 0 is reachable from a received frame, since llc_adm_state_trans_5 h=
as:
>
> net/llc/llc_c_st.c
> static const struct llc_conn_state_trans llc_adm_state_trans_5 =3D {
>         .ev            =3D llc_conn_ev_rx_any_frame,
>         .next_state    =3D LLC_CONN_OUT_OF_SVC,
>         ...
> };
>
> and llc_estab_match() does not filter on llc->state, so the socket keeps
> being returned by __llc_lookup() for subsequent frames.  As written, a
> stable backporter has no indication that a memory-safety fix is included
> here.
>
> [ ... ]
>
> > +void llc_release_incoming_children(struct sock *sk)
> > +{
> > +     struct sk_buff *skb;
> > +
> > +     while ((skb =3D skb_dequeue(&sk->sk_receive_queue))) {
> > +             struct sock *newsk =3D skb->sk;
> > +
> > +             if (newsk !=3D sk)
> > +                     bh_lock_sock_nested(newsk);
> > +             if (newsk !=3D sk) {
> > +                     llc_release_incoming_sock(newsk);
> > +                     kfree_skb(skb);
> > +                     bh_unlock_sock(newsk);
> > +             } else {
> > +                     kfree_skb(skb);
> > +             }
> > +     }
> > +}
>
> [ ... ]
>
> > @@ -795,10 +921,25 @@ void llc_conn_handler(struct llc_sap *sap, struct=
 sk_buff *skb)
> >       bh_lock_sock(sk);
> > +     if (unlikely(sock_flag(sk, SOCK_DEAD)))
> > +             goto drop_unlock;
>
> [Severity: Medium]
> Is this test too broad?  llc_ui_release() only sets SOCK_DEAD when the
> socket is in TCP_LISTEN, but this check runs right after __llc_lookup() a=
nd
> so applies to every socket the lookup returns.
>
> Existing code already sets SOCK_DEAD on ordinary established stream socke=
ts
> when the peer disconnects:
>
> net/llc/llc_conn.c:llc_conn_state_process() {
>         case LLC_DISC_PRIM:
>                 ...
>                 if (sk->sk_type =3D=3D SOCK_STREAM &&
>                     sk->sk_state =3D=3D TCP_ESTABLISHED) {
>                         ...
>                         if (!sock_flag(sk, SOCK_DEAD)) {
>                                 sock_set_flag(sk, SOCK_DEAD);
>                                 sk->sk_state_change(sk);
>                         }
>                 }
> }
>
> At that point the socket is still published in the SAP tables, because
> llc_sap_remove_socket() only runs from llc_ui_release(), and
> llc_estab_match() still matches it.  After such a peer-initiated disconne=
ct,
> are all further frames for that tuple now silently dropped instead of
> running the ADM-state transitions that answer retransmitted DISC and othe=
r
> commands with DM responses (llc_adm_state_trans_3 and
> llc_adm_state_trans_4)?  That is the same protocol behaviour this patch
> open-codes for listeners in llc_conn_send_dm_rsp().
>
> Would distinguishing the listener case, for instance testing
> sk->sk_state =3D=3D TCP_LISTEN together with SOCK_DEAD, or using a dedica=
ted
> flag, be closer to the intent?
>
> > +     if (newsk_lookup_ref) {
> > +             bh_lock_sock_nested(newsk);
> > +             newsk_locked =3D true;
> > +             if (atomic_read(&llc_sk(newsk)->incoming_state) !=3D
> > +                 LLC_INCOMING_PENDING)
> > +                     goto retry_unlock;
> > +     }
> >       /*
> >        * This has to be done here and not at the upper layer ->accept
> >        * method because of the way the PROCOM state machine works:
> > @@ -795,10 +921,25 @@ void llc_conn_handler(struct llc_sap *sap, struct=
 sk_buff *skb)
> >        * in the newly created struct sock private area. -acme
> >        */
> >       if (unlikely(sk->sk_state =3D=3D TCP_LISTEN)) {
>
> [Severity: Medium]
> When the lookup returned an LLC_INCOMING_PENDING child, sk was re-pointed=
 at
> the child's incoming_listener and only SOCK_DEAD was validated afterwards=
.
> What happens if that socket is no longer TCP_LISTEN?
>
> This condition is then false and control falls into the non-listener else
> branch:
>
>         } else {
>                 skb_orphan(skb);
>                 sock_hold(sk);
>                 skb->sk =3D sk;
>                 skb->destructor =3D sock_efree;
>         }
>
> so the child's PDU is fed into the ex-listener's own connection state
> machine, since llc_conn_state_process() runs llc_conn_service(skb->sk, sk=
b).
> The backlog path guards exactly this case:
>
> net/llc/llc_conn.c:llc_backlog_rcv() {
>         ...
>                         if (sock_flag(sk, SOCK_DEAD) ||
>                             sk->sk_state !=3D TCP_LISTEN)
>                                 goto out_unlock_newsk;
>         ...
> }
>
> Reachability looks similar to the llc_ui_release() case above: connect() =
on
> a listening socket is permitted and sets sk_state to TCP_SYN_SENT under
> lock_sock(), a SABME that arrived while the lock was owned leaves a PENDI=
NG
> child, and a second frame for that tuple arriving before release_sock()
> drains the backlog takes the redirect path with sk_state =3D=3D TCP_SYN_S=
ENT.
> Can a frame from peer A then drive the state machine of a socket that is
> connecting to peer B, while the PENDING child is torn down by
> llc_release_incoming_sock() without its frame ever being processed for it=
?
>
> [ ... ]
>
> > @@ -852,12 +1013,38 @@ static int llc_backlog_rcv(struct sock *sk, stru=
ct sk_buff *skb)
> >  {
> >       int rc =3D 0;
> >       struct llc_sock *llc =3D llc_sk(sk);
> > +     struct sock *newsk =3D NULL;
> >
> >       if (likely(llc_backlog_type(skb) =3D=3D LLC_PACKET)) {
> > -             if (likely(llc->state > 1)) /* not closed */
> > +             newsk =3D skb->sk;
> > +             if (newsk &&
> > +                 atomic_read(&llc_sk(newsk)->incoming_state) =3D=3D
> > +                 LLC_INCOMING_PENDING) {
> > +                     bh_lock_sock_nested(newsk);
>
> [Severity: High]
> Same locking question as in llc_release_incoming_children(): this handler
> runs from release_sock() -> __release_sock(), which drops the parent sloc=
k
> with spin_unlock_bh() and even calls cond_resched() in that loop:
>
> net/core/sock.c:__release_sock() {
>                 spin_unlock_bh(&sk->sk_lock.slock);
>                 while (1) {
>                         ...
>                         sk_backlog_rcv(sk, skb);
>         ...
> }
>
> so softirqs are enabled here too.  Can these bh_lock_sock_nested() and
> bh_lock_sock() acquisitions on the child (also in the retry,
> out_unlock_newsk and out_kfree_skb paths) deadlock against the same lock
> taken from llc_rcv() -> llc_conn_handler() or from the LLC timer callback=
s
> on the same CPU?  The child slock is additionally held across a full
> llc_conn_rcv() state-machine run, including dev_queue_xmit().
>
> > +                     if (atomic_read(&llc_sk(newsk)->incoming_state) !=
=3D
> > +                         LLC_INCOMING_PENDING) {
> > +                             bh_unlock_sock(newsk);
> > +                             goto retry;
> > +                     }
> > +                     if (sock_flag(sk, SOCK_DEAD) ||
> > +                         sk->sk_state !=3D TCP_LISTEN)
> > +                             goto out_unlock_newsk;
> >                       rc =3D llc_conn_rcv(sk, skb);
> > -             else
> > +                     if (atomic_read(&llc_sk(newsk)->incoming_state) =
=3D=3D
> > +                         LLC_INCOMING_PENDING)
> > +                             llc_release_incoming_sock(newsk);
> > +                     bh_unlock_sock(newsk);
> > +             } else if (newsk &&
> > +                        atomic_read(&llc_sk(newsk)->incoming_state) =
=3D=3D
> > +                        LLC_INCOMING_QUEUED) {
> > +                     bh_lock_sock(newsk);
> > +                     rc =3D llc_conn_rcv(newsk, skb);
> > +                     bh_unlock_sock(newsk);
> > +             } else if (likely(llc->state > 1)) {
> > +                     rc =3D llc_conn_rcv(sk, skb);
> > +             } else {
> >                       goto out_kfree_skb;
> > +             }
>
> [Severity: Medium]
> The new QUEUED branch dispatches into llc_conn_rcv(newsk, skb) with no
> closed-state filter, while the surviving else-if branch still keeps the
> llc->state > 1 test.  Combined with the new lower bound in
> llc_conn_service(), does a frame for a child left in LLC_CONN_OUT_OF_SVC =
now
> produce one unratelimited log line per frame?
>
> llc_conn_service() returns 1 for state below LLC_CONN_STATE_ADM, and
> llc_conn_state_process() prints unconditionally:
>
> net/llc/llc_conn.c:llc_conn_state_process() {
>         rc =3D llc_conn_service(skb->sk, skb);
>         if (unlikely(rc !=3D 0)) {
>                 printk(KERN_ERR "%s: llc_conn_service failed\n", __func__=
);
>                 goto out_skb_put;
>         }
>         ...
> }
>
> State 0 looks remotely reachable: a child back in ADM (NORMAL plus rx DIS=
C)
> that then receives any frame that is neither SABME, DISC nor a command wi=
th
> P=3D1 hits llc_adm_state_trans_5 with .next_state =3D LLC_CONN_OUT_OF_SVC=
 and a
> no-op action, while it is still hashed in the SAP table and matched by
> llc_estab_match().  Every further frame for that tuple would then reach t=
his
> branch, and the direct llc_conn_rcv() path in llc_conn_handler(), and emi=
t
> another KERN_ERR line.  Would filtering the closed state in these new
> branches be preferable to letting llc_conn_service() fail?
>
> [ ... ]
> --
> pw-bot: cr
Hi Jakub,

Thanks for forwarding the review.

I agree there are enough concerns here to warrant a v2. I=E2=80=99ll rework=
 the
patch and recheck the listener-child cleanup path, the child socket
locking, and the closed-state handling. I=E2=80=99ll also split out the
llc->state lower-bound change if it is indeed a separate fix.

Thanks,
Zihan
