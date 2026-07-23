Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4DD3DC4AB;
	Thu, 23 Jul 2026 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816854; cv=none; b=gzlcpevoE5P2Yqy9bWXVv7C7WlPPNvzZ3CJqA4xbuZJYoPhsU8m4mp5cKTXXSrrDwn5kHI99it93ArNPzXyQ2Hlmz8IqiCvMwu1dfT4TbCiH7bTte7E6NDTWnjrCeqBOFqItVQOkRID8W8XRQp/8FO1TrzJDROMgGqvOntGf1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816854; c=relaxed/simple;
	bh=rWVI3fvv5t7PjCH2SeK+Wr6ceS2bxX7EGQ2tqXPfcnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXr9QerbzvLWL/w76Po0WCZsZueO4Tifbqz+O1g4HCp7QVDEjFx0XMRbeyBFVd2QUpJai2rKuYZN0LHYezzBG6GDPDxCGdI1uUlnuwrGIq0NAEui0WTHNixwj7v7/3yPqOWKFpcscWJVF4+vrspGkwQCuWMXa87sY3bP4gZHmpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vdGuHqeN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vdGuHqeN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FWDX8hhSrAnEsBh4J0zBKDddRaALLoTrUIMqF3n4iC0=; b=vdGuHqeNV+tMHXnflYaGkWK5/Z
	VbjThy0v04CtgK1WRQd14ff9PpOO3XkEH3HtkS6C+TlQAju8X5OD0kroTwi993kID8iSr7cGcbyUn
	PO0piWnjoz04FBbX5KVTazEDG6sgluJ6/+GHQSHCTQJkyrVRPwIyeX8DyGTXvH1Y5P0E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmuOP-00DpeK-Tg; Thu, 23 Jul 2026 16:27:21 +0200
Date: Thu, 23 Jul 2026 16:27:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v5] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <ec6fb144-9b38-418c-ab6f-a02d5fb47b2b@lunn.ch>
References: <20260721114810.660718-1-kyle.switch@motor-comm.com>
 <d394347a-4162-49ea-b65a-c2e2bd3769aa@lunn.ch>
 <59cc79d4-cccb-4cc8-94d9-60c56e86b598@motor-comm.com>
 <c591a9b0-7fea-4953-93db-23f0f591e6ae@lunn.ch>
 <47d31704-e57b-4828-8c8d-0438ef43e49a@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47d31704-e57b-4828-8c8d-0438ef43e49a@motor-comm.com>

On Thu, Jul 23, 2026 at 05:28:39PM +0800, Kyle Switch wrote:
> 
> 
> On 7/22/26 21:18, Andrew Lunn wrote:
> > On Wed, Jul 22, 2026 at 04:06:31PM +0800, Kyle Switch wrote:
> >>
> >>
> >> On 7/21/26 22:18, Andrew Lunn wrote:
> >>> Just checking something here....
> >>>
> >>>> +/**
> >>>> + * ytphy_write_top_ext() - write a PHY's top extended register for YT8824
> >>>> + * @phydev: a pointer to a &struct phy_device
> >>>> + * @regnum: register number to write
> >>>> + * @val: register val to write
> >>>> + *
> >>>> + * Returns: the value of regnum reg or negative error code
> >>>> + */
> >>>> +static int ytphy_write_top_ext(struct phy_device *phydev, u16 regnum,
> >>>> +			       u16 val)
> >>>> +{
> >>>> +	int ret;
> >>>> +
> >>>> +	lockdep_assert_held(&phydev->mdio.bus->mdio_lock);
> >>>> +	ret = __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, regnum);
> >>>> +	if (ret < 0)
> >>>> +		return ret;
> >>>> +
> >>>> +	return __phy_package_write(phydev, 0, YTPHY_PAGE_DATA, val);
> >>>
> >>> The _top_ registers are in a different MDIO address, and are shared by
> >>> all PHYs within one package. Correct?
> >>
> >> Ans: yes, the understanding is correct. The top registers is shared by
> >>      all PHYs.
> >>
> >>>
> >>>> +static int yt8824_write_page(struct phy_device *phydev, int page)
> >>>> +{
> >>>> +	int old_page;
> >>>> +	u16 data;
> >>>> +
> >>>> +	old_page = ytphy_read_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG);
> >>>> +	data = old_page & (~YT8824_RSSR_SPACE_MASK);
> >>>> +	data |= page;
> >>>> +
> >>>> +	return ytphy_write_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG, data);
> >>>
> >>> The page register is in a top register. So when accessing a paged
> >>> register, all other PHYs also get swapped to that page. And so it is
> >>> necessary to block all other PHYs from accessing registers, until the
> >>> paged access if completed?
> >>>
> >>> If i have that right, that is an odd hardware design. Since this is an
> >>> odd design, it deserves to be documented. Locking is hard, and it is
> >>> made harder by not having good documentation about the design of the
> >>> locking scheme. 
> >>
> >> Ans: Yes, the current operation involves locking at the beginning of the phy8824 driver
> >>      ops and unlocking at the end of the ops function, that is why so many __function 
> >>      involved in this driver, but there are also some special cases that need to be reconsidered 
> >>      such as using  phy_read_poll_timeout().Can you give me some suggestions on the lock scheme?
> > 
> > So, that is a really bad design. As a software engineer you should go
> > talk to your hardware engineers and tell them what is wrong with this
> > design. Hopefully they will then fix it for the next generation, move
> > the page register into the PHYs own address space, a page register per
> > PHY so removing this locking.
> > 
> >>>> +	old_page = phy_select_page(phydev, reg_space);
> >>>> +	if (old_page < 0)
> >>>> +		goto err_restore_page;
> >>>> +
> >>>> +	if (reg_space == YT8824_RSSR_UTP_SPACE) {
> >>>> +		ret = __phy_read_mmd(phydev, 0x1,
> >>>> +				     YT8824_UTP_TEMPLATE_MODE_CTRL);
> >>>
> >>> What address spaces are paged? Every other design i've seen only has
> >>> pages of C22 registers, since you only have 32 of them. But looking at
> >>> this code, does this hardware also page C45?
> >>>
> >>
> >> Ans: To access the mmd register of UTP, must first select the page as UTP. I'm not sure if this is 
> >>      the answer you want.
> > 
> > So it sounds like each MDIO address on the bus actually has two full
> > PHYs on it, and this page register allows you to swap the accesses
> > between the two. Are there two sets of MDI pins, one for each PHY?
> > Can both FIBER and UTP be used at the same time? Could i configure
> > both copper and fibre parts, see which gets link first, and then
> > declare that the winner? Maybe you should actually be exposing both
> > PHYs, with a mux between the MAC and the PHYs. This is something
> > Maxime has been working on.
> > 
> > This whole concept of one shared register controlling page access to
> > all PHYs within the package sounds so wrong, i would go talk to the
> > hardware engineers. Maybe you are missing something, the software is
> > not doing what the hardware designer intended? Because this is so
> > ugly.
> > 
> 
> Ans: Perhaps there is indeed a misunderstanding here. The working mode 
>      of phy8824 is"mac <---> usxgmii ----UTP". The panel ports of 
>      PHY8824 is always UTP.

So what is all this code about YT8824_RSSR_FIBER_SPACE for?

I'm assuming this device can be used similar to the marvell
m88e1111. It can either be used with Base-T UTP, or it can be
connected to an SFP cage. It uses different pages to configure UTP vs
fibre. Your driver seems to have a similar structure.

       Andrew

