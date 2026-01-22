Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659529D29E;
	Thu, 22 Jan 2026 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099680; cv=none; b=B58rgPBB6tnBOE062YKZ8slWN5LLF01TU7vY8QPqSbM9gtgDhpbtpP725Vh0ZXSEkKO2fHb2mYiT6Jnyyhmjq7fm33M/LHc5KzmsCar2cy25AJhZM4v2Q1qW6Akrpstue+aa9TirLUVdCCKvIwPyXkVmbBdDBoh18dvS2O6eVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099680; c=relaxed/simple;
	bh=ICOSaMUxWOeV8CMsW7YgfJmE2btAc+ylLFLc9HTkF2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5wqe1P6qDj8u2EIjUtASr/j3OHtOSxaobfMOKUr5lqw4qnrVwyAyAYH2t1CqFJIkCJm1Lq9Uj3wnHlEw991tg3+BZw9mz5nD/Kynp8rTqBWDUmYSEwDlVVFG0iVLg3UXz1LeEIT4+q6FvW8SW2uvRCEXAJj3lMNQdBHBCBBPbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSCco9OU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSCco9OU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769099673; x=1800635673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ICOSaMUxWOeV8CMsW7YgfJmE2btAc+ylLFLc9HTkF2E=;
  b=MSCco9OU4sujNBBbNOXgTqZmtni4xQlASwBxEzMGEVhsafMTxGfN6VC5
   GHwQIC0R8vy0AuZDVduUUZoiqu5e/mQAp1YWEKRSrs8NvCFRjbefKsUbQ
   BjmmWc0fMFIj0DKChqDym30KQJBsQl6P5TSHbkEcADU9F+kho4WDJ8Ms0
   2L7Wx1jbHFsgCRkjNTA0WN0n5Oz1bSDQ0lNpqmoXwdbPYvhfBI5JjJ+Mn
   Gy6Nyvd3tCaO7oWNKmJZqK/Tuvs9f+KPNbtr/KFgLfCDefDxilfgkOi5h
   bWajBsRevH7A8pmt2EcKM9t9/rGoMMNZGEyBeUA+oNPHqT7K5seCIvOZ3
   w==;
X-CSE-ConnectionGUID: 1OKF+G6cRHyti1SS4PyCdg==
X-CSE-MsgGUID: ITGuCPMGTam9iAV+gJqbRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70254659"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70254659"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 08:34:28 -0800
X-CSE-ConnectionGUID: 3/BOsD87TSSDkXJ4s3YWfA==
X-CSE-MsgGUID: 1aoWwdbrSYOWdIPMgzZz8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="244391801"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 08:34:24 -0800
Date: Thu, 22 Jan 2026 18:34:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
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
Message-ID: <aXJRjfeoHZ_TnnxL@smile.fi.intel.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-5-vladimir.oltean@nxp.com>
 <aXIWttaIcR-yq0nx@smile.fi.intel.com>
 <20260122134245.i5rocwklpcauk3hw@skbuf>
 <aXI6E4-n25aYn-0y@smile.fi.intel.com>
 <aXJNtz0i--EZXQUR@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXJNtz0i--EZXQUR@shell.armlinux.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 04:17:59PM +0000, Russell King (Oracle) wrote:
> On Thu, Jan 22, 2026 at 04:54:11PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 22, 2026 at 03:42:45PM +0200, Vladimir Oltean wrote:
> > > I never understood the point of dev_err_probe() when you know the return
> > > code can never be -EPROBE_DEFER.
> > 
> > i) Smaller code; ii) no need to care about: a) deferred probe cases;
> > b) -ENOMEM cases.  I see only benefits here by using it.
> 
> Isn't it also used for /sys/kernel/debug/devices_deferred to report to
> the user ?
> 
> E.g.
> 
> supply-voltage-monitor  iio_hwmon: Failed to get channels
> 
> produced by drivers/hwmon/iio_hwmon.c::iio_hwmon_probe():
> 
>         channels = devm_iio_channel_get_all(dev);
>         if (IS_ERR(channels)) {
>                 ret = PTR_ERR(channels);
>                 if (ret == -ENODEV)
>                         ret = -EPROBE_DEFER;
>                 return dev_err_probe(dev, ret,
>                                      "Failed to get channels\n");
>         }

Yes, that's what I imply by "deferred probe cases".

-- 
With Best Regards,
Andy Shevchenko


