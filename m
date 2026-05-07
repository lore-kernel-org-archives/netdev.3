Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB2432F764
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 05:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778133251; cv=none; b=C/sXa9suO/qb19D8R9lKM78hIkQnDZqNlxKNmYpeh1IpAifqHfydYGg/zIKpEjhDKA2pYjbTxAk/gGijf6oM17zuj2BYkFSzi8YrPRf1vcg9rzLRnMjgj+3qrMpdOZa5TBASwK44UMyTtyMLGlUJM0fAmICVDk27OO+W13YdJtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778133251; c=relaxed/simple;
	bh=vdUDKyEsmWH2y93zh2rXtHiWIuuWuDw3ES4ekFbLdrY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEyLLFTeXJrGAImSzGd/fZyhg67jfsqVU4kUzjLH8egk8F7Bs/0Bze43b6j/sB9MJ/BFyC5mJQgfIEYtR8CqRopd/zHHyxjkYRFjWRXfxIa+cAWgXcPwU7rh+cbRelWgEcYh/oQTdn1GdQ391tOYhGlwiRaA/ip9K+ri5VhYL1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=RdW8erXR; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="RdW8erXR"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9E4A2206DF;
	Thu,  7 May 2026 07:54:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P9Pes1OaK0xk; Thu,  7 May 2026 07:54:05 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 05A462067A;
	Thu,  7 May 2026 07:54:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 05A462067A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1778133245;
	bh=bKwPfNu6eXE8thNJCiuhb2gb/Y3wZqs+ChZtr4i0GlQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=RdW8erXReECdZqdF0nv7ctNKatoCvUlI8lSJeocV3WebIFktZsty9EJX7g3Fi3yfG
	 VEAAIFm+GhihPLo98Cg3Cj2ACBJWKQj1kt7Ucypw1RHam/uM2z5O6nfolMwHVdbNAO
	 PDfb2dZU9s6AYVa04HaPoPva/nHbaPdEIuLmpbZk2NhrHLUdHmLmImrvpefxWC2rdW
	 P2BA6Ts1zU8d4fltyB7X2BLY1vHm1IgY/s5K/WTR2J0/Z+V/D3mtXV3mlK/nfUUOve
	 t79jFevPRqjQ0LvVmX5npjwzzw79kvZtTvFaqZ4bd2E3vVLyL5aNKJWFR1/1aTCMSh
	 9i8ruEn5wMEXg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 07:54:04 +0200
Received: (nullmailer pid 1286833 invoked by uid 1000);
	Thu, 07 May 2026 05:54:04 -0000
Date: Thu, 7 May 2026 07:54:04 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: David Miller <davem@davemloft.net>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/8] pull request (net): ipsec 2026-05-05
Message-ID: <afwo_DsMkYzL2AG9@secunet.com>
References: <20260505132326.1362733-1-steffen.klassert@secunet.com>
 <20260506165035.61964333@kernel.org>
 <20260506165149.12e30102@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260506165149.12e30102@kernel.org>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, May 06, 2026 at 04:51:49PM -0700, Jakub Kicinski wrote:
> On Wed, 6 May 2026 16:50:35 -0700 Jakub Kicinski wrote:
> > On Tue, 5 May 2026 15:22:56 +0200 Steffen Klassert wrote:
> > > 5. Harden __xfrm_state_delete() against repeated or inconsistent unhashing
> > >    of state list nodes by keying the removal on actual list membership and
> > >    using delete-and-init helpers. From Michal Kosiorek.  
> > 
> > Sashiko seems to have extra comments for this but I suspect follow up
> > is the way to go there.
> 
> I should have made it clear - Claude-shiko:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260505132326.1362733-4-steffen.klassert@secunet.com

I think the races Sashiko reveals here don't exist. __xfrm_state_delete()
is always called with the xfrm_state lock held, so there can't be a
second __xfrm_state_delete() on the same xfrm_state.
