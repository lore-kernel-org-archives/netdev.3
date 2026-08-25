Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7689C3C1984
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787638936; cv=pass; b=jA3gnOkEZCSfTqt40PiXtgN6LQjZlaqbHO7feZVGbx/R9C+ecZZ/HbYFOx+wX0UXQaLgGjmWpoxzySKlbOxKKKL7bNHqyUCkQ+8rQ3ExWZ4nCfcM2q7TzmUs6JZZoDJ0APasPkqwOik1/OjBZYXZZXMOcfM658OJk2pOefgu+W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787638936; c=relaxed/simple;
	bh=1XJycN1eKzm1slwbyQsbcSHLl6wYSi/yDaumlrFerJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phmiaFzIjMm4/RSIC2bTIfXJvU0B63LV8eW1WKDrrZqCrwKJJkrwwXy6hhoD6UWHRZOaKtANCOFeVKQDm12CLguNVFXa2vmXpPw600lFNm7EjCa0pzM49B/ENUSnas/INeWyu21dGhC/bnsW98RWVcdjEpT6TBl2fSwEXk7kwx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kp7dOIcG; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp7dOIcG"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39c8dbf4f38so41930991fa.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 23:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787638932; cv=none;
        d=google.com; s=arc-20260327;
        b=BLbuVi2NHXMJ7j/sB5c/5ENeTJ8n96YFfW7X7Xp1d0G9whHwvS6byce8DHJyH3CDvg
         qAruiHyBzuqMyPFr6dg87x7d4cPBZptODuoC+wcuIWJeurdogvVk5wp8F3IbV0d9Fadj
         vO4MS1MWmayvInwQpu71veyOsWFO6iEub8TaZkvofGjYlDQoS9s6TfNWwwFC7n/C4Tgg
         bbqGNWUu6xxWhsxY7M8SzQMWrDCAgAA3VuNK8MyL97Ze73zR8u9mPc5bshYupOjb/cHy
         BLCb8yPEosF/ksCOX9fDwk9bF3VBbQoOrc0I192ekQvnX5TIXdXLILURxw7PdvA5Hdpe
         sxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lmfxIomckmLv6QtHhQG41G6LPwKSajfTzLUuEWwyKE4=;
        fh=bgsEq7yGBMQ8UCl0KWJ5WGwIKTE3FWdJN824LHP8YJ0=;
        b=gO0Xc8V6sk0g086aeedLtZGWWfuxGjZfS931vO5E4J+1lqHxy8Msanoje1lRNow6K7
         9SeioDP7evNbtjOCIqK4FCsVg/WBspqUyCN3FKd4jxoiu79OAoJ026+CHjUA/xVcjoKm
         yVYx57O1sWc5NS+s8Ol6ZedTmajwq/Mm8dpkAuzWmM2jkqxUsI+gRVnVpXOpZIS+p6Aj
         wnX5+nC49bEX9OrcRk2uDatdyELYWz9xt+0z5wzMVOKQPcB0gDk1AWRWF7tnVVnkgEHY
         9Sxmqwoi+PgNrbzAaC/cgDf8kIvuEtAs5S0s4hrjkBsuUflM7q4B/Qa5kqpT+Bo0yc43
         2UIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787638932; x=1788243732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lmfxIomckmLv6QtHhQG41G6LPwKSajfTzLUuEWwyKE4=;
        b=kp7dOIcGaWAm6eyKL7k4efqwBdupV5Yug+k5mKsz4o0gnfhi4GOEZWpp8IkOUmviVQ
         JW3WvjYO0eJrxbdUzjfHFV3YqFXL/4FvmwHAlHxmn/aLjH8cJ1Ucw7Qti8Dk8vCqNNlF
         ks/OBA9FQyEOeAm7f1t0BHQggiJbCs9+Hgt8H1fBkjX74HjzsRDKw8il68BEL6eF4KFy
         GBgCp3tAvmU5W11dQcpM8vwEvrzdurhByaZgIfpnQZ82W/r4hVry1N8D9qHt6djOl/nW
         bHVsz0VqGx4vEWbNzVOT0UHrOg8ZSF9b8z3435AIVP3NxiD9POqPK+Ma6Ud8HKKhH1j2
         HwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787638932; x=1788243732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmfxIomckmLv6QtHhQG41G6LPwKSajfTzLUuEWwyKE4=;
        b=e+XrsNmaJ7T6y9/pspn5Q+iVOGJmPcQbA1BfUvfAj/43+mthiJSDGYA6PjHoiHqNJ+
         nbF8U9tXrfyz58T8g7dN9GSJsuF//HA2PgI9iMcOi77usOeG195PnCPTc9ADMCb4laFs
         kLeHCpLxht9doIc7vlCq+wEVL/HjQ+xA9F3KZfqXRQPWwanC7+be5fe5wcFwgZW5UCL3
         pcsdF3MCwkZ6JiouHDs4BVWfsTkYggBkswFe3r/NMJmwfYaRg7aVDSLGLNh1K/UgLu3h
         WY5tvcF6pTwv3UIL3W6DUPXdMRFDGRDpM2b2iMbjJq+RZJnRn0n5Vi8Cg0DJsLX5SMI/
         1lkw==
X-Forwarded-Encrypted: i=1; AHgh+RrDD7EhAyjN5Nz4kEI3oQihOQ5W2lTb97UzwKO9CCcCIaS0JyJo6TCLiDvrwc6W/m1UNInS49w=@vger.kernel.org
X-Gm-Message-State: AFuF++k7VBY2i3tTK2h+j1LhBEXOrQITVFFnD1dRfWnP6GgMZBb8inPC
	3+jYWf7PegE4EdtWmiaKLKNQDh6BkWa9KostRzjK2TT6vQcEeZc1yp6DsYg3GvmzmP5pQJAQKJB
	GfHnJV6/ba87v9sAwKbhseyrgdB4d4FRJVQF9WAU=
X-Gm-Gg: AR+sD136+ITa73FV+HR+WRWFNjjfQ1pubZZWR9S982uCLx7QknZRC32lxsVVP5BryiZ
	so4asd90GoTaELAlm/ak6dpJlnUg5Iv4qKvE/NWV6qfZXB99uP7y3u2+i6SydwaoWtmFDRZW7ub
	TC7iwfEK4LAzb9tEhBODduXIauD9V9pewduloqrrRj4KwgtVP03kovsJtCBCBc76Hlq/cqNbImQ
	Js2IrZmqNMr6tyoJB9DbPdfFCfTDjZ7ZAcppdCjtFabg96SRO3pnoANaSDa4CYFzWTig3JYZMl7
	JdaC2PN0QSeKzpq+beJEQRT/jRpNncGtEishIXnum+uzfHajTf2ycwqcMVwAd0PoTw3WbKw2OXy
	anVTpbuGNqYIodnHmgsrt8CSxW/U8SFWcRgLsxrIdNqtcP5azK8PZHBfsdWM=
X-Received: by 2002:a05:651c:3242:b0:3a1:11d3:173e with SMTP id
 38308e7fff4ca-3a1ef41de62mr8160691fa.14.1787638932016; Mon, 24 Aug 2026
 23:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817153957.3177627-1-poros@redhat.com> <CANn89iKZe5reKy5uNxF7_G2=zytnPjWCUn+bX7-iGdJuTjBgMw@mail.gmail.com>
 <CAL+tcoBX+3_oiy5KCtnBkjEdmDgzY6PYAT2oOqDSLXezDCFfHw@mail.gmail.com> <CANn89i+aacS2PfaMXnimzGgbCLz-JSnqo6QyoS122Gf+kxya3w@mail.gmail.com>
In-Reply-To: <CANn89i+aacS2PfaMXnimzGgbCLz-JSnqo6QyoS122Gf+kxya3w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 25 Aug 2026 14:21:34 +0800
X-Gm-Features: AcwNN1V7KGrHTI3nUtkITBErK4SK8jYm4mBMcZcrHQYCTHlnZyUa999e2sIfyTc
Message-ID: <CAL+tcoB80wATncgNQDnWS6-W+VxqiANph1ogGz6zLv0TKLxG1g@mail.gmail.com>
Subject: Re: [PATCH net] xsk: reset the mac header in the generic Tx path
To: Eric Dumazet <edumazet@google.com>
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

On Mon, Aug 24, 2026 at 9:14=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Aug 24, 2026 at 2:47=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Fri, Aug 21, 2026 at 1:07=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, Aug 17, 2026 at 5:40=E2=80=AFPM Petr Oros <poros@redhat.com> =
wrote:
> > > >
> > > > __dev_queue_xmit() resets skb->mac_header, __dev_direct_xmit() does=
 not,
> > > > so a frame taking the qdisc bypass path reaches ndo_start_xmit() wi=
th
> > > > the sentinel left by __finalize_skb_around() and skb_mac_header() p=
oints
> > > > 65535 bytes past skb->head.
> > > >
> > > > The packet socket reaches it through packet_direct_xmit(), and
> > > > packet_parse_headers() was taught to anchor the header by
> > > > commit c2707480cfbf ("net/packet: reset the MAC header on the
> > > > packet-socket transmit path"). AF_XDP reaches it through
> > > > __xsk_generic_xmit(), and net/xdp/xsk.c never sets the mac header.
> > > >
> > > > ice reads eth->h_proto through skb_mac_header() on its ordinary Tx =
path.
> > > > On an E810 every one of 2817224 AF_XDP frames reached the driver wi=
th the
> > > > sentinel still in place, so the ethertype never came from the frame=
. With
> > > > this patch all 5757920 frames of the same test carried the correct =
0x88b5.
> > > > An AF_PACKET sender on the same port read 0x88b5 in both runs.
> > > >
> > > > On a KFENCE kernel that read lands inside the pool and gets reporte=
d as a
> > > > use after free of an unrelated object, 387 times in a 180 s run:
> > > >
> > > >         BUG: KFENCE: use-after-free read in ice_xmit_frame_ring+0xd=
db/0x1650 [ice]
> > > >          ice_xmit_frame_ring+0xddb/0x1650 [ice]
> > > >          __dev_direct_xmit+0x347/0x4d0
> > > >          __xsk_generic_xmit+0xc13/0x1e70
> > > >          __xsk_sendmsg.constprop.0.isra.0+0x519/0x640
> > > >          xsk_sendmsg+0x6c/0x90
> > > >
> > > > Rerunning the same reproducer on the same E810 with this patch appl=
ied
> > > > produced no reports and no bad reads.
> > > >
> > > > Anchor the header in xsk_skb_init_misc(), which runs once per skb f=
or
> > > > both build paths. With IFF_TX_SKB_NO_LINEAR the offset still is not=
 a
> > > > real header, but it stays in bounds and no such driver reads it.
> > > >
> > > > Fixes: 35fcde7f8deb ("xsk: support for Tx")
> > > > Signed-off-by: Petr Oros <poros@redhat.com>
> > > > ---
> > > >  net/xdp/xsk.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index 7855ee09c4b640..885427392cb6b3 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -931,6 +931,7 @@ static int xsk_skb_init_misc(struct sk_buff *sk=
b, struct xdp_sock *xs,
> > > >         skb->priority =3D READ_ONCE(xs->sk.sk_priority);
> > > >         skb->mark =3D READ_ONCE(xs->sk.sk_mark);
> > > >         skb->destructor =3D xsk_destruct_skb;
> > > > +       skb_reset_mac_header(skb);
> > >
> > > I don't know, I had at some point the goal of removing our dependency
> > > on mac header in ndo_start_xmit(),
> > > as this must be skb->data.
> > >
> > > ice could use skb_eth_hdr() instead of eth_hdr() or skb_mac_header()
> > > and save few cycles.
> > >
> > > Some drivers call skb_reset_mac_header(skb), this is really a mess.
> > >
> > > With AI these days, it should not be too hard to completely remove ou=
r
> > > dependency on mac_header.
> > >
> >
> > I saw the status has been changed to 'rejected'. Why is that, I
> > wonder? I think it's just a fix that can be done in xsk like
> > skb_reset_network_header() that I'm going to add.
> >
>
> skb_reset_network_header() is orthogonal.
>
> Patching net/xdp/xsk.c (and follow-up network header resets) only covers =
one
> caller while leaving the core issue open.
>
> The discrepancy is that __dev_queue_xmit() unconditionally executes
> skb_reset_mac_header(skb), whereas __dev_direct_xmit() does not.
>
> As a result, other paths bypassing qdisc hit the exact same out-of-bounds=
 read
> in ice. For example, AF_PACKET with PACKET_QDISC_BYPASS only resets mac_h=
eader
> in packet_parse_headers() under:
>
> if ((!skb->protocol || skb->protocol =3D=3D htons(ETH_P_ALL)) &&
>    sock->type =3D=3D SOCK_RAW) {
> skb_reset_mac_header(skb);
> ...
> }
>
> Any PACKET_QDISC_BYPASS socket using SOCK_DGRAM or SOCK_RAW with an expli=
cit
> protocol (e.g. ETH_P_IP) sends an skb with mac_header unset (0xffff senti=
nel)
> directly into ndo_start_xmit().
>
> If the core stack was expected to guarantee mac_header for direct xmit, t=
hat
> reset belongs in __dev_direct_xmit(), not duplicated in xsk, packet,
> selftests, etc.

Spot on. That's a general approach.

>
> Work in net-next would presumably audit / change all drivers to not
> rely on mac_header
> being set (This I can do when net-next reopens)
>
> Then we can remove skb_reset_mac_header(skb) from __dev_queue_xmit()
> and __dev_direct_xmit(), and from dpaa_tx() / dpaa_tx_extended()

Thanks, Eric.

But my minor confusion is that the current patch still holds for the
older stable kernels, right? So it seems reasonable to accept it in
this way since it targets the net branch?

Thanks,
Jason
