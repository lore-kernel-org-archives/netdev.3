Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459DE3DA5C6
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047307; cv=none; b=SO6xI3MpTPMYj7Wqs95+vly0Xu8gxqjnIkT0m/T+Zqd+umpiTHKTyiuOsA+tRdctrKh2GOdWniEPQtCcoRwxn3TOn+72zrU0wk5sZxZfxUvZU7XiStvS3JagavhOFSJ1YYfIqIOIwRFd2S+1Gv23rbkmDf3CYM6IIE1MYOtar98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047307; c=relaxed/simple;
	bh=+NtCaUUsSKYFjfs2ocXw9v7dMhPLM4xoeDLyCoILMEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSMBVbz7iFYKvShwUJgDlZyZhq7ZTWhngNfM4V15YoUqxtzPTXiNxbm2ei6SuMkg+WVWkE6ewRFHh43cX4VEziBDl3eo5N0ECXfT8qbqFdmI2sOk0I99LpcbzBPYy1RgRv96MwZ+Rr1E/UBw2VR7fHoWp8C5WKAuL7eSML9D42k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QqZ3P5kK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QqZ3P5kK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CAJkGlVFFT5U5e9C33pZw9eYz6tOfkAlvygEpeiNyAc=; b=QqZ3P5kKTng55RSp24e8WL9pFp
	kxxW945wya/yGkD+OCYaakgseH/ZLXGnV283N2MPWp6TxGMv4Lw01haT3O1T9Lt3gLNlmh2LYyM33
	gHu4CsanYmckmO/ihT6vvfAOdAT4ZWU9ahKlx3+kHAeuuQChhuttI2GauljtmgObYM9rCBbtKYjab
	zluwYonWg29mn8hu/jGaU+3i02JhK3C+8LoWZBoXyGRyryYXsUU3v3YNgVEmKjc9x0tXhkxYVC1Kj
	gN90iub/NLhGtqLuWDGuRs9KgUkh+KS4g/B+XiIoF2XFYAkzzZtBBWRiEaTEleyUUpwVQOokhIDZ2
	j9yh3goA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56488)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7ut7-000000003Ay-0Wt2;
	Wed, 01 Apr 2026 13:41:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7ut3-000000004nl-1sY8;
	Wed, 01 Apr 2026 13:41:33 +0100
Date: Wed, 1 Apr 2026 13:41:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 00/14] net: stmmac: TSO fixes/cleanups
Message-ID: <ac0Sfd5E00Z8RjDX@shell.armlinux.org.uk>
References: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
 <420f910f-523d-4a74-a255-2fe48909283a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420f910f-523d-4a74-a255-2fe48909283a@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 01, 2026 at 02:19:27PM +0200, Andrew Lunn wrote:
> > I'm moving the setup of the GSO features, cleaning those up, and
> > adding a warning if platform glue requests this to be enabled but the
> > hardware has no support. Hopefully this will never trigger if everyone
> > got the STMMAC_FLAG_TSO_EN flag correct.
> 
> Is this:
> 
>   snps,tso:
>     $ref: /schemas/types.yaml#/definitions/flag
>     description:
>       Enables the TSO feature otherwise it will be managed by MAC HW capability
>       register.

Like much of stmmac, this description is totally wrong.

snps,tso sets STMMAC_FLAG_TSO_EN in priv->plat->flags, and priv->tso in
unpatched stmmac:

        /* Disable tso if asked by ethtool */
        if ((priv->plat->flags & STMMAC_FLAG_TSO_EN) && (priv->dma_cap.tsoen)) {
                if (features & NETIF_F_TSO)
                        priv->tso = true;
                else
                        priv->tso = false;
        }

and:

        if ((priv->plat->flags & STMMAC_FLAG_TSO_EN) && (priv->dma_cap.tsoen)) {
                ndev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
                if (priv->plat->core_type == DWMAC_CORE_GMAC4)
                        ndev->hw_features |= NETIF_F_GSO_UDP_L4;
                priv->tso = true;
                dev_info(priv->device, "TSO feature enabled\n");
        }

So, basically, TSO is only enabled when both the hardware supports it
_and_ snps,tso is specified.

Whereas the description suggests that snps,tso overrides the hardware
if it's specified, otherwise the hardware capability is used.

Given that the hardware capability says whether the hardware is, umm,
*capable* of TSO... yea, DT binding is basically wrong.

Now, how many of those snps.tso in DT are ignored because the hardware
doesn't support TSO... I guess we'll find out!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
