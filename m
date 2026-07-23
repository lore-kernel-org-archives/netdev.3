Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A43C0634
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784851100; cv=none; b=sNaopRG97VgpGuFn8Ns66pydSjqWOofemtBO+hCvYGVpeWC1ELFlAAi6QunpEhNWHGH2BdYeHuVsTxoLpbCBpPtSnDfMneuyAl4OQ5OCY0Mfjnd2sFHFxQwb6wXQtJKz3PRhJUWQwguTK9l6SvApufqh4hbVu+GJZcxaQWASWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784851100; c=relaxed/simple;
	bh=K0m0Bw+juA87MvkMrxX6h4japgSDmVkJYZY6q2X099U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ib66PuFLEipZY8AZ9BFy0WR8HAGXbMOrWmFC3P9FMQRLt48Bzt5v8jTlmwZfyELyzTVNd9ChXHr+LyyZkUfw9I04NBYoQ3Qdh5GgLP05c/E6ybqQbeEXmFRFSwfCTJmpPuOLoyC7rvURkwO5qMN7JxweCTnLDi4N8tRMlJRgLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIxI5L7s; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIxI5L7s"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccf2360620so12455845ad.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784851098; x=1785455898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o9MA5hxyHF+TVODI4Fw4gloLACgAEZ6Zp8N9Sn3aTq8=;
        b=UIxI5L7sngoQnsTOl0k8ykJp+v4Q0IEGGCUJPD2hEH46hIp7oJU3w67FBqYvgs7Bit
         cLrV8+J21fMubKmBoaEJjgjZgUvoHewJSetvAYTk968OXtf/QpHOaUt+eFV5TSGxoUre
         /419Xfq6Kd2X+7OpLBqO/NDdsFRUd/SfXiwQe9+9P8ClFJ+KWsWX5g0sfdS/287/IDFs
         s40RUaKG6Bfz4jWnnJXuxfHyM0p2rHZYW8Ypgjl6TNYYKrbB+7ug6WaQjPWpFuEVcGeB
         4BdRbnldbR80AcNwiYIzouDoUmlyK7O7fNrQYMhzmuPQjy+6vkUbAIetIAJOjSWIh11f
         Z/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784851098; x=1785455898;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o9MA5hxyHF+TVODI4Fw4gloLACgAEZ6Zp8N9Sn3aTq8=;
        b=XuxzSH9/diCeTSsikNAq2MX9TAjSOarMFv4tAAB+xgTsWTxcJgOoNnKPRIhlTnsfZC
         +fVgJFtDKeMiIhNGiyuPx1UzRJt8H+IdMk6pfcVSyDqPfNED0iaKOEmjIUXXt0eaHynu
         54rx08Xj5nKaY/3UYFCbX+uubxGN6hIBWyXQnuKaLPAh9SZDL2R/2Jtun2l5WlasNwZA
         7D/VU4KmTTz7FcsyTud2GhIW7lw2Quaq/E20i/xT09pZDyhZJlaLhRljeU1hXFI1skzC
         /8q/YfjZiLWGNcrVWh5UfBZBMJBwq2I0osObaeoqDsc+RyRYu27JN/K1fSSH9OpZ02JH
         rn6A==
X-Forwarded-Encrypted: i=1; AHgh+RpzHvR/CONp37EFJabA2K8nME1t3w9+bw2nJo+KaSt3+g+bCbpfCk9jlm+Xxkjtv2lb1AHj1S8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwixTzRKvbq/7BFc4a4Sh5S8Osn8GM2jWkVrupoqmXjRc2By/kP
	CMctqYcM7GJcjmdV8Dgqw9qDF7Y7R4ezTDN0WeeXENzZRjJAIwnCmcNs
X-Gm-Gg: AR+sD12fEdDTieBB1ZEVSsP5kTGPijupt+fLoDoQkRqafHk9fw+kR2xC3DhF+BOqLu0
	JuC0i2HhDyXnhdUUZs5j2vValsGAtIY+WE4f+jhhATn+6r9znxYycAdEL+TgB0zk0Wzd4vbmE/G
	1Tcm5tZA0Sz+Dy9ayL9hRtaG9ZLpOzBV0tDSUYToazzVR/m+JQhAi5HNFmYaw34ZjriO2/Upx4R
	1EzctmatQiZVNATdrYeoAjNPpUGWrTX1zAHjWGeP2OJT7aVT7YU5gYIqzRucXJBmQCiVnmbUedZ
	+/MLQU2ETr1pFXJ/STq2XSNbzB/di2VUhxJotrTW75kwJk/sWVBH/dTlS7LOanDuJrCTV3l8yHJ
	5c98u/w4O/beeVe+XofJBu5dpYrq766CHjM8/9LKBOvp6CsYzGbx8cLf0dGGt23WFxBLHrCbqyO
	vmKlm70dxPu03CfranJH8m7A==
X-Received: by 2002:a17:903:1b07:b0:2ca:b8fd:f31 with SMTP id d9443c01a7336-2cfa6b77a8fmr64729945ad.15.1784851097746;
        Thu, 23 Jul 2026 16:58:17 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f3131b0sm41548075ad.62.2026.07.23.16.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 16:58:17 -0700 (PDT)
Date: Thu, 23 Jul 2026 16:58:14 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org, sdf@fomichev.me,
	razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
	matttbe@kernel.org, skhawaja@google.com, dw@davidwei.uk,
	Joe Damato <joe@dama.to>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 1/3] net: devmem: allow rx-buf-size >
 PAGE_SIZE per dmabuf binding
Message-ID: <amKqlqgfZipKjrii@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-1-34bf6fac941b@meta.com>
 <20260721110713.325d36ba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721110713.325d36ba@kernel.org>

On Tue, Jul 21, 2026 at 11:07:13AM -0700, Jakub Kicinski wrote:
> On Wed, 08 Jul 2026 15:55:04 -0700 Bobby Eshleman wrote:
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > index 5f143da7458c..70b902008bd3 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -598,6 +598,13 @@ attribute-sets:
> >          type: u32
> >          checks:
> >            min: 1
> > +      -
> > +        name: rx-buf-size
> 
> rx-page-size, we're modeling device pages.
> rx-buf-len exists in ethtool and is something else.
> 
> > +	if (info->attrs[NETDEV_A_DMABUF_RX_BUF_SIZE]) {
> > +		u32 rx_buf_size = nla_get_u32(info->attrs[NETDEV_A_DMABUF_RX_BUF_SIZE]);
> > +
> > +		if (!rx_buf_size || !is_power_of_2(rx_buf_size) ||
> > +		    rx_buf_size < PAGE_SIZE) {
> 
> we should add a check: min: page-size in the Netlink policy?

I played around with this adding:

Documentation/netlink/specs/netdev.yaml:
 definitions:
 +  -
 +    type: const
 +    name: page-size
 +    value: 4096  # dummy value, to pass ynl_gen_c.py checks
 +    header: asm/page.h
 +    scope: kernel

Generating:

+static const struct netlink_range_validation
netdev_a_dmabuf_rx_page_size_range = {
+       .min    = PAGE_SIZE,
+       .max    = U32_MAX,
+};
+

... but the dummy 4096 is kind of annoying. ynl_gen_c.py can't know the
value of PAGE_SIZE but needs some value for its arithmetic checks (e.g.,
confirm min < max is true).

Should we stick with using a dummy value, or should we add a patch
teaching ynl_gen_c.py to allow value-less consts (skip the arithmetic
checks)? 

Best,
Bobby

> 
> > +			NL_SET_ERR_MSG_FMT(info->extack,
> > +					   "rx_buf_size %u must be a power of 2 >= page size (%lu)",
> > +					   rx_buf_size, PAGE_SIZE);
> 
> This must point at _ATTR, the _FMT is unnecessary.
> -- 
> pw-bot: cr
