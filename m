Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A7A40DFB9;
	Tue, 31 Mar 2026 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963526; cv=none; b=NSu7Wv/c6ESo5/PGKeyryrPQJZYqAmOmlwd/ESrYBLaoB5kHoMJM9PIUkr2g0aajf2ZBYxPDkYIIsQqD/ZdGlK/lFrGEhzKqPeMB7rxdr5OmlhjXZhgs3AmWj4Gq7G5UbRYZ0aiJ0db5qP2th88qnC+LQADkxH+CCcWCW6PJHgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963526; c=relaxed/simple;
	bh=Ly6/4S7J4geHgQY5tvnPgbhPiiPxZ9OCJ/8Jtke1RcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV0J5acZBfchT+Cuyz2R7ajcu3D1auWyrMQqHN42Lnm+D+oUFZkzE+6oK9W5Jz+rWvi53L3aowJx442FaALG+vBared6JJLSKPVlIK/Jh1Z2oGXDfoa+XIYnctIFXvTUTWyEFNAV55z0MXqD9zLo/k8ghQ4Nx/BQB1bMSXS9AlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ASE1G+jB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ASE1G+jB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DT+vgC5GXM15UUYIt8jVOrq7hQsR3Kl52e6YumuVgbo=; b=ASE1G+jBY0+Zdw7m+MNrwynC3M
	oz1UtlZZ8QrFCgHW01uF8i3NGyZ54AbmCEiMkVTqTAhPkRqLjopmruGoYGctz81Sq5uUPunwrNMoN
	DLbLRt3ZEBAb1pfCnJXhfdw3pLUm1i15h8fpfJCgpXTW4xmXRN16fpK5mILuWEaegy4xefNKObCVf
	heNp+hlKFYCCNrbVfDYkooB3XjjyWeCauOSEresJzTdXLdTvq9YuO06ZXRXqGjwHvSDFmfnBMHK03
	iGMn3gCTXTApIpnrYe/9g30ihDgwiTOovgpnS+5JgWwMXvIkS8lVBMsayN7yPz8I3xDBk/+/wrVjg
	9i8iExCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43612)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7Z5l-000000001se-3Q5v;
	Tue, 31 Mar 2026 14:25:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7Z5j-000000003lJ-3F0n;
	Tue, 31 Mar 2026 14:25:11 +0100
Date: Tue, 31 Mar 2026 14:25:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Julian Braha <julianbraha@gmail.com>
Cc: manabian@gmail.com, davem@davemloft.net, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stmmac: cleanup dead dependencies on STMMAC_PLATFORM and
 STMMAC_ETH in Kconfig
Message-ID: <acvLN7toll85veZy@shell.armlinux.org.uk>
References: <20260331125817.117091-1-julianbraha@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331125817.117091-1-julianbraha@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 31, 2026 at 01:58:17PM +0100, Julian Braha wrote:
> There are already 'if STMMAC_ETH' and 'STMMAC_PLATFORM'
> conditions wrapping these config options, making the
> 'depends on' statements duplicate dependencies (dead code).
> 
> I propose leaving the outer 'if STMMAC_PLATFORM...endif' and
> 'if STMMAC_ETH...endif' conditions, and removing the
> individual 'depends on' statements.
> 
> This dead code was found by kconfirm, a static analysis tool for Kconfig.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
