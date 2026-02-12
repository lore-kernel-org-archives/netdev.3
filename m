Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891D29BD87;
	Thu, 12 Feb 2026 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892117; cv=none; b=Za0WKwynnF/TOVLHG0mNB52mVe4urkWb2GGecHqScPA5XejzD/V4jYnfzOtJW5/4uHC6ai+a7KLTQjFvA5rTS3oBsxURgxvEQGDPsOiSfixLv8mq9WmQXBcSig1FBnovO7J5s/PWfpdZ+5anPgYakVXcgFwmRYdFiq8InvuSOQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892117; c=relaxed/simple;
	bh=dDixvmDCxBfjKGZUfcrZCK8jjMgfeSQI9VVri2MGUxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yir5pMPnOp1IxcG1xaixzV+jgrHFsaWz0bqZfCpQf7edV0bthHxtFOqhHkmMUVZaLAiZj72KrvQVy5QnTcNWLDZMr/3YpYh5tqAUJ/HPGqUp7o3jQZT2+T8GEUyWqsHdiXkOudkhnnbT1AbsrsPovXW5wfxGCUdKfMHlCR+wJ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1riGLJb1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1riGLJb1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xSFJcBfVZKp82+Db3xO54CWUoHlWgz8IeqJYSETUKnY=; b=1riGLJb1LrUTq2AMxJAEE3fPYe
	GGAhsHEa5SOZDT9rTt0biTAUn50DlKRNx0SI58Ki1gpElxnFzDbIcTz3KYeBe3ZjGL1UmNW86V+Q/
	p5pUTRyhoyCSwsNJzEtmcqQvkPzP2RMr4aD7qeYVKI4ioPG0sQphqLV7Ej7U+LHbbLUqBKFhC87Ut
	RqYEns3IrdUHTgcItxWWeYTF4epkkC7RfnQcV0lVedVjPW8+NMnuNDdA1k5iOUTvK36Pr6+AxNjGG
	F2gQfai0V50HAyrXYgNq+ncht/5qgAPL3JGxKL7QFMnEQgOtSgbocJKaUuV9C+xvP+918nnj5CYB4
	+5wbXcxw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49322)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vqTvt-000000004QW-3erv;
	Thu, 12 Feb 2026 10:28:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vqTvr-000000004hn-3a12;
	Thu, 12 Feb 2026 10:28:23 +0000
Date: Thu, 12 Feb 2026 10:28:23 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vincent Guittot <vincent.guittot@linaro.org>,
	Rob Herring <robh@kernel.org>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com,
	p.zabel@pengutronix.de, ghennadi.procopciuc@nxp.com,
	Ionut.Vicovan@nxp.com, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	horms@kernel.org, Frank.li@nxp.com
Subject: Re: [PATCH 1/4 v2] dt-bindings: serdes: s32g: Add NXP serdes
 subsystem
Message-ID: <aY2rR3Hlm525kGUN@shell.armlinux.org.uk>
References: <20260203161917.1666696-1-vincent.guittot@linaro.org>
 <20260203161917.1666696-2-vincent.guittot@linaro.org>
 <20260210004011.GA2188625-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210004011.GA2188625-robh@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 09, 2026 at 06:40:11PM -0600, Rob Herring wrote:
> On Tue, Feb 03, 2026 at 05:19:14PM +0100, Vincent Guittot wrote:
> > +description: |
> > +  The SerDes subsystem on S32G SoC Family includes two types of PHYs:
> > +    - One PCIe PHY: Supports various PCIe operation modes
> > +    - Two Ethernet Physical Coding Sublayer (XPCS) controllers
> > +
> > +  SerDes operation mode selects the enabled PHYs and speeds. Clock frequency
> > +  must be adapted accordingly. Below table describes all possible operation
> > +  modes.
> > +
> > +  Mode  PCIe	XPCS0		XPCS1		PHY clock	Description
> > +                SGMII		SGMII		  (MHz)
> > +  -------------------------------------------------------------------------
> > +  0	Gen3	N/A		N/A		100		Single PCIe
> > +  1	Gen2	1.25Gbps	N/A		100		PCIe/SGMII
> > +  2	Gen2	N/A		1.25Gbps	100		PCIe/SGMII
> > +  3	N/A	1.25Gbps	1.25Gbps	100,125		SGMII
> > +  4	N/A	3.125/1.25Gbps	3.125/1.25Gbps 	125		SGMII
> > +  5	Gen2	N/A	        3.125Gbps     	100		PCIe/SGMII
> 
> Mixed tabs and spaces. Drop the tabs.
> 
> What's not clear to me is do you have 2 or 4 lanes?
> 
...
> > +  nxp,sys-mode:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
>        maximum: 5
> 
> Though isn't this redundant with the child nodes? You could use the 
> standard 'phy-mode' property in each child.

phy-mode is ethernet, but the above is more than just ethernet.

I've been wondering why a generic PHY driver needs to know this via DT
when the generic PHY API has:

phy_set_mode() / phy_set_mode_ext()
 - sets the type of the PHY and its submode (e.g. ethernet interface
    mode)
phy_set_speed()
phy_set_bus_width()

Surely these are sufficient to describe what mode is required from the
generic PHY, and the generic PHY driver can figure out whether the
mode is permitted from the above table, programming the PHY as
desired.

For Ethernet, we don't call the 3.125Gbps "SGMII" using that term. We
use SGMII strictly for Cisco SGMII, which runs at 1.25Gbps. 3.125Gbps
single-lane serdes ethernet is not able to use Cisco SGMII inband
signalling because running the underlying data rate with 10 or 100
symbol replications makes no sense. So we have decided to all this
2500BASE-X. If such a SerDes is connected to a SFP cage, then we
support switching between 1.25Gbps and 3.125Gbps mode depending on
the module inserted, which requires dynamic reconfiguration of the
SerDes.

What I'm saying is that describing a single mode covering several ports
could make things difficult in the future, so make sure you think
carefully.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
