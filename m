Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866940;
	b=y5Ip+tkffk+fxqI6qOhu15WQ5/qqw1ZkdNikICtQBgBDVAzaro7NTmhHif3kYmtdT10r
	 bSt/SZUcdOYc8LiwqbvwCIRLYs+N/v4oHgHZk7+cm2DWnwRuWPdqEL2t2qUVA/25iV+O+
	 zgtfWdQiWRN+z8yZ/gtfji+OI0KigFgtGEjawaEYLJH80yEewFSA7iYt9ie6tsIIlD07a
	 OGELMNe+EIE0ycvRkjKzizdjqsVu3AA9MAXfRqmP1EyCkZ/qDi7peI+QFWxhGqrsoacoX
	 O9ybLNH//srIw3xmXrQXiL/bq5+7+TQL8Tntz7J+OCKia7+9k1P/v9UpInNn2xEGbxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866940;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=FE6flEcS2K/7KWRh4Kaf757dnWLpMHfHAJ2OdiuX5FU=;
	b=QoxtqvV0781PEUt+LlwoZgUxuY3iV3AyPsmnf34n+9PBo2Ou4TMcCRkb4DkAtVld5Ziu
	 kUxvXzJFcMWMEv6QnnojB4JVDhXh5r6wo3dJrCGg4gMwK48frXlKXpsHomShwkEd/UP6m
	 c82x6Rvu4XXbOwg4e7CoyyeyuIxviHmXM6lKNNWdzqdAM86b8Vnt9rIjTxxrrCpjvFmaW
	 Y13YZkjQEOCzK44ntvHzl66oYDqbPBrjSL5/kdXDX3E50kRkF22+F3lWpz8DJOV2mZOEB
	 z6ZzrMEHwQapPPSXoa9toeLaCTfQvLlkbtwxeJaXymLlGG15FMYtHlJYr+vg1EVDuJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TspYA1oJ;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB7606A31B;
	Thu,  5 Nov 2026 08:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60AB7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TspYA1oJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793866939; x=1825402939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DEatSBoF3t2AIO2viBbGfJoI7pyTQ+39KdF/ZrSmhQ8=;
  b=TspYA1oJ370XczcWgja3fDx1qdpkTgKYCGAIVZwTGsSw2NCPHVonbzZl
   SwYUEeYpBn9K/OMd10t8haKLp5HltjD7ucHT6zGWl+jJHwwmPM9rriN/t
   cH9sx340S7SFasgRVQhCX3QQu/4ZI+zpFAp1rrnSkb7NqcQEfZj2S9ife
   KIYqYUxM4/VH8Iek5YUklXsR1+/dZWafehtzRPYUxvq//6nGFVQSTpchA
   eYhQ8mCSBtx6mFtVXST3fslNL+OLTKhNCLYRqR9OzHGgun6ywoLXurGDY
   AbrV3rOmr7MPUiXEi76XJrBwXYI3UgK9qdv/L1isg/Udl3SWnbLnM0Rjg
   w==;
X-CSE-ConnectionGUID: Rv3xYSmaQ/GelGpzXiPAdg==
X-CSE-MsgGUID: PtlXw5G9ShmL3m42J5meSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2544917"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2544917"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 00:22:16 -0800
X-CSE-ConnectionGUID: AkKOJ/V8RoqUF1HxSP1VPw==
X-CSE-MsgGUID: tubbTcFTRhyaJ5DltBVd3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7285527"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 00:22:10 -0800
Date: Thu, 5 Nov 2026 10:22:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Liu Chao <liuc63@xiaopeng.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, khtsai@google.com,
	fangxy@xiaopeng.com, Randy Dunlap <rdunlap@infradead.org>,
	dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: gadget: u_ether: fix out-of-bounds read in
 get_ether_addr
Message-ID: <auw8sAYE-nkZ-qIT@ashevche-desk.local>
References: <20261104025058.2650911-1-liuc63@xiaopeng.com>
 <20261104025058.2650911-3-liuc63@xiaopeng.com>
 <ausGsH4Q6IDMMtin@ashevche-desk.local>
 <20261105072144.3382964-1-liuc63@xiaopeng.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105072144.3382964-1-liuc63@xiaopeng.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 03:21:44PM +0800, Liu Chao wrote:
> On Wed, Nov 04, 2026 at 12:19:28PM +0200, Andy Shevchenko wrote:
> > Hmm... indeed. Perhaps we want to continue supporting those.
> 
> Agreed for the raw notation. v3 restores it with a hex2bin() fallback.
> 
> >   bool valid;
> >
> >   /* Try standard format of MAC address */
> >   valid = parse_mac_pton(str, dev_addr, ".:");
> >   if (valid && is_valid_ether_addr(dev_addr))
> >                         return 0;
> >
> >   /* Fallback to raw format */
> >  // check, if it correctly handles the case you want to fix here
> >  // I believe it does handle it correctly
> >   if (bin2hex(...) && is_valid_ether_addr(dev_addr))
> >                         return 0;
> 
> It does handle it correctly, and I checked why rather than assuming it:
> hex2bin() validates every character and returns as soon as it sees one
> that is not a hex digit, and the NUL terminator is not a hex digit, so it
> cannot read past the end of the string. If it does manage to read
> 2 * ETH_ALEN characters then the buffer holds at least that many. So no
> strnlen() guard is needed in front of it.
> 
> Confirmed on a KASAN build of exactly what v3 contains: dev_addr=ab,
> dev_addr=aazz:cc:dd:ee:ff and dev_addr=aabb.ccdd.eeff all come through
> with no report and fall back to a random address, dev_addr=aabbccddeeff
> now gives aa:bb:cc:dd:ee:ff, and dev_addr=aa:bb:cc:dd:ee:ff still gives
> aa:bb:cc:dd:ee:ff.

Cisco should not work, the index is going over 3 characters on each iteration.

> Two details about the helper itself. The direction we need is hex2bin(),
> not bin2hex(), which turns binary into hex text. And hex2bin() returns 0
> on success and -EINVAL on the first character that is not a hex digit,
> whereas bin2hex() returns a char * that is never NULL. v3 therefore uses
> 
> 	valid = hex2bin(dev_addr, str, ETH_ALEN) == 0;
> 
> > The function itself was introduced in 331a2d82bcaf ("[PATCH] USB:
> > ethernet/rndis gadget address params"), and not in the USB network
> > core split as your Fixes points to.
> 
> You are right that commit 2b3d942c4878 ("usb ethernet gadget: split out
> network core") does not introduce it; it copies get_ether_addr() into the
> new u_ether.c, and the function is already at
> drivers/usb/gadget/ether.c:2240 in its parent.
> 
> 331a2d82bcaf does not resolve for me, though. It is not among the 104530
> ancestors of 2b3d942c4878, and that range reaches all the way down to
> the git root, and cgit returns 404 for it. The loop is already present
> verbatim at drivers/usb/gadget/ether.c:2236 in commit 1da177e4c3f4
> ("Linux-2.6.12-rc2"), so it looks pre-git to me, presumably a BitKeeper
> sha.

You need to add history.git from history group and tglx
https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
If you want to have smooth link between all three, add grafts.
$ git replace
1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
7a2deb32924142696b8174cdf9b38cd72a11fc96

With that being done you will have the full history from Linux 0.10
till these days.

The above mentioned commit is from v2.6.10-rc1.

> Nothing in mainline history uses 1da177e4c3f4 as a Fixes target, so v3
> drops the tag and records the provenance in the log instead. Say the
> word if you know a tree where 331a2d82bcaf resolves and I will put it
> back.

It depends on the Linux Next checks and USB maintainers, not everybody does
have a full history (as possible). Better just to refer to it [1] in a free
form, like

[1]: 331a2d82bcaf ("[PATCH] USB: ethernet/rndis gadget address params")
     from v2.6.10-rc1 (check out history.git tree)

> On the Cisco notation, agreed: keeping "aabb.ccdd.eeff" would need a
> parser of its own for a grouping that nothing else in the kernel uses.
> v3 spells out in the log that it and irregular groupings such as
> "123456:789abc" stop being accepted, so the narrowing is on the record
> rather than implicit.

-- 
With Best Regards,
Andy Shevchenko


