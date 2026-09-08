Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED915237B9;
	Tue,  8 Sep 2026 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872385; cv=none; b=F96vLFRfHKUFjGGaGwrJVxY41ZN98ab7g9ps+llpnu2M/OOjgkAioIlINbEOwnRtgq9amgds2OsW4ZqDZwIKu4aabCKmcJhkCmIcT8EmDL2eayy0NabQPFe+qdrEdkwzJKz6P85KIRNUYYfELUONLQqkqWDaOku9wKeGBVnWmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872385; c=relaxed/simple;
	bh=iZjAUkgXr07TKEpRDmqWXw3PNy/p3D4RjwvVTYIyU4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMUvZEar8q5JBZ63s3FkjVPAYSPBQT0SSVIhzpnwiJGTR85w9FFrSl+QnrkUBaFy9fZAoFfqER4Su747dvmxr9U/tt8oAeRpAjbVOIkoyLon8fQdnNA2JWIQgUqTI/349f6jAtQeYtJxJU7HaVAHA/q+gTyZf0kinn7vlilRWNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aQNbOmqn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aQNbOmqn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4SgzWIuxonQdSLbK63L66PzWz+wr5RZVhYrx0WZUfJM=; b=aQNbOmqnxG6JYqLymzf4lzxH6p
	XMS1vl5WNo6q1eP4i04jm6t+Ow/rNzidadw5KORCvQ1g3ZkeNKTEpXnJ+l9XrEoU1Isc3ECAalJqz
	vFKDP38uq/e4TYt53L7QNIuvRytTXLZu2hg61GzFT/YctqlOgaOi6NTqzyXPG2oS0oPc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3vQ5-003tVj-Es; Tue, 08 Sep 2026 14:59:25 +0200
Date: Tue, 8 Sep 2026 14:59:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v12 2/9] dt-bindings: net: lan9645x: add
 LAN9645X switch bindings
Message-ID: <f745c884-ecfd-4dbd-ae33-6b713f8ab73d@lunn.ch>
References: <20260908-dsa_lan9645x_switch_driver_base-v12-0-2d6aa59350cd@microchip.com>
 <20260908-dsa_lan9645x_switch_driver_base-v12-2-2d6aa59350cd@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908-dsa_lan9645x_switch_driver_base-v12-2-2d6aa59350cd@microchip.com>

> rx/tx-internal-delay-ps is used to model a direct MAC to MAC fixed link,
> using RGMII, where exactly one of them must supply the delay.
> Documentation/networking/phy.rst describes plain rgmii as the mode where
> the MAC or the PCB adds the delay rather than the PHY.

This is not correct. phy-mode 'rgmii' in DT means the PCB adds the
delay.

If the value is not 'rgmii', then the MAC/PHY pair need to decided on
which adds the delay, and by convention, it is normally the PHY.

Where it gets interesting is MAC to MAC, which you do see in
switches. Using rx/tx-internal-delay-ps makes a lot of sense in this
setting.

The binding itself looks O.K, its just this commit message text which
is wrong.

	Andrew
