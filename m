Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792552515;
	b=S5XmJc+ILkZDBFP5dMPX8MN5WgvlOfPcCu0wZI5KqhStO+7dLDxrv2yK2iYQOZAXSjO9
	 Lep+FfYNU/kfJ6nQ17UT6AA0UpeQnjSY80B7CaMyjJ0HRhnOragSFJ+5lXh7/hBeRT+uK
	 mLkqAdDazJIgbBTIIx52iitRLGmRS+qDQx4pjlOwR38SVrBHrFk4fLXTzVsCPmiTk1U6J
	 Q2oX97E7+sttjD55Qg1nHPaivbev9y379t9imjskY9/nWCmBIe9inWOhqJlzwAFMt55Vo
	 Ocr/BuaODssLLMUwVHSIngRKE5gpiFRGw6U2DduQYzBeb2H0qPV/KgeRPBy/+gPSNXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792552515;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ys8oP0bysBxyVKMvLkKGZUAWfsxvNo0pNAVuTzJHbRQ=;
	b=DGLYkKa1n8EUA/9PfqByOA5JEOpqylAB4ym3AdJQUdMdE4QqU+SqkPT/BF/W+FTge1hQ
	 wi+17OiVLBD3qkFmMGQHP1PZF7/kGrxYhy1Eb6Yql6On81/rxMfvXOURgstJTDvI8XnKx
	 7DXj0VDomBYOSZgRsmsMRCTyT67hJ9jGQL220l/UMLUpVNeLhvWbeq0X15An8bg2FsRRt
	 dgsQSYKHpDTiB81vw1GWradNg04lB7yPlZU6XZ/ahbzv85DSfvetZv+BgfLul6AwCN29X
	 kCXpn1s+rNJVLqZL0wypgc+rFo35561Ccn9Ifh+StuFsy2p9dvsckV608OfeTVWizhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evDlOaod;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54863606A31B;
	Wed, 21 Oct 2026 03:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evDlOaod
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE231F000C9;
	Wed, 21 Oct 2026 03:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792552514;
	bh=Ys8oP0bysBxyVKMvLkKGZUAWfsxvNo0pNAVuTzJHbRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=evDlOaodjI+nyT+AchLjNaMkTnceP8J1lq5zDIgnoEJnwGD5JvxB0R0lOQslv787q
	 mLHXpSvBDKXOg5D1weZZdIZGpMyc0YuoMXQCjI1uOxqtME0Fhrm75qrY6hRq3mWTXz
	 xi28526KH11XMEzGGYlJWMYL0ZujoQQkI1PdCiYdxHIYyG3MkoyTvHNIQum7oRdLst
	 xHthLbNIfEC94oQlL1L7+OZGYD0TXIp15rW7iXKoBw3Yo4f/oOmSJpbXHhsKIWzjdA
	 r+0Ww92US795seIaMClJooZENVaG8EVHY1XlTulx/X14sz0t807kEkoUqLOLZ+E6/h
	 YEwMud3Mti3Zg==
Date: Tue, 20 Oct 2026 20:15:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <clement.leger@bootlin.com>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Simon
 Horman <horms@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Russell
 King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Prabhakar
 <prabhakar.csengg+renesas@gmail.com>, Biju Das
 <biju.das.jz@bp.renesas.com>, Fabrizio Castro
 <fabrizio.castro.jz@renesas.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH net-next v3 04/13] dt-bindings: net: dsa:
 renesas,rzn1-a5psw: Disallow ports beyond port@4
Message-ID: <20261020201513.7c537f7a@kernel.org>
In-Reply-To: <20261014131906.990077-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261014131906.990077-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
	<20261014131906.990077-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 14:18:52 +0100 Prabhakar wrote:
> Restrict the A5PSW ethernet-ports node to ports 0 through 4, matching the
> hardware configuration of four external ports and one CPU/management port.
> 
> Although the schema pattern limits port nodes to port@0 through port@4,
> additionalProperties: true allows other port nodes to pass validation.
> Set additionalProperties to false and explicitly allow #address-cells
> and #size-cells so that ports beyond port@4 are rejected.
> 
> Existing in-tree device trees describe only port@0 through port@4 and
> are unaffected by this change.

We are closing net-next and this is missing DT review.
LLM also found a potential issue here:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014131906.990077-9-prabhakar.mahadev-lad.rj@bp.renesas.com
-- 
pw-bot: cr
