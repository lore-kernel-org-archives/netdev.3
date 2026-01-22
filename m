Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AD339F310;
	Thu, 22 Jan 2026 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098982; cv=none; b=YvDpGGpe93Vjdk9aHXQVNZUs+RGIG+ef/faWLmMyw6ulg2e6sk+60EGQi/C4gdAXNo1sn0FJjiUo3qlAxublfGovftpAv9XGkHIAtDZwp3XSpDbUVuDMRLefTdY6FgC/6N+ofxzXzubSLpMtGoF5Zh24Lv+pD7hjof6aUb2j3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098982; c=relaxed/simple;
	bh=3ddLLMocqzjgPG2VQ8xOi1yWp4oyUF8X95qnENFTwrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb/zEiohE60EG2nmRS3skN/gGzHtuYe7rKH75ZklHqOivV5EvAXcES6+xf1l3stvmd4XkGTmcygKXIc4XhFP8hlCkRkGZnlHvpU99SA06AqA8iCopwyMeKzsYVleAJRYXfJcJCJn68GwV3lKv/dxmsbm9+1p7QgZSZJB0ICUtGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KrTIkEZ8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KrTIkEZ8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QykwrNRD3WLxos9vHKgsroa2kUMOmekOJY3UepmxBAQ=; b=KrTIkEZ8SACnkn02GcGVYP5rH2
	IEA3KpP0Ns/JWmcNODyqHGbgRG8djIM28gNgToYqqI/r3l41JRb5ZHGk9INxN3U1zzcYvSldw0BBm
	q7wS097tuBr1vHCtuazpw82oVfbpQuQssNp60YBmFTncDggOtF8sABLIe80YPmpXX+b6UNizmwM61
	QxPZ9+4F3vaNWAP+BmbTvzLYwZssnXplfS5HQD39t2y6hUZAJV9ZdtcmXFK4AZ66iKTncAyN+QV0Y
	lCUcvdCJnPC06+8f1fT5QL3ex4wPoQg0/orv1+pdNO1c/ijvswwCY7yri1j+hv/JXpL63s2PupOCQ
	RdftnSSw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55402)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vixSJ-000000000he-0CW9;
	Thu, 22 Jan 2026 16:22:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vixSH-0000000018V-08Ob;
	Thu, 22 Jan 2026 16:22:45 +0000
Date: Thu, 22 Jan 2026 16:22:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v5] net: sfp: extend SMBus support
Message-ID: <aXJO1GMQp2Z3UVmf@shell.armlinux.org.uk>
References: <20260116113105.244592-1-jelonek.jonas@gmail.com>
 <6a87648c-a1e8-49a2-a201-91108669ab44@bootlin.com>
 <6987689b-35ac-4c15-addb-1c8e54144fa7@gmail.com>
 <5e7c71f6-80dd-408b-a346-888e6febf07a@lunn.ch>
 <fcf7b3f2-eaf3-4da6-ab9a-a83acc9692b0@bootlin.com>
 <fe1bf7b6-d024-447c-a672-e84f4e77f8d7@lunn.ch>
 <91442f3f-0da9-4c52-89ce-2ca0a3188836@gmail.com>
 <66e8424c-86c9-4ad7-a3a7-3c277bfa5432@lunn.ch>
 <d223bf52-ba2a-4185-930d-e9db9dac9d80@gmail.com>
 <92538fd0-aa1f-429b-9984-89bcd46e2a28@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92538fd0-aa1f-429b-9984-89bcd46e2a28@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 22, 2026 at 05:04:29PM +0100, Andrew Lunn wrote:
> On Thu, Jan 22, 2026 at 11:14:03AM +0100, Jonas Jelonek wrote:
> > Hi Andrew,
> > 
> > On 18.01.26 16:39, Andrew Lunn wrote:
> > > On Sun, Jan 18, 2026 at 10:43:12AM +0100, Jonas Jelonek wrote:
> > >> Hi,
> > >>
> > >> On 16.01.26 15:25, Andrew Lunn wrote:
> > >>>> But let's first figure-out if word-only smbus are really a thing
> > >>> Some grep foo on /drivers/i2c/busses might answer that.
> > >> Did that and haven't found any driver in mainline which is word-only.
> > >> All drivers with word access capability have byte access too.
> > > So for the moment, maybe add a WARN_ON() for an I2C bus that only
> > > supports word access, and we can deal with it only if we ever get a
> > > report of it firing.
> > 
> > Should it just have a WARN_ON and continue (so it may work in some cases)
> > or fail at that point? 
> 
> I guess doing a word access when a byte access is wanted will either
> work, or immediately kill the I2C bus because the SFP is broken and
> only supports byte access, and the dead I2C bus will cause a cascade
> of errors.

RTL8672 / RTL9601C based xPON SFPs are an example, they need single
byte access.

Conversely, we have the Nokia 3FE46541AA GPON module which locks up
the I2C bus if one reads the EEPROM (i2c 0x50) offset 0x51 using a
single byte read.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
