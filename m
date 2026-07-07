Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19BC3EBF36;
	Tue,  7 Jul 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438068; cv=none; b=avOWUDn72TQJfddcFhzAO1yPpF4j9O7ZxhXLDIcYS1BvUWT3sA4dHh77oViYAzeDFapOBxBIuZre4uoe+sPRTpOWokiLnQI4OGfZlXWZ41+czVBYVipsMeUu9/hVbTs1d9axBW1ewTgbTOIUD1QPm7d4Pk5MJbf3hK4A9zcl7Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438068; c=relaxed/simple;
	bh=12OpZJuCaMunwiSZHOFEBBh41+3n7c89g4nF9GYtnq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhypDxu41MtbsyDR1LGT/2I3LdvKITmB+d76H1BlcHfZDhBtmR9oiCy+07m+vtnKR2DRPF51YeNMcA80mh49C/r+DrSivIZx+3EZ68LvIuZYL5Rvs4C/N61c7OZHUVwEbPdHn7wI19lgbtHP8tKjNKCUDWwTy7937gC2SlGdfxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Zcp97ptx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zcp97ptx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4y/PlnE2tBFmXtQgA4bQtJX6H+SETuZI4i3pD5DI9LQ=; b=Zcp97ptxanCT/YIrR4o0jby0IY
	K/H6HWhQsfKP4jzibm/lpZuPj2wiC0P6wKobx88x1HwugwqOPkJ5+aYmwsKo5HKTqqC4FzOICVQSV
	XaNGtYgJXjJaAtPM/xNKQ6VkVKdiE9L5vTpGB6v79Bs8wSW+2OxuzeFOtMDOaWF7kVDw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wh7ho-00BBVm-MI; Tue, 07 Jul 2026 17:27:28 +0200
Date: Tue, 7 Jul 2026 17:27:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] ax88179_178a: Add support for ethtool pause
 parameter configuration
Message-ID: <33b35184-e962-44ca-b0c1-ba9beb08c341@lunn.ch>
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-5-13685df67515@birger-koblitz.de>
 <587499ee-d87e-4056-8d2a-8fda2ef3f0f1@bootlin.com>
 <947860cc-de6e-48b8-804b-e27f27b2f82c@lunn.ch>
 <d2edb164-91c8-40e4-a104-db690609cb57@birger-koblitz.de>
 <46553470-9be3-4ae0-824d-ae85441c920d@lunn.ch>
 <833f79c1-39be-4c04-bc4f-3ec7a983ab56@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <833f79c1-39be-4c04-bc4f-3ec7a983ab56@birger-koblitz.de>

> For me the way ahead is to stick with the simple MII-driver and just make sure that
> features such as pause configuration are properly implemented. Please tell me if that
> makes sense or there are better ways.

The better way forward is to refuse to support the device in Mainline,
until the vendor produces a firmware version which is not FUBAR.

The PHY ID is a contract, it states compatibility. If different
firmware gives it a different API, it must have a different ID.

Mainline can push back on vendors. We can say only their out of tree
vendor crap driver will be used with their hardware, if they don't
follow the basic rules as defined in 802.3.

There are plenty of USB dongles what just work in Linux, because they
follow the rules. So i don't see it as being a particularly big loss
to Mainline.

   Andrew
