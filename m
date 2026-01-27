Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362CE23B61E;
	Tue, 27 Jan 2026 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769498618; cv=none; b=YkLMpHRugazQPIT0UMY0IpBeK8gkLtl6l6QimxgrBAvNNA79Ju+VdjSnDraapsfupvVShfbq1Xl15ilZKRp3peUzh3a1Da2lM+EkKvwYdLn5br5nEziBqHTinyFOzcdXSm7UIGbyE0cUyDwOqoTp6tSFk64mcsREYb0XU1G2dsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769498618; c=relaxed/simple;
	bh=wyNF7i3+840gDfgZld5/1AhZ7AUFe0KzhH/eftQF6og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dexXGh5BCqOKwn7d2BMXQy9Cb8MQ8rtMHWWGEa6IjdFh9wtP2FFdB7l3F1mFBc8XYOJlOGJWSDQIwCN21aQT8bd6XaPSfpbnTVwO8M0IDARzEFBNEjHtNa6RxQwKFUWsJ3EG534RL9SNgOSUVfleAwm2lHPVjjClRxJbc7uO85s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qy2lFnhv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qy2lFnhv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769498617; x=1801034617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wyNF7i3+840gDfgZld5/1AhZ7AUFe0KzhH/eftQF6og=;
  b=Qy2lFnhvJHjd+/QPTPpulW0pcuXLeOkhGrItpMmgEczyUx4dVWTXVF8v
   4rqZdmmmLWGDnC0G71US5Z4lXcyoKCpoxAUg0o1ljjpSPYAUx0QizLiGw
   qQSYpm1L66dBxVa15STUqU6a0/ga57zCXroNG2xL96einDkv150FJz9uW
   irV7b2yYwXGdnyvbIk6rdE8mL+BdmH1YMYchaXJ2AHOmiqxxuTVUYJStY
   0Ld7FaUypBy/Bye8YzYPr2xyYZijcz0Dp561VWAKPwuyP8gzk7zmn3nYH
   0B0sgfoYVGW3RPFu97ZH+79kJB2rz4Y2sBU1yEj3GzNCgweBQ6N4Uh3tE
   A==;
X-CSE-ConnectionGUID: ZvwMNO3ZQTS/UFKC67oSGg==
X-CSE-MsgGUID: we5accQZQl2sl8wC8aJTlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="80987942"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="80987942"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 23:23:36 -0800
X-CSE-ConnectionGUID: +5JKoZbKT1Sn8iAUlz8Sbg==
X-CSE-MsgGUID: ck8G6BRPR2e+3/0K85ZM8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="212013659"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 23:23:30 -0800
Date: Tue, 27 Jan 2026 09:23:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Petko Manolov <petkan@nucleusys.com>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Oliver Neukum <oneukum@suse.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Max Schulze <max.schulze@online.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH net-next v3] net: usb: remove unnecessary get_drvinfo
 code and driver versions
Message-ID: <aXhn7wefmv32H_w6@smile.fi.intel.com>
References: <20260127060534.51206-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127060534.51206-1-enelsonmoore@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 10:04:38PM -0800, Ethan Nelson-Moore wrote:
> Many USB network drivers define get_drvinfo functions which add no
> value over usbnet_get_drvinfo, only setting the driver name and
> version. usbnet_get_drvinfo automatically sets the driver name, and
> separate driver versions are now frowned upon in the kernel. Remove all
> driver versions and replace these get_drvinfo functions with references
> to usbnet_get_drvinfo where possible. Where that is not possible,
> remove unnecessary code to set the driver name. Also remove two
> unnecessary initializations from aqc111_get_drvinfo, an inaccurate
> comment in pegasus.c, and an unused macro in catc.c.

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Andrew gave you a tag in v1 as well. Why is it not here?

-- 
With Best Regards,
Andy Shevchenko


