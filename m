Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DBB331EC5;
	Thu,  6 Aug 2026 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022676; cv=none; b=SqnFM7F/4UIWQXzp1q7gj+3PZLpd3UJafqEnVMP9c+JHxns0a6h0Op0L3GFxRtAlvvMOVgvrcpx4+dtLCLILy68rKR3K/W1Bu5gV0M93zEb3Dh4N+uaR7nzPyNwqpi6dUSw2xefss2zU5gsLy/YTShpkpyCkLP7qYD+b9LtYAAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022676; c=relaxed/simple;
	bh=Xs4OhOZsDMGD/Md5haOJbWoeVffkPj/InpW0B11Ykos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWL04zPXXBvb8TOBYP3MISImsdbEpWbCGiW81pK3l1K/PMu2kGstgLeDbSXeNNrpYW3tvb+xZCeSpTQYiVXqk93gTb49owGwD4CSSIWddHbktoMWLLTvcB6SDYQDmZhzf6BFTYS84I/MtjoLWpHIxgNSjS4SvK/sCQ6+OgWhmyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1j2wPPMN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1j2wPPMN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pEq82F8vmHFWTlfbsof69GnETKFSLl7q73Otq4PVYHI=; b=1j2wPPMNH0emvT/NVuYIBxoc7h
	oKxCJuNH6NRWwGcmg1uMejulpctqYSQL2OZcmcdvw2H5FMB4DHjJd7WLFsANS1vLn+CrHUiGIEwZB
	NJi8TmVOPLqCFbKxyNeSfOFV/MTNOAL61F0PTyBgqwG91waa0VHzimraFOJ5Zm6I4jmI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wry58-00GNjf-4B; Thu, 06 Aug 2026 15:24:22 +0200
Date: Thu, 6 Aug 2026 15:24:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: dp83867: support setting output-impedance
Message-ID: <b225ccb7-f79e-45af-aa06-97a6e09de955@lunn.ch>
References: <20260804-v7-2-topic-dp83867-v1-0-1ca79eb54eef@pengutronix.de>
 <20260804-v7-2-topic-dp83867-v1-2-1ca79eb54eef@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-v7-2-topic-dp83867-v1-2-1ca79eb54eef@pengutronix.de>

On Tue, Aug 04, 2026 at 02:46:34PM +0200, Steffen Trumtrar wrote:
> Currently the dp83867 supports setting the io impedance to minimum,
> maximum, default or a value from a nvmem cell. In situations where there
> is no backend for a nvmem cell, the value can not be set to anything but
> minimum, maximum or default.
> 
> Add support for the ti,output-impedance binding, allowing to specify the
> impedance via the devicetree. The existing boolean bindings for minimum
> and maximum take precedence over this new binding. The nvmem consumer
> still takes lowest precedence.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  drivers/net/phy/dp83867.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
> index 88255e92b4cdb..e98c5d940410e 100644
> --- a/drivers/net/phy/dp83867.c
> +++ b/drivers/net/phy/dp83867.c
> @@ -542,12 +542,19 @@ static int dp83867_of_init_io_impedance(struct phy_device *phydev)
>  						"failed to get nvmem cell io_impedance_ctrl\n");
>  
>  		/* If no nvmem cell, check for the boolean properties. */
> -		if (of_property_read_bool(of_node, "ti,max-output-impedance"))
> +		if (of_property_read_bool(of_node, "ti,max-output-impedance")) {
>  			dp83867->io_impedance = DP83867_IO_MUX_CFG_IO_IMPEDANCE_MAX;
> -		else if (of_property_read_bool(of_node, "ti,min-output-impedance"))
> +		} else if (of_property_read_bool(of_node, "ti,min-output-impedance")) {
>  			dp83867->io_impedance = DP83867_IO_MUX_CFG_IO_IMPEDANCE_MIN;
> -		else
> +		} else if (of_property_read_u32(of_node, "ti,output-impedance", &val)) {
> +			if ((val & DP83867_IO_MUX_CFG_IO_IMPEDANCE_MASK) != val) {
> +				phydev_err(phydev, "'ti,output-impedance' contents out of range\n");

The binding says 35-70. A simple mask operation is not sufficient for
that.

Andrew
