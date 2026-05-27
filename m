Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EDE28686;
	Wed, 27 May 2026 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883957; cv=none; b=LxNv2kkvt1KuVAX/yyzgOJk+8T8Cnl42fYnl3Yh23pUHRoOgZTWCXTJH7vzw+Ql3cUUorCGMyPoqx5dAKH2vtKvYTkmcAI27XxvR+b6pGqO86HweJGAw3qvefagX0UykW2pX2BCKbBBDmS8+WGAheFIgPgcu74CaCDiwoCYNmk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883957; c=relaxed/simple;
	bh=QY1fQkl00NF9K5hBvqQ/nYiHznD/0YmHD2gKsxNgpQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELUKYZZlvxiJyAtLfkXXxbe9GxjhOFYxaI7ibJQB3Um8bTiG6dNI646hF4ynjtvkcGEYzv5EY1ll/HELK3rCLi55S4dUP6JXS7U8WeoZh6quIBtlvz5uHEWf1zkualmZQiZ6kOBvZd79qao7oeofBuYf1nWHvL0xbnn/n48qC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZZRg+Ij3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZZRg+Ij3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DOuNAbF+hDR19urz05nNoffPdf8rxXQKcacY07LL8x0=; b=ZZRg+Ij3IDk+el3WBPjiBZXAqM
	EItPKF/Qag7qkqlIePwa2WGvG+GyNqK/vVrT0c6sngpLGnnn/kqareDT+wkluMYkrPTdkD+PUhap6
	oGFPKyilCzLRvv/3rd0vdM/JdDmyS8EsYB+OFjm+b/1qotiWeImX91So3vaB/AaCk9yw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSD7c-004k7e-4Z; Wed, 27 May 2026 14:12:28 +0200
Date: Wed, 27 May 2026 14:12:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thangaraj.S@microchip.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Bryan.Whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: lan743x: add RMII strap status
 detection for PCI11x1x
Message-ID: <6ae1c613-394c-46fe-a4cd-0ffa8cb0bffb@lunn.ch>
References: <20260526154054.19829-1-thangaraj.s@microchip.com>
 <20260526154054.19829-2-thangaraj.s@microchip.com>
 <8eb1d177-b176-40bf-a77d-434aa2b9189e@lunn.ch>
 <DSWPR11MB97158A7DDD0C53EA9E221AE4EC082@DSWPR11MB9715.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DSWPR11MB97158A7DDD0C53EA9E221AE4EC082@DSWPR11MB9715.namprd11.prod.outlook.com>

> > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > the content is safe
> > 
> > > +     if (!adapter->is_sgmii_en && strap & STRAP_READ_USE_RMII_EN_) {
> > > +             if (strap & STRAP_READ_RMII_EN_)
> > > +                     adapter->is_rmii_en = true;
> > > +     }
> > 
> > What does it mean when both SGMII and RMII is strapped? What if neither
> > is strapped?
> [Thangaraj Samynathan] When both are enabled, Interface will SGMII. When
> Both are disabled interface will be RGMII.

So both enabled is not an error, we don't need to give a warning that
the board design is broken?

> > >       netif_dbg(adapter, drv, adapter->netdev,
> > >                 "SGMII I/F %sable\n", adapter->is_sgmii_en ? "En" :
> > > "Dis");
> > 
> > Since there is a netif_dbg() for sgmii, maybe add one for rmii, so the code is
> > somewhat symmetrical?
> [Thangaraj Samynathan] Sure. Will add it in the next revision. 

and maybe also add RGMII. Looking at this code, it is not obvious that
RGMII can be indicated by strapping.

	Andrew
