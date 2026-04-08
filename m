Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB4B3B8938;
	Wed,  8 Apr 2026 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656117; cv=none; b=VVjYlcSHZNGsTZzUD+WJesED32X+hB6ozU4kyBOFjuohIEwzayq3zcAosPt9LdUE69KaCUS5/kWlrkorbLf7p4xf8B1+L37+JkjRStSIhZN4G1nsyIdohvVFLT19LM7JMEInTPwovxhDOl/h+1JcCsTwsW5b8gFMMr9s3oZHCSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656117; c=relaxed/simple;
	bh=8jIO3JYBIXDzPlE2sEUxBQJr+iNNQe6e6yvNzsFvXa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssIedPfHCkPupW8ncBIzs0Py2Zx136FxY+ZCAH3F4BPOXVv9kV+wULAIbVFGK0S/ezRe8pEcFQ3U+G1wLkbx0nibZ1O72mc7U+FMEisXaJJc5KlfqJgdqisQ1YkdH5zPpo00kcO2Ljawk1ah8+zZkX9eOMAny3vpZR84RWdO2oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NtilGzGE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NtilGzGE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h3ol3IqNMNc9xdu0c1/y7NRd5BbJtFf8VRUSzc1d+1o=; b=NtilGzGEYPZa00MiD9rzPFUjcv
	0Y6WT5caj+hZhTy+DBdjzKYKswOA1pg+hEzykq2BbCEKRLl9Pt+5fX0I9kOTnmuyEMdvTE0C/CbEP
	8iCWaVNPsij88oJZgWqnTxNn9+ozG9Ze3wnhKxc7NEkbec3SiHegs2bX4+oNsOvfU3es=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wATGY-00FIXo-4G; Wed, 08 Apr 2026 15:48:22 +0200
Date: Wed, 8 Apr 2026 15:48:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: fix a return path in get_phy_c45_ids()
Message-ID: <bcc4943d-137f-46d0-b5fd-385577c1259e@lunn.ch>
References: <20260408133145.1177417-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408133145.1177417-1-charles.perry@microchip.com>

On Wed, Apr 08, 2026 at 06:31:44AM -0700, Charles Perry wrote:
> The return value of phy_c45_probe_present() is store in "ret", not
> "phy_reg", fix this. "phy_reg" always has a positive value if we reach
> this return path (since it would have returned earlier otherwise), which
> means that the original goal of the patch of not considering -ENODEV
> fatal wasn't achieved.
> 
> Fixes: 17b447539408 ("net: phy: c45 scanning: Don't consider -ENODEV fatal")
> Signed-off-by: Charles Perry <charles.perry@microchip.com>

Thanks for fixing this.

The Subject line should be [PATCH net] since this is a Fix.

Otherwise:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
