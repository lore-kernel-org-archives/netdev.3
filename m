Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5443C196B
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783031466; cv=none; b=akUMtfGYxhWAy6yWZXyyhKeTovhZ6AMzm9kGNEFRxbQUaIXBhky39vHYO6hP85GrblpvqQHHXmKTxOsVx42sqiaBAolYHc3baNpzHRTQwkurJF1v36BzX3cr0NLWqOEZXK3d7TV6jgW44d6Eurc/StB3SQ8VjKC5VtuDm68kr4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783031466; c=relaxed/simple;
	bh=zjJRlyMPqYkkzf2sX+4CDQKaI/eahG3+8u3eAkAj3Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KObFPHFAolBN5y4I+3JdB9ogq8cJXdXvvTP1pOIr0iZPWi3empChjMb1/P/MCdx+/9QSMs9xpeKkA8Aag0xomQ5szzScIo6Dxi+GWJ31zkaGDlSvv6KyGrMmeV/kl0Ph9MeN26Ls7WjWWPwYWeVayyuUQwRW+AXqWCtmxJsUkrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=sMlWBhJg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Aeb2Tr4W; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="sMlWBhJg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aeb2Tr4W"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E0ED87A011E;
	Thu,  2 Jul 2026 18:30:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 02 Jul 2026 18:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783031450; x=
	1783117850; bh=4HPa8Lg3Uy1GV1K58y9Bs1t4DixOxuUTq7dc1oDREPo=; b=s
	MlWBhJg7JNbjpm9pcIL3mqULj+snhA3lZjjvmOoSTEMVJmwGboHFCXR0DtSbRT+K
	SmKRuNHJZH7sQqut9EAlnS4zS8xjkLdHZKuyPzyPYNsXDsH8k2Wy7pJDR0fswjfV
	So34pAaRKND8HybHATllwAXY4Xr+Q6L5xCT1cext4SMwIGuqKlSx8AbzfjGMrjv5
	gVPMVF4zzfksyU3+P5Fmo/QPXjfmcm7M00GlF6UZ+XBBmziw2YtaWyLJtz5VI3wI
	oOclgP17ChcIBrt91TNjUQQ+ebuv7zA2jFKfiuxtfRpi0lrJM+SgCA05ie1lygbS
	Sv8WFtJNuHdpoHHblM2mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783031450; x=1783117850; bh=4HPa8Lg3Uy1GV1K58y9Bs1t4DixOxuUTq7d
	c1oDREPo=; b=Aeb2Tr4WvMyGRIUR1FXj2M88+JIiMAYZrw08ueJ19/lExqGW1o8
	afnolF/BJhnCfR2rwlE+1KUHvuEPR27OFlT+svtpFiael//cBA7Fu2qskD6/bAGr
	sfO0vYYXZ5x+TaOhkzg3qbbUwMe9He2Bzt0q1B4IPJrOG1BB3deGp6wNsf+bF0WI
	IHjnrBev4GrOGWB+Fw91t6dE9+jbd02xEqjm6dvMZmVffrnkIht89Tk2VqviwALq
	8c68vPgTUhCt9CyGjxNGN28aHXY7nGKAwuKjj7dkXlNMDEF/d2n8EF5EvyAEp6rB
	JSXnrLsX4XV/8X17e3Jov9KRzDMKsKSgKog==
X-ME-Sender: <xms:muZGaqNW6_y3TWL_fWpdGFnLI7xlCQ5s0gZWbijMoBO41b4T0L9OeA>
    <xme:muZGarg1AovWletUzyTW2ShqslJmyG4X_UUA7c3703rOaUGMR-OmQCF-JqyJYjY_D
    eRdb-V0VCZvgf1qERmgllLVrdSRFyLP3qtIoNX5kSgQR6QGqomdD3w->
X-ME-Received: <xmr:muZGak4E8sjaEhn2Fe1Y0gbX78h7mRQug81yqmuz9RR7kBJ0tRFrLBreCZE>
X-ME-Proxy-Cause: dmFkZTGxib75otGYDAE+7LTjVTMUvh7YtIOlwdsQbM96+W5ha/uoGsbJG5P05AOUHE9RBu
    L8IQG6YR96aZvWsk5aVetl/sVLlt3HdDJnqaP/T5p42DPWJcPXx9iltbuifU+9tloLYca8
    XDnx978dSkVq5Mm83bLTf3+BEtuCqzNYCJOzOQfgfN9HCv/u1gpIDx68eZJWD33ojCy69y
    cgojgCTWB3N97ynajkxOo41fvPi6DpTdEBiCQ+FTjxCN7wPIJdyqsDwRs313/aNZ8lInLr
    j3MxzWEqLTg9NVr13ZQti68QG75MoCQS8aHWvN7DPwMvfEloe2pLneBrTPrOR8ONNr2nF3
    z0CSmLWf409s1YPsw/43Z+KtlpusasLB7P68wFcUQ3Oklsvj21Y9LTwgzN0OvgK5U1ArH+
    /wP/g6ka8AgQ1OvVYu2/0q8EmZjS0VS7S2T+QIDhh5xvX1QqAdsUmbBJQn0UAhVO3kRJEI
    ChEmAIm8n2huLyNn1SmejBdGSRhEG+WEq3xUoZuB3WJueJvqu/ggl+2MMEnW9KKfwss5gh
    ySADr4gDGtS64pksVLt7uT1bDIUuQc4Goo8fqBRYQAUR1yz9q+BNp9w5su04sSeO3tXr+e
    JWBiD1xcVSxbKi4AFhBre1NCS/d16wf2QGhSjzG9cCvge5ez5dTUAAlXVEWA
X-ME-Proxy: <xmx:muZGaq2eXqjnUOENOUJvK5Mxc878yxWHN2USIPSMIdvPtWhdewanBQ>
    <xmx:muZGanst1YG-XZpQuMFxulq2Emr1-g36B0_tTj85EeKTCMVL9yBGdg>
    <xmx:muZGao6VpndAgZunrOu-utkHaPCYfODVMc-_URg3t0xpNtR6oxdxjg>
    <xmx:muZGarc9Omh3efYX2gzFLHiDPhzXDJBOPyddjAiKUoEGhjbVw88tzw>
    <xmx:muZGavehnMJ5TON_Yd_naVjQLd53hskGS5Z7rftJ_DbPkH6x7t_txQTO>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 18:30:49 -0400 (EDT)
Date: Fri, 3 Jul 2026 00:30:47 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next] macsec: no longer rely on RTNL in
 macsec_fill_info()
Message-ID: <akbml3DkpQJuVYZd@krikkit>
References: <20260701094341.3218199-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701094341.3218199-1-edumazet@google.com>

2026-07-01, 09:43:41 +0000, Eric Dumazet wrote:
> Add READ_ONCE()/WRITE_ONCE() annotations on fields that can be
> changed concurrently in macsec_changelink() and macsec_update_offload():
> 
> - secy->key_len
> - secy->xpn

Those can't be changed, macsec_changelink() rejects
IFLA_MACSEC_CIPHER_SUITE (as well as IFLA_MACSEC_ICV_LEN and
IFLA_MACSEC_SCI) and key_len/xpn are fully linked to the cipher suite.

But I don't mind the extra READ/WRITE_ONCE if you don't want to
resend.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

> - tx_sc->encoding_sa
> - tx_sc->encrypt
> - secy->protect_frames
> - tx_sc->send_sci
> - tx_sc->end_station
> - tx_sc->scb
> - secy->replay_protect
> - secy->validate_frames
> - secy->replay_window
> - macsec->offload
> 
> This allows macsec_fill_info() to run locklessly without RTNL.

And at some point, the whole datapath probably needs some READ_ONCE()
sprinkled for those fields, too.


> @@ -3928,13 +3929,14 @@ static int macsec_changelink_common(struct net_device *dev,
>  	}
>  
>  	if (data[IFLA_MACSEC_WINDOW]) {
> -		secy->replay_window = nla_get_u32(data[IFLA_MACSEC_WINDOW]);
> +		u32 replay_window = nla_get_u32(data[IFLA_MACSEC_WINDOW]);
>  
>  		/* IEEE 802.1AEbw-2013 10.7.8 - maximum replay window
>  		 * for XPN cipher suites */
>  		if (secy->xpn &&
> -		    secy->replay_window > MACSEC_XPN_MAX_REPLAY_WINDOW)
> +		    replay_window > MACSEC_XPN_MAX_REPLAY_WINDOW)

nit: no longer > 80 chars

-- 
Sabrina
