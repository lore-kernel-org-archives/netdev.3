Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB71935C682
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 23:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675577; cv=none; b=CDPbpqaGq6NxfHL5u8mBTc6BxM7/GauqXpaSaYd1ivDrvjsCKvCRlhAYlz+hiEQm6w9o4ZIuH3AuN7M+8X4iNnxOgXL0TCdgNZS6Z6GAehH2W5K7lfDfKP1WpJDgCy1oP4uVUM2Qb3BTNIvgKIX/GOUwZ+h58Ed9gwBiDNQDtww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675577; c=relaxed/simple;
	bh=Qsy9pxG0ZiPzVMrZREnQD/AsgYibId+ttr/qYC+JKKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgRLrUjTcQucW7W4aTR1pj/swR1lkEoleNqwcsRqV+hyekeCSH1mK5YMg/PpT5EBK2Vc7k92xIhxEnjudjZPW4V0CQuyA7UNk4Bk0/G6d/1HBmPfEeJI131Od/fIdhiCe409ie6DkFJzAUI0ROJ+EJSEQUm8pEASHoUlutXRTFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g/MJFhTf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g/MJFhTf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4DcE3KqVDNfHAhhkWxaeBg4TIRClxbD2Bz/bkHDor9c=; b=g/MJFhTf9l2bHpAcg4AKsoLjgN
	TjvfKs4UiqY6cP0Os9dj+rNvHZEUULytndd9zuvYunmeItSDdUfwBZ+U8s5MHMG2gt7WK7YO4J6VW
	IVN4yk3qzTn3Ut0j1jZaDs3Fljf4A1G7OKSIYIjnfCXYeJiBIN1TwQZy4wmVzmL9CNsE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmJdi-00DWcD-Ep; Wed, 22 Jul 2026 01:12:42 +0200
Date: Wed, 22 Jul 2026 01:12:42 +0200
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
Message-ID: <a70dc967-6656-4eef-beea-d1894e983fde@lunn.ch>
References: <SN7PR11MB6900E94E718175AACB2309109AFD2@SN7PR11MB6900.namprd11.prod.outlook.com>
 <e3dd8e06-97d1-4943-b54c-fdd0d0e6ecaa@lunn.ch>
 <20260711073128.7f94e0ac@pumpkin>
 <bb7bb5c6-5643-4e5b-b26b-9363127bb2d8@bootlin.com>
 <SN7PR11MB6900984B5FBD60B71B3B8F329AF92@SN7PR11MB6900.namprd11.prod.outlook.com>
 <20dde8ba-5429-45e2-8071-ce83f1c2d6c0@lunn.ch>
 <DS0PR11MB6397D3B945CFF9FA501AC6F688C22@DS0PR11MB6397.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB6397D3B945CFF9FA501AC6F688C22@DS0PR11MB6397.namprd11.prod.outlook.com>

> As for your comment/question about FW vs linux controiling the HW, the intent here
> is to use linux to tell FW where to go based on user input.
> How the link is eventually achieved is all in FW.  

I don't see how that works. ethtool has no APIs around
phy_interface_t.  All ethtool offers is link modes. How do you see
this working?

     Andrew
