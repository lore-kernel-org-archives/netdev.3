Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B750C29E
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572117; cv=pass; b=SnkmW8PPx7qi3yc3eJWqcbiHrKrfmAx1UegTpAuI2kFnTancZXh0as3+oNEbmdN/Tx14dp6zkjD6l0wF4wjK7/DQTPESmnf84fJUPIDV0QnWdWpK1EsvbklGBHiaKVF3rb5UpunWvr/k1bsqFlc2r3Dgz3KP6fOv0PLq5BAopYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572117; c=relaxed/simple;
	bh=ZLzBSbLHdIx7oKJft5euLp5tK8dytE+WWJeEygpcoPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxZGOxZRqGEJpYaYnhEftAwEnHf90hSy7anAdKK2flMu9n/m0+3qgkDRuohzhVS6rcifpg/b3WexPl1ttqa+5IVYkVEeCfIscchrOhuwNvFyq3w4qL0LPEbSajR7PWEKlihuWFiBx8Srg6OLbNNyufN5elOzPp9mOjJh9c/H1wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/oljoSn; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/oljoSn"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b2e1d7so866378b3a.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789572109; cv=none;
        d=google.com; s=arc-20260327;
        b=CVB0CKIPOcbaCWgwMgMPfjbcetqR8A6GPbiMQbzU6nUBOZgffyz9ptdVqklMXBlvBQ
         Yv9lIjfu0Red4CQ8C1fJRuReZSjibt8lBYLWo6bPHLKUea/dEMlEYlIJW8Zg8WZcqZuz
         vKm3g3cZIK7VLKvHIhc13F/W6o3EX7Q6cXfM0beBc3E7AHUax0kQtNmR4SXeG8olsHn8
         ujzUn4IiQuPON56UwWwyaTrOKYv84BGO/B5wFg/DMju2k7IBFpU8EXXtJtHbdo5AHA2x
         5lwp8ruUbLZGC6oP0SWf0LcMuWpzVv0nKcrPgZb9E4gqycwlMh6Ii2Grymbw5M7rEZjB
         EXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p1eY0XzQHV53ynXnFivLaDlowT7CeoLCfbXUtFiZQ8o=;
        fh=QFMgEb3XV5rS/ZRBmyHUP58oM4AaOHTWaWQeeAou20k=;
        b=jLIdM0QDcN4eBRnlV++kZcczafJ9FF21CsfZ2S+/fugSAbpbN21HTWyTgG7/k74zRG
         37GfTFUs8ZAxfMw2MBdnlVBwrTGqyU+rPLhmd3tUGFbDRuh4A9GogiXbnUN9ztYRCW5w
         VZoni5vGQ7UtFXkMRQBoanW6+tYN72hpvJPjN43YoKsenIQv33RLJcWRUmU6Oz9Og1W4
         LbuX3DntB81ESb1ZolSFoc3sF9Zoj6iAh81iYhmL1/56kpz7S/rpWkZPLz0PeiPLHPHh
         kwocpwtfA3iUhhwGnlRnXtjNKma6TdO6PKT/Lze7D4cjJ0zdvDfYkYlhUnsrxsdGomtx
         qiAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789572109; x=1790176909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p1eY0XzQHV53ynXnFivLaDlowT7CeoLCfbXUtFiZQ8o=;
        b=q/oljoSng/SVRm/Bujcm3uQnDd7ITD961bNsR2YS5xwjwuEt8LkNL1N/CebjYR7wlh
         ILtTP2ncqsaViM2SJULaMmxpzepMBixcWIHz8sz6Lv/ZEAplYiO2Zm4W2gUWjZZfmIm0
         UVgza+SbSWWxIvA8JOgpqAVlWhmozdC9MeuSd9ZEx6KYG6XQfnBXrgZ+NI7mhJTp8KbS
         0T7kXDGYUGSKdxC4+2HH6MnTng/TWP60Hz3Sz9jGvHRPlcuKzhsUw8yUDbNi2Ks8Mdp+
         SgU+am5n+u9TK1hp2YrEjbwDp1Y5SSn18jJUr4+9wkAZhMfmDIF5tJTt8kbRQXQuWjO4
         Is6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789572109; x=1790176909;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p1eY0XzQHV53ynXnFivLaDlowT7CeoLCfbXUtFiZQ8o=;
        b=a2f+3PqmbEzmeLvspCoQunEWYm86+gHGkplptOgRzLQlkhi9stSb7R/YB529oRYuv1
         Jz7DF4WpwHsxO/r7FRUP8qiPt6Yuz9vTmjxawuFzNRDHsldt8BbVn0vUuEa7V7gxaaRb
         5/+N5d9tnnghasZWisf6+3ZA60rqPqGUXiFxUnszCkPC24ZG4G9NpANaqOhvTT04t+G3
         reDYbtm4Kk9LG4YJAFcovOA9W/M0pWdk1n4tXnD/f+qZ/Mqgp/WzGL67UWCasRFx1M6o
         JtybCusEWg6Pd2FztrQN74Flz4ndjHrGaKSLClaVf6ng8ehP5NO/DbEQhTuoxLMWwT9z
         kqKA==
X-Gm-Message-State: AFuF++mqC3QFRgT+fMsonRYLd22MsxwWHxffgzjhAy0JbntFlYowSsod
	653DCfMEbwoDFBaI5bUwYOKOHkMz0aw0Ry6MwD1wbGyt12w7XFCheUo8hzYFTJOsRPP6PPLJfoF
	tbGcR5hlH253wnXFy5/XnPRT1SBaTqgA=
X-Gm-Gg: AYBFou2oyM+LPylHm/sxnzlBIMCqfodcsDqHo6eVBhtFDLE4piLi1BNCETxoBss+ORb
	FY+kfFnDtTYa9mhmw8syttw8VHN7708QG3X4ostMkfYEKN9V0ijKDD9/2wjnPBeriATeEYBRjKl
	osI4MbwxFW0+3aI6VuRdFp2yd+AP2V2kSKtkXG9VnvOjuJWyyTSFPVCXg6KeZ/8aO3JkuwCITCS
	NIMM1Ueblq6mVNI+vBGglfy4H75lio6Jd9rBYXSspwOq61g9L5Obk3Ol6CaHYXtTKKg+i1+6CQU
	v5tRjrI0nMK/UwJfzfSsmQ7RU8XTCaRy9rKic0F/FbaZOlLPQCmgnQCG2oVNcLaAKVJ3DFTri/R
	vC5+2VXET9tkGkaDAvMDF6RwaYuBMBVT6Vvz2bi75R6oa2UF6x8aNO4yo
X-Received: by 2002:a05:6a00:4fc3:b0:86f:2d2f:48ef with SMTP id
 d2e1a72fcca58-87236ddb105mr6042886b3a.1.1789572108837; Wed, 16 Sep 2026
 08:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6d7bfc9ba424a7170befff9ca9eaed1663017ca8.1789393775.git.lucien.xin@gmail.com>
 <178950183921.22033.10083649522216474862@kernel.org>
In-Reply-To: <178950183921.22033.10083649522216474862@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 16 Sep 2026 11:21:36 -0400
X-Gm-Features: AcwNN1UD3xdvGptxprJEVONmj0qpc-MJ-3juUKU_3i9i2Xyg8-vDsV7GrGmZ3i4
Message-ID: <CADvbK_ejqDoS3bA33Ryi-qeNV7eRbTE9QPc-90XDoRujmuaoxg@mail.gmail.com>
Subject: Re: [PATCH net-next v15 06/15] quic: add stream management
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	metze@samba.org, mbuhl@openbsd.org, tfanelli@redhat.com, hepengtao@xiaomi.com, 
	dreibh@simula.no, linux-cifs@vger.kernel.org, pc@manguebit.org, 
	linkinjeon@kernel.org, tom@talpey.com, kernel-tls-handshake@lists.linux.dev, 
	chuck.lever@oracle.com, jlayton@kernel.org, steved@redhat.com, hare@suse.de, 
	aahringo@redhat.com, dhowells@redhat.com, matttbe@kernel.org, 
	mail@johnericson.me, xiyou.wangcong@gmail.com, alibuda@linux.alibaba.com, 
	jbaron@akamai.com, illiliti@protonmail.com, sd@queasysnail.net, 
	marcelo.leitner@gmail.com, daniel@haxx.se, andrew.gospodarek@broadcom.com, 
	mef@scarletmail.rutgers.edu, paul@jakma.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 3:50=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 2
>
> - [Medium] quic_stream_set_param() (net/quic/stream.c:387-416) treats the
>   UAPI field `struct quic_transport_param::remote` (a __u8, so 0..255)=E2=
=80=A6
> - [Low] quic_stream_create() (net/quic/stream.c:83-160) allocates each
>   stream with kzalloc_obj() and explicitly initializes only id,=E2=80=A6
> - [Low] Concern: quic_stream_free() is called from quic_destroy_sock()
>   (net/quic/socket.c:60), i.e. from proto->destroy, which=E2=80=A6
>
> --
>
> quic: add stream management
>
> Adds struct quic_stream_table and struct quic_stream along with the
> per-socket stream hash table, the acquire/release helpers
> quic_stream_get()/quic_stream_put(), the stream ID limit checks, and the
> transport parameter get/set helpers.  The table is allocated in
> quic_init_sock() and released in quic_destroy_sock().
>
> A few questions below about stream state initialization, the handling of
> the transport parameter "remote" field, and the teardown ordering.
>
> > diff --git a/net/quic/socket.c b/net/quic/socket.c
> > index 0e0a13235fa42..731c1e00dba2b 100644
> > --- a/net/quic/socket.c
> > +++ b/net/quic/socket.c
> > @@ -49,11 +49,16 @@ static int quic_init_sock(struct sock *sk)
> >       sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> >       INIT_LIST_HEAD(quic_reqs(sk));
> >
> > +     if (quic_stream_init(quic_streams(sk)))
> > +             return -ENOMEM;
> > +
> >       return 0;
> >  }
> >
> >  static void quic_destroy_sock(struct sock *sk)
> >  {
> > +     quic_stream_free(quic_streams(sk));
>
> [Severity: Low]
> Is the stream table teardown ordering here what is intended for later
> patches?  quic_destroy_sock() is proto->destroy, and sk_common_release()
> runs it before ->unhash(), with no socket lock held:
>
> net/core/sock.c:sk_common_release() {
>         ...
>         if (sk->sk_prot->destroy)
>                 sk->sk_prot->destroy(sk);
>         ...
>         sk->sk_prot->unhash(sk);
>         ...
> }
>
> So quic_stream_free() frees streams->head and then stores NULL into it at
> a point where the socket is no longer reachable from user space but is
> still, in principle, reachable from the network.  A concurrent
> quic_stream_find() would then walk freed hlist heads, or dereference NULL
> in quic_stream_head().
>
> Nothing can hit this in the current tree, since quic_hash() is
> "return 0;" and quic_unhash() is empty, so a QUIC socket is never inserte=
d
> into a hash table and cannot be looked up from the receive path.  Would i=
t
> still be worth doing the free after unhash, or under the socket lock the
> way udp_destroy_sock() does with lock_sock_fast(), so this stays correct
> once the lookup paths land?
>
> [ ... ]
>
> > diff --git a/net/quic/stream.c b/net/quic/stream.c
> > new file mode 100644
> > index 0000000000000..6b34b117103a8
> > --- /dev/null
> > +++ b/net/quic/stream.c
> > @@ -0,0 +1,416 @@
>
> [ ... ]
>
> > +     /* rfc9000#section-2.1: A stream ID that is used out of order res=
ults in
> > +      * all streams of that type with lower-numbered stream IDs also b=
eing
> > +      * opened.
> > +      */
> > +     while (stream_id <=3D max_stream_id) {
> > +             stream =3D kzalloc_obj(*stream, gfp);
> > +             if (!stream)
> > +                     goto free;
> > +
> > +             stream->id =3D stream_id;
> > +             if (quic_stream_id_uni(stream_id)) {
> > +                     if (send) {
> > +                             stream->send.max_bytes =3D
> > +                                     limits->max_stream_data_uni;
> > +                     } else {
> > +                             stream->recv.max_bytes =3D
> > +                                     limits->max_stream_data_uni;
> > +                             stream->recv.window =3D stream->recv.max_=
bytes;
> > +                     }
>
> [Severity: Low]
> Should stream->recv.state be initialized here?
>
> The stream comes from kzalloc_obj(), and only id, send.max_bytes,
> recv.max_bytes and recv.window are assigned, so recv.state stays 0.  The
> send and receive states share one enum in include/uapi/linux/quic.h:
>
>         enum {
>                 QUIC_STREAM_SEND_STATE_READY,
>                 ...
>                 QUIC_STREAM_SEND_STATE_RESET_RECVD,
>
>                 QUIC_STREAM_RECV_STATE_RECV,
>                 ...
>         };
>
> which makes 0 equal to QUIC_STREAM_SEND_STATE_READY, while
> QUIC_STREAM_RECV_STATE_RECV is 6.
>
> net/quic/stream.h documents the field as a receive state:
>
>                 u8 state;  /* Receive stream state, per rfc9000#section-3=
.2 */
>
> and quic_stream_put() compares it against the receive constants:
>
>                 if (stream->recv.state < QUIC_STREAM_RECV_STATE_RECVD)
>                         return;
>
> This comparison happens to give the same answer for 0 as for 6, so nothin=
g
> misbehaves today, and the same field is what gets reported to user space =
as
> struct quic_stream_update::state.  Would setting recv.state to
> QUIC_STREAM_RECV_STATE_RECV at creation time (or documenting that 0 means
> "Recv") avoid an equality test going wrong later?
>
> [ ... ]
>
> > +/* Configure stream hashtable from transport parameters. */
> > +void quic_stream_set_param(struct quic_stream_table *streams,
> > +                        struct quic_transport_param *p, bool is_serv)
> > +{
> > +     struct quic_stream_limits *limits =3D p->remote ? &streams->send =
:
> > +                                                     &streams->recv;
> > +     u8 bidi_type, uni_type;
> > +
> [ ... ]
> > +     if (p->remote ^ is_serv) {
> > +             bidi_type =3D QUIC_STREAM_TYPE_CLIENT_BIDI;
> > +             uni_type =3D QUIC_STREAM_TYPE_CLIENT_UNI;
> > +     } else {
> > +             bidi_type =3D QUIC_STREAM_TYPE_SERVER_BIDI;
> > +             uni_type =3D QUIC_STREAM_TYPE_SERVER_UNI;
> > +     }
>
> [Severity: Medium]
> Can the two different interpretations of p->remote in this function
> disagree?  It is a __u8 in the uAPI (struct quic_transport_param), so it
> can hold 0..255.  The limits selection uses a truth test, while the type
> selection uses a bitwise XOR, so for p->remote =3D=3D 2 with is_serv =3D=
=3D true:
>
>         limits    =3D &streams->send              /* truth test: non-zero=
 */
>         2 ^ 1 =3D 3 -> non-zero                   /* takes the CLIENT bra=
nch */
>         bidi_type =3D QUIC_STREAM_TYPE_CLIENT_BIDI
>
> which leaves streams->send.next_bidi_stream_id =3D 0 on a server instead =
of
> 1.  Would !!p->remote ^ is_serv (or rejecting p->remote > 1) keep the two
> tests consistent?
>
> The follow-on in that state is that quic_stream_get() for the server's
> first bidi stream (ID 1) passes every gate: quic_stream_id_valid(1, true,
> true) is true, find() returns NULL, quic_stream_id_local(1, true) is true=
,
> quic_stream_id_closed() is false because 1 < 0 is false, and
> quic_stream_id_exceeds() is false.  quic_stream_create() then starts at
> stream_id 0:
>
> > +     while (stream_id <=3D max_stream_id) {
>
> allocates a single stream with id 0, advances stream_id to 4 and returns
> that stream.  quic_stream_get() reports success and records
> streams->send.active_stream_id =3D 1 for a stream that does not exist, wh=
ile
> ID 1 is now permanently -ENOSTR because next_bidi_stream_id is 4.
>
> A later quic_stream_put() on the returned stream 0 evaluates
> quic_stream_id_local(0, true) as false and decrements
> streams->recv.streams_bidi, which was never incremented, so that u16
> underflows and feeds quic_stream_max_streams_update().
>
> quic_stream_set_param() has no caller yet in the tree, so this is
> forward-looking rather than something reachable today.  Along the same
> lines, should quic_stream_create() return an error rather than a stream
> whose id differs from the requested max_stream_id, since no caller can
> detect that today?
>
False:

The caller of quic_stream_set_param() added in the next patchset validates
p->remote and ensures it can only be 0 or 1.

Thanks.
