Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466CA30E821;
	Fri,  4 Sep 2026 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527262; cv=none; b=WRsY7F6DoKBgr7IDfnFIvTHWhYNiHa/O6+h4t5kIuSh7utEvymCjXjGp5rLbllfvC7UJ5gvF0Eno8GiT64a6k1tNF4VYSJ9FAFjbCXTVe7GKA9cMCuVBawd0809a9jssFfK4y3swKAYmZWfm7UofSCSdCTAvhCjQgsc2gD1nZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527262; c=relaxed/simple;
	bh=ZFcXSfVpjsp3ea8ffT98/0V0MTOKphrYDS/7Rd5MSVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2/d/swQAYJOAzFuU6gohkWCI59XW3uTGvrcI/DqwAHFOVH3vdXGw9Xa/YLaWsMngav8iEspfB8zNBFs/eLPPzkoHYW1TZ890BwJAqAba7jswi4hUjP5W+gyQ36Ly/7QsqjRxCFJmjhX8uTom/nf0tEKdLctqN1sXgP9yzbZlAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cTtvLoen; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cTtvLoen"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=s3pOQD5MihH4j6xIkfsCXZKy/aeDg6skrvyfrq7MlcE=; b=cTtvLoen84bGX4CvN/pFZEUw+J
	KPREzWcJITQNGQ/CSCvkDhO5DwoiQpexCw3HT5/B8bV21PDmTzkYCzbi9Xn2fljy0dUodv6SF0rA7
	Rj3PNfEKVJAT+FMqEqbSeH7n81L46l5UBOxuRf0bNJCVF3yyYsGb/u6Yfkfc5p0BK8ps=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2Tdj-002yhW-Gq; Fri, 04 Sep 2026 15:07:31 +0200
Date: Fri, 4 Sep 2026 15:07:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: ethernet: oa_tc6: deliver the PHY
 interrupt to phylib
Message-ID: <844a369e-3e52-4489-b8b1-d359789bfcb3@lunn.ch>
References: <20260901130948.212914-1-parthiban.veerasooran@microchip.com>
 <20260901130948.212914-3-parthiban.veerasooran@microchip.com>
 <713d8963-6aa6-460e-83dc-157d37d66662@lunn.ch>
 <624254b3-2aa3-47e9-aae1-d62b2dc3f5f7@microchip.com>
 <2d313e42-3fbe-4fc9-bd57-23a951d997b9@lunn.ch>
 <a01b3780-b36d-4544-a372-9daa3be20a9f@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a01b3780-b36d-4544-a372-9daa3be20a9f@microchip.com>

> +     /* Populate all irq[] entries before registration so
> +      * phy_device_create() picks up the virtual IRQ regardless of
> +      * the PHY's MDIO address.
> +      */
> +     for (i = 0; i < PHY_MAX_ADDR; i++)
> +             tc6->mdiobus->irq[i] = tc6->phy_virq;

Yes, or just a memcpy().

     Andrew
