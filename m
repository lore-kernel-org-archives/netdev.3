Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A647F37C11E;
	Thu, 10 Sep 2026 02:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005825; cv=none; b=AwnY++H69W7AV6KuVbzHeDX+QSlB5sIcMN/5j0HmEkMxKc+crVGWtChqW5Olw/U3yz5B5nKbvchcEek+p6Gw54E5dEhW+yJe6MGmpgB2JQh1Fb1dAsQ7jbVJkSxyLX/O6PJtztq2Wl56Xd5tQJn+O50gjUmlYAHIpVQ2Gk2i8Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005825; c=relaxed/simple;
	bh=xlRJ72FwZfHDaP0FN7zJaI9aT2tpdo9YaK9aqOKWLO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxloXcy9jaxI4KoNoGmstRATNEB1SmOMuYFOvFSSiV8Vp47XWuyeJnZ+Zr+JqDP3J3csZHqx778VnH8QvUrMaRI6DlHE/CNRq6dxy0+RuTUknZlMtRmPuxCuO8bpd04lWAXS7aSI2hF3/oqly42HByikAhcUZDEhVN5bbrOml7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vj6WK+cb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vj6WK+cb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7umdtFMYt4QzNXyY0z0IHE2wl7o8dhXEhulEfNUzqAM=; b=vj6WK+cbok/TUQYZrOVxfYfxuR
	hQLFsrOXPkfyzWMRvmxhISh6Fqdh53D4aZYMNtU/iyEx1SYFtLx4tUtK+ngJuTjxSSVpyIX4vQ9jN
	uVt2q7w7DvTFAKFOJbhOujBClJaZDAHFTgiTKuKD8oiG9e1rIrdMhWVXTTHGVcXRpcTc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4U8F-004Pvj-3b; Thu, 10 Sep 2026 04:03:19 +0200
Date: Thu, 10 Sep 2026 04:03:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, dqfext@gmail.com,
	SkyLake.Huang@mediatek.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Subject: Re: [PATCH net-next] net: phy: mediatek: support MT7530 PHYs on
 EN71221 MCM
Message-ID: <746ebc26-e4ad-4988-a839-c5805d7ab319@lunn.ch>
References: <20260909213250.3184238-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909213250.3184238-1-cjd@cjdns.fr>

> +	/* Clause 22 local data. */
> +	ret = phy_write(phydev, MII_CTRL1000, 0x1e00);

Please express this using

/* 1000BASE-T Control register */
#define ADVERTISE_1000FULL	0x0200  /* Advertise 1000BASE-T full duplex */
#define ADVERTISE_1000HALF	0x0100  /* Advertise 1000BASE-T half duplex */
#define CTL1000_PREFER_MASTER	0x0400  /* prefer to operate as master */
#define CTL1000_AS_MASTER	0x0800
#define CTL1000_ENABLE_MASTER	0x1000

Once we have symbolic names, it might be obvious what this is doing,
and if there is a better way to do it.


> +	/* Vendor profile disables 100/1000BASE-T EEE advertisement. */
> +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x003c, 0x0000);
> +	if (ret < 0)
> +		return ret;

Any idea why? Is EEE broken? If it is, phy_disable_eee().

    Andrew
