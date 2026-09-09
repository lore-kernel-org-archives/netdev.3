Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4549AA45
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949417; cv=none; b=fWJ0JX3yoK2Nv7aohyUsqTFUNYQ4x2n4l6yPS35MsR4dB/WRF7QIbIKlZUf4QQEOh3f3b3V3Ihm/Q/lI1TKVvlmvUFzgTt21VbyTMxsIh6AenMvDrtGmUAamAjef1iRzlWJQuYYyHSFl9Tu7HxiKtDjb4WEUqCoriVHGdnkANcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949417; c=relaxed/simple;
	bh=GIKeEIpX6bu2mSsgllCLz7N1GSQMMvriOoU2DkKa3TQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+VTjoFgnN5B5whAJ/euqqUgY8glS9R0+6RSFIWFM0MlzO7G7pY6AqJ/IbrdUAVojhZTxmFgySYGF8WCRSIVKxc7uOwGerO2VFsDSocdzhWEtQS2kkTrUDgfvu8Fc0l5Wh7avprg1PXYPQI2GWAaYJhx0VCw5Qt8x4cDr0JoOYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=H7s+aJfs; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="H7s+aJfs"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 364AB205DD;
	Wed,  9 Sep 2026 12:23:31 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VMJpqiGSiQax; Wed,  9 Sep 2026 12:23:30 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7258420643;
	Wed,  9 Sep 2026 12:23:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7258420643
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788949410;
	bh=hR2krZCcC8dNPV+S5ASkDPvhZIoZe17yZmu5JuEtkv8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=H7s+aJfsBktP7I+rFVb7lpVveVB42bJL4jc+q8oV0kngK23ceOTUNEmp8FFNHWjFK
	 tF1vc8oCLwtiSeTJTjxxtpVG1xSB5JgdB/Rr8FnZH4d0JBKgZH0mG6jWIdzZqmWr0o
	 vBWPCIlFy/FPqSh3988t0iMasP+LrGCraG9Lzhff6f97F84Ghf9LgiL0VgILV7hDTs
	 jhHSAbQMZhnJ6Wgh6DKBa9OUQ4ryHVH225CmoCoZelfk/u4QuqW1OvX83bHxU5eRUI
	 x+9nQwOTFwGKWAj5kZgQhll6CIeFc3b+umSuzDD0IVPDQs8bUk61pVHoHRGeg8bwbS
	 6fQmQxEaP40tA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 9 Sep
 2026 12:23:29 +0200
Received: (nullmailer pid 334441 invoked by uid 1000);
	Wed, 09 Sep 2026 10:23:28 -0000
Date: Wed, 9 Sep 2026 12:23:28 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: Some clarifications on the upstreaming process
Message-ID: <aqEzoAcZ0uP0Kz6k@secunet.com>
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
 <aqD-_cBnIOMEpxVh@secunet.com>
 <70d0048d-694b-4348-a6a5-de87a767b8fd@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <70d0048d-694b-4348-a6a5-de87a767b8fd@redhat.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, Sep 09, 2026 at 11:23:56AM +0200, Paolo Abeni wrote:
> On 9/9/26 8:38 AM, Steffen Klassert wrote:
> > I need some clarifications on how to handle future ipsec patches.
> > Since we have the AI-generated patches and patch reviews things
> > changed quite a bit and I have problems to upstream ipsec fixes.
> > 
> > I have the following problematic situations:
> > 
> > 1) Sashiko found nothing in the original patch submisstion,
> > but found an issue when I resent the patch with the pull
> > request. I think this can be solved by asking the author
> > to send an incremental fix on top of the ipsec tree if
> > it does not happen too often.
> 
> This is usually the correct approach, with some exceptions i.e. the
> newly found issue is impactful (the new code is exploitable).

Are you willing to pull this as is, or should I resend the pull
request with the incremental fix? The latter leads to problem
4.1 (patch does not apply to net).

> 
> > 2) How to treat preexisting issues that are not introduced by the
> > patch under review? I'd say that's ok as long as the bug is
> > completely fixed with the patch. Is that acceptable?
> 
> Yes, pre-existing issue are generally better handled as follow-up. With
> some exception. i.e. sometimes sashiko says "this is a pre-existing
> issue, but it looks like the path doesn't actually fix the pre-existing
> issue it's supposed to fix..."o
> 
> Or when the pre-existing issue is very strongly tied to the issue at hand.
> > 3) Which severity is ok to accept? Maybe this:
> > 
> > - High, only if the review is wrong?
> > - Medium, only with good reson?
> > - Low, ok to accept?
> 
> AFAIK the above is the current general guidance.
> 
> Note that some brief comments on the ML in reply to sashiko feedback
> would help in all the above mentioned cases.

Ok, will do this.

> > 4) Some patches for the ipsec and ipsec-next tree don't get Sashiko
> > reviews either because they don't apply to net or net-next, or
> > because of some other reasons I'm not aware of. This is the biggest
> > issue, I see the Sashiko review only after I sent a pull request.
> > This makes the upstreaming process complicated and delays fixes
> > quite a bit. I requested some infrastructure from the LF to get
> > this fixed, but no answer so far. Any other ideas how to fix
> > this issue?
> 
> I think are 2 separate points:
> 
> 4.1 missing sashiko reviews on edge cases
> 4.2 difficulty to reproduce the sashiko/clashiko review process in advance.
> 
> WRT 4.1 things should generally improve over time, with the exception of
> patch that do not apply. I think we can't do much for them, but they
> also should not matter much, right?

Well, the 'patch does not apply' is one of my biggest problems.

> WRT 4.2 the current guidance is to run AI reviews before submission.
> Sashiko could be installed and run locally.

If somebody pays for the LLM tokens...

I don't have any influence on the patch author. But as most of
the patches are AI-generated, I'd guess they have some AI review
too. Unfortunately this does not mean they are correct.

> The nipa instance (clashiko)
> is slighly more effective than sashiko.dev because it runs several
> recent models and its result are indeed hard to replicate locally/in
> advance.
> 
> Clashiko currently runs on (very significant) meta-sponsored budget, I
> think it would be hard to extend it's usage to netdev's subsystems.

But that would fix the issue. Finally all the patches are reviewd by
Clashiko anyway when I send the pull request. If the nipa picks the
correct tree (ipsec or ipsec-next) the patches get reviewed already
when submitted and I could send the pull request without attaching
the patches. So this would be still one review per patch.

The current workflow makes me running in circles. I have no idea
how many iterations it needs to get a PR upstream, while the
queue of new patches continues to grow.
