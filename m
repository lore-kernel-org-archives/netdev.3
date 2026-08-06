Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922423A8734;
	Thu,  6 Aug 2026 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025285; cv=none; b=dR17jFhJYFJsvM0MfytFs42U5jAj8KzIQn6TKwgi3C0CWiCUji8npu2b2OtN1i6vc7DUYKj50AjjOktnvAj/EsVm5VWX41KT0xPf2rM4TcKwTPuhvVCBd9gWd010E5WMk8Uqv+RpL6VQLW38HsrlhbPmFtQGiJ5u/9U1wbPSk8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025285; c=relaxed/simple;
	bh=7QfLPup1TVyoVI0T3ZggWOWebXh3+/TcVirM1mT2tkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ae5sXTDyPiKsCbj+gkCN9P6dngtnhj3T4haqx4bjs0CYl01yVBCI7L0q02TjWHin6iGcQRAMbf9b9WmTMhD+P9iWH+ZdwXEPBiBcAp0MSxMplbnUJLLkZbosPDprJ+cKiDq81X/TI9rYOZ4WV61u9glvMoTYyICQmASSFwspo3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2FzUpSRD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2FzUpSRD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CDt50ZbSfecwIguvUrRfu92OtUWjBxx8JFM0g8yVGpA=; b=2FzUpSRDhBmdvyV4gLJg+DyzDy
	SXUJIk87J2EERnzgv0JCMg9kos6v0p0Escx7gR2Tl8zUgRvM0KQFy6rtorJcMKeJmeeZTOp0ityb/
	WMPyaJ0kyNFUGwjSlj0o876exhGK5qwhGnCfLcM7mw2Ec4o0QKGUom75Llkn07yi6x6E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrylF-00GO3B-0m; Thu, 06 Aug 2026 16:07:53 +0200
Date: Thu, 6 Aug 2026 16:07:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: phy: realtek: fix EEE advertisement
 write on the internal PHY MMD path
Message-ID: <c006535e-f416-4c25-943e-a9e84c1e6c71@lunn.ch>
References: <20260806134716.3511821-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806134716.3511821-1-o.rempel@pengutronix.de>

On Thu, Aug 06, 2026 at 03:47:16PM +0200, Oleksij Rempel wrote:
> In rtlgen_write_mmd(), the MDIO_AN_EEE_ADV case swaps the arguments to
> rtlgen_write_vend2(): it passes the MMD register number as the OCP address
> and the OCP address constant as the value. The caller's value is discarded
> and the write lands on the wrong register, so the EEE advertisement cannot
> be configured on the affected PHYs.
> 
> Mirror rtlgen_read_mmd() and write the value to RTL_MDIO_AN_EEE_ADV.
> 
> Fixes: da681ed73fb9 ("net: phy: realtek: improve mmd register access for internal PHY's")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
