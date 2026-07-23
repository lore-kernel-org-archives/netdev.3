Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644C535C6BF
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823113; cv=none; b=oEaoiflTMlzC4q6BHnzIcLKaWoVVnO4Cfl+fJkwpEJ4hIG57ApEfTQIDxg/mNLpQ5dhK9QdYY8ogAQz2/k79rWugUFAhpJM0a4M7Lwl+G67bwrwXZY4FyfI0C5wG4KQxxNkuDMM91TagmGI0EZgtwxKPDz2mKxF6uf3Qu9dGpfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823113; c=relaxed/simple;
	bh=jUcotzTeGHseDTEsvIVAaM/5dkYSEPp61sUE3M2Ha4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKoZPNHky7xIfnw1zJ/nsf5PiIYcON5+5o0zuoybcAUigXOBDnJ9LhTrcD4y1BtaPjItEnqrvEfZimHAhyOkJYx2XcdryQWUy/w4tQb3qr5dEDqWslFQUe58qYDNM18W5x3utXj05wL5OVqEaLciCWSLX+t5sQnCm8RRBmhwbE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMdoClnp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMdoClnp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784823111; x=1816359111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jUcotzTeGHseDTEsvIVAaM/5dkYSEPp61sUE3M2Ha4I=;
  b=OMdoClnp0AUnUkdPMPkWejkdDqCfA5Yrurrzw6faf8BydyqO/PtX8hFd
   gZS8+WJM0T1IhtXBIVPsnes85tljGrXPwtQmG6SeDuy8S/Ei/sdFe4FtA
   7DAvqE289YMoOOxJEnrT50BrPE0SI1QKU3g/CzgISG3T2OncB1TeuGGHI
   MFObJuzffPUIwM9HSWxt41hszjaiEcIPV645UnUAyAe/Onym1wpdg8Hlq
   a7B6Iz5mfB2RpALcR3DvTCt2dtjf+N7e12l/8ZFGPkyL6UFed8nUlX1mT
   VY9ZhyAOx48UP3pMpYdqOjb9KjjkVYwdNYQt9qENnHW2oDfRErF8naFhG
   Q==;
X-CSE-ConnectionGUID: INJWejeAQEin4QrnK28hLQ==
X-CSE-MsgGUID: mH+Mg4wGRryYCT8AXcM2uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="102893198"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="102893198"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 09:11:50 -0700
X-CSE-ConnectionGUID: 0bMapSTvSbuSZqtNqgKM6w==
X-CSE-MsgGUID: 7CSbUSIcTp6N/vvPakIgRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="281753336"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 09:11:46 -0700
Date: Thu, 23 Jul 2026 18:11:44 +0200
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
Subject: Re: [PATCH v6 2/2] drm/xe/xe_ras: Report correctable/uncorrectable
 error events to userspace
Message-ID: <amI9QO9_4QcfG4jc@black.igk.intel.com>
References: <20260722094134.3036087-4-riana.tauro@intel.com>
 <20260722094134.3036087-6-riana.tauro@intel.com>
 <amDglMC44EIWChvp@black.igk.intel.com>
 <f08a30a8-afca-4cad-8353-5c3ce091a9ef@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f08a30a8-afca-4cad-8353-5c3ce091a9ef@intel.com>

On Thu, Jul 23, 2026 at 08:34:39PM +0530, Tauro, Riana wrote:
> On 22-07-2026 20:54, Raag Jadav wrote:
> > On Wed, Jul 22, 2026 at 03:11:37PM +0530, Riana Tauro wrote:
> > > When an interrupt is received for correctable errors indicating that error
> > > counter has crossed its threshold, read the current counter value and
> > > deliver a drm-ras error-event to userspace for each affected component.
> > > 
> > > Also send drm-ras error-event to userspace for uncorrectable errors on
> > > receiving an AER.
> > > 
> > > To avoid sending duplicate events when the same component appears multiple
> > > times in the response, Send the error-event once per component.
> > ...
> > 
> > > @@ -425,6 +487,12 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
> > >   			xe_info(xe, "[RAS]: %s %s detected\n", comp_to_str(component),
> > >   				sev_to_str(severity));
> > Similar to threshold crossed case, we should probably have a BUILD_BUG_ON()
> > against XE_RAS_NUM_ERROR_ARR.
> 
> This is already added part of correctable. Seems unnecessary to add it twice

'sent' is a local variable and needs its own BUILD_BUG_ON() IMO, but
upto you.

Raag
