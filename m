Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FACA2C21F4;
	Thu, 10 Sep 2026 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002023; cv=none; b=l8Bjghe1HXbZx5EdjmlOidrEjQKtoE4LwmzK2hR96NDHFp0ipRsmr2h7qwdo6MTOzgFBpyLJl+J6MDP3WYhHfG9HPoKgBQEDvEZuuM8r/MFtIql4XEkPIU3hxQs1QdgfJ4oqsVI6ocL6DDhjYgzrXp4oEydjG31dcpt9ZM1CLg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002023; c=relaxed/simple;
	bh=kz2eJccjwxntQiTpBGdg6QwXDyo2uOIHcMPMV9Fo3P4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dI7HNMCg61HZdhpf25WHL/a1zPKICfsfYpQHrIuglJYCf4ViPMYl+dDdw/1EHRH2G69N0UtKsMO8LUd7u50SMmvRK2ISiptarWxbtXvl4JIEZPG9B50ECFNRg+/IgGs1F/1wuBD3s8/htzi/pnXBTwHttVf04qHF6sMpQK4Qrt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mest1+yn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mest1+yn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7491F00898;
	Thu, 10 Sep 2026 01:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002021;
	bh=kz2eJccjwxntQiTpBGdg6QwXDyo2uOIHcMPMV9Fo3P4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Mest1+yn1zit2wSv3yM+CkN6ZcvUmjdGdU1t+fA/GVxN8t49dT+a5m9N8ApW4hsWV
	 fH43mf8ARJs7vdK8/DQxx5UEkbilmTP3bSDHIo+XDIk0NALdW9E7skuSXMIOI7W0vt
	 F3ONUlKgI9a+X4aDYzEHVatgw9/cbC/sKI4VGp0bQXrDwlOdwrq6iIfHXsHWaKxcBW
	 KffEuGKPdL0I0B05U973n8AQnzzVj2yygq346ruu2DubTdBbankfSRTDfRoMvcXW5E
	 PPOxxWbQxxGee9xCDOTjr8HQI8AMabi5nfDGULAsF17wf+lHUAiFgHMwuE5IuTB3nL
	 BgSEhetKy6ENg==
Date: Wed, 9 Sep 2026 18:00:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jan Havran <havran.jan@email.cz>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Hauke Mehrtens
 <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Daniel
 Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: dsa: lantiq_gswip: fix
 GSWIP_MDIO_PHY_FCONTX_EN value
Message-ID: <20260909180020.395488f2@kernel.org>
In-Reply-To: <aqHE37RDmQNlA35W@arch-zen.localdomain>
References: <20260907134818.16670-1-havran.jan@email.cz>
	<20260907134818.16670-4-havran.jan@email.cz>
	<b7d56704-2aed-464f-8295-2ad70e4afa2c@bootlin.com>
	<20260908174322.61223934@kernel.org>
	<aqHE37RDmQNlA35W@arch-zen.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Sep 2026 22:43:11 +0200 Jan Havran wrote:
> V=C2=A0Tue, Sep 08, 2026 at 05:43:22PM -0700,=C2=A0Jakub Kicinski napsal(=
a):
> > Other than this last patch the series reads like net-next material=20
> > to me TBH. New board enablement. Is that fair?
> >=20
> > No need to repost either way.
> >=20
> > And thanks for quick reviews! =20
>=20
> Hi Jakub,
> it makes sense to me. If there is no other board using different speed th=
an the one
> defined by the straps and also there is no other board running it at 2.5G=
 speed,
> then yes, it is new board enablement.
>=20
> Sorry for the trouble. I had not thought about looking at it from this pe=
rspective.

No worries, thanks for a quick response!
