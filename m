Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A0D32B120;
	Thu, 30 Jul 2026 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428189; cv=none; b=OtDdZCZ77Y6jefF+KBCX/zAmuH61CXgW7pDYjcKyKFeKgCZS61n1cfrEsEjf6L8WJKFzuNu61715l+ibHK/ojPWdSIwcedISKIviBRYYuhPkkczwSR8gYwppGu9vdjxGIg5fJbrG5FYiZsT+0cJS3iRKG4B52+eQ6yJuQ4JjCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428189; c=relaxed/simple;
	bh=JBQC1G/d1dHVQfle/a+BOi5GEYSDhMzz1GYD9mvQUWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4aXysd1OAcN1lbi9C3ywhK+GLWiSj95UkaWix1ZXPyx1imq96LpOXdxZ27JIqzZDdZEunBCF8B256KRw5G0MufY4UWrGgxeJS41gyQbR3j7HK9c5XrVSG2m/SnP0CYpSWVfS/yOBHwIGEtHw/cPvjOQnsmIPDydODxb3I55JAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p/CFWH9O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p/CFWH9O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VNFN2Co99MmNM9wjzZFskt0bLc4iBky+Jm2OcMCXmE8=; b=p/CFWH9OT/Hf2t9gPenGWEjaiD
	Z1qfm6U1bT3BS+ytUN53IACn0m088dp/I7mcIukGS7ipfvdmupelUkYfHVkeRtaflpSloiwR9CiQj
	k8HAJVWOiMXk0OklgT+Z/9C97os3vah6sDXZpgTwItT+uoWuOu0mMpfdkaeUET+odmU8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wpTQO-00F2Cg-JM; Thu, 30 Jul 2026 18:16:00 +0200
Date: Thu, 30 Jul 2026 18:16:00 +0200
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
Subject: Re: [PATCH net 3/4] net: dsa: mt7530: error out on failed PHY_IAC
 command writes
Message-ID: <5f1b2fc3-33de-4c50-9ad2-fc989838f9de@lunn.ch>
References: <cover.1785427248.git.daniel@makrotopia.org>
 <2c0409afcdbd795fbc15b0cd3c9018474c272883.1785427248.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c0409afcdbd795fbc15b0cd3c9018474c272883.1785427248.git.daniel@makrotopia.org>

On Thu, Jul 30, 2026 at 05:03:29PM +0100, Daniel Golle wrote:
> MT7531_PHY_ACS_ST is only ever set by the command write that precedes
> each poll in the MT7531 indirect PHY access functions, and that
> write's return value is discarded. A failed write leaves ACS_ST at 0
> from the previous access, so the poll succeeds on its first iteration
> and the functions return stale IAC contents as if they were fresh PHY
> data. Check the writes and bail out before polling.
> 
> Fixes: c288575f7810 ("net: dsa: mt7530: Add the support of MT7531 switch")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
