Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68250175A8D
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666919; cv=none; b=NMwBjg3RCSp2bvwLA3MtsAwejWrmbuwICIgB1yRT7NiRhyd3/2X5B73ku7l1RM+Yi8P7N7R0pb7l2o3IwOSKTaxcirPFTeImj7znOFdUcT7iGkW50RjZc7ZPEKRWF2XWs9azETKM0/d3GyzWzvSliUsOq720RVsJQla9A5Rfykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666919; c=relaxed/simple;
	bh=mKrHoQIcdBs4zvYbSqGq2WENhC/ESFou9mdv3o19g6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hg9OTNjYZCIIa2Elw4IRwk79vHDLVM2c98/LVNw2ziW27JKXq/7QYIIDHeqAwFutuwAQ8HR4bSFR2A+GNSK2GZKEwEPOT2/lxrIIAgrMyJ7a8BRsDXOdgWOR/h4Gl6DFEFVdVJ/oK2Zi7l9km2MWkxbqPgbiDUzwTmUILxDYjsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFf6wNbI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFf6wNbI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB151F000E9;
	Fri, 14 Aug 2026 00:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786666918;
	bh=BTbUb3MX/t95fArHVnY9sL9y9W4mR5L77BDPM1oB7qQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lFf6wNbIA/mnWUXJe1uFMLtsfn4y468vV0gNvVxUpMCSEGA8fHpTo6txg1pamW6ry
	 b9HPp+slKWH+Z5KjcerTk1o5WOX0NqWhvsTtB1HYxFV2+bLTmjxWILX53YV5etkJm8
	 vA2KPQwTj5TPDteIuY7PWWwxDOFIUJq2ZUGUUbw172YVxXzhsLrFRfQtHeylQMuBoe
	 U4BNYfhuyYYCjbzgzal6NktxNcWYtEZ5sQl+acgvhqno2t5YtDki7jE2HzOXWouzMC
	 HcQ1R10LRncJKDLDcWmVpdAX4ihrWabBwsmI8VPeyoIJYM/TzXs+t+inKH/I6GTy4s
	 vqn/OguKOFv4Q==
Date: Thu, 13 Aug 2026 17:21:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2] net: stmmac: improve TSO/GSO queue
 selection
Message-ID: <20260813172156.0243cb7a@kernel.org>
In-Reply-To: <an4qzUrK62-rN7Q6@lore-qca>
References: <20260808-stmmac_select_queue-tso-fix-v2-1-67175b29772e@oss.qualcomm.com>
	<anybM_3Rdg8X8CMs@lore-qca>
	<20260812161038.5602eac9@kernel.org>
	<an4qzUrK62-rN7Q6@lore-qca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Aug 2026 22:36:29 +0200 Lorenzo Bianconi wrote:
> On Aug 12, Jakub Kicinski wrote:
> > On Wed, 12 Aug 2026 18:11:31 +0200 Lorenzo Bianconi wrote: =20
> > > please drop this version, I will post v3 to fix some pending issues. =
=20
> >=20
> > FTR Russell was trying to fix TSO in this driver too, before giving up
> > (on us?). The direction he was following of clearing the TSO caps in
> > ndo_features_check and letting the stack GSO instead of all the weird
> > hacks this driver has seemed much more sane. But maybe I'm missing
> > something TBS specific here  =20
>=20
> thx for the pointers. I reviewed Russell's commits and I guess we have two
> options here:
>=20
> - manages all the TSO/GSO checks in ndo_features_check() (stmmac_features=
_check())
>   and disable TSO/GSO if the selected queue does not support checksum off=
load
>   or it has TBS enabled. In this case I guess we can drop ndo_select_queu=
e()
>   callback completely (it does not make sense to me to always use queue 0=
 for
>   TSO/GSO packets, e.g. it does not allow proper mqprio offload).
>   Please note this approach would introduce some performance regressions =
with
>   respect of the previous implementation.
> - implements TSO/GSO checks in ndo_select_queue() callback
>   (stmmac_select_queue()) in order to keep TSO/GSO enabled if the selected
>   queue supports it and at the same time do not always use queue 0 for TS=
O/GSO
>   packets (proper qdisc offload). Please note this is patch I am proposin=
g.
>=20
> What do you think?

I don't know this driver, or how it's used.

=46rom the commit message it sounds like "if the packet wants TSO and=20
the queue has a scheduler enabled - take the packet to another queue".
Presumably you know why the TBS is enabled and whether the packet
should or should not be going to that queue in the first place if
you're sending the patch? What is the use case?
