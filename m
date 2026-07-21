Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B5A3BB9F3
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623074; cv=none; b=hKSUej7XNaEi5UfHp/G1NNGXaPPi1d6x3pQ4hNUc6Kn5sagH3nmHc505OT/BkkYd0cSBUcEuzBC7mOCfCUgY2sdhFWDVmrqM9MV6MUdoJyZB3m/279ReytieKryT+FQ7L77+6qLPiTdTn5sFnjmZIiWfampRVgK12yaPEZ+WSe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623074; c=relaxed/simple;
	bh=tuO2+/LIjsEx+XFyN+fZk2W+ZU5M/HIoZSIlXVgHCSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxfF+EZ6DZ/+Ccp+cvH/jNlcwx7Ew1eQay02YGXYdUnctAHYbQSfNXtLV/Zb6TFyDqtVK9gHikKyEv7B6ZBs4EjBKNUKO320Te+rnE4i0d7dbQkX3BOkqlAuva9QRqLMrWkEpAT8fsB7jwHW4lvA29uEKSbPwLipxqmDN8hH6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4Oq48A9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4Oq48A9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784623073; x=1816159073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tuO2+/LIjsEx+XFyN+fZk2W+ZU5M/HIoZSIlXVgHCSU=;
  b=h4Oq48A9J0c86k+5Lw4POrFnAX+HINHm26G3EVwMSZOOpCB4yfu6YnJN
   QRGIfxPanlAFGOSBsGcK+qhh6xa5rfFQyKu/+66FPgIesTun7QUzW/rBw
   A/h1ZTKiyX+UrVbUWXurOogos0MXErcBEPS/o2pP7ucIYQBmPDUeg1d+e
   fzycPpll0ulWLAxhmPs84Ox3eniwKLzHO/npbTs55Qw0OPUhSAb5KL2JK
   cYy8BIgCaUXKa/ickYYxSQGFOFwLPtIwk36MQb9geBXtm8GPem+65tZvv
   H7mH9Gw6oMY1gDMF0b1veu67h6cdsWxOhDhaiYdo48wsxNBP6E/MmEqv3
   Q==;
X-CSE-ConnectionGUID: aZ1doAo2SzeHlSaULxf7Ew==
X-CSE-MsgGUID: 8MKhVTsbQnKknFubCoBnFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="89037215"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="89037215"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 01:37:52 -0700
X-CSE-ConnectionGUID: 8eSonQXHRFGdoJ/7ZakRGA==
X-CSE-MsgGUID: L9tLW/9ERsmf9CBmhnPKGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="280968466"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 01:37:48 -0700
Date: Tue, 21 Jul 2026 10:37:45 +0200
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
Subject: Re: [PATCH v5 2/3] drm/xe/xe_ras: Report correctable error events to
 userspace
Message-ID: <al8v2STXTiMhp5C5@black.igk.intel.com>
References: <20260720082208.2648279-5-riana.tauro@intel.com>
 <20260720082208.2648279-7-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720082208.2648279-7-riana.tauro@intel.com>

On Mon, Jul 20, 2026 at 01:52:11PM +0530, Riana Tauro wrote:
> When an interrupt is received indicating that error counter has crossed
> its threshold, read the current counter value and deliver a drm_ras error
> event to userspace for each affected component.
> 
> To avoid sending duplicate events when the same component appears multiple
> times in the response. Send the error-event once per component.

...

> +void xe_drm_ras_event(struct xe_device *xe, u8 component, u8 severity, u32 value)
> +{
> +	struct xe_drm_ras *ras = &xe->ras;
> +	struct xe_drm_ras_counter *info;
> +	struct drm_ras_node *node;
> +	int ret;
> +
> +	/* Event is supported only if drm_ras is enabled */
> +	if (!xe->info.has_drm_ras)
> +		return;
> +
> +	if (component >= DRM_XE_RAS_ERR_COMP_MAX) {

IIUC this is error_id and should be validated against first/last counter
range in drm_ras layer (similar to registration code).

> +		drm_warn(&xe->drm, "unsupported component %u\n", component);
> +		return;
> +	}
> +
> +	if (severity >= DRM_XE_RAS_ERR_SEV_MAX) {
> +		drm_warn(&xe->drm, "unsupported severity %u\n", severity);
> +		return;
> +	}
> +
> +	node = &ras->node[severity];
> +	info = ras->info[severity];
> +
> +	if (!info || !info[component].name)
> +		return;
> +
> +	ret = drm_ras_nl_error_event(node, component, info[component].name, value);
> +	if (ret)
> +		drm_err_ratelimited(&xe->drm, "drm_ras error-event failed: %d for %s %s\n", ret,
> +				    info[component].name, error_severity[severity]);
> +}

...

> +static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
> +{
> +	struct xe_ras_error_class counter = {0};
> +	u8 drm_severity, drm_component;
> +	u32 value;
> +	int ret;
> +
> +	counter.common.severity = severity;
> +	counter.common.component = component;
> +
> +	ret = get_counter(xe, &counter, &value);
> +	if (ret)
> +		return;
> +
> +	drm_severity = xe_to_drm_ras_severity(severity);
> +	drm_component = xe_to_drm_ras_component(component);
> +
> +	xe_drm_ras_event(xe, drm_component, drm_severity, value);
> +}

This entire function can be dropped. See below.

>  static u8 handle_core_compute_errors(struct xe_ras_error_array *arr)
>  {
>  	struct xe_ras_compute_error *error_info = (void *)arr->details;
> @@ -312,8 +364,10 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>  	struct xe_ras_threshold_crossed *pending = (void *)&response->data;
>  	struct xe_ras_error_class *errors = pending->counters;
>  	u32 id, ncounters = pending->ncounters;
> +	u8 sent = 0;
>  
>  	BUILD_BUG_ON(sizeof(response->data) < sizeof(*pending));
> +	BUILD_BUG_ON(BITS_PER_TYPE(sent) < XE_RAS_COMP_MAX);
>  	xe_device_assert_mem_access(xe);
>  
>  	if (!ncounters || ncounters > XE_RAS_NUM_COUNTERS)
> @@ -327,8 +381,21 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>  		severity = errors[id].common.severity;
>  		component = errors[id].common.component;
>  
> +		if (severity != XE_RAS_SEV_CORRECTABLE) {
> +			xe_warn(xe, "sysctrl: unexpected severity %s (%u)\n", sev_to_str(severity),
> +				severity);

Sanity checks are good, but I think this needs to be extended a bit.
I have something[1] more robust, feel free to reuse.

[1] https://lore.kernel.org/intel-xe/20260721082953.640497-1-raag.jadav@intel.com

> +			continue;
> +		}
> +
>  		xe_warn(xe, "[RAS]: %s %s detected\n",
>  			comp_to_str(component), sev_to_str(severity));
> +
> +		/* Send event once per component */
> +		if (sent & BIT(component))
> +			continue;
> +		sent |= BIT(component);

With [1] in place you can just get_counter(&counter) and drm_ras_event()
directly.

Raag

> +		ras_send_error_event(xe, severity, component);
>  	}
>  }
>  
> -- 
> 2.47.1
> 
