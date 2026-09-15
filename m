Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418364BEE58;
	Tue, 15 Sep 2026 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789435831; cv=none; b=Y81PQZxJdCPMPTck9EU7z4Ik96rOF2JZrR8oWlClx7BEDaRAUZGFwuMbV60FuC9aRMHp/ZZwkcsOOPfY5GOQyOd/+eQ+/gIDCXry8kr1iGOTsibSVw5bBvYJShwNQ1O7PFc0K0JVIPfchhrUvmjZSXVSqudpZveP4UziuVpSfS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789435831; c=relaxed/simple;
	bh=4ooeXO5micOcfFMgkQaja78GEUbahBIBFjBU+V/knw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5rPltLl90qasB1uI2bxNt3Ae6sM7pFNIUcZRMqjo59JVrpkE1ogwaEWVslcBWmzuh+wdmFKk8Uioii1vq5YT1iBlTIceQNpkO+jzKfc2DCe2AKciFsyZ3SwS5PXTtvxWkrxHUibvlMsq/CG9it1RYCpWgbNoiyY5yN6sIXF4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C4+IcYp5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C4+IcYp5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n2eViIN4CdrY8DfZkVZmrroRFxyLR9A2oDMQaX2oNio=; b=C4+IcYp51szJzg/ZWHQe755SAa
	UKsJTryjGJ+6BhHTM/kE2Fh6WWuOVmUp5W50XWafKCMsgOjjVR9CFkloxs1O9afx+Y65xUCDlMdEz
	Y4OpOKQdFr9i5y8mk3qZHSN03dTT+ZC8UmNa/ZWDrkMiYl3OmMyxafAyZYu3yWDZHwHw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6I03-005AG1-Bm; Tue, 15 Sep 2026 03:30:19 +0200
Date: Tue, 15 Sep 2026 03:30:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v7 2/2] net: phy: take the interrupt back from the
 bus on detach
Message-ID: <a2a2a8fb-97c3-498f-9bf4-e0c44be2eff6@lunn.ch>
References: <20260909204306.2374562-1-f@lex.la>
 <20260909204306.2374562-3-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909204306.2374562-3-f@lex.la>

> A bus whose driver writes only phydev->irq and never the table is not
> covered, because the table then holds PHY_POLL and there is nothing to
> take back; lan78xx, smsc95xx and sxgbe are in that position today and
> registering the interrupt with the bus is theirs to do.

Maybe i was not clear. I listed all the drivers i thought you needed
to look at and patch, so that the bus is the source of truth. This is
also what the AI was pointing out as a problem.

    Andrew

---
pw-bot: cr

