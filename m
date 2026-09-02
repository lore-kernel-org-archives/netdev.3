Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401111DA23;
	Wed,  2 Sep 2026 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788307860; cv=none; b=fSNg8VPoFe9E3qmXm4AWoTJ3y5T5+UzWtpBAKPgv14fAosVRLvvCY9LtnpRhi+KX5Xd1nLqrGwnwXPBIF24xY0DQKpP7pAUvCuPSvhr65ei6YXnYIh9Vr6/BqVI8Qdxd/vq+jHkXAKrr+fBkcS35ljaT17Ip/UP4XYqUCSrUUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788307860; c=relaxed/simple;
	bh=JB0ryUD6z7hb9bbtnjF9MqW/sSkRWFS8Ey8xg3z8TII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuTsrYjK42bqnz0FBYjPSkMJ5ZZNGxNqZMh2BUAoGT+AAlVxUReIxiz9WgTeLguPI5h8uClcMN0EtdLskUM93c8CZPS6VRvW2rMWPSN11NAJX2B4fe9t9EekBOixKYZ/Cr9mni5vFdeVOP+njQJjsPDDnvJK9bzZCxDBH7LfH/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i36D2gLJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i36D2gLJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N8TNu5kGZ5XQGNLlmvuhUi5237bvUACSc0gg7uOwZ1E=; b=i36D2gLJ3aoSclk6Cm8Bb1GU9D
	adWsnp/3K7OXn67Ok3kT5c1bKIIFXz+iKJdwx3MmC5NUObfc1n5zO0jhuNrIlW1+A9KFglCejZY1/
	crdJLcQXr0Db14Nv+OD4tkUEoOfrlcrz6E1M378c8/3CMwBhiBuMaTBjxtX17AwPh/Qk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1YYu-002RYE-Nl; Wed, 02 Sep 2026 02:10:44 +0200
Date: Wed, 2 Sep 2026 02:10:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v15 05/13] net: phy: add
 (*notify_phy_attach/detach)() hooks to struct mii_bus
Message-ID: <2f57940c-1b88-491b-8251-fd11d6445c6c@lunn.ch>
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
 <20260831143439.2404484-6-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831143439.2404484-6-markus.stockhausen@gmx.de>

On Mon, Aug 31, 2026 at 04:34:31PM +0200, Markus Stockhausen wrote:
> From: Daniel Golle <daniel@makrotopia.org>
> 
> Some MDIO buses require programming PHY polling registers depending
> on the PHY type. RealTek switch SoCs are the most prominent example
> of a DSA switch which doesn't allow to program MAC speed, duplex and
> flow-control settings without using PHY polling to do so [1].
> 
> Avoid a half-baked solution in the MDIO bus driver because
> 
> - it must reinvent the bus scanning to determine the PHYs and
> - it must anticipate the right point in time (e.g. deferred PHYs).
> 
> Hence there is a need to inform the MDIO bus driver that a PHY is
> being attached or detached. Provide two hooks in struct mii_bus
> 
> - notify_phy_attach(): called in phy_attach_direct() after PHY
>   hardware has been initialized and just before PHY is resumed.
> - notify_phy_detach(): called in phy_detach() right after PHY
>   has been suspended.
> 
> Worth to notice: As of now phy_detach() is not 100% LIFO symmetric
> to phy_attach_direct(). E.g. sysfs links are torn down before
> suspend while being created before resume. Without reordering of the
> detach function the above mentioned notifier placement is the best
> possible symmetric implementation. An unconditional call of
> notify_phy_detach() was favoured [3].
> 
> Remark! A slightly different version of this patch was part of a
> former series [2]. The discussion already showed that an initialization
> hook should be placed somewhere late during the whole setup. This
> commit implants it right after phy_init_hw() as suggested. On top of
> this it adds the detach hook.
> 
> [1] https://github.com/openwrt/openwrt/pull/21515#discussion_r2714069716
> [2] https://lore.kernel.org/netdev/cover.1769053496.git.daniel@makrotopia.org/
> [3] https://lore.kernel.org/netdev/9e40f50b-357a-4a93-9f59-94847850835d@lunn.ch/#t
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
