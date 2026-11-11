Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439151;
	b=O11v9QLnX3bT5C0L5P4PEUtiklPYAun9kn4AlWU06R88dkXUjUOs95ZcBKZlpBul1vlw
	 GQYumOAZNZIWYdC/QlGLYPZdv9QkOPWR4yBE/7iw7XHqLqgX6fQGPyz1YSpwSoX3Hwn17
	 e0Y9gAAkcSsX6GPigPqcinYg595u/S96XMUMud61UxRz1q+MJJLKLm0W04J83TBsZukJW
	 FuAyNqLI1etBXuZTiAD5cmsdRo33eCES9kS+XaZzA75PYANRznNL6hdNG4vIpGEGRoc2n
	 BybOMw8g2meHcYfZ3gf7QrdrG4atoQ/kUEjesisHuDsTWnXxtoLtlj61QiiVFjZqTvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439151;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mRvFwWptZxyVydMUFNMiU3ZLZ+/+jyea3auxUAzVqwU=;
	b=yUl1wTxAcoCzk31JdUnLZEZ7oKAFtAERWLlLqSEempM4o0xtZLkmX0o7VIJRQJM5NZ+w
	 cXI5MnaWrQXD65AY9i4dlCwnt3oA8wY0EStV5RmUaSqiS7830NcUatxReoWZxn2Wbvn3r
	 Vr+eF8VrETv+5qMX0McTln6uSryQd8czUglfYC5al3WjxKlUn+wYPpAAmHnL48YI4U03D
	 l5250FFQwjnuXTnzSRy6oHUqJGcleM2OvC/mN7cKjWH7pGg2g0TMrzX3bndHPUIKX8bm7
	 XaNuPeSTp929ZDWncGI6TvTeCbBin7ZY8UBiwaK1Gq87s2bw3o8ED3lO0blZyMDC+Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mBCRjWsv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE729606A31C;
	Wed, 11 Nov 2026 23:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mBCRjWsv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DE91F00A05;
	Wed, 11 Nov 2026 23:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439151;
	bh=mRvFwWptZxyVydMUFNMiU3ZLZ+/+jyea3auxUAzVqwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mBCRjWsvwQ5lATAIOcjS0ATQSM0ld1ro9t9JxkoNO4iCsyS2aUmsU1S711MG/LfKS
	 /WpaX6DPdYWDy/WyED/x7Kh5vl4XgCgJbHzYZhyALzhWi7Bq4cj1bCfY0ILqyGdcRl
	 spUbw3WbU0kKqGkNSQ8Lsl9UyeoWIPkvE6uRNAdOpjSaQdgAbfig1v/iRydNbSIKmR
	 CrkRIZ1+3bVgLWRFeEqCoFp7DIqLZ1q5ehfPRsbZRms2mU5P9CkAK7QyzFKuF6ig5P
	 RAxQQV0w94Hn9ZaWwey/0xBmaeIBAiyCxA6GXsSwH2d/yw1PAxsfsYFZ6r7eMt64ox
	 CYTjNb1Hq3kug==
Date: Wed, 11 Nov 2026 15:19:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: motorcomm: Do not inherit ports from
 dynamic FDB entries
Message-ID: <20261111151910.0979b8cf@kernel.org>
In-Reply-To: <CAAXyoMP5hQC8Jgg9LgY-X59ftAGThOMXVf3jTCmRzUPjvC+Qrg@mail.gmail.com>
References: <20261109153407.1761032-1-mmyangfl@gmail.com>
	<179441151084.2199510.11035302452325241587@kernel.org>
	<CAAXyoMP5hQC8Jgg9LgY-X59ftAGThOMXVf3jTCmRzUPjvC+Qrg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Nov 2026 00:44:53 +0800 David Yang wrote:
> On Wed, Nov 11, 2026 at 11:38=E2=80=AFPM <netdev-bot+sashiko@kernel.org> =
wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [High] This patch replaces the egress port mask in yt921x_fdb_join()
> >   (drivers/net/dsa/motorcomm/chip.c) only when the existing hardware=E2=
=80=A6 =20
>=20
> Looks like a pre-existing issue.

I think AI is saying that the fix will be in the same place, tho, so we
may be better off fixing them both in the same series. Please try, if AI
keeps finding more and more issues we can cut it off, but not at v1.
