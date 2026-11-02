Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604526;
	b=sC59ovlRq493CJ8URW0Tlkf2inge/pwr69QJUnzf7hDUxSqFWqRm6yVthTZ/APixBy6P
	 ecSuBAIHiZ3K/QSZ1pq+6/jmvIcrepm7UG8zs1GQAHwxADzIalnUKBXg4t5nvIvtNwEYN
	 adIlAseoj+tVCP06n7FFdFJK8/GXCpQ6+3p+1q51sojKS3JHr8FXOzpOVmWYDg0+7+R5l
	 K2PM/cvt51DkEaqiAw8FlZ/yFSXiMoGN3NsrldzNZRQD4ufMijc3HCcRb1i3odTNjU1Ng
	 1xH/6wVBOhV6mO27Y/xbeISC4/1pvHgSGd8jd8S/txVT6fF9L1GC0/Po0fJMlCnExPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604526;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=If3fE+lQ75xX1Vq7CvfUefIfI5ALcUIEaypG/wi/3sA=;
	b=ik3gSSsGZcu8LKXQKziqZCPFeDuM1QhKcNC9A9eSLQ/3ZKZ0MpLmLpTIB3EJUw6Ii7cX
	 rCPlmAaLxvId8E6Hp8bpy0M2n/j7AeidMD/R0mKmd8R4SVWULR0I1s6p8cN5AUxUd93W4
	 IP8fdiRM1LLk6C00uEfnv9fLdK9FIq0ZRy9D4LblVHpf+jVXT611y4IU84/DkQJVjvVwj
	 KxQh3fRcoeTsKm3qae9SVkiuHLdnpAag+gjC6kRQ7GBAonzXN3l0AGEJ5qh2Oe2Di9BKi
	 e6ElYnFI4M1aJ3c/OVrVB1UfONXpwJikeLhcRrYneLrSC5/AkHsRbpnKjkCX7AbJqhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANPfABDF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E170606A32C
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANPfABDF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295C71F00A21
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793604525;
	bh=If3fE+lQ75xX1Vq7CvfUefIfI5ALcUIEaypG/wi/3sA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ANPfABDFS9h7v/zbtspJG+jpYTY9mf6Dam/W28kcKLm2ElLtClCumMoi7Wt2af5+/
	 dFHPLET3iKdbIwJzB7VPdp7ycb0T0Ajh7Gmm8+KUhbLlfjEzgNqi5eWUYtFCrAPdML
	 RQja44X2DHa0nNp70DsTNsvGWogE5vZKhZ2yOFWg9BI+JWay6Vi9wWh/8qado2DYaZ
	 AouH8S9bo95qcgiW56f8ZpuYHJTmpP3Xwj09585H2XkOi39XFH1/QxaBbJzGE540uR
	 hwsJx289rCqh7nRomwoAXFNMIRZglGFTSBQHqU/+oFjnvDV7mnRIJUKKzFlkR9Whpk
	 JNMeU/PVt2dLQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-705cb6ceebaso1752392eaf.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:28:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzplQd2JNgAP9gc/DeQw/yZ0bt5wazrXbVAaH3GUVAQ+CJfwxZE0Jw8AThua7RYmalokh9Au/0=@vger.kernel.org
X-Gm-Message-State: AFq9FYICKem/Op3nGUE5P7GBzSiVjauSCuegzIEkeMdpXk2OIAuQYuKT
	+WI+xOj/E2CAeG/Y8e7HBuOASCOrvduE0n4GWNoUyh3AZV5nrp03z7ii6F5naSNxVpBRyARvybM
	ko+EQIXaunh7/0io+XIZHDqT4M4hRpjc=
X-Received: by 2002:a05:6820:5709:10b0:70a:df8e:8f64 with SMTP id
 006d021491bc7-714f23f7d98mr3415125eaf.22.1793604524395; Sun, 01 Nov 2026
 23:28:44 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <82c31e4d5043f3dbd11b44177cfba779d335aae3.1793599929.git.x-professor@outlook.com>
 <aug0tMr2QXRxTWuE@google.com>
In-Reply-To: <aug0tMr2QXRxTWuE@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 2 Nov 2026 08:28:32 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqMbiJS07YwNCNKsY6UMLsU+XDoemJMnHvrZz_+ayiOTw@mail.gmail.com>
X-Gm-Features: AclHuK-qkDj2lomKdPUBIYW2cw33-lPnwEAvc_Rj2h8jY0csV8s3qylZZM4N8nA
Message-ID: <CAL4WiiqMbiJS07YwNCNKsY6UMLsU+XDoemJMnHvrZz_+ayiOTw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: ipv6: keep request pktopts alive until request destruction
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Yingjie Wang <x-professor@outlook.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 2 nov. 2026 =C3=A0 08:03, Kuniyuki Iwashima <kuniyu@google.com> a =
=C3=A9crit :
>
> On Mon, 02 Nov 2026 06:12:18 +0000, Yingjie Wang wrote:
> > When IPv6 flow label reflection is enabled, tcp_v6_send_synack() reads
> > ireq->pktopts to copy the flow label from the initial SYN.
> >
> > Request sockets can be processed without the listener lock. A
> > retransmitted SYN can therefore run tcp_v6_send_synack() while a
> > concurrent final ACK creates the child in tcp_v6_syn_recv_sock(). The
> > latter clones ireq->pktopts for the child and immediately consumes the
> > request's reference. This can free the skb while the retransmit path is
> > still reading its IPv6 header, causing a use-after-free.
> >
> > Request migration has the same ownership problem. inet_reqsk_clone()
> > copies pktopts without taking an skb reference, and reqsk_migrate_reset=
()
> > then clears the old request's pointer. A CPU holding the old request ca=
n
> > still be sending a SYNACK when the cloned request releases the only skb
> > reference.
> >
> > Do not consume pktopts while creating the child. Give each cloned reque=
st
> > its own skb reference and let every request release its reference from
> > tcp_v6_reqsk_destructor().
> >
> > I found this while testing IPv6 TCP request-socket lifetime handling. T=
he
> > reproducer required no source changes, artificial delay, or fault
> > injection beyond enabling KASAN. It triggered the use-after-free before
> > this change. With this change, a 2000-round run completed without a KAS=
AN
> > report. A separate 10-round test recorded four successful request
> > migrations and no KASAN report. Networking selftests were not run becau=
se
> > none directly exercises this race.
> >
> > Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets"=
)
> > Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash ta=
ble")
> > Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retrans=
mitting SYN+ACKs.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yingjie Wang <x-professor@outlook.com>
> > ---
> >  net/ipv4/inet_connection_sock.c | 6 +++++-
> >  net/ipv6/tcp_ipv6.c             | 7 ++++---
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection=
_sock.c
> > index 93b306d91b6d..66f8ce25aa38 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -936,6 +936,11 @@ static struct request_sock *inet_reqsk_clone(struc=
t request_sock *req,
> >                     req->rsk_ops->obj_size - offsetof(struct sock, sk_d=
ontcopy_end),
> >                     /* alloc is larger than struct, see above */);
> >
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +     if (inet_rsk(nreq)->pktopts)
> > +             skb_get(inet_rsk(nreq)->pktopts);
> > +#endif
> > +
> >       sk_node_init(&nreq_sk->sk_node);
> >       nreq_sk->sk_tx_queue_mapping =3D req_sk->sk_tx_queue_mapping;
> >  #ifdef CONFIG_SOCK_RX_QUEUE_MAPPING
> > @@ -982,7 +987,6 @@ static void reqsk_migrate_reset(struct request_sock=
 *req)
> >       req->saved_syn =3D NULL;
> >  #if IS_ENABLED(CONFIG_IPV6)
> >       inet_rsk(req)->ipv6_opt =3D NULL;
> > -     inet_rsk(req)->pktopts =3D NULL;
> >  #else
> >       inet_rsk(req)->ireq_opt =3D NULL;
> >  #endif
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index e006a30360ea..0b51cb4ad960 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -1522,11 +1522,12 @@ static struct sock *tcp_v6_syn_recv_sock(const =
struct sock *sk, struct sk_buff *
> >       if (*own_req) {
> >               tcp_move_syn(newtp, req);
> >
> > -             /* Clone pktoptions received with SYN, if we own the req =
*/
> > +             /* Clone pktoptions received with SYN. Keep the request's
> > +              * reference until the request is destroyed, as a concurr=
ent
> > +              * SYN retransmit may still read it.
> > +              */
> >               if (ireq->pktopts) {
> >                       newnp->pktoptions =3D skb_clone_and_charge_r(ireq=
->pktopts, newsk);
> > -                     consume_skb(ireq->pktopts);
> > -                     ireq->pktopts =3D NULL;
>
> This is reported from another person in security@ mailing list
> yesterday and Eric has a better fix.
>
> pw-bot: rejected

Indeed, I will add another 'Reported-by: Yingjie Wang
<x-professor@outlook.com>' tag.

Thanks.
