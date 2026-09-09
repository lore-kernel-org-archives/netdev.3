Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74BC3B895D;
	Wed,  9 Sep 2026 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937077; cv=none; b=rwB1ggxjTLiurKvngmzQNagn3NWV9ebfqmB2ybhNPsbFlTDjbzOouGKJ7StMbUvdYdqP8ytliBVCJoTl2xJCI/cD+yVZMda3P4jalQci2hgh3GS7GE9+zJhEFdkpdA/6rEu76VXbzWlDyVzPIuV7NeB5NNVmwcLsw1UIT9Le5YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937077; c=relaxed/simple;
	bh=/1yRgfIBCn5oCZ3fLkNdI4VLXILwg53ZI/AHhTIxrBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqOVPSxwy9eKTJSzxKUOoWpkENDUW3h3icjdHAa7NNE6zVX/oq1yOZauDtwE20pWwzJi+MDhntBlIbb82J5/TYuJHcek8vi2GMvRrayPmm4MVMLMCxZ05T3Hw1R9ujuStUAohUqW+JZnF7ne8Y673tMTdJ5mCZjHWjFmO6ow4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjMJhyp6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjMJhyp6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287591F00A3D;
	Wed,  9 Sep 2026 06:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788937076;
	bh=94b4xZSZhYha5/YD2kEuPE3VpiyZ0M9dSeOS4tMdF68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YjMJhyp6EuvVoEDcsE1eTR6f2AOX+X3lMdJeEmOTxZTUSXC5oenQdnHf1IhbzZlZN
	 UiDUQg2lcTHW8xDAzLK7kWSQZhDcw60EhwsiWG8nq7rR0SFOu5NaM+y4FaOTyzB2dJ
	 4OG+LZe9i6J4eZAGBx3h/TjPRDc7AwSjUWZ10Pe5I9mDotHlmlp04K7wCJmIdMJNt1
	 m0ta/FsYXmk6Ekc8yQ605THZ1Q+4m00wx/68y6B/JV4xtJL/e2hbiSUAUETvYaW1UK
	 BVDOhui3AQCA36vG+XtUwaD21m3Bl5yDYhsAhNWOdXyto2+i8hVTK+hfNOgah3KohU
	 a2i5datwyblbg==
Date: Wed, 9 Sep 2026 07:57:51 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, hkelam@marvell.com,
	linux-kernel@vger.kernel.org, naveenm@marvell.com,
	netdev@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v4 net] octeontx2-pf: reset HTB scheduler topology before
 freeing queues
Message-ID: <20260909065751.GF40544@horms.kernel.org>
References: <20260903020533.3068041-1-rkannoth@marvell.com>
 <178888726063.219967.8664029829834628993@kernel.org>
 <aqDPtg2y3Pl5_r-j@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqDPtg2y3Pl5_r-j@rkannoth-OptiPlex-7090>

On Wed, Sep 09, 2026 at 08:47:10AM +0530, Ratheesh Kannoth wrote:
> On 2026-09-08 at 22:37:40, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider:
> >
> > Critical: 0 · High: 1 · Medium: 1 · Low: 0
> >
> > - [High] Incomplete fix: the stale-TOPOLOGY bug class the commit claims
> >   to close stays reachable through the AF's bulk release path.
> AF's built release path is FLR/PCI reset path. We will fix it as seperate fix.
> 
> > - [Medium] Set/reset asymmetry at the aggregation level: HTB offload
> >   programs NIX_AF_TL1X_TOPOLOGY (PRIO_ANCHOR/RR_PRIO) on the shared per-…
> We can't clear TL1 blindly as it is a shared resource between PF and VF.

Thanks for looking into those concerns, and moreover addressing Sashiko's
feedback on earlier revisions of this patch.

This version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...
