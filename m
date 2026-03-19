Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA023BAD96;
	Thu, 19 Mar 2026 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912266; cv=none; b=exeWq9z4LKtsxVS9YgwbG+21gOz4+AZhaLLatJX1H61Be5eFrt1WqRLjPCFBg6C4zXR6kRaylN0UclEs1QVF3pxTsW4ywJriQRmIc3KqNPTWKxEr5xxXv1H52N66WusS3u33wbdZCK2A8CLWF/nCb5JeSVPD5KEOmNAAqdSsN5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912266; c=relaxed/simple;
	bh=DS+Zt/gEv/WAbeWYllp8LUq+PkKXC3XUp1VYLwde/ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmwD+tMMlPqOUkKYuXoGmUnaPgjr7W+Qjb0XqSt5G+3aygLE90iz7FEJz9/DLpTU1Qy5RbgTuskC//yAXCuLTENf8FI7zErSOrok1k685R9QZoycQYuT1WhAlWhvdzt2MPeiPE3wt02yFE7sMpgmqE+4gwz5kgCfRyZgL9g2VZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=V9ViYl4m; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="V9ViYl4m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wJt/xpnM5xpQ9m6S0Jhmk7m0+jbWUyf+lp4bNeFUlMs=; b=V9ViYl4mTpgvWY0lWySwuoVuME
	iZ0ZlE/SNmOJSdwCXiDp2aVCWvLcO1IsWqvDLQ6Waf9Jp92guN/CiUOzBfcJGexKjOu5QaUHKXihL
	FGgxe3c6o+bZj4DjmSw24TqDDrs0sTimw0wMLZrMNx1tKAOHAljBRZWEM+GZaaJB5I7fY8LZI2cMD
	3y1ogT3Jb38P1YFTgiu9DKxJUbyphk9YZ2swdfEXvb6n634qzw36qz9sKdiRY633fDLtyhWxeo2FJ
	qTh27iZt3nmZp2MZXEWYM7vc91gFozf5I3rshlNjtZyvsZOPScS+6ax9DY6UVsv7RHVM5rZqu839Z
	TM39otQg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58408)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w39bv-000000004Wg-44EL;
	Thu, 19 Mar 2026 09:24:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w39bs-0000000081c-38rg;
	Thu, 19 Mar 2026 09:24:08 +0000
Date: Thu, 19 Mar 2026 09:24:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next 0/8] net: stmmac: improve PCS support
Message-ID: <abvAuHFZzCFobO-V@shell.armlinux.org.uk>
References: <abQC7r38QLhSeadl@shell.armlinux.org.uk>
 <abdEscs44fU4kRag@oss.qualcomm.com>
 <abdYu864OmNWiWIW@shell.armlinux.org.uk>
 <ablpxwGks9m38fhM@shell.armlinux.org.uk>
 <absjNQ2s3Z5N2Zwo@oss.qualcomm.com>
 <abtE7sDT75I7uPnk@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abtE7sDT75I7uPnk@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 19, 2026 at 12:35:58AM +0000, Russell King (Oracle) wrote:
> On Thu, Mar 19, 2026 at 03:42:05AM +0530, Mohd Ayaan Anwar wrote:
> > [    8.650486] qcom-ethqos 23040000.ethernet: clk_csr value out of range (0xffffff00 exceeds mask 0x00000f00), truncating
> 
> Please look into this first - with the MDIO bus operating at
> who-knows-what frequency, this could make reading from the PHY
> unreliable.

My guess is clk_get_rate(priv->plat->stmmac_clk) is returning zero,
which means we don't know the rate of the CSR clock.

From what I can see in drivers/clk/qcom/gcc-qcs404.c and
drivers/clk/qcom/gcc-sdx55.c, this looks like this case - the
struct clk_branch makes no mention of any clock rate, nor does it
have any parent. From what I can see, neither of these drivers
specify any rates for any of their clocks, which likely means that
clk_get_rate() will be zero for all of them.

Sadly, when I designed the clk API, I didn't think that people would
be stupid enough not to implement the API properly, more fool me.

Under the old code, we would've used STMMAC_CSR_20_35M, which means
we're assuming that the CSR clock is between 20 and 35MHz, even
though the value is zero. Is that the case? If it's higher than
35MHz, then you've been operating the MDIO bus out of IEEE 802.3
specification, which can make PHY access unrealible.

In any case, please fix your clock drivers.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
