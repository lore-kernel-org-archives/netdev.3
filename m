Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5583F31F99B;
	Wed, 10 Jun 2026 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080412; cv=none; b=ZJkk5IcEEQ39pzlOP5YGGpjwutuROtuJmipEwyhDO1qAx7TztIs7pmPhJ1gB0OEYaQBgG+87Y9SBJwvXEagDOGRdtU6GWr1H6bgICyT/t4RNRTbDIyLnrsH3A19RGb8W8G7duxuemcDOrhI63AbElYZuYDh2ooWhdXXVwTBnav0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080412; c=relaxed/simple;
	bh=I8U1dqE0X3EJ1nwfVW9+ZRT3iLh4MgnVfV7K7ePH/KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRIWn6YVQDMbateBSiCv0PQwQliuFXSNpZE8bXzasF+YS+YTjyoSms+6puOXxfBrX8LJIcfhe6LyIa/HC6kDdkoTsK3FzqGVEhrd/hFJpnKvL3TO5sXAXoT2pW4gjDuOdCVmhTOxz+WUK5rY+ffxcciE7d98auy8pZ4HqCEUsIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4lX/HW05; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4lX/HW05"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4e2FYcgnoPTw69bKQJw/JJJ5zGcI1SiPxzhYDwsqlXg=; b=4lX/HW05thT0H0T9VWEfzGCvl0
	zxrGSl5tT03vJKTnTsCoCe4pXG1D7RS7aFgGDskIbkXyi7Db5U0OSbK9rf6mrbZWlhly8qDnSsmJK
	lWYGu+wFjnUJi1kw2TB6FZ9i+GQwl1Kqc7iph5ImsH0lTWWaqbMANQMeJdeaRFclG5Lg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXEN5-006wpW-4f; Wed, 10 Jun 2026 10:33:11 +0200
Date: Wed, 10 Jun 2026 10:33:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/5] net: mdio: realtek-rtl9300: Add prefix
 to register field defines
Message-ID: <411ffe68-f226-4f8a-8089-cde6b63808ac@lunn.ch>
References: <20260609052856.3142922-1-markus.stockhausen@gmx.de>
 <20260609052856.3142922-3-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609052856.3142922-3-markus.stockhausen@gmx.de>

On Tue, Jun 09, 2026 at 07:28:53AM +0200, Markus Stockhausen wrote:
> The current Realtek Otto MDIO driver has some define leftovers without
> a SoC prefix. When adding new devices there will be an overlap for some
> of them. Sort this out as follows:
> 
> - PHY_CTRL_CMD/PHY_CTRL_MMD_DEVAD/PHY_CTRL_MMD_REG are common for all
>   series. Leave them as is but move them into a separate block.
> - Add RTL9300 prefix to all other defines and adapt the callers.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
