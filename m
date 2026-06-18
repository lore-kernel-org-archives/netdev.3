Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF83C5DDE
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767396; cv=none; b=Da5BB+iWj/41mcVaTYJwnRmU99DaGTEEF7bojxOxDPhuz7zUXjxEdD6sUxTzGwEFqJLbDQ0dFXbOBJMXNZ6mVDQgwzdS0985A9YUTs6ZdJRnfWM+UB3nrclJqHOSe6iqIBZ1ZNSSjheZiubLfoofLD1ptcKtI1DBLQtY89znXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767396; c=relaxed/simple;
	bh=T2RL72LMPbUm6XUhqskQ944FUcEgz9tb+3dQGG7OZK4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xf9btyl7Lxq3uSx7C2vRx6XziSh3QmAqsZEmnf/5tqp+nVRshTI5j/CJ7rmmUIcOwVmZQzKtTaLGdMR+EGX//HygI1lCcvYPpxZbrENe6xN1MvlMUFK3Nccyx4aGGp50nnmiptApw7ba0Uxn2PxbUb0QeX8hZcU03s88w7A2vuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=CaO8bwlv; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="CaO8bwlv"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 775CD20704;
	Thu, 18 Jun 2026 09:23:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vGTzZaZUtyoD; Thu, 18 Jun 2026 09:23:05 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0153A201C7;
	Thu, 18 Jun 2026 09:23:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0153A201C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781767385;
	bh=3tKuVAsKGQbKj6HqiNuuq9WdJK1y43J+sAU0Vt2qdGM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=CaO8bwlv14Tnaq4YJ/1fCHbJas03ws3QvWp94vLFRhuBl54qpFgZ+doAWatseYHQq
	 EHAWbUVzMekMQxSZInsf4S3G6+mhwSVLoSPP5SaRMFLVf9A+tT02045iiRecyuslUI
	 V1/H7ZNQ9VyPA1pK4s/Sf7HL+2ba3TyXPjqAbWUQqHmMMWKp94DxXbatWRTa0ZZlWd
	 ZcAc1wKwz/x3lsuypfpUkJtYnbUs3UoOVEmB6bieQKdqAfjotgIzuHx13IVimryKwR
	 xow31a7jRDIm2mgCs8PsIhV24Fzm8ovh6wbqZ9tE/y5SFgA6bRRdQPX0dRGiK/l/QK
	 mCc7+8fgqDoFw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 09:23:04 +0200
Received: (nullmailer pid 3961711 invoked by uid 1000);
	Thu, 18 Jun 2026 07:23:03 -0000
Date: Thu, 18 Jun 2026 09:23:03 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Simon Horman <horms@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, "zdi-disclosures@trendmicro.com"
	<zdi-disclosures@trendmicro.com>, Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] xfrm: Fix xfrm state cache insertion race
Message-ID: <ajOc10E_D7k_3NcI@secunet.com>
References: <aiuSE5J-U8SuoZnk@gondor.apana.org.au>
 <20260615084321.GE712698@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260615084321.GE712698@horms.kernel.org>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Jun 15, 2026 at 09:43:21AM +0100, Simon Horman wrote:
> On Fri, Jun 12, 2026 at 12:58:59PM +0800, Herbert Xu wrote:
> > The xfrm input state cache insertion code checks the validity of
> > the state before acquiring the global xfrm_state_lock.  Thus it's
> > possible for someone else to kill the state after it passed the
> > validity check, and then the insertion will add the dead state
> > to the cache.
> > 
> > Fix this by moving the validity check inside the lock.
> > 
> > This entire function is called on the input path, where BH must
> > be off (e.g., the caller of this function xfrm_input acquires
> > its spinlocks without disabling BH).
> > 
> > So there is no need to disable BH here or take the RCU read lock.
> > Remove both and replace them with an assertion that trips if BH
> > is accidentally enabled on some future calling path.
> > 
> > Fixes: 81a331a0e72d ("xfrm: Add an inbound percpu state cache.")
> > Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Applied, thanks everyone!
