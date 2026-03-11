Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A277282F33
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773240862; cv=none; b=kqo0yaBVDeBbImlMSJS8kj6qvwOwc1EbHbsCZWP5NEbmv/o71f0J/6q8xF/xagaN2q+TkNAvCtz3pP+Z4U2fMRJklKUF02M+hwTqy4AX3c46cOdzJpl3ikZw+db9CeQKiYcu99YFfKDH0HyKsugMbJcoGM1xbu7j50v1ovqZzhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773240862; c=relaxed/simple;
	bh=lv1HP99ILyDctcQVFRP5cs2333XdRDjSSuU279tzbFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKrW9EHUg1AnP9lW+zKqqvjcVHImv+zfuGgcFNuAyucWiNFIv+dRzASlKn6YonHHkVtcmEDPuFqNnEzYFX2Y9QiCWLIIH2wIzwi2r8zTLYe+MP08adsabUJDzFGm6y0YJJsdmR++m4YE8cyKR6SchB2kRCnRU3Ronf0NVDAl+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tcMxzgfT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tcMxzgfT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ihk8cctYaDTTAXahQ5QiHppWRWZTDtiHyNCdY1kl4C4=; b=tcMxzgfTFXtWY80LnNu1TPXKE8
	8FpDlVO1Pcl2jEeBsOnnW4FOIpESal5rbH88A+cRCtG9J5uF+Lz4cX/LTiQBLSIEGRwkCo/gzTQT+
	ddoikE4eK4rXKaHIFXYw8sKXXC2kid8lAOIlcX9oyIxTIkPWSaZjNP+Mb20tmtpcEnIAN4B7A38yC
	PyIYQd4fmQ4d9l+KYky+/49BCjcb2fRi4DVmdDl2ZL3Kg+ttkEHjlzpXJTvA/az8MPK6QAkbCZy0s
	xMQ1pJZ8JLd+JcNT9MQGxwhCkoyImIpC7NkcREnhhIyf3LHzkYdx39C062vZ9AMk8H1QWbvqbWYx5
	EfR1j1Sw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55616)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w0Kwu-000000006W3-1Twz;
	Wed, 11 Mar 2026 14:54:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w0Kwq-000000006K0-3TjH;
	Wed, 11 Mar 2026 14:54:08 +0000
Date: Wed, 11 Mar 2026 14:54:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: andrew@lunn.ch, conor@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] net: phy: vitesse: add inband caps and
 configuration
Message-ID: <abGCEExpM61-9rOE@shell.armlinux.org.uk>
References: <E1w082O-0000000ChNc-1wDz@rmk-PC.armlinux.org.uk>
 <20260311140135.937544-1-geert+renesas@glider.be>
 <abF7g9kZk5-9YN5_@shell.armlinux.org.uk>
 <CAMuHMdWiN_zQ_1j2HcD1KLwS_FUH_G6WtaMy5bK2HnLTKeNA=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWiN_zQ_1j2HcD1KLwS_FUH_G6WtaMy5bK2HnLTKeNA=w@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 11, 2026 at 03:43:30PM +0100, Geert Uytterhoeven wrote:
> Hi Russell,
> 
> On Wed, 11 Mar 2026 at 15:26, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> > On Wed, Mar 11, 2026 at 03:01:35PM +0100, Geert Uytterhoeven wrote:
> > > On Wed, 11 Mar 2026 at 01:07, Russell King <rmk@armlinux.org.uk> wrote:
> > > > Add support for VSC8662 reporting its inband capabilities, and also
> > > > hook to configure the PHY's inband mode.
> > > >
> > > > This fixes a regression in the macb driver caused by commit
> > > > 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled")
> > >
> > > Fixes: 1338cfef1ff1b958 ("net: macb: fix SGMII with inband aneg disabled")
> > >
> > > > Reported-by: Conor Dooley <conor@kernel.org>
> > > > Link: https://lore.kernel.org/r/20260304-nebulizer-rounding-40fbc81a2ba1@spud
> > >
> > > s/Link/Closes/
> >
> > I avoided it because any other PHY used with macb that is also connected
> > via SGMII will run into this same issue. It just happens that adding
> > this support fixes the above commit.
> >
> > Conversely, we have stmmac, which unconditionally enables SGMII inband
> > at the MAC end no matter what phylink says to do, and should this
> > PHY be used with this patch in a stmmac system, it will cause that to
> > break, because we end up with either end misconfigured.
> >
> > Also, if this commit is applied without the macb change, you'll
> > probably also find that macb breaks (please test that.)
> 
> Correct, it breaks in a similar way.
> 
> > So, while this is a solution and a step forward, I'd rather not suggest
> > that it is an official fix to the macb issue - it's merely filling in
> > a missing piece of the jigsaw.
> 
> Well, when the stable machinery will discover the word "fix" in commit
> 1338cfef1ff1b958, it will backport it.  With the Fixes tag, this patch
> will be backported, too, keeping at least the MPFS Icicle users happy ;-)

... and potentially breaking other users. I would prefer stable not to
backport this patch, or the original patch that introduced the
breakage.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
