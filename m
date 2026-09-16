Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75324CDA2D
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789553152; cv=none; b=CsCUj4/esbxaJbeLtXbZTz0n/+Ntgq6uqohNUQW/NOaStNS5ps/9rlIADMvUpNHf2Zw5+MxgWTMfvojsc+D6DEFb2qY+66UscZqjw53VAGTAIF/pX8F3Ux/4DYvuSFr4WaKWM6aJIqCRj4ggC5KFKEVZRMKnetg8mmt+bRvRTBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789553152; c=relaxed/simple;
	bh=btoDqcPYHansgQaIU1/iWWe4Ofv4oCN+akMByieyj04=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkisXM2P4HE10N8IKElqDqv2l37ealPszLQJQA/tpoXMc1I+VaiqE7ABSwh9Xfdrw00OcWnpddFEE/tBN4vdzyOlrZWJjxTS+687EideyfSnrYBMv5K5rWMq86D6cM4XtqbwEe1k72Ny7LsE7pOa6VrhTHnshBqZw6mhcvRUVeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=QLsyoc7+; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="QLsyoc7+"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B87AF20851;
	Wed, 16 Sep 2026 12:05:32 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sA5kJGbrce64; Wed, 16 Sep 2026 12:05:32 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 3033720758;
	Wed, 16 Sep 2026 12:05:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 3033720758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1789553132;
	bh=8d9pmdwJo6QjATX5qrT1knfc3kYnDHk1c29r4ICb5vg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=QLsyoc7+fwErZ5Dj54z7Qscvshy/zcE6vVxXtJsDw5SRX7K8Dx4NdmsJL0kP10r47
	 CsOTnJheMSxnEIioObVCDXbA+uovcBZW4gg0UzjKadZ4e1gUKFxrbu3B5VJEEDjT9P
	 N2tTRELD8kCZseuFY2Uk/8BFenPo/UvwxOw93CtD8PdaZWcjAKVRVjECNP/z66KkmK
	 uMN8QO2wEGcbl7oRGCAYLYIHHMmXYY7vZG6qMc0hB4rQcH4YNjGBA8Jtw6qJQL2XGE
	 sovfHoG5Lnnho1SJ6pDzTznRsxvW+jc5Nm6NPqqNEIimj+HI0RJJJKX6dWmbAlEgxR
	 7nASW19dAUsbw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 16 Sep
 2026 12:05:31 +0200
Received: (nullmailer pid 106235 invoked by uid 1000);
	Wed, 16 Sep 2026 10:05:30 -0000
Date: Wed, 16 Sep 2026 12:05:30 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: Some clarifications on the upstreaming process
Message-ID: <aqpp6mVPvfTsbViZ@secunet.com>
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
 <aqD-_cBnIOMEpxVh@secunet.com>
 <70d0048d-694b-4348-a6a5-de87a767b8fd@redhat.com>
 <aqEzoAcZ0uP0Kz6k@secunet.com>
 <83dd4915-e7a3-4c7e-91dd-adbea16450b3@redhat.com>
 <aqE4eK2cqpvxqCQJ@secunet.com>
 <20260909115753.75723ca1@kernel.org>
 <aqfbzekdykqo6ZJG@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aqfbzekdykqo6ZJG@secunet.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Sep 14, 2026 at 01:34:37PM +0200, Steffen Klassert wrote:
> On Wed, Sep 09, 2026 at 11:57:53AM -0700, Jakub Kicinski wrote:
> > On Wed, 9 Sep 2026 12:44:08 +0200 Steffen Klassert wrote:
> > > On Wed, Sep 09, 2026 at 12:34:42PM +0200, Paolo Abeni wrote:
> > > > On 9/9/26 12:23 PM, Steffen Klassert wrote:  
> > > > > Are you willing to pull this as is, or should I resend the pull
> > > > > request with the incremental fix? The latter leads to problem
> > > > > 4.1 (patch does not apply to net).  
> > > > Due to time schedule I can't look into the series detail before tomorrow
> > > > my time. Since Jakub forwarded the AI report and left the series in PW I
> > > > assume he is looking for your replies to the AI comments - which is
> > > > pretty much would I'll do.  
> > > 
> > > It was a general question, not directly related to this pull request.
> > > 
> > > There were several issues reported, it will take a bit of time
> > > to review the AI comments.
> > 
> > Thanks, I'll toss this version form PW, please let us know if it's good
> > (enough) and we should pull as is after all.
> 
> Most of the patches are OK, but I'll give the patch authors some time to
> comment and resend the pull request then. I send just the pull request
> without resending the patches to the list if that's OK. I don't want
> to have yet another AI review round...

The pull request had 2 incomplete fixes but no regressions.
I'll resend the pull request without changes, we correct
the incomplete fixes with a followup.
