Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A0833A033
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784742609; cv=none; b=rWxz0zww574n8jSsT2O5sNlpOQJvXKnktLeyDg6enlYDj7XwkO/xIs7rnQ7XsVf6s0Ct0imtGRdAc5Jjw0luSW2KRkZYeArYeBvZJ5G15tbxum32dXKk+0NXQVrGS9SgxyMr4kgDWrQb06kPVZWxrWDtjKyFzgbQbcrTuziZIDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784742609; c=relaxed/simple;
	bh=nRQ/aD3XYpzRz8LEbqqQRQO2RwdvFU+/hkHzzROftdA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=He+WiFLbmVJJL3X4ZDZPMfhE2RWMXxvTTfyPq87yhAXR0gAKCzmJUJxeXWy7P1Rq5hIZtPrl8evxneTXUheME2/50bhrhrwcAzhgkv8OVESgpdWvqJJS9UbYb8tMZ4S5YZjG8/mAp1jAhMEhOayh4BHB70NJcP6YvlTy/K1nMrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=cB2r6/Q7; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="cB2r6/Q7"
Received: from [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d] (2a02-1812-162d-3d00-c381-7255-a866-916d.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id BDC657CE97A;
	Wed, 22 Jul 2026 19:49:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1784742598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b77cc/ns2yf7BVwHqBgWMOjJlS+SvngLLADUbWvll5k=;
	b=cB2r6/Q7KYc6dw0r+pc/7mNHpm/Hz7OBIah3DrKNmh4Ys4B0uz+tV7w/y5TWNGGa0LyVVT
	Vk0DXPNCqSUI9rwo6Z/MAd6S0UMRKcVmh3dfHd+k0bI+mXQtWypmGWAZpU+At8ifKcPgam
	ky4vrb0Q7TehcZydjzIi16H6j/yDtHTKPNagVLh4rFhy2RXjx0adqH7PmDTE3dlayQaLB0
	BauDdZXU54g5YkEkjD9hSv2AYjOtGiwuQZnG1bRn3D2mWCe05B5L58o0PzVVdjeXDzj1ZX
	7V/GlxoX7ZQz74LZ90KcnOzFheyx40F77EPwjkwQ21DiesmUOPD0noSLf3JStg==
Message-ID: <b3456b41152613ed45bcfde92aff89d0c33fa243.camel@svanheule.net>
Subject: Re: [PATCH net-next v8 1/4] dt-bindings: net: pse-pd: add bindings
 for Realtek PSE MCU
From: Sander Vanheule <sander@svanheule.net>
To: Jonas Jelonek <jelonek.jonas@gmail.com>, Oleksij Rempel	
 <o.rempel@pengutronix.de>, Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>, 
 =?ISO-8859-1?Q?Bj=F8rn?= Mork
	 <bjorn@mork.no>, Conor Dooley <conor.dooley@microchip.com>
Date: Wed, 22 Jul 2026 19:49:56 +0200
In-Reply-To: <20260715075530.2491534-2-jelonek.jonas@gmail.com>
References: <20260715075530.2491534-1-jelonek.jonas@gmail.com>
	 <20260715075530.2491534-2-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Wed, 2026-07-15 at 07:55 +0000, Jonas Jelonek wrote:
> Add a binding for the microcontroller (MCU) that fronts the PSE silicon
> on a range of managed Realtek-based switches. The host talks only to the
> MCU, over I2C/SMBus or UART, using a fixed message-based protocol; the
> PSE chips behind it never appear on the bus.
>=20
> The device is the MCU together with its Realtek firmware: the firmware
> and its host protocol are what the binding describes, not the
> general-purpose microcontroller they run on. The PSE silicon behind the
> MCU (Realtek or Broadcom) is reported by the MCU and detected at runtime,
> so it is not described here - hence the 'realtek' vendor prefix.
>=20
> Two protocol generations exist, both Realtek's, selected by the
> compatible: gen1 on older boards (fronting Broadcom PSE silicon) and gen2=
,
> the altered protocol used with Realtek's own PSE silicon. On an I2C
> attachment the framing the MCU firmware expects is part of the compatible
> as well - '-smbus' or raw '-i2c'; a UART attachment carries no framing
> suffix, as the transport is given by the parent serial node.
>=20
> Each board additionally carries a device-specific compatible that falls
> back to one of the protocol compatibles above. Drivers bind on the
> protocol compatible; the device-specific string identifies the board and
> reserves a place for a future per-board quirk without having to retrofit
> device trees already in the field.
>=20
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
[...]

> +=C2=A0 power-supply:
> +=C2=A0=C2=A0=C2=A0 description: Regulator supplying the PoE power rail.

As I reported to Jonas earlier [1], I used this property to define a power
supply for the 54V rail. While everything was working nicely, I still got t=
his
warning for the missing vpwr-supply property on the PSE-PI nodes:

regulator regulator.2: supply vpwr not found, using dummy regulator
Of course I don't like seeing warnings when everything is seemingly working
fine, but I was also wondering if this duplicated way of providing the PoE =
power
rail is a good way to go forward and if the generic pse-pi@n/vpwr-supply
shouldn't just be used instead. The latter is admittedly more verbose, with=
 a
property on every node, but going forward offers a few advantages IMHO:
 * Being able to reserve "power-supply" on the main node for the MCU's actu=
al
   3.3V regulator (not needed anywhere at the moment AFAIK)
 * Being able to take advantage of the generic pse-pi framework evolving to=
 take
   into account more properties of the parent regulator, such as requesting=
 more
   power, or ensuring the parent supply is not overdrawn by the combined PS=
E-PI
   outputs.

[1] https://github.com/openwrt/openwrt/pull/23222#issuecomment-5032841546

Best,
Sander
