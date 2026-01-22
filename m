Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E77F30DEB2;
	Thu, 22 Jan 2026 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089630; cv=none; b=XHS1OU6iBnRcY2BdzI6kPu2w1Er+IADTicmBo6qPLKqEEQAduBwf/yIS5zG+VEtv7gx/svF+zTsQEUMbqDSkLM2EgXoQbYpM7xnTFJ7BVmVmZrrNMnGFzKB7ZPKic3JM8v5P8r8tKLLf4gCF6ghu2c+GMoZrKPEbGBpOV7vHOH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089630; c=relaxed/simple;
	bh=5a4oXbuQ8xqp7SWWO+B/Tny2A1xi737t+ltPk/RBq24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxy/M5cNW//J/IS9LydCP8LKMP9W9gmgR0qOwE3g7tb09k2VAPiCfkTvWEOjrfjlcLnJSpFlZrPicQzeY9efCJQhc1K5+ScWeiPFdykxIpaA4uiKV+SEXJef1F7KY6iA1aAJlJrAyzwRyezcoz0Wx20avdDJ/eev4CjN9q0px8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v0Jfga2C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v0Jfga2C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=s+UoEP8fgFNioiA0cQfrXKdI1DKZEfP1zLyt65J1dQA=; b=v0Jfga2C8MpXJpBNihWG45WisM
	vKBrHOcerdnd+qpD6iNrBdTsC88xvl8oJRScp8w8uTY0Mlqq0dkb+6QjtsS9T90ckyeG8lrCyIcXH
	Wunzn1j1oHSd7K0CiUKo2d1Luw5H0L47W6b5oaRYRilXYDB581iLAgGD+QGoVahnotKE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viv1W-003yin-8p; Thu, 22 Jan 2026 14:46:58 +0100
Date: Thu, 22 Jan 2026 14:46:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: Re: [RFC PATCH v2 2/2] net: mdio: rtl9300: setup PHY polling
 registers
Message-ID: <8663bcdb-4c53-45f5-88fc-1f01f816e8b0@lunn.ch>
References: <cover.1769053496.git.daniel@makrotopia.org>
 <680696024a8648535ce6dee771fe4de67802e0e8.1769053496.git.daniel@makrotopia.org>
 <aXITnCLt945xHqaP@shell.armlinux.org.uk>
 <aXIke6nASlCSJVuF@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXIke6nASlCSJVuF@makrotopia.org>

> Only a small subset has been seen in the wild inside RealTek switches
> for now. Most, of course, come with RealTek switches. However, it is
> only very recently that RealTek offers 10G PHYs, so before vendors
> were using 10G PHYs of other vendors, in practise I've only seen
> Aquantia.

...

> Yes, that does sound better, especially with your concern about
> ->supported mask not necessarily being correct at probe time in mind.

FYI: The Aquantia PHYs are particularly bad with ->supported.

	Andrew
