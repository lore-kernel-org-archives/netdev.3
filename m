Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4314246762;
	Mon, 12 Oct 2026 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811724; cv=none; b=I0cbZz7iXIzd0h+Z1u42DoT++FPON1BnjklJaNziS4rNAb+5/9IiA/uxGqeL5kXZhlowCzGYlfhyFW6/4obB7aMPBug+BYPNYvMvgFY/dI/knu1eoEP3CIeGF3YlkSTXXRxgHyUOwihZhG83Y1z97ZxPd11tQmy29pJsVDNn3Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811724; c=relaxed/simple;
	bh=K0Obv5/zq4Q+xZ7fYSMKMHEO5mo1oQXLTSqqs+AnRfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtZawGIO8qT5Q6HZ5Zcxz2AH6fxjIeUGQHY/gp09rROVxQuwsPrQcBByw3UpkRAtxF/xRWqQdpwIrwzTq+6ywXloqmZJ1cfEmCMvEuHhFkmapKj5MvSHb6dmqx0llfAr0GWlA1l7NiVoX4WeW5eEfk7c/8kdk0nJEEs6YKxVJ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xGG4r-000000006ZI-2Wlu;
	Mon, 12 Oct 2026 13:28:29 +0000
Date: Mon, 12 Oct 2026 14:28:26 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Hee-Suk Kim <hskim@dilluti0n.com>, netdev@vger.kernel.org,
	javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] r8169: allow Giga Lite fallback on RTL8168EP
Message-ID: <aszgerrI8yoLTaX0@makrotopia.org>
References: <20261010135356.85454-1-hskim@dilluti0n.com>
 <dbdd5abd-f1b1-443c-adc3-6ecdc95f4854@gmail.com>
 <4435b286-1638-464a-821c-f486b647c9f7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4435b286-1638-464a-821c-f486b647c9f7@lunn.ch>

On Mon, Oct 12, 2026 at 02:46:27PM +0200, Andrew Lunn wrote:
> On Sun, Oct 11, 2026 at 10:59:42PM +0200, Heiner Kallweit wrote:
> > On 10.10.2026 15:53, Hee-Suk Kim wrote:
> > > Giga Lite is a Realtek proprietary mode which allows links of up to
> > > 500 Mbps over two-pair cabling. In South Korea, it is widely used to
> > > support 500 Mbps plans by most ISPs. The vendor driver [1] sets PHY
> > > page 0xa42, reg 0x14, bit 9 to allow it on RTL8168H and FP. The driver
> > > does not handle RTL8168EP but I confirmed the same works for it by
> > > setting the PHY register via SIOCSMIIREG on an SK Broadband 500 Mbps
> > > plan [2].
> > > 
> > > With the bit set, the link still came up at about 470 Mbps even when
> > > only 10/100 was advertised. So set it only when autonegotiating with
> > > 1000baseT/Full advertised, and clear it otherwise, to respect a lower
> > > advertised speed. This matches what the vendor driver does for
> > > RTL8168H and FP.
> > > 
> > > PHYSR reports 0x30 in its speed field to denote a Giga Lite link. This
> > > value is not handled in rtlgen_decode_physr(), so the reported speed
> > > varies between 100 and 1000 Mbps on the same link. Handle it to report
> > > 1000, as there is no 500 Mbps uAPI.
> > > 
> > > [1] https://github.com/mtorromeo/r8168/blob/b3e24e4aa74a3561618d0abf01b708bd55def57a/src/r8168_n.c#L6375-L6390
> > > [2] https://www.tworld.co.kr/web/product/callplan/NI00000567
> 
> I'm in agreement with Heiner here. If we add this, we do it properly.
> 
> Please add ETHTOOL_LINK_MODE_500baseT2_Full. Make the PHY report this
> link mode in it features, add the speed, allow it to be negotiated,
> reported in ethtool etc.

While at it also consider ETHTOOL_LINK_MODE_1000baseT2_Full which is
supported as "2.5G Lite" by the RTL8221/RTL8226 2.5G PHY family.
