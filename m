Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4163C5530
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442418; cv=none; b=RlAHxg2tsqeU5hgxETV8h4kWHC9Y2wi5sLTd1Y0IXj5DFXEyvlWX5U7KNGpkTlLbMdGezljwLcEMv5mAT2Wk8mLR3Q9OqCJYyWoimvtPXHO+FWxthSiKraRKOhWKLF2s+pPRnbjbjXuOe8B4KWuVgHr3Cnz7u9vAhYRH/qnDXrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442418; c=relaxed/simple;
	bh=0ykjiUAp1iGLjedC402sZIXIRZSWQPp4VGFsoOIHYGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNF9Pnx6HR0GW9tB4uAGJHccqYD0kr2cJvGGJw3J57cX3EY0ia+2D3x1oQwBDeaAWSJV2JzhJtLjW1L5GeeH8LizxlKaO0oCgDP7VIB1nnQSsGF0vL96nZ7D+qwNZ2wQs6itmVuvb/MupuWhr9Vm2/1UtChhQF6l0wnQzoLy1kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0bGQqFf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0bGQqFf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774442418; x=1805978418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ykjiUAp1iGLjedC402sZIXIRZSWQPp4VGFsoOIHYGQ=;
  b=B0bGQqFfZ51XHthRkDn71l2Y5nrfDAv9mkqSI/m9VcKi+yohdQnKH1/v
   bkrpBbYma3JCF9O57g+fdm3eNxICUBNJmKJTmBWeKXridlEueMzqCTY4I
   aQLxhGGcp/6/ZHDeHD9ZfKQThFtWC8NDZGif2MmpNd1SzTileF2xUsk98
   McpHPR+ODcngs/pCd+CdTlEfRYz3702AmQK9A+16bE706G/SlAYYhHxdo
   E03YcVlWNFR7w29HAqw1MXWmFpFPBfx0cb/GlqwoG365iQxIem8mdxjRp
   FBJ8J2FjNPvLg+GoONf25i4N717jNIaN0zyGQaLk29xUJpZvhdOd+xy0I
   g==;
X-CSE-ConnectionGUID: Mjm+PGZ+QUOwip8XL2A/4g==
X-CSE-MsgGUID: qnyv536ZRo2EHlrwHRsv3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86088718"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="86088718"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 05:40:17 -0700
X-CSE-ConnectionGUID: NpVP2QpCQ/aAk7BMZuwJiA==
X-CSE-MsgGUID: WxcnrAMbQZ2f6cr9KP47OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="229125935"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 05:40:11 -0700
Date: Wed, 25 Mar 2026 13:40:08 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com, simona.vetter@ffwll.ch,
	airlied@gmail.com, pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
	anvesh.bakwad@intel.com, maarten.lankhorst@linux.intel.com,
	Jakub Kicinski <kuba@kernel.org>,
	Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 1/4] drm/drm_ras: Add clear-error-counter netlink command
 to drm_ras
Message-ID: <acPXqL030Syciz1b@black.igk.intel.com>
References: <20260311102913.3387468-6-riana.tauro@intel.com>
 <20260311102913.3387468-7-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311102913.3387468-7-riana.tauro@intel.com>

On Wed, Mar 11, 2026 at 03:59:15PM +0530, Riana Tauro wrote:
> Introduce a new 'clear-error-counter' DRM RAS command to reset the counter
> value for a specific error counter of a given node.
> 
> The command is a 'do' netlink request with 'node-id' and 'error-id'
> as parameters with no additional response payload.
> 
> Usage

Missing ":"

> $ sudo ynl --family drm_ras  --do clear-error-counter --json \
> '{"node-id":1, "error-id":1}'
> None
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Riana Tauro <riana.tauro@intel.com>

Reviewed-by: Raag Jadav <raag.jadav@intel.com>
