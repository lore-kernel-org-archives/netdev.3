Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737F4219F7;
	Mon,  6 Jul 2026 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783376104; cv=none; b=qUbztHz5tqQ7PwC7A0NC7mwBWMdKDSDexxk+4gLO5itoL9hqOqQWtu10AZyD7PlgpHGp0N5LTh86mVAqXcVWwf0m2IMiSKcFS1i5L7Sry3Tw/8fLpvT94C78Aoi1nBDb5MIbsMfBOpcR4h6ksOtCdnu4BfTGSX7Bzktu4pjA4xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783376104; c=relaxed/simple;
	bh=ARzoxDUqIpgA+F6A6+ubrSzYNFKL8czoFMBBbJoH/vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEom+DsSDLw/nJwkyyfgQnSdJmTEvDrAkC9TwBavvgRZGa2davL1v4myRpBhjX0Nv0c2nAukv7sNF0B0K6E+ZydO28Tb8ZqvM2wYUK/Mmfiv+wdm/JlKLiBaZqbJo6p1HhsWQ6EMGXpO3xISaaThEaWpnAmCpvaXkbbUjaOsY4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fz/DSAA8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fz/DSAA8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=O/8MZRQbeZFADHC8QzF/gakWGqfy8oOjHZ6Mw36MIXY=; b=Fz/DSAA8/NYB/EK2YBo54Xh+iB
	ugGc42KCQqxIGAEb0mVMxrtLJOeAq8pMnoABoWEzXbNwTgLBtMVMH+ScjKQ3IZuJfAay+aDSoal/n
	cctBtyIA0gPb+zm1eVycYBww7cPpWJF+7v665BqGeDRDl0eauSVFNSlBe2t1RlipyryA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgraX-00B4c5-U5; Tue, 07 Jul 2026 00:14:53 +0200
Date: Tue, 7 Jul 2026 00:14:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 net] net: emac: mal: replace devm_request_irq with
 request_irq to fix probe error race
Message-ID: <6865cefe-3340-49a9-8416-18d91de20274@lunn.ch>
References: <20260704033229.2447410-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704033229.2447410-1-rosenp@gmail.com>

On Fri, Jul 03, 2026 at 08:32:29PM -0700, Rosen Penev wrote:
> devm_request_irq() is a managed resource: the IRQ is not freed until
> devres_release_all() runs after the probe function returns.  In the
> probe error path, free_netdev(mal->dummy_dev) and dcr_unmap() execute
> while the IRQ is still live.  If the shared IRQ fires during cleanup,
> the handler accesses unmapped DCR registers (crash) or the already-
> freed dummy_dev (use-after-free).
> 
> Switch to plain request_irq() with per-IRQ error labels that tear down
> only the IRQs that were successfully registered, and add the matching
> free_irq() calls in mal_remove().
> 
> Tested on Cisco Meraki MX60
> 
> Fixes: 14f59154ff0b ("net: ibm: emac: mal: use devm for request_irq")
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
