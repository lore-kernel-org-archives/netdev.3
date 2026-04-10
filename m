Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695782DA749;
	Fri, 10 Apr 2026 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807430; cv=none; b=I0VBed52eR1yNN1mMLn+klrTqahWbCkLYZ8D4ZhOKD+7DNYqYyUN8vQL4pRVzgiMjdgjNiZB/FV27M756W0AUaQmjjwAlsSjBblVlQ96uSZSpwRsp4OSfc6LO0gtd4IomDp3Eucfd09i0UsssqcjJt5z9KiI1jtK5vkGFGGklYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807430; c=relaxed/simple;
	bh=hWfMUrd3Kjb8PtQWZzix6P6/YWd6UH2YL5UcraBYBIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edJUz3IFmD9CWH9HZuXa5AFJgy0KrV3+Kd5cpjmkQ0S75uRsGw9dWJYLgRayhdFbA/rQrPPeWmFgijDLZ7mwPVyAdwDT6VmcaS0mcW2LIl7XT6xv+6fS946vQEj1W2Mzuv9Ce1Cf/fJ2ECWMKhxLTpUwPylpR7mWg8iZNldvvy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=a4Olywbl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="a4Olywbl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B1BxrsFUKX6jqT453u4B/bslW6vUL7jkrbnkrOn6egc=; b=a4OlywblGMI3RLpc/SxnvAjiYp
	hBQ2RFziq7gw7crLvOQT4/8c9Ml8bV/Kajls5SLyyMa9plyXZWrLAvg4Dlcd5085D1sFMVb+m+egg
	utCpC0dSxe+lM1a77OsHX8XgstoACYu+DYpHq4n5MgTMULv7kcS5Y87ZKs7DjZS94Z0DuO3kQPwak
	WBm8Zw3yKG6PVMKwCl3iChgH6AKDnBVNaXA2c/56nJL3Qka2zqCT+kbxbMZM70iAOls+gtCAgGn7W
	c77RGstUTegUNzrhum9gFYjKQtlt8NjmpP97w8w5A1Zdpz0TeoTFRrNgwqUj9/urh+DTKzTEP1PJM
	XnZQvAVw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36062)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wB6d2-000000004bi-0CC0;
	Fri, 10 Apr 2026 08:50:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wB6cv-000000005S9-3wXl;
	Fri, 10 Apr 2026 08:50:05 +0100
Date: Fri, 10 Apr 2026 08:50:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: KhaiWenTan <khai.wen.tan@linux.intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, maxime.chevallier@bootlin.com,
	ovidiu.panait.rb@renesas.com, vladimir.oltean@nxp.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	yoong.siang.song@intel.com, hong.aun.looi@intel.com,
	khai.wen.tan@intel.com
Subject: Re: [PATCH net 1/1] net: stmmac: Update default_an_inband before
 passing value to phylink_config
Message-ID: <adirrTJujEsrsK4F@shell.armlinux.org.uk>
References: <20260410020735.327590-1-khai.wen.tan@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410020735.327590-1-khai.wen.tan@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 10, 2026 at 10:07:35AM +0800, KhaiWenTan wrote:
> get_interfaces() will update both the plat->phy_interfaces and
> mdio_bus_data->default_an_inband based on reading a SERDES register.
> 
> Therefore, we moved the priv->plat->get_interfaces() to be executed
> first before assigning mdio_bus_data->default_an_inband to
> config->default_an_inband to ensure default_an_inband is in correct
> value during PHY setup.
> 
> Fixes: ca732e990fc8 ("net: stmmac: add get_interfaces() platform method")
> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>

Patch looks good, but the blamed commit is wrong.

d3836052fe09 ("net: stmmac: intel: convert speed_mode_2500() to get_interfaces()")

introduced the problem.

The commit message could also do with mentioning that dwmac-intel
regressed result of that commit.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
