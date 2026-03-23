Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEEC3793DD;
	Mon, 23 Mar 2026 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258334; cv=none; b=nSQcfwnfIUlLYdqwCXwLokGKj8qMJWj2mR/cAryPosfK++d60JMcMMZD+B0RrVOnz+KjwGPyzBG0UC82b724ztmi6T5tq9zqKHVFarpQNJz7ENDh4o2q2RRXpaWqtR7CvbXctIjmLRqmZF7EFq/7DRQO56l+evTcJaQZeckK0c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258334; c=relaxed/simple;
	bh=Nw2H8UPnGniCUi7bpLmU8tenp051CDAoy72MalyTwVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGomVMZdqMydJbWOLm7/M8K/L3dm1a8OQwjHG0aLYQrFfXDlhYUDI3YIAkgKmDEu+HXaILYgs6b1uKBwMWEzv4d/ci11psg2H5+WvE5mf7jX0cT2ssN3pekYVNS1Ozv3Cmp8a0AyE7yAb2MF2Gxj2YomTTuT/LgK+fP9HtUyoVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DTXlGIWC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DTXlGIWC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vw4FyI3ZHdlhaTG9Z9gacoa7d/BeZ3QcuEdmbc33NuQ=; b=DTXlGIWCet7aIZMApPsuukXR5h
	XjoYGvkNROsh38UzJz9LXFB3tHLEFc66zZkuEeUI1UMi42o2unZGoeHStkEpHeOJH2rVkhfKTMNV7
	wKcaPbBrNsiwjeL0lgCyVuUAAylHXHa3OQFHgFYhPnqbJLtYdDGmfUxlwA/1RnJPsKIp/5L+LcT4a
	T3Gv0rOT5rT+znlAvnJvTkEjehr8DOXAQ7uqVtfjOyG/AexhfRVbzGxVs0brYnG9BeWw69AFTmm61
	9IvjRspdoGLp51T1yrabSGbG2pB6W6C25o9tzZkavzLCmbatIBCVihngroHbiZk2zTOy16IcTvAj1
	gleRMGiA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37754)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w4bdj-000000000DS-30nj;
	Mon, 23 Mar 2026 09:32:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w4bdi-000000003ux-0uzH;
	Mon, 23 Mar 2026 09:32:02 +0000
Date: Mon, 23 Mar 2026 09:32:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Raju.Lakkaraju@microchip.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: lan743x: fix duplex configuration in mac_link_up
Message-ID: <acEIkidIfKgMQHfk@shell.armlinux.org.uk>
References: <20260323065345.144915-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323065345.144915-1-thangaraj.s@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 23, 2026 at 12:23:45PM +0530, Thangaraj Samynathan wrote:
> The driver does not explicitly configure the MAC duplex mode when
> bringing the link up. As a result, the MAC may retain a stale duplex
> setting from a previous link state, leading to duplex mismatches with
> the link partner and degraded network performance.
> 
> Update lan743x_phylink_mac_link_up() to set or clear the MAC_CR_DPX_
> bit according to the negotiated duplex mode.
> 
> This ensures the MAC configuration is consistent with the phylink
> resolved state.
> 
> Fixes: a5f199a8d8a03 ("net: lan743x: Migrate phylib to phylink")
> Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
