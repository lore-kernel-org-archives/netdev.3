Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D08B1F91E3;
	Tue, 28 Apr 2026 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397195; cv=none; b=pyLtObr8s9tNM9/w84vGXAPuYA1tn/OL2oXiCe0z5DYaKelnsyscOarzklOZfwfW0irIiLO3fo5iSdMDqAWGCtUmmg1LF+H8Kt5k6RMoO+pG/TeAfYjpYYhN3jkIxJa/EjuACZUxm8Bu9LuX3V7usqlZFrubufmkMKOi1P+03C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397195; c=relaxed/simple;
	bh=SQiGHj32t9iWO6e+9fjO+sP3Q+Qv4qnXT4IQe4UiUtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh9Gw1PwVpo9etiCqzwYwj2bKAT1drqeGT7P+YxI2L1Ri8ODYZYmPkHrPt4EMxvrL7ilWAyzutf3SNrOsf0cCDDg/5VFCKcjwKfuFpSYpqHqC8rLglMaKIsX72wVSd9AH2vmLw7yeyN6uBVfsKSbiLjOa4bsraAWfZQZGGtd7TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0wjbdXK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0wjbdXK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777397193; x=1808933193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SQiGHj32t9iWO6e+9fjO+sP3Q+Qv4qnXT4IQe4UiUtE=;
  b=e0wjbdXKKteUlmZLO7Fisj1xzuc0N0DKjTWykqJbOFiusdlPG3qas4qG
   VkChJEiP6i25FVyWCRGtNl/xoAh0M1tOvKbAsEyBW/kGA3cG3z8PpWEVq
   KLSZB5enQJ+EcOFuUtz8eWD8/vjD5576KDnY1Pg9gscYIWsUFBKmuuTWK
   /JKFmW/pTHD93xj4rKdMRObfGnjIvbIYBUrddRBGcxw4yP6Co44ihkiAB
   JsDJDnM+TXwCvY9iNluMGd7XU6GjecT8VertQbVLNnUw9XN7m6VarNH/U
   YrOETn3QBqBrp/GfzXj+WtekHXjBM27gTArL2qDC3Bmx7uB4IP98hx5Nb
   w==;
X-CSE-ConnectionGUID: wKItaPvtQ3qbXGyAvsCHww==
X-CSE-MsgGUID: NqgzORcKQ822dTCcyTX+Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78376029"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="78376029"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 10:26:33 -0700
X-CSE-ConnectionGUID: 4h1DVRxvTDqiGPe6Te3O3w==
X-CSE-MsgGUID: Rtk1415FTjmJAeYEt5YfIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="231375828"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 28 Apr 2026 10:26:30 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 63F0095; Tue, 28 Apr 2026 19:26:29 +0200 (CEST)
Date: Tue, 28 Apr 2026 19:26:29 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-usb@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 5/9] thunderbolt / net: Let the service drivers configure
 interrupt throttling
Message-ID: <20260428172629.GW557136@black.igk.intel.com>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
 <20260428072209.3084930-6-mika.westerberg@linux.intel.com>
 <a0d3eec7-4c11-404f-804c-fa46515d25fe@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0d3eec7-4c11-404f-804c-fa46515d25fe@lunn.ch>

On Tue, Apr 28, 2026 at 04:59:58PM +0200, Andrew Lunn wrote:
> On Tue, Apr 28, 2026 at 09:22:05AM +0200, Mika Westerberg wrote:
> > Instead of the core driver programming fixed value for throttling let
> > the service drivers to specify the interval if they need this. We also
> > allow user to tune this through a module parameter if the default is not
> > good fit.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/net/thunderbolt/main.c |  7 ++++
> >  drivers/thunderbolt/dma_test.c |  5 +++
> >  drivers/thunderbolt/nhi.c      | 58 ++++++++++++++++++----------------
> >  drivers/thunderbolt/nhi_regs.h |  3 +-
> >  include/linux/thunderbolt.h    |  5 +++
> >  5 files changed, 50 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> > index 49673f7e0055..8771ca807933 100644
> > --- a/drivers/net/thunderbolt/main.c
> > +++ b/drivers/net/thunderbolt/main.c
> > @@ -218,6 +218,10 @@ static bool tbnet_e2e = true;
> >  module_param_named(e2e, tbnet_e2e, bool, 0444);
> >  MODULE_PARM_DESC(e2e, "USB4NET full end-to-end flow control (default: true)");
> >  
> > +static unsigned int tbnet_throttling = 128000;
> > +module_param_named(throttling, tbnet_throttling, uint, 0444);
> > +MODULE_PARM_DESC(throttling, "Interrupt throttling rate in ns (default: 128000)");
> 
> As i mentioned elsewhere, netdev does not allow module
> parameters. They are hard to use, especially when you have lots of
> instances of a device, or you need to set it on the kernel command
> line because by the time the kernel has booted, it is too late, etc.
> And they are undocumented, and every driver does it differently.

Right. This was meant to be a "chicken bit" or "escape hatch" not something
used in daily basis.

I can drop that part from the patch, no problem.
