Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A538311968;
	Tue,  4 Aug 2026 02:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811778; cv=none; b=s72lRQwz8KKrcYiLLQPB/8QdmzYA0ZUnZadCR/6P9lkpHd/V8AGXdxvfiFT8STWMXodLtmDCysvSyC/JeyvpC0tLWDI1Z3LaLxycWnUv7CuTlPm7YAR9Q9QY5VzK4YDS+ssRDCk/BCD3GzQocI8638o8pYhaUwXHwsQ6v7SwZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811778; c=relaxed/simple;
	bh=pselfx0wnh/QRs7eqzsa8my3IvpyL50cqg3W5SXjv3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXGy4Usd1qcBQi3fc7Gd4O/aFoaWt394uhLn1uew+hyZNhSYGMB9s4hi9I1Ems7d8XaiocA4CFHs3Oxsh1j0q8I6avb+7Cqekk9DDh+vIlDKm5ykr33fE0O7t4elGSg0uaysDXiWCen09um5KxIYQqptvHy7bVFueb3ja3Aj8fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YZ7vMoQ5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YZ7vMoQ5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Jzo4rhQ+WeKcNvXBIQdH7dAAfdtRqh5eeYkH7PHUZy4=; b=YZ7vMoQ5Iojjf89ZaYL9j3LBDq
	8kv3nZFltbzLYRfA+m0MGYkQdhKWq2bQYAivWbSYWmGfq2dOJT0ww5sXfWF7fNQZ1yzW9PPnkrFRx
	B69bhbbxGPGybiPuEGQQBKyQ0/2uc6DKVDYYrZ9ZUTZBIq6IiABAam+L226HykoA2xIY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wr5Db-00FtlS-Kf; Tue, 04 Aug 2026 04:49:27 +0200
Date: Tue, 4 Aug 2026 04:49:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Liu Changjie <liucj1228@outlook.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] net: phy: maxio: extend PHY ID matching
Message-ID: <d0f8e198-b999-4f99-b09c-9bf34562398d@lunn.ch>
References: <20260803101452.2993721-1-andre.przywara@arm.com>
 <20260803101452.2993721-5-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803101452.2993721-5-andre.przywara@arm.com>

On Mon, Aug 03, 2026 at 12:14:50PM +0200, Andre Przywara wrote:
> Currently the maxio Ethernet PHY driver expects a PHY matching exactly the
> one ID provided: 0x7b744412. The Maxio MAE0621A-Q3C model used on
> the Allwinner based X96QPro+ TV box uses a slightly different PHY ID:
> 0x7b744411.
> 
> Replace the "exact match" requirement with the more relaxed "model
> match" version, which ignores the lowest 4 bits of the PHY ID. Both
> PHYs should now be recognised by the driver.

Is there any documentation to suggest this is different versions of
the same PHY? The datasheet sometimes document the lower nibble as
being version.

	Andrew
