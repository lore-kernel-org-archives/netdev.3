Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ADC3F410E;
	Tue,  4 Aug 2026 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809390; cv=none; b=Lz0EqJ0g8Qj5F/DWWuu75/xzSkWJKbmKRvhwbzh79ou5ckod7SNtphFrWCFa2r6FJhYzPGaVzPkEuBXTjIgMhFiQsg+ZUmEp2D/V8DftM6LeOAHmKjxXwiCdGP2fdP6Y5Nw6cu8t4ayfdmIdYjig+ea3uaH9BavuV7QVEtpo8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809390; c=relaxed/simple;
	bh=Pu17s6SB1/SEi8jz8l1Xxyn0lzeSNh7tYfuOD/LmqUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRtGtGmfy9Q48aeQO1bJGvxuIRWhvNR1DInpW1b+hwoMFgytJVBfPEI8QkgMbFQya4Py65YsUFNEzlyWNRTd4aL3hzlXNJkZkak4E54pY3UeljWBf3Z8vWJ+vuT2vZnbxXxCdVqkb7Zc07ap3J2dWXnDvh5IoEhjlHkR+URj6YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RbyfqlqH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RbyfqlqH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aoFvMGhDfDOW3E0MWAosEdNVj/krmvIXG4EI2giGr74=; b=RbyfqlqHrxEumvBY/2y7FRqbcl
	pAYtP/nvcihbG9J88Ay7b7meG19LkAVtrDkZtk2kOflzK/VAfb0Hd/N86Q5IKWdW6GeAYd0ddSzVT
	WuqgusIf6vUidQ6HV9ohD3M1u2kA0xg7fi3ZjlGH8jqUPKiI3hNwHHmZYxm3/HyKgeVQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wr4ay-00FtKw-Ek; Tue, 04 Aug 2026 04:09:32 +0200
Date: Tue, 4 Aug 2026 04:09:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sean Wang <sean.wang@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Landen Chao <Landen.Chao@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 5/5] net: dsa: mt7530: serialize the regmap IRQ
 chip like every other user
Message-ID: <33c097a2-6b88-4b43-b378-c9c90988c9b9@lunn.ch>
References: <cover.1785368701.git.daniel@makrotopia.org>
 <b28df01d04c0e50c3d44ca2f29b12260bc32072d.1785368701.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b28df01d04c0e50c3d44ca2f29b12260bc32072d.1785368701.git.daniel@makrotopia.org>

On Thu, Jul 30, 2026 at 01:15:06AM +0100, Daniel Golle wrote:
> The switch register regmap is created with .disable_locking = true;
> every other user in this driver calls mt7530_mutex_lock()/unlock()
> around it, which takes priv->bus->mdio_lock, since the underlying
> mt7530_regmap_read()/write() issue raw, unserialized bus->read()/
> write() MDIO transactions.
> 
> mt7530_setup_irq() hands this same unlocked regmap straight to
> devm_regmap_add_irq_chip_fwnode(), whose threaded IRQ handler then
> calls regmap_read()/regmap_update_bits() on it without ever calling
> mt7530_mutex_lock(). An interrupt firing while another thread is
> mid-transaction on the same regmap (e.g. a paged register access, or
> an indirect PHY access) can interleave with the IRQ handler's own
> paged access and corrupt page selection on either side.
> 
> Use struct regmap_irq_chip's handle_mask_sync hook to call
> mt7530_mutex_lock()/unlock() around the mask register write regmap-irq
> issues whenever a consumer of one of the mapped sub-IRQs enables,
> disables, requests or frees its line. This needs a per-device copy of
> mt7530_regmap_irq_chip, since devm_regmap_add_irq_chip_fwnode() keeps
> a pointer to it rather than copying it.
> 
> handle_pre_irq/handle_post_irq, which would additionally cover the
> status read and ack write the threaded handler does directly, bracket
> the whole handler including its handle_nested_irq() calls. Lockdep
> caught this on hardware: those calls reach phy_interrupt() for the
> per-port PHY IRQ lines mapped through this chip, which takes
> phydev->lock, while phy_attach_direct() and this driver's own indirect
> PHY access already establish the opposite order (phydev->lock, then
> priv->bus->mdio_lock) elsewhere. Using them here would close that
> cycle, so they are not used.
> 
> regmap_irq_sync_unlock() also has its own init_ack_masked path, used
> by this chip, which unconditionally does its own regmap_write() to ack
> currently-masked IRQs; that path has no per-driver hook. Together with
> the threaded handler's own status read and ack write, these stay
> unprotected -- a narrower, harder-to-hit gap than the recurring mask
> sync above -- and will be closed once the switch regmap moves to
> regmap's own locking in the driver-wide register access cleanup.
> 
> Fixes: 254f6b272e3b ("dsa: mt7530: Utilize REGMAP_IRQ for interrupt handling")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
