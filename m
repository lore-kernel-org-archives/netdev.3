Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C537C0FE
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777286; cv=none; b=NcXaDA0Zj7piJlydNSdiuaE0yenR6g16KIM7DhlwbkztjqAuE12t9NnauxUC3lliXGoHa/10mYZRdGbxSqtoLdp6aMJeI9x97PjB6RlqnynHtT7gaDK89lJGttZp8JfQ+2GzwNNy0NkaPuCEHmEQQ0wbt8HxgdQqjAzz2RIGay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777286; c=relaxed/simple;
	bh=C+XViI3owNPDk7ocOokFo/XxhRN3dEGwZ3OHdlhAOtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+NsC+mduu7Rju+Rb4JJryie2tzY41ZEykoF6ZWko3l3itAUvplanfuo3EU5NHR0hQjra7Hdftp8byKGiVzy4ozvkWmHYgeFa0Bsu7jlXOIa81ULPdweT71GGXGZNG12gEGYyYzpOZxG3CXS7OMOnjRyGFeuU1Ge3Ra9D6IscZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lb4u7GNL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lb4u7GNL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781777285; x=1813313285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C+XViI3owNPDk7ocOokFo/XxhRN3dEGwZ3OHdlhAOtU=;
  b=lb4u7GNLUKKbY/N7TxQDuruCz7xDTyOe6RpnVfJ8sUdZapuWGFPJEHap
   Gcmi8gmy4pak11SgSEA2gAEGzLLNV+2em97PVqHJUv2OOohTYTPwC1O3N
   /IEbx3besdnGRmSjir/8EKyMjzrEF5P1OLySiU6GCMpN1zK9Ja1Wrd2fr
   NF+RkkzxOSH6ALkVnLXGWPmM/IWCrxrXXW083YxUs+06+WAtd9TpW1/fg
   hh0QINBYXzjHZCSkrD4BS1AuTcpykwQe74ToDuPAcTaF7Hd+3pR/UU7b3
   SrG1obYKzW68iCDEUG6JqjF8ba77WAGURjFBuBFAxabN9UfNjp98MwzlW
   w==;
X-CSE-ConnectionGUID: PNFQdHHTT1mhoUueJRs0NQ==
X-CSE-MsgGUID: mX6v+GMuTlCTZ688ZN3d4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="86450809"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="86450809"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 03:07:59 -0700
X-CSE-ConnectionGUID: AkhGEWlSRh+6lM90ZBVbsg==
X-CSE-MsgGUID: EIj4hHNTTYSlQPkrf+Hrug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="252644135"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 03:07:55 -0700
Date: Thu, 18 Jun 2026 12:07:52 +0200
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
Subject: Re: [PATCH v2 2/2] drm/xe/xe_drm_ras: Add error-event support in XE
 drm_ras
Message-ID: <ajPDeMpSypYrFllq@black.igk.intel.com>
References: <20260611052144.784969-4-riana.tauro@intel.com>
 <20260611052144.784969-6-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611052144.784969-6-riana.tauro@intel.com>

On Thu, Jun 11, 2026 at 10:51:47AM +0530, Riana Tauro wrote:
> Add error-event support in XE drm_ras to notify userspace
> when an error occurs.
> 
> $ sudo ynl --family drm_ras --output-json --subscribe error-notify

Same comment as first patch, but upto you.

> {
>     "name": "error-event",
>      "msg": {
>          "device-name": "0000:03:00.0",
>          "node-id": 1,
>          "node-name": "uncorrectable-errors",
>          "error-id": 1,
>          "error-name": "core-compute",
>          "error-value": 1
>      }
> }
> 
> Signed-off-by: Riana Tauro <riana.tauro@intel.com>

Reviewed-by: Raag Jadav <raag.jadav@intel.com>
