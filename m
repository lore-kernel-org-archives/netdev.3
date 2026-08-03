Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D9D30AAD8;
	Mon,  3 Aug 2026 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785794942; cv=none; b=AH3rYSs0wLrWxli3FwPDxNZES2Q0CieRNypL8hAjjgIILgi6vJrsGy+9axs43yX0yzC6e3VMHsHzxa/bbuZQnhfXU8yaBgs9xH2y477CpeChz+vij3wAToB+DPy9qSidWW9WUEWSloEOGyvE3uIdiiLm43fprILMhKA7f96H3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785794942; c=relaxed/simple;
	bh=1DWDE6QLjQZ2bKZAsVMI80rxRGo0prsYl5kHKGIVQsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HL94gVUKF1Qtf+F+k3a1QnlzkQB0ylP9Gx3NmRvKTy/P6YtXte7+zbGtJKDDx9FM+AikAi5k2ccj1ZjbJ812OSpATvkz8sbp7yVMUckEC0AGFgOnX7BHY9BUZJmuZoHvPOyiyK20ULCnOvNfUSQaIqWirNA+1ixg8W+GjJd4s/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3xVavcBm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3xVavcBm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DbFmzob2h3mc9NFDw7Z+MI3+hG4ALqWGM27Ae1WumvQ=; b=3xVavcBm/Z/zU0JYPwkA7lkDVs
	z/Gh0732M2VyyVx4uPB6I9JdGtixRCXX4HXbss2qbRLQNfhs4pwncw7bpAsZjPPyprE6LWB9AetLU
	OLOEVwWSvyT3fDPbKsiTc+be6GvaUTDg19jdx+XN8oYpAyTT+kzX2AJ9WiV0kFK9oFSc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wr0q4-00FqYW-Ox; Tue, 04 Aug 2026 00:08:52 +0200
Date: Tue, 4 Aug 2026 00:08:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] net: phy: add PHY-autonomous EEE provider support
Message-ID: <cf6b5768-3fb1-4221-bd13-db1fe5cb22e1@lunn.ch>
References: <20260803-phy-autonomous-eee-v1-v2-0-222a187ba2bb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803-phy-autonomous-eee-v1-v2-0-222a187ba2bb@gmail.com>

On Mon, Aug 03, 2026 at 03:54:02PM -0600, James Hilliard wrote:
> Some PHYs implement a vendor-specific autonomous EEE mode. Once EEE is
> negotiated, the PHY can generate transmit Low Power Idle (LPI) without
> MAC assistance. Linux must select exactly one LPI provider: enabling both
> the MAC and PHY paths conflicts, while enabling neither makes a successful
> ethtool request ineffective.

Thanks for splitting these out.

For the moment, i suggest you drop them. Lets get very basic support
in first, then we can think about EEE and all the nice to have
features.

	Andrew
