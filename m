Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA143E1CE4;
	Tue, 31 Mar 2026 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774958485; cv=none; b=C5oAPMlb0cXZ0hepODpecIx9dx2Aboa7dYROx8k9V8xM0TKCs2zfAjMguuo8bCWQMGxqAePwuuwUS1G4V6QDfG1V41j96ebFQnXi97NhidCkYv/wN9X3XucAKIs0Y3uiN7q7JkUk3XTPTCC1/wLS/YV7xKO7+3Pj6xv66nVQKuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774958485; c=relaxed/simple;
	bh=19pbnbAimNIzR75qW8nQCtsMh4GPYhxXmu5AgTufCkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOqPrs68FY+fjQwXCd4Mq5n4QM5LMrf+2V93lltrF06n/kLmRduFmTPn8kxOUXJI8oPJcrVbOpuqz6UrxmiXAyixpAOWl83HHBQ4sN+kYpTKMBf5LX9OBRfQ1NUo67k/bT9gaUGo6ZUvvuLte+Dv3GCC5k36d1bdjGRG80G+KZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Brel6ArM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Brel6ArM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZyyR0akWtd4Mb0R7I/8TtMbIbfwANm6SSQf2dtf2cO4=; b=Brel6ArMqPToKbIEcL9qm5xu+i
	GLU+ilm4nbu/KjLa22PuJm00TH+5wE5PVuwLwbH0A6bu9lpfDb5J3azYJu5XYslJShsEkEG39egrZ
	llecS410lhs6NddsLuGfu/SUm8upqUOX+2L2jFnq9/hA/xT0EPWPrP/iwt8rlxOvDiHDErmI1QcvG
	wP+nR8C/CWs6TJ87iUX2aiRfr6+h5R4EqVNJcC5pSOi9c8i6wfHN+Qrmn3/3UOhs1hMUOenv0uKTM
	BBYr+tUE6ZBHvUTgO1XkjElLhQKzmaVYWW3VOz3ZlOdnRx7Ziwt6+HG7/WiBPYHdTN7qhifYksK7m
	2G5cPekA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49946)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7Xma-000000001nt-0nGC;
	Tue, 31 Mar 2026 13:01:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7XmY-000000003ho-1UKs;
	Tue, 31 Mar 2026 13:01:18 +0100
Date: Tue, 31 Mar 2026 13:01:18 +0100
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
Message-ID: <acu3jgGklIfDVp-m@shell.armlinux.org.uk>
References: <20260330224630.579937-1-nb@tipi-net.de>
 <20260330224630.579937-3-nb@tipi-net.de>
 <acuwvoydmJusuj9x@shell.armlinux.org.uk>
 <a7e4a17ed0ae027ee6ebfd5f79f7c85c@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7e4a17ed0ae027ee6ebfd5f79f7c85c@tipi-net.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 31, 2026 at 01:58:55PM +0200, Nicolai Buchwitz wrote:
> On 31.3.2026 13:32, Russell King (Oracle) wrote:
> > On Tue, Mar 31, 2026 at 12:46:27AM +0200, Nicolai Buchwitz wrote:
> > > Enable auto-downshift from 1000BASE-T to 100BASE-TX after 2 failed
> > > auto-negotiation attempts by default. This ensures that links with
> > > faulty or missing cable pairs (C and D) fall back to 100Mbps without
> > > requiring userspace configuration.
> > > 
> > > Users can override or disable downshift at runtime:
> > > 
> > >   ethtool --set-phy-tunable eth0 downshift off
> > > 
> > > Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > I'm slightly concerned by this commit. ->config_init() is called when
> > the netdev attaches the PHY, and also during the resume path - and it's
> > the second one which I believe is a problem here.
> > 
> > If the user has configured the downshift, it is reasonable for the user
> > to expect the setting to be preserved over a suspend/resume. However,
> > by placing this code in ->config_init(), you will overwrite the user's
> > setting when the system resumes.
> 
> You have a valid point. Looking at other drivers, Marvell has the
> same issue: m88e1112_config_init() unconditionally sets downshift to 3
> on every config_init call.
> 
> I see two options:
> 
> 1. Save the user's setting in the driver's priv struct and restore it
> in config_init instead of blindly applying the default.
> 
> 2. Handle it generically in the PHY core, saving/restoring tunable
> state across suspend/resume for all drivers.
> 
> I'd lean towards (1) to keep this series simple. (2) could be a
> follow-up that fixes Marvell and others too. What do you think?

Or (3) configure the default it in the probe function?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
