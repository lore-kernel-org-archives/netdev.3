Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6380E39A048;
	Sun, 20 Sep 2026 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789915018; cv=none; b=CYk1HN0QY1/p11H37P/sXqcfB414hurHeeRVdsBsa4ID7Dph0CnYWJaXs4IUh0Bf2/4qT9nxLUKD2XuZeflJunaJMqrYYpPHaRmOBAlpKU5PyYPFE3Exg7u0yJuU5ZyCDWAh4eplFukGeOtPGKI4FdWsmMo+7P+KB8OZyNrkyXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789915018; c=relaxed/simple;
	bh=RkTfotcmKdl8Gm6gycEXOFmRlypm+Oqg7usjUJ/auHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn1/m5DQKk/MTzn+V5FqqtswgLOm+FsKqtwKLRLoQ8R/UF0olCp63xPKnTFV/s6Lo9Few4O8o3OGLPO0txFBdjI8whVpJQOPO7tcpUt7XdPkkN4edPY0a0/a9jS9v31BqF8ZZPUzdJHNbBXNeidN05V2FvXPs3n4FvgHS/m3Yxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JlWjejE4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JlWjejE4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=imeQGDetawv+Tkn7TH70AoBC1Xg4a9gWPuzZHHBSHdQ=; b=JlWjejE4PfDmkOiSfPF5t4Cc2f
	Tn+fTqYe0tU4EMnUZ659kHz1QIO6r1jR0RbbyOfNIrZe1tEEa0sUAXFtjZRdEGVdxjkhqczX/tXSl
	Wks+uXFXejEf1e7A6HkJcXdwjrJvl5arvmQsPv2GIKRS5TDN9mKuzw0kxeKZAkOWuwDM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8Iem-006AIh-6A; Sun, 20 Sep 2026 16:36:40 +0200
Date: Sun, 20 Sep 2026 16:36:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: phylink: unwind the PHY binding when bringup
 fails late
Message-ID: <4eedad70-0b77-432b-838f-eb11ca47af4e@lunn.ch>
References: <20260919015338.499611-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919015338.499611-1-f@lex.la>

On Sat, Sep 19, 2026 at 04:53:38AM +0300, Aleksei Sviridkin wrote:
> phylink_bringup_phy() records the PHY in pl->phydev before its last
> fallible step: on a MAC whose phylink ops implement LPI,
> phy_eee_rx_clock_stop() can fail with a real MDIO error. The callers
> unwind with phy_detach(), which knows nothing about pl->phydev, so a
> pointer to a PHY that is no longer attached outlives the failed
> connect.
> 
> What that costs depends on how the caller got here.
> phylink_connect_phy() goes through phylink_attach_phy(), which refuses
> to attach while pl->phydev is set, turning a transient MDIO error into
> a permanent -EBUSY. The SFP path is worse than that: sfp_sm_probe_phy()
> answers the failure with phy_device_remove() and phy_device_free(), and
> it assigns sfp->mod_phy only past that error return, so nothing clears
> pl->phydev and it is left pointing at a freed phy_device that
> phylink_resolve() and the ethtool helpers go on reading.
> phylink_fwnode_phy_connect() has no such check, so a later connect
> overwrites the stale pointer and hides the problem. A disconnect does
> not: phylink_disconnect_phy() hands that pointer to phy_disconnect(),
> and the second phy_detach() on the same PHY drops references the first
> one already released.
> 
> Found while making a DSA port survive a PHY whose driver arrives after
> the switch probes: keeping the port across a failed connect and
> retrying is what makes this window reachable.
> 
> Clear the binding on the failure path. This is the same operation
> phylink_disconnect_phy() performs, so both now share a helper. The
> PHY-side fields are left to phy_detach(), which every caller already
> runs on this path.

What is missing here is an explanation why you cannot record the PHY
in pl->phydev later, once all calls which can fail have been
performed. That seems like a simpler and more logical fix. But maybe
i'm missing something.

	Andrew
