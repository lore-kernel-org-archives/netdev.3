Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FACB35838E;
	Tue,  4 Aug 2026 02:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811396; cv=none; b=aqo/vQbgcdGPMJsYkeQ0Yuo0SjOxDSAq8UhwTQ6Fw+wDhZQTOo+BUyw8jrpTVy/kCDd7UrHJL4TGQt6lt1MXXDLkKTxW7tv++g2s6JzojvEWE1oS6JUwypswXW0VwtP9Ggwa2TW5xVFZ4YCW9mzUvGJ8OtJq9E1dkeW/Ut36gCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811396; c=relaxed/simple;
	bh=9KUWNQpzkICGiZIz6RpeJzq6ZNfaxUzX/eYjQny1Brw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uo/b2jUWIP1Pa9eIj5EFyrHwkNDQkkcsDhTFwtczcR0rWlgD7GYF0csVUASlklkvGpjzP73ANCKOGNgPfNjyQM/wckPwyxBhRyCjl4GQGYncKOxpNmCFo7ShNpIVa70BB4I7fPdcN1YVeWUHmrGyj9za5Q3pJMmhn3pAZ05BwwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HkvcuGbT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HkvcuGbT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5xd/A/k5scoEkiSfkxEsnxNSvX+fTeIItseFvpU0+3U=; b=HkvcuGbT7wWBfvr6qcREZl62zE
	gPFazdXpsM7+ig4sGAA+An7X07pznvVmjoOpIHcMCugq+/KBJjD6aa7xbG/itZNNKWYObTMUxA/QF
	VZtic05EpfJy4txj+JVSHDxN7lX60fBPDZCzbtF1RLynmG4gUTj2KGThGOQ4hCLTSg8c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wr57I-00FtfC-Ic; Tue, 04 Aug 2026 04:42:56 +0200
Date: Tue, 4 Aug 2026 04:42:56 +0200
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
Subject: Re: [PATCH 1/6] net: phy: maxio: prepare for more DT properties
Message-ID: <4d855daa-a426-4f46-985c-181e3b0eb7f1@lunn.ch>
References: <20260803101452.2993721-1-andre.przywara@arm.com>
 <20260803101452.2993721-2-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803101452.2993721-2-andre.przywara@arm.com>

On Mon, Aug 03, 2026 at 12:14:47PM +0200, Andre Przywara wrote:
> The probe routine for the Maxio PHY returns early if the optional
> maxio,clk-out-frequency-hz property is not found. That prevents looking
> for other properties.
> 
> Refactor the routine to handle the property in an if-clause, to allow
> more actions in the probe routine later.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/net/phy/maxio.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/phy/maxio.c b/drivers/net/phy/maxio.c
> index d2cb23895646..95a2169f25df 100644
> --- a/drivers/net/phy/maxio.c
> +++ b/drivers/net/phy/maxio.c
> @@ -43,18 +43,18 @@ static int maxio_mae0621a_probe(struct phy_device *phydev)
>  
>  	ret = device_property_read_u32(dev, "maxio,clk-out-frequency-hz",
>  				       &frequency);
> -	if (ret == -EINVAL)
> -		return 0;
> -	if (ret)
> +	if (!ret) {
> +		if (frequency != 125000000) {
> +			phydev_err(phydev, "invalid CLKOUT frequency %u\n",
> +				   frequency);
> +			return -EINVAL;
> +		}
> +
> +		priv->clk_out_125m = true;
> +	} else if (ret != -EINVAL) {
>  		return ret;

The normal pattern is to check for errors and return them. So i would
do this test first.

 	ret = device_property_read_u32(dev, "maxio,clk-out-frequency-hz",
  				       &frequency);
        if (ret) {
	   if (ret != -EINVAL)
	        return ret;
	} else {
		if (frequency != 125000000) {
			phydev_err(phydev, "invalid CLKOUT frequency %u\n",
				   frequency);
			return -EINVAL;
		}

		priv->clk_out_125m = true;
        }


	Andrew
