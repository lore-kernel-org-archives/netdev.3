Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB9314B8C;
	Thu, 23 Apr 2026 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776973189; cv=none; b=hMijDWAyDfA7j6kw2uXHcwCOFBfI6twa0CP1u/JaRCR35+atPzFcVIRfjgDQXSSd1i4rXRBs/neW79R172QrB1jhBZnc9hV4FWKqGqn4BQcoFPBiUjFO7eIfrSaCjY9iwV09QADruD1NIQqrUJ8m5s3qMr6PCQUoQNCi9RO6QuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776973189; c=relaxed/simple;
	bh=GGFSJeIzTqFHDDyGBEjnK9+way6aNvCig6oj3Gt/GYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ar59laFGC3XVSF5dL4U7laASV5woNtsK1CZx7QORzqqGGcTNA6y5oCRx0bWa9cPzrIX5SUee9NNtWWj/6u9kz+bPWdwyZGQrRCDab9l/yT26ZW5yx1nlRVfkK/qMSjbXghe33rbjs057zAIMW6py8xXHIcPCxcavtHOLeuh8hg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj2ce3T0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lj2ce3T0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA77C2BCAF;
	Thu, 23 Apr 2026 19:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776973189;
	bh=GGFSJeIzTqFHDDyGBEjnK9+way6aNvCig6oj3Gt/GYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lj2ce3T0L9yScN0kd0HJwNyaf+d2b/5V9vm0AIXAIcBHsSiGMDC4HzAjqhQkIpIjP
	 yWTI++t+WVKPp9JL7pzb1IT4omD0958Vg9RCht6tZvP8YYqkcpRrf/pBkPofZAL36k
	 pJt1sQUp+wbRptAiiStMS0zwNhFOpk0WFAV0gpibudC0MzCB+riZMONFnVv2nqQvJO
	 k79vWCZROdbo+nOVe4bxOGQ11BIUfjUxvoausJw3O4awJ5N/O66UBKQRskp7wn57ln
	 NmA90jDHG44SvNBJsJeBFWdid8AWh8/iK19333Mr0ArOo0AfUi+S/2fEpZubZKRQ8K
	 7HJLKc1nJIiUA==
Date: Thu, 23 Apr 2026 12:39:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Anderson
 Nascimento <anderson@allelesecurity.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/6] rxrpc: Miscellaneous fixes
Message-ID: <20260423123947.156ce741@kernel.org>
In-Reply-To: <20260423115853.59273351@kernel.org>
References: <20260423105639.6e0a0a7e@kernel.org>
	<20260422161438.2593376-1-dhowells@redhat.com>
	<2990993.1776970042@warthog.procyon.org.uk>
	<20260423115853.59273351@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Apr 2026 11:58:53 -0700 Jakub Kicinski wrote:
> On Thu, 23 Apr 2026 19:47:22 +0100 David Howells wrote:
> > Jakub Kicinski <kuba@kernel.org> wrote:
> >   
> > > Have you had a chance to look thru sashiko run for this?
> > > 
> > > https://sashiko.dev/#/patchset/20260422161438.2593376-4-dhowells@redhat.com    
> > 
> > It wasn't available this morning when I looked.  I know there are a couple of
> > things to fix from other checks.  
> 
> It is now :) May I offer the following menu of options
>  - all the complaints are already taken into account / intentional /
>    will be addressed later
>  - I need more time, let's wait until tomorrow
>  - some of it looks legit, apply patches ${list} only
>  - let me respin completely

I've been hacking up Sashiko on top of Claude in these past few days,
and it's far less nit picky. For this series it doesn't flag a thing.
I'll just pull this in, if you could LMK whether any of the "real
Sashiko" reports are actually valid commentary on the current patches
I'd greatly appreciate.
