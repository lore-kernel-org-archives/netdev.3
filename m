Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CE643E49A;
	Wed,  9 Sep 2026 20:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986010; cv=none; b=DQ28l0WcwTMg+n3teEBnKbBSDfnlvqko9nYRe6WGCkNMR11yidAbwrQt+KsE0X0OLEQtA+gwpeXndSXv05L78QiWcns+uYzv5fV/64CmRPnHSgxw7OTOA1ldgMM9fXQ4AA2GtX+3JeJtCudjVsktg/yFFeCn7eeu3Au23nFH6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986010; c=relaxed/simple;
	bh=RMAu/QNHXEM/oR4TK8SNDcoL1VMXdPVO5VZmdFvUeKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1ExOkZKmBSJKM7ZY4Ag5JEs5XfoKG7UG/x1SucNXYuPQVUmRUH2I4HzUAKCiZCikdWuyM6RGgzK9/HlWgRfQtXo+zz3VMuie0EeL3pK7f8czW4sX52dS39CBwAm7U0ukggwM0ZdfanWqFBUNOTyc0cZJ5PBdTUmA5/9uOZ4z78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz; spf=pass smtp.mailfrom=email.cz; dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b=GoVYhoIK; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="GoVYhoIK"
Received: from email.seznam.cz
	by smtpc-mxd-7df9bfcc5f-xt28s
	(smtpc-mxd-7df9bfcc5f-xt28s [2a02:598:96:8a00::1200:70c])
	id 63d7209ce3304a0161a31ef2;
	Wed, 09 Sep 2026 22:32:33 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=szn1;
	t=1788985953; bh=jogMKRYJWaF8PeTu3z07YD/N5tIeVwYkeypfnTb5Rsw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=GoVYhoIK2rmpf25wqE1Fq4mmcWKXdrc/a7/pdROuf7ozGe76pX+tvhvduEIod+X4f
	 NzA8he+GtbedLDsmEIlIGotP1ZIOn/SngHnx0Kcrh8LCL5mbx6t1qjOnpsRmHpJSme
	 KVsEfOJ7zgdVy2qgD8ZtidNI2SMwyfzWDHXUAqaFb5V2D8BFl6XUps2HC3BaxvNLsp
	 2+BAOaXwW85XXDK6/VedIJ6kXN1p/npVWmr7nYa/mMPaPrIgP3pBRJszprLUcQXg6e
	 9VH4RYrwTfOMhg6Bxm6tZ/NHoO62ZzSKxCUg22FK2cUmma/cOK+gn5+k+kPM14kHBa
	 FSaYtCJqpGwhw==
Received: from arch-zen.localdomain ([2a02:8308:b086:3c00:3636:4bcf:b8c2:e5cf])
	by smtpd-relay-7887d69dc5-j57bt (szn-email-smtpd/2.0.82) with ESMTPA
	id 03700400-fae3-4b33-9877-78ea5db3103f;
	Wed, 09 Sep 2026 22:31:52 +0200
Date: Wed, 9 Sep 2026 22:31:47 +0200
From: Jan Havran <havran.jan@email.cz>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] net: dsa: lantiq_gswip: SGMII/2500BASE-X and
 flow-control fixes
Message-ID: <aqHCM6M_1SpVfLKI@arch-zen.localdomain>
References: <20260907134818.16670-1-havran.jan@email.cz>
 <ap7yeykTFK0nNbzz@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ap7yeykTFK0nNbzz@makrotopia.org>

V Mon, Sep 07, 2026 at 06:22:48PM +0100, Daniel Golle napsal(a):
> On Mon, Sep 07, 2026 at 03:48:15PM +0200, Jan Havran (Advantech Czech) wrote:
> > This series fixes three issues in the lantiq_gswip / mxl-gsw1xx DSA driver
> > found while bringing up a MaxLinear GSW145 over SGMII on a Marvell
> > Armada 7040 board, with the switch CPU port running 2500BASE-X and the
> > user ports at 1000BASE-T.
> > 
> > Patch 1 reorders the SerDes NCO clock-rate setup ahead of the SGMII shell
> > reset. Without it, only the rate the switch was left at by the straps or
> > the boot loader links up; the other rate comes up but forwards no traffic.
> > 
> > Patch 2 adds the missing SPEED_2500 case to gswip_port_set_speed(); without
> > it the CPU port was forced to 10 Mbps at 2.5G link-up.
> > 
> > Patch 3 corrects the GSWIP_MDIO_PHY_FCONTX_EN field value (a typo present
> > since the original vrx200 driver).
> > 
> > Tested on GSW145 hardware only. The register values are backed by the
> > public GSW145 data sheet and by the driver's own field encoding; the
> > xRX200/xRX300 data sheets are not public.
> > 
> > Jan Havran (Advantech Czech) (3):
> >   net: dsa: mxl-gsw1xx: set SerDes NCO rate before SGMII reset
> >   net: dsa: lantiq_gswip: handle SPEED_2500 in gswip_port_set_speed()
> >   net: dsa: lantiq_gswip: fix GSWIP_MDIO_PHY_FCONTX_EN value
> 
> Thank you for taking care of this on a board which allows you to actually
> test it -- on the reference platform I had to develop the driver with the
> SerDes interface of the switch is hard-wired to an MxL86111 PHY, hence I
> could never test 2500Base-X mode.
> 
> Whole series
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>

Thank you, Daniel.
We are developing a new board containing this switch and we found your upstream driver
in a much better shape than the official Maxlinear driver.

Unfortunatelly 2.5G did not work for us because of the missing SPEED_2500 case and
1G did not work because the switch was left in 2.5G mode by the straps.

But with these fixes, this driver works great for us.

Thanks again for your work on this driver.
Regards,
Jan
