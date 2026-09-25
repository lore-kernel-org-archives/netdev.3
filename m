Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25268322C73;
	Fri, 25 Sep 2026 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354242; cv=none; b=LNpKK6yc8jmEq7UR6p2UBEb2MHfQRO5pUCnBKKOjCOP6ccorWsXTEfQfBdraPqx4rfct568XFynLFR926JqbJPT0l0XEnY81aXGrDBhn720bAdyBO3dRZMOHAS8m/YLjQq9mu6+JQZyZgIHnMWtIl8VlhWrg806E4idIFC18Lnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354242; c=relaxed/simple;
	bh=Jg50N8Q9Cm7OCREL7u7EAp/IFB6oDWc0U8Wsu77nV58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfWy3kdbl3EqculFbVaBgc8DqpoPPd+Ha6IQ4teB4urn1ku3On5Smbn6m0DsRrncNSZ8EO7bho4YCOrjYjJ3F7aA2gCMkRadyrlV8NiMWBfqE9c68VavJuYP50a3bFZ+Wj9ghdjPAa+y+DWkoFT+/Da4yaVFEY1XBgdDZ5k0fiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/yPlYrt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/yPlYrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0651F000FF;
	Fri, 25 Sep 2026 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790354240;
	bh=Jg50N8Q9Cm7OCREL7u7EAp/IFB6oDWc0U8Wsu77nV58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G/yPlYrtGx2x103ezpTDBH8WS/RYQB5howfAxsr5p8OZBq3XRgPYKABPGH3sk4I9e
	 sIUHcuKf0hgMvUY8Q1UrVbrpu+rTuClFlVI1qONB84Mye4d5urs8ZDiMKEkeCLk7Na
	 qgOiZpk7hUcAPI6PjDsJBFm7tpdWB/mpCDmpmjCo+AkimRmZMJdxMTfZsTBarRDTxq
	 u6cGP9/9/pIqdvnqxVCn0vYGlgOjsCLGsufoqFtBbfBckhE5LRzGh9DhRbBCzbOGM6
	 yzL0oOlVrNx1TTeUjPf/FK79nebl13WrjL3cnwDgU9VlFRPzyI4WAhQ63iDaAIHu5Y
	 7Bvbxz7kLXoEg==
Date: Fri, 25 Sep 2026 17:37:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: ethernet-phy: add
 needs-host-firmware
Message-ID: <20260925-dipping-moody-d20fa0d1152e@spud>
References: <20260925001209.2334139-1-f@lex.la>
 <20260925001209.2334139-2-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2jR+fEFaZ1freKib"
Content-Disposition: inline
In-Reply-To: <20260925001209.2334139-2-f@lex.la>

--2jR+fEFaZ1freKib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--2jR+fEFaZ1freKib
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarajOwAKCRB4tDGHoIJi
0lhzAQDRHpWRTrTuf9mAme7kt4gLYZE4TVZALqtRHRO1WeIrZwEAprk4hPH3WzPG
pqN8P8GzlfGhpE5iTRnBLNd46hMkXwo=
=sXmu
-----END PGP SIGNATURE-----

--2jR+fEFaZ1freKib--
