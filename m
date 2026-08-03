Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35D84039;
	Mon,  3 Aug 2026 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764438; cv=none; b=SQaVGTNNWqT1eScQonC6rhWdOYaj7Rdco1lZtPN4AGdH7dp8ZSULJRD1qRt4lY/JIAVa+I5r5/b0l2JtqBjaykCH5N14T+KFH6T0kpY5tTEhkAbfaX0zqRZVRFa6ejeqQxNsgrDDJlswWVNMX3F5zvKiqdheMkwaBToRlvXUaaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764438; c=relaxed/simple;
	bh=fK/b9MXniraU1nr8yy4WmwL/xpBjpHF1fruxTUviijc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6mC2NJ9ZSNKgt2pjM73byqorfdWGCoNyBIgjjp3MRIYC39N3cbKeVrhxdAGqMXgKePPWGO6GbPW2LIXD4wsOoEHinqMgdUl6lc0Uarv7M2KRjVgYS47cGJpwoOmVZNgnF4nwgfKnoFDQOWHUgRWztcBCNMHQWH+6wQNhsuybDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Bd+qoP4i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Bd+qoP4i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yZ42Be3CAijIs1MNORT4K5KkOylX/+uxMp3PqspuDn4=; b=Bd+qoP4il5TLPBh6QS/4b9X0nU
	HnNfIDbxqVMYSSvKsJHB/wilXUpTzT6MId6khGbs6GirY44D6Qjk9++TBwKdtRzMvb7AQW7BKn6n/
	0W7y7583P09MTfuHmqsXdBgidD14JrlWZ8EeJhIq/OjcdrBdD67k0INqZLW+jjj5cbcY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqstf-00FjM3-02; Mon, 03 Aug 2026 15:40:03 +0200
Date: Mon, 3 Aug 2026 15:40:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Maxime Ripard <mripard@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, mfd@lists.linux.dev,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 07/21] dt-bindings: net: x-powers: add AC200 EPHY control
Message-ID: <2979768f-4f83-4f28-ace3-826f4b4c6844@lunn.ch>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-7-0a53cd9e21cc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-submit-acx00-of-dynamic-v1-v1-7-0a53cd9e21cc@gmail.com>

> +  phy-mode:
> +    enum:
> +      - mii
> +      - rmii

Despite the phy- bit, phy-mode is a MAC property, it defines the MII
the MAC uses. I would not expect to see this anywhere else.

The PHY driver is told what MII to use, phydev->interface, which takes
the values PHY_INTERFACE_MODE_RMII, PHY_INTERFACE_MODE_MII etc.

Please explain why you need this here, why is the MAC nodes phy-mode
property not sufficient.

    Andrew
