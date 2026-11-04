Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793764051;
	b=pnJBq/+eVRpVLP+IBbus8TPby5dXUY2XZVy2iGOyitfRu8MhyjYScHuVu2VHD7rAsllm
	 zgY6syIpyXJeQq5m13Js06b5mfzUTv9H7KCwtxTRbdCTqFuRlATxRBOqkWEj1ia0CAoOC
	 ivc5DOItRvf5l6A5dg9ynMON/Fy6g6yMhWyVg8z+YylU1XElbCGa78jcR0wJZmZbMyUuQ
	 sR7b9+IhIxaSGX7wRVqGAroknm9VGmK7rDuVQhfar0TzRvJfyvTW1aa62CXXKEEfOziDd
	 A/sCErJfYQEy+EGVvgZEcEwUFuMpugKT0zBscwsj4oiqyMSqgrDR/pfOMYZep0/dpYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764051;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=anENukeyGCErDFQZNu3WJp6VnCz6+leAQwN64BZAi5c=;
	b=IngwgJRpHPuTcA4AWDw/JL8xk0p32fQFcuc8ubKof3CwKCwa0iCM2Ys5vs3EiJgJRS/E
	 QXDhshDomDS7hR91PhG+7wq12rmLm3kiQyxpuObKGJclEAOqxzb4C9Kh1BQaIzyfgzCLa
	 w8tRrXg+sjLO3QRXO/XSgsY29A87v0b53zZmusjF6GU9SGFPih1ITz8N91xdUfAd41d7u
	 q2ZDnZJ6Fjwcnl+T0j08y3lSmXi5gURVEGF6KZz/XPBTPIBo+CSbxLDUT9TJJhaXJZggs
	 7cFt5U9SUttv7Mbvy1lbtxScJLTF/4/N95Hn+yQOCub71bzzXTxor1lyDF12R0Nk8nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=fUyYMLAW;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D1606A326;
	Wed,  4 Nov 2026 03:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C3D1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=fUyYMLAW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=anENukeyGCErDFQZNu3WJp6VnCz6+leAQwN64BZAi5c=; b=fUyYMLAWj18oT0ItksI3a7iwqW
	ADJ3JN6Ut4kUYAT9NalLP52L4f/gMjb7e6ldScl/k31EuuNgc4Y98ziNoTFxlXO1DPxWyhxh2MZI9
	tLf5OUvHXrahfb58uXblJ2srXpFvI/A23Raa+rc9gpK8HdzI6nCERYk3/uuZTIsZp/XQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xORxt-00EESW-5H; Wed, 04 Nov 2026 04:47:09 +0100
Date: Wed, 4 Nov 2026 04:47:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Joris Vaisvila <joey@tinyisr.com>,
	Ahmed Naseef <naseefkm@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v4 5/6] net: phy: mediatek: add calibration
 logic for AN7581
Message-ID: <2b744929-609b-4529-8b6b-30feb3ebbbde@lunn.ch>
References: <20261103221439.30502-1-ansuelsmth@gmail.com>
 <20261103221439.30502-6-ansuelsmth@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103221439.30502-6-ansuelsmth@gmail.com>

> +static int airoha_cal_cycle(struct phy_device *phydev, int devad,
> +			    u32 regnum, u16 mask, u16 cal_val)
> +{
> +	struct airoha_socphy_shared *shared = phy_package_get_priv(phydev);
> +	struct phy_device *phydev_p0;
> +	int ret;
> +
> +	phydev_p0 = shared->phydev_p0;
> +
> +	phy_modify_mmd(phydev, devad, regnum, mask, cal_val);
> +
> +	ret = mtk_cal_cycle_wait(phydev_p0);
> +	phydev_dbg(phydev, "cal_val: 0x%x, ret: %d\n", cal_val, ret);

What is the locking scheme here?

When using PHY packages, the typical usage is:

	phy_lock_mdio_bus(phydev);

and then use

	val = __phy_package_read(phydev, X, Y);

All the read/write helpers are __ indicating they assume the bus is
locked.

Here you are doing something similar, accessing another PHY in the
same package, but without locking. Is that safe?

     Andrew
