Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2058346A08;
	Wed,  1 Jul 2026 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916994; cv=none; b=gIX9Xe3F6BesVGAJe97/y4Tj35ZjWpzwnwUjWigLO+euFEWE9Zq4QdACzjaTb344AI0gk0/Lfvf9RTJEpgnKZfQBpJgTAkKIgBor1oHBt076qXoxxIl8PySy0KigWgxspy6aeci2GjEQLmi/8lGi7MfhYaOLzrKDwNBrGkPo2Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916994; c=relaxed/simple;
	bh=W2v3V4in/7G/PNiCx7Bo6y+UOkoiifug0X4J3Tm9pF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLkebt80jvX9v9P/riJeEK07Vbh5eh0Km1cgBmhFrwX9LcVqX26ZbD8r9yHRIcnsiMQugFQI1jCZ6n5m+4vBShu4gtU/tCuaGCSPYltOEnhDsrf7gqz6hKzr2JQ6wBNv6/Awi5CuF7b5PxHDiP9uo2y3SAuUN7fLvABafczAUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OPGqidVo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OPGqidVo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GBCvyH3YtvkpXtOPlGLQiWEsgokOQEtClJ0E/kQYkoU=; b=OPGqidVoJyb+oeiZIjLeJI+cwy
	fYnYlX2dPelUiaiwKyYW64KtiZmA/kbKqOlxmGSTuC6yoQKnzJ9dEqJVcuVEAJCaiQAXxKvW0Wz4f
	Wx+wdVPn6cMWpxWZeuB3Jp8aryxD+9en+Rn6MmCWIkuOyglGxITpTaOXC1daGb03QYK0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wew9X-00ABS3-J4; Wed, 01 Jul 2026 16:43:03 +0200
Date: Wed, 1 Jul 2026 16:43:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: dinguyen@kernel.org, maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org, conor+dt@kernel.org,
	robh@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: stmmac: dwmac-socfpga: Add mac-mode DT property
 support
Message-ID: <e489be4a-5940-46e5-ae06-b78f1c919352@lunn.ch>
References: <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630133108.27244-4-muhammad.nazim.amirul.nazle.asmade@altera.com>

On Tue, Jun 30, 2026 at 06:31:08AM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Russell King's commit de696c63c1dc ("net: stmmac: socfpga: convert to
> use phy_interface") replaced mac_interface with phy_interface in
> socfpga_get_plat_phymode(), noting that no upstream DTS files set the
> "mac-mode" property, making the two values identical.
> 
> The Agilex5 SoCDK TSN Config2 board is an exception: its gmac1 TSN
> port uses GMII internally in the MAC while the PHY-side interface is
> RGMII, so mac-mode and phy-mode differ. Without restoring mac_interface
> support, the MAC is configured with RGMII instead of GMII, causing
> connectivity failures on this board.
> 
> Add socfpga_of_get_mac_mode() to read the optional "mac-mode" DT
> property and store it in a new mac_interface field. When the property
> is absent, mac_interface falls back to phy_interface, preserving
> the existing behaviour for all other boards.

I don't actually see a need for mac-mode. From what you are saying,
there is no choice. The MAC is hard wired to the converter block. So
you can just look at the compatible. You are going to need to use the
compatible anyway, to mask the phy-mode to handle the "MAC" doing the
RGMII delays.

      Andrew

