Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65613AA4EF;
	Sat,  3 Oct 2026 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791038854; cv=none; b=DavrD/TXjgYjMjm15UR2+bXhNpouB+Z4OV1MKBNNua00UtgISNqWadW/5HCr/Q4pehPWI2qvTcas8zmJwX1ZeodMp/O/TABrNlivkoBQKlQIE0stACsqV8sbRhodd0w9PO3FaPUxWhW3vHmRDKECbFBr6UWec2pFFg/TRl6n3GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791038854; c=relaxed/simple;
	bh=mB/dG/SgGk5ffMybraWJ0qYGHriRWch+eYQSWWwj7k4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th1DnFFZ7IHJv7264Uo2wcQPQS00a4rh17ubDK+dZq9iaCj9z3pnr0cfGg+DjcWsgH14QZ8p3Yw2nQ3X6FY98pDMv2pJEQ/UIkPuqsaF4Auldg73y3e6MlsDsy7VJW1GN1zdAdAiwML/l2bW9UiluBZKg5CsO14BOJy/so5qh2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TTvBdKCS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TTvBdKCS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791038852; x=1822574852;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=mB/dG/SgGk5ffMybraWJ0qYGHriRWch+eYQSWWwj7k4=;
  b=TTvBdKCSX+bvSyZ4gbyyOuyvlteWoZhPjN34K1JUW9+oaANMGwLf0rfe
   J0CM3xKioBmNBgzTQsfzlmyTRSxMNNGSFebC9/UmcMbO+x0jfo5Y74U45
   cnqVh5iFAmfp9/BYRURvSia1GwSkHrCSpR2D/kCa+iJhcL+hUkVnPbh8u
   4DeM+WVNyWQLDcXM+Z8o6yV/HJ+CbJzHg/KVxU0vw7TXj3B3cmDGeYl9P
   dChTa8sDM6LNXdPd0NPQxH6KK5IvOiMCpUR1cNOe+KFaD0TcLv/RCI6xb
   gXFmNfbJr3tPCBr4mLfi7QXKgFRvm9Sgm/269oabItGbGXMTgouPqyN3m
   w==;
X-CSE-ConnectionGUID: 5Xep6lpYQCy5rHegGizM0g==
X-CSE-MsgGUID: UcDnCNltTHGLgjBNQrYfhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="101107096"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="101107096"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 07:47:31 -0700
X-CSE-ConnectionGUID: Q5SY4u41QcKuMmly/bPTqQ==
X-CSE-MsgGUID: SyuFaXRfT0yRQU9SSTzL5g==
X-ExtLoop1: 1
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.78])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 07:47:29 -0700
Date: Sat, 3 Oct 2026 17:47:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joe Damato <joe@dama.to>, Andy Shevchenko <andy.shevchenko@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 1/5] eea: Drop temporary buffer by using
 %*pEhp directly
Message-ID: <asEVfjCp3cUAv50m@ashevche-desk.local>
References: <20261002100035.863275-1-andriy.shevchenko@linux.intel.com>
 <20261002100035.863275-2-andriy.shevchenko@linux.intel.com>
 <asAZF53tsdq/QAYv@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asAZF53tsdq/QAYv@devvm20253.cco0.facebook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 01:50:31PM -0700, Joe Damato wrote:
> On Fri, Oct 02, 2026 at 11:59:19AM +0200, Andy Shevchenko wrote:

...

> >  			rep->reply_str[EEA_HINFO_MAX_REP_LEN - 1] = '\0';

^^^ (see below)

> > +			dev_warn(dev, "Device replied: %*pEhp\n",
> > +				 (int)strlen(rep->reply_str), rep->reply_str);
> 
> i have no idea what this otuput could be but i suppose if you wanted to remove
> the terminator write above, you could do:
> 
>    strnlen(rep->reply_str, ....)

I haven't touched original code, which as you see above NUL-terminates
the reply string. So this has no difference with strlen(), but the latter
is shorter (doesn't need an additional argument).

> instead, but that feels like a fairly useless nit so:

Indeed :-)

> Reviewed-by: Joe Damato <joe@dama.to>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


