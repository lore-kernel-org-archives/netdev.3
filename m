Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC9431A57;
	Thu, 16 Jul 2026 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220515; cv=none; b=Km2m6mvKoMw2fDIeZt3Uewm/PoKVRtmE2sgsnpROOPXB1t9JN2O0P4w5KN+9vz7qLQXypblsM3sHF1DXLmKwJgw9bJUGQ1gXfLUDO4n6Pzfu/K7ipJkaqZpDCDpvWtbfnt0usA9Ick5/gBynkBf9lGvogQdr9Uf68Y44M7XKqps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220515; c=relaxed/simple;
	bh=x7RsXAv1jWvavO/ZVM2Ey9LKTMW7NRZNHv238+hNzWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcxI807ne8Mx4Nh2k2DV3+cli+PxEs1qLJkTHGYR8uefljVCPhUgNCD6PXCsA6rwi8DUmn+Yaou6qqbhOIPo3nffoToiwpqgRl4tu6NgyHOAzsIBdtCc7ou/MTbpghNk4wawbKJawB8XEWsMWEFhmG6XNiPwKXTYULdxW3p6niI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ddxm9mO/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ddxm9mO/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g76Q4pmDFdgsbzQPtcRMVR11iZGQrSVce0wDnwor4zg=; b=ddxm9mO/pvQ4NeEjQudSdPSZ3/
	y8Tql0fg3iRKEBojj9aIH0dMjIHPsfCKsAO5VLhOxQvFnQehG3rcL1UPR+45CWiWKQHt0V2cEbglR
	kxIFzeV63brPjSaoyE/vak5CtZGI9/e1aXdub4wZsMaOmsC5CskTS4luv1Vk3QixF4bE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkPFu-00CaRI-Ag; Thu, 16 Jul 2026 18:48:14 +0200
Date: Thu, 16 Jul 2026 18:48:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianmin.wang@motor-comm.com,
	xiaolin.xu@motor-comm.com, ming.xu@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [Patch net-next v2 2/2] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <cc9e3f9d-a3e3-4099-83a9-7204dbc4854b@lunn.ch>
References: <20260715121012.1113552-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715121012.1113552-1-kyle.switch@motor-comm.com>

> +static inline int ytphy_top_write(struct phy_device *phydev, u32 regnum,
> +				  u16 val)


No inline functions in .C files. And this is a PHY driver, it is a
long way from the hot path, optimisations are not needed.

As i said elsewhere, please look at phy_package.c. It might result in
better code, and a more obvious locking model.

> +/**
> + * ytphy_read_top_ext() - read a PHY's top extended register for YT8824
> + * @phydev: a pointer to a &struct phy_device
> + * @regnum: register number to read
> + *
> + * NOTE:The caller must have taken the MDIO bus lock.

Rather that have this comment, use lockdep_assert_held() to prove it
has been taken.

Maybe add a phy_assert_lock_mdio_bus(struct phy_device *phydev) next
to phy_lock_mdio_bus() and phy_unlock_mdio_bus(), to hide away all the
pointer following.


    Andrew

---
pw-bot: cr
