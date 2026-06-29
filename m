Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7197B405860
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738676; cv=none; b=ERlFPvt8mfpOuKnXY0c/wrU1HSNADBFwVc4R78QRJucNsclAfddFqCjVeUnIKQP7fQA6bNbC2H57P6rXVE3YztAcmdotf8rjwF4vU2KJNQg08h5stu0pX0deq09waUF9axmnqADRuaELEMShQ1G1G9t+KTmuHiALb2TZ29H8CNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738676; c=relaxed/simple;
	bh=Uvbn2OzXJH/AEYcQQZnnByuP9FqGwNtcUMW2sa97Ik4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEXaGryPTe3wIeHfkauX0YDPW/ADLEnKJIkIBklPLCGPlS7bjtAjvQd82HVhOi0C36TofupEddCIphi1hnAeyWODNRu1McTHI91I96zc8CG3rhspZ7xge5CtY+TWrJDk9UUfUbx8B5bNWkYigWQ1XRewrcqRpj5ikDnIpSjQxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JJ2c5AB4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JJ2c5AB4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UDQKJL7fISB5ZtnqWn72zCYjTHrHpgulsxTX7mBM+fE=; b=JJ2c5AB4WUYQ9643mGcyXLt63m
	VNCAT7My1v2sGUBkfYXwfE09VQwhvHkb03st0hZZ3RNLzLTSramYCHbhaRDmCe1+xpupxumZwBqIx
	/EWYjephBcvBBedCPTnc4qYcJXXxJyCoQFfR5347Snj/3TAF4JuI3lIG39Pzq0E8ELdM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weBlM-009l2z-Js; Mon, 29 Jun 2026 15:11:00 +0200
Date: Mon, 29 Jun 2026 15:11:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "D H, Siddaraju" <siddaraju.dh@intel.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Das, Shubham" <shubham.das@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"Srinivasan, Vijay" <vijay.srinivasan@intel.com>,
	"Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
	Niklas Damberg <niklas.damberg@ericsson.com>,
	"Wirandi, Jonas" <jonas.wirandi@ericsson.com>,
	Siddaraju DH <siddarajudh@gmail.com>
Subject: Re: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
Message-ID: <deee3864-69dd-4eb5-bcfc-4ab771f4530c@lunn.ch>
References: <MW4PR11MB6912A234CAAAFD25EAC7C8909AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <2994edfc-0894-49c9-abac-6daea5e12075@lunn.ch>
 <MW4PR11MB6912BE7FEDE5C509B6C5D5DF9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <2baa5a77-3305-4ed9-b56d-ba27cecc1911@lunn.ch>
 <MW4PR11MB6912BABFEED268D38B4BC2BB9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <1b3975a8-788a-4b81-94ec-3ab5708b251b@bootlin.com>
 <SN7PR11MB6900D73E1714AA8AE05BA7BF9AE82@SN7PR11MB6900.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR11MB6900D73E1714AA8AE05BA7BF9AE82@SN7PR11MB6900.namprd11.prod.outlook.com>

> Will wait for @Michal Kubecek's response about the manual page update
> and as second possibility: options to update ethtool help string.
> 
> IMHO, yes the comment in ethtool.h enum definition is good
> as it helps developers who use ethtool.h directly but from
> ethtool app USER point-of-view, the manual page is the
> first impression and ethtool --help is second. The effort here is
> to help the user with a clarification, to avoid the clear confusion
> with the wrong naming of 10000baseCR

Is there confusion? git blame suggests it has been there 10 years, and
this is the first time somebody has questioned it.

I would limit changes to Documentation, man pages, help etc.

	Andrew
