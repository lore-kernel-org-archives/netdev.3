Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980AF3E025E
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030980; cv=none; b=E0yNyA9mMLHRVlEAlai4tFgkL2xGL1B153qCKtpQm6TPTE7bkewU8cnDRV4j9PFK4wju8zn0lS0fDN3Xm8BpQ7pjwvxRxfzaD9UTfpjS+7b+xJtvu4DsLPDBttRE424GxtXRn/E1Jm6CsmupGC8X5YgPHEHWIgaCt4NyyeYtHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030980; c=relaxed/simple;
	bh=KVaKw3u2+eIjTPoDb96RuNMIKOqLXYqAnnu5/uHh7UU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDVpYzDg6bzzs+ppzP5EH/HjUmjo48N+IF89hqHVgP8lR7bLmrBNUD+mzQ7SF4gXd+nXdcjw39CwJYLgYiEziwRN/QEYxE4x7GPksURN0gYGYpVlfLB5RiYE8LbLzhoDxuMye0gRa87VwdrUkOMGV3dMXlcFswGtbcH4ssvsCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ae3G9CYS; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ae3G9CYS"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 603DD20799;
	Thu, 10 Sep 2026 11:02:55 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3G1cOySSH0VH; Thu, 10 Sep 2026 11:02:54 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B7F8D20764;
	Thu, 10 Sep 2026 11:02:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B7F8D20764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1789030974;
	bh=6S57wzuKxaYOC1XRe1jtTl1AyQ+73enbpK+LgwGysXU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ae3G9CYSiEOrZvY0mCv+L8O3qWFutdQQAQhPXNsROxTai9UhxeMM1mzLKOLVVtDFT
	 sbiluq7YKV6PWnFvDzuru079AMuFlgV1v7u08HiCt8gG/9S0iq9Lhv7CFzNRAnYv/Y
	 xak2SmjHvjvZ0iUetkKs9RTwVWMuXk8IKJ49ngZL6B4OYnqQ9zHGO5g6d1JmOfL1Zc
	 OfrHkgysDv9X0QycxFcLGl0utiV+usauPQuQTjnOX4Slv7bLv7vVTcw2tqrzZ+sZ2L
	 oJ2ZQsTZrJTIen+r4Q9FRbuBmvQ4c8+rybXXOFMwHgr/qFcJc2Sp3D7vNhSssDVTc9
	 Shl200qjH5rJw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 10 Sep
 2026 11:02:53 +0200
Received: (nullmailer pid 1412914 invoked by uid 1000);
	Thu, 10 Sep 2026 09:02:53 -0000
Date: Thu, 10 Sep 2026 11:02:53 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: Some clarifications on the upstreaming process
Message-ID: <aqJyPdQ-XmfQsfIC@secunet.com>
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
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
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

I'll sort it out for that pull request, but I can't do that for every PR.

> In general, I'd of course like to allow more use of the meta sponsored
> models but my time is limited, and to some extent so are the funds (to
> some extent because I suspect the volume is negligible compared to
> netdev).

I'd guess it is negligible. It is one review per subsystem patch,
as it is now. It is just before the patch is applied. So I think
the actual cost is to set the things up.

> At the same time I worry that *shikos are making it easier for our
> maintainers to ignore the fundamental changes which AI brings to SW
> engineering. IOW I'd like to encourage more local use and
> experimentation.

We do local use and experimentation and yes, we could probably
do more. But that's a process and I have only limited influence
on that.

But anyway, this does not solve the root problem that patches
get their final review after they are applied to git (as
mentioned in the other mail in this thread).

> Sorry for not answering your actual questions. TBH I don't think we
> have any real answers for most of them.

Unfortunately we have to find an answer for these questions.
My time is limited as well, that's why I came up with that.
So I hope we find a solution before I have to raise the
white flag ;)
