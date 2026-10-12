Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8414940960D;
	Mon, 12 Oct 2026 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809228; cv=none; b=iBsrvij6qLcxLnduGSQENP0u1+z9JrNJaL8r8bCF3EnwZ+PNG9nfBqNktmbMctuuclkqzAv/bRVBjho9aG0qSfJRN/IBZAtxcF9bGXfq+co2CivFv6dvFcEBSNhQVkkwB4SE6myCSuBORwaZHd5DBly5dK+pIU5dsI3xzsPHv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809228; c=relaxed/simple;
	bh=tJulF0cY5GTjLpEoRpxtedyJmzltGV9t2tuLCq0SvcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOFcT0NkurlZJKh+SgxelisWRiZBASYVxFejgrhqs/cwG3eoQ8mXaPhpIm4lLXfzzoTpCohR0fUQgRXFGkB1tLmgrOdvPE/GoPnmCWck/581dtQZEKRYpFdi5XrjQ5nkfBdd3v8oazF0SpmXOr7Ud/mhJ2lkcGXIekTGn/fBnlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XcvLQoT+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XcvLQoT+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=moPKCpl59FsFkLNh5tqh19aLEugn3YQjprApG1uQ7rA=; b=XcvLQoT+fO5x6I+yRJFZn2px1H
	HEcRosHh9xuVFBTQDhobbfixZmocSrue6AI4h6s0epACdfr/ZI4Tbdc1ZTGC09qyXpmzbhtVU0XKA
	ALFJs/DiaAW1dx+kXqS9cjIAE9jzGV0WnT6VV74pLRScdZnbQjBCgyeri5I5zgNfByhs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGFQB-00AK7G-KP; Mon, 12 Oct 2026 14:46:27 +0200
Date: Mon, 12 Oct 2026 14:46:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Hee-Suk Kim <hskim@dilluti0n.com>, netdev@vger.kernel.org,
	javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] r8169: allow Giga Lite fallback on RTL8168EP
Message-ID: <4435b286-1638-464a-821c-f486b647c9f7@lunn.ch>
References: <20261010135356.85454-1-hskim@dilluti0n.com>
 <dbdd5abd-f1b1-443c-adc3-6ecdc95f4854@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbdd5abd-f1b1-443c-adc3-6ecdc95f4854@gmail.com>

On Sun, Oct 11, 2026 at 10:59:42PM +0200, Heiner Kallweit wrote:
> On 10.10.2026 15:53, Hee-Suk Kim wrote:
> > Giga Lite is a Realtek proprietary mode which allows links of up to
> > 500 Mbps over two-pair cabling. In South Korea, it is widely used to
> > support 500 Mbps plans by most ISPs. The vendor driver [1] sets PHY
> > page 0xa42, reg 0x14, bit 9 to allow it on RTL8168H and FP. The driver
> > does not handle RTL8168EP but I confirmed the same works for it by
> > setting the PHY register via SIOCSMIIREG on an SK Broadband 500 Mbps
> > plan [2].
> > 
> > With the bit set, the link still came up at about 470 Mbps even when
> > only 10/100 was advertised. So set it only when autonegotiating with
> > 1000baseT/Full advertised, and clear it otherwise, to respect a lower
> > advertised speed. This matches what the vendor driver does for
> > RTL8168H and FP.
> > 
> > PHYSR reports 0x30 in its speed field to denote a Giga Lite link. This
> > value is not handled in rtlgen_decode_physr(), so the reported speed
> > varies between 100 and 1000 Mbps on the same link. Handle it to report
> > 1000, as there is no 500 Mbps uAPI.
> > 
> > [1] https://github.com/mtorromeo/r8168/blob/b3e24e4aa74a3561618d0abf01b708bd55def57a/src/r8168_n.c#L6375-L6390
> > [2] https://www.tworld.co.kr/web/product/callplan/NI00000567

I'm in agreement with Heiner here. If we add this, we do it properly.

Please add ETHTOOL_LINK_MODE_500baseT2_Full. Make the PHY report this
link mode in it features, add the speed, allow it to be negotiated,
reported in ethtool etc.

	Andrew
