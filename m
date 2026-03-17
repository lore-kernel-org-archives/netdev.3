Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA91B36164F
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739875; cv=none; b=RRoXCOrlt+v+S7YeqFm/0k23fQaaDxO/HvlHWAkOwvn3rLsAcfdUrQ/DeEQi+e5+FSwcdmYCQA3zZLjuDhRr9WR5OQtudcOCmjqRFBxWl9f/HVu0SVlYddnfpTwUsUrkV/AM7+KZ/3Jv5x9eVgK9wytToClebG7Q4h7cjNdiYmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739875; c=relaxed/simple;
	bh=bRE/EtH3xPYe8k457Z7er8BWyQlZxCv1IfN+A1qtpoc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEbkEvwNtYgMbMLADKGOj/a0ESBwpM+2M/4SaN3OcHSiKLhyoAIvP14q54OPUmrKqTlcHVjd7LxONfSI15hyl1Bgsb12+kbumzRnw+jqhObrkri4ohvqOqNVPxWqifIGGTTSIwf0uIGSNSiypn+25pwdrvlt5cGJf7XoVnVin9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=fKoexbSL; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="fKoexbSL"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B299C207B3;
	Tue, 17 Mar 2026 10:31:10 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UfAyDrfqQm8f; Tue, 17 Mar 2026 10:31:10 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 2E01F207D1;
	Tue, 17 Mar 2026 10:31:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 2E01F207D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773739870;
	bh=PI3jjADnzckh9xb4VbsB8JreqJnn1LrgTwTj+GjbA5M=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=fKoexbSLwf/lt5JYeIcFOjaBMsm11RagbYGO4v20a24zuzmAlkJHitTaWHGUOE/F0
	 Hm4aGGxT2W0dPlevXkn0TWnfqZ7H4CCCenBLsbE7DJCznrHdWIRIsjjVbmIKAK379v
	 S2B/MWFWLxfCgGZHvM8F1RIubt5XVgHEjACNd6Cm5dpaAWv8EW50ASl2IX+SVG3DTl
	 OoRsjEX4T9XG1IAamDpoM5h0ptmVrWu42nid+QKBD7JGKzXfzfdOIMQ2DGcvMECFnz
	 eFZiOr2l2seBm2/4WyAfLKAb7DgtFc1SBQ8F19pv05UnnUpPvjlvbhvidGouSp9oGV
	 nc+3pTdkwwLLw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 10:31:09 +0100
Received: (nullmailer pid 1454644 invoked by uid 1000);
	Tue, 17 Mar 2026 09:31:08 -0000
Date: Tue, 17 Mar 2026 10:31:08 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next 00/10] xfrm: fix most sparse warnings
Message-ID: <abkfXHGMMk64xuQz@secunet.com>
References: <cover.1773051558.git.sd@queasysnail.net>
 <abPBQcgtrZh9sGCr@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abPBQcgtrZh9sGCr@secunet.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Fri, Mar 13, 2026 at 08:48:17AM +0100, Steffen Klassert wrote:
> On Mon, Mar 09, 2026 at 11:32:33AM +0100, Sabrina Dubroca wrote:
> > This series fixes most of the sparse warnings currently reported about
> > RCU pointers for files under net/xfrm. There's no actual bug in the
> > current code, we only need to use the correct helpers in each context.
> > 
> > Sabrina Dubroca (10):
> >   xfrm: state: fix sparse warnings on xfrm_state_hold_rcu
> >   xfrm: state: fix sparse warnings in xfrm_state_init
> >   xfrm: state: fix sparse warnings around XFRM_STATE_INSERT
> >   xfrm: state: add xfrm_state_deref_prot to state_by* walk under lock
> >   xfrm: remove rcu/state_hold from xfrm_state_lookup_spi_proto
> >   xfrm: state: silence sparse warnings during netns exit
> >   xfrm: policy: fix sparse warnings in xfrm_policy_{init,fini}
> >   xfrm: policy: silence sparse warning in xfrm_policy_unregister_afinfo
> >   xfrm: add rcu_access_pointer to silence sparse warning for
> >     xfrm_input_afinfo
> >   xfrm: avoid RCU warnings around the per-netns netlink socket
> 
> Series applied, thanks a ot Sabrina!

I forgot to mention, I've pulled this into the ipsec tree
as I consider this as fixes to get rid of these warnings
and the regression risk is pretty low.
