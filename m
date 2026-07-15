Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B8B30F531;
	Wed, 15 Jul 2026 00:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073647; cv=none; b=L+gAhxKeszemaMaI2W7tbZ8yoHgzB9SNxzJrjFG0zF9vNZ6VCpoYxEzBlN7o/gcvv5BcVEyKtz0IFtFTyqNNQ8AHtbPSfWV92BEUcvanNp73s4bjcfckCrVDRg04sYzibwgK9pS2s+3J3s61mIotX686YQ1vnMh/RpG+srmb5Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073647; c=relaxed/simple;
	bh=0ffoVCimaamwnS9O95Jl9HBnKyBuyPJV1aXjr1ZD5Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFXhz9R9fs0cjYrZsli4b/ppoQRU7JZMS55g0ytv0tW3/aOgHw+ijlbfMon2sfLl1iUkVsyiMhXTKzcrveDyyJVzsnCBK86msPXZIl5x4VL19ahttj9E+VneA6U5POjg0rZHEJJeIk9nHzkU7JTUwBD8xhjr10dY5HxZoDeSqdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q8ggfXdV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q8ggfXdV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vkqO5gNJzp3dhXjMGW9t4sIt3IyxEElwYw4sHoA/Yog=; b=Q8ggfXdVVchD6y3PdjGfQOL7ng
	g4nh/7AN2sbmLC/0MyadyKkccfnsfcZd80t2z/sDW/D+U9I3UCQi966xZd07CLi21MrUfQ1n5nRaB
	W9hRd5pfqBoOEX460sWNQeKp4xL6thJyJPlxOXkLAE9mcnN6Wzvoi+UfEGA20rwx317M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjn34-00CGkP-Nk; Wed, 15 Jul 2026 02:00:26 +0200
Date: Wed, 15 Jul 2026 02:00:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Cedric Jehasse <cedric.jehasse@gmail.com>,
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] net: dsa: mv88e6xxx: write the ATU FID
 register on 88E6141/88E6341
Message-ID: <d59e2e61-6952-4fe8-b03b-6946a789cab2@lunn.ch>
References: <20260715-mv88e6x41-fixes-v3-0-9a8702b27ecc@padl.com>
 <20260715-mv88e6x41-fixes-v3-1-9a8702b27ecc@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-mv88e6x41-fixes-v3-1-9a8702b27ecc@padl.com>

On Wed, Jul 15, 2026 at 09:29:41AM +1000, Luke Howard wrote:
> The driver decided whether a device has a dedicated ATU FID register
> from its database count, taking the register path only when there were
> more than 256 databases. The 88E6141/88E6341 have 256 databases but do
> have the register, so they fell back to the legacy path and the FID
> register was never written. Every FDB entry was then loaded into FID 0,
> breaking VLAN aware bridging.
> 
> The number of databases does not imply whether the register is present.
> Add an explicit atu_fid_reg flag, set it on every device that has the
> register (all that previously matched the >256 heuristic, plus the
> 88E6141/88E6341), and key the register access off the flag instead of
> the database count.
> 
> Fixes: a75961d0ebfd ("net: dsa: mv88e6xxx: Add support for ethernet switch 88E6341")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Luke Howard <lukeh@padl.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
