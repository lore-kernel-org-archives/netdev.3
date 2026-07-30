Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A23936E477;
	Thu, 30 Jul 2026 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428135; cv=none; b=kLEeBvyrtimm6sjxGXXwwrjqXTTbwTTEL7LsosOZe4SHpxIqCTUPry+JP02q5wy784kGp+gwCViS9tFfdGbJqNVhQogFV7IoFob1dgSD/FOEILA6Q8OznOTOKc1B1gTWgr1ZteXAT59sqsNlYHVQBLZbd2rpyeFsPv33vK7uFNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428135; c=relaxed/simple;
	bh=WaljAOFXj1Cm0zNOt1P7tp2B0Uook0sAEOdY7Q7vvzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXv9NmcjIBoaO3HDMKXuP/SrdkpVvZTZqT5yg5mX4Ec+Y0B7OzO/C5UYNlfVETYuixJyZx1ZIDx+YOBXaMhYHAQk0Z/PeMywMULhRJ7YZkvZ0tc0ZqV1GZ0DSPqgHkL0yGaZR9AtmNIEFD82mjLhT1u+5WM5ID5+yzQJfMO+hg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kNbvtihE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kNbvtihE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IL3Oo7QOt9gbYMZOfnGaQko6Bls9KQHHxXUeMAA4kYs=; b=kNbvtihEq+ufWkZGyL3dKiuh1L
	VYiSyD5AE4oJel9u0So3Xo9mLfar0Lqf1QG/xJuS4F92Y4mFGoWuqN6Zv7hlg3TfYu9eSCX1qUwfM
	HUuHlEmUI2Bs7BV1j1mVmEW9mlgxdc6ssQbavmD1U55MxFVQeep+06F4LNErn66ez4FU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wpTPa-00F2Bf-IB; Thu, 30 Jul 2026 18:15:10 +0200
Date: Thu, 30 Jul 2026 18:15:10 +0200
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
Subject: Re: [PATCH net 2/4] net: dsa: mt7530: check bus->read() error in
 core_rmw()
Message-ID: <a1bc4379-3d28-4d8e-99ee-8c4035434eca@lunn.ch>
References: <cover.1785427248.git.daniel@makrotopia.org>
 <fe3926ab260b94d88d97ee5f417dab7dcf55f8fc.1785427248.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe3926ab260b94d88d97ee5f417dab7dcf55f8fc.1785427248.git.daniel@makrotopia.org>

On Thu, Jul 30, 2026 at 05:03:17PM +0100, Daniel Golle wrote:
> core_rmw() accesses the MMD core registers directly rather than
> through the regmap and has the same unchecked bus->read() as the
> one just fixed in the MDIO regmap backend: a negative errno is
> consumed as register data, modified and written back to the switch.
> Check the read and bail out like the surrounding bus accesses do.
> 
> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
