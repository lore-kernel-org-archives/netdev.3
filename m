Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81764175A80
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781983268; cv=none; b=OCBZSC51fuW2FZuU7ghca82g858grt1RQbAbNbMnjm4swZmqYWR6hX4YhIl2rb2Ly8oniwlvu402iSzpvoaJHeYyMZncjUF84wcN3SS6nNEhQTxI0UkWRaa4pKJ/dIy0ADS3MRSCxe3UjpIKEaX1PuLPGaorAL18UziTjJElVqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781983268; c=relaxed/simple;
	bh=N1UUh3BANIqct31c3K2hCxb0yp5SzjQMRZCxITrnE0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLkOjYVcDxl+aLPWmr9flhNO+8KHFq6lqIdkqpoU15DHXmcE+JW5INuRMYQHGDCCtMCqxGAxV/+xNAJnl4mQcWAaHB4FzJb4Z7hBGBMwfsi+tGoNzHGo00RJW/6MwtuV0lhEq/HTYtAtFVhlRHjfJ+0N8/gmeOo+vrCRlTR8q40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hkPK4tiB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hkPK4tiB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cpmZ4xbw9aU/bY8j7OQBmS/nBwju/NcJCLGgibnZitM=; b=hkPK4tiB6aZESQm/MhsfxuVhjs
	d0AMwEFFsv9Ee3Aq312dqHERCb4ZJgKKfKhYEsp+cDOkw1XWb2DzlvjoEb2deIEDN7dio1gA3Awv3
	lgspYMCZu6phL5Et/BuWwMY7D35bE8QWh1HFJp7nLUCbntXzejCLuK7oqZkG4pF61zuo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wb1FJ-008d48-VL; Sat, 20 Jun 2026 21:20:49 +0200
Date: Sat, 20 Jun 2026 21:20:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Das, Shubham" <shubham.das@intel.com>,
	Alexander H Duyck <alexander.duyck@gmail.com>,
	"lee@trager.us" <lee@trager.us>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>,
	"D H, Siddaraju" <siddaraju.dh@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
	"niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>
Subject: Re: Ethtool : PRBS feature
Message-ID: <b61ee484-f9f5-4504-9e88-aeac701cd4e2@lunn.ch>
References: <SN7PR11MB810923BBDEC398E860099150FF1B2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <f4a3e4ad-91e2-4844-a29b-81f70151228e@lunn.ch>
 <SN7PR11MB81099B4885C10E16D52A2EB9FFE52@SN7PR11MB8109.namprd11.prod.outlook.com>
 <06d8c98da24e80d148ede4e933bb621c5515a7a2.camel@gmail.com>
 <SN7PR11MB8109C173933D08F994FBB084FFE22@SN7PR11MB8109.namprd11.prod.outlook.com>
 <26971635-b13a-4ed3-b2cb-ce35da9b63d3@lunn.ch>
 <SN7PR11MB81096CF160930DB8FA278B3CFFE12@SN7PR11MB8109.namprd11.prod.outlook.com>
 <be5c474b-c969-49af-8235-825580ee945c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be5c474b-c969-49af-8235-825580ee945c@bootlin.com>

On Sat, Jun 20, 2026 at 04:39:06PM +0200, Maxime Chevallier wrote:
> Hi,
> 
> On 6/20/26 15:48, Das, Shubham wrote:
> >> Can you change the firmware to expose the 802.3 registers for PRBS?
> >> You can then write a library which both plylib and your driver can use.
> > 
> > Andrew,
> > 
> > No, exposing the PRBS registers to drivers is not possible in our design (the registers are buried deep within the Accelerator/NIC/PHY/Analog IP hierarchy).
> > 
> > Additionally, the PHY PRBS registers are not in accordance with the IEEE Clause 45 definitions. For instance, the PRBS registers are paged and 32-bit wide.
> > 

Hi Shubham

Do you at least have the functionality of the standard C45 registers,
even if the addresses and bit fields are messed up?

If you do, maybe we should actually start with a C45 conforming
implementation, and then you can do a translation layer to whatever
oddball implementation you have?

> > Given these constraints, we think ethtool --phy-test is a
> > reasonable starting point for exposing the long-established
> > Ethernet PRBS functionality to Linux userspace, as it aligns well
> > with the driver-owned NIC architecture model.

I agree an ethtool --phy-test makes sense, but we need to ensure
standard based C45 functionality is covered, not just your oddball
vendor functionality.

	Andrew
