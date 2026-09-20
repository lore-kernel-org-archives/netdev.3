Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E923A6F06
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789919891; cv=none; b=il9DTmIOoPgVyJq3jC3hEPvPuy1yNakkxg4G8S4vWUaqmfv779RNj8HabyR5sqZL+XWgxOrPeNtodGS2tVXC+0nLL84WP7lfhDWQAcduNJMhx/N7mlX9G0Y8+u0DLat5iLedcP7Sr8TEnaXRFYv4XHcj7Xx4mFgHx8BLiDDU2dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789919891; c=relaxed/simple;
	bh=YI52QG6qOsUffbKiK5MX4rqAWZ7lmS/CfFvLIe/UQxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNsOLIZ4nZ0aoK4c7uWdoR1RbDG6M8AqKsEd6/IScIU0fFLgtlhTBsgQQGMChfbjO/mGQFeesiO7Dv/DI9JMkx+Rwnhz24NgPwrwYPxvxuJQDonlTpzqQl/Sur6RihVtUT+ZwhYgy2n2m5g9eohFYDeHh1Cr02NIEHHsHUWwfr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=b842Vz6B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FkTCVAJ5; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="b842Vz6B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FkTCVAJ5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A5C51D000B1;
	Sun, 20 Sep 2026 11:58:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 20 Sep 2026 11:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789919886; x=
	1790006286; bh=ObKVVqqjFY5FTlrwFv8pO0OA4ydnQaM3MM3R6yNiGiM=; b=b
	842Vz6ByWLZZefQ+ExBgyEsBciK+hjJAN170IM9T+w8uaiZBBeCaghazHNv2sG+f
	rU6o+SSyJFtwSYWW3zA+dAAt7PPvhTIfJ8oLhbpcuPCR8eRtuzDK0hHFBVreZrz4
	WCLZDCyGw3a+QfUzf4KwLkwDmb44X3DPqcj7qphT1qLyuO5jNv0Pxugn8HAvyGSB
	oN9PtAawlRl0ZgNevu7T/C8Aal+BSGKIMMq5/KHMTGyeZiOuggZZNrskXgOOGAHc
	ABNdsSHBOniSmg/Q7ABd3N1hiN4HeTcROUDQlwj4y+gHNz23wd/nyw0WjDZlK+Df
	8p0QEYkd0+ibDu4JpPIIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789919886; x=1790006286; bh=ObKVVqqjFY5FTlrwFv8pO0OA4ydnQaM3MM3
	R6yNiGiM=; b=FkTCVAJ5kS4uVZv8xVh9H1H+V+QxXYoBGpkVM/pgLxDKKkG9W7/
	xplMkVkOFcnCox7Ey50ugW4ciH6PP4Yq4ZrONxEqzY7Jo4jqVhdgotEHeKpTH2FP
	1ekP5lVQK4YEMo0YHsMVI+nWjNMSvgboXZgW+e8yZFm276xr8mPTjI/vaA84OY0p
	ayVhDFE+PdbP45gu1B9n2p4TZwjNLSwggiob7d469tjvcIIJASNhrFTUV5s/vwg4
	vtIhTEbOMvRhb1NRNVlvycH7oSFNKJkyGOAXx7MqW7JWv7S8kTej0PWaBncgp6Kl
	/unN5djPJACEYiPgAoIvDd1BnuH2kR/woUA==
X-ME-Sender: <xms:jgKwahSiklMkppmSTqubH4fUPtDKQe2WmPmpd0kv_On3AdmTZiugNg>
    <xme:jgKwap315aPZ2PAdfVvIRbI51QE9IThsZzj2xe0XvApwn9kq6dTT_cORdYPcXnWBP
    oa818k5RD9LvHYutp9tLSvRaLfwMDkG0s9kjbR0bTzc1lsc5fy5bZZt>
X-ME-Received: <xmr:jgKwatBf3YkiAnuPHVFeguwD9CWqF1PXr56FY5L12Ad5S7LMXDNAvDhhQIlN>
X-ME-Proxy-Cause: dmFkZTGyQOeWXF02o3Y9CYoAN/BXPyoh6SjxJn84sCMCqQLkii6PvNj8ml8pSRsTJ635kJ
    BOnrU2AFCB03boZViUFQ66DI+vRQzqsbd3RqMUzyeTUGO7vea8ibYIkyRBFmgxeY8/D3yj
    Or41rqqDBTEa8pX9gB3mdsYnk3J07dZCNHgncrEQZkKZorkuIFl6mwOwi8t8Z6qYj28ELY
    XwR7FOFaZ0NyqYM6byL9NP/qh5yg9716PNxSg5xKjg4TXlaxZNBAmNfRz+6xn1z3clLR00
    b/AjarbMdEnkVih1pLIR+liBsl72CHlRZS5FMheY5BrGM/0lioDQxNwDQC8i/7c32cN1Wh
    0SSM1XBATZTpBQxj9eaIUaNXrqi5F78b0YN4sitmnokSUZFVzA4E2cy3HZndRM1BdW/7cz
    KQmX7vd+E1eG6+4bV3PS7xjzj951J7eYhZ3kxjHIhadT8y0MwVEMoEqqxHKW5DUdeIyAvY
    K/NqIKzv6rwEbw+vC4K57u7v6v4Bv6ooJ7uUpbpEBWZkkCnu7VZq1l3wTY71qNqXkvHHcq
    KL7KH0u74NbnctH6SnPNk3QrpNYxR0zZioo7qCGKK6eiCpC7o6C84k6Ha8owC5jlEt/jMj
    N2oHelTP9JIGosmp2opLcPBL8lggtiOdENuHTi2c0B+LmMxI6GjP99mXplDQ
X-ME-Proxy: <xmx:jgKwaljJ_7_8DD4pfch9J_3edLdHkfCyYALtIhPb4AfyjZywO0k36w>
    <xmx:jgKwavNYLKRW0qn-jNwRUkImCQAKgkrD_0jZLdzjkxdra60tyU59iA>
    <xmx:jgKwal8viFmaDYcGBkLwsvOU2JPXC7TDaqxhN36S3oT0a3jisQ9bsA>
    <xmx:jgKwagfW4gmyZMRZeTN0ae8oM_TMcQ8D7xP_DLIUtskRSwa2wsSMnw>
    <xmx:jgKwakTr2IbXh3DL-l6ID0h2Ul8ajVPoSWj4DhKoaB6STL_esbJkCXVu>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Sep 2026 11:58:05 -0400 (EDT)
Date: Sun, 20 Sep 2026 17:58:03 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>
Subject: Re: [PATCH net-next] MAINTAINERS: chtls: remove entry for removed
 driver
Message-ID: <arACi2B3kvRaVLHa@krikkit>
References: <20260919-ch-maint-v1-1-76af77aca5a4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919-ch-maint-v1-1-76af77aca5a4@kernel.org>

2026-09-19, 09:24:19 +0100, Simon Horman wrote:
> The chtls driver was removed in the v7.2 development cycle by
> commit cdae65fc43f2 ("tls: remove tls_toe and the related driver").
> 
> Remove it's entry in MAINTAINERS which was left behind.

chtls was removed, but inline_crypto still exists

% git ls-files drivers/net/ethernet/chelsio/inline_crypto
drivers/net/ethernet/chelsio/inline_crypto/Kconfig
drivers/net/ethernet/chelsio/inline_crypto/Makefile
drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/Makefile
drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.h
drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/Makefile
drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_common.h
drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.h

So the entry shouldn't be removed.
(otoh, the rest of the inline_crypto driver seems as well maintained
as the chtls part was, so maybe it should go away, where "it" can be
either the MAINTAINERS entry or the driver)


> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1a3ec390096..59ee1cff04ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7091,13 +7091,6 @@ S:	Maintained
>  W:	http://www.chelsio.com
>  F:	drivers/net/ethernet/chelsio/cxgb4/
>  
> -CXGB4 INLINE CRYPTO DRIVER
> -M:	Ayush Sawal <ayush.sawal@chelsio.com>
> -L:	netdev@vger.kernel.org
> -S:	Maintained
> -W:	http://www.chelsio.com
> -F:	drivers/net/ethernet/chelsio/inline_crypto/

-- 
Sabrina
