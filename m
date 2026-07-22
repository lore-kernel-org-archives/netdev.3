Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9A641CB54
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784755535; cv=none; b=rkZlYacZTWvsMg32muJtylip1TIqVjrd9lgKGgQ8lkv4ESSYCOhrswjmcJ4Hiu+rk3ZbpaieCW1GR4aNaJ2hgmyI3yRnRJ+wxabDZDbp6x4RzHYU4yAc1Qa7zke3ro2p5gy/UU4BegcbV8DahQ5B6FkIMl9cGzpNznFbKFagkmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784755535; c=relaxed/simple;
	bh=/7I1GhcWn5vYrJdkHm7cMsCLvRCkt+WTE6VDMxK6F7M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESAgRS04+1Qy5pwXAz718RumoXrgsYW6gBZ6vSgW0PsmVSVi112DWGAC5s/I809vNeazkVFYN6444ZuoOj5Ram9vold9QOxpaHqBrK4vkZAKzzLARgvnHq3b4EvalKhRDijRf7vQydeLChLkOal7sONxQ9Jw/vIoikR4dt+K0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=CZR6icqC; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="CZR6icqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1784755525; x=1785014725;
	bh=ieanosvVc7iyNM82vFepUjKpdwvItENOXuBT+v+95Io=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CZR6icqCKZ23n+QhmrJ0bfUTFzQKvrx5yTz0Qcy7gb9NZVrZQi68JwV2R1bPo9kR4
	 iL7u43oYp2VUD3IkMGdnx9jHq47rXQBS0aqTascT+lzG8Ey6TotpVqiE4iQXpFlO1Y
	 B4fxkvyGdvN2VBgB9wV7m1Jh3qEB1YUlyQOHstvz44zGXH26tj0EkiKX45e2nasEPk
	 iouEUQvAVRIIwbP0wvMtBg7GpArGb2WMrvDN5AvwMZytrSyuyh+dre2eMJokMKxxN4
	 fNbkXadhjyRXhAvzcCTm/OqMhIBv+nIk/Ct2+jTySvTfGAIVKexOXVGWH4lZIlaIRt
	 rRZ1Q++pQe11w==
Date: Wed, 22 Jul 2026 21:25:20 +0000
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
From: manizada <manizada@pm.me>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, daniel@iogearbox.net
Subject: Re: [PATCH net] tun: prevent underflow in rx headroom calculation
Message-ID: <RikInp28JqJzTOJH8tUelSNgYEK6pUyLDko4ddJgBQTTS93OcYU09E74E3Rnx3ssUHW8gsEmuIugKcfhu_AzTaGeJZIrqTMMF2Z7Yl1nXhA=@pm.me>
In-Reply-To: <willemdebruijn.kernel.1f0c43b9fce2d@gmail.com>
References: <20260721014117.2234892-1-manizada@pm.me> <willemdebruijn.kernel.1f0c43b9fce2d@gmail.com>
Feedback-ID: 37265593:user:proton
X-Pm-Message-ID: 6d2037f808d3c4ead076c1a02a0ee3a18089d61f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Tuesday, July 21st, 2026 at 12:59 AM, Willem de Bruijn <willemdebruijn.k=
ernel@gmail.com> wrote:

> Asim Viladi Oglu Manizada wrote:
> > tun_get_user() calculates good_linear with SKB_MAX_HEAD(align). The ali=
gn
> > value comes from ndo_set_rx_headroom() and can be larger than the linea=
r
> > space available in a one-page skb head.
> >
> > OVS can reach this case by carrying headroom from a netkit/VXLAN port t=
o a
> > TUN port. SKB_MAX_HEAD() then underflows, leaving good_linear negative.
>=20
> Separate from protecting tun from such huge headroom, which is good:
>=20
> Is cooking paths with such huge headroom itself incorrect? Should
> netkit have some reasonable upper bound on configurable headroom?
> Netkit is not the only path that can reach this, right?

Thanks for the review. Yep, oversized headroom can reach TUN/TAP without ne=
tkit via OVS/veth/VXLAN, OVS/veth/GRETAP, and bridge/veth/GRETAP/TAP (at le=
ast on stock Ubuntu 6.8). A netkit-side limit might still be good too, sepa=
rate from these other paths, for defense in depth.

>=20
> > Assigning that value to the size_t linear variable in tun_get_user()
> > converts it to a large positive value. The wrapped value is passed to
> > tun_alloc_skb(), where prepad + linear and len - linear wrap. skb->data=
 can
> > then end up past the allocated head, and later packet processing can ac=
cess
> > memory outside the skb.
> >
> > Clamp good_linear to zero when SKB_MAX_HEAD() returns a negative value.
> > This lets tun_alloc_skb() allocate the requested headroom and place the
> > packet data linearly or in fragments without wrapping.
> >
> > Fixes: eaea34b23c46 ("net/tun: implement ndo_set_rx_headroom")
> > Cc: stable@vger.kernel.org
> > Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
> > Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
>=20
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
