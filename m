Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126F3DA7CF;
	Fri, 10 Apr 2026 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834554; cv=none; b=Ll61gvqz+nGu5lHEbWd21t2mStTNCI6GdoX3IhlGuZmDCsOs1U2CblurF0/RhqoJ/jBD5Zf8zlBtdGuVEvFst5aoJjo2ClaDQZQLUTNmJwgkZwS0qDbbI2ehq/D0Fem7OZTaUwS9uhGKLJUivm/xpibd9ifqRR+497hTskpcj6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834554; c=relaxed/simple;
	bh=vs9wPTjCYz5Q/Xxx4ae9f6hg9EqjWJDqgXe50C2TWw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3+e9YuVSgV5px6OHyye2yxoIJDSbtbCZe4hFkci6VbpLAW9Keq5voRorTOX+OJSfzluueCfqNMxYsGgK/8aLF6f1slKzcvhrp5HwR6FTPgUGjUO8IcG3MSCKWiBntECf9w9eHTu0ZZE8SV4grBs3QvjvDHbUiduAOpNuKqbrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=srqFcTqt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="srqFcTqt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cXle5+7G19JrZkRXvCxXfOz8zwJG/tmHPZORwqwmnek=; b=srqFcTqtAhlqTa0L+bixIfG2v+
	QVKytAi6GlP5MJVANKMaP0YJknUccsVyrg/uf0wOEz0bXusOH66DZPjf8MX/OdJN2MStcnA3ntAk6
	vtHtcFzIKz9V0LyHqiJTEPd/NSYF1J48Nu7z4AI5fVU8FmkZWhJTFq9oF0kDfGqrJ1GpJDdizzVLq
	HeaLPJ2dcXkU5n43aQUynvPyj5dHSg4EeHatLpIQoub3EcdAe7gbHAuuog655eaSwCM2AWZtB8vUd
	/dlBapUY8pNKcqx16RYOCXI0iZyswCsSQ5C8uETYbetZbbFWJWWIQJkv0oKS+eSWF2kD2ixK+riPM
	jk4UymtQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40120)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wBDgf-0000000057Z-39tn;
	Fri, 10 Apr 2026 16:22:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wBDgd-000000005it-2YlO;
	Fri, 10 Apr 2026 16:22:23 +0100
Date: Fri, 10 Apr 2026 16:22:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Biju <biju.das.au@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH net-next] net: phy: call phy_init_hw() in phy resume path
Message-ID: <adkVr0mMzDsXile1@shell.armlinux.org.uk>
References: <20260410142904.439666-1-biju.das.jz@bp.renesas.com>
 <adkOZl4gt5UoGv-0@shell.armlinux.org.uk>
 <839fec66-5ec0-4cc0-a0c4-ae2de6902188@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <839fec66-5ec0-4cc0-a0c4-ae2de6902188@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 10, 2026 at 05:15:21PM +0200, Andrew Lunn wrote:
> > Apart from that, looks fine to me - it seems some paths call
> > phy_init_hw() can be called with or without phydev->lock held, and
> > this one will call it with the lock held which seems to be okay.
> 
> Haven't we had deadlocks in this area before?

If we have a problem calling phy_init_hw() with phydev->lock held, then:

phy_state_machine():
        mutex_lock(&phydev->lock);
        state_work = _phy_state_machine(phydev);

_phy_state_machine():
	switch (phydev->state) {
...
        case PHY_CABLETEST:
                err = phydev->drv->cable_test_get_status(phydev, &finished);
                if (err) {
                        phy_abort_cable_test(phydev);

phy_abort_cable_test():
        err = phy_init_hw(phydev);

that path has a problem and needs fixing.


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
