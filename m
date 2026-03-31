Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7036A3D3CE4;
	Tue, 31 Mar 2026 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956740; cv=none; b=tAfcdFuZs8nRPcgFpLxOSeby7nYy05axmGVmmg5rCWG5ybe7PBQi+wgH6Ks57dw6GwChvN1LXD11zqdiTOQRGKlk6s2bRRem7CeFp99EcPS1OHb2gx72MVsWhH4GBiPpUPJ4cwWSnCxfDWHZiPKhC5u8BTVJ6q8WvWE8BpeoBdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956740; c=relaxed/simple;
	bh=uWvD8OMz4WC6x8GO3aWXa1F6pahPRvU98JbiBGw9yDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpc2dpEx5t0FSjiu9Q4EGkkfPUya2AXf54C/bCGl37lNF3d4wR2241Oe9B9FGMChYSZ/bk+e/Gfso25oD/oXsqvYCotQSPeHMe0VfojbOWeb+zjV2SdZhr8NiX+GDc7b3yuBGHFhmoAypji2VJQVPe3Nl56WGGoGAi3rehr99S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fxiRpoKY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fxiRpoKY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uYqtW2F2Ni5winkOH9lfGjwrb6edTSs5jBu1jVMFlSA=; b=fxiRpoKYc5IcBtR6cQgCbX/6fF
	YSHWIeRlno1ZwSdI9vFVFueOGbrTzr+uBfSZfy3ni2s3e6aGqLgO3VD7NnrX0eT+r1SrchJpIZB39
	FVBvOms9vBQPzft3rZZQOaXM2b5mx8Pr/q2A4xKNOoWpFgInoQ9TfccOu8/OyJJl5m/KTFjVaI4fL
	g5YvjmGMXmpo89tLtjxbwINFf/vDLUSoRzQOk22lqkDNG/vaD8per6Q1nxCeP3I3IJ78qPc25uCQG
	HoAbz/fkLQes6POSajIRpC+fMZL6xz9La+rap6bjd65VV2x3ZgEh8vOB1Qi0CWufRh9uIo8FwDcsu
	eW7qTjbQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45026)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7XKS-000000001m6-1D5V;
	Tue, 31 Mar 2026 12:32:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7XKQ-000000003gP-48P0;
	Tue, 31 Mar 2026 12:32:15 +0100
Date: Tue, 31 Mar 2026 12:32:14 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] net: phy: microchip: enable downshift by default
 on LAN88xx
Message-ID: <acuwvoydmJusuj9x@shell.armlinux.org.uk>
References: <20260330224630.579937-1-nb@tipi-net.de>
 <20260330224630.579937-3-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330224630.579937-3-nb@tipi-net.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 31, 2026 at 12:46:27AM +0200, Nicolai Buchwitz wrote:
> Enable auto-downshift from 1000BASE-T to 100BASE-TX after 2 failed
> auto-negotiation attempts by default. This ensures that links with
> faulty or missing cable pairs (C and D) fall back to 100Mbps without
> requiring userspace configuration.
> 
> Users can override or disable downshift at runtime:
> 
>   ethtool --set-phy-tunable eth0 downshift off
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

I'm slightly concerned by this commit. ->config_init() is called when
the netdev attaches the PHY, and also during the resume path - and it's
the second one which I believe is a problem here.

If the user has configured the downshift, it is reasonable for the user
to expect the setting to be preserved over a suspend/resume. However,
by placing this code in ->config_init(), you will overwrite the user's
setting when the system resumes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
