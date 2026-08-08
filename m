Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB112F0C7E
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786221468; cv=none; b=X9Nx+cMmrxAieiSTl1MtFK2wlXRQWsrApOGC6RgfK1AYT0wWHNsWbfdbGIycUo6ETYfNRmohWLczrQoSu7KwQvnyhSjQvRiL9Kko1jRiyFbs28F/77HemBLwfkuFYAnBgZhDTwDMNUO8gueidTuFC76Jg4MD2UFrJPNwogx4glY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786221468; c=relaxed/simple;
	bh=pRkGWPDysq+3krAoeTSjNETKTaQN91z4bODPjkF9RQs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZ1qSeElOc9OuYsYRm2rx8bpgZAn3DLNgb116CZHOLfASX6YH/VBJ5SbNGltqd6ZPo/5fXc5rcdrl7xid8TJXZWPwYzzxy+0NUArA3z8ivzodwKy/PW2lwA/RiOLsARz/jOuRIYY+p8H4BJL/wU3sOYw1xQ/dhSEFRbedINXwuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=YEbeKSit; arc=none smtp.client-ip=79.135.106.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="YEbeKSit"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1786221458; x=1786480658;
	bh=NSY9IBQLOML4TZFwOdvdU+K5iWRNzYKtyaA/UWYx+X8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YEbeKSitf5k60lE3w5iwJdK6NbFHOYCE/V+Gq/r6mWmEjsewNzvX1RMvAahPWwcWB
	 rt0PUd67Dg+C33jT9Y/JNasmlY8N2h4XPSd4OaOX0h+9suOnkojy174RFI3KqL6yak
	 rMuMVvBmaZkhX7nSLRn2kXh+SjkY7tD6JL1ek7bCf/cdJ0MuQ3mkBaCr3arKPHHNcp
	 kFJUKcp5M6UUEG2URDZQb+8zTzxzqkmonMa2Q+Niik08WkMHNJGSCmBVAzYfmNCoXp
	 YfUn3GvWp/dLITqGrH30ircEls/ag1K2ZNt9ylnjiNxq+a4CL6Dtkzl3GKNeaAIMFI
	 k4js3gRQ8Rp0Q==
Date: Sat, 08 Aug 2026 20:37:30 +0000
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
From: manizada <manizada@pm.me>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v2] net: tun: bound receive headroom
Message-ID: <M-tchWLCUNtHY9Erqqa3ydBwEKSuSzKhdoNQp_1ByTTHSIZpP8kar1oE64p8PC6N1vCrIgoBfkeMVnExvtNkmTz14LI7eq-_I22-9ok-2SY=@pm.me>
In-Reply-To: <willemdebruijn.kernel.25faae4ed8f11@gmail.com>
References: <20260805084504.953162-1-manizada@pm.me> <willemdebruijn.kernel.25faae4ed8f11@gmail.com>
Feedback-ID: 37265593:user:proton
X-Pm-Message-ID: e118d8eedad03ce45d2e8f5ac677d7306cb38a11
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Wednesday, August 5th, 2026 at 6:14 AM, Willem de Bruijn <willemdebruijn=
.kernel@gmail.com> wrote:

> Asim Viladi Oglu Manizada wrote:
> > tun_get_user() uses tun->align both as skb headroom and when choosing h=
ow
> > much packet data to keep linear. OVS can propagate an oversized headroo=
m
> > request from another port to TUN or TAP.
> >
> > When align is larger than the usable space in a one-page skb head,
> > SKB_MAX_HEAD(align) underflows and the result becomes negative when sto=
red
> > in good_linear. That value later wraps when assigned to the size_t line=
ar
> > variable, and tun_alloc_skb() can place skb->data outside the allocated
> > head.
> >
> > Bound the headroom stored by TUN to the one-page skb-head budget and th=
e
> > largest non-sentinel 16-bit skb header offset. Leave one linear byte fo=
r
> > raw TUN and a complete Ethernet header for TAP, including NET_IP_ALIGN.
> >
> > Also pull the raw-TUN protocol byte and the TAP Ethernet header before
> > accessing them, so these checks remain safe for nonlinear skbs supplied=
 by
> > other allocation paths.
> >
> > Fixes: eaea34b23c46 ("net/tun: implement ndo_set_rx_headroom")
> > Cc: stable@vger.kernel.org
> > Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
> > Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
> > ---
> > v2:
> > - bound tun->align instead of clamping good_linear to zero
> > - derive the bound from the one-page head, 16-bit offset, and TUN/TAP
> >   linear-header requirements
> > - pull the raw-TUN protocol byte before reading it
> > - make the TAP Ethernet-header pull unconditional
> > v1: https://lore.kernel.org/netdev/20260721014117.2234892-1-manizada@pm=
.me/
> >
> >  drivers/net/tun.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index fed9dfdfcc3b..efd2e7d75c9a 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1107,11 +1107,16 @@ static netdev_features_t tun_net_fix_features(s=
truct net_device *dev,
> >  static void tun_set_headroom(struct net_device *dev, int new_hr)
> >  {
> >  =09struct tun_struct *tun =3D netdev_priv(dev);
> > +=09size_t max_headroom;
> >
> > -=09if (new_hr < NET_SKB_PAD)
> > -=09=09new_hr =3D NET_SKB_PAD;
> > +=09max_headroom =3D min_t(size_t, SKB_MAX_HEAD(0), U16_MAX - 1);
> >
> > -=09tun->align =3D new_hr;
> > +=09if ((tun->flags & TUN_TYPE_MASK) =3D=3D IFF_TAP)
> > +=09=09max_headroom -=3D ETH_HLEN + NET_IP_ALIGN;
> > +=09else
> > +=09=09max_headroom -=3D 1;
> > +
> > +=09tun->align =3D clamp_t(int, new_hr, NET_SKB_PAD, max_headroom);
> >  }
> >
> >  static void
> > @@ -1822,7 +1827,13 @@ static ssize_t tun_get_user(struct tun_struct *t=
un, struct tun_file *tfile,
> >  =09switch (tun->flags & TUN_TYPE_MASK) {
> >  =09case IFF_TUN:
> >  =09=09if (tun->flags & IFF_NO_PI) {
> > -=09=09=09u8 ip_version =3D skb->len ? (skb->data[0] >> 4) : 0;
> > +=09=09=09u8 ip_version;
> > +
> > +=09=09=09if (skb->len && !pskb_may_pull(skb, 1)) {
> > +=09=09=09=09err =3D -ENOMEM;
> > +=09=09=09=09goto drop;
> > +=09=09=09}
> > +=09=09=09ip_version =3D skb->len ? (skb->data[0] >> 4) : 0;
>=20
> Overall, LGTM, thanks. Let's wait for the bots too.
>=20
> This can be a bit simpler. pskb_may_pull checks that len < skb->len.
> And it is not an allocation failure, but a bad packet.
>=20
> =09if (!pskb_may_pull(skb, 1)) {
> =09=09err =3D -EINVAL;
> =09=09goto drop;
> =09}
>=20
> =09ip_version =3D skb->data[0] >> 4;

Makes sense, I'll do that in v3, it also keeps returning -EINVAL
in the empty packet case without needing a skb->len check. Will
resubmit within 72 hours or so unless I hear any more concerns.
I'll respond to the AI review separately, those things don't look
concerning.
