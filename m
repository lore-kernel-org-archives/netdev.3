Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863DEEEC3
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724731; cv=none; b=IkpFHHmvFCWWh+OHPkMZhBorQL+AUJIqVO2AWFpfX+Y583tHNhHdvMc9jB/ARO9G01KezI9Amm6uFjeXtF3yQtZjSMmQNCrh4lqGDRAvzaOQV/IBRny/QzpSvaL/Bk6m/sIHaX+DQFGLg1MpSHZt84h+m7r5IXvBkj8jvNTa3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724731; c=relaxed/simple;
	bh=ZIouS8X/r6cSZE6UX23DoR47D8oZoeQrevp6ddsm2PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnKWC6KapTnW5tgB2rWU9ffanI6gMDjuoiahbCyhbPGp0q9Z40Mjg+6rGBUcppMsqqIUC8MVvm+xXVi6SyxG0432mDA9ocAilWT6XY0C9ROyfzHKTtcXdFBr/8RiVB3xPVMcOloveD8ghxSnPjI9mqXke/oKBtoO1XUkYZ1z4CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CCrotnvx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CCrotnvx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Eih44ikSC7XomY2WvttTAM/QMOPKbUAktu5vg4VzL5k=; b=CC
	rotnvx22oF9gkmJViS+A1pSd7XY+2iDklz11zxXwfIHv+oUPu2dyBfw8OdJy0q02mce8uAapAttm7
	9UiP16DBJSRDj2flolYMU7ZZT9YzbXei5c5xyNWVj7lUz5y5wGVElvYs80CPrYZ++w7qcUpgabsyQ
	Oa3cEHJtg8OZzKg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmWQe-00DdDx-PC; Wed, 22 Jul 2026 14:52:04 +0200
Date: Wed, 22 Jul 2026 14:52:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Srinivasan, Vijay" <vijay.srinivasan@intel.com>
Cc: "D H, Siddaraju" <siddaraju.dh@intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	David Laight <david.laight.linux@gmail.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"Das, Shubham" <shubham.das@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"singhai.anjali55@gmail.com" <singhai.anjali55@gmail.com>,
	"Brandeburg, Jesse" <jbrandeburg@cloudflare.com>
Subject: Re: Ethtool is missing C2C link modes
Message-ID: <e1d14d88-dbe4-4e15-b794-6277f9df7e6d@lunn.ch>
References: <SN7PR11MB6900E94E718175AACB2309109AFD2@SN7PR11MB6900.namprd11.prod.outlook.com>
 <e3dd8e06-97d1-4943-b54c-fdd0d0e6ecaa@lunn.ch>
 <20260711073128.7f94e0ac@pumpkin>
 <bb7bb5c6-5643-4e5b-b26b-9363127bb2d8@bootlin.com>
 <SN7PR11MB6900984B5FBD60B71B3B8F329AF92@SN7PR11MB6900.namprd11.prod.outlook.com>
 <20dde8ba-5429-45e2-8071-ce83f1c2d6c0@lunn.ch>
 <DS0PR11MB6397D3B945CFF9FA501AC6F688C22@DS0PR11MB6397.namprd11.prod.outlook.com>
 <a70dc967-6656-4eef-beea-d1894e983fde@lunn.ch>
 <BL3PR11MB63856413FCFB7F30D30E469688C22@BL3PR11MB6385.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL3PR11MB63856413FCFB7F30D30E469688C22@BL3PR11MB6385.namprd11.prod.outlook.com>

On Tue, Jul 21, 2026 at 11:29:05PM +0000, Srinivasan, Vijay wrote:
> > As for your comment/question about FW vs linux controiling the HW, the intent here
> > is to use linux to tell FW where to go based on user input.
> > How the link is eventually achieved is all in FW.  
> 
> > I don't see how that works. ethtool has no APIs around
> > phy_interface_t.  All ethtool offers is link modes. How do you see
> > this working?
> 
> Correct me if I am wrong but isn't that the role of the driver?  
> I expect device driver to translate Ethtool link mode argument and pass it to 
> FW via driver-FW handshake (device specific SET/GET functions). 
> MAC and PHY config. which includes phy_interface_t for that specific link speed 
> is then implicitly handled by FW. No other intervention from user should be 
> required.

It is. But if the driver is talking to firmware, it is using whatever
proprietary values defined by the firmware.

It only makes sense to use phy_interface_t for communication between
different Linux components, or uAPI and a Linux component.

	  Andrew
