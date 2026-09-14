Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5D3B42F9
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379875; cv=none; b=ut5HwMOBbKqDCHJ2lqFSShieyFCnRb+jNgzE6wGSVvgSRFSC1DVpBcRy52XnuQUiiguUYfXa+Pyx6Hfd9WtccsnubDl8JXaq9s0+EWfq3hW4Yoyv1wJKN5NyfR6hbO57BxwQ+kY9B3umhH/D9EPoVUSiUE3/X8tsZxSh82yiPfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379875; c=relaxed/simple;
	bh=ZuYRaUxuHQtq6Jk+qbTnMeV3MZhwMqN82Kt98XtvfdY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anK9mWpRw5EmpoTRi7SRvBr5vllvvE8tclbAGABHs265YuoF6fguwAQVxLntM0v/4lWhxX42kZzEI54KdHsgK61LMQYQt6HRAl6ZNFYxep6gU41nvuNIG/p8dLr8mQXiKH+nJyLo3P6UH/CTAS3z0fqJ2gpCZ2/8GJ0LQVuzZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=mifipakX; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="mifipakX"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8D36E205E5;
	Mon, 14 Sep 2026 11:57:51 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IHOkA1iAlDRl; Mon, 14 Sep 2026 11:57:50 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A889520190;
	Mon, 14 Sep 2026 11:57:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A889520190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1789379870;
	bh=5hTUNR6MfceJf17ioOXyKyR2xJJx6neXU1mZb6Cwa5I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=mifipakXHC9VmRCo7G772/St0vaMt+EhLMFPDCgtQiCRzWDIQugvu9BYz1LsrBJkx
	 QtKHg68cquyzElQYeP/wIaSj4/MN74ZxNH3xU8PtjlGIYK+NNyk4d2QkagtCvNhIJC
	 HiFERkkKz4cyJQMs5JzrkRnk8MhJuQakdAFItfKZUwPqs/4YTjM/PruxVBI3dI+Kqb
	 d1uSOSkvDql5k2YN8gUc7p1rHeqSMbdCYBtojymG8Oj67bG6f10MO3NwRBErvhJ+la
	 ib5yq3bgr4E5ZkVxn9Paxn72cnAaxO8bqivheNb8LOrN0vDowVLJNmt7fUiiyjup2y
	 tp66EIAdRRRbA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 14 Sep
 2026 11:57:49 +0200
Received: (nullmailer pid 1885832 invoked by uid 1000);
	Mon, 14 Sep 2026 09:57:49 -0000
Date: Mon, 14 Sep 2026 11:57:49 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, Cen Zhang <blbllhy@gmail.com>
Subject: Re: [PATCH 10/12] xfrm: hold net_device reference under RCU in
 bundle creation
Message-ID: <aqfFHUcFsQyS10So@secunet.com>
References: <20260907093020.2228346-11-steffen.klassert@secunet.com>
 <20260908224901.1591334-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908224901.1591334-1-kuba@kernel.org>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

Ccing Author of the patch.

On Tue, Sep 08, 2026 at 03:49:01PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> xfrm: hold net_device reference under RCU in bundle creation
> 
> This converts the dst->dev reads in xfrm_bundle_create() and
> xfrm_create_dummy_bundle() to dst_dev_rcu() and keeps the RCU read-side
> critical section open until xfrm_fill_dst() has taken the device
> references, closing a use-after-free when a concurrent RTM_DELLINK runs
> dst_dev_put().
> 
> Link: https://lore.kernel.org/all/20260820200245.44312-1-blbllhy@gmail.com/
> 
> > diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> > index 932a313b9460a..513c9f2283347 100644
> > --- a/net/xfrm/xfrm_policy.c
> > +++ b/net/xfrm/xfrm_policy.c
> > @@ -2770,9 +2770,12 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
> >  	xdst0->path = dst;
> >  
> >  	err = -ENODEV;
> > -	dev = dst->dev;
> > -	if (!dev)
> > +	rcu_read_lock();
> > +	dev = dst_dev_rcu(dst);
> > +	if (!dev) {
> > +		rcu_read_unlock();
> >  		goto free_dst;
> > +	}
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but should the same treatment be
> applied to the other dst->dev reads in this file?  The caller in the reported
> stack trace, xfrm_lookup_with_ifid(), still reads dst_orig->dev twice and
> dereferences it on the nopol path with no rcu_read_lock() held:

This is no regression introduced by this patch. Can be fixed with a
followup.

