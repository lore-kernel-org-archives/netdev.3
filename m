Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746AA14BF92;
	Wed,  2 Sep 2026 00:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788307740; cv=none; b=Jsbl6elsQWxugzEpj2Ku69R6PaBKuJf5C4yR8XecUx7Lh3uVpreNXeWyPwNofNPuvTZdni/xlLudpbEmYqTM/OyAx5fetcDnpofSWIzwNEnSKFxE34j6x+WrHsqrnsHVLe9JJrumH7/6S7sMjQeo2teyVWoPn/DMX6LbCuCc0os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788307740; c=relaxed/simple;
	bh=ObcgPvUN6UtB/e88qvIKyLy2pbqLncOSzwoqRFTSics=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxJwmSqAmB+3ZjfzqqpjOVdrnzXO/WgE9KNvwpHOrR/6v/2gXRAmNGgO3Z6i4XlRtRxvtHBw9ttslX/WR7KUbYb5kceE1k1Y1GT4Q7ZSlsCc6A3qWuRx6qu65SrCP67bJw03e6dgT58DjfSHWnExfe3Ah1RcmnswhkVOOC2Ajlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vE7OrkFE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vE7OrkFE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=izxYeCS7VsJ1gyy3ISM96ulCmU54tHMcPfCgpE2EBac=; b=vE7OrkFEOC3E8le2IooUoWP7sG
	RmHUD3bvXJkcVVFDXMptXMNi3oShE0vwmanwJGTKe5s+NJmW2iuV4Yhq62ZJxnSWK4IYnBwYc5A/n
	0gHgKF2jdIY5RH5khdTt9N6B3/EY5DaS74209H7WkqaAnYtCJXBO7bPW4ma8hptE7ywo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1YWh-002RW4-4o; Wed, 02 Sep 2026 02:08:27 +0200
Date: Wed, 2 Sep 2026 02:08:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v15 03/13] net: mdio: realtek-rtl9300: deny C45
 over C22 access
Message-ID: <009ea534-2964-407e-a2dd-028cb0c2b157@lunn.ch>
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
 <20260831143439.2404484-4-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831143439.2404484-4-markus.stockhausen@gmx.de>

On Mon, Aug 31, 2026 at 04:34:29PM +0200, Markus Stockhausen wrote:
> Hardware polling breaks C45 over C22 PHY access. Currently this
> is accepted by the driver but it silently fails with undefined
> results. Make the situation clear to the caller by adding checks,
> returning an error and giving a one-time warning message.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
