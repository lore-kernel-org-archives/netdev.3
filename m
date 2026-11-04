Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783077;
	b=uqZRUWMPOEN9hllw06IlxrkPinUoikTfqzKKZuz4AneVBKDlTRx09/eb6Be/DIdJ4gSL
	 56azuKO0DokEgVZr3vhmEJXML4uQGAFErQLxm225pyxXst5FSAJKfBumnhtdDvt0L76Lp
	 8kBTEVeQk2u/ZElKDVSE/KXw27RPln4XDI3QFQDH8U8oJEFvfMRHIQKpUs/JenUPijXHk
	 WsIdDOFbYYQ7shjeo/Ii9+EJua6H1Nhq6zGiq3LA5TKOIi/MzEXmQ+mfOl9qzoA0Q3ouv
	 ONHn5ngClndAWDuOrg8zuV6bIbPu7fDycoWAxjWF0wUqeW+pYmRNJG0nAhLBhfJhKuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783077;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Yi6uSUZH/rRvO4dc8qtfm+oA6mubW8QBOCH28tEKExo=;
	b=iMSDkM5DUP+gtkJz7B7Eix7bfMOJ/9jfS+BneGU87wsA+n6UpDv6n3T7UnmDZyN9/Rc0
	 PFtgmnL490slxtlVZJ1LhSX8C2Hdl2HJ2WecWoLc53EGCkuHgd5TmfVgCXiG7hNXz83Ih
	 iy2AQvmACnGEwIs9rzgUWRlk54AvI/M+TWgr+Yjgdz3kncv+x+Bv69QyPqB30UJImyCf0
	 ZeZxjF3CSYUPVD6KjXp2/djkzsCgpXcyAL0WU3MgZ1JCqpBkVyJ9X0no0/9TJzPfqUcFH
	 NB+T9cihZ+Uhn/LgUWD9xAA9tVSrxaU8oLt470S1cnwqrzFl7H3OEbuALQ371Mmh+3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=klg9zMBD;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AFA606A328;
	Wed,  4 Nov 2026 09:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20AFA606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=klg9zMBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793783077; x=1825319077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t8cJaf6alrVXE44hj9mQKJqj29+9TVluofn8Kon4sL8=;
  b=klg9zMBDxudzSYw8lIkmy1aXwVTaOmfH7gmDwddqZopVRI9kkD4+e6/Z
   1tgJPT8HqDP+4uVmRH9f83u4HLCou81vIWX99svoveehzQLT+qpxSXec6
   98/RoAdMGyStaT+WFQv8+dRTva+PZnqrKsdrNDTfntfvok5Lffs/Tla6h
   k2DyazoX2+cMHCntjeaCdnbrYop6HMb5o3mCXKPjJcW6VbKqmEpEHQQkE
   YuOQAz4gySlIFRsohxqD6XOfp/lmrHttBG/3KZX9mK/BMQGadC1B/i3cz
   qBOAOqB6fIu52WYNIOcxbahQN82y5uTuhS3wy/s6fXTLA67xJN1fk8NCd
   Q==;
X-CSE-ConnectionGUID: m4FwuLt3RqmuBJQ4wRAWcA==
X-CSE-MsgGUID: BsRzQy+HR4a7snb/coIbIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2560604"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2560604"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 01:04:36 -0800
X-CSE-ConnectionGUID: 6qQSRYk2Sl+6FINxHbSa3g==
X-CSE-MsgGUID: 2sb06OhQSOuQLClbM+8xUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6551391"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 01:04:33 -0800
Date: Wed, 4 Nov 2026 11:04:30 +0200
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
Subject: Re: [PATCH v2 1/2] lib/net_utils: allow mac_pton() to take a custom
 delimiter
Message-ID: <aur1Hqd53BXKgWQu@ashevche-desk.local>
References: <20261104025058.2650911-1-liuc63@xiaopeng.com>
 <20261104025058.2650911-2-liuc63@xiaopeng.com>
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
In-Reply-To: <20261104025058.2650911-2-liuc63@xiaopeng.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 10:50:57AM +0800, Liu Chao wrote:
> mac_pton() hardcodes ':' as the only accepted separator, which pushes
> callers that need a different notation to open-code their own parser.
> 
> Split the body out into parse_mac_pton() taking the set of accepted
> delimiters as a string, and turn mac_pton() into a static inline wrapper
> passing ":" so that every existing caller keeps its current behaviour.
> The strnlen() guard still runs before any delimiter is inspected, so
> strchr() is never handed a NUL character.
> 
> No functional change intended.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Exactly what I had in mind, thanks!

-- 
With Best Regards,
Andy Shevchenko


