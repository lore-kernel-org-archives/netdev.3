Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE3C358367;
	Mon, 13 Apr 2026 22:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120479; cv=none; b=dQgtMnaMfoTHzRxnSPT7q+iilt8IroAZATBZj4jJfuNJK/HH5bOOSGP0YJ2fsxGQOBUQgVMmac/3XmMufPZws09dLVvGfCMjKpGzL6beoKCoWIebnoiFQ7i14Wqi7lHgC57h4wGO2y+8ezCXsBTfwbCoCqkAp31k8hF+DEihY58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120479; c=relaxed/simple;
	bh=2+wOj3KwAwOXM9QmiaHJSXR4Smqg06+muZsDtxlLq7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTBTsMtEcnGkJb3heDn5RYubwNJYK009fGZdKQlw0kRio2A9YU7rBzTXcYavTt8pJE1F6kGGrsQ09K2jC0Ol0+oF7Ckp+qdzJAQtr4UqbtukrIywpFN2WhC/W0CGY+q1coF9ziVrI+g3absxJUR61jHVryL+GQK2IOJ8PEs+0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfKjqXJu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfKjqXJu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6616BC2BCAF;
	Mon, 13 Apr 2026 22:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776120479;
	bh=2+wOj3KwAwOXM9QmiaHJSXR4Smqg06+muZsDtxlLq7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dfKjqXJuL96tvYguGP0YPbaIXxACsgP9/cZdRRL32N0bBYK616oXCmO/nExmmP4mU
	 e2Rqj4DIf/qmMR87Spo8if82eo9tIFliNuEvwU7CoYrkuCvRVge1MbcutqlUtZl+60
	 czn2UlogWBiMQayaMeS7JQk1i/by6ZsL/IIH1SheQdkVyjZ/NiaQlg2w+cEq5Qm0Zm
	 +BBAjhdR/yyNcQjZpMVJgwxQiIku6/jQ3697Nk/GuWvWA/nFKc54awJx0NB6iDLodK
	 qcALHsF88CZcIErZFtwzqmvbxnhs6h8sECGJktzRIkGdXyT1z2gA1gv8CoqvjgU15m
	 9ytP1QA0Uw7Cw==
Date: Mon, 13 Apr 2026 15:47:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jens Emil Schulz =?UTF-8?B?w5hzdGVyZ2FhcmQ=?=
 <jensemil.schulzostergaard@microchip.com>
Cc: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung
 Huh <woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v3 0/9] net: dsa: add DSA support for the
 LAN9645x switch chip family
Message-ID: <20260413154752.479e02fe@kernel.org>
In-Reply-To: <20260410-dsa_lan9645x_switch_driver_base-v3-0-aadc8595306d@microchip.com>
References: <20260410-dsa_lan9645x_switch_driver_base-v3-0-aadc8595306d@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Apr 2026 13:48:36 +0200 Jens Emil Schulz =C3=98stergaard wrote:
> This series provides the Microchip LAN9645X Switch driver.
>=20
> The LAN9645x is a family of chips with ethernet switch functionality and
> multiple peripheral functions. The switch delivers up to 9 ethernet
> ports and 12 Gbps switching bandwidth.
>=20
> The switch chip has 5 integrated copper PHYs, support for 2x RGMII
> interfaces, 2x SGMII and one QSGMII interface.
>=20
> The switch chip is from the same design architecture family as ocelot
> and lan966x, and the driver reflects this similarity. However, LAN9645x
> does not have an internal CPU in any package, and must be driven
> externally. For register IO it supports interfaces such as SPI, I2C and
> MDIO.

We're wrapping up the 7.1 PR and doesn't look like Vladimir (or any
other DSA expert) had a chance to review this yet, so let's defer to
the next cycle.
--=20
pw-bot: defer
