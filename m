Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22C4457AE;
	Wed, 22 Jul 2026 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745817; cv=none; b=jSlVYANM0ZvHqts6Gn/ryV34WzUJL5xoSmdSQNqkYQUhWdJxNgHqODjaS3E3Qlq0GvxSRjxkJAQo9YyazdBvV67wANmWEnny6LqF8vUMthjOEM2tui35R82twC99aKtCw1KHkWJy9NThyTy833NeU2AopOkftQSYTDu41vNYNFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745817; c=relaxed/simple;
	bh=Z9GkqvwuqLgAAcrinM5JRNG6kTI5e4nOY+Oit8wefJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehMlAiTRvmYOLGODTuC+CYDPbIftMrES67thIDHa8vJ0Kb5kkwsDDq8Z6logBy63sdJMUF/OkjmXUf5w0CjUDmldRBzbzuDkrWUssSgKIGdVnmIwclEY59ioEhElRrEfBhw5KA75DECZN2H0ae8unRgSHZRI36V/wwXcS614Jmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=11VirxSQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="11VirxSQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5qLQxpw9eIzC2pJyjf7vgJvOPlOHLT4SHr9gT4vTBhU=; b=11VirxSQw4mUydCBofBj9QaPUt
	1WgTqYhvxeRzQAfpOB8fwtQrhNrOFORDM1f+fYgIeP6LZKYtqi1c5CmuxrLUBcURKg/eRhBfQzSWE
	zTn1Too5It33i6gE4X7giTN+5n15bvdGxU194a3ImTJn5A7Cqsa6eT8ck2uqMEjBcr38=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmbuT-00Dg6H-VL; Wed, 22 Jul 2026 20:43:13 +0200
Date: Wed, 22 Jul 2026 20:43:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/8] net: phy: add
 (*notify_phy_attach/detach)() hooks to struct mii_bus
Message-ID: <9e40f50b-357a-4a93-9f59-94847850835d@lunn.ch>
References: <20260722062356.12291-1-markus.stockhausen@gmx.de>
 <20260722062356.12291-4-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722062356.12291-4-markus.stockhausen@gmx.de>

> +	if (phydev->mdio.bus->notify_phy_attach) {
> +		err = phydev->mdio.bus->notify_phy_attach(phydev);
> +		if (err)
> +			goto error;
> +		phydev->mdio_bus_notified = true;

It is not normal to keep state like this.

I would expect phy_detach() to only by called if phy_attach_direct
succeeded. So phy_detach() should just call notify_phy_detach.

If something fails in phy_attach_direct() after calling
notify_phy_attach(), the cleanup code should call notify_phy_detach()
to undo what has been done.

   Andrew
