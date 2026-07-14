Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3903F8222;
	Tue, 14 Jul 2026 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016920; cv=none; b=WWjUgltCnLBTeYPdTtHfL4A7kTHsHJCe7Q8R8gf5y3X6hEnGuxAfLXmGZ1ZA/JQdLnHr7a2+PVKbOQs9gRhJ3RWpI0ClFxSwzl65KRAbT8VuPPgVC7xAJEDGMEGZy9lJal7stwlDZWZJ9tWAmZbqnpPUT3qsBuRGpmsB+8fnNxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016920; c=relaxed/simple;
	bh=0upYgGRQu/B38VZchdINsyPj9F703eh+hxbl8OvmROw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWCWwP3QMLBjChRfo3S00WW6hyageafoaY8l3oDShxNFigna2l8w0RfLfUbz0MvVCz949U27m0UYn/b9i2CBR940jDjlhcV1fxY2rkKAwe0Ssb8VR0mh7/m/XL7wWSoGFxqIj94+KZJBPW9P5Xo2OKte4KoIGWicNrNk6w6wGpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A5EFF2021FF;
	Tue, 14 Jul 2026 10:15:08 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wjYIG-001jwQ-1u;
	Tue, 14 Jul 2026 10:15:08 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wjYIG-000000091xV-2055;
	Tue, 14 Jul 2026 10:15:08 +0200
Date: Tue, 14 Jul 2026 10:15:08 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	=?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH net-next v7 1/4] dt-bindings: net: pse-pd: add bindings
 for Realtek PSE MCU
Message-ID: <alXwDEZsXY90Wh0N@pengutronix.de>
References: <20260712192251.1413279-1-jelonek.jonas@gmail.com>
 <20260712192251.1413279-2-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260712192251.1413279-2-jelonek.jonas@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Sun, Jul 12, 2026 at 07:22:47PM +0000, Jonas Jelonek wrote:
> Add a binding for the microcontroller (MCU) that fronts the PSE silicon
> on a range of managed Realtek-based switches. The host talks only to the
> MCU, over I2C/SMBus or UART, using a fixed message-based protocol; the
> PSE chips behind it never appear on the bus.
> 
> The device is the MCU together with its Realtek firmware: the firmware
> and its host protocol are what the binding describes, not the
> general-purpose microcontroller they run on. The PSE silicon behind the
> MCU (Realtek or Broadcom) is reported by the MCU and detected at runtime,
> so it is not described here - hence the 'realtek' vendor prefix.
> 
> Two protocol generations exist, both Realtek's, selected by the
> compatible: gen1 on older boards (fronting Broadcom PSE silicon) and gen2,
> the altered protocol used with Realtek's own PSE silicon. On an I2C
> attachment the framing the MCU firmware expects is part of the compatible
> as well - '-smbus' or raw '-i2c'; a UART attachment carries no framing
> suffix, as the transport is given by the parent serial node.
> 
> Each board additionally carries a device-specific compatible that falls
> back to one of the protocol compatibles above. Drivers bind on the
> protocol compatible; the device-specific string identifies the board and
> reserves a place for a future per-board quirk without having to retrofit
> device trees already in the field.
> 
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de> 

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
