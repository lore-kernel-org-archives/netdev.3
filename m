Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E640F72D;
	Wed, 26 Aug 2026 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787748222; cv=none; b=Y3OhlHvZlowvwg+reK0RTfJ5/PeOdlJ/av8Z0zgyui0UvYzYWSBdzo1kIrXI4GdNMQBdpP3W4+Kje/iUSWCAhvhxeA+Fx+gojFdoWD9xHvpDL1asf0QR84RsmEKfOrWfTFWVGcoUQlaM9y/poA5FYrylEBxqW1DIK2oO4gof5RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787748222; c=relaxed/simple;
	bh=50EVnbLhgMdyVGypBo9kduQP9h4EKPQxaXXDjtJbMYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkFgYlIdYTOBO8E4hxKkY/LksiAFuVf/OSyXmEsCJqI/nDt7WVuvUyhRvZmOcLugQeIDl+0M5i8/LrEU++V7oeLx0a8D+AuHxM7ztd0VHN5XRlaWMrPNb4jcih21DZYEe4ktIzyv5M4E2BRLdP1yt8J/ZgEugHIF6SCyu2veenc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4pWIDh7X; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4pWIDh7X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=arzcOx6vfsLYPgRwHygN2YIb0+P0qfJJ6xKycIsxFh8=; b=4pWIDh7XFmvoLHLNC90P76IIWl
	ucnt/UAr0z3ZD3IrCPmywBEsDDygHbtcNufv3Dpiv0zthavCUNKbywAYYAG4k2+CWaJxPt7cpzcs2
	fGOQnPfFvyjJmEPrl/mdAhEjRazQejowXjDqtapyjCnezhp9CGL6oWcK2UF5wuoWg9OY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzCyT-001WTi-LH; Wed, 26 Aug 2026 14:43:25 +0200
Date: Wed, 26 Aug 2026 14:43:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com
Subject: Re: [PATCH v3 net-next 2/2] net: dsa: Add support for Motorcomm
 YT922x
Message-ID: <55523ac4-023b-4ed8-8519-293c778044a4@lunn.ch>
References: <20260825061610.3116673-1-kyle.switch@motor-comm.com>
 <20260825061610.3116673-3-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825061610.3116673-3-kyle.switch@motor-comm.com>

On Wed, Aug 26, 2026 at 05:08:02PM +0800, Kyle Switch wrote:
> Motorcomm YT922x is a series of ethernet switches including:
> 
>  - YT9224: 4 * 2.5G UTPs and 2 serdes interface
> 
> This patch just add basic func for a working DSA switch.

I asked you to break this patch up. I want to see lots of little
patches, each with a good commit messages, each obviously correct.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

says you can have a patch series of up to 15 patches.

>  static int yt921x_mbus_int_read(struct mii_bus *mbus, int port, int reg)
>  {
>  	struct yt921x_priv *priv = mbus->priv;
> +	int max_ports;
>  	u16 val;
>  	int res;
>  
> -	if (port >= YT921X_PORT_NUM)
> +	max_ports = priv->series_info->ports;
> +	if (port >= max_ports)
>  		return U16_MAX;

What did i say about this in my last review? This would make a good,
simple patch, changing all YT921X_PORT_NUM to priv->series_info->ports.

You first need a simple patch which adds struct yt92xx_series and
yt92xx_series_table[] with very minimal contents, only mode and name,
for the existing device. And add the code to do the lookup and
associate it to priv.

Then you can have a patch which adds .ports, and changes all
YT921X_PORT_NUM to priv->series_info->ports.

Then you can add .num_lag_ids and change all those references.

Then you can add .ageing_time_FOO and change all those references.

Slowly make the existing code more generic by adding to struct
yt92xx_series.

    Andrew

---
pw-bot: cr
