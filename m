Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3384B048F;
	Fri, 18 Sep 2026 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789732445; cv=none; b=jD4hjVPqjQRw/qlDpGEUGW4X+DVZ1/inWLsT5F8AvIVzal1WVS28Kejja5Yv7yJJF8ubUzJJmLgyWcq+SF6lhOHZ7AapaHd/CjUGQ8TsEVS6r+odHX3mD6xggLad7Jld1t09yX9R0dM1mFKzFSRQXZ8wRXiRFf1YqkMwySinKM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789732445; c=relaxed/simple;
	bh=Tg6sUZbO12kr69TGuRX2+TW8rG6HSgB8VQPilIPhGII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbqyGupW9wMQ4rZJ2QNokAvmSa0PHP5g2wqWNwCTk/eCu0yrj5AzdDNEoZjnZnIRzOvqXm2MybIYfquPOa5RdC9L3wW0koFdx5JMNRubNm2985NHIqjNaXg4PGGgLIuc7KzfUUvSMt3yKGCnCD3LQBb/7NL/5YYAOpOcQacqVEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cuFI9FDE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cuFI9FDE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=19PmKoo5d7cVYVpSiRTEt7PfX902d55BNS+Eq3QkL8o=; b=cuFI9FDE5WIKKQNKCxDMX1Ruy5
	k4FYVNSa9Dho+4uGi0ZjZY1l7Ier74EmfH/TUtoCSVp6AChYgjs1Ww8+rqoZn356cRGT7KODMR2Mn
	knj1XbxvhWTRm4DRR15AQdVaC0iRH+MzrpcYfJ17+nZIOdBLcA6bdMqv/qtmbIGRGs+0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7XA7-005ri5-1N; Fri, 18 Sep 2026 13:53:51 +0200
Date: Fri, 18 Sep 2026 13:53:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <me@ziyao.cc>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] net: stmmac: Default DWMAC_MOTORCOMM to m on
 MACH_LOONGSON64
Message-ID: <f57f9a1d-72cd-4997-9895-202654a81b52@lunn.ch>
References: <20260915073206.6665-1-yangtiezhu@loongson.cn>
 <90a666a8-9f6a-4640-a219-731f3d551c66@bootlin.com>
 <f6b93b98-e0d3-9e28-e366-4df126e6ab5f@loongson.cn>
 <a10c8361-648e-476b-8b04-8716ad274fc4@lunn.ch>
 <36a43b65-f94e-4836-b511-715fb136c10d@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36a43b65-f94e-4836-b511-715fb136c10d@loongson.cn>

> drivers/net/ethernet/marvell/octeontx2/Kconfig:54:	default m
> drivers/net/ethernet/hisilicon/Kconfig:106:	default m
> drivers/net/ethernet/hisilicon/Kconfig:134:	default m
> drivers/net/ethernet/sun/Kconfig:77:	default m
> drivers/net/ethernet/sun/Kconfig:81:	default m
> drivers/net/ethernet/sun/Kconfig:89:	default m
> drivers/net/ethernet/mellanox/mlxsw/Kconfig:37:	default m
> drivers/net/ethernet/mellanox/mlxsw/Kconfig:47:	default m
> drivers/net/ethernet/mellanox/mlxsw/Kconfig:67:	default m
> drivers/net/ethernet/mellanox/mlxsw/Kconfig:86:	default m

Look deeper at these. Apart from the sun cases, which are very old,
default m is only used for optional parts of a module, not the module
as a whole.

   Andrew
