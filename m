Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A85340A41;
	Thu, 19 Feb 2026 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513037; cv=none; b=D7F+xsrLivTKw6tnkT3Jx/mGF2hfXE6l7LbJ+qH54uSDaohcA9V1OgFsfEiQ3L5VZENU5miUgpL9mZ9sFMOWBkQ99ya07t8Ueb8OMCzALgBTKCbScVBie9YyRUHj/orZcj57aniXWOrTPh9xl7/9BBveiVgbRjZaBAjnECwPerg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513037; c=relaxed/simple;
	bh=94B6Lsm6D2Q/Sghrk98D44GP75slA+JbI+MX3ooEOp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mke73qPA9MJfnC0DX/sjZwtGKmWNd1Wt4h0JYlYqWR4HDgzyK0W8o/GzNNDghv8gVggBZswy0BFw4GFqSCw4Ju08i2y6oD0pQPayONiOBCuhxwftN3ACvxg8YQUGoKnqOUgaVj7MS16LxS08lirsTyr1LsB/rnmD3BTmQtTHh+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CQKRmh0X; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CQKRmh0X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uBNavfOIwUyk3lD5ni6+njwKkkWNLweWNL6akkR6tGo=; b=CQKRmh0X60U2gzbkaafer5aLWQ
	eJ/IbKY+gpn4C4kt/yBMI8aGrKigsDDgWV63owbU25bFSnXfLLTWhjNWNbuYiyVlOMjVmYZaVX5Rr
	1XKLwLKwbwiUoT2V/idifcwPMW41tOQutaXvA1rT23ztsiBgiozuX0TGizWPpoG+m0oFVTrbWj9w8
	NnfL8qmXHNSEvRkWwSmt0tqcoXVpbUqXj/FKUFiEYg0gsNtyCEgr0RWztIxzIApEfS9XMQPaROej5
	AzKVskNAvduqZUbkO5ILHlCN7YOsBxvhgZUaLDHAkqR38fzmOhKGMGnnRLUHWvucAboqbmKZK+0bf
	ZQgqHRvA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58698)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vt5Sp-000000000zE-3DDd;
	Thu, 19 Feb 2026 14:57:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vt5Sn-000000003PT-0Jvt;
	Thu, 19 Feb 2026 14:57:09 +0000
Date: Thu, 19 Feb 2026 14:57:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: microchip: lan743x: add ethtool nway_reset support
Message-ID: <aZckxGvOx8QnkJVE@shell.armlinux.org.uk>
References: <20260218195615.25655-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218195615.25655-1-nb@tipi-net.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 18, 2026 at 08:56:15PM +0100, Nicolai Buchwitz wrote:
> Wire phylink_ethtool_nway_reset() as the .nway_reset ethtool operation,
> allowing userspace to restart PHY autonegotiation via 'ethtool -r'.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

When you resubmit for net-next (please read the URL Andrew gave you)
please include:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
