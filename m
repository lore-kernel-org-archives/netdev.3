Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E373009C8
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774777255; cv=none; b=s5wqI7fEa+7sSQIWfeS0LMuQIDEjR37npgTDf9ioClbEkJDuBDJV6Qb09Zd+4yEVM5Yr5HxcQiFB8H1ceCeWqElrG16CMGBa9/TMULpIg1qHTM1hqGozXDC6RtXESfwuPTTV6k01jxAyCM16f79Yu7uu6x5I1k2ZZCONzZ7VNl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774777255; c=relaxed/simple;
	bh=X7sbKucCbl/JqdxspMjRfR/zWWx+5M7lhl/MNi5tH3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkW+H7wtpq0Mgrpy1UIYD87PT1BJRmwMpCFjErikweZDYIg46mMRfAka7WGff3zkl/BNcqvfsOYFu9sjHFEoN2XNKySEEGR6e4LSUm56NzWFpsu9208xTc6A4G9LsuOxhRrPjOirZu/15JYlA25QURq0p2OkKi51E9Rn1uT28ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Jc2Py1MS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Jc2Py1MS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VedDf6KjO7+dUX4YVKgtrHVL8jRFgWiX8TrdhyAcPls=; b=Jc2Py1MS/550Vpu9IWtlooDX44
	a0y5FYBt2WATmyZfNO92STW5xUTWe20esS0KQaitLEMVxE5zzvgpVCe+rGXRGf0nKgcKhnzpfVP/8
	HB0uIISrxjcnHVgMQgzk35Xa5LhZ7AVOgkHHiXLWa6PR3MI3d8M60nBpUUUnsM1nLJVlSxTcunyaC
	UvIW3GzBYgDtz87l1RA6s7K/U0JZjT/3yGHKm8hfd8cfCFOEyeZgAMmq8O+zKeDpSXU87fZR3V4IF
	33/hmTlexM7N21VguQNH6cZXzpB+RcuGNjg8QNUS86npk/fjLmlUkbf0Nd77xQKRd1QkY0BOI2BdZ
	//cPxMQg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49578)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w6mdT-000000007qA-0Mle;
	Sun, 29 Mar 2026 10:40:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w6mdP-000000001cj-2hQZ;
	Sun, 29 Mar 2026 10:40:43 +0100
Date: Sun, 29 Mar 2026 10:40:43 +0100
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
Subject: Re: [PATCH net-next 01/10] net: stmmac: fix TSO support when some
 channels have TBS available
Message-ID: <acjzmxY9xmBInSwm@shell.armlinux.org.uk>
References: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
 <E1w6bKj-0000000ELtf-3md9@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1w6bKj-0000000ELtf-3md9@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Mar 28, 2026 at 09:36:41PM +0000, Russell King (Oracle) wrote:
> According to the STM32MP25xx manual, which is dwmac v5.3, TBS (time
> based scheduling) is not permitted for channels which have hardware
> TSO enabled. Intel's commit 5e6038b88a57 ("net: stmmac: fix TSO and
> TBS feature enabling during driver open") concurs with this, but it
> is incomplete.
> 
> This commit avoids enabling TSO support on the channels which have
> TBS available, which, as far as the hardware is concerned, means we
> do not set the TSE bit in the DMA channel's transmit control register.
> 
> However, the net device's features apply to all queues(channels), which
> means these channels may still be handed TSO skbs to transmit, and the
> driver will pass them to stmmac_tso_xmit(). This will generate the
> descriptors for TSO, even though the channel has the TSE bit clear.
> 
> Fix this by checking whether the queue(channel) has TBS available,
> and if it does, fall back to software GSO support.

This is sufficient for the immediate issue of fixing the patch below,
but I think there's another issue that also needs fixing here.

TSO requires the hardware to support checksum offload, and there is
a comment in the driver:

        /* DWMAC IPs can be synthesized to support tx coe only for a few tx
         * queues. In that case, checksum offloading for those queues that don't
         * support tx coe needs to fallback to software checksum calculation.
         *
         * Packets that won't trigger the COE e.g. most DSA-tagged packets will
         * also have to be checksummed in software.
         */

So, it seems at the very least we need to add a check (in a subsequent
patch) for priv->plat->tx_queues_cfg[queue].coe_unsupported to
stmmac_channel_tso_permitted().

I'm also wondering about the stmmac_has_ip_ethertype() thing, which
checks whether the skb can be checksummed by the hardware, and how that
interacts with TSO, and whether that's yet another hole that needs
plugging.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
