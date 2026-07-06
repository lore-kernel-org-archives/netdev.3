Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402139021E;
	Mon,  6 Jul 2026 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349796; cv=none; b=pD/HoluYZMP5QLluf3UHz/owSo7BV8HfgCGnt1kzc3SMVGVNNV5eXVhUM8Qq8KXnjRuVtw8xM5lq4SWcq2bRoffJEDpdtVhwO0nHVcGkItOr3g8kw/bWKFAN4pe+HRpJuObXdZzpw5NL6cklU21N6sCi73KMcXWi7ZvsE9uXPik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349796; c=relaxed/simple;
	bh=xYJEGHBvJA1hlYkblhbKhFrN+LPr5d9EWENLDkBCNNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6rI6y7jeteAg4RoiW9hu7ROrqGp2HYfYA6z8ihIgRatk8L/FEDjDW+H+SG5HxAeqPKhN2kD1ur4AU7XTAreEWdLOHh57V/dgoulwbXfJN7E0rLEfhAOa2+M3mqgQTNUySRdPWBQ4OUsWYBVTkutAuvlBN5ZS+SEGjBP8CkUP0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VK25B0Fe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VK25B0Fe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w8joU4cXK6hN478uM2nlCnYfVvF9AwmMn0E7W8AlcPE=; b=VK25B0FevkFnnIvRkDNCtDbhAy
	HMXuMOvcMQCq6b+613/bHU+SkZmKvaQWrxrv/dYSKlXOo17Qlxei+WkUqvC2DvgESt+oMN26iQTsM
	do1Ta9iXF6SLwqa1KSoIYnvolhGzOf64nLdXZ6Q30RvPnLqs/XZ7zPQ9Mxbf7dCpY5Q0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgkk3-00B0Vt-9k; Mon, 06 Jul 2026 16:56:15 +0200
Date: Mon, 6 Jul 2026 16:56:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yanan He <grumpycat921013@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wu <david.wu@rock-chips.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 3/5] net: phy: motorcomm: Enable optional clock for
 YT8531
Message-ID: <ea703e8d-e11f-4f0d-bd23-060a4c9ac988@lunn.ch>
References: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
 <20260706-rv1126-alientek-dlrv1126-v2-3-ff3176ca362b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-rv1126-alientek-dlrv1126-v2-3-ff3176ca362b@gmail.com>

On Mon, Jul 06, 2026 at 05:14:43PM +0800, Yanan He wrote:
> Some boards feed the YT8531 PHY from an SoC-provided external
> reference clock described by the common ethernet-phy "clocks" property.
> 
> Enable the optional PHY clock during probe so boards can model this
> clock as a PHY input instead of keeping the clock alive from the MAC
> driver.
> 
> This is needed on the Alientek DLRV1126, where the PHY reference clock
> is provided by CLK_GMAC_ETHERNET_OUT.
> 
> Signed-off-by: Yanan He <grumpycat921013@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
