Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1571F3D56
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653701; cv=none; b=J/7zp0pVQuPPJ5DqJAAIBO5MIeY2o8VGQLjIYHeBhA4bnRc6j9j8LGkmR/WZmulqB8vBPTr+vpYJVPg6SMM5swuFFVFUu30ERZqwRjW/G4K6H4PyZwuT8B3eYKxLBrXAImkGoXotHsyMw1K3SljHPtaRFb4qOFM+8OIPfX3SNSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653701; c=relaxed/simple;
	bh=mVMWIWJnrBJufKkviFN2SwdHevpvpeFyKIUvsgpQLgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUgEksDUkYFT9V+XqzHdF1/SgyIHMdVOBczzOaVhu7LtSai+LgPPZsq4UHgrItvJqem4o1RzhDWQQxrnhj6+lEh5NLVMtvPEL7sL4kJY+JNJW/2GmgD/bysYc4TfqsRivv0xNOHkKXhiwHm2XlPI/kU8l9wdbCFfBKUphHo7gGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OT5ka03H; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OT5ka03H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784653699; x=1816189699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mVMWIWJnrBJufKkviFN2SwdHevpvpeFyKIUvsgpQLgU=;
  b=OT5ka03Hj4FpbByDGX+i+ohQC8nN0IQqqYCw1TXhz+HLx+oY/wLJ0CTi
   NyNY5nUqYetr1xYUTD0e4lfas3ow3rQqPVLdrT38zW5vnVV2/e+hT1gky
   5l0QA4Tb09PF3dNHbGlbwmrGt4NgZCrWawSbfUbIVSMT9XnyXMHIjE2Fz
   nBoqHEdhoK8uDPhO5r52vdZjRCMtKLH3ELBFLWeRPpJtx1A8x/BghQm2z
   2BBtWdNFHcBcjcdzYs6zbehTQVulXcFp2pcZOvoNMZHHbpA/KWEAhuvSB
   yTo/sYvQ8jPCooeQYDIZjd4Hp5FdyukbV0GVP3DpPRGG4ftxVF+D/5Xho
   w==;
X-CSE-ConnectionGUID: xDfpbQJrSPO7hVxuFoEuOw==
X-CSE-MsgGUID: 8u6X4jo+Qt+SZ05YlGE2Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="108052101"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="108052101"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 10:08:19 -0700
X-CSE-ConnectionGUID: uZ/sfGZES5yTsDELOKMzAw==
X-CSE-MsgGUID: H9ufHB3dR5qdCLemR5XmcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="261382897"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 10:08:14 -0700
Date: Tue, 21 Jul 2026 19:08:11 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
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
Message-ID: <al-neyeoG873l1xX@black.igk.intel.com>
References: <20260720082208.2648279-5-riana.tauro@intel.com>
 <20260720082208.2648279-7-riana.tauro@intel.com>
 <al8v2STXTiMhp5C5@black.igk.intel.com>
 <0e842368-3bbf-436e-839d-cc7fec29b0cb@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e842368-3bbf-436e-839d-cc7fec29b0cb@intel.com>

On Tue, Jul 21, 2026 at 06:52:51PM +0530, Tauro, Riana wrote:
> On 21-07-2026 14:07, Raag Jadav wrote:
> > On Mon, Jul 20, 2026 at 01:52:11PM +0530, Riana Tauro wrote:
> > > When an interrupt is received indicating that error counter has crossed
> > > its threshold, read the current counter value and deliver a drm_ras error
> > > event to userspace for each affected component.
> > > 
> > > To avoid sending duplicate events when the same component appears multiple
> > > times in the response. Send the error-event once per component.
> > ...
> > 
> > > +void xe_drm_ras_event(struct xe_device *xe, u8 component, u8 severity, u32 value)
> > > +{
> > > +	struct xe_drm_ras *ras = &xe->ras;
> > > +	struct xe_drm_ras_counter *info;
> > > +	struct drm_ras_node *node;
> > > +	int ret;
> > > +
> > > +	/* Event is supported only if drm_ras is enabled */
> > > +	if (!xe->info.has_drm_ras)
> > > +		return;
> > > +
> > > +	if (component >= DRM_XE_RAS_ERR_COMP_MAX) {
> > IIUC this is error_id and should be validated against first/last counter
> > range in drm_ras layer (similar to registration code).
> 
> This should be done before because we are accessing the nodes here.
> The nodes anyway won't be available in xe_drm_ras if not registered with
> drm_ras.

Yes. We get the node from severity which we already validate here, but
error_counter_range is the property of the node and unrelated to xe.
Even if you prefer it here, these checks must be in core functions to
make sure they are not abused.

> > > +		drm_warn(&xe->drm, "unsupported component %u\n", component);
> > > +		return;
> > > +	}
> > > +
> > > +	if (severity >= DRM_XE_RAS_ERR_SEV_MAX) {
> > > +		drm_warn(&xe->drm, "unsupported severity %u\n", severity);
> > > +		return;
> > > +	}
> > > +
> > > +	node = &ras->node[severity];
> > > +	info = ras->info[severity];
> > > +
> > > +	if (!info || !info[component].name)
> > > +		return;
> > > +
> > > +	ret = drm_ras_nl_error_event(node, component, info[component].name, value);
> > > +	if (ret)
> > > +		drm_err_ratelimited(&xe->drm, "drm_ras error-event failed: %d for %s %s\n", ret,
> > > +				    info[component].name, error_severity[severity]);
> > > +}
> > ...
> > 
> > > +static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
> > > +{
> > > +	struct xe_ras_error_class counter = {0};
> > > +	u8 drm_severity, drm_component;
> > > +	u32 value;
> > > +	int ret;
> > > +
> > > +	counter.common.severity = severity;
> > > +	counter.common.component = component;
> > > +
> > > +	ret = get_counter(xe, &counter, &value);
> > > +	if (ret)
> > > +		return;
> > > +
> > > +	drm_severity = xe_to_drm_ras_severity(severity);
> > > +	drm_component = xe_to_drm_ras_component(component);
> > > +
> > > +	xe_drm_ras_event(xe, drm_component, drm_severity, value);
> > > +}
> > This entire function can be dropped. See below.
> 
> We don't need to drop function. It's cleaner to have it in the function
> than repeating it twice.

I thought we'd lay the groundwork for cper which'll also need get_counter()
in the same path, but upto you.

Raag
