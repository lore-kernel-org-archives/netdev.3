Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587580;
	b=KZjxr/WvJmMDPWw5BbS7mhB9CQs/husbjlR3H+FruqhgR+dQCD69BLqv2JkbBm8wEjjA
	 stMuqMz6Enqp+yiSV2klPeRd7SQsGTJzY4Fm+9jc4rLF7vzkIPn97FmmOpBfr6Ua/ev+L
	 pEzOt0uqySMuQNFuhQQwvNAihd/xfr9lu3IPx6cd4fP1bN6UCi+dAzO0AXOd9hG8u6rXl
	 yV1wyAI2KecKvrL6JQ2AeypN4FyverER+M+fyoWTJK8pKzSpCrRobOAgiNymndKUSWtEx
	 y1rMdsQHkbTuQYefb8ZQe1szviWKFB9LKT57vCfIy1guNnBXNigoTOvYrGowXgBxB2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587580;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GIJg6VKroIEKiKwNbncnOaNqN5TLBnzrp4Dp2ytEtUM=;
	b=qPOtFqXVdGWTYShXP2w3uoV1INDKICSXSMip36wYlVEhWX7psRyPO5aYWaa3NpHvbryY
	 AK43QWJW3GLTs0j09ryP3Iti6t8+eCthKYxSRZfVYof5ynev70QtdR1E7jpu5OrUw2aHU
	 tneftDhj2yYasw1DU5H3HhesPZW/XdiIy8D70TAOS4VhFwSyLoJl1CVg8agkLjl7Rs0ek
	 tHHCr42jvzWVkKZqV98n4zQdwd1Q3ZlDK/UVzvjC4wFDlhP0NPbq8mCV4wP26BXXfWmtc
	 dMd2SovubJCwbeXfRRIZdiB8XXrIK4f9QeEzv9sjFKXRbhAkLqsqIq4qX/ivB49Ga6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Q8QRuj/7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D9E606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q8QRuj/7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7401F000C8
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 12:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792587579;
	bh=GIJg6VKroIEKiKwNbncnOaNqN5TLBnzrp4Dp2ytEtUM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Q8QRuj/7vHke3NtM8c+QHspOJAGgjABtyagUQ7X80Z9PGEepoS/B8Ci6yJTHUPh6P
	 qp3T1WKQVHG3RdsAxNWqb1lnMNnFHDD4SRK+I9x3iO5rzfY3Lz8LpemFn8POSNsQgW
	 Dgq4WHfhRhqVXAKOnQWbooSjJm1YxIEfLgig2PL+1S4hvLDXqezK1lGSQAfjSyBMc1
	 Ig4GapvM7jgyWRHiBnaunTEnpU6QumMT3BSm3Kgm7msqwojNkH8a9hUPfATTo/VbyF
	 IyWBXlijbL72JXAmTMkaU28S8jiR/D3eTVl41B0TeowiRFjNjMqqFJrwQd6ye+rVzC
	 ovmd69nILQ14A==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a9841363b5so5664241fa.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 05:59:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx/Zz6j2yodZ237PlkSpMUXQ29cenDJClxDgfblavaBrlsMObbN467S+jykMaCTcM8lVyRvpXs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJDjblwbiMYl26YVLypJsbbihM+zKaCOjthJFlNdB7x1TqFl+kl
	7iwchAoOKHZm7LLTGU6h1TYbOEukuJuDiCN6nvWmzghGUZ43VE1833VffR5dG+k61CwO18r1rBj
	uNcCf+fu5eoe5LR7jDi+JH+y/kQ8rmMI=
X-Received: by 2002:a2e:be0b:0:b0:3a6:4a45:df84 with SMTP id
 38308e7fff4ca-3ac440a1b48mr6226641fa.1.1792587577987; Wed, 21 Oct 2026
 05:59:37 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019174522.55644-1-kaifengw@google.com> <ef23d9b7-33c1-40dd-854e-1911ad3534a4@redhat.com>
In-Reply-To: <ef23d9b7-33c1-40dd-854e-1911ad3534a4@redhat.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 21 Oct 2026 14:59:25 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqDG2+vhkpCckc1mqMCcH1XAFJ_g0=OdCgv049gG7HgzA@mail.gmail.com>
X-Gm-Features: AclHuK_Z2qfEA1qqbI9J4CzMT9qDwZOPde0aorWAVjSYKIu6-DuKrwXEsyuD1Sc
Message-ID: <CAL4WiiqDG2+vhkpCckc1mqMCcH1XAFJ_g0=OdCgv049gG7HgzA@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: reject devmem tx with fastopen and repair
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kaifeng Wang <kaifengw@google.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@google.com>, ncardwell@google.com, davem@davemloft.net, 
	kuba@kernel.org, horms@kernel.org, asml.silence@gmail.com, 
	almasrymina@google.com, willemb@google.com, kaiyuanz@google.com, 
	sdf@fomichev.me, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 21 oct. 2026 =C3=A0 12:53, Paolo Abeni <pabeni@redhat.com> a =C3=A9=
crit :
>
> Adding Eric (for real) and Kuniyuki

Thanks Paolo.

>
> On 10/19/26 19:45, Kaifeng Wang wrote:
> > tcp_sendmsg_locked() enforces that devmem TX can only proceed if the
> > zero-copy path is active and a valid dmabuf binding exists. However,
> > subsequent branches in tcp_sendmsg_locked() can still intercept the
> > message before it reaches the devmem zero-copy loop:
> >
> > 1. TCP Fast Open (MSG_FASTOPEN or DEFER_CONNECT):
> >     If TCP_FASTOPEN_CONNECT is set, the socket may have a valid dst wit=
h
> >     NETIF_F_SG (so zc =3D=3D MSG_ZEROCOPY and binding is present), but
> >     tcp_sendmsg_fastopen() -> tcp_send_syn_data() will use
> >     copy_page_from_iter() to byte-copy from the iterator. Since iov_bas=
e
> >     represents dma-buf offsets rather than user virtual addresses, this
> >     misinterprets offsets as user pointers and copies the caller's memo=
ry
> >     at those addresses into the SYN packet.
> >
> > 2. TCP repair mode:
> >     If tp->repair is enabled with TCP_RECV_QUEUE, tcp_send_rcvq() simil=
arly
> >     calls skb_copy_datagram_from_iter(), byte-copying from the iterator=
.
> >
> > Neither path supports or makes sense for devmem transmission. Reject
> > devmem sends inside the Fast Open and TCP repair branches when a devmem
> > binding is present. Checking inside the tp->repair branch also covers
> > the case where repair mode is enabled while sk_stream_wait_connect()
> > drops the socket lock.


Note that the check in the tp->repair branch also rejects
TCP_SEND_QUEUE, not only TCP_RECV_QUEUE. This is fine (a devmem
binding can not be restored by CRIU anyway), but the changelog
could say so.

Also, an application using TCP_FASTOPEN_CONNECT will now get -EINVAL
on its first devmem sendmsg(), and the SYN is not sent. Again fine
for a net fix, just worth being aware of.

> >
> > Additionally, drop the !sockc_err gate from the devmem validation check
> > and return sockc_err if set. Otherwise, if a valid SCM_DEVMEM_DMABUF is
> > followed by a failing cmsg, sockc.dmabuf_id remains set while binding i=
s
> > not acquired, allowing the Fast Open and TCP_RECV_QUEUE repair paths to
> > proceed and return before sockc_err is checked.
> >
> > This pre-existing issue was identified by Sashiko AI review on commit
> > 125755776bc6 ("tcp: reject non zerocopy devmem tx") and has not been
> > hit in production.
> >
> > Fixes: 125755776bc6 ("tcp: reject non zerocopy devmem tx")
> > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Kaifeng Wang <kaifengw@google.com>
> > ---
> > v1 -> v2:
> > - Move the devmem rejection checks into the Fast Open and TCP repair
> >    branches directly, also covering the case where tp->repair is enable=
d
> >    while sk_stream_wait_connect() drops the socket lock.
> > - Drop the !sockc_err gate from the devmem validation check and return
> >    sockc_err if set, preventing a valid SCM_DEVMEM_DMABUF followed by a
> >    failing cmsg from bypassing the check.
> >
> >   net/ipv4/tcp.c | 12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 87ef6d5cbfeb..2792923f0748 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1169,14 +1169,18 @@ int tcp_sendmsg_locked(struct sock *sk, struct =
msghdr *msg, size_t size)
> >                       zc =3D MSG_SPLICE_PAGES;
> >       }
> >
> > -     if (!sockc_err && sockc.dmabuf_id && (zc !=3D MSG_ZEROCOPY || !bi=
nding)) {
> > -             err =3D -EINVAL;
> > +     if (sockc.dmabuf_id && (zc !=3D MSG_ZEROCOPY || !binding)) {
> > +             err =3D sockc_err ?: -EINVAL;
> >               goto out_err;
> >       }
> >
> >       if (unlikely(flags & MSG_FASTOPEN ||
> >                    inet_test_bit(DEFER_CONNECT, sk)) &&
> >           !tp->repair) {
> > +             if (binding) {
> > +                     err =3D -EINVAL;
> > +                     goto out_err;
> > +             }
> >               err =3D tcp_sendmsg_fastopen(sk, msg, &copied_syn, size, =
uarg);
> >               if (err =3D=3D -EINPROGRESS && copied_syn > 0)
> >                       goto out;
> > @@ -1200,6 +1204,10 @@ int tcp_sendmsg_locked(struct sock *sk, struct m=
sghdr *msg, size_t size)
> >       }
> >
> >       if (unlikely(tp->repair)) {
> > +             if (binding) {
> > +                     err =3D -EINVAL;
> > +                     goto out_err;
> > +             }
> >               if (tp->repair_queue =3D=3D TCP_RECV_QUEUE) {
> >                       copied =3D tcp_send_rcvq(sk, msg, size);
> >                       goto out_nopush;
>
> The ever increasing number of conditionals is a bit concerning, but
> I don't see how to avoid the new ones.

Yes. sendmsg() has been hijacked by so many slow path components.

At least this patch only adds code in unlikely() branches.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Thanks.
