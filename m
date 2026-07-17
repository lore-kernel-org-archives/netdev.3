Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2255D3AE70A
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270471; cv=none; b=ZFs8bkLBm8VuIdXwZWOhO4OwtS6Pee7qJXodTb0Acdu2Zk9cGJxMyOBvgXtu+1bS67mXfdjeAahSfalXALA5rBvv37/uv7k8ClKOearggB6Zb66N/3Mw5eUSFMh5FawXTYBeMdFaELHzErqjOVyF/cxPP+XY08NjXygIyglDfo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270471; c=relaxed/simple;
	bh=vulebB9C8nuEp8cKObMoDXnbn4yRAgWEntVwrmSpMRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=El8L0u1PTAmbJrjbiPtaejTd0WxpJq48Y3rINur3UAAIL1hsakjD2f2KTPH8YLxOFzi1Va8Rqrgd/P6lDQNt5Rsr//dYSBbUh8Q3PMpJumKLi8CGHn/TUx+kgzIDSsi2foF5CHAReepzSpMa75vJ3req3D9zHU7+UwgvSyHGe7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5Y6u1em; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5Y6u1em"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784270457; x=1815806457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vulebB9C8nuEp8cKObMoDXnbn4yRAgWEntVwrmSpMRM=;
  b=R5Y6u1embOi7/yXrI2PwWYoUfM3K+8uPkifuOcOvKH8/oeRfSJouLupv
   yaoTUVpTSPlgIULDpR/5twATWs4qcHMB5iLz8p/e533XQ6o50RrXmQkYH
   KJFjJkYEIsxmUSKmAnDBDAGoZO9IVUhznk+4TCPwW/mjYoctdHui0cRQZ
   UbAp/xfnSxM5vfI/0eAdpG73ZtcKQfqWXTm84T783m1BC7UeaVvdmrpX3
   pNvPqxihFPjBtUGKG7GOzRE6gM5O8EkFmIB2v2iT6nmGnJa+dfdeJnq3B
   yj1qpLjpYnnWNSrbEPuVb+Xml1XhwvVubj23WgAy2FCLxBnd//tFWoBNW
   w==;
X-CSE-ConnectionGUID: Sgn++ZWXS7CiKSbUig5XSg==
X-CSE-MsgGUID: 5rSU5SbMRXmsJyWm66TuWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="96073422"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="96073422"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 23:40:53 -0700
X-CSE-ConnectionGUID: e5E06XyOS2GvPc7NvW7vhQ==
X-CSE-MsgGUID: AEJHUp6ZSnKxRrcRC3FlQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="258701243"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 23:40:49 -0700
Date: Fri, 17 Jul 2026 08:40:45 +0200
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
Subject: Re: [PATCH v4 3/3] drm/xe/xe_ras: Add error-event support for CRI
Message-ID: <alnObRca4xNQMgi7@black.igk.intel.com>
References: <20260701094409.129131-5-riana.tauro@intel.com>
 <20260701094409.129131-8-riana.tauro@intel.com>
 <ak9yEyDF_tlJe-Rx@black.igk.intel.com>
 <918f2fc4-2aec-43a4-b52a-028011aa91b4@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <918f2fc4-2aec-43a4-b52a-028011aa91b4@intel.com>

On Thu, Jul 16, 2026 at 03:27:59PM +0530, Tauro, Riana wrote:
> On 09-07-2026 15:34, Raag Jadav wrote:
> > On Wed, Jul 01, 2026 at 03:14:13PM +0530, Riana Tauro wrote:
> > > Add error-event support for Correctable errors in CRI. Report an error
> > > event to userspace for every component that has crossed the threshold on
> > > receiving an interrupt.
> > ...
> > 
> > > +static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
> > > +{
> > > +	u8 drm_severity, drm_component;
> > > +	u32 value;
> > > +	int ret;
> > > +
> > > +	drm_severity = xe_to_drm_ras_severity(severity);
> > > +	if (drm_severity == DRM_XE_RAS_ERR_SEV_MAX) {
> > > +		xe_warn(xe, "sysctrl: unexpected severity %u\n", severity);
> > This is uapi and not coming from sysctrl, so the message is a bit
> > misleading. But if at all it needs validation, it should be done in
> > drm_ras layer.
> 
> You mean in the ras_event function?  The parameters to this function are
> coming from sysctrl.
> So added sysctrl flag

We shouldn't be at this point without valid severity and component, and
this also contradicts the if condition which is for uapi.

> > > +		return;
> > > +	}
> > > +
> > > +	drm_component = xe_to_drm_ras_component(component);
> > > +	if (drm_component == DRM_XE_RAS_ERR_COMP_MAX) {
> > > +		xe_warn(xe, "sysctrl: unexpected component %u\n", component);
> > Ditto.
> > 
> > > +		return;
> > > +	}
> > > +
> > > +	ret = xe_ras_get_counter(xe, drm_severity, drm_component, &value);
> > No, instead of converting back and forth just do get_counter() using
> > sysctrl values and send_event() afterwards.
> 
> The reason for using this is to avoid unnecessary churn of moving the get
> counter above or use forward declaration.
> Yeah i can use that too directly.

You already get a counter as part of threshold crossed event, which you
can directly pass to get_counter() instead of dealing with severity and
component individually.

Raag
