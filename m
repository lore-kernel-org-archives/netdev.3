Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CACC19EED3;
	Wed, 11 Feb 2026 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770805349; cv=none; b=pjy2/0CbNIzizmZwjbyfRXROY4kbhKDNphJVmVeqMRjEuXDagBevgf3Olj5NPHF/ChseFQ500hZwtoHHRnzZSGWAltXMMSbuwcIv3h7qjxaR9Ub41i6bTds/83GNdTRQHmR3tUyiZpC5VoabcUjztH34rW31RXIpWFKN2bUd0gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770805349; c=relaxed/simple;
	bh=rBK6FdRF8RDJHWlLzixMxjhU3HjyL6p4/YgUmJotBDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Unq+lBt4mQlketzOgZBy3km+4BTDRvyUys39IgkQP5H/oThwlXVNUVQ5C7YudTSOb5W2NKorDdwoQeyrljGfrhREv56COIJwTaGp0cod4cBF062mjc0YjhKpky48gzMZV8Apk+9+g5t06FCcvMDu7kJ0CbWjnkBA/u5v+QM+opU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=z4W1LRrY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="z4W1LRrY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x26RJEZzvywxmqhbMuzA7A8coQZewEhYsgXJn0+8VIw=; b=z4W1LRrYkYWx83Y554+BLK4ps/
	kVIQ8R/xWaPBtSIVRSxNeQxUZR9q/qriUgI3IuFK/p+PhIWjaONg3mJu2RR/6f8/QTOZlhlqusSwg
	fkFoLU6UFJH/2vU5HeOMWorE3bHSPb5/aGh3gmzBViiPULwhubt4MLzZ00LMDV8A/V2u3P8UMCZUJ
	gT3QvTwSTWt7MvCSEIysqM6eXS6tX5YmDPQOBIjSfWpOX1z5pE60m5+Z8SR6jlEBJurVc3bBM+/1V
	BRp3ICKDwKulxr0GcBRYHmaLH4jh+TUOf1wacGWYe0JN6tDHwSQhA0J7sP2wDET0dBBh1GwXRPq0R
	JHoTO1jQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55616)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vq7MD-000000003Ij-10GA;
	Wed, 11 Feb 2026 10:22:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vq7M6-000000003hT-07hu;
	Wed, 11 Feb 2026 10:21:58 +0000
Date: Wed, 11 Feb 2026 10:21:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, ychuang3@nuvoton.com, schung@nuvoton.com,
	yclu4@nuvoton.com, peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v12 3/3] net: stmmac: dwmac-nuvoton: Add dwmac
 glue for Nuvoton MA35 family
Message-ID: <aYxYRZZkVFz2jHaF@shell.armlinux.org.uk>
References: <20260210052226.3005666-1-a0987203069@gmail.com>
 <20260210052226.3005666-4-a0987203069@gmail.com>
 <aYsurPBMnzWDZCco@shell.armlinux.org.uk>
 <747b9ab4-6711-426d-95a5-4ce6c8732edd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <747b9ab4-6711-426d-95a5-4ce6c8732edd@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 11, 2026 at 05:52:21PM +0800, Joey Lu wrote:
> > Is this register preserved over suspend/resume ?
> 
> It is not preserved by the GMAC suspend/resume flow and therefore needs to
> be treated as a system register rather than a GMAC local context.

That is another reason to use .set_phy_intf_sel as that will be called
just before GMAC soft-reset in the .ndo_open() and resume paths.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
