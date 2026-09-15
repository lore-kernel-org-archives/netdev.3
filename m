Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE131FB1;
	Tue, 15 Sep 2026 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457767; cv=none; b=NSemO9L41zmxgiEeo46Yj2e/jss5whsGjuXTeB1Znb0sF5t5c+AJLBGwl8NWitwkJ6h893CB6yXBhmJ7VlwAEHQQvFkHq8FkpwbeIsxf5XuZRt60XRlgtBHM28lY2CWHdB03P5hu9dqbIBZ4O9+5/Ltng3+F1CFUySH1oAz3FrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457767; c=relaxed/simple;
	bh=XI314yk2mcLA3E5rxG8QGiO3KQMt+/7qiDJWUztORNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKiY3/2SAlG9p2BEwzw6w0vMSP5KxUA6SimfB6cdu8dfAGhCxHu1ZTtYFhuSXFwy3bEgeMKti0x23FrdbjlwzudX8QnzOPDt5a6ZNQhli4BedNw2D3Xel1glQs8Ud2ae79nlFJyJbjU79nBOHoeIzaulAivROnGb3avRkeiOBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jo6kmtoi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jo6kmtoi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789457765; x=1820993765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XI314yk2mcLA3E5rxG8QGiO3KQMt+/7qiDJWUztORNE=;
  b=Jo6kmtoicpmWxEaBWYrpe36mM6D5I808tsTonPVMUf3MiA4gy4i/YcOs
   W7UTMRO6FGa42Rwpe5HJXMsyLmtyrjF2ySBa5tQ4DC9JXs7pQTe5wGr62
   QQsUzjQ0TC8A063XpjwgkWJcSuUw3mEx0UQLURwIoL6DO0YjEBo66KkrK
   KbasPhdDLABss29P9aGiO/EwyB7jMmPPrUXSAya5jh3O85ByZeikmaOX8
   x4za6n/WFU75GU4SybamDhqL1UxTZArl8RQp01jfsDGLZ0VQ8pXPqawcP
   nIuymMhCW4StY+BzWF/CHhrVLrjCLz4peAipVs/O+ztlkCQzC3EPnjkTo
   g==;
X-CSE-ConnectionGUID: 29zJ97P2SCCtzsd9bs4xRA==
X-CSE-MsgGUID: EvGH581cRPmLArBHvS81nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90019247"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90019247"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:36:05 -0700
X-CSE-ConnectionGUID: 5NzGOxZcSlioubbv6v+4ig==
X-CSE-MsgGUID: z4d7+SynT9Cjp4sbKYG6UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1271050"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.203])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:36:02 -0700
Date: Tue, 15 Sep 2026 10:35:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lucas Stach <dev@lynxeye.de>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: usb: asix: reject a truncated Data
 header in rx_fixup
Message-ID: <aqj1X8aIEs5SqEAK@ashevche-desk.local>
References: <AS8P251MB000193C798F98A11C73C3E9DC8BB2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB000193C798F98A11C73C3E9DC8BB2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 14, 2026 at 10:23:45PM +0100, Aamir Ahmed wrote:
> asix_rx_fixup_internal() runs its parsing loop while two bytes remain,
> but the branch that starts a new frame reads a four-byte Data header.
> Only a two-byte tail is special-cased, via split_head, so a three-byte
> tail reaches that read and leaves offset at skb->len + 1. The clamp
> below it then takes the unsigned difference skb->len - offset, which
> wraps, so copy_length becomes the full length the device asked for:
> skb_put_data() copies from one byte past the received data and
> usbnet_skb_return() passes the frame to the stack, before the trailing
> skb->len != offset check can report it.
> 
> Reject a Data header that does not fit and reset the parser state, as
> the other malformed-header paths do.
> 
> Only a device emitting an odd skb->len can get there - every asix
> rx_urb_size is even and offset always advances by an even number of
> bytes - so this is net-next material rather than a stable backport.
> 
> Fixes: 8b5b6f5413e9 ("net: asix: handle packets crossing URB boundaries")

If it's a fix, why net-next and not net in the Subject?

-- 
With Best Regards,
Andy Shevchenko


