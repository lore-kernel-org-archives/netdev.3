Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BDC3DE450;
	Thu, 24 Sep 2026 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272955; cv=none; b=lS//b9+JUEgfoVC3QGOh92/A9u3XAKgce++eN2zQzm9wgNnx6dyfbU8ZqaaRwD7xrl2qFmmd5bxW2hhl84oTEXOQ2gCeEaryrRmzJsojRNk+Dfze+p1OhsHeFIzVIqVY5wBloWhnsVTA7Zbc1kbudXQYngr613JmraOD4Iwp05E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272955; c=relaxed/simple;
	bh=BWQmMk4P7oWQZ6selUXVbWgc3eCmQ2XDAFOZYJ0wtvY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ciBfu/Jh3n0nEA0dfPslI99wYKqrFKvGffrrZA/V4oWdIev6w3NjgZ+RJyjUYtfUBcUAlxVsArwTaGs0yap9i/EAd5bU5AWNpvFGHfDFF5qs5rZevoCuoKnZ8B9Vpj4NIAIQnV2VYsIrQn1nNXPoPnKnFds2XkFaLSM/Ty++leI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XBsI2RkD; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XBsI2RkD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1790272950; x=1790532150;
	bh=yw4Nx+apWUj5aMc01ZYswKCHC3oxA/NJaFvqqFiFb6o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XBsI2RkD3KGBSvEbYylArmUzoF9JHZb4otYJunaZVlgY02LOpi+LCIxGwHA6Py3mq
	 ObpPSU6eb93OLFugL0uCbbrPe0qJGrrCh5EVeNcgTDZI4GiAS7nw2gfptPZb4tTcss
	 w3kIlXNSOre35E635KHGZN+Ox8Sa4bNSq5o+aKBc/I56WBkJ6NiXJvy1kBOsAN//8g
	 KOJq4V8Kf7R9Ae5H2aG1qv9CGBKUrvVj0nufEFkaLz6zsIvjuJTr09OiOnxBleCkQ5
	 hgPfLoc/HT2twSBgz8CtAc6byzAvg/eVkNLWGMMqbLw8javzobmlJOm74zD8Y98m6G
	 /uaVELx1nEUVg==
Date: Thu, 24 Sep 2026 18:02:24 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: Sagar Taunk <sagartaunk@proton.me>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, Matthew Maurer <mmaurer@google.com>, Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v4] rust: net: netlink: validate attribute length before casting to `c_int`
Message-ID: <pg6AgjGkbepQeI2FIcnGmFk79uPhI0wShhVJVNbvrLkULQtO4jco6gm4xKaLiGFV9UVZBVK_h-sDlHtVip5s34SkCRyDoE47V9Zse9GsLAg=@proton.me>
In-Reply-To: <20260924104645.4764dbba@kernel.org>
References: <20260923120504.9100-1-sagartaunk@proton.me> <20260924104645.4764dbba@kernel.org>
Feedback-ID: 130121444:user:proton
X-Pm-Message-ID: 8552dff6b3f12d1f9196725532baf41082287872
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sorry, my last patch was based on the rust-next tree so I thought it was no=
t applying because I commited this on top of that so I just removed that an=
d rebased on rust-next again.=20

Am I supposed to rebase on this one?=20
`https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/`






On Thursday, September 24th, 2026 at 11:16 PM, Jakub Kicinski <kuba@kernel.=
org> wrote:

> On Wed, 23 Sep 2026 12:05:17 +0000 Sagar Taunk wrote:
> > Rebased on the upstream rust-next tree.
>=20
> I'm confused, you're tagging this for net-next but rebasing
> on rust-next. This patch does not apply for us.
> --
> pw-bot: cr
> 
