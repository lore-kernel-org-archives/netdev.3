Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF593191D3;
	Thu, 22 Jan 2026 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093660; cv=none; b=tOPO4pX62j4NUhrCXKqXcViou/vr3m1oMUzpB4DR+imdxu2AmXqK7J5aRAjUdPOiN2frcBjlt/8AA+lh2xt/JUsSwlLXw2a6j+zZujj/vFGFTHVHR2ergr9KYaSF/TLmcgXxtZO03AnfkigmUhlP5oy7BXHJg7YQzNqzPTatkjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093660; c=relaxed/simple;
	bh=1+M2dzkCMBb5JOtsID4HBah1lotmGEXtHbeL5i+Ctg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=samLfo//T/gde4KAtAMDT/NB0UW9DYNpG5hvaDf4xA47vFHXT5kwFB5RUMgClMjNu6/Sl0JeytCCRGB6JL8aLHZbCIoO0R2DM4NGk0QUPIqLkdiy2EI6lAoyqXOD825hUwO9yRS2b6l4btGJNj4U8EZ6H9fMFb2GYqopD9Uebus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbyBv/D4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbyBv/D4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769093658; x=1800629658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1+M2dzkCMBb5JOtsID4HBah1lotmGEXtHbeL5i+Ctg8=;
  b=jbyBv/D49w8/MtduG+r66KFqQJcXpDtJCkZlXIZoSqvlbBzi01/AG5go
   Xus7qxR+ejrFJbm86Cu6thk8lF4VQwJpZClqM6IGPaKU3yvQXHl4+0OjK
   VgJDvRnQWCxrRWhXn+L2+zq2coNDlAQOLHjmYNo1DkHOfImsAmQ8Y/z1l
   ppzt+m9hH8DXzjwWSpeS14+jupHKqSUO2H5wUv736AWv39KM8r4Cs7c6o
   xQn4wmdTz3MtbCObQqlp3MnT5CguZreyZLSVlnU6/5qBGBAzXI9L393ZC
   LWiVGKpy9ux/3kbHzEHXmMt7rJlvDh9pXybAUW7EdafEEB4m5E5z3f2Yb
   A==;
X-CSE-ConnectionGUID: k1d21RSGQ+W+IbsVtBPckA==
X-CSE-MsgGUID: uhVkPBYWQB+4wij/03359A==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="69530959"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="69530959"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 06:54:17 -0800
X-CSE-ConnectionGUID: tqBZPYoGT/y7ymjYQMI30Q==
X-CSE-MsgGUID: HWlBNE5QSCu7l+04EYZNIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211204365"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 06:54:13 -0800
Date: Thu, 22 Jan 2026 16:54:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 net-next 04/15] net: dsa: sja1105: prepare regmap for
 passing to child devices
Message-ID: <aXI6E4-n25aYn-0y@smile.fi.intel.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-5-vladimir.oltean@nxp.com>
 <aXIWttaIcR-yq0nx@smile.fi.intel.com>
 <20260122134245.i5rocwklpcauk3hw@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122134245.i5rocwklpcauk3hw@skbuf>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 03:42:45PM +0200, Vladimir Oltean wrote:
> On Thu, Jan 22, 2026 at 02:23:18PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 22, 2026 at 12:56:43PM +0200, Vladimir Oltean wrote:

...

> > > --- a/drivers/net/dsa/sja1105/sja1105.h
> > > +++ b/drivers/net/dsa/sja1105/sja1105.h
> > 
> > >  #include <linux/dsa/8021q.h>
> > >  #include <net/dsa.h>
> > >  #include <linux/mutex.h>
> > > +#include <linux/regmap.h>
> > > +
> > >  #include "sja1105_static_config.h"
> > 
> > It looks to me that somebody missed grouping above (not this change) and it's
> > better to have it done:
> > 
> > #include <linux/dsa/8021q.h>
> > #include <linux/mutex.h>
> > #include <linux/regmap.h>
> > 
> > #include <net/dsa.h>
> > 
> > #include "sja1105_static_config.h"
> 
> That somebody would be me, but I don't consider this a relevant change
> for this patch set.

While it's true, this patch already adds blank line which suggests that the
author (would be you :-) has something like grouping in mind. Otherwise just
place a new one before net/* which might be more logical in accordance with
your justification (of not doing grouping here).

But I'm not going to fight to death for this :-) Your choice!

...

> > > +	rc = devm_sja1105_create_regmap(priv);
> > > +	if (rc < 0) {
> > > +		dev_err(dev, "Failed to create regmap: %pe\n", ERR_PTR(rc));
> > > +		return rc;
> > > +	}
> > 
> > Hmm... Perhaps return dev_err_probe(...); ?
> 
> I never understood the point of dev_err_probe() when you know the return
> code can never be -EPROBE_DEFER.

i) Smaller code; ii) no need to care about: a) deferred probe cases;
b) -ENOMEM cases.  I see only benefits here by using it.

-- 
With Best Regards,
Andy Shevchenko


