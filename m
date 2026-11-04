Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.142.180.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777931;
	b=HU6b1h2Wxcf+Lnc9bq5ZZLsafJeoFzB76n5nNjYP7iXxU7eVD5wsvOCrp6++9czhfqqD
	 wijg75LeFZqvaarQXKI0JEL1q8Q89cqTwc4MeSaJazDBcZCu5446fjAJdf6mAil2o+MXt
	 l4ApDg11gmLUGE5UZwV7+aXh/tFW82Ey6JOceBWX8UDhweCe9cEz1MGQdDEN/qpP7SAM0
	 HWP5PYzOcgLmVu2PgRGljANsOAQbfMAO/0e9uXmkvj0FyXswe6IKxta82JmFANOqCeHAS
	 mtMtQFPRw8BCSDUHoS8zQtIU2ThVHjQP/O7p0aSYrBfh+CQcXnC9bijk9cC0EBSbbIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777931;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KdTcTFdrYhp+y0Fe5KO7mqbp34rJ36pFSPrrypS9TYI=;
	b=RY7NbAWT5jYw9U1hQh7LhiPWOnYeL7gwJp5tL7uIqwUTk4L/GVgfJzsDzSvXyBO91Kxk
	 Aw3BwrGLPY/t6iTY2PxWoL3UZ+f5+l5jRY3srLMfOoen+THlMOcgosEssVvPrTKOALBCK
	 c7m4ubRZW/2KgOI0ohmebtPQsd989mQ3PM3wYF4O0iVa5AQH/fkyELiJlDyflRGiHJnc6
	 3AeNCKQ+Z7kRZiFWsDwYJ+lHAl7lKIYnbluvfOb14B16y2bPidIEd1LaDTfQotDg5KC3s
	 xDEXrbLDqlIWpqqWkJWNMIkXpui3/ZFN0Q+IxwC9mdXcVmHFLcIU3mvcJB8/SQvmiOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=makrotopia.org;
	spf=pass smtp.mailfrom=makrotopia.org;
	arc=none smtp.remote-ip=185.142.180.65
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC7E606A32C;
	Wed,  4 Nov 2026 07:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EC7E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xOVNN-000000003uC-03qs;
	Wed, 04 Nov 2026 07:38:45 +0000
Date: Wed, 4 Nov 2026 07:38:30 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: joseph@telaak.dev
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: mxl-gsw1xx: reset the switch
 through reset-gpios
Message-ID: <aurg9vX3_i_ewWur@makrotopia.org>
References: <20261104-mxl-gsw1xx-reset-v1-0-53839bf5c88e@telaak.dev>
 <20261104-mxl-gsw1xx-reset-v1-2-53839bf5c88e@telaak.dev>
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
In-Reply-To: <20261104-mxl-gsw1xx-reset-v1-2-53839bf5c88e@telaak.dev>

On Wed, Nov 04, 2026 at 02:15:48AM -0500, Joseph Telaak via B4 Relay wrote:
> From: Joseph Telaak <joseph@telaak.dev>
> 
> The switch keeps the configuration the bootloader left in it, and the
> driver never resets it. The MDIO core asserts and releases reset-gpios
> only for PHY devices, so a reset line described on the switch node has
> no effect either.
> 
> On the GL.iNet GL-SFT1200 the bootloader leaves each internal PHY of
> the GSW150 one MDIO address above its port. Port 0 then fails with
> "failed to connect to PHY: -ENODEV", and the PHY that answers at a
> port's address belongs to the neighbouring port. After a hardware reset
> every PHY is back at its port's address and all ports work.
> 
> Request the reset GPIO in the driver and pulse it before the first
> register access. The timing follows the vendor driver: asserted for
> 2 ms, then 100 ms before the switch is accessed.

Any good reason to open-code this instead of using reset-gpio
(CONFIG_RESET_GPIO)?
