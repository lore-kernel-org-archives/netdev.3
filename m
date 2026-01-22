Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E051F4611;
	Thu, 22 Jan 2026 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083596; cv=none; b=N3KBotrR3hFlMOZXztwO0WwpWzSZDK66YGWDDxxPJksr+TP4pR3345fAMpsVurlGmMx+8KtH2uhPvGL0ugw+E53XZpYaqAVX63ey5IBwHr8khbZAkETkoV7OgbNj+2OOgovBIaxR8aXQW1wR/yZKPC3klwIGLJgmzTF+AceaMJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083596; c=relaxed/simple;
	bh=JTVz6R+VCRUISvCJ3ZucfF6TRHe+SaS+E+rhgH6fMpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=st/lt/SGmbY1NtXdft6zGz9dbdTbUTpcXTaWWcA3bjKOihxyvBe1z5J5YVmOjdHLAfK7VwNxo4ZLvIoBcPUvuuf/LmUhTIBeZSyCZdbuHlPwLyGutqRrnFmJBk3KP99a+23A3t3MQipSlIq8SUgZ9bzol7mAxdhTtihAL1P21NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ScRRWpab; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ScRRWpab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769083592; x=1800619592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JTVz6R+VCRUISvCJ3ZucfF6TRHe+SaS+E+rhgH6fMpc=;
  b=ScRRWpabv1mceMIxZO7kL/CW0EzVCM8z6xpLilKO5QN1/l5UezNu5uIv
   eQWu/t2G7SN+pBbpowSZyAqN4s/JRx2WDlcaI8lQ8A8EWRPZQXU7FOl5t
   R1MaVDcySyRHXHMjDEMK/Cxs03dCkJE+y1Z9bJEQ7G3zZwzqwlcgKjVcy
   0KQLU6Qr4jCPCpC5vlx/7NU3Vf0kKen6wdEpWn9gy5ARnAKVZdOpM8KGs
   L+y1OfCJnYCgJMfBWI296bFvbjrbowCch24dyjXGGPW/8wPwpYlzxvBkO
   rT4cIVD8NiO/Jjwe4SrJRf2x4+XEay0A/T2oLeJ2MKJkQdokrB/ekR18u
   Q==;
X-CSE-ConnectionGUID: wUgO3qW9TuqvOINY9aBeIA==
X-CSE-MsgGUID: JPLVVlZOQi6MV9zHq9GEOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70231050"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70231050"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 04:06:31 -0800
X-CSE-ConnectionGUID: +aJYAhtVRM6pxvea3i9K3w==
X-CSE-MsgGUID: j/nQnV0BQx+Y/g2bpTPARA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="237977397"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 04:06:25 -0800
Date: Thu, 22 Jan 2026 14:06:23 +0200
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
Subject: Re: [PATCH v2 net-next 01/15] net: mdio-regmap: permit working with
 non-MMIO regmaps
Message-ID: <aXISv3Acm1v6yS4V@smile.fi.intel.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122105654.105600-2-vladimir.oltean@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 12:56:40PM +0200, Vladimir Oltean wrote:
> The regmap world is seemingly split into two groups which attempt to
> solve different problems. Effectively, this means that not all regmap
> providers are compatible with all regmap consumers.
> 
> First, we have the group where the current mdio-regmap users fit:
> altera_tse_main.c and dwmac-socfpga.c use devm_regmap_init_mmio() to
> ioremap their pcs_base and obtain a regmap where address zero is the
> first PCS register.
> 
> Second, we have the group where MFD parent drivers call
> mfd_add_devices(), having previously initialized a non-MMIO (SPI, I2C)
> regmap and added it to their devres list, and MFD child drivers use
> dev_get_regmap(dev->parent, NULL) in their probe function, to find the
> first (and single) regmap of the MFD parent. The address zero of this
> regmap is global to the entire parent, so the children need to be
> parent-aware and add their own offsets for the registers that they
> should manage. This is essentially because MFD is seemingly coming from
> a world where peripheral registers are all entangled with each other.
> 
> What I'm trying to support are potentially multiple instances of the
> same kind of device, at well separated address space regions.
> 
> To provide isolated regmaps for each child device would essentially mean
> solving the problem of how would each child device needs to find the
> correct regmap. This further means that "dev_get_regmap(dev->parent,
> NULL)" transforms either in:
> - dev_get_regmap(dev, NULL): search in the child device's devres list,
>   not in the parent's. This means adding the regmap in between
>   platform_device_alloc() and platform_device_add(), but is
>   structurally impossible because &dev->devres_head is initialized way
>   too late, in device_initialize().
> - dev_get_regmap(dev->parent, "unique-regmap-name"): now the child
>   device needs to know, in case there are multiple instances of it,
>   which one is it, to ask for the right one. I've seen
>   drivers/mfd/ocelot-core.c work around this rather elegantly, providing
>   a resource to the child, and then the child uses resource->name to
>   find the regmap of the same name in the parent. But then I also
>   stumbled upon drivers/net/pcs/pcs-xpcs-plat.c which I need to support
>   as a child platform device, and that superimposes its own naming
>   scheme for the resources: "direct" or "indirect" - scheme which is
>   obviously incompatible with namespacing per instance.
> 
> So a parent device needs to decide whether it is in the boat that
> provides one isolated regmap for each child, or one big regmap for all.
> The "one big regmap" is the lowest common denominator when considering
> children like pcs-xpcs-plat.c.
> 
> This means that from mdio-regmap's perspective, it needs to deal with
> regmaps coming from both kinds of providers, as neither of them is going
> away.
> 
> Users who provide a big regmap but want to access only a window into it
> should provide as a struct mdio_regmap_config field a resource that
> describes the start and end of that window. Currently we only use the
> start as an offset into the regmap, and hope that MDIO reads and writes
> won't go past the end.

> Cc: Mark Brown <broonie@kernel.org>
> Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>

FWIW, Cc list may be located after --- line. It will have the same effect on
emails (as regular tooling will parse and put them into email headers), but
will reduce unneeded noise in the commit message. List will be still available
on lore.kernel.org in the mail archives.

> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---

  Cc: ...
  ...

...

>  struct mdio_regmap_priv {
>  	struct regmap *regmap;
> +	unsigned int base;

Hmm... resource_size_t ?

>  	u8 valid_addr;
>  };

-- 
With Best Regards,
Andy Shevchenko


