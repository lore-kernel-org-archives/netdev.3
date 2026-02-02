Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578F935BDD5;
	Mon,  2 Feb 2026 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030656; cv=none; b=iHcwoTl37+PMWsT4AG9dfv1F/mrkJ7a8lcMVRl2UV+Meq4cPnXn9ErX77YFuqhHjZ/XWpRnk+wmNtCOf5N9dUqoZdTKBFOCoo37ZP1cW+kCqBr8LUggg7vVf7XnrBUYFyAzAZVZQdrNpzaGpSJLx6+XD/egVUveJB+chzduFg90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030656; c=relaxed/simple;
	bh=YNanO9tFcfDC23L7/D3aQzKIHeiH1WR4P0RY1wQMyfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXQMvxz/raOLEjZJX2Z1PfwefJoGhU6jDy8QnyZ66wkw/RpJxY9AtfVsHnf54ETQl1gGDONFm/UqHvB2aVOIKT5YT6vo//j2D4LVeEfb6XIa91Jlv7P89hnAm/aUgnHgc7UfSJ6IcETZcGZTTOiiazctYjPJGykw9tvcirKl0Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Oay+df1L; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Oay+df1L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dY0Mz/dngA8mQO5Q82ENeVBGxDsbuEGAb+y2sI/4SsM=; b=Oay+df1LRCrADItlWUQ0HtIwqm
	Un/BBk7/qiloSmz2P8O9tzId10A+CL2XX781NVpwdhAsWeC+Vg59xtRD57NpZmFxmf+NhfztH6n6c
	XeBzUEAZHIMoQ3BIlq17itt5m5MEDJTmKIaCUqyNNLo0KYxlJ+iDkaYVuPzreUTmJ1UYS9pN70VqJ
	OQT8UucfwAbYWrI1jXTeePSsNJAs1VjPNyRcELmm6WsYsdn7iyBWYxTh+bNAzW37AjbkdYaYyrqit
	hAKjtz7F6jS3lQRBqaokp7hyiHUDXSBXGyha2dZCOhnrLrXp4AW3mPuzlzHCQV1wZ4LRkwuZdJTmX
	rzq5hWFg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59386)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vmrpO-000000003vp-16fi;
	Mon, 02 Feb 2026 11:10:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vmrpM-000000003ML-2waq;
	Mon, 02 Feb 2026 11:10:44 +0000
Date: Mon, 2 Feb 2026 11:10:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jakub Kicinski <kuba@kernel.org>, lxu@maxlinear.com,
	hkallweit1@gmail.com, yweng@maxlinear.com, ajayaraman@maxlinear.com,
	andrew@lunn.ch, netdev@vger.kernel.org, bxu@maxlinear.com,
	olteanv@gmail.com, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	lrosu@maxlinear.com, chad@monroe.io, conor+dt@kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org, edumazet@google.com,
	pabeni@redhat.com, cezary.wilmanski@adtran.com, davem@davemloft.net,
	john@phrozen.org, frankwu@gmx.de, jpovazanec@maxlinear.com,
	fchan@maxlinear.com, horms@kernel.org
Subject: Re: [net-next,v11,4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aYCGNMAdZXsQnLKl@shell.armlinux.org.uk>
References: <46226b74030f76bd04149ed5c92b3e263abbe6c2.1769817939.git.daniel@makrotopia.org>
 <20260131175243.1122906-2-kuba@kernel.org>
 <aX6keghdVMI-A6Fq@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aX6keghdVMI-A6Fq@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 01, 2026 at 12:55:22AM +0000, Daniel Golle wrote:
> Do you think it's worth to fix this also in other drivers which follow
> the same pattern? (bcm_sf2, mt7530 and mv88e6xxx if OF node is NULL --
> if there is an OF node it uses %pOF, and I'm not sure that's such a good
> idea either)

So in v11 here, you ask a question of your reviewer. 2 hours later, you
send v12 without waiting for a response.

Slow down. Give your reviewers time to respond before posting your next
version.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
