Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316353;
	b=kuuVKDnYZcYw3SYjWBxfrkLUeOp7lWRW2nrK+ZGvwRhh0QMw0vCtf4vcbJ94xFxq0GtG
	 zWEGoszuxHw/bvgJdxEDhS1yr/mTTCQc0kfiAO5QJiYbAUKEZZhuC8clMc4qTsswWjhbU
	 HyE6ZfZcULoNEqLZqRgfN1uO1/GDGCdkTxjDRjiCxcTgnXa/m/ov2x6fm6yQwOnQZGrC8
	 BUT8Zd947YOR4mh/hQ8NX7+yGyOMVoSNCvFlPLk+arYrcvnX4kScWrv76JNhCe+A3YF2y
	 zwNhYcqa6XecFRaTWXQAw8v01SOlZ0hr2PdroOCw3IX+7WB811x/vdJPSJ81rJxmEow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316353;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=uN8v/ql7Ig3Q1kzcH3JlLyoHXVIkZ6u9pSBdR1rwWCg=;
	b=aWhIjE1lsd+eg9SNIgQJyED1Kegmk0w0J3tp4ZQKW4z4iCgH7XEFbH9NVP652mmih51f
	 U8t0EsX7bxz4Sd4ufsQAWcrM2oDqbvx2+cU7xerQzomzYLc5GUs/0iAzlShlWExcq05j1
	 BoZbQtSD1FYNjTHt4g9oPzTgr2fvnxjvGXoO0aHu0fmfQCgv85ACqOAOlROns3yzTHm1A
	 jyTcfsO8Q4yTtTy0ptRjoJRx++p4oHPUcyLYpkr7BvkP4Huzj9mzX0nqhzRFApZH7ECV8
	 oCHL2UJ85g+8jfSpbp8xBvNn8RrSF3qcI/TeqDhprvZGUvrtFwUX0NxCSdXMfvXreDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=t62pdt2N;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C506D606A7CF;
	Tue, 10 Nov 2026 13:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C506D606A7CF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=t62pdt2N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uN8v/ql7Ig3Q1kzcH3JlLyoHXVIkZ6u9pSBdR1rwWCg=; b=t62pdt2NbyA0Rm8RsYb4nduog1
	bDSBtA7ZYHqleUkTKEPRlFTIzt4Uu9JI47Br24O6URPnJSKyYQ+miajbzhp5ZFyJyhCOXQnydWkTw
	88LSdaHDXTmJugXY9MjIJlHcBSIpCIRpjZPvwlddRyaXM3hnwV114qBTcdAssYzBkXIw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQleA-00FTwe-5i; Tue, 10 Nov 2026 14:12:22 +0100
Date: Tue, 10 Nov 2026 14:12:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Michal Simek <michal.simek@amd.com>,
	Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 5/5] net: phy: dp83867: support setting
 output-impedance
Message-ID: <ab3b042d-dded-4349-b9c0-7b2678274275@lunn.ch>
References: <20261106-v7-2-topic-dp83867-v3-0-45e1d3adf1bf@pengutronix.de>
 <20261106-v7-2-topic-dp83867-v3-5-45e1d3adf1bf@pengutronix.de>
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
In-Reply-To: <20261106-v7-2-topic-dp83867-v3-5-45e1d3adf1bf@pengutronix.de>

On Fri, Nov 06, 2026 at 08:47:29AM +0100, Steffen Trumtrar wrote:
> Currently the dp83867 supports setting the io impedance to minimum,
> maximum, default or a value from a nvmem cell. In situations where there
> is no backend for a nvmem cell, the value can not be set to anything but
> minimum, maximum or default.
> 
> Add support for the ti,output-impedance-ohms binding, allowing to
> specify the impedance in ohms via the devicetree. The PHY has 32
> settings between 35 and 70 ohms. The datasheet does not specify the
> impedance of each setting, so the value is mapped linearly to the
> nearest one.
> 
> With this mapping, 50 ohms results in 0x12. For non-OF devices, the
> driver sets 0x0f (IO_IMPEDANCE_MIN / 2) as the 50 ohm default "per
> datasheet", which would be 53 ohms with the linear mapping. As the
> datasheet only gives the range, neither value can be checked against it.
> 
> The binding does not allow combining the new property with the nvmem
> cell or the boolean properties. The driver still reads the nvmem cell
> first, then ti,max-output-impedance, ti,min-output-impedance and
> ti,output-impedance-ohms.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
