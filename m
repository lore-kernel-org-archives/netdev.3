Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF5227A91D
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788320175; cv=pass; b=MtKcvwO+Y1cGI7i75ouV7RUnIchuFL3tMBL6gcIaDPa0KjBXCs11N+MzIoyZWss9KfPuD+pPUXq8pX5Wd8fWrWzsxDET2hTCujx0zZawMCtLXOAUmukCdQINvqIiDkBHcDjX9A1hx0/evSkn90ulXFuK5pBRGbehT9JP94jyCF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788320175; c=relaxed/simple;
	bh=MBRR2QE/1sl+Ph3CpG18ShB2Bzi1dIhs75byozISlGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NybBjqN6XSUBjBA1pVWhlNCRP/USBmeOzu75FYIB8xKx6S5ta0zVwzCecFazkmT0fQqP3S98DoZmvrpnCzvtTzrwiKq6Mkud3GR26RgbOn35kiISk4StP3gZvwGgKdT1GrllcqupUUf8MFuvibr3OSOWOoNUlnxTXSOe97wBpe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=eUk0uQe2; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="eUk0uQe2"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aec201b582so672482e87.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 20:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788320171; cv=none;
        d=google.com; s=arc-20260327;
        b=WyvNPzmByRSFf/B0T/ec/eFNfNPFpQPrFbCQSpDI6+neWmE2frl5pUT+7QIkn3E3gT
         BcvTC1ynv3KlGBf6KwzHOXOSE5bSEervizmETPUJmo2txvUocBseUC7rnFkI5+95vl61
         P7RmfoYqkiR0xbImPVst4/Ai083dqRF1Ogu5zeBAKbFBYJkVH/8q3KlCjjOz40DptUzx
         TI0RCIzlT+0fNZG6byWSuZscHFMSemNX7xTrSFDzq5+9yzQeGJFAZa2GREQqbStlVwTi
         7pYsl6lCMOh5OEhSaiKvRDldK/nruUtYejmXShnMgQQfF92OEkyro6SKKJy9fv7xK4gr
         Fayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WZJ6GV0DqGuA2eo3lm1kA/JjLv1Db3xa1qf9KZGwzIg=;
        fh=xTPakTUgYSGUKVvY2V6SwMnZfW9/Fq2/vppTn/NMl6E=;
        b=oX3wNPM08wXD6qNaDKjfrV6ocFkiZOnErNG+kkpBhpUcQfbGkLoOUku31tD1Y4Glhy
         cMC2pR/1SlV3F3XrbQRIok/JN4ioCmtBogqvzqE4JS3NYRw7aJdag4vLBqk3vFzdl95y
         Kj8yGH7uXvceKQziGgGdWJJi/bdZnnjK85f9hs86yE9ttPElxXxxvV9+H8/u8NeDFXQQ
         o8qM1QsvgouAhgmPvXgeTFSGS43GomStxyQ4Nvohpqu1V4s7RFDzi3ISfzQ62ihzGkxo
         NMOE4Qh90EIUEh5sJ0+XvAQwJaVvQjzl/inQ32HsGVeZYSWSMk8WH6ck3Va9OZezoMV2
         QFfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788320171; x=1788924971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WZJ6GV0DqGuA2eo3lm1kA/JjLv1Db3xa1qf9KZGwzIg=;
        b=eUk0uQe2K6FS5t6Jz9GmN81BGc3O2SX+h8bX/YLofBc0DfZw2ofuWCo3Pw8lR1Ir7g
         5PFkPzR1clDLy+CxJvudjebxuUIxK+OBW7CvXazrbDKsHTRpE2jk+DNNf4frp5eejekX
         6QqkC1fbs1SXBrvlKPgsirUT648RKKcwyu0kV+LRGAEVyg2BKtzX5PBrSVhYGD6Mp9jM
         m+1IqIBSyEGi6iy38HZY+34bfIpGMMtOgfkR0jkEyUjmNxXuHBAUiOJTOeb8a3F2AAhi
         IcXVI6Gzk3lJ8oicQu+Ju92KAFG41ohE+N8SV0axq8S3uO7b8HIlVeAn/KBmRldlnClh
         VH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788320171; x=1788924971;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WZJ6GV0DqGuA2eo3lm1kA/JjLv1Db3xa1qf9KZGwzIg=;
        b=j0G2zJEnImt2fy4Xcs5cb1MJpm3i097wCifpecg7Bi/z9HBxGUQ+u+ENO6tRMKX7qQ
         JHjCJzM6tX2UFLMF+Sl8M9MZWLMH6N4ZZavz758V44N7KlddA00ZEnvB5DfA1wGNfO71
         msNqRj66/uwKOH2xIzPcRyf04rC1g4vflWiH+bsyGWSWEbYAr9n+zGWuR0893BXyRqvC
         Xbi8NtyU+jmlr1se+oHmMdVSE+B4F5FgdEexomytWs9AXVdM2hWVhFYg0gzSGmHlt1Vk
         M5vymh0pAYJAn47KP6s98oodPFnR4DYfhlQgwQfukxh9iZ/secQ8CL1bopxB4xrf22Nd
         7ydA==
X-Forwarded-Encrypted: i=1; AKwUvBxTQB2tn3Dc+9NLPGnxqcSQjfb8ou9Nee2UcLgS0ENvE4PFW17qr0DyPPCW5+TjXlfHyeb3VKM=@vger.kernel.org
X-Gm-Message-State: AFuF++kJw6ybKhBe723z93KHxR8/GGwZWamk7LwZWuulhlCjo6Ef9dEj
	Gndkwo0iZ/e6WMpUlDhnkw6fs+07PL2UEmG2gVe+DpCWSHhXiWx8jOm5I0mpfrGNZ8SC1WN9LdQ
	EEmUPRoWVQZTEekIAovpTIZliDQ9GchhWaD/UHteTXVU=
X-Gm-Gg: AYBFou32AzbMUEsHVh36mszF/+ZQz7UMFxB16O7FZe9g5BSBbm79vz3n4ZWGpI194r+
	HLXo27DKKdennnARnnjPgYBA0jsn5MWJ2FNbEvIao8c24/xNy0hMN89BXfLlIDyXJfPniKhKfKF
	S2ZlCSD0ZmDZ4SMOB/mWa98QeF+AUp4OGr6sAsssxwJBp10tMYhDUqwyTlNrnk6pwGX+S9NbDFm
	eewZzl8UhuafI2emj4Hw7dcV/QvodszMuWE+YYQULzhTOWTyDzNEZR3GY5bYt2zXGpQ34qA2QaN
	ZpXTmPABTAIB72gsurin9UrNI3DFkL0M6l/WPQYk/pbuemG6BooXrcYEqssSkyvsM1AN6VTgMU2
	Qg/2NzL9xyOGiMBo2NrKLi3LMylkiffY=
X-Received: by 2002:a05:651c:1544:b0:3a1:7eff:413c with SMTP id
 38308e7fff4ca-3a35013ab1fmr3450211fa.10.1788320170983; Tue, 01 Sep 2026
 20:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8fa3c9e6d5dcf328979ed2bdc27817c11a5eff91.1787752861.git.zihanx@nebusec.ai>
 <20260902010052.2297527-1-kuba@kernel.org>
In-Reply-To: <20260902010052.2297527-1-kuba@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Wed, 2 Sep 2026 11:35:58 +0800
X-Gm-Features: AcwNN1W5A5Vr5_mfUAJhRgWg73KHuqbWAvozEtCFXeIQlCxjhsSFewh8gZGNXlA
Message-ID: <CAANe3eS3knCks0avTO87C_Qg+FL4=NDi-xwFWyNhGPpQU-rKzw@mail.gmail.com>
Subject: Re: [PATCH net v6 2/2] llc: reject out-of-service state before state lookup
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, vega@nebusec.ai, kees@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 9:00=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> llc: reject out-of-service state before state lookup
>
> This adds a lower-bound check on llc->state in llc_conn_service() so that=
 a
> socket sitting in LLC_CONN_OUT_OF_SVC is rejected before llc_qualify_conn=
_ev()
> indexes llc_conn_state_table[state - 1].  A few questions about the new
> check below.
>
> > diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> > index 885a5c33024c3..4a34f240ad2cc 100644
> > --- a/net/llc/llc_conn.c
> > +++ b/net/llc/llc_conn.c
> > @@ -362,7 +362,8 @@ static int llc_conn_service(struct sock *sk, struct=
 sk_buff *skb)
> >       struct llc_sock *llc =3D llc_sk(sk);
> >       int rc =3D 1;
> >
> > -     if (llc->state > NBR_CONN_STATES)
> > +     if (llc->state < LLC_CONN_STATE_ADM ||
> > +         llc->state > NBR_CONN_STATES)
> >               goto out;
>
> [Severity: High]
> Does this check actually protect the table access, given that the validat=
ed
> value is not latched?  llc_qualify_conn_ev() re-reads llc->state twice to=
 do
> the indexing:
>
> net/llc/llc_conn.c:llc_qualify_conn_ev() {
>         struct llc_conn_state *curr_state =3D
>                                         &llc_conn_state_table[llc->state =
- 1];
>         ...
>         for (next_trans =3D curr_state->transitions +
>                 llc_find_offset(llc->state - 1, ev->type);
>              (*next_trans)->ev; next_trans++) {
>                 if (!((*next_trans)->ev)(sk, skb)) {
>         ...
> }
>
> The store that produces state 0 is done with no socket lock at all:
>
> net/llc/llc_conn.c:llc_sk_free() {
>         llc->state =3D LLC_CONN_OUT_OF_SVC;
>         /* Stop all (possibly) running timers */
>         llc_sk_stop_all_timers(sk, sync);
>         ...
> }
>
> and llc_ui_release() calls it after dropping the socket lock and before t=
he
> timers are synchronized:
>
> net/llc/af_llc.c:llc_ui_release() {
>         ...
>                 llc_release_incoming_children(sk);
>                 release_sock(sk);
>         ...
>         llc_sk_free(sk, true);
> }
>
> So can this interleaving happen for a socket closed while an ack timer is
> still armed (for example a non-blocking connect() left in
> LLC_CONN_STATE_SETUP, where llc_send_disc() returns early because sk_stat=
e
> is not TCP_ESTABLISHED and stops nothing)?
>
> CPU0 (softirq, ack timer)
> llc_conn_ack_tmr_cb() -> llc_conn_tmr_common_cb()
>         bh_lock_sock(sk);          /* excludes nothing here */
>         llc_process_tmr_ev()       /* sees state 2, !sock_owned_by_user()=
 */
>           llc_conn_state_process() -> llc_conn_service()
>                 reads llc->state =3D=3D 2, passes the new bound check
>
> CPU1 (close(2))
> llc_ui_release() -> release_sock(sk) -> llc_sk_free()
>         llc->state =3D LLC_CONN_OUT_OF_SVC;     /* unlocked store of 0 */
>
> CPU0 continues into llc_qualify_conn_ev()
>         &llc_conn_state_table[llc->state - 1]   /* now index -1 */
>         llc_find_offset(llc->state - 1, ev->type)
>         (*next_trans)->ev(sk, skb)              /* indirect call */
>
> Since bh_lock_sock() in llc_conn_tmr_common_cb() does not exclude a write=
r
> that holds no lock, is the negative index and the indirect call through t=
he
> pointer read from before the tables still reachable after this patch?
>
> Would latching the value once, for example
>
>         u8 state =3D READ_ONCE(llc->state);
>
> and passing that value down to llc_qualify_conn_ev() and llc_find_offset(=
),
> or moving the llc_sk_free() state store under the socket lock, be a bette=
r
> fit for the problem described in the changelog?
>
> >       rc =3D 0;
> >       trans =3D llc_qualify_conn_ev(sk, skb);
>
> [Severity: Medium]
> The goto out here leaves rc at its initial value of 1, which was previous=
ly
> unreachable for a state of 0.  Where does that 1 end up?
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
> net/llc/llc_if.c:llc_establish_connection() {
>         ...
>                 rc =3D llc_conn_state_process(sk, skb);
>         }
> out_put:
>         sock_put(sk);
>         return rc;
> }
>
> net/llc/af_llc.c:llc_ui_connect() {
>         rc =3D llc_establish_connection(sk, llc->dev->dev_addr,
>                                       addr->sllc_mac, addr->sllc_sap);
>         if (rc) {
>                 sock->state  =3D SS_UNCONNECTED;
>                 sk->sk_state =3D TCP_CLOSE;
>                 goto out;
>         }
>         ...
> out:
>         release_sock(sk);
>         return rc;
> }
>
> Can connect(2) then return +1 to userspace on a socket that was just rese=
t
> to SS_UNCONNECTED and TCP_CLOSE?  Callers testing for a negative return
> would read that as success.
>
> Is the printk also a concern, since it is not ratelimited and now fires o=
nce
> per event for a state this patch treats as expected?
>
> The sequence I believe reaches it on a still-hashed socket:
>
>   1. socket(AF_LLC, SOCK_STREAM) + bind() leaves llc->state at
>      LLC_CONN_STATE_ADM
>   2. a failing connect() leaves state at ADM with llc->daddr set and the
>      socket still in the SAP list
>   3. any further frame from the peer matches the ADM catch-all transition
>
> net/llc/llc_c_st.c:
> static const struct llc_conn_state_trans llc_adm_state_trans_5 =3D {
>         .ev            =3D llc_conn_ev_rx_any_frame,
>         .next_state    =3D LLC_CONN_OUT_OF_SVC,
>         .ev_qualifiers =3D NONE,
>         .ev_actions    =3D llc_adm_actions_5,
> };
>
>      which sets llc->state to 0
>   4. connect(2) again (sock->state is SS_UNCONNECTED, so it is accepted)
>      reaches the new reject path
>
> Would it be more consistent to translate out-of-service into -ECONNABORTE=
D
> at the llc_if.c entry points?  llc_send_disc() already does an explicit
> check:
>
> net/llc/llc_if.c:llc_send_disc() {
>         if (sk->sk_type !=3D SOCK_STREAM || sk->sk_state !=3D TCP_ESTABLI=
SHED ||
>             llc_sk(sk)->state =3D=3D LLC_CONN_STATE_ADM ||
>             llc_sk(sk)->state =3D=3D LLC_CONN_OUT_OF_SVC)
>                 goto out;
>         ...
> }
>
> while llc_establish_connection() has no such check.  On a related note, t=
he
> kernel-doc for llc_build_and_send_pkt() still documents only 0,
> -ECONNABORTED and -EBUSY, although state 0 is filtered there only
> incidentally by llc_data_accept_state().
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but while looking at the calle=
rs
> of llc_conn_service() there is an asymmetry in llc_backlog_rcv() worth
> mentioning.  The fallback branch tests the owner socket's state and then
> dispatches on it, while llc_conn_state_process() operates on skb->sk:
>
> net/llc/llc_conn.c:llc_backlog_rcv() {
>         ...
>         } else if (likely(llc->state > 1)) {
>                 rc =3D llc_conn_rcv(sk, skb);
>         } else {
>                 goto out_kfree_skb;
>         }
>         ...
> }
>
> The two branches above it take bh_lock_sock_nested(newsk) before touching=
 a
> child, this one does not.  For a listener-owned backlog skb whose skb->sk=
 is
> a child, the child's state machine runs without the child's lock, even
> though llc_conn_state_process() documents that the socket lock has to be
> held.
>
> Every child reachable through this branch appears to have already been
> released by llc_release_incoming_sock(), whose state store the new check =
now
> rejects, so this looks defused for the concretely reachable case.  What
> remains is the publication order in that function:
>
> net/llc/llc_conn.c:llc_release_incoming_sock() {
>         if (atomic_xchg(&llc->incoming_state, LLC_INCOMING_NONE) =3D=3D
>             LLC_INCOMING_NONE)
>                 return;
>
>         WRITE_ONCE(llc->state, LLC_CONN_OUT_OF_SVC);
>         ...
> }
>
> Can a drainer in the fallback branch observe incoming_state as
> LLC_INCOMING_NONE while still seeing the child's pre-teardown non-zero
> state, and then run the child's state machine concurrently with
> llc_release_incoming_sock() on another CPU?  Both fields are read there
> without the child's bh lock.  Reaching the branch at all also needs the
> listener's own llc->state above 1, which seems possible only through a
> listen() followed by connect() on the same socket, since llc_ui_listen()
> leaves sock->state at SS_UNCONNECTED and llc_ui_connect() has no TCP_LIST=
EN
> check.  I could not confirm that all of these hold at the same time, so t=
his
> may not be reachable in practice.
> --
> pw-bot: cr

Thanks for the review. The points on 2/2 look valid, especially the
unlatched llc->state check versus llc_sk_free(), and the connect(2)
return of +1 / unratelimited printk path.

I'll drop 2/2. Kees's net-next series covers the same out-of-service
lookup more completely, including the state machine guard and the
-ECONNABORTED translation:

  https://lore.kernel.org/all/20260901210300.i.590-kees@kernel.org/

I'll leave that bug to his series.

1/2 is a separate listener child-socket leak and is not addressed
there. I'll reroll that alone as v7.

The remaining note about llc_backlog_rcv() / llc_release_incoming_sock()
belongs to 1/2; I'll look at the publication order there in the reroll.

Thanks,
Zihan
