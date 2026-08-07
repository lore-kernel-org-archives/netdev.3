Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA94837C11E
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128145; cv=none; b=iT5j609ZogR+ZAcU1drhl/bGFd5lDmzG/uyegwTO36I48bZrh/RDMZZtjsM8m1OP9kZHTXNB8lN6JhsB2a5zORht2EtSU2Zj5Oq8n3hiCC1uZj6gKaEYSXbpgnpT3+dd7b7yi/H05LWInXoZHflfBXM620n06Algo82fe2kgir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128145; c=relaxed/simple;
	bh=kIxvH1ECDAJjmkjqqBi8p4D7nI8FKr025kL/O8Y1RNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boH5oPKVqdZANlch0a0O/gZJjKCePu5OOlodMAlFnXvy4lmEfNBtRmU9kPNyhmlbhrvda1YugX1Cf5OjJva4jIZ7Qz04187QSCmS9Yus5IUPkZFsnZtWaODaZ+wZq8gJ+W7l6GoVGvwg8Kx2+/OJ0SUGRlYyf+nb/7XYDwKnApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sB/22N7Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sB/22N7Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YIAWJfIwSNFtkKjD5xlFiUWxLnIwM/cdT5KEU51NJIk=; b=sB/22N7YFBnLC+Wwqf4yDayyQQ
	nGt6Xu/BcpdmPO+ws9V3FzzNz+4lksXSL87STWTANsrzg6wD2l+3EP9VQC+m3Dxs/qc5Fa25SsK8o
	fCCbuLMaX2oTwNmreDeHUX8TdLHJY+nfU0G2r/fdlwxk11EUZeomYP+oBPN82Tt8CJAE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wsPWL-00Gd5x-Ra; Fri, 07 Aug 2026 20:42:17 +0200
Date: Fri, 7 Aug 2026 20:42:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Das, Shubham" <shubham.das@intel.com>, Lee Trager <lee@trager.us>,
	"Srinivasan, Vijay" <vijay.srinivasan@intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>,
	"D H, Siddaraju" <siddaraju.dh@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
	"niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>,
	"Wirandi, Jonas" <jonas.wirandi@ericsson.com>
Subject: Re: Ethtool : PRBS feature
Message-ID: <debdbcd4-e2e4-49f1-8961-b41f299e61e6@lunn.ch>
References: <BL3PR11MB6385468A86BACA1D8EFEF2BE88F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <SN7PR11MB8109F7A3F491E20701BDC0DFFFF02@SN7PR11MB8109.namprd11.prod.outlook.com>
 <46f714b7-ec6e-4b26-9ff8-b7f27f11fe33@trager.us>
 <SN7PR11MB81091D62922BAC1AF7A553ECFFF82@SN7PR11MB8109.namprd11.prod.outlook.com>
 <SN7PR11MB810996F17CD8513F4CD57371FFCF2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <CAKgT0Ucz8FT0EvdUMm=dUS-Q171ZuT-i-n+mahJV3OvQnOMkyw@mail.gmail.com>
 <SN7PR11MB8109B6F350AE2E5BC02C6E1EFFCC2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <SN7PR11MB8109AD2F25C4DE21C048C9CBFFC92@SN7PR11MB8109.namprd11.prod.outlook.com>
 <SN7PR11MB8109BF8590FC789586C326F5FFD12@SN7PR11MB8109.namprd11.prod.outlook.com>
 <CAKgT0UfEgu5xFts82j4=qFCiX-JnNVrtL3MUEhffpP7B_ZqvWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UfEgu5xFts82j4=qFCiX-JnNVrtL3MUEhffpP7B_ZqvWA@mail.gmail.com>

> Honestly I would probably defer to Andrew or Maxime on this as most of
> the DSA stuff is much more their wheelhouse than mine.

Sorry, too many patches recently, too many newbies using AI without
the knowledge to properly steer it, etc, so i've not really been
following along with this thread.

> Also rather than submitting a snippet you might just resubmit the full
> patch with your changes as an RFC as it provides the full context on
> what we are reviewing.

+1

	Andrew
