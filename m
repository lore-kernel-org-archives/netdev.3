Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718CD246788;
	Wed, 10 Jun 2026 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069829; cv=none; b=G2aZnEbj898Oviane7HK0DPByDg71k1AMDHm1PDdfYB8Y90gcJbjy+1HyObrFw2g7136NzB73tuc+aVb5CT4Vvu15tDU4/aisMOaEDXNdjCjpm5BZ4xMOtYO562Vp1xlYOJJOMiM85ft5f89zAtFADJdExPjSNWkuddSv5E/bcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069829; c=relaxed/simple;
	bh=r0zIRam0HY/RGCuXi86KtxWTjO2YQuTrsB6Nq9lKnlc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6/VU+hl4MaI6/Guz/aSvNGbXW12qpbcGhkmvvbL3iZkY/NzIYOwaFXuG/P3C1WxYXX0xj3FPuwBpRVt0fxvjKxVgaV9x9N4lCD6Ytdjo+6v9IYIsdcxx34Khr6hShZc27G0RV0LwUHSvtgERlyTHPa7IHwpFEyotrzd2RML3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Mv88YLx3; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Mv88YLx3"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5272C20743;
	Wed, 10 Jun 2026 07:37:04 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YchcY681ui08; Wed, 10 Jun 2026 07:37:03 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B5F392065A;
	Wed, 10 Jun 2026 07:37:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B5F392065A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781069823;
	bh=M8q7M9x/uyiIw2ivZXkSif9yz1VVIbf6870JsMhgCoE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Mv88YLx3apY0MhVoUZqHZTLeEf+7m1lQrLkNrSa1+phZL0E7d8/3iq2OIKwOU6w4t
	 24HRmOETmQTjbA19eVv0tRO6IQDDY7gnIIwizFR7y04gC+jjBxEl1/z1Q3kPh9mcfZ
	 wRt4fd+t3F1e7yNGQRWPelYhm4j1vUvkUAiiya367WCkTHSH8fz252Z/j+FnPkfNCe
	 EXL90cZj1s8aqK5734mWreMiDAbUpPkFVme6eTX7CUuOX09Uf1Q2QU+qNxduVNA9EJ
	 edK0A3yBWp7uh3ynVlzy7gEJcGoeWEGhkDK5Jwp9clSgQ5MGoUF9UuNAxLiNkzPvvX
	 n6LWmXKpv1M/A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 07:37:03 +0200
Received: (nullmailer pid 2119962 invoked by uid 1000);
	Wed, 10 Jun 2026 05:37:02 -0000
Date: Wed, 10 Jun 2026 07:37:02 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Alessandro Schino <7991aleschino@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ipsec v3] esp: fix page frag reference leak on
 skb_to_sgvec failure
Message-ID: <aij3_qm9x7LJUfbG@secunet.com>
References: <20260605122215.825-1-7991aleschino@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605122215.825-1-7991aleschino@gmail.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Fri, Jun 05, 2026 at 02:22:15PM +0200, Alessandro Schino wrote:
> In esp_output_tail(), when esp->inplace is false, the old skb page frags
> are replaced with a new page from the xfrm page_frag cache The source
> scatterlist (sg) is built from the old frags before the replacement, and
> esp_ssg_unref() is responsible for releasing the old page references
> after the crypto operation completes
> 
> However, if the second skb_to_sgvec() call (which builds the destination
> scatterlist from the new page) fails, the code jumps to error_free which
> only calls kfree(tmp). The old page frag references captured in the
> source scatterlist are never released:
> 
>   1 sg[] is built from old frags via skb_to_sgvec() (no extra get_page)
>   2 nr_frags is set to 1 and frag[0] is replaced with the new page
>   3 Second skb_to_sgvec() fails -> goto error_free
> 
> Fix this by adding a bool parameter to esp_ssg_unref() that, when true,
> unconditionally unrefs the source scatterlist frags. Since req->src is
> not yet initialized by aead_request_set_crypt() at the point of the
> error, the source scatterlist is obtained directly via esp_req_sg()
> Existing callers pass false to preserve the original behavior
> 
> The same issue exists in both esp4 and esp6 as the code is identical
> 
> Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
> Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
> Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>

Applied, thanks Alessandro!
