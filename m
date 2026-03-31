Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1E440DFB9;
	Tue, 31 Mar 2026 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774919000; cv=none; b=jxgxJNf1mCQD5tiIzrtwGewEKwpGqIVnp1cafcxKP1RmQr2jOFmLo9DMMP377tJHTIks3NYjsU035Oo/wNsYY0S9FIUiUMsWAkjYvfcdpb8gQaMVWO6a/8nNseaQv/IbWFRIGvmjEBrZtXdtvZTp6XeMButFvfhdlherps6yTHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774919000; c=relaxed/simple;
	bh=EEnGHDGcPXbkA4XoPEgIoHMDOY3ZA9HT/e9LOMKZytg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDJ/MF7d0zokgsaOfspXwUuxKx3LQD4SdWygg4B/kOwvdmEd84hhVpcydqx6LvnoXR102FqZZcd+yid1iVRDShhpg0vmd+ooOm+SjQwgMdf4Jv5TCeCKjXBtMxDwanNQfhzPDKB1gRO5clR8XTbkNEiEiXaJGjJoByreb4CskXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bKGtF3rm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bKGtF3rm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9jV5sRl7iwcYGmx0pZppSKRzzBz6NVBY7Uz72jbXcC4=; b=bKGtF3rmqCnWl/tm+oiS9c6MMi
	ezxpdVlSFY/B3t2gcinwlpod2VDuBWo9C2/iWJD+jkhprTyZAFq5GqHHUWjb1xLKUHyPlpjI8B1LQ
	s7ZMziCdkEkfcH1GQFIy9E8ZH9RImWaPCWO8yf8X1NP4mKpefbGWj7V+q0v46YJqqTow=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7NVQ-00E7Oi-Fa; Tue, 31 Mar 2026 03:02:56 +0200
Date: Tue, 31 Mar 2026 03:02:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: phy: microchip: add downshift tunable
 support for LAN88xx
Message-ID: <1778259e-6513-4af3-bd43-63ffdcc1dc9c@lunn.ch>
References: <20260330224630.579937-1-nb@tipi-net.de>
 <20260330224630.579937-2-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330224630.579937-2-nb@tipi-net.de>

On Tue, Mar 31, 2026 at 12:46:26AM +0200, Nicolai Buchwitz wrote:
> Implement the standard ETHTOOL_PHY_DOWNSHIFT tunable for the LAN88xx
> PHY. This allows runtime configuration of the auto-downshift feature
> via ethtool:
> 
>   ethtool --set-phy-tunable eth0 downshift on count 3
> 
> The LAN88xx PHY supports downshifting from 1000BASE-T to 100BASE-TX
> after 2-5 failed auto-negotiation attempts. Valid count values are
> 2, 3, 4 and 5.
> 
> This is based on an earlier downstream implementation by Phil Elwell.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
