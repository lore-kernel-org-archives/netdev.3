Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFB9431A54;
	Wed,  5 Aug 2026 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929285; cv=none; b=nTJZJvI44K8mOqagvyqeJe/H9EnsPzsusT6h6edY4ILW1vOKOJ346Ed1DLbwb+0D5GYpY5mj5Us9ipNeDGD+X0M7xK8hdyyltkJvBU7XXc+myspoYqew1bsxnsI2GjHWuxoCpUZscnvv6R3sy6YlMT/EEky/EQhCIlTZah1zTV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929285; c=relaxed/simple;
	bh=H+1YnhIQAneUZwC0Y1Yb7xsyru1/OSp0XgmQJ0ad2Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUMMq2jGRr15vdX2IF07xTFpLfkgjnEFb/nlMEiMTTdbtfl0nZnYzuDFuB2hpeRCQfQ0+Vq6guX0f8Ol06zjoNkKaNBZfa8WOsCXP+1uU4qvsA7ylYJWMDcsQRlvZ8lsu+bPGz7RgB8QAYskyELZu4JjNE61ub5mUW0qx/8hTr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIkreivZ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIkreivZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785929281; x=1817465281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H+1YnhIQAneUZwC0Y1Yb7xsyru1/OSp0XgmQJ0ad2Zs=;
  b=gIkreivZTv5YNc7JoUxMp8VWm3QH8yMFlH6i1A9dUEpmhUYhN8a9zaXy
   2XWyE9+ZzuQU/BCTgvi2cc1pOCJzDNWHrXSPNQymrDUAWhh+X1NppY/yp
   F9H0uvBuKlQdaBgWdojLP0VHMreYfGRIRBKV85AXQ3lasD5BYQCHRcbBx
   LOJf/4Crw9G/jWmKLAlS7T2KKYiDa9f8T9vZiUcZ7UY0apEzWATepet5/
   HRKijUzYL7geNw3tI/+iQLV8+Esn2j4tuKhF6hRjr+j01KQ/oALtMn+L+
   cG3TarDYEMFuHnKs1yzkTbRHJ9UfKSr5iodeG55ktFGMK0KfxozBSEdIx
   w==;
X-CSE-ConnectionGUID: YNQGrmUNT1mFOsFFzd5R8w==
X-CSE-MsgGUID: c9ImvG4+T/WDGMVKSP6XIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="74035137"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="74035137"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 04:27:58 -0700
X-CSE-ConnectionGUID: 6L/m8W8VSKmfx5sJiD6tnQ==
X-CSE-MsgGUID: MUzCAaBSRjSNm/eqhNT/sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="263778077"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 04:27:54 -0700
Date: Wed, 5 Aug 2026 13:27:51 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>,
	David Airlie <airlied@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Riana Tauro <riana.tauro@intel.com>,
	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>,
	Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Subject: Re: [PATCH] MAINTAINERS: Add entries for drm_ras
Message-ID: <anMeN5B8LbaM41jz@black.igk.intel.com>
References: <20260805094949.536651-2-rodrigo.vivi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805094949.536651-2-rodrigo.vivi@intel.com>

On Wed, Aug 05, 2026 at 05:49:50AM -0400, Rodrigo Vivi wrote:
> DRM RAS interface provides a standardized way for GPU/accelerator
> drivers to expose error counters and other reliability nodes to
> user space via Generic Netlink.
> 
> Since this is cross-driver infrastructure carrying its own uAPI, add a
> dedicated MAINTAINERS entry covering the implementation, headers,
> netlink spec and documentation, maintained through drm-misc.
> 
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: David Airlie <airlied@redhat.com>
> Cc: Donald Hunter <donald.hunter@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Raag Jadav <raag.jadav@intel.com>
> Cc: Riana Tauro <riana.tauro@intel.com>
> Cc: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> ---
>  MAINTAINERS | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5114e6db7307..51be7ad24528 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9039,6 +9039,19 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>  F:	drivers/gpu/drm/drm_privacy_screen*
>  F:	include/drm/drm_privacy_screen*
>  
> +DRM RAS
> +M:	Raag Jadav <raag.jadav@intel.com>

This one should be 'R' and not 'M'.

Raag

> +M:	Riana Tauro <riana.tauro@intel.com>
> +M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
> +R:	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> +L:	dri-devel@lists.freedesktop.org
> +S:	Supported
> +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> +F:	Documentation/netlink/specs/drm_ras.yaml
> +F:	Documentation/gpu/drm-ras.rst
> +F:	drivers/gpu/drm/drm_ras*
> +F:	include/drm/drm_ras*
> +
>  DRM TTM SUBSYSTEM
>  M:	Christian Koenig <christian.koenig@amd.com>
>  M:	Huang Rui <ray.huang@amd.com>
> -- 
> 2.55.0
> 
