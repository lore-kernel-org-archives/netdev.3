Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213B231829;
	Sun, 27 Sep 2026 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536542; cv=none; b=Dq4mfcwUEOHUvvTfGWoCMPel3nwEQSWFE5ZBaCM5H3h2+SG44l45bm7wsqu5EnaChrLIbqW6yx5BqNolSFjuxcW78ZfImugX8OaQmh2lEwmB3f7pfGFeF/6pXKZoYeRizqMKT0/70SeeXPJVlBDmBOwepxvQDY4H29D3vZWMLO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536542; c=relaxed/simple;
	bh=I/Z4Dq5qP+62urdqFOFOTkrLhloFH1RT/ER5bPm6B2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/Sw/++2wyzbfxEsJ6Jv8k0Q/BtrQich+sqniJ/7bQwb4djfd+N+NsS70F8nqY8iR9WTCPyZPIzZELJrpxaIVxsaQd1A0qD6+Qk2YFTmJ0J6lEHKjwLr7qsOzJ3FK9AkwaL2fPvDyZdIkCfW2Qu61XlIU5ujj5fqDz1HH9Fa5U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NRDOCaSx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NRDOCaSx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NqRBQ/l/KshauKybq+sCIFSt1P3/4rPlGdvjwaBtLAY=; b=NRDOCaSxs31myX620RHNR3NtbD
	DlO/eHfwjSO2o1fszpdlSXh2acAKvIRswjuUu1MGGz9cmWY6uPQsWR+wpABZ3YVXMOEQ9M2QmS/U3
	kNgqBqiQsXDHZ9xTK4RknHJ9VA3VJphoUQvDhss9bvsB8OG/gn+EKGhhxHZ3aPhfl/0Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAuLM-007YXi-VD; Sun, 27 Sep 2026 21:15:24 +0200
Date: Sun, 27 Sep 2026 21:15:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v23 9/9] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <c56b0621-a4c7-4276-91a7-dafb5c6cd5a8@lunn.ch>
References: <20260925182435.21207-1-ansuelsmth@gmail.com>
 <20260925182435.21207-10-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925182435.21207-10-ansuelsmth@gmail.com>

On Fri, Sep 25, 2026 at 08:24:31PM +0200, Christian Marangi wrote:
> Add Airoha AN8855 5-Port Gigabit DSA switch. Switch can support
> 10M, 100M, 1Gb, 2.5G and 5G Ethernet Speed but 5G is currently error out
> as it's not currently supported as requires additional configuration for
> the PCS.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
