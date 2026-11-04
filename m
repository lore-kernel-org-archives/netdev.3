Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787730;
	b=fRJuxDxZO++4JSmkOGfEeRIXHRFw1aLQwUWynY6tveepOPpqk/c6bGG97x1JuZqBuLbD
	 QuyeJfd1/2Ac6QYlY103lh4szSRex2kW+wb/amgE2xtpuc4++ScgCl4nSwEk2WjvUQd3F
	 R1JXCF5tZJU+U8EE8dPGd4G9onQ16FuJtyVbOMQBKLVSqgNdq/13+WToMVKwJ6bSBdDuM
	 L1K5zqS+qTqnbEipkFTLpgoSUoLtrs0BSx6eJOD2YGKJII4H0lu+K/Bvfd2ulGrziLGDu
	 /Ws/TxqM1LYCf29VzyqZGjCOrAVf282S6eAyMg7cAZdICDaJAEXLdu7X2/pt1VuMkFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787730;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=8JlT2WFtQQEPD9bV9vXfzxVqL6Fc5wChqZs3jOCuMA4=;
	b=PPT+VYol2XMrM6L/m4aVPX8Jco+jc7OKGIGHdJyimc/Xfv40ogKrHST9MX9dnoiTfa4K
	 ndDzOKqe1dZ49DUZzDCTUw3I0vgnuMOm7lV/1PNWagAVj1p/UHRO0FWklSo62xBuX59GJ
	 sbHoS+pVxjS7e689pG6d/Qek4QSTMYBhdNuPZPAZKC2ZBhGXniPoNirlNNJbKoshWZY7k
	 cfVGjZlcQjQa8gq9zeZ2hG76nOFmMuKu6AI49fZmHLwnTCtjeIrVFm0/ZSaNLXGjBbHRu
	 HVnBPbrGH6eFpGByIASRaiJrew51/BfSPR/28vkKfNquw5ZEik1NSpAlLyg1spqOpjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=auV8UG5C;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F52A606A31B;
	Wed,  4 Nov 2026 10:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F52A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=auV8UG5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793787728; x=1825323728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n/3H2j26OWb0nl3FEmMvVsN3VTQcUIyP2j60OWNMrdI=;
  b=auV8UG5CoD8GWVIUpwU3RVdfkNoPpaeAcPi/2MBbPlWoTtPoEmn7/CXE
   qH9SkeUVnd0lyXg2Q5bt/RDJGtOCnqntlVLs00v5x1Ov6U16tKMinaMhi
   W1elvFSpkZxtJXgIlBz5TU3VC8dhtxgWWt0NTWnszfCQE3F0BOpcNfBd4
   6i2Czhi706YoXbBMxjpAGKRP9DeLvhRIPfRHjk9uXNSpqAmYWlXqwRroN
   Wv1Bw7oY7Ga6vTJ+0eYXNyRP6TqknKFRUztW+ajsCH7YoAJK+IxjqK9qa
   xA/eMWMkwezGJblyRt/sEPmwLJKUN7lIiTuLsfNBzU5+8mU6OmE6qpQ7l
   w==;
X-CSE-ConnectionGUID: bea7kcOsQwK++7gRfPFfrw==
X-CSE-MsgGUID: +lprVKMXS5GtzGTd/99Fcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2631120"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2631120"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 02:22:08 -0800
X-CSE-ConnectionGUID: GFWNVOkcTdady7CHAwh0Uw==
X-CSE-MsgGUID: uUCaORvRTySTCFYXcZlRMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="8452709"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 02:22:04 -0800
Date: Wed, 4 Nov 2026 12:22:02 +0200
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
Message-ID: <ausHSm5voXbEoGjL@ashevche-desk.local>
References: <20261104025058.2650911-1-liuc63@xiaopeng.com>
 <20261104025058.2650911-3-liuc63@xiaopeng.com>
 <ausGsH4Q6IDMMtin@ashevche-desk.local>
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
In-Reply-To: <ausGsH4Q6IDMMtin@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 12:19:34PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 04, 2026 at 10:50:58AM +0800, Liu Chao wrote:

...

> 		bool valid;
> 
> 		/* Try standard format of MAC address */
> 		valid = parse_mac_pton(str, dev_addr, ".:");
> 		if (valid && is_valid_ether_addr(dev_addr))
>                         return 0;
> 
> 		/* Fallback to raw format */
> 	// check, if it correctly handles the case you want to fix here
> 	// I believe it does handle it correctly
> 		if (bin2hex(...) && is_valid_ether_addr(dev_addr))

Of course it should be !bin2hex(dev_addr, str, ETH_ALEN). Alternatively

		valid = bin2hex(dev_addr, str, ETH_ALEN) == 0;
		if (valid && is_valid_ether_addr(dev_addr))
			return 0;

>                         return 0;

-- 
With Best Regards,
Andy Shevchenko


