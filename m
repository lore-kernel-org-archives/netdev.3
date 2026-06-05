Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DEE3A3821;
	Fri,  5 Jun 2026 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683297; cv=none; b=GKbfeMpjOlyoZrqg/kywW42i//k2/idlpOQsJAFWJbjVUeYWRw6wwgKcm7VUHL/yXsnqi0/ng3NRV/EvXKzVicfv8aYORf7MJduyiZyYXpU/Y4jnBZCREPMvJvt5W6bPKJLnSu6F3l5whiJrwVxG1rzOCp7t9B4Ay0GoP27GO8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683297; c=relaxed/simple;
	bh=Ge2nsXbXVB11wGz26n/HR93zpsXWkFswt9H/b+SLtgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7JmOc7bZSzPLbTY/w/2CkYSCLyPpumvnJOxnr4xpBhB9xfomEJO0lj5ldK6u+0KWsXwktw2FlOQVR++kh+DntDzriendpWvy/LDY+4+KlygHoMoJF0vghbpjyzIZ9UWmNXlu9/S7EvBKZS0PHt828hWQX8f0qS7XdRyGR+tGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kKvXX5Tw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kKvXX5Tw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CWSJhxCvKNv8WF2H5sZ3YZCpqe7EisvdRxWuvZCt+Lg=; b=kKvXX5Tw3k1zYXky5H61GA2eAn
	YQCNCAOfKkOUytJ/ySMIjmGQwwTn903T3ajubR8xq7X2ymdVcWy5etV9+6ZpEv+kQYn2SsTy4QiUX
	2hr4X3WWaFNDEQkSscWHthsGXvO+PfTiaXqUzXBmUkiw/Z45LVwc3z3cRtPm9l6SHmlg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVZ43-006H9d-S1; Fri, 05 Jun 2026 20:14:39 +0200
Date: Fri, 5 Jun 2026 20:14:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 4/4] net: phy: at803x: add RX and TX clock management
 for IPQ5018 PHY
Message-ID: <afdced5b-73b9-4214-a94a-c13fadd39dce@lunn.ch>
References: <20260605-ipq5018-gephy-clocks-v3-0-f232d9ca0966@outlook.com>
 <20260605-ipq5018-gephy-clocks-v3-4-f232d9ca0966@outlook.com>
 <36cd63f4-749e-4b09-b8a6-cbf6924dea88@lunn.ch>
 <SN7PR19MB673634FEEF98FB8BCBBB15979D112@SN7PR19MB6736.namprd19.prod.outlook.com>
 <471a21f2-7ab0-410c-861d-5722a94b127d@lunn.ch>
 <SN7PR19MB67363B4F852FB37071637A299D112@SN7PR19MB6736.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR19MB67363B4F852FB37071637A299D112@SN7PR19MB6736.namprd19.prod.outlook.com>

> >> This PHY is integrated into the IPQ5018 SoC, connected to the first GMAC
> >> (GMAC0) and probed upon boot. However, this PHY is not used on all
> >> boards because an external PHY or switch can be wired to the SoC's
> >> second GMAC instead (through a PCS). So from a power management
> >> perspective, it would be better if we can disable the clocks if there's
> >> no link detected.
> > 
> > Humm, is link the correct criteria? If the PHY is not used,
> > .config_aneg should not be called. Why not have the probe method get
> > the optional clocks, but leave them off. When .config_aneg is called
> > for the first time, enable the clocks?
> 
> Will check if config_aneg is called and test accordingly.
> 
> ip link set eth0 up/down and cable (un)plug do trigger
> link_change_notify, and based on the link state the RX/TX clocks are
> turned off/on properly.

You are talking about something else here. You say the device is not
used. If it is not used, .config_aneg should not be called.

This is a second use case, the device is used, and you want to limit
the power it consumes, when there is no link. Do you have any numbers?
How much power is actually saved?

> Could you explain why to use _optional variants of devm_clk_get as these
> clocks are required? There are currently no users upstream.

This last bit is important. We don't want to cause regressions on
existing systems by adding in requirements which were not there in the
past. But if you say there are currently no users, that is fine.

	Andrew
