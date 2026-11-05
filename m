Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880815;
	b=pdL1V7oNr5F1Fd9vNFTOS7/jyeRSEDJfezXion/VZQSV/i4p13YO4KMd63sugtLmT6CU
	 l/qjRu5FPYmRa/RvxZMSSv1o/Jz2nJEMlCPUShJKXJMo2Y4y9vyQ10l607pQJwowJt39C
	 AwuvKxf35tc+JA5py8nO5PzwaGGka8GvLO5I+J4g9Iunas4nUohp6qeIjXFEUSyVlZZ2x
	 eZgH3qZqXQ2z6zt/SoA02z+SEl7Di0SnGcS1m8X6Ep0/IAuwftc1Yj+r+TvbzsshLcpmn
	 02HxHJrVoNCV2L1ZNPkOzTV0a8p2GWEYWI0qyDxw6o+o+NBarIh4Y3kg3JekXLU6Myg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880815;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=pksQ9ydEkR7hKW9OrSgdMPBgmVI8kSXRvLVcfHzAEyM=;
	b=v3DMorVsv+pWxRfUdFWKaEh/01wPLsuN/UJlPpXrx+sEcUEwpyzhascxef075UmAPIe5
	 Gdi18Z9xKYAuRi66EVIA3v2yapBGkK1DaNaDa9sFxARe8NQdO01zsn92uNyLMFesjasYl
	 9NXmRWXMImBw0iazT5RV7zhPHzkZJ/owQKqYPv6AKGy06s+NLFSc4GPPE4Htbjrw5GNlv
	 kgftVEup7ryRhpypiLinO0JBjAuOdMp8KAX4L8kcAxo8PWKKEp3C9H9bcrkR6SXD2URAe
	 HFsxzDkZgm1iRmINPCmCp93PfBslTmXMTxNARFI3GylqYrjCT8mmdROGWh4AElCW+bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=da95RKeT;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE56606A328;
	Thu,  5 Nov 2026 12:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EE56606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=da95RKeT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793880812; x=1825416812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t3q41Lk1t46q2jZPidQXOdV2YqSwsGH1AhoLFZlB4CA=;
  b=da95RKeTEpMvZMEVHskSLyglwhMS0JUCTpmtctfnJIsiQxxrihlotWAK
   HzRGLvnDVb8MqxFUx6jYEcjZ6V99iPSA9Cv8p7zLL0LbhkVG7wrvbw3SS
   N3CVJFjr1z6thTylqem5g/QkfwcT0TJoo4JOCd4qQ0txcDTAozNX8H+eT
   Qup94QSINuYMLxnrh1BPB1vJTW87KIHyPYsjcwDO7hub1+jYRRC78q1IJ
   gCR/6t4OP1u6oZzDlfqU62lCYFekmW56f/5uS1nqTe2vvgYg6vVINdtbo
   jUE5rS2L+LljWq355pGzYZoDU4C5rCBhR7U9AVyXixWcC1gPopUgg5u1W
   g==;
X-CSE-ConnectionGUID: T5zGxJ8bRdOLHv5T6akIBg==
X-CSE-MsgGUID: oKOAcvuRQyC7utg0dC8H2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2682943"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2682943"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 04:13:31 -0800
X-CSE-ConnectionGUID: YgrG8tPaS2aKgHC7GT0JFg==
X-CSE-MsgGUID: yu5E/HkqTs+AO3j/zKQz/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7302217"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 04:13:28 -0800
Date: Thu, 5 Nov 2026 14:13:25 +0200
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
Subject: Re: [PATCH v3 2/2] usb: gadget: u_ether: fix out-of-bounds read in
 get_ether_addr
Message-ID: <auxy5cmALpy0AMzu@ashevche-desk.local>
References: <20261105072147.3383565-1-liuc63@xiaopeng.com>
 <20261105072147.3383565-3-liuc63@xiaopeng.com>
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
In-Reply-To: <20261105072147.3383565-3-liuc63@xiaopeng.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 03:21:47PM +0800, Liu Chao wrote:
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
> gether_set_host_addr().  Their store handler passes the whole configfs
> buffer on, so an overrun there stays inside the same object and is never
> reported, but a malformed address is silently accepted all the same.
> 
> Replace the open coded loop with parse_mac_pton() for the delimited
> notations and hex2bin() for the raw one, and keep the existing
> eth_random_addr() fallback for everything both of them reject.
> parse_mac_pton() checks the length and every digit before writing
> anything to dev_addr, and hex2bin() stops at the first character that is
> not a hex digit, which the NUL terminator is, so neither reads past the
> end of the string.
> 
> The notations that keep working are the byte pair ones, ':' and '.', in
> any mixture, and the separator-less "aabbccddeeff".  What stops working
> is the Cisco notation "aabb.ccdd.eeff" and irregular groupings such as
> "123456:789abc", which the old loop only accepted because it skipped a
> delimiter wherever it happened to find one.  Supporting them would need
> a parser per grouping, so such input now falls back to a random address.

It is worth to mention that the occurrences of use those formats
(Cisco and irregular grouping) are more historical and rare to meet these
days.  Also point out that the original commit didn't explain the choice of
implementation, most likely it was just for simplification and not really
allowing non-standard formats to be used.
(So, some kind of summary of our discussion in v1 round.)

> Select GENERIC_NET_UTILS so that parse_mac_pton() is built in.
> 
> The loop is older than the git history: it is already present in
> drivers/usb/gadget/ether.c in commit 1da177e4c3f4 ("Linux-2.6.12-rc2")
> and was copied into u_ether.c by commit 2b3d942c4878 ("usb ethernet
> gadget: split out network core"), hence no Fixes tag.

As I pointed out, you may use the correct SHA, but you need to point
the readers out to the history.git tree.

Code wise LGTM, so after addressing the commit message and reference
to the culprit commit, feel free to add

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
(with all awareness of the potential weirdness of the user input)

-- 
With Best Regards,
Andy Shevchenko


