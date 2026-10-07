Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD2147D454;
	Wed,  7 Oct 2026 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378113; cv=none; b=HXf1E0gVuuxlunL7V6B9OYmmkq+378loZSPRvdLmQ0I7ekblnb37hJNqVISYQjuGbqGrT1ecC4PjafTjIIFPtYnom98GEg1RfvIqspVI2GrskdQY4aodgsmp+y7PfMuFOgF0Gf4COJgzjfLjQ95g48KcPnnU+NNYHcsPpCWSBGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378113; c=relaxed/simple;
	bh=O0EtaeY/6At1FiwpxnWcfkDfEcMW6xZEaO6fINS23AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNKriBR9dcM99b2DltaEO+0I+ayJQslSNCjAQRlOv/XXQWuFAfY4Sn2wlbRiyTdFLpI81YZfS4MOmFlrzFYytma0A0yncKDPJuWX2BoQH6lB74H0ly1YSbaWtNBmtBivECTeiqvnUvtq5u5HD/lPoytgUwNDbTDgGnqHamG7/Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zU5ZvP25; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zU5ZvP25"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6YP3nrzHNBPV4laVHmTWlcL0xqJ7r23M87T5OozmfTM=; b=zU5ZvP25ND/Pnn0/1VuaJCdY08
	UffRk45r/0Ba3w0c/7bsl2unFhNjUeFg2U6bjfHSZQJ2YWsy5NRyJ0lHPQf/MGkB1x1tfw2JhHfqv
	A6/GJqeHG0rX5ehWSZOIH50Z9Nqq1h5uwQKXKf/XKsPTMyi4U8RPjpSiNQSlK+gCOSjw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xERGy-009SZ2-8w; Wed, 07 Oct 2026 15:01:28 +0200
Date: Wed, 7 Oct 2026 15:01:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/7] Add ethernet support for the Amlogic T7
Message-ID: <d23dfdf3-5837-459f-afd6-6c198a05c13c@lunn.ch>
References: <20261007082627.63807-1-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007082627.63807-1-tanure@linux.com>

On Wed, Oct 07, 2026 at 09:26:20AM +0100, Lucas Tanure wrote:
> The T7 pairs a Synopsys gigabit MAC with the same glue registers the
> G12A has, but nothing described it. This adds the binding, the driver
> support and the device tree nodes, and enables the port on the Khadas
> VIM4.
> 
> Unlike the G12A, the controller reaches DRAM through a pipeline stage
> with a gate of its own, sys_ampipe_eth. Nothing else claims it, so
> clk_disable_unused switches it off and transfers stop.
> 
> v2 changes the RGMII delays, after review. phy-mode describes the
> board, not which chip adds the delay, so this board is rgmii-id.
> dwmac-meson8b did the opposite, and ignored the *-internal-delay-ps
> properties. Patch 1 fixes that. The VIM4 needs it because the RTL8211F
> transmit delay does not work here.

What is special about the RTL8211F?

     Andrew
