Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495B13BA24E;
	Thu, 11 Jun 2026 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182448; cv=none; b=Pp8vIKE64Jg51o7xeQ4bhcWGJ1rsZiae6sKniUT/OMIU7cxY7WatMJn2WCWj7rtBXfLHWPxpP5cj6iUL8gplUbGvHnd4T54cCUqX+uxwBo4gztPOqzTIy7oN8P4q4LEDjWCeDD2pWwdF/5D4kRTR5Ur6ngM4HR7djXDo95LK7R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182448; c=relaxed/simple;
	bh=DB1b/zE7yNW4BVRYZVyrzDr3oeKzzGbsNJ4Knw0UBSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EU1mKMTjAD9JL3A9O+g3ygWkQJneS2ZaDow9loohiIjZzzao5Y06VB9avfnNAjC22rQtH7sp6P50Y/EP3OSssTIv0t0vJfm9D5nONQ+9sd/haaIBVJ/1qDT/waUNubmMCPoTc+i9n3Nf+orwrrkDICqjMsGfjlUtpmXmRBIF4GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oJUtp19S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oJUtp19S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eWMyFYQOlebPl3WgHaKU8b57HiaBmqEtV4qe+nwXb0A=; b=oJUtp19SAn79+RsQj6pCibv+Ij
	+jPNnJYZKyiLFJrgZgWrBFB+qvAW4OeZN4eomNrWrSxY59mjcBEcfenvOzNSEkv2zJOunzT4c+bYc
	vkvTmrcr/ChWIhG2oGV6/xVvMV4pXTgI/A1sgQBls69jbU6jy6BogaI9hH1JfMt4vS9E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXeuz-0079qz-4h; Thu, 11 Jun 2026 14:53:57 +0200
Date: Thu, 11 Jun 2026 14:53:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: george.moussalem@outlook.com
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: dsa: qca8k: fix led devicename when using
 external mdio bus
Message-ID: <92bdf851-bc96-40b3-a5f5-d086a6e79349@lunn.ch>
References: <20260608-qca8k-leds-fix-v3-1-a915bb2f37ae@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-qca8k-leds-fix-v3-1-a915bb2f37ae@outlook.com>

On Mon, Jun 08, 2026 at 11:22:08AM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> The qca8k dsa switch can use either an external or internal mdio bus.
> This depends on whether the mdio node is defined under the switch node
> itself. Upon registering the internal mdio bus, the internal_mdio_bus
> of the dsa switch is assigned to this bus. When an external mdio bus is
> used, the driver still uses the internal_mdio_bus id which is used to
> create the device names of the leds.
> This leads to the leds being prefixed with '(efault)' as the
> internal_mii_bus is null. So let's fix this by adding a null check and
> use the devicename of the external bus instead when an external bus is
> configured.
> 
> Fixes: 1e264f9d2918 ("net: dsa: qca8k: add LEDs basic support")
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
