Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929642B750;
	Tue, 14 Jul 2026 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019706; cv=none; b=iCeiaQlJmygGjrG+wfSKppFtS/AdyZ8NwBfgDzUVnVpRfjy1DdMDOXIyRJJuna2hPYlEgWmuxjEOHHeAaCUXo2jXKoCXRTj4kKrM4p06Deru7++qd/VXJYcoM59nGjkRBNpSVSXDXbD8uteZ/6BCa+hlbkA8qLIVL1m2qe8EYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019706; c=relaxed/simple;
	bh=77Xo29AbWRs4JGrjJRKlJS1S0CmzpkZJvOtjHGGo3s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vy6cGLWOgoMs7iBV9eTUZ06qnFT1VQf3dPyQaIb6k9QGLnqI+VmRaX/Q8otNY2W0bKtfIUSEkbhdZQ89Pa7dEgxigMZz0cWr08A/k+v5aT4cPpjApahXaEz4qLYyTwO1qWUR5UI7dUkDBDyY7x4u68QBU9/+BcztiD9+UfaYh5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 00059202203;
	Tue, 14 Jul 2026 11:01:36 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wjZ1E-001k6W-2q;
	Tue, 14 Jul 2026 11:01:36 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wjZ1E-000000092Xi-3D65;
	Tue, 14 Jul 2026 11:01:36 +0200
Date: Tue, 14 Jul 2026 11:01:36 +0200
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
	=?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v7 4/4] net: pse-pd: realtek-pse-mcu: add UART
 transport
Message-ID: <alX68PwC0cRdAOSp@pengutronix.de>
References: <20260712192251.1413279-1-jelonek.jonas@gmail.com>
 <20260712192251.1413279-5-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260712192251.1413279-5-jelonek.jonas@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Sun, Jul 12, 2026 at 07:22:50PM +0000, Jonas Jelonek wrote:
> Add the serdev (UART) transport for the Realtek PSE MCU core. It registers
> the MCU as a serdev device and provides the send/recv callbacks the core
> uses to exchange the 12-byte frames, receiving asynchronously via the
> serdev receive_buf callback.
> 
> The baud rate defaults to 19200 and can be overridden per board with the
> "current-speed" property.
> 
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

...

> +static int rtpse_mcu_uart_probe(struct serdev_device *serdev)
> +{
...
> +
> +	fwnode_property_read_u32(dev_fwnode(dev), "current-speed", &speed);
> +	serdev_device_set_baudrate(serdev, speed);
> +	serdev_device_set_flow_control(serdev, false);
> +	serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);

Some of this functions will return errors, it will be good to get at
least warnings, even if we decide to go with best effort initialization.

Otherwise, LGTM, with this addressed you can add my:
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
