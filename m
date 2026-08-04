Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852CE45DF5A
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879529; cv=pass; b=fDJDk0ZGUnkRUAQEWdM2lmmCVaUA4VPpQeUbCgovASbVO1KDyRxuxEkZDdlss9MtKRlGNYJ/95e4M/zeULWMNSwYz44qHzkB0ATijc38lgqHFLCbwS9+LCXs2wOdHRBUd5R4xPxqKgagMHKS9rcYvtrqWI2QAFbuyK7m/o70t5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879529; c=relaxed/simple;
	bh=HPw67P1JaDyf+3Qi++4bTv49ZviLpxGpA5izJb9AyCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6gC9xd/0U/cbMcoxqQSeEUtKavpvoTB/1dMjSt0yaHm3r9TGuwTB4wyd0brGLxAYVWvTougpbF9w1EPzETwukKc20zXjBBaGVPzevGc/OCD2qfn3j2cOy/SDOdIkIJ5J5Rw/2owF5zUGHyuRmjD2yQphNaYBdkkWjSi/ns74DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW8O/Z1V; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW8O/Z1V"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84874b52eabso419477b3a.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 14:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785879527; cv=none;
        d=google.com; s=arc-20260327;
        b=NZmswXQlIQZTjCgGREvqco3P/jEVRdJtCqY5RXthIue5R2fWZsIqwrTDhBx9I25SCs
         rEd2NsjzETiV3iZ29tBSc4kQ8GGMUkibaiYuR8hArCFBUs4L7RkXhCZaQLRnbQ37yD5j
         o0QIuW6s75I62boyhBB6A9YF+AkqN2wDrf4dE6h3N5Q7xx27ytuCZg/9s1WVbuX1iHjM
         prBrcf5f/rxowF6AouifvWgDASmB6iNjqU0kZ/yeAIrSpwEnEsI6vjXMWg0zXLXygJ5n
         +owxArI2bc15/DiPg9LDJWVwcTRJ4Poy/zktPsBW7ThQ7quJr8GPY1+ZrtHnnQoGECRB
         45Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B6KIbQNVhd86qsyAZv144/o6xQEuZj0wYuM2h/vplZ8=;
        fh=y4TNq3h5gCJ67W5Y5V83pyfDmRPJUqXonjkfQuskxfY=;
        b=k4bADIU+wVfp033PbYbKMH//5afaP3BeP8/TWWtJDT8mvdmH0c6gOI5PHKnfCQYAcD
         jy7y2e8utrqBV8bRvu0jwegXpZdMAj3dNG1upFdbm4MC79SiD/uoIR28WvWOrUKb0lwT
         lSIO6+XcG/vyflBEmJ8hxA7/YJSak2EBIFWbxZ3citSpBV1BpXPT/DX917ThRvl8xCyh
         9QYrcDIDDsNu7fMV9wEBC858fcdAUNb31SJymF8uKcQLedHZD8YarBceRppYQzq0QJOv
         yzIDLvoucYPT30MAcbZMkexeC7i/QRng2n9KcJBxlcozu2v8PJknlWNrO/F4ytqdnzKc
         Msmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785879527; x=1786484327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B6KIbQNVhd86qsyAZv144/o6xQEuZj0wYuM2h/vplZ8=;
        b=aW8O/Z1VCyJTc71MHaqI03EH4TJJPsZiwy8yLbJW6MDdV8EBl7iWUCxzISCQJrTkhP
         ZhUsRhmQQgQvDYGV9fwUYcqQEshx2C7AE9B4CA9yWhb2SXJBFH22MxMdo1a+7aVHsTdC
         ava6AEnTM8JzEDrd8Sxwk2pAxdgWTlartVZwWQyR1jabaxoAjAiDVLbSmhCt5eCK4Dmq
         kBmlsMSlGT3wp9+Qxa8PixFrTxA7uPXbJ7pAolL14IOybFlwwGatA4hjJDjIb8eRN8rq
         NmwTlIqJLT2lS4TZRNzZ+V9hEnIqLb/7rNTik2KyG7LmRrkTAYgJsn/MIJRfItTH2tkt
         7M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879527; x=1786484327;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B6KIbQNVhd86qsyAZv144/o6xQEuZj0wYuM2h/vplZ8=;
        b=P0zRQa/OSMI64PwhgC/vQqysURhOwyrNBf2e14IOwVeox208ze3XfBSo541aJtneuO
         ckS7kc0V1+EBeJguIC9HRSKRCe19CsTGOwKhSF74AULsSU19DD2gsdm9jTpQnHuUUgEe
         HyBJA0Sl9Hh/KK1iunyqYqOKoJbpWqvGevh0BKuBq4ETuYoisvw7ittHSgHcbxWqdEJw
         dZ6PBbXZSojJJ3+dsX1bUOoigSkV+fHTzXaxWSuSFZZLwwNCwHaxzn85BKE4fwSyIlxi
         SmV45maL1JM5G86bcBwBWzVbju9i/eFUUa+kWBgCW9veYHfwwIv/biROi08OlISJiQgt
         cOEQ==
X-Forwarded-Encrypted: i=1; AHgh+RpkelLv4s481YK3WPSWg/ch79Pya7b9yEbUZEkB63vDNVZgBmh0PMBGAMLpz08PDA9iMhdsyrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzhzDcjDEYmQMmBNuA2lnbKL51e70rkwJNFzULXMzP2wbPqb9k
	WXY7xQ45orKGGJgv+25nB4l+Fww7eKBL+COXytrvIq6NZegaecq+5G0dg69LzYdfUx7Sd//mNZH
	eMImgCKM/T+v4fxBJ0ZJBMjrCa6Ygds8=
X-Gm-Gg: AR+sD13OExSXol1c+gqxkAA1E2dv0A4OFVPGH3XRv5+o9PaemP6lTYFqP6F80248lOE
	ZS0N2tTShdxs2OIsY4Y2ap9CQSD7wrH/58Y+bOlhjGD1hhVxGIc0cNPOG5sxHAXF5k/VHT/7H/v
	8Ez7LIaKAfsVApcwEdHU5ChY1gRV4n2DXNH9PpxketMT6sZutr5cniFx7iyZ+XgAO7Lbe2KKRMb
	B6Nmzr5hWQYz5CpczX4WXPY4YWHFxqI+ehs6KBOVDvBznMQNttwxaJ2nafThWqiUqk9gdjXpDTk
	pK5LI6D3/ek+2ZZct4IpyRRbpJ7Tn93rud7rXxqJUl0GIeEwSHSBv8ZLylAquPzwGxAFNMDWdbQ
	ue6bbwAq2zXfBX+E70xDinPKMdYeIksNwM2oG/j4nmfM=
X-Received: by 2002:a05:6a00:3016:b0:848:6895:b754 with SMTP id
 d2e1a72fcca58-84f2dff6cc9mr1867806b3a.28.1785879526616; Tue, 04 Aug 2026
 14:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730023309.21654-1-omeux327@gmail.com> <20260803233718.2336399-2-kuba@kernel.org>
In-Reply-To: <20260803233718.2336399-2-kuba@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 4 Aug 2026 17:38:35 -0400
X-Gm-Features: AUfX_mx0qsQi4XvAs8sThQUkRgCKrDkD_PKPxvhHU85HH2SPOTpO3L4PvjQUwMA
Message-ID: <CADvbK_f6qcqPj=YqFDfkgYzzw+wJp9k5fkH1jjgM6xn1rQggJw@mail.gmail.com>
Subject: Re: [PATCH v2] sctp: diag: fix uninitialized stack leak via INET_DIAG_LOCALS/PEERS
To: Jakub Kicinski <kuba@kernel.org>
Cc: omeux327@gmail.com, marcelo.leitner@gmail.com, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 7:37=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email says "AI seems to have spotted another related stack leak, and
> suggests an alternative fix."
> ---
> sctp: diag: fix uninitialized stack leak via INET_DIAG_LOCALS/PEERS
>
> The patch changes inet_diag_msg_sctpladdrs_fill() and
> inet_diag_msg_sctpaddrs_fill() to zero the whole sockaddr_storage slot
> first and then copy only the family-dependent prefix of the stored
> union sctp_addr, so the sockaddr_in6-only tail of an AF_INET address is
> no longer exported through the netlink attributes.
>
> A few questions about the changelog and the placement of the fix.
>
> [Severity: Low]
> [Finding: main-1-2]
> [Sources: opus-5]
> The changelog says:
>
> >     inet_diag_msg_sctpladdrs_fill() copies sizeof(union sctp_addr) (28 =
bytes,
> >     the size of sockaddr_in6) from each sctp_sockaddr_entry.a into the =
netlink
> >     INET_DIAG_LOCALS attribute and then only zeroes the bytes from offs=
et 28 to
> >     sizeof(sockaddr_storage).  The same pattern is used by
> >     inet_diag_msg_sctpaddrs_fill() for INET_DIAG_PEERS.
>
> Can the INET_DIAG_PEERS path actually leak anything?  transport->ipaddr
> is allocated zeroed and only ever written with sockaddr_len bytes:
>
> net/sctp/transport.c:sctp_transport_new() {
>         transport =3D kzalloc_obj(*transport, gfp);
>         ...
> }
>
> net/sctp/transport.c:sctp_transport_init() {
>         peer->af_specific =3D sctp_get_af_specific(addr->sa.sa_family);
>         memcpy(&peer->ipaddr, addr, peer->af_specific->sockaddr_len);
>         ...
> }
>
> So bytes 16..27 of from->ipaddr look guaranteed to be zero for AF_INET,
> which would make the inet_diag_msg_sctpaddrs_fill() change hardening
> rather than a fix.  Should the changelog say that instead?
>
> The changelog also says:
>
> >     region) are left uninitialized.  Those bytes are propagated verbati=
m through
> >     sctp_add_bind_addr() (which copies sizeof(union sctp_addr)=3D28 byt=
es) and then
>
> sctp_add_bind_addr() copies a caller-supplied length:
>
> net/sctp/bind_addr.c:sctp_add_bind_addr() {
>         memcpy(&addr->a, new, min_t(size_t, sizeof(*new), new_size));
>         ...
> }
>
> Callers such as sctp_do_bind() pass af->sockaddr_len and store nothing
> uninitialized; only the callers that pass sizeof(union sctp_addr) do.
> Could that be spelled out so the scope of the stable backport is clear?
>
> > diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> > index c2a0de2adf6fd..610c937deffd7 100644
> > --- a/net/sctp/diag.c
> > +++ b/net/sctp/diag.c
> > @@ -85,8 +85,12 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_b=
uff *skb,
> >       info =3D nla_data(attr);
> >       rcu_read_lock();
> >       list_for_each_entry_rcu(laddr, address_list, list) {
> > -             memcpy(info, &laddr->a, sizeof(laddr->a));
> > -             memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr=
->a));
> > +             size_t copy_len =3D laddr->a.sa.sa_family =3D=3D AF_INET =
?
> > +                               sizeof(struct sockaddr_in) :
> > +                               sizeof(struct sockaddr_in6);
>
> [Severity: Low]
> [Finding: main-1-1]
> [Sources: opus-5]
> This isn't a bug, but the AF_INET/AF_INET6 to length mapping already
> exists as struct sctp_af::sockaddr_len, and the exact "zero a
> sockaddr_storage, then copy only the valid part" idiom is already in the
> tree:
>
> net/sctp/ulpevent.c:sctp_ulpevent_notify_peer_addr_change() {
>         memset(&addr, 0, sizeof(struct sockaddr_storage));
>         memcpy(&addr, &transport->ipaddr,
>                transport->af_specific->sockaddr_len);
>         ...
> }
>
> Would sctp_get_af_specific(laddr->a.sa.sa_family)->sockaddr_len in
> inet_diag_msg_sctpladdrs_fill(), and from->af_specific->sockaddr_len in
> inet_diag_msg_sctpaddrs_fill(), work here?
>
> Also, the else branch hardcodes sizeof(struct sockaddr_in6) as a stand-in
> for "the whole union", so an unexpected sa_family copies the maximum
> length rather than the minimum, and the constant silently diverges if
> union sctp_addr ever grows a larger member.
>
> > +
> > +             memset(info, 0, addrlen);
> > +             memcpy(info, &laddr->a, copy_len);
> >               info +=3D addrlen;
> >
> >               if (!--addrcnt)
>
> [Severity: Low]
> [Finding: main-1-0]
> [Sources: opus-5]
> Does this leave the uninitialized tail sitting in the bind address list
> itself?  The residue is stored by the producers, and this hunk only stops
> one consumer from exporting it:
>
> net/sctp/socket.c:sctp_send_asconf_add_ip() {
>         memcpy(&saveaddr, addr, af->sockaddr_len);
>         retval =3D sctp_add_bind_addr(bp, &saveaddr,
>                                     sizeof(saveaddr),
>                                     SCTP_ADDR_NEW, GFP_ATOMIC);
>         ...
> }
>
> net/sctp/bind_addr.c:sctp_raw_to_bind_addrs() {
>         union sctp_addr addr;
>         ...
>         !af->from_addr_param(&addr, rawaddr, htons(port), 0)
>         ...
>         retval =3D sctp_add_bind_addr(bp, &addr, sizeof(addr),
>                                     SCTP_ADDR_SRC, gfp);
> }
>
> In both cases only 16 bytes of the 28-byte stack union are written for
> AF_INET, and sctp_add_bind_addr() then persists all 28 bytes into the
> kzalloc'ed entry, so offsets 16..27 of the stored address stay as stack
> residue after this patch.  The second path is driven by peer-supplied
> INIT/INIT-ACK address parameters.
>
> Would zeroing the union in sctp_v4_from_skb() / sctp_v4_from_sk() /
> sctp_v4_from_addr_param(), or clamping q() to
> af->sockaddr_len, close this for every present and future consumer?  That
> seems worth considering given the Cc: stable tag.
>

Instead of only copying the valid address length when dumping entries from
address_list, the comment suggests that the unused bytes should be
initialized when the address is added to the list.

For transport_addr_list, the path:

  sctp_assoc_add_peer() -> sctp_transport_new() -> sctp_transport_init()

already guarantees this:

  transport =3D kzalloc_obj(*transport, gfp);
  ...
  memcpy(&peer->ipaddr, addr, peer->af_specific->sockaddr_len);

However, for bp->address_list, sctp_add_bind_addr() relies on the new_size
parameter to copy the correct address length. There are currently three
callers passing sizeof(addr) instead of af->sockaddr_len:

- sctp_raw_to_bind_addrs()
- sctp_unpack_cookie()
- sctp_send_asconf_add_ip()

These should be changed to pass af->sockaddr_len to sctp_add_bind_addr(),
as shown below:

diff --git a/net/sctp/bind_addr.c b/net/sctp/bind_addr.c
index 31737f144c7f..1b9bfac17816 100644
--- a/net/sctp/bind_addr.c
+++ b/net/sctp/bind_addr.c
@@ -294,7 +294,7 @@ int sctp_raw_to_bind_addrs(struct sctp_bind_addr
*bp, __u8 *raw_addr_list,

                if (sctp_bind_addr_state(bp, &addr) !=3D -1)
                        goto next;
-               retval =3D sctp_add_bind_addr(bp, &addr, sizeof(addr),
+               retval =3D sctp_add_bind_addr(bp, &addr, af->sockaddr_len,
                                            SCTP_ADDR_SRC, gfp);
                if (retval)
                        /* Can't finish building the list, clean up. */
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index b472565fc7f2..8da6d97b6062 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1861,8 +1861,11 @@ struct sctp_association *sctp_unpack_cookie(

        /* Also, add the destination address. */
        if (list_empty(&retval->base.bind_addr.address_list)) {
+               struct sctp_af *af;
+
+               af =3D sctp_get_af_specific(chunk->dest.sa.sa_family);
                sctp_add_bind_addr(&retval->base.bind_addr, &chunk->dest,
-                                  sizeof(chunk->dest), SCTP_ADDR_SRC,
+                                  af->sockaddr_len, SCTP_ADDR_SRC,
                                   GFP_ATOMIC);
        }

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index e4ea57a642c1..1f934a9b2e5a 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -634,7 +634,7 @@ static int sctp_send_asconf_add_ip(struct sock
         *sk,
                        af =3D sctp_get_af_specific(addr->v4.sin_family);
                        memcpy(&saveaddr, addr, af->sockaddr_len);
                        retval =3D sctp_add_bind_addr(bp, &saveaddr,
-                                                   sizeof(saveaddr),
+                                                   af->sockaddr_len,
                                                    SCTP_ADDR_NEW, GFP_ATOM=
IC);
                        addr_buf +=3D af->sockaddr_len;
                }

Note that the same issue does NOT exist in the following functions:

- sctp_copy_local_addr_list()
- sctp_copy_one_addr()
- sctp_bind_addr_dup()

Although they use sizeof(addr), the addresses being copied are already
entries from address_list, where the unused bytes have been properly
initialized.


Hi, MingXuan, can you give it a try to fix it in the proposed way above?

Thanks.
