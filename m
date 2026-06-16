Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD871EB5C2;
	Tue, 16 Jun 2026 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570266; cv=none; b=iLApII3Z/3Y96DD/NnThz7MdE0Aqk02fVu0jjWtk20cVPL/4SZOOW2Iz2wjUxlHAR1KNlXrfPyd55Cl1SKGv9f57Bg7/n7tvAvHbZTqUyufL41rUdU8MGYb2ICKaVaKVlAj1w7LuWcfwhtdCGbEM0gZe1cH7Xt6evM/ePoHKgPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570266; c=relaxed/simple;
	bh=9EMtu70oTR2wsRqKysTB+4EMHVklEHtZJ5SYzUkSO2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMmhVmvnNte1MExqEHGVGxsk+/C2554Us7AH1VUDEn7P48BjW9hD2JA/g74PU/1c3vbF5PFLbW4fv17dFaGnuhmDQOyrgDAYT5nTL6Bw9B+cXPVh6P7AP21yuFKxqf65BlbEmnjqWmqR/twQT1IV9+7z6orMwFuuN+39K1wntUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8ou0ujC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8ou0ujC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6BD1F000E9;
	Tue, 16 Jun 2026 00:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570264;
	bh=8WZ/kWvcwXjo8nkM/deXKzl0tF137AbhFnIn3jjSTiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N8ou0ujChG8gDSo9JRndRK03MV9ygaMcb2iSXTSVe0RSzv2aKVT+MpEQ2ZROP7rBf
	 bMP5b66NUiCfbQ6F8b9Ltrj+k22BvYR8wY9T5hj7d5vgj4i/N7KV5K85hA4qd6J+gA
	 yXZ8hCHd4wAmJS7o1IHtGdhM/Ho4M5qBv8Vci+n5RqrbMR14pIibkezy7AXBHUFDft
	 kIDLLLf8kA5rNW52kia+N+Ts7wiKg9nui1YBe7ZvxIU+cbko4xQd+OvqcGs1lCXj+t
	 WinBT0Dq0eo+c7TGFWBhFuyR9alQwuyVPzDlshPONom2q093GNfKG57taAC29Oz8l9
	 t/US8CvKAP7bQ==
From: Jakub Kicinski <kuba@kernel.org>
To: markus.stockhausen@gmx.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/8] net: mdio: realtek-rtl9300: Add polling documentation
Date: Mon, 15 Jun 2026 17:37:42 -0700
Message-ID: <20260616003742.1104659-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613112946.1071411-3-markus.stockhausen@gmx.de>
References: <20260613112946.1071411-3-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: mdio: realtek-rtl9300: Add polling documentation

This commit adds a comment block to the rtl9300 MDIO driver describing
how the Realtek Otto switches' hardware polling unit interacts with the
MDIO bus and what this implies for kernel-initiated PHY accesses.

> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index 892ed3780a65..da2864c94d2c 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
> @@ -35,6 +35,72 @@

[ ... ]

> + *	phy_read(phy, 5);		phy_read(phy, 14);
> + *	phy_read(phy, 6);
> + *
> + * The c22 over c45 register 13/14 sequences read MDIO_AN_EEE_ADV and MDIO_AN_EEE_LPABLE. As soon
> + * as one PHY status is read, the polling engine goes over to the next PHY. Basically the bus is
> + * always busy and the MAC status is updated in realtime.

[ ... ]

> + * - A c45 over c22 kernel access sequence is most likely to fail because chances are high that
> + *   the polling engine overwrites registers 13/14 in between.

[Low]
The two paragraphs above describe the same mechanism — using Clause 22
transactions on registers 13 (MII_MMD_CTRL) and 14 (MII_MMD_DATA) to
indirectly access Clause 45 MMD registers — but use opposite wordings:
"c22 over c45" in the first paragraph and "c45 over c22" in the second.

The example writes shown earlier in the same comment (phy_write(phy, 13,
0x7); phy_write(phy, 14, 0x3c); ...) are the standard C22 indirect access
to C45 MMD registers, conventionally referred to in the kernel as
"C45 over C22".

Since the stated goal of this comment is to simplify future development
and review, would it make sense to use the same phrasing in both places
(for instance "C45 over C22" in both)?
