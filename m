Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338889;
	b=2/Ry+45oDbFCFGzg0DXbZrDqBQPZCQWc8LEYGqFzu9I9SMJlZ4zY31XiNAEiFZPgleoE
	 AShC53HJbJumvaJxnO+T3F+eO6H2EZwOnEm+YNj/mDZkepFehwlp/IldgaLY2/jTaBilr
	 9+iyO/dcBsoHCO5fHvP8TL97wBKxsbzu+ZwvDfGOcJciYTW1fR+VaGa0PvlONEXI183v7
	 iFwFc6hESn4anzeRqYBALv5QjwlxgIBSURJZX47U4Po0cwUSY84LKI74yqnBFjRhGd6fu
	 aFTUg/Q/J6gqM+su6hJJ5KlGiYreW9/zkdS9U38hopWQtzSZexqxJW+nr+mSXsoF95w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338889;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=51jvtZXqTPoK/2Yb77nppX3c9CG+qWCiBgIYaZSu06A=;
	b=jcpQyCrGs89iu3sBH+II9zeW3rzgeDfzwGPZh2yQFo0U6bA8q0DF8TngS4JXYHOdUJVV
	 1yiUbXbjq74RNnZC9Gupow5eBs/bEiXI1FvrwXjOwalGHkQVkzA/U1DJ/9pdvJoasiSqA
	 +vwksmXXKcuyW4ddD8tLljDMGXnzvPo9onB5qXV96Ww8WbXdH8peSBGWMI09HT5/5rldi
	 P9K8tR5NTqxWG2pHsQk7I6sOoztHq808BdnJabONm7hkMPDoBxTOtVVagruuK90wUBiMc
	 +H6HMGoRDRm+MUEoB9gukNIUuMReEiEeLMr7W2KBqa6KsTA421hZOG9imiOEKaLG+gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M7vrqsYf;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7191B606A321;
	Tue, 10 Nov 2026 19:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7191B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M7vrqsYf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794338888; x=1825874888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Tk7wzXU45kue3dYmskygRpZWfROmf4iDPW1IaUfcEc=;
  b=M7vrqsYf1JvJBbmUl617wW57MFlc03Ne6NMmKjNzym3yghTUidqRw9SX
   GrrmBiy0UGoBXMdlP4Ov2tqrqrc3ldoyZdSZuNXLxLgMJWbMogV1xrf4i
   WWUXLi1+iv0xVz3AHkFrRWmYWkC1qP7jIbEBjLbjgHNTkP8DAE7usZUDV
   aJTVi/lMe0A7KsRLO47mactWcAfpG33QR/2J83VX/BomX8ge7jt6nb5Yc
   d1zkBeUT83I7jYYQKpfhSILI90ipt4KTDWNnsHxStW/C1UrB1dOtRK6W7
   K37UaCTCETGANIR9Jy6GYllxegqCAbuFIlOqvXaC5L4yeT9ukRoddKTSK
   A==;
X-CSE-ConnectionGUID: +cHu3qUvTuq17jHVj1LD7Q==
X-CSE-MsgGUID: gDGvfLscSYSWNnwacmsLaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3015868"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3015868"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 11:28:07 -0800
X-CSE-ConnectionGUID: xAku1fccToutxOEitshrqw==
X-CSE-MsgGUID: FozGz7xzQXOFK/5Xdus7Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8816957"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 11:28:03 -0800
Date: Tue, 10 Nov 2026 21:28:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: netdev-bot+sashiko@kernel.org
Cc: liuc63@xiaopeng.com, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	khtsai@google.com, fangxy@xiaopeng.com, rdunlap@infradead.org,
	dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 2/2] usb: gadget: u_ether: fix out-of-bounds read in
 get_ether_addr
Message-ID: <avNwQFNAh7mEEegd@ashevche-desk.local>
References: <20261106030605.576584-3-liuc63@xiaopeng.com>
 <179431528770.994134.4467102794206412303@kernel.org>
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
In-Reply-To: <179431528770.994134.4467102794206412303@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 12:54:47PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.

[ ... ]

> > The notations that keep working are the byte pair ones, ':' and '.', in
> > any mixture, and the separator-less "aabbccddeeff".  What stops working
> > is the Cisco notation "aabb.ccdd.eeff" and irregular groupings such as
> > "123456:789abc", which the old loop only accepted because it skipped a
> > delimiter wherever it happened to find one.  Supporting them would need
> > a parser per grouping, so such input now falls back to a random address.
> 
> [Severity: Medium]
> Is the "falls back to a random address" part accurate for configfs?
> 
> It holds for the legacy module parameters, which reach get_ether_addr()
> through gether_setup_name(). The configfs path goes through
> gether_set_dev_addr() and gether_set_host_addr() instead, and both throw
> away the random bytes:
> 
> drivers/usb/gadget/function/u_ether.c:gether_set_dev_addr() {
>     ...
> 	if (get_ether_addr(dev_addr, new_addr))
> 		return -EINVAL;
>     ...
> }
> 
> The store handlers generated by USB_ETHERNET_CONFIGFS_ITEM_ATTR_DEV_ADDR and
> USB_ETHERNET_CONFIGFS_ITEM_ATTR_HOST_ADDR in u_ether_configfs.h return that
> error to the writer.
> 
> "echo aabb.ccdd.eeff > functions/ecm.usb0/dev_addr" used to succeed. The
> old loop skipped the '.' and produced aa:bb:cc:dd:ee:ff. Now
> parse_mac_pton() fails the length check and hex2bin() fails at the '.'.
> The write therefore returns EINVAL and the attribute keeps its old value.
> "aabb:cc:dd:ee:ff" behaves the same way.
> 
> The message also names only ECM and NCM. The same macros are used in
> f_ecm.c, f_eem.c, f_ncm.c, f_rndis.c and f_subset.c. All five are
> documented in Documentation/ABI/testing/configfs-usb-gadget-{ecm,eem,ncm,
> rndis,subset} with no format restriction.
> 
> Could the commit message describe the configfs behaviour change and list
> all five affected functions?

Okay, what I think the v5 of this patch has to do is to update
the entire documentation where the patched function is used.
It should clarify the accepted formats.

> [Severity: Low]
> Should this still carry a Fixes: tag?
> 
> The function this patch changes, get_ether_addr() in u_ether.c, was
> introduced by commit 2b3d942c4878 ("usb ethernet gadget: split out network
> core"), and that commit is in git. The usual convention for bugs older
> than git is also available:
> 
>     Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> Cc: stable was dropped in v2, and there is no Fixes: tag either. Stable
> tooling has nothing to match on, so the out-of-bounds read from
> "insmod g_ether.ko dev_addr=ab" stays in all maintained stable trees.
> 
> The fix also depends on parse_mac_pton() from the preceding commit
> "lib/net_utils: allow mac_pton() to take a custom delimiter".
> 
> Would a Cc: stable with a dependency note, or a separate minimal fix for
> stable, help backporters here?

Yes, the Fixes to official Git era that starts with v2.6.12-rc2 is fine to have
while leaving the free form of the pointer to the actual commit that introduced
the function.

> [Severity: Low]
> This isn't a bug today, but the kernel-doc for parse_mac_pton() added in
> the preceding commit "lib/net_utils: allow mac_pton() to take a custom
> delimiter" says:
> 
>  * @s must be MAC_ADDR_STR_LEN characters long and use a character from
>  * @delim at every separator position, e.g. "aa.bb:cc.dd:ee.ff" with ".:".
>  ...
>  * Return: true on success, false if @s is malformed.
> 
> The implementation only rejects strings shorter than MAC_ADDR_STR_LEN and
> ignores everything after the 17th character.
> 
> This caller depends on that prefix-only behaviour. The configfs store
> handlers in u_ether_configfs.h pass the raw page down, and it normally ends
> in '\n':
> 
> _f_##_opts_dev_addr_store()
>     gether_set_dev_addr(opts->net, page)
>         get_ether_addr()
>             parse_mac_pton(str, dev_addr, ".:")
> 
> So "echo aa:bb:cc:dd:ee:ff > dev_addr" passes 18 characters to
> parse_mac_pton().
> 
> Suppose the helper were later changed to enforce the exact length that its
> documentation describes. Wouldn't every colon notation configfs write then
> fail with -EINVAL? The hex2bin() fallback would not help, because it
> rejects ':'.
> 
> Could the kernel-doc say that only the first MAC_ADDR_STR_LEN characters
> are checked? Alternatively, could this caller strip the trailing newline
> itself?

Yes, this was already mentioned in the previous patch, the kernel-doc
should be amended.

> [Severity: Low]
> Can both branches still silently accept an address with extra characters
> after the MAC?
> 
> parse_mac_pton() only enforces a minimum length:
> 
> lib/net_utils.c:parse_mac_pton() {
> 	if (strnlen(s, MAC_ADDR_STR_LEN) < MAC_ADDR_STR_LEN)
> 		return false;
>     ...
> }
> 
> It never looks at s[17] or beyond. "aa:bb:cc:dd:ee:ff:11",
> "aa:bb:cc:dd:ee:ffff" and "aa:bb:cc:dd:ee:ffZZZ" all return true.
> 
> hex2bin(dev_addr, str, ETH_ALEN) consumes exactly 12 hex digits and returns
> 0 regardless of what follows. "aabbccddeeff0", "aabbccddeeff00112233" and
> "aabbccddeeffzz" are all accepted as aa:bb:cc:dd:ee:ff.
> 
> In each of these cases get_ether_addr() returns 0, gether_setup_name()
> marks the address NET_ADDR_SET, and the configfs store reports success.
> 
> The commit message says parse_mac_pton() "checks the length", but that
> check is only a lower bound.
> 
> Would it make sense to require str[17] in the delimited case, or str[12] in
> the raw case, to be '\0' or '\n'? A single trailing '\n' has to be allowed,
> because the configfs store passes the raw page buffer from echo.

I think this also needs to be "checks the minimum length" in the documentation.
The original code IIRC doesn't prevent the input be restricted by exact number
of characters.

-- 
With Best Regards,
Andy Shevchenko


