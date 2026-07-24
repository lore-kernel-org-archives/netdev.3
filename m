Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7628A36F428
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 05:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870855; cv=none; b=P+xSD5whw470m1Qdoi0h6P9c77Vj93LL0S+hz0H/+x8DT5cGL9AyyM17h+IYpVhugUxSwEc0eUT9/gLLxqd+ziBWKOh8ZCR5AisN5lSvoAanWRuKaNaAK1DWbk61r+8hnBhjk1NSvTstMOYULTAnAQ/h0psbx23+ghgYM7oooKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870855; c=relaxed/simple;
	bh=aYAHaw6pASCZgbw+wWdFHx52iHXeg8cPWkdsGpWaqEw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/DxjTjLahZAJxJCz/yI6FlmXK6tyv3CFpJpwwa/BxrnkvErKrNkPKbcFxn0ScEKsen4CTQv6DbuH7nundGDFRy4WXf2rp65qQzK+3FCk0i2J0JSZARKTIFUGBfr3jT/oVbOsA6CqMEV6OSLdagXBaogyaQpaBOaNEkhcoAJTOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=D5p0usVB; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="D5p0usVB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1784870847; x=1785130047;
	bh=bK1M74oJPuOcS9IymgqF+jlYzfxQH2PmW/bCL01gSbs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=D5p0usVBpDrRUbdtwrOhUy6WFGHUOt9KljhE/xnyq8koF7aByWKyS3+Gda7K9VMgx
	 2KDhSl7uEIceqoyQ+02wIeo/pEE6DZpN0b/0tO1H1aFFRF/ris5qcsDA/cZR2m4nB1
	 v2YNqPxu33qr9XNuqwSekqHtZZtgAI31fY6FzYbZn5fCrRPefLTb/7S0/EtKQiVP5a
	 mIMS/xB4uSBZHzC60WYaAxRSLjG65uQbifIzH+f12BlybxcTqtC3H1wRSSoA3gRXc1
	 nBdCtXoGuAULI+uWGSznF4MT/usS2KgMiHRs5tXcEs+ZuGv5E3lx7k4vfpdU0hTYck
	 roSKv4jRCsPxQ==
Date: Fri, 24 Jul 2026 05:27:21 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: manizada <manizada@pm.me>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net] tun: prevent underflow in rx headroom calculation
Message-ID: <YzGdhAUpdIBVpl5kEwszNWBTaolCS34_1OLI3kj9BiUkrxJsgcpIlsQKi2LnuvGQy76ugEGsZvZdB2Fgbmq1_QMpAel2h--RFpYe2ZIX7aE=@pm.me>
In-Reply-To: <20260723171437.784955-1-kuba@kernel.org>
References: <20260721014117.2234892-1-manizada@pm.me> <20260723171437.784955-1-kuba@kernel.org>
Feedback-ID: 37265593:user:proton
X-Pm-Message-ID: 7f188e280008dc664fcb8126cef58cdbaddeb932
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Thursday, July 23rd, 2026 at 10:14 AM, Jakub Kicinski <kuba@kernel.org> =
wrote:

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> tun: prevent underflow in rx headroom calculation
>=20
> This patch clamps good_linear to zero in tun_get_user() so that a large
> tun->align value coming from ndo_set_rx_headroom() does not cause
> SKB_MAX_HEAD(align) to underflow into a huge size_t when assigned to the
> linear variable, and later cause the skb data pointer to end up outside
> the allocated head.
>=20
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index ffbe6f13fb1f..d3be0f2d5df8 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1780,6 +1780,7 @@ static ssize_t tun_get_user(struct tun_struct *tu=
n, struct tun_file *tfile,
> >  =09}
> >
> >  =09good_linear =3D SKB_MAX_HEAD(align);
> > +=09good_linear =3D max(good_linear, 0);
>=20
> [High]
> Does this fully cover the IFF_TAP path when align is large enough that
> SKB_MAX_HEAD(align) is <=3D 0?
>=20
> With the clamp, good_linear becomes 0, and later in tun_get_user() the
> non-zerocopy path does:
>=20
>     copylen =3D len;
>     linear =3D min(hdr_len, good_linear);
>     ...
>     if (!linear)
>         linear =3D min_t(size_t, good_linear, copylen);
>     skb =3D tun_alloc_skb(tfile, align, copylen, linear, noblock);
>=20
> so linear ends up 0 and the resulting skb has skb_headlen(skb) =3D=3D 0.
>=20
> For IFF_TAP without IFF_NAPI_FRAGS the code then calls:
>=20
>     skb->protocol =3D eth_type_trans(skb, tun->dev);
>=20
> eth_type_trans() -> eth_skb_pull_mac() -> __skb_pull(skb, ETH_HLEN),
> and __skb_pull() has:
>=20
>     if (unlikely(skb->len < skb->data_len))
>         BUG();
>=20
> Since skb->len and skb->data_len both start at the packet length and
> skb->len is decremented by ETH_HLEN in the pull, would this reach the
> BUG() when a user writes to /dev/net/tun with tun->align pushed above
> the SKB_MAX_HEAD threshold via the OVS/netkit/VXLAN stacking described
> in the commit message?
>=20
> The pre-existing behavior at align =3D=3D 3776 appears to hit the same
> BUG() and align > 3776 pre-patch corrupted memory before reaching it,
> so this change is an improvement, but would forcing linear >=3D ETH_HLEN
> in the IFF_TAP path (or calling pskb_may_pull() before eth_type_trans()
> regardless of the frags flag) be needed to close the remaining panic?

Oh this is a good catch. But while making the TAP pskb_may_pull
(ETH_HLEN) check unconditional would address the eth_type_trans() case,
raw TUN with IFF_NO_PI also directly reads the first protocol byte from
skb->data, so we'd have the same issue there.

Rather than add consumer-side handling for a fully nonlinear skb state
introduced by the repair, maybe the cleanest is preventing TUN from
creating this state?

=09#define TUN_MAX_HEADROOM 512

=09tun->align =3D clamp(new_hr, NET_SKB_PAD, TUN_MAX_HEADROOM);

This fixes the original SKB_MAX_HEAD() arithmetic issue, and also preserves
linear space for both the raw-TUN protocol byte and the TAP Ethernet
header. The 512-byte value matches the existing ceiling in
ip_tunnel_adj_headroom(), so requests above the cap can require later
skb expansion instead of unsafe preallocation by TUN.

Does this sound reasonable? If so, I can post v2 using the TUN-side cap.


> --
> pw-bot: cr
> 
