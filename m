Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF982866
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783001; cv=none; b=fY4wHOo60D3wGS8Jq46NSG2QO+CaATsFyqWQKH255uTfXEKz1jiQbw6XuYl6+sgAAeijN8PjfUB5VWrYtO/rCdUygjplETAUyVglNU3b3dxxdKKNQ4xE3AD8ao1GKmd+9keUjivFbI/k9QGSpXO/74mpnBCaxfxUrBbORYQ4ZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783001; c=relaxed/simple;
	bh=nh7AGmHVKrAU7t1AcaynZLcca/AOh35ebCYwatgCXp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfVV2k1CNg9lKuB8ZF2QOnbjhE58jDNbtBRPlJY4fRT3bv8rAoajpeDx4EjRpxHzuauQ0kGRCeRPho7uJpZDlrkjJq7BbRBr/QRvKjcgQgzh8g+/Qh/mrHX7Ym7dgwwqZuhvsV+DypN8avLfBM+0DYtr6t/WuFuEA6Gh7yK3Xwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M6O4pOGf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M6O4pOGf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=s8VVxditPMEF3PVmMbBKB0SHgQPyj5KXM+8qvAn3ZEY=; b=M6O4pOGfSSDiOeQxhgp0M6AYlK
	gEh/4UBPIRbMhpH+oZBEErCN0qQMF9M5J2VR1ph87DBnH8QGogqVELGaoZ/CpL4AV4R1pH2ImDEdI
	3WLoGy1VcFmmmRyzK4Q5BJVqE/asH/lJR5v7sLahrwZUdL6vCf1iUA2jePscDnEV7WgU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiZRS-00Bn5J-GB; Sat, 11 Jul 2026 17:16:34 +0200
Date: Sat, 11 Jul 2026 17:16:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Lee Trager <lee@trager.us>, "Das, Shubham" <shubham.das@intel.com>,
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
Message-ID: <63b07d12-d337-465b-a4a8-b8b0771986f0@lunn.ch>
References: <cb7921f5-cc9a-49fe-9561-cac903cf611e@lunn.ch>
 <BL3PR11MB63854B0A4AA33A718D474C6588F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <BL3PR11MB6385517EECD04C783E9DC42488F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <26d44b09-d72c-4e23-84a6-3d0ea4a521ef@lunn.ch>
 <705f6fcb-e0e2-4898-bf83-78c38f32f505@trager.us>
 <BL3PR11MB6385468A86BACA1D8EFEF2BE88F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <SN7PR11MB8109F7A3F491E20701BDC0DFFFF02@SN7PR11MB8109.namprd11.prod.outlook.com>
 <46f714b7-ec6e-4b26-9ff8-b7f27f11fe33@trager.us>
 <4ccc869f-a724-41fc-9bfc-da5332f54790@lunn.ch>
 <CAKgT0Ue-wMYab25gPzE8iarW2abYONv=5ZBokrLS6-DfD4WFpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Ue-wMYab25gPzE8iarW2abYONv=5ZBokrLS6-DfD4WFpA@mail.gmail.com>

> Looks like they are different derivations of the polynomial for the
> given pattern. For example PRBS11 is 1 + x^9 + x^11

802.3 section "72.6.10.2.6 Training pattern" agrees with you.

, but PRBS11_0 is 1
> + x^5 + x^6 + X^10 + x^11. That is one thing to think about. When we
> say PRBS7 the assumption is we are all talking about 1 + x^6 + x^7 for
> the polynomial.

I could be missing it, but i could not quickly find PRBS7 in the
standard!

> We may want to have that clearly recorded somewhere so
> there isn't any confusion on which polynomials we are using for this
> testing as there is always a risk that somebody is playing with
> bleeding edge hardware and ends up defining a PRBS polynomial
> differently than what is expected.

I would probably give a reference to 802.3, at least for standard
tests. If a vendor has made up their own test sequences then yes,
there needs to be a clear definition of what it is.


> I almost wonder if we couldn't
> define the sequence as a bitmap instead of an enum with each bit
> representing which fields are in the sequence.

Not everything is a polynomial. Look at SSPQR, 120.5.11.2.3 SSPRQ test
pattern.

	Andrew
