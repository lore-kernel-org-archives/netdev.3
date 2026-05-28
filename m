Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7569317A2FB;
	Thu, 28 May 2026 02:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779935477; cv=none; b=B4cXw4iUtEECjw+ylHJgzGy2kDtX6ktt3Nxf0KKxCM8qbAyLmW97bAhpuM9d99mBH79es3m2im4ceEQ7AU5MNrteOUZNCYZX4fZgokCaSf06SGMDso7rhb9UPva5uZ8xn2mc9jTLCiiB91ypVFDEqhx5kZDYVsuxuuHI9rWp7o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779935477; c=relaxed/simple;
	bh=QXG4NoFFgfCQ/linVMkGqNEiHmD8eKNJ+CBWQ6RrjuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXEnkOIM/4aJ59fPOA9SrTJCiBbP/m6waMwn7irsOmJ0B+/d6ruV418Fakqh8hrxQ1oA+2Z3n7tNQog6WUhuuX6TxKBtDUsMyeI595jhgy2Z6KZD7aYwXr2n/toyuMao8Km9yMY+7LqDdpC91hVF6jcxh28jxGIkV1m+sgsZUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qscarzia; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qscarzia"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b5cdt+8NA/r12+VI/46tnIxe3zkckBM5TI5/In/7L7k=; b=qscarzia9CKEXoaaOu2DQTVqjp
	t8tBu1mTcr/372vU1d0hgjOe5jYXZxHHx0zbfm1Z0jKatKeS6PjNVT3bcW+rBUr8812tNQCFM7F8P
	MLt7A7YCViQs/NYm9zsm1Ki0knFIm/MK4+D2QXJky6OfABi7DKCBYB/68rTCK3mTb8II=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSQWV-004qLm-Je; Thu, 28 May 2026 04:31:03 +0200
Date: Thu, 28 May 2026 04:31:03 +0200
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
Subject: Re: [PATCH net-next v2 06/10] net: ethernet: oa_tc6: Add MMS
 register formatting macro
Message-ID: <e0fd44b6-edd8-4da4-98d0-dcb48ff30e10@lunn.ch>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
 <20260527-adin1140-driver-v2-6-37e5c8d4e0a0@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-adin1140-driver-v2-6-37e5c8d4e0a0@analog.com>

On Wed, May 27, 2026 at 12:51:51AM +0300, Ciprian Regus via B4 Relay wrote:
> From: Ciprian Regus <ciprian.regus@analog.com>
> 
> The Open Alliance TC6 standard defines multiple memory maps for the
> MAC-PHY's register space. These are used to separate standard, vendor
> and PHY MMD specific registers. Add a macro to make it more clear which
> memory map each register is part of and allow easier definition.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> 
> ---
> v2 changelog:
>  - New patch
> ---
>  drivers/net/ethernet/oa_tc6.c | 4 ++--
>  include/linux/oa_tc6.h        | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 904bd790159d..876891ca9859 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c
> @@ -471,7 +471,7 @@ int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = oa_tc6_read_register(tc6, (ret << 16) | regnum, &regval);
> +	ret = oa_tc6_read_register(tc6, OA_TC6_MMS_REG(ret, regnum), &regval);

How about:

	ret = oa_tc6_read_register_mms(tc6, ret, regnum, &regval);

and let oa_tc6_read_register_mms() combine them in the correct way.

Maybe also change

	ret = oa_tc6_get_phy_c45_mms(devnum);

to

	mms = oa_tc6_get_phy_c45_mms(devnum);

	Andrew
