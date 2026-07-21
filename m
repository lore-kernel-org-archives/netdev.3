Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2422BE7DD
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 06:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784613787; cv=none; b=Bij1D1rkhmEAEQ4qyQsFiq1QZ5Gtjs9elGi/sVnAerxMNHceUQTweMKOC92O0GPysbQtSa7Xmja57MdFLLPJRNGvowVmsDXTlYpbpKrru5Hr2MJYftUL6f5hUSlKn1FOF6HBd8D+cEiRgSn3kiHdJSJep1fYj7UUhUuXm+taL9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784613787; c=relaxed/simple;
	bh=oUiLEZWxz0krgAJtw0tElQ84P0GVfJgHVML4fwWkZp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1+2+Y8D7oSqYq4AAGKXJ2hRGqyczq/fiD/H9WCgmmOK5RfO0oIAtHB3neCBm4IfzQsjCmZSE51mDO1HEiwi8+/xwQYqhT4YLHqNdAE0zuezgJhNLVvlto5ICrFl0etBNKe6L5FJZEEZZI/Y+NQ0a0+uGAU4RB1qz7Fn4vY8J/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMF5QxJB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMF5QxJB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784613786; x=1816149786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oUiLEZWxz0krgAJtw0tElQ84P0GVfJgHVML4fwWkZp4=;
  b=WMF5QxJBw25x7i7kWKGT30lNkoV8lxpPOwHiup8Q4B1ovvoHabTYE4km
   cZvezI/5B3bYk4o2FHaKseaUrVunnH4PSPviQY8UoxIETHCCBXFUMD/cc
   RRNxzDck8cwCz+xAwql67rqHSafsv1ZqYhaq8BFH0d0r8NA8DNfMkd+k7
   aCg5k16Y/GfSaJPSwU4Y48m85vlKEwvzSYIx/RA+GzME+0YL+oME1qAnD
   Zf7FBMR/bt+csjgnb/DgHJmx89FALPhYcIrp5pclRsxzfg1PavkXERzm/
   siBbeYcBIBK2pj9pPBRMSPFs+1oXQBDyY5DD7xWfQGGXHtQb1Jvm2P4Sq
   w==;
X-CSE-ConnectionGUID: HSF5OjYbTcOlImxvnLkbIg==
X-CSE-MsgGUID: KNMdw56YRSS3A6sNf2OkJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85147410"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85147410"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 23:03:05 -0700
X-CSE-ConnectionGUID: S3iE7oTOS56QFS9mPBh+pw==
X-CSE-MsgGUID: 0b2SClBgTuWTePuS3ULHhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="257722919"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 23:03:00 -0700
Date: Tue, 21 Jul 2026 08:02:56 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com, kuba@kernel.org,
	simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
	maarten.lankhorst@linux.intel.com, mallesh.koujalagi@intel.com,
	soham.purkait@intel.com,
	Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v5 1/3] drm/drm_ras: Add drm_ras netlink error event
Message-ID: <al8LkE_elgQCxcXk@black.igk.intel.com>
References: <20260720082208.2648279-5-riana.tauro@intel.com>
 <20260720082208.2648279-6-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720082208.2648279-6-riana.tauro@intel.com>

On Mon, Jul 20, 2026 at 01:52:10PM +0530, Riana Tauro wrote:
> Define a new netlink event 'error-event' and a new multicast group
> 'error-report' in drm_ras. Each event contains device name, node and
> error information to identify the error triggering the event.
> 
> Add drm_ras_nl_error_event() to trigger an event from the driver.
> Userspace must subscribe to 'error-report' to receive 'error-event'
> notifications.

...

> v4: send event to all network namespaces (Sashiko)
>     remove has_listeners check

Curious, is it possible to have a has_listeners() that covers all
namespaces?

Raag
