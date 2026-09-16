Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4254AC155;
	Wed, 16 Sep 2026 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552126; cv=none; b=qDNLIqr6WMDyovYn+rYUsR499D3i64SZVJo5P6YkXw+pIiA8f3AmrWiNLiXgza1qkL+fjMH+JmRDn0wYyxQjGtlHzK7sha/sTPMG9JBogwFLrBiOvX37khmLrls7bILp7dsKdZwwfC/mYs096Maces11MthUQ3QWFg/hekg0JeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552126; c=relaxed/simple;
	bh=DNHnn50GsIUIzWdFRjg15OCsLK/KeuBXWd77ZzcOKME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLTGCywr9JcSKqFw/AH3sGcEhJ6PTkqi8gJoRTgnzwyDceP/6FdK2GoFyjSZJuk7qzaMy5nqficLTwwVYr36E1Fr/4oOkYpMdI8wEM8bOM2PEWvgVwm9mOpFzc5xwgttCIlRXlLdtwpywFdBMvu2rRR9k7bYOKxCDpzIinD88w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXblpg6k; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXblpg6k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789552106; x=1821088106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DNHnn50GsIUIzWdFRjg15OCsLK/KeuBXWd77ZzcOKME=;
  b=LXblpg6kNwUgQOFweKxvyuVB4zXIkHInKLRb5jKpiZf8GMtVkw2WjRPy
   wde7Sc4iVYVaVkbYV+QfEPX6FrPla/MOar4zm2PFy0GkjN6XxJbkxcoZF
   Rw+CJpprEd+kwy0068YiN+DbjS7RS6bTipyBwAgc/zUR2bAdPri3R0p0s
   XBWXEalSw871V8FCRZaTTBfi1fYVoWjIMT5ATrkj+fAm/e+bEuJu9zErD
   qWZQeXGG8CLvCT9kZwCMd+r0dtKtr7T3McBX7hcsOUn/nAdiimzxoFcMC
   SnMqW/qIUryVTB/7lixiuYwN3SdSyeJ3mR65ArwMhPg0/vzlGu35Pa+HZ
   g==;
X-CSE-ConnectionGUID: m0y6BYLHRyG0tq4J3fsoMg==
X-CSE-MsgGUID: 0BaAcJcaQme7CFrE1w/LjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90136455"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90136455"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 02:48:22 -0700
X-CSE-ConnectionGUID: IlpqL7MrQl+Ox2jDvxO/ow==
X-CSE-MsgGUID: 5FoteMpKSTy0yhwRnoZcZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269013733"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 02:48:19 -0700
Date: Wed, 16 Sep 2026 12:48:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lucas Stach <dev@lynxeye.de>, Peter Korsgaard <peter@korsgaard.com>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: usb: asix: reject a truncated Data header in
 rx_fixup
Message-ID: <aqpl4EPCIvXDLn8j@ashevche-desk.local>
References: <AS8P251MB0001D5442318B9E58797D230C8BA2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
 <aqpKPXiVESngnVhp@ashevche-desk.local>
 <AS8P251MB000156CD4ABF9B3E03324492C8B92@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB000156CD4ABF9B3E03324492C8B92@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 09:19:13AM +0100, Aamir Ahmed wrote:
> On Wed, Sep 16, 2026 at 09:50:21AM +0300, Andy Shevchenko wrote:

...

> > I don't know the rules about __func__ in the error messages in net, but above
> > may be simplified as
> >
> >     netdev_err(dev->net, "%s(): Short Data header, offset %d, len %d\n",
> >                __func__, offset, skb->len);
> 
> I've based the error messages on others I found in this function, here
> are some examples:
> 
>   netdev_err(dev->net, "asix_rx_fixup() Data Header synchronisation was lost, remaining %d\n", ...);
>   netdev_err(dev->net, "asix_rx_fixup() Bad Header Length 0x%x, offset %d\n", ...);
>   netdev_dbg(dev->net, "asix_rx_fixup() Bad RX Length %d\n", ...);
>   netdev_err(dev->net, "asix_rx_fixup() Bad SKB Length %d, %d\n", ...);
> 
> __func__ here expands to asix_rx_fixup_internal, the internal helper
> rather than the asix_rx_fixup() the others name.

Yes, and current state of affairs is confusing. If this is _internal() helper,
it should either take a name as a parameter, or use __func__, or ideally drop
it altogether and make error messages to be unique enough that one may easily
guess where the problem came from.

But okay, since it's a common style this discussion and possible amendment is
for another patch.

-- 
With Best Regards,
Andy Shevchenko


