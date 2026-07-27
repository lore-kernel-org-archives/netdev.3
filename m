Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24E53B14C1;
	Mon, 27 Jul 2026 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173121; cv=none; b=sVLcwL5UZSLYxYT9NvwJFrXHNmif6d/6QxcJINorrsNpZ1DIomWf/DwF8IkRlER07+bZE7zQgmLDquMGw/cs09ar+NV/ex+9UQB0FGbjRx9qrwJwb5pyEXrKnib+Y74ZA8KsmX7KQ2hDA/j4hShicj4srCKGUjwF/cWC0UZZaCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173121; c=relaxed/simple;
	bh=YnTFkd80tk0P+Wgp9kd4f4A9IariH27l0dHYr458dGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdMhhJyvYn4auGUN9KMTS9ZMbXXzvwuulgQBLcnLlyCH6wHE+R7AIi+AKlUbbzYIYxWLRsYT5pRV8JPyEQxBkK80VyXbUjFcaNDD1UECKLPLFIawv2rQcOM2iG1i7gCSseZvj5ItCXYQ9/lmwLJB42O7OMiQvAYkkkhpUeitWyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hr//TWcb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr//TWcb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052751F000E9;
	Mon, 27 Jul 2026 17:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785173112;
	bh=uqq1seJ2rJd2NxGYvSU4KyI8FNHbnRTWyMgpCIHcLUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hr//TWcbeP7dHjO+5vL1RyJW/zEooE4WiVGzl1A+V12YEEm1lYwQkwpwiFTLMxm34
	 FEt5pcUykZeuYEUu7YAhAE0Do30mUxfK+nMDxv1gYJHLcCaG12/cjlvyXmodxS2LKJ
	 TkxJF1JNSM9yzWesqsfdP2aFTH9Kw676622hqwhjHCoWST7Tu0EsTDJvon8dW5lY/u
	 Z38oxrY8fFpSvMXcAQ2/pniiRWfzu4WOVF7vzgtiuQAYGxaYCxVnKBaT4N4Imx3EAm
	 a+iYUOhSsct7e0pHZNyn4C2h5pxiEEOl0/1bDoND/mwfho2y84gatsfMCTIEAB+/ze
	 VXjFDU6zEBaMw==
Date: Mon, 27 Jul 2026 18:25:07 +0100
From: Simon Horman <horms@kernel.org>
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hariprasad Kelam <hkelam@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] octeontx2-af: Use LMAC_AF_ERR codes in CGX
 handlers
Message-ID: <20260727172507.GR418547@horms.kernel.org>
References: <20260722040307.3393236-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722040307.3393236-1-nshettyj@marvell.com>

On Wed, Jul 22, 2026 at 09:33:07AM +0530, nshettyj@marvell.com wrote:
> From: Hariprasad Kelam <hkelam@marvell.com>
> 
> When a netdev that is not mapped to a MAC block (cgx/rpm) requests a
> MAC feature, the AF driver currently returns generic errors like -EPERM.
> 
> Replace these generic error codes with driver-specific LMAC_AF_ERR_*
> error codes to provide better debugging information.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>

...

> @@ -1178,7 +1176,7 @@ int rvu_mbox_handler_cgx_set_fec_param(struct rvu *rvu,
>  	u8 cgx_id, lmac_id;
>  
>  	if (!is_pf_cgxmapped(rvu, pf))
> -		return -EPERM;
> +		return LMAC_AF_ERR_PF_NOT_MAPPED;

Hi,

The AI-generated review of this patch [1] flags a number of pre-existing
issues. Which I think they can be considered in the context of possible
follow-up.

But it also flags that the change on the line above (and other similar
changes in this patch) will result in custom error values being propagated
to user-space. Which seems undesirable.

I think one possible solution is to convert the custom error codes
to standard ones before they are propagated to user-space.
But I'm unsure of the overall effect of that on this patch.


https://sashiko.dev/#/patchset/20260722040307.3393236-1-nshettyj%40marvell.com

  

>  
>  	if (req->fec == OTX2_FEC_OFF)
>  		req->fec = OTX2_FEC_NONE;

...
