Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BACA330644;
	Mon,  3 Aug 2026 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762906; cv=none; b=sQVNHvdOPFmxneztLLD4zqIy+o+b7xlVEZ+PgBqIG9E7b6ewVSvZtuVGejzDtzvmSiXRsgerPcR60ZOwJPathsG6dZOzMymnmKEFvUbKUhqmclBINQkdVioyIY1Mz4JBU6zZ01mNBPkU6K7Oi9nV65BV9Bc+I7jPgYsAGaC2vzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762906; c=relaxed/simple;
	bh=SjCYjATvRQ8vLkiNIWtKeOW8qz1wSzTU7uGxyq27uN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbC12aW/Ss0yCE66WhTagZ7ANBxssUWGF0yJhAk0FOz3iqjhNOmAf1SjzBQjUdmTiAGugx++RQDu9Rj1DzBfizt26Z4vEl6+6QULCWlErWbqx6uNp86UO0HJsyk3i7STQyI6SZFZ2sLzMV9Mj8ptZgjQ3SmYl7qTx/S2lO5c07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uzs0YsEl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uzs0YsEl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8sNolu05p2stbRh8O9i9DhDkrV8/wacJ3u8HFpmRd9c=; b=uzs0YsEl/wyjSUeJIGAh44pup2
	clSj5ky5vnYE1dv+Y3Q8VJcH+ZvefXHy3Z04HonSEMux5+T7uRkw+geiIY6GfdnrC3fVgL6VxjjVi
	nl7VXpxEfoSNZIC9jQfRX+MDjRQ09znKfT8Rc1GsKGVh552ZksIsFxrL4wd9TkFcizBg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqsV2-00Fj7p-CJ; Mon, 03 Aug 2026 15:14:36 +0200
Date: Mon, 3 Aug 2026 15:14:36 +0200
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
Subject: Re: [PATCH 00/21] net: phy: add X-Powers AC200/AC300 EPHY support
Message-ID: <4b5fd8a3-3bfd-426c-8711-6aee45fceaa9@lunn.ch>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>

On Sun, Aug 02, 2026 at 11:14:10PM -0600, James Hilliard wrote:
> The Allwinner H616/H618 secondary EMAC is commonly connected to a Fast
> Ethernet PHY in an X-Powers AC200 or AC300 companion package.  The two
> packages expose the same link PHY ID and

I have a couple of terminology questions, one here, anther later

What do you mean by link PHY ID? Especially the link part?

Are you talking about 802.3 Clause 22 registers 2 and 3?

	Andrew
