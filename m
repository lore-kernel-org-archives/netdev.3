Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5A41687C
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577279; cv=pass; b=TOnfeIjyjtUTeGIaSnARS8m/fL/Jb/CIZqTZ8Kj/bOriRAcoe4cJ1oa0crSl1DtT3SkbVH3qxJen4UtxQNz5o5qOPU0p/HYLR4BRXmlvDgVb3MyxzAg53fntKRdrgzq910ovbUxmNe4bwPHGkp3RqHhHVLnkdzwKlB/Sfsas3u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577279; c=relaxed/simple;
	bh=H9ESRqbYFKIzVphlKxi6kHHfLBQ/3zka1Lcl3k+zGKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJ+hdfTqmMsHG7DlHt0ZVj0XuHu51XtkxwajVZeqHvPTKOJIAtLPzYzIZRum2+B6SP3Lo6M2uuSzqJwi1IhOy7+EeqVEDT3+Po9VjCkuvcZTup4ljwA5hr2Q+Ykw5CXQ1rkxupmUyt+ytpMXlkgiSNEHqZhcWKW1lpYDyTP3i0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NYrFf1gd; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NYrFf1gd"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-836eac5682bso61360017b3.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 06:14:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787577272; cv=none;
        d=google.com; s=arc-20260327;
        b=a8dx65pP3K+Oey0NZTpBFxwS6O5t8T2nz9bAlTA4+hsdnI/kmFBvG8+Ma4O3E1D0eV
         QB/jXC3VxOvoTD6ykjITcEfTF4/pWG3QvdnxQfy6dThIPqRWvXt+dF3Js7b6rTxxQA2X
         81oUg13y4UtciGLzrRPG+Iqb7pfsFKZI+XfmO0dhAHdsd1zX21NFk1ldpIrYL6TS1YIo
         cY1Usu2GbVTHexdJSVlCwA+umDJLhHmgk29KKRG+ADEyxyOsKiDYCx9Pa6maqoxg4lSj
         y8LYzhRdsS1YcCa+MEPj3hqQqNWKrmcpOH2pKRa+dRtDue1ocj5DDAVj0+X+5oCWCaxn
         CZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m4A5oM0s12UDxTBgx5tT3y/RZNqLbYSEaj9e4gxD5is=;
        fh=vBz+OVyX8dJz1YiD0pOwHc8USrY9y86Z+MBXEvpwq/0=;
        b=LnJTMO8YBp1Bi9AHa7T0up7FQChxvHo9coUFaT+/NA5o4fmEgC3cUd3dJDz2dXa9r9
         jnjWkPN4rjp48g4ttg4LPQSmltgpl5AdGPbQHODp3PjLPzsjNYMw26yBWUh6RA5Y78u6
         MALknr8tuKaYKszxv03ag0MRxDXXd6/iXcGYzLwxRIbfgVG2rSIioZrjGXbBLpghH82h
         rFN1+7Q9WLTDf7oCSBX91pXIjWzRxSyLrvGNP5gETKttfThzzyMEpon7MByqP8gwGpx/
         T4+KIGmJXG2dWNStWFPiEVcSCf7QToGID7BScmO/FQ3lx0iSBDiJXCQ8YioINnS3pub7
         HVMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787577272; x=1788182072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m4A5oM0s12UDxTBgx5tT3y/RZNqLbYSEaj9e4gxD5is=;
        b=NYrFf1gdnDspYhhpfZzvi0hq3PA6KoNtaG0H+Uwt9KNnzRhkIZn6/CorKt9XW19cP8
         7VU7kYHSC5EowFgyyB4u9iHu498KFRLTvyYQ8iI7Cb2UKJc2v2E+DhxnGpueV7lD/dvg
         n/h0/68+2g1sVlmJfIekaHJoPDElJxLTb3g5ooCIDJYIf2U7V+uO2vu383QfocC/Tm2u
         8yGNs291H77pD7d3Q5P0Pu4dFGyXPHGfiYN4aA0kKhcdyEtRZymOOOgJIjzRIs8SRK0S
         TKlSSNQCm4oatjI6KnM4HysOdhDgSUEBvNYezuNplR/C+CXf8pZ3Fnuv8WBVCW9UF9Qn
         lP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787577272; x=1788182072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m4A5oM0s12UDxTBgx5tT3y/RZNqLbYSEaj9e4gxD5is=;
        b=P/lkHNhL/GRDUX4ku10tA0uz8hm+oBDMZ5isdCyoDQh6swi+UdPCEDqzcFoNhdgG8G
         iExJ0xNvaZJvBNiIwZi+7m3RsFh+F16g0/BKVefT1OtN5T4yT0RTCYl8VU6km9RR1/8s
         1n8nuzenToxrl/RLRPur1IKFjNYBqvKDkVT+C5pp85Ui96y/yWAo6LYiLw5PvuHcV7DQ
         kqssbFLk5ZxNFXqIxz9RQalqbvLe8OMWY2RoScygIQv96TuRhJ0+59xst2Nd92ecJWgh
         GbuoKryOEL1YxEGB47oqbIlES6Mr2acuPH+HZLVbJRup6yaGIouKWOTlom2FNRBnYvA7
         R9aA==
X-Forwarded-Encrypted: i=1; AHgh+RpypxsiUyxffxmKAtL5PxE1fMkbJH6hzPRzh1dPGM77Vp3sceqoXegZGnoGBK9KXCc5SMtVhXc=@vger.kernel.org
X-Gm-Message-State: AFuF++k6LdWB/Cai/tc/TtteB7g/zBc9CzxUk26LQRRbyVSTQfAs71FH
	A6xaBoi0l01H6MXPg7+cogcKIlYP1x8A6jx67dsZIgJ0ARV4YqzxYRe9abM1CH5rfbWK9eNHlUB
	edqIgGoIf7hjgp2qdnazxXMLtC7NYoVclbr6S6cLU
X-Gm-Gg: AR+sD12tUirYB0Q5DQm3Tf8ZriaJ0ixXZcdMloeMO7OYjuVreeMBphb0HS6pTGaaDcS
	K2alJGrCub8m0Uy2UvsJlNF0UynrMyFM04rHiISlKDfZqyGZ6oxxigm8+tQYJoZOHfyNt4tdRJN
	+UtJkkTqnkj4v2cSVWZ2Ema0GIguYMOzxLlJeyytARIk0BXpDG5iSRmjcrTJYoiM2s0ybG464sV
	SscdqgjQZhNj+D3BpXxHdykt83v5jzs+s1yUCGI3ZpwJXMksRLNgJtqnA57bM+UHyb72G2F1R9G
	BTQzJgNyDE0JZ/NjnoDavoOi8PsxMVEOAuVaUJueZqNbdLvEi4Juiyum+lwW0DfSKiLCRI5MqfH
	bfn/oC7ZAA5stoUh5v8ObqS//0wvxkGOu9D3iJkdIDGBcH0jcxwHyyrx7f6oJH0d09E0=
X-Received: by 2002:a05:690c:e681:10b0:80e:c332:1796 with SMTP id
 00721157ae682-8470b3d3316mr89912227b3.10.1787577271496; Mon, 24 Aug 2026
 06:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817153957.3177627-1-poros@redhat.com> <CANn89iKZe5reKy5uNxF7_G2=zytnPjWCUn+bX7-iGdJuTjBgMw@mail.gmail.com>
 <CAL+tcoBX+3_oiy5KCtnBkjEdmDgzY6PYAT2oOqDSLXezDCFfHw@mail.gmail.com>
In-Reply-To: <CAL+tcoBX+3_oiy5KCtnBkjEdmDgzY6PYAT2oOqDSLXezDCFfHw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Aug 2026 15:14:20 +0200
X-Gm-Features: AcwNN1Uv9lIX3zmkxdB3EjIqAVKKZ0pLsVj08EKSHGvCV-nTg0FsVN0v-Sg6ExE
Message-ID: <CANn89i+aacS2PfaMXnimzGgbCLz-JSnqo6QyoS122Gf+kxya3w@mail.gmail.com>
Subject: Re: [PATCH net] xsk: reset the mac header in the generic Tx path
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Doruk Tan Ozturk <doruk@0sec.ai>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 2:47=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Aug 21, 2026 at 1:07=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Aug 17, 2026 at 5:40=E2=80=AFPM Petr Oros <poros@redhat.com> wr=
ote:
> > >
> > > __dev_queue_xmit() resets skb->mac_header, __dev_direct_xmit() does n=
ot,
> > > so a frame taking the qdisc bypass path reaches ndo_start_xmit() with
> > > the sentinel left by __finalize_skb_around() and skb_mac_header() poi=
nts
> > > 65535 bytes past skb->head.
> > >
> > > The packet socket reaches it through packet_direct_xmit(), and
> > > packet_parse_headers() was taught to anchor the header by
> > > commit c2707480cfbf ("net/packet: reset the MAC header on the
> > > packet-socket transmit path"). AF_XDP reaches it through
> > > __xsk_generic_xmit(), and net/xdp/xsk.c never sets the mac header.
> > >
> > > ice reads eth->h_proto through skb_mac_header() on its ordinary Tx pa=
th.
> > > On an E810 every one of 2817224 AF_XDP frames reached the driver with=
 the
> > > sentinel still in place, so the ethertype never came from the frame. =
With
> > > this patch all 5757920 frames of the same test carried the correct 0x=
88b5.
> > > An AF_PACKET sender on the same port read 0x88b5 in both runs.
> > >
> > > On a KFENCE kernel that read lands inside the pool and gets reported =
as a
> > > use after free of an unrelated object, 387 times in a 180 s run:
> > >
> > >         BUG: KFENCE: use-after-free read in ice_xmit_frame_ring+0xddb=
/0x1650 [ice]
> > >          ice_xmit_frame_ring+0xddb/0x1650 [ice]
> > >          __dev_direct_xmit+0x347/0x4d0
> > >          __xsk_generic_xmit+0xc13/0x1e70
> > >          __xsk_sendmsg.constprop.0.isra.0+0x519/0x640
> > >          xsk_sendmsg+0x6c/0x90
> > >
> > > Rerunning the same reproducer on the same E810 with this patch applie=
d
> > > produced no reports and no bad reads.
> > >
> > > Anchor the header in xsk_skb_init_misc(), which runs once per skb for
> > > both build paths. With IFF_TX_SKB_NO_LINEAR the offset still is not a
> > > real header, but it stays in bounds and no such driver reads it.
> > >
> > > Fixes: 35fcde7f8deb ("xsk: support for Tx")
> > > Signed-off-by: Petr Oros <poros@redhat.com>
> > > ---
> > >  net/xdp/xsk.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 7855ee09c4b640..885427392cb6b3 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -931,6 +931,7 @@ static int xsk_skb_init_misc(struct sk_buff *skb,=
 struct xdp_sock *xs,
> > >         skb->priority =3D READ_ONCE(xs->sk.sk_priority);
> > >         skb->mark =3D READ_ONCE(xs->sk.sk_mark);
> > >         skb->destructor =3D xsk_destruct_skb;
> > > +       skb_reset_mac_header(skb);
> >
> > I don't know, I had at some point the goal of removing our dependency
> > on mac header in ndo_start_xmit(),
> > as this must be skb->data.
> >
> > ice could use skb_eth_hdr() instead of eth_hdr() or skb_mac_header()
> > and save few cycles.
> >
> > Some drivers call skb_reset_mac_header(skb), this is really a mess.
> >
> > With AI these days, it should not be too hard to completely remove our
> > dependency on mac_header.
> >
>
> I saw the status has been changed to 'rejected'. Why is that, I
> wonder? I think it's just a fix that can be done in xsk like
> skb_reset_network_header() that I'm going to add.
>

skb_reset_network_header() is orthogonal.

Patching net/xdp/xsk.c (and follow-up network header resets) only covers on=
e
caller while leaving the core issue open.

The discrepancy is that __dev_queue_xmit() unconditionally executes
skb_reset_mac_header(skb), whereas __dev_direct_xmit() does not.

As a result, other paths bypassing qdisc hit the exact same out-of-bounds r=
ead
in ice. For example, AF_PACKET with PACKET_QDISC_BYPASS only resets mac_hea=
der
in packet_parse_headers() under:

if ((!skb->protocol || skb->protocol =3D=3D htons(ETH_P_ALL)) &&
   sock->type =3D=3D SOCK_RAW) {
skb_reset_mac_header(skb);
...
}

Any PACKET_QDISC_BYPASS socket using SOCK_DGRAM or SOCK_RAW with an explici=
t
protocol (e.g. ETH_P_IP) sends an skb with mac_header unset (0xffff sentine=
l)
directly into ndo_start_xmit().

If the core stack was expected to guarantee mac_header for direct xmit, tha=
t
reset belongs in __dev_direct_xmit(), not duplicated in xsk, packet,
selftests, etc.

Work in net-next would presumably audit / change all drivers to not
rely on mac_header
being set (This I can do when net-next reopens)

Then we can remove skb_reset_mac_header(skb) from __dev_queue_xmit()
and __dev_direct_xmit(), and from dpaa_tx() / dpaa_tx_extended()
