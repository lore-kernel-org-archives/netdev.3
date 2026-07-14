Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A8842B75D;
	Tue, 14 Jul 2026 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784065572; cv=none; b=QDSntZRI9sTWAidoE1ShgATIYIVH7icslXEHGtuLfzZaEiiRmV1KHaf7wvI2YxfC8S15wTqllSsRB5qfnmmrRmZ74gs3Go1JsRttqSFm2oIvXY0CjD9wAsgjoGHsGaD1R4Y4WH2mDQWr2aSI7BSN1jEYEowHVgZesht8AKhVCSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784065572; c=relaxed/simple;
	bh=DOzDETjKS2qvwsCg74pGfhtukU00woYoc0qw8j2wi8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4bmwI3nSTBEZI8FED7CeGwelLKqdiVjZV9RYKTNln0Y8j3M5nsAFNlR2OIT8xbQ3wbYXZ+fPocWbwKIIQsCClN4UzrKEgEtrZgZyRiNl3Nrzt+RVCE/E49Uv3OskiPZLAgJAXsuozi9ugC1RWhp+VvLhUm9rb+3AECk1qYWJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=18ktEAwU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="18ktEAwU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6PepwHkFASb8sxqIxg49RH3q+Q4v1E7HSP8MSKVyFNk=; b=18ktEAwU/P2/tfMPTvJdnHadkL
	Em6B0WIStzJLXxImiWg5r/4/C8n7fZLfQzV+8CrodKGrmXP9Jjc2O4xHmnw5Zj+H4Druw+z7oZIgW
	ctGLqLUCWXvcLkkGwld69WBg2rzgPW1lNfn04rE5j0ud7Zs0N38M+9Kcqi03QJOlwQXo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjkx1-00CFsq-6v; Tue, 14 Jul 2026 23:46:03 +0200
Date: Tue, 14 Jul 2026 23:46:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianmin.wang@motor-comm.com,
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
Message-ID: <46c380a2-74ab-4690-a289-6050cb33c1a4@lunn.ch>
References: <20260714111203.3852126-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714111203.3852126-1-kyle.switch@motor-comm.com>

> +static inline int ytphy_top_write(struct phy_device *phydev, u32 regnum,
> +				  u16 val)
> +{
> +	struct yt8521_priv *priv = phydev->priv;
> +	struct mii_bus *bus = phydev->mdio.bus;
> +
> +	return bus->write(bus, priv->top_phy_addr, regnum, val);
> +}

Please could you explain the architecture in detail. It seems like you
are accessing registers of some other device on the bus.

Maybe you need to use the code in phy_package.c?

      Andrew
