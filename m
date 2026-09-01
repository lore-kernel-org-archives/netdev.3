Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A9C432BF5;
	Tue,  1 Sep 2026 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278546; cv=none; b=uRtyBl0g+oneXZOOEYyp2qiyk7gahsyUhIgTNtHBh7wqRmTmmWTGLiTtuIJRdyKl1VaM26nYB94dd4h9/HxB/Svx+jVbkM+33Se7tkon+RQlISidWC/V7rgnYUANiPO3HS3O9sgaY/eShTxSMYwxrmolkq2TPvHfRgiv2i9JIPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278546; c=relaxed/simple;
	bh=gNdfoe53Mwg604n+y0WvOrjjC2vMCSzhmMsUM4XmopE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWMnSgC0L8EbszsnW4lFgpnCunI+bMQJwoqHCUgk8M9hxtIXTyd9CDXoEemGR02OqD8EMvdorS7rS3ORImMBiOQ/ZqwcK+WAgXL42002iOf13EnezAVuc1i5nGZv03lIyNJ8fg6EB1d8kpVVf+yCE+MA+tB5mQWdusxjkgnVMsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5BA3PfSj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5BA3PfSj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FfrKBcy61KkfVsK24t+C7a6pUxQVpc0yKJroxL4DpCM=; b=5BA3PfSjkYjr0GpkauUfNf2enR
	FCD7S4ZAjZ0MqCrkYQLWWrL8NYJc65r/gtgGbc7DOOrd46dTZfiqOyxjpFfZFQ07fVmE06tkXu3Uf
	JSiu1dU+XgJBmFZyJTzpDy8rddcpRJ9ME9DLN98S/NwwBlq4SuG7Bn1P1k9jMbMI26nA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1Qw7-002NxP-Kn; Tue, 01 Sep 2026 18:02:11 +0200
Date: Tue, 1 Sep 2026 18:02:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: khendry@reliablecontrols.com
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] net: pcs: rzn1-miic: Verify port number from dtb
Message-ID: <bca8ba82-211e-496c-bc8a-c9ccd8667f9c@lunn.ch>
References: <20260901-rzn1-miic-fix-array-v2-0-3e907049e770@reliablecontrols.com>
 <20260901-rzn1-miic-fix-array-v2-2-3e907049e770@reliablecontrols.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-rzn1-miic-fix-array-v2-2-3e907049e770@reliablecontrols.com>

On Tue, Sep 01, 2026 at 08:25:14AM -0700, Kyle Hendry via B4 Relay wrote:
> From: Kyle Hendry <khendry@reliablecontrols.com>
> 
> Add check to make sure port number is in range before writing
> to dt_val array
> 
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
> ---
>  drivers/net/pcs/pcs-rzn1-miic.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
> index c50b65d064fa..ebd73ed63896 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -692,6 +692,11 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
>  		if (of_property_read_u32(conv, "reg", &port))
>  			continue;
>  
> +		if (port < miic->of_data->miic_port_start || port > miic->of_data->miic_port_max) {
> +			dev_err(miic->dev, "Port number out of range: %d\n", port);
> +			continue;

Better to return -EINVAL, so the probe fails and the broken DT blob is
fixed.

    Andrew

---
pw-bot: cr
