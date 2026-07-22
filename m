Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C303932E6
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733866; cv=none; b=tZLa3YdvLjaaQCpr2TWURc9fpBXQNCYYBfhMWxDQ/H3bsoVj5hFK/m6YS5/qHkNJ0IXDomb6D8UpF2weXfykWz27Da545RPfmyJLFUjzbURw3F+f701AbKNW/9I5y0SLSs6uaO8Kp1qVelN58V+Ghnvfpp7znJYJeBSOydOUYBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733866; c=relaxed/simple;
	bh=yNp5vfbNrcw9crZa4ho/0WR69M1J0VF4JvsRHE3RGcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8SxOsH0BKnE49nHFpXYUcUSOoisvTQDaOJIld7fb/xkUdD0injVA6HvYWLhJ1lQiF6T8XQslTmKDeGnFqz/INKObCVmRMOdN3+6WM7VNBwBurG3y83C9KtnMTEbRvIbYPLA06LsyUOt+9dQrYOTWUyoaJ8lQYF3DKnWF3YJCZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cB/sBv3W; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cB/sBv3W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784733859; x=1816269859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yNp5vfbNrcw9crZa4ho/0WR69M1J0VF4JvsRHE3RGcU=;
  b=cB/sBv3W7bUBB3NBE4BBa+g/0Fac0WGHn3SjpfzaDTg0nWFykXWtwe8b
   Xhq2+Hw/2+4V/H606yLWR68JaOHn/4RuGuW5S0EFfdBVZ+hXBQ8zKvyhe
   P/NxHNhjavb2JM8d4AwCSYrSfUNbED2lvb6lFEtbIm4JUt5ud5ZumlfYu
   SaKT2TeZw8GIp78ry5PO04U8x69ixBa3f7IJKRQKYCRf7mbQzUzYEYrPt
   qK7eIIH9CwjLJ2sW0lNsKoqmBwI8izq3oNelvrnaaY79kJBr1foWIoIe8
   TVx3/5635kgbYWLKo0aIw30rFjW5DO35V4fXsMI0iVIACiB8KtkcdL9Vv
   g==;
X-CSE-ConnectionGUID: 0pom0/uoQGCCnlEX17sfJw==
X-CSE-MsgGUID: MIZEg2HEQc6lrVMKa2Kh/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85318085"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="85318085"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 08:24:12 -0700
X-CSE-ConnectionGUID: 6UUqaySHRriAFSZgN/h1kQ==
X-CSE-MsgGUID: AKAZSnbeQquZ5UOnakilBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="263068633"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 08:24:07 -0700
Date: Wed, 22 Jul 2026 17:24:04 +0200
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
Message-ID: <amDglMC44EIWChvp@black.igk.intel.com>
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

> @@ -425,6 +487,12 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
>  			xe_info(xe, "[RAS]: %s %s detected\n", comp_to_str(component),
>  				sev_to_str(severity));

Similar to threshold crossed case, we should probably have a BUILD_BUG_ON()
against XE_RAS_NUM_ERROR_ARR.

Reviewed-by: Raag Jadav <raag.jadav@intel.com>

> +			/* Send event once per component */
> +			if (!(sent & BIT(component))) {
> +				sent |= BIT(component);
> +				ras_send_error_event(xe, severity, component);
> +			}
> +
>  			switch (component) {
>  			case XE_RAS_COMP_CORE_COMPUTE:
>  				action = handle_core_compute_errors(arr);
> -- 
> 2.47.1
> 
