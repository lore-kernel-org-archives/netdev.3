Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88740184524;
	Wed, 15 Jul 2026 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784121128; cv=none; b=R2DRtAdEQnBvdM8/2ikosHz5oXUS33Ua89dFkdb8AEnRmu0g7f3DplBiBO9kmV80GjxV1COXK3FGvpoUS0DRAd16hJMp1uq1jKnVhz3k6LoGD7US2wz1QGFr+UpIPF3lndUlRa9MnMfugI2NM/VRKQVrT1/pTrAit7yW/q8Y7YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784121128; c=relaxed/simple;
	bh=N8+L2p4i3T1xUM6b5VPOIbq4dgEjM5LFxDH1YfqZafg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2IgEHio//I8f9BI3BkxRBJJgp+AlNk9owEI649yBb6GgSIgyTpJEC6qGAY0/61lQs+Vk1R1l/nJXwpB9WkZ8AUOaEaNLZyeM4Aq7CjjU7R3PMWXsb5DxhXKY+m0GPTdxDAzzUZwfiM1Ep+gcBoR2U308IqbYsPvhimdYpkPs9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DYFjJdot; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DYFjJdot"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6HaOHHCdIdSslifVl0U7OJt8b5n1YD2TqPRVJJGNryk=; b=DYFjJdot1UgKYDvmi2FLzNo8E/
	ai2AYwbkMPQ0O+LFJFB4WpBrPc89yS/y+pTfrhEVkdDdAwd5HwWKUgPI5hRWxpvCiK6ooke0ipxb4
	iu9ZDcPC7xf3cAwiyqYxT/YxOsy1a/cXDChDNqLpiumJ4ZbT7lorCrxG693+D07ghync=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjzP4-00CMAE-J7; Wed, 15 Jul 2026 15:11:58 +0200
Date: Wed, 15 Jul 2026 15:11:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v2 2/2] net: mdio: Kconfig: Group mdio
 multiplexers in a submenu
Message-ID: <6b62d2a9-8759-46c5-ae08-500f8ac4e6cb@lunn.ch>
References: <20260715082226.51481-1-maxime.chevallier@bootlin.com>
 <20260715082226.51481-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715082226.51481-3-maxime.chevallier@bootlin.com>

On Wed, Jul 15, 2026 at 10:22:25AM +0200, Maxime Chevallier wrote:
> Move all MDIO muxes under the "MDIO controller drivers" submenu.
> 
> This doesn't change any dependency for KConfig options and is
> purely cosmetic.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
