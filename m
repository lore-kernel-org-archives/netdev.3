Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4505C2F0C7E
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786222161; cv=none; b=K7+QhWnPw7l1Fw3FaAg07BGD2c5X3nL3uwh9XE2aseIJE5/xfPwNNov7co2u7gdardjqVwIR9StiVMdAjAhhIS/YRP/KLhBlLltmylh9CivtHdtDJdP7Pz3+r3czT9169vKu4CUJtBN5HDBXOSprC7UzHgd7VsOTz90IHqrJKCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786222161; c=relaxed/simple;
	bh=Hs1lo/Yt0wnw6bToEFrrhbdaRH3eG44pTYd4kW6BDvk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlLbDBhwLGH9BkKD7/XPhFGVX51epmCYQUOKGPfJBeQsyohcKP4G3Ad0AfUgm0CXGSIqGhe/y3wF7NQ4eIsO2am/vD9ygr7Pu7mS1eleqoxXXMJsgBSWWofS/6vVPAFpkfBTF6ZBufYIzwjcc/kejX/eNQi81NWAkJCED3JdXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=m8ed6OwB; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="m8ed6OwB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1786222156; x=1786481356;
	bh=Sdx90Tbwg4No+B+M/+bZrMrDCj+Kwh8GppS54q3a0lw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=m8ed6OwBvtGrML8adljDNcieNY8w8pmpVW2uJfMtj5YvFjJ6yW0dSDvlLz4JCvN+j
	 OcP2pe9mMfSO2U6bgI8HkJ0rH9uXDqul83lMUwVvrzKgRg3LFrGBqg0GKVLx2isApq
	 /fdNTa8lpu6kpYkG3MuAC3bWxtwMxWNAE+wBjuvCaim24iiuL8Q+UZUSNEKFtoa6rR
	 S5miMplwtmLTMV2Gy5fSTnBgc0wAF7Ql/d3KDtcKw82cmGf2T931jf50IPdZYizzXl
	 Pj2t/1PPhrWIjRYjwfuXfNEHWqdLSMgGFoDs9w5yL05663Rgzon2OZfd/r7qUyjcBB
	 kaRI0W3uOoeRg==
Date: Sat, 08 Aug 2026 20:49:11 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: manizada <manizada@pm.me>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net v2] net: tun: bound receive headroom
Message-ID: <i1iqF8lnn-l74SDP8wgrfjVHVaCGXclTI1vgMTfh60WpzUIeJoc5bhsXoOxsbtH0XgzX0FuSpYTweIS1pe1omkMGE_NIj1LjBB8enWdp2Qg=@pm.me>
In-Reply-To: <20260806142236.2353282-1-kuba@kernel.org>
References: <20260805084504.953162-1-manizada@pm.me> <20260806142236.2353282-1-kuba@kernel.org>
Feedback-ID: 37265593:user:proton
X-Pm-Message-ID: 827c1920182034b41497cd7cc3a7f140fd757e55
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Thursday, August 6th, 2026 at 7:22 AM, Jakub Kicinski <kuba@kernel.org> =
wrote:

> This is an AI-generated review of your patch. The human sending this
> email says "This is what the bots think :)"
> ---
> net: tun: bound receive headroom
>=20
> This patch clamps the headroom that tun_set_headroom() stores in tun->ali=
gn
> so that SKB_MAX_HEAD(align) in tun_get_user() cannot underflow, and it ad=
ds
> pskb_may_pull() calls before reading the raw-TUN first byte and the TAP
> Ethernet header.
>=20
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index fed9dfdfcc3bc..efd2e7d75c9ac 100644
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
>=20
> [Severity: Low]
> Is the upper bound intentionally this tight?  At the clamp maximum,
> tun_get_user() computes:
>=20
> =09good_linear =3D SKB_MAX_HEAD(align);
>=20
> which evaluates to 1 for raw TUN and ETH_HLEN for TAP.  The non-zerocopy
> path then does:
>=20
> =09copylen =3D len;
> =09linear =3D min(hdr_len, good_linear);
>=20
> so the resulting skb has skb_headlen() of 1 (or 14) bytes.
>=20
> Does that make every write() carrying a virtio_net_hdr with
> VIRTIO_NET_HDR_F_NEEDS_CSUM or a GSO type fail?

I don't really follow this; not for the linear-area reason described. The
virtio-header conversion calls pskb_may_pull() for the required checksum
or GSO headers before skb_partial_csum_set(). The requested pull length
includes the checksum field, so after a successful pull csum_end is within
skb_headlen(). The one-byte and ETH_HLEN values are only the minimum
prefix initially kept linear.

In configs where the 16-bit (vs the one-page) offset limit controls the
cap, an extreme max-headroom request can still leave too little room for
a non-zero checksum-start offset to fit. But that is rejected safely and
is a whole other topic.

> The chain
> tun_vnet_hdr_tnl_to_skb() -> virtio_net_hdr_to_skb() ends in
> skb_partial_csum_set(), which requires the csum offsets to live inside th=
e
> linear area:
>=20
> net/core/skbuff.c:skb_partial_csum_set() {
> =09...
> =09if (unlikely(csum_start >=3D U16_MAX || csum_end > skb_headlen(skb))) =
{
> =09=09net_warn_ratelimited("bad partial csum: ...");
> =09=09return false;
> =09}
> =09...
> }
>=20
> With a 1-byte or 14-byte headlen that check always fails, so tun_get_user=
()
> takes the err =3D -EINVAL path, bumps rx_frame_errors and drops the frame=
 for
> all checksum-offloaded and GSO traffic while the headroom request is in
> effect.
>=20
> Note that for IFF_TUN, tun_can_build_skb() returns false, so the raw-TUN
> path always goes through tun_alloc_skb() and always sees good_linear =3D=
=3D 1 at
> the bound.  tun_alloc_skb() only overrides linear when prepad + len <
> PAGE_SIZE, which is not the case for non-trivial packets at this prepad.
>=20
> Would reserving a usable linear area instead (for example GOODCOPY_LEN, o=
r
> the maximum hdr_len the device can accept) give the same memory-safety
> guarantee without turning offloaded traffic into drops?  For a Cc: stable
> patch, could the commit message also mention this consequence?  Right now=
 it
> only says:
>=20
>   "Leave one linear byte for raw TUN and a complete Ethernet header for T=
AP,
>    including NET_IP_ALIGN."
>=20
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
>=20
> [Severity: Low]
> Should this path set drop_reason too?

I'll just do what Willem suggested in v3 instead:

=09if (!pskb_may_pull(skb, 1)) {
=09=09err =3D -EINVAL;
=09=09goto drop;
=09}

=09ip_version =3D skb->data[0] >> 4;

So there'd be no skb->len check, so pull failure can also mean
that the packet contains no first byte, at which point SKB_DROP_REASON_NOME=
M
wouldn't make sense either. So I think it's best not to set it?

> It jumps to drop without touching
> drop_reason, so the free_skb label in tun_get_user() reports the initial
> SKB_DROP_REASON_NOT_SPECIFIED:
>=20
> drivers/net/tun.c:tun_get_user() {
> =09...
> free_skb:
> =09if (!IS_ERR_OR_NULL(skb))
> =09=09kfree_skb_reason(skb, drop_reason);
> =09...
> }
>=20
> Since the call is guarded by skb->len, pskb_may_pull(skb, 1) can only fai=
l
> via the GFP_ATOMIC allocation inside __pskb_pull_tail()/pskb_expand_head(=
),
> so SKB_DROP_REASON_NOMEM looks like the accurate value here.
>=20
> The IFF_TAP arm changed by the same hunk does set an explicit reason for =
its
> pull failure, so the two adjacent sites in the same switch end up reporti=
ng
> different things to the kfree_skb_reason() tracepoint.
>=20
> > +=09=09=09ip_version =3D skb->len ? (skb->data[0] >> 4) : 0;
> >
> >  =09=09=09switch (ip_version) {
> >  =09=09=09case 4:
>=20
> [ ... ]
>=20
> > @@ -1842,7 +1853,7 @@ static ssize_t tun_get_user(struct tun_struct *tu=
n, struct tun_file *tfile,
> >  =09=09skb->dev =3D tun->dev;
> >  =09=09break;
> >  =09case IFF_TAP:
> > -=09=09if (frags && !pskb_may_pull(skb, ETH_HLEN)) {
> > +=09=09if (!pskb_may_pull(skb, ETH_HLEN)) {
> >  =09=09=09err =3D -ENOMEM;
> >  =09=09=09drop_reason =3D SKB_DROP_REASON_HDR_TRUNC;
> >  =09=09=09goto drop;
> --
> pw-bot: cr
> 
