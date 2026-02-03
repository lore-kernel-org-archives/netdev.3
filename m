Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4A339524F;
	Tue,  3 Feb 2026 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770107133; cv=none; b=qOfKKNyfC9fBKaAxoLTtShIkVCV6oMbC/Q7Wm31K1cqkMpp9pkkYpmP8tvGZPqpXoS2h6GorMhVpMTb5XihtqrV4pDdcWIgtlCUz2hQK76kk1gbk/OYvDn4VBfJXi7n4Zh0dL0sFiDHZmG0fhu5klrUKrb9xxsypAZYflTaQB1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770107133; c=relaxed/simple;
	bh=Z301POJ0aDWyYxAcdWEO8C7RNgn2ukfXuTND5yFSzzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp5baP9MOsbqA9Urpl6AzF4RqIthlq5mlBb9A1RWdfoIyja6wJTDVNoU4HHHzColB43OKL28yWbI5TKUI6QXM0s1UMkbGdh84wdRbBmCv4lFCtAH1obDzjR92hRXyIRkrfl74jRRexHoyCUrdSlUswOc+MXzWKYO+voU6XYR13w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAtQR/Jo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAtQR/Jo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770107131; x=1801643131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z301POJ0aDWyYxAcdWEO8C7RNgn2ukfXuTND5yFSzzc=;
  b=IAtQR/JoEVkkm5lD8uailR+hiBSZu4bDZ6+CApD2WL42rTYzofXex4Hv
   mbb0s2RIaazzOXze2l8hmviZmmRGvKsdVOPqacYDkrc0n0LCXbObLPpqO
   5qbexYzVsMqeY7MLqKXt8J3ffNyW3eAY/XU9urXpOXKHG01kMw3z4EeCg
   hpqM5z8QTavmL6Y/ivXx9mtjnhhNxqjKuUpCn5hNIcyuBo/POrnJF9s5i
   U51296ogiLCtrNvURYqkW8ddjp/VTlyZxPTEsZLVKpQwU5ASESIgEYH8j
   pUuLxy2+Stdy/XOB8J9q4stPyBYLtflS+Dm23DwrCPS6ZlP07NBMeapOY
   g==;
X-CSE-ConnectionGUID: +V2dTEXGT2imruaTuA1y2g==
X-CSE-MsgGUID: elyfYY2sT0qFHYDBKF4Q4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="70996068"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="70996068"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 00:25:29 -0800
X-CSE-ConnectionGUID: Q5mRRxLoS1OBYIB6UIsSlg==
X-CSE-MsgGUID: GbkgH2OoRiuD3NyjhXP1aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="214262646"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.13])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 00:25:26 -0800
Date: Tue, 3 Feb 2026 10:25:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Max Schulze <max.schulze@online.de>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Subject: Re: [PATCH net-next v4] net: usb: introduce usbnet_mii_ioctl helper
 function
Message-ID: <aYGw80IvE0TG7WOx@smile.fi.intel.com>
References: <20260203013517.26170-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203013517.26170-1-enelsonmoore@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 02, 2026 at 05:34:55PM -0800, Ethan Nelson-Moore wrote:
> Many USB network drivers use identical code to pass ioctl
> requests on to the MII layer. Reduce code duplication by
> refactoring this code into a helper function.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  extern void usbnet_set_msglevel(struct net_device *, u32);
>  extern void usbnet_set_rx_mode(struct net_device *net);
>  extern void usbnet_get_drvinfo(struct net_device *, struct ethtool_drvinfo *);
> +extern int usbnet_mii_ioctl(struct net_device *net, struct ifreq *rq, int cmd);

Do we still need to populate 'extern'? Can we get rid of this redundancy?

>  extern int usbnet_nway_reset(struct net_device *net);

>  extern int usbnet_manage_power(struct usbnet *, int);

-- 
With Best Regards,
Andy Shevchenko


