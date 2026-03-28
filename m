Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1FE55A;
	Sat, 28 Mar 2026 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774707337; cv=none; b=BVG6k6/93Jpz+6gsyPQvhJ4EykcUylTuljqNeGVaXIGcjd3zrDypqclYYlVrNSWvpiu70WO3TE7IhJEajdi08DKP4WzmT1PcCouL5Tv5wAugKYHo/5fhYfW22Ns/qRUnys5tn2Oxr35a+TaFlzLuoF5NiRtbaqf3QJ3oA0amTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774707337; c=relaxed/simple;
	bh=Z86EOurNTWz1a+nZzokKJ8hU47RVxzrhQCryff54TlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMzxDBARWluvpPj8L3aBBV22Y2oywnD5/QvUec6fDQF9IJZp3QLxhFdkpP+jvPcGBLL7kB8oiwhyu8WssDgoXb5dGLRygEJDOn7j91M6Z8NyNlCm1Om/QfYkyjgqSkoWbrCMuirVqx2I96ncsnVd9g2vKts75JKZxOVcWB8rtzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=I71qmciX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="I71qmciX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kVfi/cvvI4effHQf1xv2lRBGA7PDS15vJ1d3gkI1pI8=; b=I71qmciXdrC9t6OXuCkhFJoPNC
	Hqh+ZSZsHdoyEGbja8szHWlXt5gNdbri7rfJc2OPLuLjdC76jyP2aKWWnHffwUYVX0ZXnfU1LjVOa
	8wtbtxO96L9s5tS+seKQjFqwUKHygxjkXGrPr26YTxAkFAtvlRsOtrr/V6u0P6ANiYoU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w6URW-00Dn4l-8f; Sat, 28 Mar 2026 15:15:14 +0100
Date: Sat, 28 Mar 2026 15:15:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	"Lucien.Jheng" <lucienzx159@gmail.com>, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bjorn@mork.no,
	frank-w@public-files.de, daniel@makrotopia.org,
	lucien.jheng@airoha.com
Subject: Re: [PATCH v2] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
Message-ID: <e1a3ca7c-99f0-4452-bd5e-ca3662fd8d9a@lunn.ch>
References: <20260326153518.8387-1-lucienzx159@gmail.com>
 <edeee8e5-0de3-48ea-aeb5-cc705fdcd469@gmail.com>
 <6f42d92b-a26d-49a4-bef7-2227c252eea7@gmail.com>
 <acesgklpv8GlNeVf@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acesgklpv8GlNeVf@shell.armlinux.org.uk>

On Sat, Mar 28, 2026 at 10:25:06AM +0000, Russell King (Oracle) wrote:
> On Sat, Mar 28, 2026 at 11:21:59AM +0100, Eric Woudstra wrote:
> > static int air_pbus_reg_write(struct mdio_device *mdio, u32 pbus_address,
> > 			      u32 pbus_data)
> > {
> > 	int ret;
> > 
> > 	mutex_lock(&mdio->bus->mdio_lock);
> 
> I wonder why we have phy_lock_mdio_bus() but not mdio_bus_lock()...
> Should a helper be provided at mdio bus level to complement the PHY
> level helper if we're going to have MDIO drivers directly manipulating
> the lock?

DSA is pretty much the only class of mdio driver. And they mostly need
to use:

mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);

Not the plain mutex_lock(). 

Hence it has not been added up until now.

But yes, such a helper would make sense for a PHY driver having to do
odd things.

	Andrew

