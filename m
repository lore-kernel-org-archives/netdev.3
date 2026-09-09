Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1EA3D1CAC
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980276; cv=none; b=mo61kZ+oHiH7NnqdWwV2M5JEuCUZJeUvIL2jzvKJabeWtf5NgxgL7RlRrwGxfPWfXnk1z9V+wAdpFgxu6xt1Nfw0wQZV7nAAOP9xpuHcAspT9yfR9cuQgdkP41aKKIGwI3dL5e/jqpLmLZt2TgAL2r2fMflpLnG20y25bGgyPlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980276; c=relaxed/simple;
	bh=Uiv/4PrLFx2CMwXXY6gt0YS2lZKn2wa8TNi2cR+uUrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bo708/DKd96XOPjnjc5d5F6izwTBlyRMV/qushAPMefgMtpAnyhYO6ZGrOoEdxAEDFieeCAJcLrHH+eqPdg3xpJnJKxNUlYT0ul8f4p4QjSqO5JJh0LWlzPQW0IeursvizfcoSuLmN7RZPXdbc5LvKFX59DMabTwL0A1LPg7ebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfR8t5QL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfR8t5QL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435071F000FF;
	Wed,  9 Sep 2026 18:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980274;
	bh=D3KSgKRO1NtNPVyUBgrFO7pRIl73Eon2VvEdxKs9iG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AfR8t5QLHCbNHAcAaSsMDSWafDcER6lUMAhC6K01B0ecKJTjQyJfXtEpA8/Fom8Xl
	 wTD8fsYs8nFg+pWtpBw3FeH5YCZ6uoWa5qdtF64ghBcRDdS0N8iOiV777XIRys8obF
	 EpXrRccXNh/dJdUMLP3KUa9trtinWtlNPnwy6nTJax0W3eOHUlYarAszkJTuWAeCgC
	 cLhQJMLKa8dMYmyLhgFXsatNJ0s0weFwpNsM+tC+rZx/hx7jmE9FLXSN7O8fNo0M4k
	 dRLyRp7yCcs0/QNVHyC032nxgw+tDYvbeRMhHoJZ+5Q6LurKwa3QtyxQNKd1beJsA3
	 iCxuof6CdG21w==
Date: Wed, 9 Sep 2026 11:57:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: Some clarifications on the upstreaming process
Message-ID: <20260909115753.75723ca1@kernel.org>
In-Reply-To: <aqE4eK2cqpvxqCQJ@secunet.com>
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
	<aqD-_cBnIOMEpxVh@secunet.com>
	<70d0048d-694b-4348-a6a5-de87a767b8fd@redhat.com>
	<aqEzoAcZ0uP0Kz6k@secunet.com>
	<83dd4915-e7a3-4c7e-91dd-adbea16450b3@redhat.com>
	<aqE4eK2cqpvxqCQJ@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 12:44:08 +0200 Steffen Klassert wrote:
> On Wed, Sep 09, 2026 at 12:34:42PM +0200, Paolo Abeni wrote:
> > On 9/9/26 12:23 PM, Steffen Klassert wrote:  
> > > Are you willing to pull this as is, or should I resend the pull
> > > request with the incremental fix? The latter leads to problem
> > > 4.1 (patch does not apply to net).  
> > Due to time schedule I can't look into the series detail before tomorrow
> > my time. Since Jakub forwarded the AI report and left the series in PW I
> > assume he is looking for your replies to the AI comments - which is
> > pretty much would I'll do.  
> 
> It was a general question, not directly related to this pull request.
> 
> There were several issues reported, it will take a bit of time
> to review the AI comments.

Thanks, I'll toss this version form PW, please let us know if it's good
(enough) and we should pull as is after all.

In general, I'd of course like to allow more use of the meta sponsored
models but my time is limited, and to some extent so are the funds (to
some extent because I suspect the volume is negligible compared to
netdev).

At the same time I worry that *shikos are making it easier for our
maintainers to ignore the fundamental changes which AI brings to SW
engineering. IOW I'd like to encourage more local use and
experimentation.

Sorry for not answering your actual questions. TBH I don't think we
have any real answers for most of them.
