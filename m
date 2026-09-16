Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0A14C2253
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575663; cv=pass; b=thRLxRASzpFJdNaCfYwVBGvJ4oqA9qMo2KU0i3IDAxPo76FcqdI4a59Ohlacb1R3pZj1VWUGN3tAHUfekgXnBi18IXXF11Oo3qXG4rSy9EkfwEFItCeNA3jy92bb1WD14ZBpmqAy8bAH/5ACgultkgSK/N7jrQKjuInxDJa8+mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575663; c=relaxed/simple;
	bh=FPz/2WUVvjgw7KkPB3vp0v3QrEeT+i8/AjpDko6jgx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AahWrggJ0e91t5wtZA9OyOeYBY7CcoY/GVhW9vaSNd1BZ2LGtgWDbdU3DhfHDKEP0K3W36f1QnxOA69eVat5L7DukJ2PHJXgDlrAM3Y08c9VT2Lrik8DAgK7GhC17hSPjz+ivEAgfHI/2KSSMHLmu2+L27NKodNs4QIgft9uTM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcxznPPh; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcxznPPh"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8692a8568e9so854213b3a.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789575659; cv=none;
        d=google.com; s=arc-20260327;
        b=WdnG5PeFmnevD+O1BeYjSrzduMydu2tKE/WqznjeUBPobKGxGm2MfMijGe/99QYo7D
         x/jYA7M+Sz4SW++aUrJfZ7HD+fRWJXP1RJD0ypVi8dlrg6wRcwqteaX7sDQoXmKPhdU8
         yYuJxGNpv7iPmeXWdhGyPOzIaV0TsDMkoF/SzGnaebMLXLli9bJzVg45T6zcsl5R76MP
         GG821bnbO69b2hoeII27o20WsFBKfXbkyR3v5IWBYidCaLs8rZhZu//7JcYAW5hwfJOY
         bJnraXYAGffze7nBsOGkswId+LiPEjMcpPEmKlxuDT5vYhppqK9BJrmGZSvRHFVF9BXu
         4dBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x758SQiPr4F20CkTzm4wFsu2ipWDv2Ry++hF6Myngkc=;
        fh=QFMgEb3XV5rS/ZRBmyHUP58oM4AaOHTWaWQeeAou20k=;
        b=P5NMXHQQxzMLa2f2xVz3LQHjCMhv268Q9JP6zvpop684waCtZ5hMY6R9EDrHvWssIN
         sml+1sOAaiYqaCDR6K0uZX60SrP97JQZ3ZFci+dP+JyzdmP3SvykNQye+ud4XRPrB5bR
         KXfj8lmydgLB6pjMeYHktSaZxqmeBgkkSZF7W6eLSHCBkiN1GZ+hMi0OSIMhZI55zLAZ
         BV0Gxfok5SpWmTTvKyK7bO1z5RuZ8JfbaopJYftjk7hzcXc+RxDZoY/youUP9hcduryl
         AGNCobDpgcCxUYuh+JPyhabEmFZ+y/g9zhJoA5w12AVbXzcAI2j5TbXuqYJ1tu5aahM7
         XskA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789575659; x=1790180459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x758SQiPr4F20CkTzm4wFsu2ipWDv2Ry++hF6Myngkc=;
        b=DcxznPPhdi7bG8BEQfTEzmx560hfmZbBKMpgjdxuRYhhTDiN6KLltpCXR0toN1OUuL
         tGcspEGdJu80Q8VEpgchq0UhYIMR6S389ENyhg981fbXtl+s1JCwAavZfxB5vIyOp6x6
         YzdPVF+oEvSTSITyTkF2qAv7GX58VikVfCRc0RE0lYt6ppFwN5gNNUPRxlpxVsZgkVRm
         nNIqkcXwxmyJEDCP/FDv3RnnGlp7qiwiy8PJLyyRe/mpydy5RP0VioqRCJfmkxhQvdgF
         WIV5s/DY2kJs92NOJq1B6J/xjDN/iD8GHoYAglTspx+pUokE4y6AovVBJeaG69k9b10x
         NNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789575659; x=1790180459;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x758SQiPr4F20CkTzm4wFsu2ipWDv2Ry++hF6Myngkc=;
        b=aTEaymMhPfnW5H4ZAXL0CXdL4A4MVmgodXVcjX+jSkI4CkAnRInOwZLVJx0WHb705E
         8su4AYqINRVsnOezrgGiENpgZsxyZj9niPS/u23SnrmEPyVV1t4U6iChyYK7UtbzDett
         0uDeyxG6YJfI74o9WCNl/wqujuBKjUnodSIK8KN9uO126+xJ4eJo9CyXFP5mI+RfB1Se
         KfC9RJdeSQeKOIINr6pvZt5/tpYca4o6H5U+mF2I3qc3KlyrqQ0xsHI0w/gL1CRo9TAY
         cYkR9oqI+rLaukN+STTHXhvCE9JNSXkKcY9sgij1STrKIVY6hcPA4GX6abyrcUC1l7lB
         Wyrg==
X-Gm-Message-State: AFuF++l1XyRCLCKpAd1ApkJNZHDxXtmgwG72xelVipsOUhvzW+rP2Nt3
	qF5P6fgzXAvj+D0gmX8m/mmovKZtQywoEhgIEUGI75LswbAyqLzVDnO0F5DyYqDE4Urtpf0Fj2a
	hpmznUMYOWYy7fADtk7XLahVPM90Sj7Q=
X-Gm-Gg: AYBFou3B11k7e6q1ndzkBf6sPhwAHhOL/mCOkLPyUJmY9mh+Vm6Ukazl2Sydhsa06bN
	CdbVVh6zaW8XstqaNRsEeE5h81NlzEaPWRCLGpD0omEBPoJ9p5TtLn26xGb5zo+JgTNRsjqpm+s
	deTKptrEOHSlZM8/MxPDp4h1+ufZavOj9i5SYa1yXsFsDam8ZPt5VTnud176lJWWJb20vLkV91P
	Qn8WZawRj4rN+bumIK6QYNogVapUBIn+fZzwIXmUnZyU2P8egiYV0puepkvt42nyosIxJRUkuAr
	97bABuu47hPdHj+Pzw9bToZzDLVpWjPkpjb3dZa1/UF1dMIJmFcWSq6H5w285wCMevrlVPLpoYk
	0O7GUQwYRBiSxf0fv7WTIlTy68tRHiNnQ3UJXt55RcUbOQEVO8hoyZ+ml
X-Received: by 2002:a05:6a00:1888:b0:84a:60a4:2651 with SMTP id
 d2e1a72fcca58-87238c8aad3mr5950497b3a.6.1789575659295; Wed, 16 Sep 2026
 09:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <927bfa67165193368d642396c4b8fcfc580d494d.1789393775.git.lucien.xin@gmail.com>
 <178950185914.22033.7074901863240008115@kernel.org>
In-Reply-To: <178950185914.22033.7074901863240008115@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 16 Sep 2026 12:20:47 -0400
X-Gm-Features: AcwNN1XmGdIGcCY3hppZmiydWNjDn39LITr2KKjk_zm8yrhQJrHdBYRINPy6wLg
Message-ID: <CADvbK_eN8x=MTceZrgNJRTGsGphQ2QsfJ0oNBET99VKBh=b9gA@mail.gmail.com>
Subject: Re: [PATCH net-next v15 14/15] quic: add packet builder base
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

On Tue, Sep 15, 2026 at 3:51=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 3
>
> - [Medium] Unit mismatch in quic_packet_route()
>   (net/quic/packet.c:63-66): the *IP-level* MTU returned by dst_mtu() is=
=E2=80=A6
> - [Low] Claim that the commit message over-advertises the packet builder:
>   quic_packet_handshake_create()/quic_packet_app_create()=E2=80=A6
> - [Low] In struct quic_packet (net/quic/packet.h:24) the field comment
>   reads 'u16 mss[2]; /* MSS for datagram and non-datagram packets */',=E2=
=80=A6
> - [Low] Claim that quic_packet_xmit() (net/quic/packet.c:199) must bail
>   out instead of only warning when skb_set_owner_sk_safe(skb, sk) fails,=
=E2=80=A6
>
> --
>
> quic: add packet builder base
>
> This adds net/quic/packet.c and net/quic/packet.h with the TX-side
> 'quic_packet' state: quic_packet_config() sets the path and computes head=
er
> overhead, quic_packet_create_and_xmit() builds and sends a packet, and
> quic_packet_flush() sends any bundled packets.  quic_packet_init() is wir=
ed
> into quic_init_sock().
>
> A few questions on the new code below.
>
> > diff --git a/net/quic/packet.c b/net/quic/packet.c
> > new file mode 100644
> > index 0000000000000..a1967f39c9242
> > --- /dev/null
> > +++ b/net/quic/packet.c
> > @@ -0,0 +1,280 @@
>
> [ ... ]
>
> > +static struct sk_buff *quic_packet_handshake_create(struct sock *sk, g=
fp_t gfp)
> > +{
> > +     return NULL;
> > +}
> > +
> > +static int quic_packet_number_check(struct sock *sk, gfp_t gfp)
> > +{
> > +     return 0;
> > +}
> > +
> > +static struct sk_buff *quic_packet_app_create(struct sock *sk, gfp_t g=
fp)
> > +{
> > +     return NULL;
> > +}
>
> [Severity: Low]
> This isn't a bug, but could the commit message list all of the placeholde=
rs?
>
> It mentions that "Functions to create application (short) and handshake
> (long) packets are currently placeholders for future implementation", whi=
ch
> covers quic_packet_handshake_create() and quic_packet_app_create() above,
> but quic_packet_encrypt_done() is also a stub that frees every
> asynchronously encrypted packet:
>
> net/quic/packet.c:quic_packet_encrypt_done() {
>         /* Free it for now, future patches will implement the actual defe=
rred
>          * transmission logic.
>          */
>         kfree_skb(skb);
> }
>
> Worth naming that one in the changelog too?
>
> [ ... ]
>
> > +/* Perform routing for the QUIC packet on the specified path, update h=
eader
> > + * length and MSS accordingly, reset path and start PMTU timer.
> > + */
> > +int quic_packet_route(struct sock *sk)
> > +{
> > +     struct quic_path_group *paths =3D quic_paths(sk);
> > +     struct quic_packet *packet =3D quic_packet(sk);
> > +     union quic_addr *sa, *da;
> > +     u32 pmtu;
> > +     int err;
> > +
> > +     da =3D quic_path_daddr(paths, packet->path);
> > +     sa =3D quic_path_saddr(paths, packet->path);
> > +     err =3D quic_flow_route(sk, da, sa, &paths->fl);
> > +     if (err)
> > +             return err < 0 ? err : 0;
> > +
> > +     packet->hlen =3D quic_encap_len(da);
> > +     pmtu =3D clamp(dst_mtu(__sk_dst_get(sk)),
> > +                  QUIC_PATH_MIN_PMTU, QUIC_PATH_MAX_PMTU);
> > +     quic_packet_mss_update(sk, pmtu - packet->hlen);
>
> [Severity: Medium]
> Are the units on both sides of this subtraction the same?
>
> The clamp floor is applied to the IP-level MTU returned by dst_mtu(), and
> packet->hlen (the full IP plus UDP encapsulation length from
> quic_encap_len(), 28 for IPv4 and 48 for IPv6) is subtracted afterwards.
> So for a route whose dst_mtu() is at or below 1228 (IPv4) the result is
> 1172, and at or below 1248 (IPv6) it is 1152:
>
>         pmtu  =3D clamp(dst_mtu(...), 1200, 65535);   /* IP MTU */
>         mss   =3D pmtu - packet->hlen;                /* UDP payload */
>
> That value then lands in packet->mss[QUIC_PACKET_MSS_NORMAL] and in
> congestion control via quic_packet_mss_update() -> quic_cong_set_mss(),
> and it is also the coalescing limit in quic_packet_bundle():
>
>         if (packet->head->len + skb->len >
>             packet->mss[QUIC_PACKET_MSS_NORMAL]) {
>
> Can that put the UDP payload size below the 1200-byte minimum that
> quic_packet_init() installs as QUIC_MIN_UDP_PAYLOAD, and below
> QUIC_BASE_PLPMTU (also 1200, in net/quic/path.c) that quic_path_pl_reset(=
)
> writes into paths->pl.pmtu two lines later?
>
> Note dst_mtu() can legitimately come back well under 1200 after a remote
> ICMP "fragmentation needed", which is presumably why the clamp is there a=
t
> all.  Should the floor be QUIC_MIN_UDP_PAYLOAD + packet->hlen, or the
> resulting MSS clamped to 1200 instead?
>
> The three 1200 constants in this codebase denote three different layers
> (net/quic/path.h QUIC_PATH_MIN_PMTU as an IP MTU floor, path.h
> QUIC_MIN_UDP_PAYLOAD as a UDP payload size, path.c QUIC_BASE_PLPMTU as a
> packetization-layer size), which makes this easy to mix up.
>
False:

QUIC_MIN_UDP_PAYLOAD is only used for the minimum size of the Initial
packet when building or parsing it. There is no requirement for it to match
QUIC_PATH_MIN_PMTU or QUIC_BASE_PLPMTU.

Thanks.
