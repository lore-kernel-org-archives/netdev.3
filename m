Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320132;
	b=xUApseu1aQDwkBQMdUqtJkgRVJGOW/w0S11duKgXFCmTRdPT1kVp6AvudSY6iuaibaDa
	 eAhSjwCdMwJw4D6HsswZeu133qPSzEq0KZUb4leowcKzQrAofxpXL4WaPpkLAQw0LTwaK
	 3hmPkqeClRruI7yrPgbOIqanTMSaUNeVSl3cwbfhTIIFZn2Oun2YgLdDPrKQ9MI0jE5Sq
	 XQEP9/IhBlGLZ2srJTeeso6HMVH6cWRDeHnOR3BU2vUBtY6LIWVXDE+LGIryFQJhjlRgJ
	 A5B7yLVuqNI2xXCO8mIQ/ZHo4quiCx46Gzy/7zq3zxjdZEpV5JliePguiHpw5TPwxGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320132;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=GxIvKSga2N66MM4PPKy/zEU2KBU8daUXspv11nGly7g=;
	b=nK4J39nQDeKUUV8qfE0c3OuLKUCJNPWlE6krjyQXf9orwN/no5SAT+sYXwoGf3w9F6Uu
	 R6SevGsA5tms7Fiy1Z+5vLE417e3+ZVXOAGDCTueJNwnVzy5Lu1cB5Am6sdWnpGDFgIZ1
	 4ILoSvWsrKvxZKKcbGol4MfgjaMEoT2hC3/TcHVqJs/JkTodVJl1RLDcTY7puKR004nnI
	 O5YQAcqTSZBejdx4cQ5X1jofRrkX6mLUyf7SlWn4+GtgNDW0ozOcURspiiPTiCRyx0mW2
	 m6L4VZAOa7puAvl2VqUypCnvyI7cC4RAFyPEz37NcoxfXqk35n/Msy7i6U7Q9G0JA5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GxARJiRs;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00F8606A321;
	Tue, 10 Nov 2026 14:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C00F8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GxARJiRs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794320132; x=1825856132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TmN61axYmllJcj7cTJcrh3bkPcrCqfZguo5XcJlLpcc=;
  b=GxARJiRs9Go5BP5+n0QGo1EpP9k7UO0SRaAkTUfYZTcZjuzbnM1/O9g1
   awac/OkyZ1cZ7yuxuXy/4jJvjOZxlLFny2IXLM2O3PuiEOmUsHSVGggRl
   XxoMlmlDTUbQifnQE+g8B8TWLmyiY48Gon6NV9P1nF9yi/pklffD8m33D
   hBBHQBpilr+z0surG4yH3IVNY/N206VMxNnoec2w/QMK0MJvv9BWZQVy7
   +nb5y0vFgv97n2Ga63lwt5bJZQ8E/kYADQ/svJQV46xwrxn3ZZpiBnoaV
   N3zeOKwdcXkR+fe8AqcnyrRw9Qp5dfhDTLwvgE75EBV5fd7ZabjPEuQcZ
   A==;
X-CSE-ConnectionGUID: Ypqqyf9OQACwO9R7XijXTQ==
X-CSE-MsgGUID: zYH9iI/AQ8CHo5BHXL+x/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3082567"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3082567"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:15:31 -0800
X-CSE-ConnectionGUID: Scheq46MTLWRyxadEA8KpQ==
X-CSE-MsgGUID: 4kTFNcGLS8eqjxHmDzBYGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8039505"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:15:27 -0800
Date: Tue, 10 Nov 2026 16:15:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: netdev-bot+sashiko@kernel.org
Cc: liuc63@xiaopeng.com, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	khtsai@google.com, fangxy@xiaopeng.com, rdunlap@infradead.org,
	dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/2] lib/net_utils: allow mac_pton() to take a custom
 delimiter
Message-ID: <avMm_f2-2PZOU9v5@ashevche-desk.local>
References: <20261106030605.576584-2-liuc63@xiaopeng.com>
 <179431528628.994134.9205744622940373491@kernel.org>
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
In-Reply-To: <179431528628.994134.9205744622940373491@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 12:54:46PM +0000, netdev-bot+sashiko@kernel.org wrote:

> > +/**
> > + * parse_mac_pton - convert a MAC address string using a custom delimiter
> > + * @s: string to be parsed
> > + * @mac: buffer to store the result, left untouched if @s is malformed
> > + * @delim: characters accepted as a separator between the byte pairs
> > + *
> > + * @s must be MAC_ADDR_STR_LEN characters long and use a character from
> > + * @delim at every separator position, e.g. "aa.bb:cc.dd:ee.ff" with ".:".
> > + *
> > + * Return: true on success, false if @s is malformed.
> > + */
> 
> [Severity: Low]
> This isn't a bug, but does this kernel-doc describe what parse_mac_pton()
> actually does?
> 
> The only length check in the function is:
> 
> 	if (strnlen(s, MAC_ADDR_STR_LEN) < MAC_ADDR_STR_LEN)
> 		return false;
> 
> strnlen() is capped at MAC_ADDR_STR_LEN, so this check only rejects
> strings that are too short. The parsing loops read only s[0] through
> s[16], and nothing checks that s[MAC_ADDR_STR_LEN] is '\0'.
> 
> So input such as "aa:bb:cc:dd:ee:ffJUNK", or the 7-octet
> "aa:bb:cc:dd:ee:ff:00", returns true and fills @mac with the first six
> octets. That doesn't fit "@s must be MAC_ADDR_STR_LEN characters long"
> or "false if @s is malformed".

> The runtime behaviour is the same as the old mac_pton(). The current
> callers (the mac_pton() wrapper, and get_ether_addr() in u_ether.c later
> in this series) don't depend on long strings being rejected. However, a
> new caller that trusts this doc could skip its own end-of-string check.

> Could the doc say instead that @s must have at least MAC_ADDR_STR_LEN
> characters and that anything after them is ignored?

Yes, this needs to be fixed in v5. Adding two words "at least" into the
mentioned line of the kernel-doc.

> The other option is
> to reject strings where s[MAC_ADDR_STR_LEN] != '\0', but that would
> change behaviour for existing mac_pton() callers.

Yep, that's why it's a bad idea.

-- 
With Best Regards,
Andy Shevchenko


