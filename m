Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D186182D0;
	Sun,  3 May 2026 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777770087; cv=none; b=uzdDTO+8f1Th6h1Kyupb9eYkua/pPyjpTvR0UhNLkmzFNRsAPZzWep9roheCNfTI7F3V+TK8XzoXs2Abq+ToAo5OVaUMdz5uYGmcXbJFJUuhEElP9ainKry/qwRRIa7WBiLL2fO3y+MDSn+wRdZarJCYeLwpcK8XaDa5HONBxK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777770087; c=relaxed/simple;
	bh=XDxcAE57Vh+QD4qQRFdtjw4UoQU1NSO56auf9NBefUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWLNi+lLKhnep61QjTgjwEori6gEML+e+WcOzKuu7xC6JyU7nGQ5MgP6bqjBQwtuG3XOxrgfaTE0vs+1WEqbkOsVfafzyKouqt9pPYVZuOUggmPz4ICOQxBK3ovx04TMpUu4Ro9XPzrPEvACF+Cq6zXyTP3RTm5Ml1ih8OJZfeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PX0xo7Fh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PX0xo7Fh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9mkuMFVnzVmlXRG17VoJ62f7p9TbirL7O14CCQUl9xI=; b=PX0xo7FhjHB3ptw9cj9tb5aaE+
	4b7kA2//6wi8Kxa4s191Pd2D1qacfDPCKPzO0hCoBDKFMRN9D3QLNeDnOtYm9PrDPIuU45BHl/sW7
	hT9I9QvZf52nwbpL3kfpvOCa1xX4ikkFS8KvyGq2OVPW2qfL3c79HTdOFVd0QuPuejZI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJLCt-0014KH-ID; Sun, 03 May 2026 03:01:15 +0200
Date: Sun, 3 May 2026 03:01:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ciprian.regus@analog.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] net: ethernet: adi: Add a driver for the
 ADIN1140 MACPHY
Message-ID: <3ae44fef-4106-4191-b48e-b2c5a952ea3c@lunn.ch>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
 <20260503-adin1140-driver-v1-4-dd043cdd88f0@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503-adin1140-driver-v1-4-dd043cdd88f0@analog.com>

> +static int adin1140_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
> +{
> +	if (!netif_running(netdev))
> +		return -EINVAL;
> +
> +	return phy_do_ioctl(netdev, rq, cmd);
> +}

phy_do_ioctl_running()

	Andrew

