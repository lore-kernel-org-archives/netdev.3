Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E3B31F99E
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781894245; cv=none; b=YY/6t8lkPupa4AdOIkId6lXpEYnETIvzJeaKqq3Y8ddKT/brFz/oCao8+ruZhK4/AC8LW1Z4XKKuzdU/sHtKF/DFKdLW2bhi66FOcLtX6py6csqOpTiwSC8WVKLQp4euGfhPew6eLoMYYIWlDwP58ky267hac4KBQ5aCudsdZoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781894245; c=relaxed/simple;
	bh=TNcmrDRsJdFEXSkW0ZNu06X5xnjVTX1NSfaiIOtyhCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sj0ZOMbksQ3LAdVF1+/RqrqXpLHk6aVkguTu5D3XlFcX2MCi93B1msZHVpap8j7JRpwjf9Z3HmhvcIvxbJDBN6mwqgiiJWm2GPj8I6mnwxwrP+5NR9Rdo70CfmCse+PJ/9y8vPlyITdgOMR7kq3oC2sGEPqSVBCk35U0lFxg/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hF8A4U50; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hF8A4U50"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RtbRFvxBjSZsxeL5FYlnS8zYyWnC+gII5mJIGRFJWHI=; b=hF8A4U50QYbZ9jkgDrDIpjKUf8
	nkyWz3Iy6evrwyYv2AVm9WacwU+KYGUuE+ZogwSkGTHNQnxGsavsycwaZRp0qrIqFg0LrH8FyPFUQ
	63apwgt4XcTFzqVWjPnCe/rUFYaUIkoRDAwNjcHnyfAnrclz3qSHbrQZ5Ka4lfF3IG30=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wae5X-008Waf-KC; Fri, 19 Jun 2026 20:37:11 +0200
Date: Fri, 19 Jun 2026 20:37:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Das, Shubham" <shubham.das@intel.com>
Cc: Alexander H Duyck <alexander.duyck@gmail.com>,
	"lee@trager.us" <lee@trager.us>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>,
	"D H, Siddaraju" <siddaraju.dh@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
	"niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>
Subject: Re: Ethtool : PRBS feature
Message-ID: <26971635-b13a-4ed3-b2cb-ce35da9b63d3@lunn.ch>
References: <SN7PR11MB810923BBDEC398E860099150FF1B2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <f4a3e4ad-91e2-4844-a29b-81f70151228e@lunn.ch>
 <SN7PR11MB81099B4885C10E16D52A2EB9FFE52@SN7PR11MB8109.namprd11.prod.outlook.com>
 <06d8c98da24e80d148ede4e933bb621c5515a7a2.camel@gmail.com>
 <SN7PR11MB8109C173933D08F994FBB084FFE22@SN7PR11MB8109.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR11MB8109C173933D08F994FBB084FFE22@SN7PR11MB8109.namprd11.prod.outlook.com>

> The host driver does not directly access any registers but requests
> the PHY FW to manage PRBS on behalf of it.

Maybe a dumb question. Why?

Can you change the firmware to expose the 802.3 registers for PRBS?
You can then write a library which both plylib and your driver can
use.

	Andrew
