Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CDB3911CE
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623233; cv=none; b=ktBO2z1YVE88XQyWf81dS8lqMuWzIcHDklI5K/0Iux5N7lhQtafmIFGzMW7Xp/9DdgIMhscyLKap3W+ORIQnn53Q2yYKvU3BybEtglIswtIq59Kw2TxfY+nMOUM3BLbryrqKdRQsxJNqAVlR6oxCAQCvkZAWcYaUjVTa9LqYHjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623233; c=relaxed/simple;
	bh=N/fNl0STMVXOM7MK04jg30opbHmwh+0fTTdIVc/7fus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAgwCxftuhkWVvolgI/m8EM7INWfu3FCbYuK6fd5C3FT3iuvHCfjMrSG07ehXTYt5MRrrn7OZApsNcRl6NCHzEhYpsvXeIHXqjrFfaTAHUZYYipVqXsgGgMsb2e0xkBudxx5dTgnVJ8rlkVNQcM1bC/Tu8ZnEhFakFdDZ+5uOVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuXKJagF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuXKJagF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784623232; x=1816159232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N/fNl0STMVXOM7MK04jg30opbHmwh+0fTTdIVc/7fus=;
  b=OuXKJagF22GDWx6zEkGqNM6xtoMC7OpqeH8RpKPzTgB+DKglVeW1yFKG
   oZCnaEVY866vvTiHu3BbAFGh6HXTPcCvBeMmgfWlfVTv16CVOaa9dlAHH
   YinrmEXtGHFwPJA/HlSIV2jZJLinMp1t2ASGQw49WSn5fdNKhL1dqxGmd
   fQbmo1siTfESI0U0id7EN52k3O4hp65wROPvh1JRsNZn03P3chxfsu+b8
   0XqOZD9CJ9dSHFOYZXar8aDOSS1khZMR93d+SG0yY7CJRAO6pjwub/UMg
   vUR7xtHKfPMHVZSYzZ6VwfoXjmnqoB/gLSlOODENwES6EOk+ihsUb2VXC
   w==;
X-CSE-ConnectionGUID: JUCjf0KeS2OyXKvGPGBXEg==
X-CSE-MsgGUID: 6JYuqvEeRvSJHYTAHnzQ+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85254398"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85254398"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 01:40:31 -0700
X-CSE-ConnectionGUID: e/CK7lyuT3O1nnzdQjmSHw==
X-CSE-MsgGUID: EAgF+5zjS+6G7Mbr4hNBXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="257765400"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 01:40:27 -0700
Date: Tue, 21 Jul 2026 10:40:23 +0200
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
	soham.purkait@intel.com
Subject: Re: [PATCH v5 3/3] drm/xe/xe_ras: Report uncorrectable error events
 to userspace
Message-ID: <al8wd1fN43vkVVPR@black.igk.intel.com>
References: <20260720082208.2648279-5-riana.tauro@intel.com>
 <20260720082208.2648279-8-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720082208.2648279-8-riana.tauro@intel.com>

On Mon, Jul 20, 2026 at 01:52:12PM +0530, Riana Tauro wrote:
> When the firmware reports uncorrectable errors in response to an AER
> interrupt, deliver a drm-ras error event to userspace for each affected
> component. Multiple errors for the same component within a single firmware
> response are collapsed into one event to avoid duplicate notifications.

This one too can reuse the patch 2 kindness but I'll leave it to your
mercy.

Raag
