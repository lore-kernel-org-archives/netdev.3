Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F22340417;
	Thu,  1 Oct 2026 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856483; cv=none; b=uv6NxFHkoV/bVsiQ0ACKXavjEGCK28i69k8YrnhrMl+IyEhLxbzTmfM8CEfeTm39ljynSFByA1nbp0QAUSVceGUDqG1RqK27A1KIYXX/CWXvCmPaF7NKXGdp+hxj8PBYgtpxjgBpwQIYqy93l5EiZ7Ds60izRosntHsTFKsvgMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856483; c=relaxed/simple;
	bh=yP7VXMieC1ae7RLGmbXh0dR1MmRHi9+xnYzns8xmVfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoD3B1mdNIp8QIN1oZ1tg2B1zM9XeE27392VBwPqpk79LDdoApIpg3OxuiyW0ri7zyVhuixCPWRfsi3a5i94lfJn0wfelSkez0eprtfQHVyUvrKc+lbNujKsij77s/x6Lohfu9WS1XQCP9dIIVyL8c6CvxrguxTgN0IOAQT6gwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ye8mKcwn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ye8mKcwn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GyeCL9VLJDxMlJIwAhfIiiYyFP5Y9P0dKixR5n332YQ=; b=Ye8mKcwncV2q0EFynQY8I75wMz
	hVFo5KdGFWQZ0bX2vuoMzoFyHomXTilBCNrEZBPSOKO6AAPOezLJHjBYytN5NZtUxtBvAJ1xqcyuO
	cA90bJZ/zuyeV7RVEI2UONmcOjVw0YUcfLRhJ8igOhqIBDej3f85K5Mt4Zr6X+XNp1XM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xCFZd-008N7b-Gy; Thu, 01 Oct 2026 14:07:41 +0200
Date: Thu, 1 Oct 2026 14:07:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Igor Velkov <iav@iav.lv>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Eric Dumazet <edumazet@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: keep the GMAC powered when
 the PHY wakes the system
Message-ID: <1795d1c1-7103-4dcb-856f-8881521417e0@lunn.ch>
References: <20260930-dwmac-rk-phy-wol-v1-1-9fdc50bd9ae4@iav.lv>
 <1799630a-945e-49ca-b9d5-9e068c482cea@lunn.ch>
 <ab67bccd76b55d7252c5380a37809656.iav@iav.lv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab67bccd76b55d7252c5380a37809656.iav@iav.lv>

On Thu, Oct 01, 2026 at 06:11:09AM +0300, Igor Velkov wrote:
> On Wed, Sep 30, 2026 at 11:51:45PM +0200, Andrew Lunn wrote:
> > You have not answered the question why is hangs? Given the current
> > description, this just sounds like a workaround, not a fix.
> 
> It hangs because the PHY interrupt handler accesses the powered-down MAC.
> 
> stmmac sets mac_managed_pm, so mdio_bus_phy_suspend() returns before
> setting irq_suspended and phy_interrupt() runs the handler at once.

Why is the PHY interrupting? What interrupts are left enabled? Should
the mask be changed to disable everything except wol?

	Andrew
