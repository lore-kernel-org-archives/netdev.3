Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A78381E9B
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032505; cv=none; b=oD/ra2uPpEIx7Xdt/L+xBFA4RqetVzegOv0Nf1Upkq5PTA3G/ppSqz7BQtTcoF/qQm0WOop/dfAMCS5n0wnLTIwfxJklGBggiibRn9BEQx873o4K8/VDJ5CqeHv0Apfa+QVlcNHLNstbYwYVfD1IFB6vpqY+X9V6Zf54ERdfKMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032505; c=relaxed/simple;
	bh=WTnXfI+fY/WHO9pETr3hvFE1W4P2+GGbGFvKWdLLTwg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+kWDEIkpwBmK3xBnVAXrqj8V29lzbX0/73k/n9X6wgSNq15HAqTzpRPBJQc9LIpORj9gTfp5FckV9n70vyhbLVjZKRCPPFd4EcuC6guyzhEwTDbcHCHjEA9afTh2a5WwBsRoxKJO9GATkGNS9KVGoTu3FWDKee9PGr6laiaKtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=am15L7Pu; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="am15L7Pu"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5B76A205E3;
	Thu, 10 Sep 2026 11:28:19 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CTv_vOjgH6uO; Thu, 10 Sep 2026 11:28:18 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C7F842058E;
	Thu, 10 Sep 2026 11:28:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C7F842058E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1789032498;
	bh=mQeSM6q3MKnNrwcZu3u23P8o0ckFAG2P3pRhFTu7bfk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=am15L7PuX4znsL/BQPTnzdZdmNVDWQGYvya5ZBVKjlF8jwHgH3IGiG2ZlJ/beAjMr
	 W+O7WUKrvCBizUjRs09jHrEzi4dBafs8AzgHAk0ufiJabzvEl5w7W/yRr1pVzbtfv2
	 5GB+1J4haW1CbNwVPDmcGkMn+Uck5KA/D5wORCdOmvhyaX5cw/SjxaPnlS/x3yRtLD
	 ARaCfRtTWZZwUJpYxNtUJ41cxeUICe/C7Sr5Cmu+6YDB+iXPtLK7kS2NhL4feSGUir
	 Gck0TJjZIHmywQEtdlA7J/syKUvMDat890DweAWZgx+8wgLJ1pV0D351rb4FXXa1iF
	 WTl4pB5p07SuQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 10 Sep
 2026 11:28:17 +0200
Received: (nullmailer pid 1434466 invoked by uid 1000);
	Thu, 10 Sep 2026 09:28:17 -0000
Date: Thu, 10 Sep 2026 11:28:17 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Matthieu Baerts <matttbe@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal
	<fw@strlen.de>
Subject: Re: Some clarifications on the upstreaming process
Message-ID: <aqJ4MSQQupbw5nsw@secunet.com>
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
 <aqD-_cBnIOMEpxVh@secunet.com>
 <70d0048d-694b-4348-a6a5-de87a767b8fd@redhat.com>
 <6d53e8e5-96a3-462f-97d7-722e1b9f8f79@kernel.org>
 <aqJniwjpWMGk_oY9@secunet.com>
 <d5103afe-4ae6-4812-888e-9e41699c8617@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d5103afe-4ae6-4812-888e-9e41699c8617@kernel.org>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Sep 10, 2026 at 10:35:58AM +0200, Matthieu Baerts wrote:

...

> >> >From what I understood, Clashiko is still being tweaked, and that's the
> >> current priority. Maybe later, subsystems can have their patches
> >> reviewed by Clashiko as well?
> > 
> > That's what I would hope for.
> > 
> >> If that's a budget issue that cannot be solved easily, I wonder if
> >> Clashiko shouldn't ignore subsystems patches: I see its value, but I
> >> also see the cost for the different subsystems :-/
> > 
> > Maybe we can work with a compromise in the meantime. Clashiko
> > reviews all subsystem patches that apply to net or net-next
> > when the patches are submitted to the list as it is now.
> > But then the subsystem pull requests are done without
> > resending all patches to the list. So patches do not get
> > reviewed again with the pull request. That would avoid the
> > hassle with reviews of already applied patches.
> 
> I guess that could work for you because ipsec specific patches are sent
> to the same list, but not for subsystems with dedicated mailing lists.
> In our case, new features and complex fixes are usually discussed there
> first, with potentially multiple revisions, before being sent to netdev.

We have some (inofficial) mailing list for IPsec as well. We discuss
early stage RFC patches and concepts there. But the rule for IPsec
is that patches must be send to netdev at least once before they
get applied. Maybe you could use a similar worflow? I guess that
would make clashiko integration for subsystems easier, as it does
not need to monitor multiple mailing lists.
