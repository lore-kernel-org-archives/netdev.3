Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560407;
	b=lNKpaTtLOp6onS5wemfy6zdqZRuZCmxWgI5qwnr5jf67+ISl8ecExMiT4AGpcjltTiiI
	 hKL3uNEnlAPpaw2ZjMvpwtzsK4ObNm+BMRi+IYfpY9d75TmWN51PfSZzW41SYsUggo/p4
	 GSB+oq+/gYKwWhxo0diP1aoDg+PJxRTLe7K9SEsWcH6WzK7lY7eYACufT3+4TEVI1I0P6
	 fUrLNrREIQKDMTl5HL9OO2Nzb+srgPFlpKSBCg26k4ouuD1MZo+KAFIp4pREdGLN7H/L/
	 XO4eF8RmsbIIhbf6mOw3HQ149q4/z3rKtcx8t/5CI1tbT5MVnEWBk69s30EYRGIhNuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560407;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nDmZz/9Lu+rwI73C7kuZiJ5O7j/5N39qJGbbT04Ep/k=;
	b=1V49UhAgbyHLom7uaP+7+q9IYIAAWWWeGjG+G/rbUTqZRZ+OLYieFr27tyf9ftRL5awB
	 aUoRD98zlzs7JnlTSTOJVoa80ipM5thgDrNH01qAHyQUUrBvKcPAgqd0tftgmp8698Ls9
	 5/SViwiUR94CFkn8p9CuY2jqsP2iLoyJ6Y+K4wBk5pCcGzPBcdxL2g13zVcUSp8/JN4hf
	 /kTXKt0gH3bh2RgplckenHM8WsCfDybMXvlFfzCLiiYvWXR19owLd7P7ZDRLhoEBWOGY0
	 wQrNh5i3oBErKDSs005VrQ4i0WzpX3L6jjY7O2qJOXeiyCgtBhntD7mgiPYD1TvyMcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LfSwP/kq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DCD606A32E
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfSwP/kq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170BE1F000CC
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794560407;
	bh=nDmZz/9Lu+rwI73C7kuZiJ5O7j/5N39qJGbbT04Ep/k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LfSwP/kqup8ZV1V5xTHwhz73bxZLsYinXaPWO/+z7CnpWPuuuK4n9XIYAMiJ6hoDG
	 nMarxgh7j+Y0rEQJNBn+K0xjzwGcftlXNrWn+LKMYJJOWXdSXyqcc21QisiOfJZCMq
	 end+/zcXMDJFvMAXke36CuIp5g5DtWHMU1Z+WIMLqX/IZI7Vso3GZUfWCu9v427J0W
	 WeINJ0WzQIKpm+oGv9rPA8ZJ5yQo5eOyGrHJV/R+w0y+PJZlarNtCqp7KDCmf6+EK8
	 xOCM3wB3zvYfAkBZ1DQC6+LPub+BnwpgdW1cwmLVzGftC35j1PbEqk/43kxf9pQcQb
	 Qo6+FOWwEtn3A==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6dde81a6820so887137eaf.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 01:00:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEMonkgkYcHAyR+56UTiNNdxAOwdlQLQqkRA9NhS001MlIhs7gc+OKGofb0a5c93o4hB5sCVJ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vE7WeKlry6T9Ow7+nWnxSE7iqoX/bDTbO3gOzhSoDZKUekLy3
	Y7rGiehJkaHoeVEzqUJXDb70QbIuFJVB0uJg8trz3s8G1C04Apsv13BvkyWjj7upbLLAwliq0z1
	17j41IJmDqu498i2sefXBxjXX2+Tc9NQ=
X-Received: by 2002:a05:6820:1608:b0:719:1627:6c0b with SMTP id
 006d021491bc7-71ab4f0c1d5mr1095396eaf.15.1794560406139; Fri, 13 Nov 2026
 01:00:06 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <avMkfJrXhCFXn8M_@v4bel> <179450310167.2199510.18107423940014989443@kernel.org>
In-Reply-To: <179450310167.2199510.18107423940014989443@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 13 Nov 2026 09:59:54 +0100
X-Gmail-Original-Message-ID: <CAL4WiioP-25nYs19MiNAjnzbvi-H870uem1W+jY5jTJb=DKn+g@mail.gmail.com>
X-Gm-Features: AclHuK9NNSpFmdpVPLO-9WPIlgqsMexzOEss1wg0JOnZXh8zBeNfDDnJO3kSg4I
Message-ID: <CAL4WiioP-25nYs19MiNAjnzbvi-H870uem1W+jY5jTJb=DKn+g@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: fix NULL pointer dereference when restarting
 a Fast Open listener
To: netdev-bot+sashiko@kernel.org
Cc: imv4bel@gmail.com, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 12 nov. 2026 =C3=A0 18:05, <netdev-bot+sashiko@kernel.org> a =C3=A9=
crit :
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The patch is meant to stop request_socks from being stranded in
>   rskq_rst_head while they hold a listener reference, but another path=E2=
=80=A6
>
> --
>
> tcp: fix NULL pointer dereference when restarting a Fast Open listener
>
> This patch makes inet_csk_listen_stop() always take fastopenq.lock and
> detach rskq_rst_head while holding it. That serializes the drain against
> reqsk_fastopen_remove() adding entries to the RST list. The goal is to
> stop request_socks from being stranded on rskq_rst_head while holding a
> listener reference, and to avoid the NULL rskq_rst_tail dereference seen
> when listen() is called again.
>
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection=
_sock.c
> > index 37cc8606d6835..9ca59dca5d184 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -1533,17 +1533,15 @@ void inet_csk_listen_stop(struct sock *sk)
>
> [ ... ]
>
> > +     /* Free all the reqs queued in rskq_rst_head. */
> > +     spin_lock_bh(&queue->fastopenq.lock);
> > +     req =3D queue->fastopenq.rskq_rst_head;
> > +     queue->fastopenq.rskq_rst_head =3D NULL;
> > +     spin_unlock_bh(&queue->fastopenq.lock);
> > +     while (req !=3D NULL) {
> > +             next =3D req->dl_next;
> > +             reqsk_put(req);
> > +             req =3D next;
> >       }
> >       WARN_ON_ONCE(sk->sk_ack_backlog);
> >  }
>
> [Severity: High]
> Is this fix complete? The commit message says:
>
>     With this synchronization, reqsk_fastopen_remove() either inserts the
>     request_sock before inet_csk_listen_stop() acquires the lock, in whic=
h
>     case inet_csk_listen_stop() reclaims it, or sees that the listener is
>     not in TCP_LISTEN and does not insert anything.
>
> That argument only holds if every exit from TCP_LISTEN goes through
> inet_csk_listen_stop(). The failure path in inet_csk_listen_start()
> does not:
>
> net/ipv4/inet_connection_sock.c:inet_csk_listen_start() {
>     ...
>         reqsk_queue_alloc(&icsk->icsk_accept_queue);
>     ...
>         inet_sk_state_store(sk, TCP_LISTEN);
>         err =3D sk->sk_prot->get_port(sk, inet->inet_num);
>         if (!err) {
>                 ...
>                 err =3D sk->sk_prot->hash(sk);
>
>                 if (likely(!err))
>                         return 0;
>         }
>
>         inet_sk_set_state(sk, TCP_CLOSE);
>         return err;
> }
>
> Take a listener that went through shutdown(SHUT_RD) or connect(AF_UNSPEC)
> while an accepted Fast Open child was still in SYN_RECV. Then listen() is
> called on it again. If an RST for that child arrives after TCP_LISTEN is
> stored, reqsk_fastopen_remove() passes this check under fastopenq->lock:
>
>         if (!reset || lsk->sk_state !=3D TCP_LISTEN) {
>
> It then links req onto rskq_rst_head/rskq_rst_tail without calling
> reqsk_put().
>
> Now suppose get_port() fails afterwards, for example with EADDRINUSE
> because another SO_REUSEADDR socket started listening on the port, or
> hash() fails. The socket goes back to TCP_CLOSE and rskq_rst_head is neve=
r
> drained.
>
> A later close() will not reclaim the list, because __tcp_close() only
> calls inet_csk_listen_stop() when sk_state =3D=3D TCP_LISTEN. A later
> successful listen() just overwrites the list in reqsk_queue_alloc():
>
>         queue->fastopenq.rskq_rst_head =3D NULL;
>         queue->fastopenq.rskq_rst_tail =3D NULL;
>
> Does this leak the request_sock? If so, it also leaks the listener
> reference taken in reqsk_alloc_noprof(), which only
> sock_put(req->rsk_listener) in __reqsk_free() drops. That would pin the
> listener sock and its netns reference too.
>
> This looks like the same leak the commit message describes, reached
> through a different TCP_LISTEN -> TCP_CLOSE transition.
>
> Should the inet_csk_listen_start() error path also drain fastopenq under
> fastopenq.lock? Alternatively, could the drain move to a place that cover=
s
> both paths?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/avMkfJrXhCFXn8M_%40v4bel

This looks legitimate, but it is a separate and pre-existing issue,
not something added or made worse by this patch.

inet_csk_listen_start() sets TCP_LISTEN before get_port()/hash() and
goes back to TCP_CLOSE on failure without purging rskq_rst_head, so an
RST for a Fast Open child accepted in a previous life of the listener
can queue a request there during that window. Nothing reclaims it
afterwards.

It needs listen() to fail (e.g. -EADDRINUSE because another
SO_REUSEADDR socket started listening on the port) with the RST
landing while get_port() runs, so the window is quite small.

Hyunwoo, no need to respin, your v2 is fine as is for the
inet_csk_listen_stop() side.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

I will send a follow-up on top of it, moving the purge to a helper
that is also called from the inet_csk_listen_start() error path.

Thanks.
