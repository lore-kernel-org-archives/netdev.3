Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FDC35AC3C
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599151; cv=none; b=Q+00PqeivdaDq0Bvi7IzCArfJBPrX9EI7o2StEqGneyvT38g0S+UXPjKUgJ5GvkyV3g/2/BIIHMZJaV4t0BqhrXxLeMWK1/oattZPITk2JoA9rpWK1eMnaU4Dy+jGgIRothBM5bixJvSrMZmt/gFnJvmzCLjJH5dhyvWXgl/ST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599151; c=relaxed/simple;
	bh=rtp/zCiJfx6FzTg9IyNA9f+pfCtn8tDWSZWTCqubcM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvJP/ZAT6ECx5+B2FRwjp3e/AIopaw+Ce7HbadgOn1eARg1XGAv+dt7dbW9hExnIauZS6L3GyVoxK8dk0NjH52x3MIPsp4ff3aOjp2J9y7umfumEy7PB5Befh7DyzMLNUTN7nfuwYY5+uLJDbF4CdDRcQ4K3fIFnh9K8a876Lg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDYRt0EV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDYRt0EV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065EFC2BCB0;
	Tue, 12 May 2026 15:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778599150;
	bh=rtp/zCiJfx6FzTg9IyNA9f+pfCtn8tDWSZWTCqubcM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EDYRt0EVWxbsXqxZvYf6aNUQulpV/G2Yt4hRdzVvQBbvWX787FCf7/RL6xb+z/laM
	 V5v77do0I1pekkf7REpcPzYgifdkvGGBFE7UJnIThxr1o77Sh+j9/k+GOb8apptM7J
	 hbfcxvh+88O89g4F3nV+XBJO2H91a54C782MVLsxyiVAvqaNjSwi4jFYv780BdtJGi
	 SBK2z3fnHZgxoUj6gJFjiArS0bpfwPP3JOjqVBoHyL99fIpdsuiq7Pcx33eUCrA/zV
	 95YCqemejjZkrOnK9pIp3mlLVGe8sQoMBmdhDDnPn80SBa02Zb6HfdmbxNWBSMTpUx
	 tpHWw5pA/cNBQ==
Date: Tue, 12 May 2026 08:19:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, horms@kernel.org, idosch@nvidia.com,
 netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net] MAINTAINERS: update the IPv4/IPv6 entry and add Ido
 Schimmel
Message-ID: <20260512081909.1dc5c281@kernel.org>
In-Reply-To: <20260512122701.2656064-1-geert+renesas@glider.be>
References: <20260428203924.1229169-1-kuba@kernel.org>
	<20260512122701.2656064-1-geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 14:27:01 +0200 Geert Uytterhoeven wrote:
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18672,19 +18672,59 @@ F:	net/xfrm/
> >  F:	tools/testing/selftests/net/ipsec.c
> >  
> >  NETWORKING [IPv4/IPv6]
> > -M:	"David S. Miller" <davem@davemloft.net>  
> 
> Is this removal intentional? It is not mentioned in the patch
> description.

Yes, this is a remanent of pre-git era MAINTAINERS when AFAIU the
interpretation wasn't as... hierarchical? IOW I'm not sure why this
entry was listing DaveM directly in the first place. Dave maintains 
all of networking, of course, no need to list him on all the
sub-entries?
