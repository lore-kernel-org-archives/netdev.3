Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59FD39D6CE;
	Thu, 26 Mar 2026 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547263; cv=none; b=Lto5ZQFf1iTAhdv0P45RZCAEpuYYgsyw9GIQygl9Ulo2cpoDipYAMsiaXotLJ9JUlnDsqL8i5UTh8VdVhw/8LH3z3FgX9gynK1z+Li5Mqo1QpHNFdLDVnQnzyN8VC0TiHD1/hKunGnDzrgmOXA2z7lEGNb/jAVTG0JZQyGA30bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547263; c=relaxed/simple;
	bh=CUrYFcbk3w4Lb6jYsZ+v76HQreQicFweUxr8XUQzyvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWbtH4qPA9M5qG0oEqSmfua+pH8plW84S+mIaoDBXdFbtKEFBOuFRZydfeDqjjlyoJHeJbUybZ4tuVOY4ypEIByD/Jze4t0Qe2fF6r5PX9W9gkcAlzFB+yfyX4r6Bj6xXmQMR0nU0XHdEMCbtLNyqyVgHML39ueTx2phHDA3X3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XRgb8Lsv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XRgb8Lsv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AxDSnNL/u8N3iCRzT8SvQaiyV0V6Lf/VVxcJwZ5quX4=; b=XRgb8LsvWYsTTIlo8Zxg3c8Mg2
	SroOvC7VmpQrHi01O5KeJdSNXpz85f0PncL1ARLtaBuEHhNLTeOrAX3l1k7M4BgeMXUzy4BFO6nUz
	uIA5/7yikZ2Ba2kWKNxYmleFglUmhOyrDo1FZAIA4lvV3m9t80slEZwWjWi6I/CRVu3MBgHBH7Bp6
	Ozof29IoG+XDLRvsvYviwE3RkLTeBHSRl/qHyMr5MWHyJl/6Gw5H1wSE/TYY6ASRkuqEWYr6wK7G2
	Xsauw971tdYRmcOyvKPB55AyTzLe4pC8/g9wD6Sh1Cd79upmI1Owk88xXslWvnHd9k2H9sE6jO88U
	x3LYWhgg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34394)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w5onv-0000000057d-27mi;
	Thu, 26 Mar 2026 17:47:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w5ons-000000007Ec-4AcB;
	Thu, 26 Mar 2026 17:47:33 +0000
Date: Thu, 26 Mar 2026 17:47:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH net-next 1/2] net: stmmac: remove axi_kbbe, axi_mb and
 axi_rb members
Message-ID: <acVxNBLE8Ck2qfjc@shell.armlinux.org.uk>
References: <acJh4z3pRKkeaFbR@shell.armlinux.org.uk>
 <E1w4ydo-0000000Dlpb-34jd@rmk-PC.armlinux.org.uk>
 <20260326172943.GR111839@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326172943.GR111839@horms.kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 26, 2026 at 05:29:43PM +0000, Simon Horman wrote:
> On Tue, Mar 24, 2026 at 10:05:40AM +0000, Russell King (Oracle) wrote:
> > axi_kbbe, axi_mb and axi_rb are all written, but nothing ever reads
> > their values. Remove the code that sets these and the struct members.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Hi Russell,
> 
> FYI, AI review suggests that these fields should also be removed from
> Documentation/networking/device_drivers/ethernet/stmicro/stmmac.rst

I noticed. I've prepared an update if netdev folk want that to happen
as I've noticed that that documentation is fairly out of date now.

Do we think it's still useful, or should we consider deleting or
trimming it down? Would it be better to move the struct definitions
into the header file and making the header file part of the docs so
that the documentation is local to the structs?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
