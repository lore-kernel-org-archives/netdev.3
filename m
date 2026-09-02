Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3457A4A92CB;
	Wed,  2 Sep 2026 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788375062; cv=none; b=PRyIcsOQWcWqL/dTqEF6e0Zn+ChAE3jQImva41M4WzmGX1WellJvFMCY5ZeuumRU7WYRzAsPqqr78v2F1obUCHGqVYPA53wqu4W3keMEiNiF2Vk2fTcsOKXVOJXMFfhLKT0r27Kao6tuxUD3FtmDx4GUyi0pCXHvqF8R0DhVTgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788375062; c=relaxed/simple;
	bh=+Ub3YMosNfdQcgVH3HgIXI4bfXDQmwUkft3s/LnH0EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrASJF1li8wuFDGTJ2n/AaM6Mj1dTFV3ei8Vh5mCvOWmQ4SmDxIV52JywF5hqNo5Uy0HtBRkvwMb1oFCpjpqnm3gc4RpSRlFK6/e3/z1WANKfjnFVDbWgU2wEfQQhZVONzcP0nOQz2mTPeF+IL+RXFZ45AXFKcTuNa8lnKdxLXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C5MEIlit; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C5MEIlit"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8YcGrZDGFlQAHZYXmJz9O2iRbfLftOMblBThW89CfDM=; b=C5MEIlitM8B/YU+bAUUR4oAuEY
	0HGN1KXdua35+2+vlhtiv3KjxZ0AAH3lvitzq7WihEFSTt6lFSkZyzeq2fnundzoNGmr4o6p57m6B
	vwZ7nehXVkFF3kAAMysJiMmEYGByjIZSFaysUuh1DwMxnzXQe69e/Soy3DfjqgzAojjQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1q2m-002ZdX-Gk; Wed, 02 Sep 2026 20:50:44 +0200
Date: Wed, 2 Sep 2026 20:50:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: khendry@reliablecontrols.com
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: pcs: rzn1-miic: Verify port number from dtb
Message-ID: <81869e14-2dff-4bff-b2b4-07185c4e9086@lunn.ch>
References: <20260902-rzn1-miic-fix-array-v3-0-3f7dccffaf5a@reliablecontrols.com>
 <20260902-rzn1-miic-fix-array-v3-2-3f7dccffaf5a@reliablecontrols.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902-rzn1-miic-fix-array-v3-2-3f7dccffaf5a@reliablecontrols.com>

On Wed, Sep 02, 2026 at 11:37:36AM -0700, Kyle Hendry via B4 Relay wrote:
> From: Kyle Hendry <khendry@reliablecontrols.com>
> 
> Add check to make sure port number is in range before writing
> to dt_val array
> 
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
> ---
>  drivers/net/pcs/pcs-rzn1-miic.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
> index c50b65d064fa..3ee40eb9d545 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -692,6 +692,12 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
>  		if (of_property_read_u32(conv, "reg", &port))
>  			continue;
>  
> +		if (port < miic->of_data->miic_port_start || port > miic->of_data->miic_port_max) {
> +			dev_err(miic->dev, "Port number out of range: %d\n", port);
> +			kfree(dt_val);
> +			return -EINVAL;
> +		}
> +

While reviewing this, i noticed:

		/* Adjust for 0 based index */
		dt_val[port + !miic->of_data->miic_port_start] = conf;

Is the ! correct?

	Andrew
