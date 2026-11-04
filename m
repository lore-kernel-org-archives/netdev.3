Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828960;
	b=sSjmx5/YEvzuv91ecDaqU7yFYCF2vXVZoSCwvUHDRu9+UtgF10MaDIJ/9psGSZgCqaZh
	 Tj8Imenlfxcn8ateoQQs8OkRs6E0fk4R9CIGJt+8g4q3nvTodB1sGEMpQB2bMM0Nid8tv
	 DMY2kteSNryGdvcUNWlWnsrJm4WYKBV5ry5svXBq1Hm6XeP9P4xGHdXEn2vtyyfznxyW0
	 IUwZsTp31iPmz9jkFHRcgsye/HMmxFy30garnV7nA9I90hRFZSBKC683QIHYMevn3X4TH
	 xxmr5nw+46UN2mMurk2VPNIaM1JxvjIuUqXkOKo1ZdZotjUBq8HAeoo4FNUKp/OJ6mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828960;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=idAwm9qenugv2ZJbuj/+gZ5oOboDMCzCkLIVSojZF0s=;
	b=w01F3miPwhVHZEKi2R6hvtQJLZikn+C2KCc+nmtDXkMHZzQiKjPvFJQwlEeg84jMumIH
	 3W9/zwt9rTi97JGf7Vj317Q28RM38+VDGsTieh28Kc7iZmWSm963oVhvSVYNiSn4Jwlwd
	 +7LUTnbfCeiHRQOFLuM7yeRNOE59wZYHQY0WB5iZAfniMxljhc1tPRk9XddgD/ComnSEG
	 fLjp6en9akc88Pb+bIisKNvWXBhe+cqu6kQEWN/sXRmqAod8NyoIuAzY9xvqjzvqWd44F
	 muvGOEfIKW/WMAEDanm1cUawKS/29qkdz+RGFx61ToeuFH4R6U1cD78uUNXNYcnmFoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hWp/+L2O";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD56070743;
	Wed,  4 Nov 2026 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWp/+L2O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8305C1F0093A;
	Wed,  4 Nov 2026 21:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793828959;
	bh=idAwm9qenugv2ZJbuj/+gZ5oOboDMCzCkLIVSojZF0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hWp/+L2O+GrExZF0k2VePlUL+pg1NMekQxFJr7U3KD1t6y1mY5XOvMpbxk05GNPlC
	 9UbCTP3mCJkayDH426/DMbJKCFjS7PtKpW0l0ynhP5g/0kzgBfiqLrj/2ZQpu28Z8s
	 DmwGd1NTfM5t+1+NuEAttZADduQJfOv6SJWB1IMPi8no7tPAKUyGYWscwLyRH2ocK8
	 KAhVs/Y1bIWTcFW2velTna4t2eAIRms7eg281jHPQejQgTVPBo1l6y/ogEMHuFvLxX
	 7zK8dh9l/MnBxDrcob503x50uJQayV4Dl1EU0Or28vdP4sFq7D3CfECGU8IPbWrkXb
	 3QfbMZ+FwZFkw==
Date: Wed, 4 Nov 2026 15:49:18 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonas Jelonek <jonas@jonasjelonek.de>
Cc: Sander Vanheule <sander@svanheule.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Russell Senior <russell@personaltelco.net>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next 2/4] dt-bindings: net: pse-pd: realtek,pse-mcu:
 add VMAIN supply
Message-ID: <179382895766.500957.15768243931044602700.robh@kernel.org>
References: <20261103220312.860629-1-jonas@jonasjelonek.de>
 <20261103220312.860629-3-jonas@jonasjelonek.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103220312.860629-3-jonas@jonasjelonek.de>


On Tue, 03 Nov 2026 22:03:10 +0000, Jonas Jelonek wrote:
> Describe the VMAIN supply at the MCU controller level. The rail feeds the
> PoE subsystem as a whole rather than an individual PI. Its regulator power
> budget defines the aggregate limit programmed into the MCU.
> 
> Require a finite regulator power budget dedicated to this MCU, representing
> the PoE power allocation of the system.
> 
> Signed-off-by: Jonas Jelonek <jonas@jonasjelonek.de>
> ---
>  .../bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml          | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

