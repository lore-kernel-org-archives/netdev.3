Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5DE346E7A;
	Wed,  8 Jul 2026 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554295; cv=none; b=pY9+/dk2rn2ZMYo+j+F+e6eYxkU4uYuq/rjZN6wv2WJ5SX4VosTzRF+vsR6TxNo0Wi8KQFAy+ZBfxeX/Xn8Up4SXKyoQXBxJGTz1hFiGjYyVS5Mh+3HvgRuQsjN62rQ9KV/68q/ngKO2f9oknEndts6altjO9kyUaBPs9oo/Fbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554295; c=relaxed/simple;
	bh=lhL1NlzO/lJ8S5/AwRVQc3DuZx2WtRnS8KEYTGAbdDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hp+wg3S+ZUNNsyZA0On/elFRtAiqDIlQO7jdI6paPwytZZNoim/DXh+vsHiiQrBSlT1evppqOguIoLIY91egsw7YaWC2nhR7Lr+SbJ/sWRUSmZBwQJLiUDIl8/AH8GEPIl7RyAi3crF6DKB1C8ewWkjKYtu3+tac9IxcJaAPwaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g87yIN0r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g87yIN0r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6p9CG0ucUJyWWPCmR1i0n8mseOGxxjsoZi2KpUvwYFM=; b=g87yIN0rgi+sraGKqIr8gUPHCy
	KihKUu5dmKFk8wq2yK4l3x0zh1cQGvT9i/avJ7sZ2Z4HAg3Y6ChHyMConek8beVh3js8Lk30B0sQr
	3L29RcNh0+uaH213xG5rMvbd0mimJkjukGpiIDH2umxA9HhmhjFO+hX23LHRpmMoXPYM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whbwT-00BPV2-GM; Thu, 09 Jul 2026 01:44:37 +0200
Date: Thu, 9 Jul 2026 01:44:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/5] net: phy: mediatek: move MTK GE SoC
 registers define to dedicated header
Message-ID: <788172f8-1005-4df1-afb7-320a135bdaf9@lunn.ch>
References: <20260708102341.53919-1-ansuelsmth@gmail.com>
 <20260708102341.53919-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708102341.53919-3-ansuelsmth@gmail.com>

On Wed, Jul 08, 2026 at 12:23:28PM +0200, Christian Marangi wrote:
> In preparation for support of special Software Calibration for Airoha
> PHY, move the MTK GE SoC registers define to a dedicated header.
> 
> It's also needed to generalize the cal_cycle function as Airoha needs
> only part of its logic (the wait logic) to complete a calibration cycle.

Can this be two patches?

	Andrew
