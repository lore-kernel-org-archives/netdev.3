Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051763D7A01;
	Mon,  3 Aug 2026 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763450; cv=none; b=avPWIZ/96nVhtsohQydS2hJGyWQYBnikPjcwXtvfqGWyNVelzGQw7OCTD0Olfkp5EerYwh4uz0rnOpqax4F3tct54F7dvt8s3GVZuONmRvDbRH88Yz55sR7q+l57gOL9dJ8SFd5Gg1Jra7e7Ja9tYWQEHsZM58+TtCxlrcMLlJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763450; c=relaxed/simple;
	bh=TXFLwSNt6M79oc5jS24gCdlgRS8754Ewq8o+NL/PxEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sk2DRcgY+uzCkho4zqDDdKHtfua/SgL/2+BYwI16D/9VJXg1LGfCBErK+hWf7rqSIRsbUBNRehdIZ1FxmSN5PJwsjTptAnbDfJ6hKOizcR2gsbiQrkdmxnQMIC/BiPH6gAKgbkUnrquylCLBUznAtU2HeSf7M5xJJNXPtlRSqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hTNo4kYp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hTNo4kYp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BjGnRhqiS2zR9pg/cS0bmUcMR7HXnniURrzPMgHT88o=; b=hTNo4kYpDqH3mP4IY1TuWvaCxA
	vg3na+Y9lhkpy4DSwX9ezau9vRGNVL4ghFQVMpBlW33l6CEeJ+C3mUY/pjGZdiSbH8ccinWMZYuyt
	gSjwEHXBcG2GxicNPWqF2C6Z1AY7di6zKVxx4gG/CzKeVdaCDpNpUWYINVRuX1lx8gAg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqsdu-00FjCh-44; Mon, 03 Aug 2026 15:23:46 +0200
Date: Mon, 3 Aug 2026 15:23:46 +0200
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
Subject: Re: [PATCH 15/21] net: phylink: allow PHY-autonomous EEE without MAC
 LPI
Message-ID: <ad954550-9dec-4e0d-8636-0b6cb379421e@lunn.ch>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-15-0a53cd9e21cc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-submit-acx00-of-dynamic-v1-v1-15-0a53cd9e21cc@gmail.com>

On Sun, Aug 02, 2026 at 11:14:25PM -0600, James Hilliard wrote:
> Phylink treats a MAC which implements its LPI operations but advertises no
> LPI capability as incapable of EEE. It disables PHY EEE during attach and
> rejects ethtool EEE requests. The same problem occurs when the MAC supports
> LPI on another interface but not on the interface currently connected to
> the PHY. Both cases are incorrect when the attached PHY can generate LPI
> autonomously without help from the MAC.

What you are talking about is SmartEEE, or other such names. It is not
part of 802.3, so there is no agreed upon name for it.

You are correct, phylink does not support it. It also needs a lot of
thought and careful design, which is why it has not been implemented
yet. Please search back through the netdev archive and find the
discussion.

	Andrew
