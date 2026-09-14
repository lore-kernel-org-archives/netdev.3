Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E4D4457D2
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385683; cv=none; b=PsaJtxKRUGOb9CbkuE+fQY318WcVkumGDxrC9XylkgO1s0tkv3N/COIXnj2c2d92SX6kbJi1eBs1O/F6zoUXSy+GkXkrKG7xji73if1M2TdQzrPDdlINx4V8G8TTKwEZ64/sEeEhVN0YJxFQJMghQIZl2L9WxQnKHqGWIRz0ik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385683; c=relaxed/simple;
	bh=OZLmEOrCfT+ySXmxd7Yn1HWMMhubrpmEzn6xfYZQFtU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LB9cfhlRPXaKcvslnMOOm9UFPPiVBni9meI7cCXVUtNZJgUtI4WoqZkFERiid6cVP2WltniyRmRtKWP/UY3/7j6tAPGrcSTSGVKbbIV+EgVpjY3fF+jlkB4XnSiWNDHtP4S4XFn/VCWxmEPklzSBwH0wJLzlV8FGy5bDgKhiBHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=OSZAyltf; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="OSZAyltf"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2D65E205ED;
	Mon, 14 Sep 2026 13:34:39 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bh-8DKk_E5If; Mon, 14 Sep 2026 13:34:38 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A1118201AA;
	Mon, 14 Sep 2026 13:34:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A1118201AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1789385678;
	bh=PXaSGHXRXXcpfxny2MjpzzTWMoLEkgVDIJkjM72Ufzw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=OSZAyltfx5RY4c3wr7V7GqmLvEiqLgcNhuW3t7wiKS+eQVB7sivE9naqdIytU7CrG
	 iUUYIft05ZsfAIPOTN9LVaBgSJpF+hbWU3OW8vvMZeDYq4Z8D1FIXPe14g97msNxsb
	 33n4wFT9eBDBIc688ito8huJAX0kCKCHrBJoif/l6eu0nvY0DHUCv1koG7Y5qzxQbn
	 uPujKTX3oFJ0AZAXfd12WBphfNyzXuscMIqXJ9gKCEJka39VHHP/Mu91Q7yYoZOJFr
	 P8oEPfPYmLs6pNNdg8wzDmMtzwlRn6DE2gpwe+qJ/H5h2xdr9moyPMCXmEfClO+dsj
	 aXimVmCOjVhXA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 14 Sep
 2026 13:34:37 +0200
Received: (nullmailer pid 1967778 invoked by uid 1000);
	Mon, 14 Sep 2026 11:34:37 -0000
Date: Mon, 14 Sep 2026 13:34:37 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: Some clarifications on the upstreaming process
Message-ID: <aqfbzekdykqo6ZJG@secunet.com>
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
 <aqD-_cBnIOMEpxVh@secunet.com>
 <70d0048d-694b-4348-a6a5-de87a767b8fd@redhat.com>
 <aqEzoAcZ0uP0Kz6k@secunet.com>
 <83dd4915-e7a3-4c7e-91dd-adbea16450b3@redhat.com>
 <aqE4eK2cqpvxqCQJ@secunet.com>
 <20260909115753.75723ca1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260909115753.75723ca1@kernel.org>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, Sep 09, 2026 at 11:57:53AM -0700, Jakub Kicinski wrote:
> On Wed, 9 Sep 2026 12:44:08 +0200 Steffen Klassert wrote:
> > On Wed, Sep 09, 2026 at 12:34:42PM +0200, Paolo Abeni wrote:
> > > On 9/9/26 12:23 PM, Steffen Klassert wrote:  
> > > > Are you willing to pull this as is, or should I resend the pull
> > > > request with the incremental fix? The latter leads to problem
> > > > 4.1 (patch does not apply to net).  
> > > Due to time schedule I can't look into the series detail before tomorrow
> > > my time. Since Jakub forwarded the AI report and left the series in PW I
> > > assume he is looking for your replies to the AI comments - which is
> > > pretty much would I'll do.  
> > 
> > It was a general question, not directly related to this pull request.
> > 
> > There were several issues reported, it will take a bit of time
> > to review the AI comments.
> 
> Thanks, I'll toss this version form PW, please let us know if it's good
> (enough) and we should pull as is after all.

Most of the patches are OK, but I'll give the patch authors some time to
comment and resend the pull request then. I send just the pull request
without resending the patches to the list if that's OK. I don't want
to have yet another AI review round...
