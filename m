Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB4024E4C3
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 00:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785631958; cv=none; b=jIKojmIG838vK73Q7oH6TcuHcFNJ9RAQzCgDZFwai/U15GuHPLWHoXWAKVFMLKebS2CuddANapP61/vytHN7lNGMaMUno0XD8jRsl59p/7NoZInmUho2gzHr32KD4gijWTQ7WTwms9TOBJg/YjfAx0pH/oCjDFqCkND7h17AraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785631958; c=relaxed/simple;
	bh=HchlqJvbJYmgEf8zNMJx/aH1mCF2j1w5x1nHZEAylDA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBNM0ZVWMdcIy9Uo8pcAxxBPdLW8FL7M9tI/jfXDOcTnwFAkHeFUfrgnnwpVW7rguW2XpPjOUdSmllqdhd3Txa/GNbtNmprwDVf859fMSGBgcVewKQMehjnKg5rzXH4nVnwqa9QsZx/Q71TPDKB04c+W9pLrU+LtJub/9yKfQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=D3NTGI/L; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="D3NTGI/L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785631946; x=1785891146;
	bh=Tr1J5/Sv0mAr7gaD8iu0l6T6sz/kl7ZnUg8iM+otgaY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=D3NTGI/LIteLAgSF6qj03Fo/v2thvshWyUvVcVFSnZISvC7jVgCA3m9WmpMCLpkCs
	 b9FPzPinAuysELivumu1Kf2mjRUqkIdUBM7RD0AYmp3HK8IqnKBVbAOA7W7WLFnUsL
	 IQ67cvo58KD15QYzav23VnsTbwbfBG+p8MqJF8MgGt0bpXmDEIXnj4OakLuDU536fl
	 EFMbby/OjZm3UaL/b2t4nITbTWHOyE93Ulo2SlIcF3/dz5PZUdB34vxAgu11AcPzSH
	 hX96EXBQ0YxpUzSVWzU70EIYRhSqQ98zlC0pbYLitvaloCZ44HWE7DoubullZxwrGN
	 v6jgmO21fHymA==
Date: Sun, 02 Aug 2026 00:52:20 +0000
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
From: manizada <manizada@pm.me>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net] tun: prevent underflow in rx headroom calculation
Message-ID: <xPAgsryD7ZWPCp4djQ2-FNguiK-v4wu_PDQFjCQ22hABd2Y8C8lIXzAskbJ3S_yJDysh9izzb82ELATvewS2RD0o2VH3q7yirg9HH_mrHd8=@pm.me>
In-Reply-To: <willemdebruijn.kernel.296b127eabe3c@gmail.com>
References: <20260721014117.2234892-1-manizada@pm.me> <20260723171437.784955-1-kuba@kernel.org> <YzGdhAUpdIBVpl5kEwszNWBTaolCS34_1OLI3kj9BiUkrxJsgcpIlsQKi2LnuvGQy76ugEGsZvZdB2Fgbmq1_QMpAel2h--RFpYe2ZIX7aE=@pm.me> <willemdebruijn.kernel.296b127eabe3c@gmail.com>
Feedback-ID: 37265593:user:proton
X-Pm-Message-ID: c511778349f44c771590ad050ce7ef08f8a1e2a6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Saturday, July 25th, 2026 at 2:37 PM, Willem de Bruijn <willemdebruijn.k=
ernel@gmail.com> wrote:

> manizada wrote:
> >
> >
> >
> >
> > On Thursday, July 23rd, 2026 at 10:14 AM, Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> >
> > > This is an AI-generated review of your patch. The human sending this
> > > email has considered the AI review valid, or at least plausible.
> > > ---
> > > tun: prevent underflow in rx headroom calculation
> > >
> > > This patch clamps good_linear to zero in tun_get_user() so that a lar=
ge
> > > tun->align value coming from ndo_set_rx_headroom() does not cause
> > > SKB_MAX_HEAD(align) to underflow into a huge size_t when assigned to =
the
> > > linear variable, and later cause the skb data pointer to end up outsi=
de
> > > the allocated head.
> > >
> > > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > > index ffbe6f13fb1f..d3be0f2d5df8 100644
> > > > --- a/drivers/net/tun.c
> > > > +++ b/drivers/net/tun.c
> > > > @@ -1780,6 +1780,7 @@ static ssize_t tun_get_user(struct tun_struct=
 *tun, struct tun_file *tfile,
> > > >  =09}
> > > >
> > > >  =09good_linear =3D SKB_MAX_HEAD(align);
> > > > +=09good_linear =3D max(good_linear, 0);
> > >
> > > [High]
> > > Does this fully cover the IFF_TAP path when align is large enough tha=
t
> > > SKB_MAX_HEAD(align) is <=3D 0?
> > >
> > > With the clamp, good_linear becomes 0, and later in tun_get_user() th=
e
> > > non-zerocopy path does:
> > >
> > >     copylen =3D len;
> > >     linear =3D min(hdr_len, good_linear);
> > >     ...
> > >     if (!linear)
> > >         linear =3D min_t(size_t, good_linear, copylen);
> > >     skb =3D tun_alloc_skb(tfile, align, copylen, linear, noblock);
> > >
> > > so linear ends up 0 and the resulting skb has skb_headlen(skb) =3D=3D=
 0.
> > >
> > > For IFF_TAP without IFF_NAPI_FRAGS the code then calls:
> > >
> > >     skb->protocol =3D eth_type_trans(skb, tun->dev);
> > >
> > > eth_type_trans() -> eth_skb_pull_mac() -> __skb_pull(skb, ETH_HLEN),
> > > and __skb_pull() has:
> > >
> > >     if (unlikely(skb->len < skb->data_len))
> > >         BUG();
> > >
> > > Since skb->len and skb->data_len both start at the packet length and
> > > skb->len is decremented by ETH_HLEN in the pull, would this reach the
> > > BUG() when a user writes to /dev/net/tun with tun->align pushed above
> > > the SKB_MAX_HEAD threshold via the OVS/netkit/VXLAN stacking describe=
d
> > > in the commit message?
> > >
> > > The pre-existing behavior at align =3D=3D 3776 appears to hit the sam=
e
> > > BUG() and align > 3776 pre-patch corrupted memory before reaching it,
> > > so this change is an improvement, but would forcing linear >=3D ETH_H=
LEN
> > > in the IFF_TAP path (or calling pskb_may_pull() before eth_type_trans=
()
> > > regardless of the frags flag) be needed to close the remaining panic?
> >
> > Oh this is a good catch. But while making the TAP pskb_may_pull
> > (ETH_HLEN) check unconditional would address the eth_type_trans() case,
> > raw TUN with IFF_NO_PI also directly reads the first protocol byte from
> > skb->data, so we'd have the same issue there.
> >
> > Rather than add consumer-side handling for a fully nonlinear skb state
> > introduced by the repair, maybe the cleanest is preventing TUN from
> > creating this state?
> >
> > =09#define TUN_MAX_HEADROOM 512
> >
> > =09tun->align =3D clamp(new_hr, NET_SKB_PAD, TUN_MAX_HEADROOM);
> >
> > This fixes the original SKB_MAX_HEAD() arithmetic issue, and also prese=
rves
> > linear space for both the raw-TUN protocol byte and the TAP Ethernet
> > header. The 512-byte value matches the existing ceiling in
> > ip_tunnel_adj_headroom(), so requests above the cap can require later
>=20
> Is that a ceiling specific to ip_tunnel or universal for tuntap? I
> suspect only the second. In which case this would add a new condition.

Yeah you're right, that was specific to ip_tunnel_adj_headroom(), not unive=
rsal.
Sorry for the delay here, the more I look into this the more potential issu=
es
I find (including couple more I'll send a patch for separately):

>=20
> > skb expansion instead of unsafe preallocation by TUN.
> >
> > Does this sound reasonable? If so, I can post v2 using the TUN-side cap=
.
>=20
> Why NET_SKB_PAD, aside from that it happens to be larger than both
> IFF_TAP and IFF_NO_PI cases?  (good catch on that NO_PI btw.)
>=20
> The IFF_TAP case already has a pskb_may_pull, but only for frags.
> Perhaps we should just always enable that. And a similar check before
> the NO_PI case reads skb->data[0]. That is in line with standard rx
> protocol parsing logic.
>=20
> Alternatively indeed clamp, but to the true minimum required values in
> these cases, which coincide with the values tested in pskb_may_pull.
>=20

With NET_SKB_PAD I just meant to preserve the existing lower-bound behavior=
 in
tun_set_headroom() for negative/very small requests, not set a protocol
minimum for either side.=20

RE: pull-based alternative, it sounds reasonable, and making pskb_may_pull(=
skb, ETH_HLEN)
unconditional and pulling 1 byte before the IFF_NO_PI read would fix the
immediate fully non-linear skb. But, those pulls would still leave
skb_headroom() unbounded. mac_header and network_header are stored as 16-bi=
t
offsets from skb->head, so a large-enough headroom can still truncate
those offsets, so just pulling the packet bytes linear would not prevent an
overflow from excessive headroom value.

How about this instead?

  max_headroom =3D min_t(size_t, SKB_MAX_HEAD(0), U16_MAX - 1);
 =20
  if ((tun->flags & TUN_TYPE_MASK) =3D=3D IFF_TAP)
          max_headroom -=3D ETH_HLEN + NET_IP_ALIGN;
  else
          max_headroom -=3D 1;

  tun->align =3D clamp_t(int, new_hr, NET_SKB_PAD, max_headroom);

This leaves 1 linear byte for the IFF_NO_PI version check, or a complete Et=
hernet
header for TAP, while accounting for the NET_IP_ALIGN added later via TAP.
It also keeps the requested headroom within both the usable 1-page skb head=
 and
the largest valid skb header offset. The 16 bit limit would constrain just =
the initial
headroom reserved by TUN, not any packet-relative offsets added in later el=
sewhere.

Would this make sense?

