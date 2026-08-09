Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEE02FFF90;
	Sun,  9 Aug 2026 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786312316; cv=none; b=kgCFL3Ab0wQrDUuVJc/gyYGfTCEjxmogdZdqtPbjPUsYfjXc1Vrh0JdQxR8aLQ3arjqxITICPtFgmm8baOYIWd6Z0qVmlGg5xPwTtuREC8TMdk4JrDDNiz9ervFXTNDqReyUT09XbBc09Tw7ByHVWtyt6K6KkIC9pxL8OFLZ8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786312316; c=relaxed/simple;
	bh=32nzNJGkgR1in1/rVOun3c3l1aNTmqNCfnR6g+UXbDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLMsGtx1B5Ox0WXeQa7bf1dmUgA14Hhm2uua41j6ow1j8323ykV1IO/p2a+tbyC8OXURiq3hIVrVL9hjwGFUeKJkrkDo4h11ONIG0Gkd6ruK79lJSUmBMo+b/3s//ms+3WVu/EChWmhiScaOg2MqXzUlOyIW9ZWzh/pcrEkKqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KArUOMyW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KArUOMyW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zVBXpD6p+LO/AQNj0KJE+h3LxuT3nPPrbVGOJvUyE0I=; b=KArUOMyWROacfVSFAFkDSAlulr
	VkXP8qvdO1hSrVolTFaJpq64falRjpXJM8fYqfd7tVBZ4Ydy7jiUuSTLhjevyZ39LbRmffSSMphH1
	kmzKvlbvH5vTKriUaWy5O43TYcaFmacsTFQE6ebYpPkygo8aJmCgooX8cWBOrCJ/yk/Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtBQh-00GrH1-IF; Sun, 09 Aug 2026 23:51:39 +0200
Date: Sun, 9 Aug 2026 23:51:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v13 05/11] net: mdio: realtek-rtl9300: Configure
 hardware polling during probing
Message-ID: <c0a3307c-d41e-4dac-a5f1-754412641881@lunn.ch>
References: <20260807171058.522833-1-markus.stockhausen@gmx.de>
 <20260807171058.522833-6-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807171058.522833-6-markus.stockhausen@gmx.de>

> This polling enabling/disabling does not solve the current inability
> of the driver to handle C45-over-C22 access during normal operation.
> For all existing designs this is not needed.

How about adding a WARN_ONCE(regnum == MII_MMD_CTRL || regnum ==
MII_MMD_DATA) and return -ENOTSUPP.

That makes it clear it is not supported, and any attempts fail, rather
than cause silent corruption.

     Andrew
