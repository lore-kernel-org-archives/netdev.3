Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DA11C3BFC;
	Mon, 30 Mar 2026 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874161; cv=none; b=aCZfQcuksmxG/txkKAOktjnxDZ6WzUGnTNDS7u/QtW/Pbr9VITU5wNc+C8QR3k/aEN+wg6a8AjcwHM4c/y+XZLtBTMuovYkeUtG/fcl/rdaM1qCje5Hh9PemobtZHl6Elzed2kOtrPRRNF9zvR6njWgPAOHt/QiJSGnuW3ZYKas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874161; c=relaxed/simple;
	bh=JgLz3/9DYWLbmsDqByx5eAD23pD+Ig2Gi9+AabgwnYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCjrjihOPMlKRMYlgnF6lrhz+PHuXjeg1XozbN9pVGr0aoK22/55hkbtaZKH6anyQFAqtVmbPvjU5QBXP1wNc7sLLjkvGCU8etJkIUt3ZBMvqdTT1H44oVNCvuZ39o5ktX7AtVAl2xLOZzg0SzYjF/KS0T5Y48JTJFEMK06CmPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1SkUQbL6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1SkUQbL6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wYBKS7dt5j38ighh50PUCkRqON2g0NPUuA+55y0x1ts=; b=1SkUQbL6OFfy1tSZ9NRgzdUTff
	nx10vqYDxRH/htdOaPiVosjSKdhM+qxPyDPb/ZeO7l4XS0kH0sLr7vfDRKQspBuuHzII56mZcUeVW
	pPYw7YPK1B530+BU4J4hpwSn8/TEQjcj6IM/G7WUTz09DeLGTvMLc3ou/fsCMWQZ6JEE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7BqF-00E1x8-5E; Mon, 30 Mar 2026 14:35:39 +0200
Date: Mon, 30 Mar 2026 14:35:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next] net: stmmac: qcom-ethqos: set clk_csr
Message-ID: <0d650de4-eb45-481b-8c39-1bf455b948c9@lunn.ch>
References: <E1w6AZm-0000000E54W-1F6E@rmk-PC.armlinux.org.uk>
 <9d0a529a-d065-4f46-a93b-23195a4f9727@oss.qualcomm.com>
 <acpqgpCsbo3lJs3l@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acpqgpCsbo3lJs3l@shell.armlinux.org.uk>

On Mon, Mar 30, 2026 at 01:20:18PM +0100, Russell King (Oracle) wrote:
> On Mon, Mar 30, 2026 at 01:18:56PM +0200, Konrad Dybcio wrote:
> > On 3/27/26 6:02 PM, Russell King (Oracle) wrote:
> > > The clocks for qcom-ethqos return a rate of zero as firmware manages
> > > their rate. According to hardware documentation, the clock which is
> > > fed to the slave AHB interface can crange between 50 and 100MHz.
> > 
> > FWIW this __may__ possibly differ between platforms, but I'm not sure
> > to what degree. Will there be visible impact if we e.g. have a 200 or
> > 300 MHz clock somewhere?
> 
> When you add other platforms, you're going to have to deal with their
> differences.
> 
> IEEE 802.3 states that the maximum clock rate for the MDIO bus is
> 2.5MHz. You need to ensure that is the case.
> 
> Current qcom-ethqos code doesn't set clk_csr, and returns zero for
> clk_get_rate() on the stmmac clocks because they are managed entirely
> in firmware.

Could a fixed clock be used in DT to represent clk_csr? Different
platforms then set it to different frequencies, to represent whatever
the firmware is doing.

    Andrew
