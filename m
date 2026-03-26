Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D072240F8CC;
	Thu, 26 Mar 2026 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544230; cv=none; b=WT5I2AseBGrdfyEFcOGKCtgnhJ2QUeO4s8OJrLNV27PyFqyAlTYGtq1Nwv/wcnnjC/NSFMPfJqlm0uBrBSmLikcIovWe0ODdutnJyLpBDyMhXMapKiCo7rR0tEUt2iU9UHcEW0s1H430R/DIjnkKPTLsjTR+UDEC4FC9hClIUdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544230; c=relaxed/simple;
	bh=YQzNDMs97EMVzOPZwCVVoor08i+/fB8/aCiaV28bC5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jldOKzoCShEGpL4cBa9Y6CGGq+zNdABkUqMaM1ZxLwcE4jX2wojjruP7MXbdo9BzNI7wV4DLnIiQcCOgEI4wBNblSVUtU8ed+hrdIIubayOTCTJe1/48Q8Mmme74n8tlg2Lk6v8s0LNOyR0W1eqe5AUQbY7db5WqZ33Yenwqr9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RU6AMIeW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RU6AMIeW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PkShcBQS80RyZYMl9HL/R0BWB7g3pxpOka68lKMaHPg=; b=RU6AMIeW6MKpa3dJEhSIo6xFgl
	EzrITyhusn+DTnjUfAwiwMR4vvM6XaLUmwrQ++HPn0GBFQJp87L9US0eo4AR4FK85P7BElugJztiF
	K6mgtzh6DVRT0rUFMfNUoiJnD4cFWcR+bVNNDPLMLQMeQY65aYa/YQzmnn9b6eb70Uao=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w5o0q-00DVrj-28; Thu, 26 Mar 2026 17:56:52 +0100
Date: Thu, 26 Mar 2026 17:56:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, kevin-kw.huang@airoha.com,
	macpaul.lin@mediatek.com, matthias.bgg@gmail.com,
	kernel@collabora.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: phy: Introduce Airoha AN8801/R
 Gigabit Ethernet PHY driver
Message-ID: <425217fd-f74c-455c-9aa7-5b6682d887fa@lunn.ch>
References: <20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com>
 <20260326-add-airoha-an8801-support-v2-4-1a42d6b6050f@collabora.com>
 <acVND6DdpM9czIwU@shell.armlinux.org.uk>
 <044110c5-da1e-48c0-93fd-35553e86b271@lunn.ch>
 <acVQQQiciPQBkQOG@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acVQQQiciPQBkQOG@shell.armlinux.org.uk>

> What is the timing requirements for a system going into suspend vs a WoL
> packet being sent? Should a WoL packet abort entry into suspend? If yes,
> then we need to program the MAC before the PHY is suspended, because
> suspend could already be in progress.

We would then need to hook into the NETDEV_CHANGEADDR notifier, and
call into the PHY driver to let it reprogram the MAC address.

     Andrew
