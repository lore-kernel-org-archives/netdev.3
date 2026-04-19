Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B6040DFCE
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776610583; cv=none; b=pBGKqBiCYXxXILisZpjnM/rkfLnEiXBQ3hmFM50oXd42lhCqEP/zQTq+Bq2OM8gk+tQg40NUNUf1xh+GmHbqyd2OCh+QtvgUm+84hwB3969NEcP2rmq2Vo7CfdcdjTjgbxMHziqOtDhIREAglfC1SWES78khIXTEkhNWqBTy/Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776610583; c=relaxed/simple;
	bh=40WO+wawAva51TTWNdL6GfONnlX5x4x9t7Gu9T23zmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGYfbtHbJezykpRUiT8QTFwOjQLoNr/WYnt5DHcDLA1+ZZKb90+j47mHaaCBZg8sCTXsxn5vxOElLMdsPvAQZMV0Z43GlF6iarPXXtPZkODlyWgo+473moxfy4ecwfEmEctqn3x2N46A2sc0wco59CIcuaqzTrM0cBlRHxSy9p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/ul5/z8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/ul5/z8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0F6C2BCAF;
	Sun, 19 Apr 2026 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776610583;
	bh=40WO+wawAva51TTWNdL6GfONnlX5x4x9t7Gu9T23zmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/ul5/z8dbyhlZW/0nELO8naWyFAAsySe8S2PkTLj7q4TKq9EoLPuJb4tHantpXU6
	 kfEGrDrLoJCy1zmJ4ejKHcI3J27wGMzVQ8Rou/ZrM58w2BIaB8v+Hgxf67Q9uKThRu
	 zi7f38hCPqeETOY22rSMS1NM/gJ4hhFC6I/6JzWrgf0WEnSA0ObA1Qdq7+NmTgWFl+
	 WQkLsO054YWWQiEPy0QzksvYImsUFMLv68yggF6TgEwPD96sZrPBWP+ya4OhdW/RAa
	 7LwKBa7ySMX18cRFHBEBFjnf1rQmqSBxvlrFGUnENipCdu1Q4P0bn5S7G8kCAB/XIY
	 FV8TL1XX0nYQA==
Date: Sun, 19 Apr 2026 15:56:18 +0100
From: Simon Horman <horms@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] slip: bound decode() reads against the compressed
 packet length
Message-ID: <20260419145618.GL280379@horms.kernel.org>
References: <20260416100147.531855-5-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416100147.531855-5-bestswngs@gmail.com>

On Thu, Apr 16, 2026 at 06:01:51PM +0800, Weiming Shi wrote:
> slhc_uncompress() parses a VJ-compressed TCP header by advancing a
> pointer through the packet via decode() and pull16(). Neither helper
> bounds-checks against isize, and decode() masks its return with
> & 0xffff so it can never return the -1 that callers test for -- those
> error paths are dead code.
> 
> A short compressed frame whose change byte requests optional fields
> lets decode() read past the end of the packet. The over-read bytes
> are folded into the cached cstate and reflected into subsequent
> reconstructed packets.
> 
> Make decode() and pull16() take the packet end pointer and return -1
> when exhausted. Add a bounds check before the TCP-checksum read.
> The existing == -1 tests now do what they were always meant to.
> 
> Fixes: b5451d783ade ("slip: Move the SLIP drivers")

AI generated review points out that the cited patch only moves code,
so it isn't the origin of the bug. It seems that the problem has been
present since the beginning of git history. So:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

> Reported-by: Simon Horman <horms@kernel.org>

FTR, I believe I was mainly passing on AI generated review

> Closes: https://lore.kernel.org/netdev/20260414134126.758795-2-horms@kernel.org/
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/slip/slhc.c | 43 ++++++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 18 deletions(-)

As usual I'll comment on the review of this patch by Sashiko.

TL;DR: I don't think it should block progress of this patch.

The review by Sashiko flags out of bounds errors. However,
these are addressed by one of your other patches:

- [PATCH net] slip: fix slab-out-of-bounds write in slhc_uncompress()
  https://lore.kernel.org/netdev/20260415213359.335657-2-bestswngs@gmail.com/

As noted in my review of that patch, while it seems too late for these
patches, please consider bundling related patches in a patchset in future.
