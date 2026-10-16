Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5D1FCFFC
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792190956; cv=none; b=g60IVPs69AJc9kCUOXMrhyGLxVEkcDZfMcK7pN17V+PtVzrkI8C6klGaoCOad4WNQPOi7MvDD9yfJubguiG8kmKc28yJIYWxS3iPjscS0GvHiW2lGwbrtILh+wuiPKfV6YkHgssT3btaokCfJUqHE+zKPv5MKUB9XWuAea0c9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792190956; c=relaxed/simple;
	bh=BcqCywRq+vQCr07TExh9701pqQcmjvYmpMnf7ImfWDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gi32fC3wqBYNtc9zZMTP8YMfqUYW8w0fM+/K+51gpONklWlspY/qjxLAJo2PXfBJtca3bDGohiikj8infdsoMsVbnvu9qDqySmRnEx2sDYLzZBmPl11qWfRW+IBG7Enp1OFL4piR9/PlKWjOnw4evni29In0rGjrXLM6aI82IPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQBLIWrn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQBLIWrn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE33B1F000C4;
	Fri, 16 Oct 2026 22:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792190954;
	bh=scthorKrG8eAJYWdzqIYf09NTRv0K0CrY9Go6fw5xwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XQBLIWrnR2vcp0RxEUEaQaOJ34wkca3U54iqZe7dcL+RStYpwT/OQyY+U+URo7ZW+
	 trIp+ywRavPwwFm/2ilCbsaLE4TbykGcyu1WpCZI/Puvo+ctmJU6PtenQsbduroLx2
	 EvYc3P1PYB9Fipzk3vXfoqbBn6a55LtS5eXT0HBtXmhJ10rjTO8xF7HM90GYRAe9Bg
	 +mBN2827tpPwnwFPSBB8ZQ3YDZwOUlfGk/Z73sg3HFM9eK2QTRmFB5R3zUJFDCr18+
	 ZY/mx7OapgPJpscZy/XVqoPcaOgOvvfZtX6drVHkIYZr2Urzg6ykGIqdILF+OUqMiD
	 kJdnUyC/e8xvw==
Date: Fri, 16 Oct 2026 15:49:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 simona.vetter@ffwll.ch, airlied@gmail.com, tejas.upadhyay@intel.com,
 himal.prasad.ghimiray@intel.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, raag.jadav@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 pratik.bari@intel.com, Hawking.Zhang@amd.com, tao.zhou1@amd.com,
 YiPeng.Chai@amd.com, jinzhou.su@amd.com, cesun102@amd.com,
 lijo.lazar@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Subject: Re: [PATCH v2 1/2] drm/xe: Expose retired VRAM pages via drm-ras
Message-ID: <20261016154913.1af64e88@kernel.org>
In-Reply-To: <20261007080354.3072751-2-aravind.iddamsetty@linux.intel.com>
References: <20261007080354.3072751-1-aravind.iddamsetty@linux.intel.com>
	<20261007080354.3072751-2-aravind.iddamsetty@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Oct 2026 13:33:53 +0530 Aravind Iddamsetty wrote:
> +  -
> +    name: retired-resource-attrs
> +    attributes:
> +      -
> +        name: node-id
> +        type: u32
> +        doc: Node ID targeted by this retired resource operation.
> +      -
> +        name: vram-page
> +        type: nest
> +        nested-attributes: vram-page-attrs

why wrap attrs in a nest? Are you planning to add other resource types
(than a page)? It's a common anti-pattern in Netlink to over-wrap stuff.

> +        doc: >-
> +             Type-specific payload. The resource type is identified by the
> +             node (its node-name); each node reports a single resource type.
> +  -
> +    name: vram-page-attrs
> +    attributes:
> +      -
> +        name: address
> +        type: u64
> +        doc: Device address of the retired VRAM page (e.g. DPA).
> +      -
> +        name: size
> +        type: u64

prefer uint

> +        doc: Size of the retired VRAM page in bytes.
> +      -
> +        name: max-pages
> +        type: u32
> +        doc: >-
> +             Maximum VRAM pages that can be retired. Present only in the
> +             leading summary entry of the dump (no address/size/status).
> +      -
> +        name: status
> +        type: u32
> +        doc: Retirement status of the retired VRAM page.
> +        enum: retired-resource-status
> +      -
> +        name: pad
> +        type: pad

And then you won't need pad
