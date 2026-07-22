Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979C3D4101
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734333; cv=none; b=JTov4tz9/BLxdeEwH7mK123bk/5emYU5YkcP4StLuZ7yNdKG2wYmimL+1UyK84TRo92nhXbtHsVSu+u4DqiB6FB8G8PnhT/PkcR3HZusxj0CsGWRLdotjQwSD9JUzCutr7qAq94+uXJMAIpLmbcD28JQQp3DTOmW89a3srGYvTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734333; c=relaxed/simple;
	bh=41vEcB7RyeIVCwqiNyAHT9hY3XiyyoOm779ExXEI0Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ2NNnoPGR7NqMoonUIK9PUDLXjKzV2lDoV5kzPMnwlA40UbgMMUhtDdSmVfvLI4k9s+AEfkwiS4a2uQhE8c/JbaXZl8xv7JBK0GL9yjdbGuGQBLePWCJu1o10zErpflNTeUsT2bSfC2AHQSsUGdoGzPqzkyDmhl1yW1HaHkNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dw4DG3Ai; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dw4DG3Ai"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784734332; x=1816270332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=41vEcB7RyeIVCwqiNyAHT9hY3XiyyoOm779ExXEI0Bw=;
  b=Dw4DG3AiIr+eMJtWrRW6/R83ruLsBdKxOtFSKxgua4zkT33wJljTc3M0
   1TT0MPIHfxRYLFbsLt5NYAAMiBjQj302ZzJpcxX3J9oSfTW0IpNj1mYZC
   6AHG80mWOz4gUev9a9a5QUhFPeWuz+a1GfhBfjlSFG0Oh1v/ooIGH1mYL
   CTAq5A/Fii69NTKPF7RNXynhusgFwmmddctIeceT9nWDGcyysz0L0vvq+
   VSILBOhc9/LbVmrH0V8Rs8B0CcQ07ubkpPBLvKnocHA0TVmhx/J+n8Mwk
   T+UtXhDLxkxE0seMmFlX+GFh8u3JrMwA+ZEqAXcBVRd1E5bYmzWoDJP2k
   A==;
X-CSE-ConnectionGUID: Qp1ajWoqTi6oxTzw1J+3WA==
X-CSE-MsgGUID: /UKyFwieQBeRH/J/sWD0Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="95961902"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="95961902"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 08:32:11 -0700
X-CSE-ConnectionGUID: Nss9kMjmSa+WqTZwoXCJ9w==
X-CSE-MsgGUID: GOPlwTiyTdi3EJgaEMXwcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="262422940"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 08:32:07 -0700
Date: Wed, 22 Jul 2026 17:32:03 +0200
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
Message-ID: <amDicxi7Bwuy1k2l@black.igk.intel.com>
References: <20260722094134.3036087-4-riana.tauro@intel.com>
 <20260722094134.3036087-6-riana.tauro@intel.com>
 <amDglMC44EIWChvp@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amDglMC44EIWChvp@black.igk.intel.com>

On Wed, Jul 22, 2026 at 05:24:11PM +0200, Raag Jadav wrote:
> On Wed, Jul 22, 2026 at 03:11:37PM +0530, Riana Tauro wrote:
> > When an interrupt is received for correctable errors indicating that error
> > counter has crossed its threshold, read the current counter value and
> > deliver a drm-ras error-event to userspace for each affected component.
> > 
> > Also send drm-ras error-event to userspace for uncorrectable errors on
> > receiving an AER.
> > 
> > To avoid sending duplicate events when the same component appears multiple
> > times in the response, Send the error-event once per component.
> 
> ...
> 
> > @@ -425,6 +487,12 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
> >  			xe_info(xe, "[RAS]: %s %s detected\n", comp_to_str(component),
> >  				sev_to_str(severity));
> 
> Similar to threshold crossed case, we should probably have a BUILD_BUG_ON()
> against XE_RAS_NUM_ERROR_ARR.

XE_RAS_COMP_MAX, missed it :)

> Reviewed-by: Raag Jadav <raag.jadav@intel.com>
> 
> > +			/* Send event once per component */
> > +			if (!(sent & BIT(component))) {
> > +				sent |= BIT(component);
> > +				ras_send_error_event(xe, severity, component);
> > +			}
> > +
> >  			switch (component) {
> >  			case XE_RAS_COMP_CORE_COMPUTE:
> >  				action = handle_core_compute_errors(arr);
> > -- 
> > 2.47.1
> > 
