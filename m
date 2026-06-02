Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A313B38B6
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402004; cv=none; b=jG4f74Cfcsnj8KDygZgdKkuZ56Xc65T3SMflkg9qAjanwqThygZlCVVsx/J/+jOUano7rJbTdtwgIv7Axk9/Xl+KfasjuRhY6XLrN86CXJnN52yVD+h4Mecv4vtCvZV60FiiNjLUbDmXxhUY4EpVxSk6XGSc+4qpkKC5zZ0laBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402004; c=relaxed/simple;
	bh=/lrA+DD/mK4kl3B4talvhK7Ttq+E6T2zzJDX056MJ3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e18gFq+EQOx7Q+ip7vZ8i1epMTd2o9/ceK9OISI7NRNr7wWH4YzFTlgnBOzbpmZoD8u6aH5dDB3nUxYY2+Acanr5x9xR+AYHqCfbZS2PGNbEMp8HOrZivgIACxOvBDOpOpQRpm02xhu/JEcPwTNuziIqZ3AJqH/bflfMhXw87O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OeG+DM6n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OeG+DM6n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DyKZGnOMszE1GbJaIgu4eJw/NQ4BfsKhIYKkkMHTOpc=; b=OeG+DM6niqMLOrLKWXF5hRiyNt
	YtL9fQf561zxHaB4G4rKMCcCuPqpDO84MNE9LI6Lu2Qrgl0pVOZy9HHOQkdYeatO1KO6qWRlPL0a3
	ogzXx7vwMf+S/GPgVOmFeHb50t7KfJjZedthk6C5xGLPa7CPUXMNw5IqHWhH4N9TvKQQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUNt5-005gIO-HF; Tue, 02 Jun 2026 14:06:27 +0200
Date: Tue, 2 Jun 2026 14:06:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, mensi@mensi.ch
Subject: Re: [PATCH net-next 1/8] net: mdio: realtek-rtl9300: Convert to
 fwnode API
Message-ID: <3b54c1f3-b60c-4e97-8e14-fec10cb1030a@lunn.ch>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
 <20260602052640.93083-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602052640.93083-2-markus.stockhausen@gmx.de>

On Tue, Jun 02, 2026 at 07:26:33AM +0200, Markus Stockhausen wrote:
> The driver still uses legacy "of_" functions to determine the port mapping
> during probing. Convert this to the modern fwnode API. With that also fix
> a subtle lookup bug in the original code.

fwnode does not exist because it is modern. It allows you to have
other bindings, like ACPI binding, using the same code. Do you need an
ACPI binding? Have you documented this new ACPI binding? Has ACPI been
tested? Are there any OF properties which as listed as deprecated
which have been converted to fwnode? A new binding should not start
out with deprecated properties.

	Andrew
