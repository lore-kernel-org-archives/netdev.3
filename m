Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DF24BB275;
	Mon, 21 Sep 2026 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004302; cv=none; b=uT1wC6pcKxk8ShObR8y4ElNOgeF82YeAvloybEzvR8bw/lHK7hU2aGQS+ti99gajYCmnkWc+CO62GL5DY5Dv0YwZrMxGX1rRcKODEWdG2TVOgtKmsvuPHmN03C8jmC8noQWLHhOqJkeetEIAYWllK9OQWMP1hmEuW9p3UhwNQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004302; c=relaxed/simple;
	bh=ttbC6zCwgzrP40c+b/UQj0nk3H5rvAsLiOR2L/Aiu0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvNi0ExR57QdzYGryArFrRge30bIae9k0GZVR/RJqLfOss1xfegjIFHxRY5K5Z8kJ1A80fxXkKrqjM9niRkhIBi12eQUKndzV7p3blvPIcPDKopaqh3Pq1H6FI65Kn53MszYAevaa5zWnAXOykUa9EWm8D9G48Xjov84o+FcgoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=TpE7Kdhm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QC1gijtf; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="TpE7Kdhm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QC1gijtf"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id C44BB1D00087;
	Mon, 21 Sep 2026 11:24:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 21 Sep 2026 11:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790004297; x=
	1790090697; bh=g3UG4kiZRtZUN7Ufu6fIkiu5YCGAlZvgz7XEvCSO/VI=; b=T
	pE7KdhmBxdtzZyZLNXIMoJYH9K1SQZXzJGl2o1N9nMe3sg0NHz+ccWmfJiHg/1xH
	o3UDoDeZNmCc8wMS7YRC2oq/VU/TzOyFS4ZKk7XW78UUbBg2+O4Q+yEA7rHAUrt4
	sGGc2yQJiq9ymy3lSGAZ6ms+vOr9k3zmITJGlggmM1nezeVta5MN1ZNiomD4U8z3
	v5cwssQDE/r2vqYy/rNIeJlnnloqgErNLF25c77jd/prYZeRcwMBTslnTOpCpGYw
	lDDBpD2SuinFMD+f/AEZT+s5TDuhnJWQcF5KkAOXz1EL1b4UQBm7EteT20KSyTcZ
	shoFxxMFJ743/TXGceerQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790004297; x=1790090697; bh=g3UG4kiZRtZUN7Ufu6fIkiu5YCGAlZvgz7X
	EvCSO/VI=; b=QC1gijtfEmk/+3j5hb3DQ4/lkzy9yrNoCw1ltpgLWrcwKBjX5NA
	asfuvxBIDGUM5eDaxplTRXb/BqKWaQL6UiPA8mk9+woBg5GpPHT4xHyJdeDCuueZ
	InCHrat3d5MXdSvfsliNIhHyESqyprv9BlQ/3UkrxaP2Phqj97B9jLHJayEHM4GB
	E76TjGICGYqmLrC7Xvi17u9Rl/TPURxnup72vFKdSsYl8+nTqyh5zZZV5ugh7DEp
	Pvq0DPVn46FnDK+pT1l9eVHOZ2IDJOVw8BecYuino5jHbgwb80ZBz232p55ez9Oo
	qRhOoT7pogI8rFNIaSogqelRrb5ybCT2Q4Q==
X-ME-Sender: <xms:SUyxasJBG4TjaFoAZhvbPKUSMqm8AqqQcszdH3DK0_EONaGmSKoHtg>
    <xme:SUyxaosyUw-qDr-IugsBElqU6EpTZCNIYm0f4NA3rSsO2RnkdlDtGLBVu-OLqzFFY
    njzp3HyWPAb7bspiskCIyy0hv-FiP-3DgUwcIsiJ3HYlZO28PUjPN_H>
X-ME-Received: <xmr:SUyxahKgn9uSIxOYoyfREtrF5fB4hLjJ8DI-8F_L1pNjd9dnHAy-Tb09kQWW>
X-ME-Proxy-Cause: dmFkZTG4jQoV4kPajQnTia3Ot5JBo3ZjTn/YU3Q6P0GeVaNoGLkluWv5oqhKidaE0ptzm2
    0wsB2YueA0zgJ+CCbfnKkz5k9t5QqSEB0o0pAqxfHygQWNaqalwxT1p9kk9ha3n6ohYxKi
    8A5AiqC34k673vuaP8n5gWJXoV3lr1M/mWQdo4DGscS/IHjFVNZA6BpR1Wi5tFdbml9zAx
    bkyKbBFKahv3598sSEgjBk1rrXcpaEJykb+tJhC1UD7uN1iG4Ynlk8q3OhRshL4I/+YutK
    axxpwtStZTLkrg63yxYhqUAJ8dMlbhMROIPGa858nv/8f59DHRlyQw9qfsD1ksolHf5yHi
    tZYvZBA6DrJlN1jMGNSfZCipnCFXm/v1dp2Z6hnYyVyy0wltezbBB3ImDgcmQ329bOLQce
    53zIahvEttagjcWcWcZva5QIymZuMnRTjY/aQQYmOYtO7UaRHGz/yR4gqatRpar6yt82ai
    h8or2opkhQVkSRG4+Ithfc7fmIOClWM0xA/6iHq3zdmuVCKeXHvbp5820vDg2Iphg09GSe
    K2uA8A3w/Pc/iAlmzyoXXMYNAD+G34S5IT+Ylx5TdEQKTZMWNvTxyKLEXaHBVcGoAJsXxb
    +xIGQoTZ/qYfhO59faUf5L9d8aN8TfjpQbtYaeab37MAXBRwCltSMsKP2CBQ
X-ME-Proxy: <xmx:SUyxagNV1ElwwYBrHd44a36DFg7oBodCRNNo-jpHEA6gPT42nyYlAg>
    <xmx:SUyxakW8qoi_Y1duhAET8YHT8MTZQ3DjbKC0FOJ_h7xia5AMi5tBNw>
    <xmx:SUyxaumedtRXk_NYVlGD24pmzOPTl2Rb6kZWb_McOY0ipALfMswpaw>
    <xmx:SUyxajNo0ymv7199Ob2A0g9naC4mMmdBHIyWGAxqrFu3OkwfIJMYPQ>
    <xmx:SUyxaummH68nIzzARcnbJ-g0UT8ZfNU-_YRPMghS__bxAjjDpZv5v6SE>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 11:24:56 -0400 (EDT)
Date: Mon, 21 Sep 2026 17:24:54 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hui Peng <benquike@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfrm: validate protocol for XFRM_MODE_ROUTEOPTIMIZATION
 in verify_newsa_info()
Message-ID: <arFMRlQvfjkzHU64@krikkit>
References: <20260919215239.3471352-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919215239.3471352-1-benquike@gmail.com>

2026-09-19, 21:52:39 +0000, Hui Peng wrote:
> In verify_newsa_info(), XFRM_MODE_ROUTEOPTIMIZATION skips the protocol
> switch validation, allowing IPPROTO_ESP, IPPROTO_AH, or IPPROTO_COMP states
> to be created with XFRM_MODE_ROUTEOPTIMIZATION even though only
> IPPROTO_DSTOPTS and IPPROTO_ROUTING are valid IPv6 route optimization
> protocols. Enforce that XFRM_MODE_ROUTEOPTIMIZATION is only used with
> AF_INET6 and IPPROTO_DSTOPTS or IPPROTO_ROUTING.

That's really not what this patch does...

> Fixes: 060f02a3bdd4 ("[XFRM] STATE: Introduce care-of address.")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index a2587c7e796b..2be800232847 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -698,7 +705,9 @@ static int attach_auth_trunc(struct xfrm_algo_auth **algpp, u8 *props,
>  		NL_SET_ERR_MSG(extack, "Requested AUTH_TRUNC algorithm not found");
>  		return -ENOSYS;
>  	}
> -	if (ualg->alg_trunc_len > algo->uinfo.auth.icv_fullbits) {
> +	if (ualg->alg_trunc_len > algo->uinfo.auth.icv_fullbits ||
> +	    (ualg->alg_trunc_len & 7) ||
> +	    (ualg->alg_trunc_len > 0 && ualg->alg_trunc_len < 32)) {
>  		NL_SET_ERR_MSG(extack, "Invalid length requested for truncated ICV");
>  		return -EINVAL;
>  	}
> 

-- 
Sabrina
