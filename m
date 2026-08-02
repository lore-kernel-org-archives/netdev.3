Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE8344D83
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785705242; cv=none; b=SNLSOJelSnnWoQFgA+AisC3jSAMcC/thoK6Xxlc/SH1jJWu+M4xV2TROoxr3VUkHTrToQrwPZ8uID6JJ7y7g9oDnP4DXZpJIZ2ADNYFCyAHeaDuaAb3QP9Gy4/IPmpx2t/IZgrkYGNaF4T8MpaJcKRZElTh1bnMGahIvgkOkKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785705242; c=relaxed/simple;
	bh=tyq0dOdndWH1w0QBgAhGPUcDpdJJ2cAAYHfCVninvK4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOfcqtgJBkABMK4azxWyiRGQaJSXt2ySYsBvz4+GmD86q6dJ8FyVQBIReDeNNEva+ocjJKp98t7qU+x7gHhvUpvY2D7kerUAJLpwA6CKfd9oWuB3xX0AX1k/PIRQftY5dOF4oQAPw+LeOZ4PkNw5LxlxZey1YUyot0oeGgwS3Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=C+hAyxOb; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="C+hAyxOb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785705224; x=1785964424;
	bh=3ErCQTiU/Y53PdObWHTxBHYaco3ncWb7dSJNmC5bAE4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=C+hAyxObO0675IgJWXJ1p1Y/yGp6tPX/2Dzz7kBj6Rhui4mVQbVB+d8X6xacER8VJ
	 a2TqohIBZZaJwrEV9mt40z8EftjJuZxFHzcJIpGXZfrnnUXvah945v82ce5nh6zfwG
	 Cq1MAn2O87w1eBgk+h//DaplbOUeeMVGqW/zOodrRkGPnmOFCdRSu6+nAI7QhS9vQT
	 8wafuDpEGuZwYop7QtCr/nE+6/YMXTQhNDymIrDGWblSpOPd8wdZYpGulk/efjQBN8
	 3eHNopu8/pVYgoQs/YtBTExdllbq3tyv4uNQPkLiq7Ck4UcaQn+C74SpVcxF/1EoDf
	 SvSiUoOPnSNEQ==
Date: Sun, 02 Aug 2026 21:13:38 +0000
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
From: manizada <manizada@pm.me>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net] tun: prevent underflow in rx headroom calculation
Message-ID: <eomszRvXgVrS3x5vXue_XYiGLN5bMyD6kM3D3rJtIp2V6uy4BvpCo9mtrovsJihu5kC2nVfbBvqpGxU15vRCP3Wpxs2Se4ewVi0upVj7U3o=@pm.me>
In-Reply-To: <willemdebruijn.kernel.6d2e5b527c46@gmail.com>
References: <20260721014117.2234892-1-manizada@pm.me> <20260723171437.784955-1-kuba@kernel.org> <YzGdhAUpdIBVpl5kEwszNWBTaolCS34_1OLI3kj9BiUkrxJsgcpIlsQKi2LnuvGQy76ugEGsZvZdB2Fgbmq1_QMpAel2h--RFpYe2ZIX7aE=@pm.me> <willemdebruijn.kernel.296b127eabe3c@gmail.com> <xPAgsryD7ZWPCp4djQ2-FNguiK-v4wu_PDQFjCQ22hABd2Y8C8lIXzAskbJ3S_yJDysh9izzb82ELATvewS2RD0o2VH3q7yirg9HH_mrHd8=@pm.me> <willemdebruijn.kernel.6d2e5b527c46@gmail.com>
Feedback-ID: 37265593:user:proton
X-Pm-Message-ID: e1b52acf3d73f3d1e0b821f53b6ac3f03ccbf82c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Sunday, August 2nd, 2026 at 8:24 AM, Willem de Bruijn <willemdebruijn.ke=
rnel@gmail.com> wrote:

> manizada wrote:
> >
> >
> >
> >
> > On Saturday, July 25th, 2026 at 2:37 PM, Willem de Bruijn <willemdebrui=
jn.kernel@gmail.com> wrote:
> >
> > > manizada wrote:
> > > >
> > > >
> > > >
> > > >
> > > > On Thursday, July 23rd, 2026 at 10:14 AM, Jakub Kicinski <kuba@kern=
el.org> wrote:
> > > >
> > > > > This is an AI-generated review of your patch. The human sending t=
his
> > > > > email has considered the AI review valid, or at least plausible.
> > > > > ---
> > > > > tun: prevent underflow in rx headroom calculation
> > > > >
> > > > > This patch clamps good_linear to zero in tun_get_user() so that a=
 large
> > > > > tun->align value coming from ndo_set_rx_headroom() does not cause
> > > > > SKB_MAX_HEAD(align) to underflow into a huge size_t when assigned=
 to the
> > > > > linear variable, and later cause the skb data pointer to end up o=
utside
> > > > > the allocated head.
> > > > >
> > > > > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > > > > index ffbe6f13fb1f..d3be0f2d5df8 100644
> > > > > > --- a/drivers/net/tun.c
> > > > > > +++ b/drivers/net/tun.c
> > > > > > @@ -1780,6 +1780,7 @@ static ssize_t tun_get_user(struct tun_st=
ruct *tun, struct tun_file *tfile,
> > > > > >  =09}
> > > > > >
> > > > > >  =09good_linear =3D SKB_MAX_HEAD(align);
> > > > > > +=09good_linear =3D max(good_linear, 0);
> > > > >
> > > > > [High]
> > > > > Does this fully cover the IFF_TAP path when align is large enough=
 that
> > > > > SKB_MAX_HEAD(align) is <=3D 0?
> > > > >
> > > > > With the clamp, good_linear becomes 0, and later in tun_get_user(=
) the
> > > > > non-zerocopy path does:
> > > > >
> > > > >     copylen =3D len;
> > > > >     linear =3D min(hdr_len, good_linear);
> > > > >     ...
> > > > >     if (!linear)
> > > > >         linear =3D min_t(size_t, good_linear, copylen);
> > > > >     skb =3D tun_alloc_skb(tfile, align, copylen, linear, noblock)=
;
> > > > >
> > > > > so linear ends up 0 and the resulting skb has skb_headlen(skb) =
=3D=3D 0.
> > > > >
> > > > > For IFF_TAP without IFF_NAPI_FRAGS the code then calls:
> > > > >
> > > > >     skb->protocol =3D eth_type_trans(skb, tun->dev);
> > > > >
> > > > > eth_type_trans() -> eth_skb_pull_mac() -> __skb_pull(skb, ETH_HLE=
N),
> > > > > and __skb_pull() has:
> > > > >
> > > > >     if (unlikely(skb->len < skb->data_len))
> > > > >         BUG();
> > > > >
> > > > > Since skb->len and skb->data_len both start at the packet length =
and
> > > > > skb->len is decremented by ETH_HLEN in the pull, would this reach=
 the
> > > > > BUG() when a user writes to /dev/net/tun with tun->align pushed a=
bove
> > > > > the SKB_MAX_HEAD threshold via the OVS/netkit/VXLAN stacking desc=
ribed
> > > > > in the commit message?
> > > > >
> > > > > The pre-existing behavior at align =3D=3D 3776 appears to hit the=
 same
> > > > > BUG() and align > 3776 pre-patch corrupted memory before reaching=
 it,
> > > > > so this change is an improvement, but would forcing linear >=3D E=
TH_HLEN
> > > > > in the IFF_TAP path (or calling pskb_may_pull() before eth_type_t=
rans()
> > > > > regardless of the frags flag) be needed to close the remaining pa=
nic?
> > > >
> > > > Oh this is a good catch. But while making the TAP pskb_may_pull
> > > > (ETH_HLEN) check unconditional would address the eth_type_trans() c=
ase,
> > > > raw TUN with IFF_NO_PI also directly reads the first protocol byte =
from
> > > > skb->data, so we'd have the same issue there.
> > > >
> > > > Rather than add consumer-side handling for a fully nonlinear skb st=
ate
> > > > introduced by the repair, maybe the cleanest is preventing TUN from
> > > > creating this state?
> > > >
> > > > =09#define TUN_MAX_HEADROOM 512
> > > >
> > > > =09tun->align =3D clamp(new_hr, NET_SKB_PAD, TUN_MAX_HEADROOM);
> > > >
> > > > This fixes the original SKB_MAX_HEAD() arithmetic issue, and also p=
reserves
> > > > linear space for both the raw-TUN protocol byte and the TAP Etherne=
t
> > > > header. The 512-byte value matches the existing ceiling in
> > > > ip_tunnel_adj_headroom(), so requests above the cap can require lat=
er
> > >
> > > Is that a ceiling specific to ip_tunnel or universal for tuntap? I
> > > suspect only the second. In which case this would add a new condition=
.
> >
> > Yeah you're right, that was specific to ip_tunnel_adj_headroom(), not u=
niversal.
> > Sorry for the delay here, the more I look into this the more potential =
issues
> > I find (including couple more I'll send a patch for separately):
> >
> > >
> > > > skb expansion instead of unsafe preallocation by TUN.
> > > >
> > > > Does this sound reasonable? If so, I can post v2 using the TUN-side=
 cap.
> > >
> > > Why NET_SKB_PAD, aside from that it happens to be larger than both
> > > IFF_TAP and IFF_NO_PI cases?  (good catch on that NO_PI btw.)
> > >
> > > The IFF_TAP case already has a pskb_may_pull, but only for frags.
> > > Perhaps we should just always enable that. And a similar check before
> > > the NO_PI case reads skb->data[0]. That is in line with standard rx
> > > protocol parsing logic.
> > >
> > > Alternatively indeed clamp, but to the true minimum required values i=
n
> > > these cases, which coincide with the values tested in pskb_may_pull.
> > >
> >
> > With NET_SKB_PAD I just meant to preserve the existing lower-bound beha=
vior in
> > tun_set_headroom() for negative/very small requests, not set a protocol
> > minimum for either side.
> >
> > RE: pull-based alternative, it sounds reasonable, and making pskb_may_p=
ull(skb, ETH_HLEN)
> > unconditional and pulling 1 byte before the IFF_NO_PI read would fix th=
e
> > immediate fully non-linear skb.
>=20
> This is probably most robust. The network stack in general supports
> non-linear skbuffs and uses pskb_may_pull for safe access.

Yep, I think it makes sense to have this as an extra defensive check.

>=20
> > But, those pulls would still leave
> > skb_headroom() unbounded.
>=20
> Would it? That good_linear limit itself was introduced to bound
> headroom, in commit 96f8d9ecf227 ("tuntap: limit head length of skb
> allocated").
>=20
> If we ensure good_linear is safe, then all allocation paths should
> create skbs with a bounded skb_headroom.

Unfortunately, yes -- I don't think clamping good_linear to zero restores
that bound on the ordinary tun_alloc_skb() path. With good_linear =3D=3D
linear =3D=3D 0, align remains prepad. tun_alloc_skb() passes prepad + line=
ar
as header_len through sock_alloc_send_pskb() and alloc_skb_with_frags() to
alloc_skb(), and then skb_reserve(prepad) leaves skb_headroom() equal to
align. Pulling packet bytes linear doesn't reduce that headroom. The path
is basically this:

  good_linear =3D 0
  linear =3D 0

  tun_alloc_skb(prepad=3Dalign, linear=3D0)
      sock_alloc_send_pskb(header_len=3Dalign, data_len=3Dlen)
          alloc_skb_with_frags(header_len=3Dalign, ...)
              alloc_skb(align)

  skb_reserve(skb, align)

I actually just tested the exact zero clamp plus both pulls on the same 7.2
rc3. With effective align 4160, skb_headroom() was 4160 both before and
after the pull. And with effective align 65535, it was 65535 both before
and after the pull; the subsequent mac and network header resets stored
0xffff. So 96f8d9ecf227's expected 1-page allocation invariant isn't
respected.

So I think the pulls can remain as defensive parsing, but the ordinary
allocation path still needs some explicit TUN-side bound -- or a rejection
derived from the available skb-head budget and the required linear bytes:
1 byte for raw TUN and ETH_HLEN for TAP, accounting for NET_IP_ALIGN.

>=20
> > mac_header and network_header are stored as 16-bit
> > offsets from skb->head, so a large-enough headroom can still truncate
> > those offsets, so just pulling the packet bytes linear would not preven=
t an
> > overflow from excessive headroom value.
> >
> > How about this instead?
> >
> >   max_headroom =3D min_t(size_t, SKB_MAX_HEAD(0), U16_MAX - 1);
> >
> >   if ((tun->flags & TUN_TYPE_MASK) =3D=3D IFF_TAP)
> >           max_headroom -=3D ETH_HLEN + NET_IP_ALIGN;
> >   else
> >           max_headroom -=3D 1;
> >
> >   tun->align =3D clamp_t(int, new_hr, NET_SKB_PAD, max_headroom);
> >
> > This leaves 1 linear byte for the IFF_NO_PI version check, or a complet=
e Ethernet
> > header for TAP, while accounting for the NET_IP_ALIGN added later via T=
AP.
> > It also keeps the requested headroom within both the usable 1-page skb =
head and
> > the largest valid skb header offset. The 16 bit limit would constrain j=
ust the initial
> > headroom reserved by TUN, not any packet-relative offsets added in late=
r elsewhere.
> >
> > Would this make sense?
> >
>=20
>=20
> 
