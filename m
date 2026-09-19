Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FBB3254BD;
	Sat, 19 Sep 2026 00:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778910; cv=none; b=ED1xYbYQelbbSHE3zCeAuC1eqaJF2GlVFpLlaRx7MUgTo/1FvoY44dmO3cZYh3uHJSffCU5H6SBASJ7Oz9M1Flme8MIPVHqU6qs9ffX4I5gYOit7DwfbphZCDkg7JLZ9PhOo4bRaSTj9UbvP6ZMalKXXh/KO2vF0QrBkDcZlNpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778910; c=relaxed/simple;
	bh=MCbmQ6WJDGdCzQN4mYg04ADyk1fF1OC+DJiGEgxhAdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abeqpBpkOJJLyVA8cOPSPhQEFRGrtCTbFPDLD3stXiZgyLMZnHq8+FuvYo7s9sypLCVnDyLLZgmdeOMsM+c56rc47jjZ9CEod7FiXcL5Tl4PIHKrGzA6igfzRCVvQRfsHJAcJ2dzAxUy//XKggZ0KctfGwDZEn6EhfiPqPr8UME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUw5HGvE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUw5HGvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB8D1F000FF;
	Sat, 19 Sep 2026 00:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778898;
	bh=MCbmQ6WJDGdCzQN4mYg04ADyk1fF1OC+DJiGEgxhAdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RUw5HGvE4NOuabChT6omhbwuPsmkFw8sBJTVrHIa3igoep+FaodwCNFN3Qzj+gYie
	 DtsRevJzMoPULHVcNHKA8n7W29O1tlxdkmxxX0mCI7ExijWvKuBiUI3YrrAmhYxFAW
	 CuBYZknAPhdL2q3gYT27jA+wMGqXK1YyavBKEWrJI0bfn6DNZ+GcF9Sg7wuGlugTwD
	 S+IykXDZNXW8RKtdTumDSVr1meeQjJTWgIOCYSEuDCfB9duWGZtaWagVpNGLnW7ASn
	 XhB2fYu2ItAwUo7gZJT0uPf2WMvBi9ZiH7/lOVq2C3tO2umtpz/GyK1Qjhq1cYMiyk
	 OWqmT/Ai/7Hag==
Date: Fri, 18 Sep 2026 17:48:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, marex@denx.de,
 horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v15 2/4] net: dsa: tag_ks8995: Add the KS8995
 tag handling
Message-ID: <20260918174816.0d77d5dd@kernel.org>
In-Reply-To: <CAD++jLm7UQGiS9C=HnAUGOmnjA0AvjLc_qOUTRCK0PeRsVn0JA@mail.gmail.com>
References: <20260916-ks8995-to-ksz8-v15-2-8825ff5fd4be@kernel.org>
	<178965134740.22033.13313484925246996796@kernel.org>
	<CAD++jLm7UQGiS9C=HnAUGOmnjA0AvjLc_qOUTRCK0PeRsVn0JA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Sep 2026 23:18:42 +0200 Linus Walleij wrote:
> On Thu, Sep 17, 2026 at 3:22=E2=80=AFPM <netdev-bot+sashiko@kernel.org> w=
rote:
>=20
> > Two details worth noting: this only happens with a conduit MAC that str=
ips
> > the non-standard 0x810X TPID into metadata while preserving the port bi=
ts,
> > which was not demonstrated here, and the same OUT_BAD outcome already
> > applies to other VLAN-metadata DSA taggers such as the tag_8021q family,
> > where proto becomes ETH_P_XDSA and also has no case in the switch. Shou=
ld
> > the receive path here rely only on the in-band tag, or is degraded hash=
ing
> > on the conduit acceptable for this configuration? =20
>=20
> This is just getting too fringe. What about we merge this and look into t=
his
> when we have a user who actually want to do these things on this
> old chip?
>=20
> I don't think this is a blocker.

Yes, sorry, I need to modify the emails to call it out more clearly.
We only really care about issues >=3DMedium severity, but if there are
any such issues found we send out the low ones too just in case.
