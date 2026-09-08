Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C43B3BFE
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788910490; cv=none; b=bLIIUcTD5PLbzlOA3dwgVveXIx/mnqLYAMxGwPFYqUP9gl1QIwX2GysHH1flcZCBh9t3yEbqVZdTAtLACCChYEpYZANX487RgHLQ/AbwFyJlyGmSG72AjdNfv1wBsqtZQwSy3Z1jiGiQYXOfJWz2pBK/ATMr785JS8QQTvHq5bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788910490; c=relaxed/simple;
	bh=JsLv+5+ZVE4pNfmj3NUmIqefBL9XKKZNgBlftJBE++w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEZZ+go0z8BI7y8f7Sj1MnrF27SinFGktfbu0ytkT6gf5gzV56lSeqMlc+qU2NpDMIId8K2aP6BEZ/eUGkSrtmVxsWY1JwNvLjkdNz4pLRppmiVS9Wva60gcyOj4rqVw2jzjEpM+pcnLoplf1d07fTEB1GH7o2TGXRKcZGaCE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYZ1ZEVY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYZ1ZEVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F001F00A3A;
	Tue,  8 Sep 2026 23:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788910488;
	bh=JsLv+5+ZVE4pNfmj3NUmIqefBL9XKKZNgBlftJBE++w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VYZ1ZEVYzUWL4GSc6mS+lQwQXfrd2r0JL/JzMOX43FyYWMRtzgA2AGCy5yOa7LlAl
	 IMmkKuf/OFhvOlZiypBtSCgKEVtEe3MaaxLbOzzqJD+Os6kMj9YUAyklrreoJpRgYA
	 t3vphR4SC8cLT+ZkJXh5QrjBPm1ZFBgX2k9sg8EBftRbee7GydxHvC4n9yL7h8VOVx
	 mdhzAmVzvQdSTIFUHpQnTr09/lGhhc9YUYvx6EniNEXjITn55v2gXbvAe5mN9reIPT
	 AYDwon3dBQnHAQ2qwPC2iDhuuzTPcbHGfGZrlyezhYWVhniOo0l64it+vLgxQUzBUz
	 ucKtw49T3jgLg==
Date: Tue, 8 Sep 2026 16:34:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: edumazet@google.com, netdev@vger.kernel.org, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, Willem de
 Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v8 1/6] net: rtnetlink: add
 pacing_offload_horizon attribute to net_device
Message-ID: <20260908163447.68d64e2d@kernel.org>
In-Reply-To: <CAF=yD-J1puTzDQUaMAsTCuCm4dYYgOzYO7S3WV6rA_pWVLKRUQ@mail.gmail.com>
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
	<20260902181747.2483351-2-willemdebruijn.kernel@gmail.com>
	<20260904160106.08acccb5@kernel.org>
	<willemdebruijn.kernel.173115664f973@gmail.com>
	<20260907161258.2b0b421d@kernel.org>
	<willemdebruijn.kernel.19b10eb6885cf@gmail.com>
	<CAF=yD-JSieHiaWVD9OWnFNiDaM2Y9r52S5cn=aFYYXT=DT0wmQ@mail.gmail.com>
	<20260908144819.16313dd9@kernel.org>
	<CAF=yD-J1puTzDQUaMAsTCuCm4dYYgOzYO7S3WV6rA_pWVLKRUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Sep 2026 18:39:20 -0400 Willem de Bruijn wrote:
> On Tue, Sep 8, 2026 at 5:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > It's just a way of avoiding netdev_features_t becoming larger than 64b.
> > At the uAPI level we have a bitmap so we can express any number of bits.
> > But in the kernel dev->features is u64 / ull so if we run out of bits
> > the refactor will be rather painful.
> >
> > Is it really that much worse to add the support for "high feature bits"
> > which don't go thru netdev_features_t to ethtool, than sprinkling extra
> > one off booleans into already bloated RTM_SETLINK? Not sure. =20
>=20
> How would this work with hw_features, wanted_features, vlan_features
> and other such feature masks?
>=20
> There is potentially quite a bit of logic that needs to be duplicated
> for a secondary set of features. Or, the risk that these features end
> up not quite like normal features.

No different than a loose bit in SETLINK?

What I was wondering is - we don't want to implement full handling for
high feature bits, agreed, it doesn't seem needed today. But is it
better to add such a bit in ethtool regardless, even tho it doesn't get
any infra for propagation to uppers etc. Or is it better to start adding
one-off bits in rt-link.

Think about it some more, since the max-horizon attr is already in
rt-link I guess putting this bit in rt-link does make more sense.

> > I hate both notifiers everywhere and the idea that we have to be able
> > to quietly revoke device features "on firmware rollout". It leads to
> > unmaintainable code which almost never runs so it's buggy half of the
> > time. Whatever. =20
>=20
> I don't like it, but firmware roll-outs that remove features
> unfortunately are a real thing. Especially roll-backs.
>=20
> For pacing offload specifically, I considered the risk low enough to
> rely on the admin to manually revert the FQ settings when such an
> event happens. But the bots kept complaining. And in fairness a
> notifier based auto disable is indeed much more robust than a manual
> correlated roll-out. OTOH, it is rarely exercised code in practice and
> thus more prone to latent bugs.

TBH I'm not sure what you have in mind with the notifier.
What netdev event does the FW reset generate?=20
=20
> A simpler approach for pacing offload is to check the dev fields
> directly in fq. It is likely that that cacheline is warm.

Right, there's ~30b of unused flag space in the first cache line
of struct net_device. Should be warm.
