Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2FC378824
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 06:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788893; cv=none; b=AbvpkP2lPm6GOEi5xCorYCFeNVOHwkpFBlRb2Wkhl9/x/0JW/QPUuITNe2EzWUrN9Jl/Bg/rEv5LEhv+s9WgwPORZKp2uhBZT5Q7mpmVq+kKem9nAUyoFlTNIin3n8rbXrypofGRGqQKQqAzLIXuM0hLrHNqNwhtZ8KWCmFoxyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788893; c=relaxed/simple;
	bh=dndr+Q7ZbdWNVlT+QLoBDH1fcE11CMP/4FK8lYK2cI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVv8VmaKUT9QMiqW5Oi7L5AZAvPurG44f/49gusws/i7esEF3PhIMCgRWPIVU5KXYerhS1D36NL9YZSe3NJJBSwF8AdaEGmrmYFjSQSU6w1ypdPMt67X+zWFzUQrO1B4RRfK5pPiMyyY+w04djxKehy2iA833Fm12mFyk6le2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIUR9kBi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIUR9kBi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784788892; x=1816324892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dndr+Q7ZbdWNVlT+QLoBDH1fcE11CMP/4FK8lYK2cI4=;
  b=DIUR9kBijFMWZ1/RBK6UiJTUkE4ZY9gNuskVUZCn6bP7qEAkfIffsj1x
   X3zu/hAKLtw4AjgXGowX3oLLobBclrGQ5um3LOOr5A0klU4sv45beXXHx
   KVVh7R4SW+BiwJ4+PSPlksphedWQgiWfwyasM80tE8ZhoM3tDnbyp0TcT
   6i0CNgEHt3wZDQTXPPG6/qd9DqrLpDjy+WLia4nTLcXIIZPyaibSJE84b
   7Wv8GBREa+nb79U3h+LkSkxCnfxyo+Xlsl2muKBjXrd6hE3X7On+1Aa82
   VUBBPMcje6pf6yFaxNKyuEP4C3GDpZPYq6BYSEciltDbLxbuYW8H5ML/s
   w==;
X-CSE-ConnectionGUID: 6y/qJXn/SQS4CQogJxZ7VQ==
X-CSE-MsgGUID: M3UNdFRiToyT01K/RioGiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85555162"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="85555162"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 23:41:30 -0700
X-CSE-ConnectionGUID: iyLNOZPCQN2e165/5ark1w==
X-CSE-MsgGUID: F6r60qe8TOiEeLgGB9fBrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="288321794"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 23:41:26 -0700
Date: Thu, 23 Jul 2026 08:41:23 +0200
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
	Michal Wajdeczko <michal.wajdeczko@intel.com>
Subject: Re: [PATCH v6 2/2] drm/xe/xe_ras: Report correctable/uncorrectable
 error events to userspace
Message-ID: <amG3k8dNCJb_tHxT@black.igk.intel.com>
References: <20260722094134.3036087-4-riana.tauro@intel.com>
 <20260722094134.3036087-6-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722094134.3036087-6-riana.tauro@intel.com>

On Wed, Jul 22, 2026 at 03:11:37PM +0530, Riana Tauro wrote:
> When an interrupt is received for correctable errors indicating that error
> counter has crossed its threshold, read the current counter value and
> deliver a drm-ras error-event to userspace for each affected component.
> 
> Also send drm-ras error-event to userspace for uncorrectable errors on
> receiving an AER.
> 
> To avoid sending duplicate events when the same component appears multiple
> times in the response, Send the error-event once per component.

...

> +/**
> + * xe_drm_ras_event() - Report drm-ras error event to userspace
> + * @xe: xe device structure
> + * @component: error component (see &enum drm_xe_ras_error_component)
> + * @severity: error severity (see &enum drm_xe_ras_error_severity)
> + * @value: value of error counter
> + *
> + * Report an error-event to userspace.
> + */
> +void xe_drm_ras_event(struct xe_device *xe, u8 component, u8 severity, u32 value)

Forgot to add. Looking at the existing xe_drm_ras code, this should be

void xe_drm_ras_event(struct xe_device *xe, enum drm_xe_ras_error_severity severity,
		      u32 error_id, u32 val)

but can be done as follow up.

Raag
