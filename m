Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787575;
	b=48Obyp8xNIbT1fsHXNEvGeUAfA/DR7/9py75YAPtxkl+x2J+CcZpDn+RAVv+hV1TQ6is
	 J7I0n2EmOMo/V/7j0+XaneOPb+q8qxwSQY257N1aCPC1mBa7LBK6UhWEkRTxkOLhfRSi7
	 uh1bGqsMV5LMTnzvC+bLnacgZZw2Uwxgafu15i4MIKvgUll0A63bHGAw7MGV5tqSmGQMP
	 bER5ywCkGs47116SbwrJN9ZvQ5q+qOXi7MAJvvGFZqC85q4TjJ5SbJw0KIBeCTZ1G9WSk
	 S0KqFZQVFcU7/ltY60fLP+D4XU/b41nhaJYmHsPr+tnwcu3nBnabI59lIsVngjcgIRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787575;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=kNT+TBf7Xk703cd7+a2HBBEiMx+XYquVY2orv0TAisc=;
	b=P5bNLzvHmB0f8J82QVMzVHBQnTWL09jHM+SEn/Hjea7iTYwC+yxP3XQOl/wEcpqwOO1p
	 x3KFVgJsX0VP0o5vGt6RADXQvobNvW0DT+kPGarY+pZv91dMQhH2sXv2LsFmPpy3anU+P
	 v09yoOMVBounhiGgm0JZW2Ea5x1WNroaiRaSlmwBDZM1eUIyJ3ucnmgXhM9CUz91dacxW
	 HVNlMp7d6tj4bGB5H8wtVLty3PVwcfbb+cfVsub7sHV9Fo6MHFRu5wV+8b3SYPZrkvsZG
	 xVEJLsqc7C+w8rSx4KGsXGN7Y1ZyzYS9W8V+10Lz94uQrymy7g2oz1NPGt26kNEexVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XZ5OhaRN;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE0B606A31B;
	Wed,  4 Nov 2026 10:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECE0B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XZ5OhaRN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793787575; x=1825323575;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rcTDP+KWHo2gNfswjTOl43Ulpy6RCia8WdpYg5XrOlU=;
  b=XZ5OhaRNYSglUlomoMz1x1ahRG/He7jLj+SkrdQkmx1jFivRhsoe0eYh
   FjRxlWRozfGUZXyEoNVqNj9nnMWyMyOxGhqBZ9iTe4LuAj92UODzWFPY3
   rWzHo4LbihvlX4pRp2y01eAJpGC3cX1C3Bt+FUpFLMJd12rj3yElY1xM0
   bteAcIwf6ZCOpd1qihKj8nA1QSVyk+EfINxUgN9zeen+vAHA9KKXH3VN7
   Ju+aQBgLvA5MLY0d7xBc87gNvf4da5jR23iU7ynEZJkaaa4LmpfqjNhLS
   /1B3oBjP72R/jC71CLaG58sLtk19mmXDZjYI9pwr7n+1b/2iDaTYXaRpf
   Q==;
X-CSE-ConnectionGUID: H9tBFbT9QpesQrKWRzLz7g==
X-CSE-MsgGUID: 9g5duCfPQA6QhR29pHP02w==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2571370"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2571370"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 02:19:34 -0800
X-CSE-ConnectionGUID: zlNP84fiQmicvrk/eaMssQ==
X-CSE-MsgGUID: jbRfxsLoSeW0GYgXP4nngQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6702443"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 02:19:31 -0800
Date: Wed, 4 Nov 2026 12:19:28 +0200
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
Message-ID: <ausGsH4Q6IDMMtin@ashevche-desk.local>
References: <20261104025058.2650911-1-liuc63@xiaopeng.com>
 <20261104025058.2650911-3-liuc63@xiaopeng.com>
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
In-Reply-To: <20261104025058.2650911-3-liuc63@xiaopeng.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 10:50:58AM +0800, Liu Chao wrote:
> get_ether_addr() walks the MAC address string with a fixed six iteration
> loop, calling hex_to_bin() twice per iteration, and never checks for the
> terminating NUL.  A short string therefore makes it read past the end of
> the buffer.  The dev_addr and host_addr module parameters of the legacy
> gadget drivers are copied into their own kmalloc'ed buffer by
> param_set_charp(), so the overrun crosses a slab boundary and KASAN
> reports it at insmod time:
> 
>   # insmod g_ether.ko dev_addr=ab
> 
>   BUG: KASAN: slab-out-of-bounds in get_ether_addr+0x1ec/0x230
>   Read of size 1 at addr ffff888009f91f53 by task insmod/70
>   ...
>    get_ether_addr+0x1ec/0x230
>    gether_set_dev_addr+0x6b/0x180
>    eth_bind+0xfd/0x3b0 [g_ether]
>    composite_bind+0x1bb/0x7b0
>    gadget_bind_driver+0x229/0xb00
>   ...
>   Allocated by task 70:
>    __kmalloc_noprof+0x1d1/0x4a0
>    param_set_charp+0x4a/0x220
>    parse_args+0x267/0x5c0
>    load_module+0x4f6a/0x6600
>   ...
>   The buggy address is located 0 bytes to the right of
>    allocated 19-byte region [ffff888009f91f40, ffff888009f91f53)
> 
> Besides reading past the end of the string, the loop ignores what
> hex_to_bin() returns: it yields -1 for a character that is not a hex
> digit, and that value is shifted and OR'ed into dev_addr unchecked, so a
> malformed address can be accepted as a valid one and the interface comes
> up with an address that nobody asked for:
> 
>   # insmod g_ether.ko dev_addr=aazz:cc:dd:ee:ff
>   # cat /sys/class/net/usb0/address
>   aa:ff:cc:dd:ee:ff
> 
> The configfs dev_addr and host_addr attributes of the ECM and NCM
> functions reach the same parser through gether_set_dev_addr() and
> gether_set_host_addr().  Their store handler passes the page-sized
> configfs buffer straight on, so an overrun there stays inside the same
> object and is never reported, but a malformed address is silently
> accepted all the same.
> 
> Replace the open coded loop with parse_mac_pton(), which checks the
> length and every digit before writing anything to dev_addr, and keep the
> existing eth_random_addr() fallback for all failures.

> Note that this makes the accepted syntax stricter: the old loop also took
> a separator-less string such as "aabbccddeeff" and the Cisco notation
> "aabb.ccdd.eeff", both of which parse_mac_pton() rejects, so such input
> now falls back to a random address instead of being parsed.

Hmm... indeed. Perhaps we want to continue supporting those.
Web browsing and AI assistance suggests that there are only few
formats that can be met IRL: raw (no delimiters), Cisco (4-digit-dot),
Windows (with hyphen instead of colon), and quite rarely OUI split
(3 bytes + 3 bytes with one of the standard delimiters ':', '.',
or '-').

Examples in the kernel and comments are only suggested about standard
hexadecimal 2-byte-colon.

The function itself was introduced in 331a2d82bcaf ("[PATCH] USB:
ethernet/rndis gadget address params"), and not in the USB network
core split as your Fixes points to. The commit message doesn't tell
anything about supported formats. Documentation also doesn't
clarify it anyhow.

AI gives this table (take, of course, it with grain of salt):

MAC Address Format Structure	Example Pattern in g_ether Context	Approximate Number of Public Web Resources	Usage Percentage	Primary Source Context

Raw / Continuous Hex (No Delimiters)	g_ether.host_addr=123456789abc	~110 references	~3.1%	U-Boot automated environment macros, hardware factory provisioning notes, custom embedded board bringing-up logs.

Cisco Dot Notation (3 blocks of 4 digits)	g_ether.host_addr=1234.5678.9abc	~15 references	~0.4%	Hybrid enterprise routing guides, blog posts authored by legacy network engineers config-switching to Linux gadgets.

Semi-Grouped (Irregular byte clustering)	g_ether.host_addr=123456:789abc	~3 references	< 0.1%	Highly specific hardware diagnostic scripts or open source issue trackers validating parser limits.

So, taking it into account as a trend, we can really forget about semi-grouped
and Cisco cases. The Raw is easy to support.

		bool valid;

		/* Try standard format of MAC address */
		valid = parse_mac_pton(str, dev_addr, ".:");
		if (valid && is_valid_ether_addr(dev_addr))
                        return 0;

		/* Fallback to raw format */
	// check, if it correctly handles the case you want to fix here
	// I believe it does handle it correctly
		if (bin2hex(...) && is_valid_ether_addr(dev_addr))
                        return 0;

-- 
With Best Regards,
Andy Shevchenko


