Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718FE3A5421
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789028250; cv=none; b=hFtqgKLpg5CYg/u1uhGXZbGGANiuWcAH2EhGOvOrhmfhwcdwWwk3qP9qUZReBfQurPwdxh2FR7kCb+FL0Dk/r6+ejpU/snjIpcOcCXYhx51Qwhsg9Qieb3DlLt1T91lOWi7CZS3z8IOfCjeRmc0IB0GCJM4CTKsP03v4h2Nzx0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789028250; c=relaxed/simple;
	bh=MTnpvTdY6iox3Uu8QA9hXh45l6Gni+W7qHF/WgDHu2c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlyZMuIQJXaM6BA4mmGP+zCvf5AUHx6nIzdkvHZt9Jp+q2AwpEtyGafnFcKlUAI1KMkl8JSJ5zljElpmOLx+1eafmX5sCyp4NzJfQa5ucl3bZSqQy78yr4BN6WwqwO58G8AytWzx3QGgOfI1G/YiDGMVnOK2eogg3k4Ll7jkfng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=c0n7tYzh; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="c0n7tYzh"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7547820799;
	Thu, 10 Sep 2026 10:17:17 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 47ZHsBSEHkpn; Thu, 10 Sep 2026 10:17:16 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 60937206E9;
	Thu, 10 Sep 2026 10:17:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 60937206E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1789028236;
	bh=uh5mv7Is0ful7AWLHgN0FvA1fRZwQ4Urcr82t0F9fAc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=c0n7tYzhb6DLQYnxvZ/on6TAvXkkVwaB1Gul3mcKSeCrTTD6P7yw9tfNoylThe/sR
	 XTsJHMdf1iV/C8TIWnYO3XJ++xhyvzrPwd/BY6Ctjv4fJJFUrcGjvxRfwkhLXwFvyA
	 ydFR2wg+3euH3GHWOn3JF+B5ttUS9ZA3YaHXkL+W5x9lPYbpj2TRepNW6S1p8H2nyE
	 XevXD2idTXqQA32vKOuVOGCc1/3a+prcxyFZzU356bLtlgNxb8SRfNoh3D0XSLOlnk
	 gYMmll3S+BPRzJKbvg1ctqI0s9HxJqbqcMYNZQH5jLK+8VcZ/+M/qMa1ywIO6h2wMR
	 iOUzUFW+mp/hw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 10 Sep
 2026 10:17:15 +0200
Received: (nullmailer pid 1374235 invoked by uid 1000);
	Thu, 10 Sep 2026 08:17:15 -0000
Date: Thu, 10 Sep 2026 10:17:15 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Matthieu Baerts <matttbe@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal
	<fw@strlen.de>
Subject: Re: Some clarifications on the upstreaming process
Message-ID: <aqJniwjpWMGk_oY9@secunet.com>
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
 <aqD-_cBnIOMEpxVh@secunet.com>
 <70d0048d-694b-4348-a6a5-de87a767b8fd@redhat.com>
 <6d53e8e5-96a3-462f-97d7-722e1b9f8f79@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6d53e8e5-96a3-462f-97d7-722e1b9f8f79@kernel.org>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

Hi Matthieu,

On Wed, Sep 09, 2026 at 12:22:14PM +0200, Matthieu Baerts wrote:
> Hi Steffen, Paolo,
> 
> (+cc Pablo, Florian)
> 
> Sorry to jump in the discussion, but I have similar issues with MPTCP
> patches.
> 
> On 09/09/2026 11:23, Paolo Abeni wrote:
> > On 9/9/26 8:38 AM, Steffen Klassert wrote:
> 
> (...)
> 
> >> 4) Some patches for the ipsec and ipsec-next tree don't get Sashiko
> >> reviews either because they don't apply to net or net-next, or
> >> because of some other reasons I'm not aware of.
> 
> >From what I saw, sashiko.dev tries to apply patches on top of the
> correct tree by at least looking at the modified files and the
> MAINTAINERS file, and possibly the prefix [1] from what I understood.

Yes, that's correct. I did not notice this yet. Thanks!

> 
> For example this recent patch [2] got applied on top of 96f01b53c2d0,
> which corresponds to today's 'ipset' tree [3] (tag: ipsec-2026-09-07)
> 
> [1] https://github.com/sashiko-dev/sashiko/issues/48
> [2]
> https://sashiko.dev/#/patchset/migrate-state-fixes-v2-0-c3e2767f0d96%40secunet.com
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git
> 
> For Clashiko, it only tests what's for net/net-next, same as for the
> selftests, etc. if I'm not mistaken.
> 
> >> This is the biggest
> >> issue, I see the Sashiko review only after I sent a pull request.
> >> This makes the upstreaming process complicated and delays fixes
> >> quite a bit. I requested some infrastructure from the LF to get
> >> this fixed, but no answer so far. Any other ideas how to fix
> >> this issue?
> > 
> > I think are 2 separate points:
> > 
> > 4.1 missing sashiko reviews on edge cases
> > 4.2 difficulty to reproduce the sashiko/clashiko review process in advance.
> > 
> > WRT 4.1 things should generally improve over time, with the exception of
> > patch that do not apply. I think we can't do much for them, but they
> > also should not matter much, right?
> > 
> > WRT 4.2 the current guidance is to run AI reviews before submission.
> > Sashiko could be installed and run locally. The nipa instance (clashiko)
> > is slighly more effective than sashiko.dev because it runs several
> > recent models and its result are indeed hard to replicate locally/in
> > advance.
> > 
> > Clashiko currently runs on (very significant) meta-sponsored budget, I
> > think it would be hard to extend it's usage to netdev's subsystems.
> 
> We might need to find a solution for the subsystems for this 4th point.
> I have the same issue with MPTCP, and it seems it is the same with
> Netfilter (and likely others) from what I saw. I would prefer to have
> Clashiko reviews before applying patches on my side: to reduce the risk
> to deal with new issues later on, and to let the author dealing with
> that (instead of me days/weeks after).

Right, patches must get the review before they get applied to
a git tree, not after. It was always like that and we should
try to get back to it. The current workflow feels broken from
a submaintainers point of view. The submaintaners are now the
bottleneck.

> >From what I understood, Clashiko is still being tweaked, and that's the
> current priority. Maybe later, subsystems can have their patches
> reviewed by Clashiko as well?

That's what I would hope for.

> If that's a budget issue that cannot be solved easily, I wonder if
> Clashiko shouldn't ignore subsystems patches: I see its value, but I
> also see the cost for the different subsystems :-/

Maybe we can work with a compromise in the meantime. Clashiko
reviews all subsystem patches that apply to net or net-next
when the patches are submitted to the list as it is now.
But then the subsystem pull requests are done without
resending all patches to the list. So patches do not get
reviewed again with the pull request. That would avoid the
hassle with reviews of already applied patches.

Would that approach be acceptable for the netdev maintainers?

