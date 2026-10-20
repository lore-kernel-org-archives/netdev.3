Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513350;
	b=Pxwir7u0RovVkKMNdD+0ICFr5AyM6gobcW2s7PiekBgvhq74BrBTPZawtbBggAvBWnrO
	 sFtZ8UFx/XKMMzhWsLTIqe9dMH5BI4pV3oY8+b1X63mQSyEeTldmqGpSFdM+5jVWDql+s
	 BvUHZoz1D4XaCeBR9uurdJVISqTVVpTJ5oaZqIIPcOU3eexrestgfRVM1dtKWj8ixgMZY
	 vrBHdUlzQX6vQGI1Y7q/IpoMlQ5l9SeYTAJMvHAJe7mhynSd/qIXDtoqgZ9kee1Fcvbi1
	 BmF/P9DJ9zyHEDVve4s55t2FxFoe8svmi+gaq+Srqy24ev0jPBLjLT+B+Dmv8eU/DpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513350;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=exk3T5bgRFJr3BmOBEA0PPJMw3HotXBrd7zGVEotTSY=;
	b=WSQB1wKyVUunXF2qaxa/de4HO/SxNi7XqXpVX/tRsFv8iiMkgrvH3r0rk3BdNK751XC4
	 ZHTAG4C5N0OTta0Op6yiXGOJSXdu59BCyD2pqvfEAFhcMvIrMvdl83yE1qWwHNvJO7gco
	 VgRIA4qF+ympMzlIgbbwJ4VwzG/Ls4a8X3+B05XWTjMvWq79l6iDlQFBtz/jfhTnjxkkY
	 s16wt2MpFQZDV6jNGDMVbdFZ6sjq3CGMQFi+vW08b6BVLea3Np2uo7tanyO1bmcMvLiXG
	 jWA4TuZnjN6JU6xj/ei2+ULhp+19pxoYGqrdm2B2ZaflQ6iYRGGTJ6ZO35qrEkSQttQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EDB606A325;
	Tue, 20 Oct 2026 16:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AE51F000C4;
	Tue, 20 Oct 2026 16:22:29 +0000 (UTC)
Date: Tue, 20 Oct 2026 11:21:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sander Vanheule <sander@svanheule.net>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: pse-pd: realtek,pse: add
 gen1 I2C transport
Message-ID: <179251331810.3943448.15869673301901038184.robh@kernel.org>
References: <20261018161248.376205-1-sander@svanheule.net>
 <20261018161248.376205-2-sander@svanheule.net>
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
In-Reply-To: <20261018161248.376205-2-sander@svanheule.net>


On Sun, 18 Oct 2026 18:12:47 +0200, Sander Vanheule wrote:
> Like the gen2 protocol, the gen1 protocol can also be used over both a
> raw I2C transport and an SMBUs transport. Add a compatible for the
> former and the compatible for the Ubiquiti Unifi Switch Lite 16 PoE
> device that uses it.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
>  .../bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml          | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

