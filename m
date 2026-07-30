Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB743AAF4E;
	Thu, 30 Jul 2026 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435797; cv=none; b=TdOdKUC5Ts/WXN3vlrFbjqPjJWDIx15JBhqpafv4UNPeXfXH+Bu9jlDxGFRn3IuAJhz5MnfJLkn5OHQnHsneVJe27EO0U7JxyIWzVVdAb2q7nIB6plZ9PpGqbSWcHq+kBYQfBLaDykH/D+fzX//Nu4XzmnjZEz2MyDWogTwIZJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435797; c=relaxed/simple;
	bh=1UlL8WY47iCqXXl/j5FVVyaCM6333yVG8avaeWvZhJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxdlRhf4zjb3dbv392bX2afqmh2tfqFKL3MFi52Do9l6iHCjcSJnC5F6qvmXkPWQVNjfiq3KfthRk9qXh2Xy/0tsAejSrS/sub2awI7W7PAS41nxEQHWxbqX7l6VIonDZYn0o1aheFFMtSwXaqneKid8PVZk/76HLgiZ6BSUrLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FCwBRcpN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FCwBRcpN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=clxCsEQvLeknhEmgMllQnjE05y0bWUTRUV24sv3aoFQ=; b=FCwBRcpN38nBeb2SSWEKkJb3OA
	pbxOPfbZwV9q49uus8tvXRjkXnphsorza6QWBNp373oWGXBVsnDZ9wSen5NyOaskINAlMQg3XSSms
	sOyzZniousgOrlbHFMZWt2RM+EAfBqmUrjuit47DaSGLZyFRd2ct6I/EqJoQ2t/s4MiU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wpVPB-00F2wO-5N; Thu, 30 Jul 2026 20:22:53 +0200
Date: Thu, 30 Jul 2026 20:22:53 +0200
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
	Landen Chao <Landen.Chao@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net 4/4] net: dsa: mt7530: serialize the regmap IRQ chip
 like every other user
Message-ID: <dfaf8f23-e2c4-4f1c-a341-4d44c153e79d@lunn.ch>
References: <cover.1785427248.git.daniel@makrotopia.org>
 <f2a52e4ada145fe6aa3fcbe5f923b125364b1a87.1785427248.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2a52e4ada145fe6aa3fcbe5f923b125364b1a87.1785427248.git.daniel@makrotopia.org>

On Thu, Jul 30, 2026 at 05:03:47PM +0100, Daniel Golle wrote:
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
