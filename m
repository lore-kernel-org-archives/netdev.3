Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C0B47AF6C;
	Wed, 10 Jun 2026 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123153; cv=none; b=OQG+15i8v8lAIRHBptXEe/H4m0iSj0mLVK/LZUrXZaw7gWC5HxIJNVF/iaJvg4+4+7yqGL1tzVWA1YBq6X3KXqP2SaxwiFoJWwpTZral/+zmsHTXi4X5k3oSG2LYKyuTmt4UHRwRMxUIKIL9xoiLL0rfBJawiPYHNPOxTBMgPI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123153; c=relaxed/simple;
	bh=LdqsW4aYYWR5kdeXkDsmwhTbV/cFdcr9ns9xT8ILuYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/H2s3r0vd/5jjiUXe+lhVURHT95LClG0r1mf0gSup5pwmODPdD7suPcI2jImZC1LVVVKs3LbzilZ8uAc7lcAs2QonZrdr5p+z/eGI4Fy8Prv31t+iZag3CMbm0hjJit/iWoy97lNTwsFA5HmO1HUWrz14RtRT5dAq3AN/NXobI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FcVgk55M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FcVgk55M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g0xAIKM2/gWnWA24EvP0cIZbaBIml9aSA5WdSauaTOg=; b=FcVgk55MG4YyYWlxLq1HB4Hti2
	1gGFQgwdv3111w6ve4EoQ0aEKvoZopA65MXS7QZCTR5rRIpoS8N8NGBowFVuDgCclBIvD2zSxTdbk
	lGK1QXfbQ8tRJtWB9F+v/m1mT9ALezvmAsAzPr8Z49+S6NQI+A0oaNHWyNumEaVpnrNI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXPUM-00731w-O9; Wed, 10 Jun 2026 22:25:26 +0200
Date: Wed, 10 Jun 2026 22:25:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Javen <javen_xu@realsil.com.cn>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v1 4/6] r8169: add support for RTL8116af
Message-ID: <a7a62d6d-f96c-420b-a7e4-4570c4017aff@lunn.ch>
References: <20260605103906.1445-1-javen_xu@realsil.com.cn>
 <20260605103906.1445-5-javen_xu@realsil.com.cn>
 <5005c1c3-d807-456d-a9a0-c77bde9f437e@lunn.ch>
 <b54b5f3a6703498fbc17e64548550ba0@realsil.com.cn>
 <282e4c64-a088-4602-b053-7a8e1cd32c5a@lunn.ch>
 <7473edee9a67407c81b357492e9452c3@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7473edee9a67407c81b357492e9452c3@realsil.com.cn>

> >Can firmware programming be moved into the PHY driver?
> 

> For our PCIe nics, they are single chips. r8169 driver is for the
> entire integrated chip. Some internal phy shared the same PHY id,
> but the required PHY parameters differ depending on the specific
> MAC/Chip it is integrated with. So I think firmware here can not be
> moved.

Can you tell them part only using PHY registers? It is a bad design if
you cannot. You can populate the .match_phy_device call with a
function which can peak into registers to determine if the hardware
matches the entry in the PHY driver list.

> >> >> -     rg_saw_cnt = phy_read_paged(tp->phydev, 0x0c42, 0x13) & 0x3fff;
> >> >> -     if (rg_saw_cnt > 0) {
> >> >> -             u16 sw_cnt_1ms_ini;
> >> >> +     if (tp->phydev) {
> >> >> +             rg_saw_cnt = phy_read_paged(tp->phydev, 0x0c42, 0x13) &
> >0x3fff;
> >> >> +             if (rg_saw_cnt > 0) {
> >> >> +                     u16 sw_cnt_1ms_ini;
> >> >>
> >> >> -             sw_cnt_1ms_ini = (16000000 / rg_saw_cnt) & 0x0fff;
> >> >> -             r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
> >> >> +                     sw_cnt_1ms_ini = (16000000 / rg_saw_cnt) & 0x0fff;
> >> >> +                     r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
> >> >> +             }
> >> >
> >> >Can this move into the PHY driver?
> >>
> >> It reads a counter from PHY, but the calculated value is programmed into
> >MAC OCP register via r8168_mac_ocp_modify, which accesses r8169 through
> >tp->mmio_addr. So I think this can not be moved.
> >
> >So, big picture, what is this doing? What is rg_saw_cnt?
> 
> UPS mode TX-link-pulse timing calibration. We read rg_saw_cnt from
> the GPHY page 0x0C42, register 0x13. This value is the SAW
> calibration result burned during mass production. If rg_saw_cnt ==
> 0, it means the MP did not burn the calibration result, so we do
> nothing. If calibrated (rg_saw_cnt > 0), we calculate the 1ms timer
> counter: sw_cnt_1ms_ini = (16000000 / rg_saw_cnt). And then write it
> into the MAC OCP register (0xD412). This requires reading a
> hardware-specific value from the PHY to configure a timer register
> in the MAC. So I think it can not be moved too.

> How do you recommend handling this kind of SoC-specific tight
> coupling within the phylink framework? Is it acceptable to retain a
> local phydev pointer in the MAC driver solely for these
> hardware-specific initialization quirks, or is there a preferred
> approach for single-chip devices?

Step one is to not tightly couple hardware like this when you design
it. It just causes problems when you need to make layering violations.

However, the hardware is designed like this, so you have to live with
it. At least for this generation. I hope the next generation is better
designed.

So yes, you can reference the phydev.

	Andrew




> 
> Any guidance for the migration would be greatly appreciated!
> 
> Thanks,
> BRs,
> Javen
> >
> >        Andrew
