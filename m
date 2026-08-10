Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6F5369D7A;
	Mon, 10 Aug 2026 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786398332; cv=none; b=LiWU2nP2lxLBC0IO9JXYgIBz2TukGsiWexKty7p5HNhLBtahisAPqB1zeGHVefsdl6DLgfNO6m2Vl9xS1zUB9R1y8WeocIxBwocL+5H7ZY6LHcyrLg1GXR3jV2hZYWOraMVvqGfcguOG81XkFKT6pAUgxRiPTskBXaE3yAfq2cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786398332; c=relaxed/simple;
	bh=P4z3HrEsk3k0e7lI32Y3qh7xVklKmPNZ+3XCO6XAMuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8QoNG9WOyb739MfMkS7ddI0+nDaREoPxAPPggeSYHTrjpPfpHMYkFkNeOVB1CPYYC2keubq7QjS9CyyHJo2W+/LIKRYf8nvVjqJwDZIByJWhl9255HnmBSL6dzAcaNxK0K7HGMmpKJLwmfmBM3C9rB9myHigCi5O45/X6IVyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcCKE7K8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcCKE7K8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9AD1F000E9;
	Mon, 10 Aug 2026 21:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786398321;
	bh=zaR1wf9AOWTkzoVRdi7oODxSZXRz+cOc2Ftey0PH2tA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BcCKE7K8iNbYcw/ziFWXkTG8TkxYYDwybFDFg9GWTG2NXAD4Rk5gbLbeWDqVmj5En
	 1OOzA4AlkadvTb8QNNl2ItbNM9ssYQwCqkojoDs7FB+tGsQj/YDrGlJYyOHAoKggZH
	 GcZuReVZ6Fg2f6NIGqyurVGp7MSCaBhEC1o/6E5lupJGjFY2yin1vaFK7xwjeoKRhq
	 50WA4HxSfXceP1VT5K4+uzc+ycd3XrtDvJGhKZWhw7ZYN/266fecFZYWxo/ajsMG4y
	 1GlOxWIDR8Teg4VezrhyhWeU8WJT+c0A7wS077v2cGEBClMYMiZkr8F01ddtC6NXPc
	 ec/w2vca4Ngow==
Date: Mon, 10 Aug 2026 14:45:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: natsemi: ns83820: Fix use-after-free in
 ns83820_remove_one due to race condition
Message-ID: <20260810144520.4dd6a55c@kernel.org>
In-Reply-To: <fb169d89c2e4589b1994b3526102b8b1367c2261.1785810962.git.xiaopei01@kylinos.cn>
References: <fb169d89c2e4589b1994b3526102b8b1367c2261.1785810962.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 10:38:12 +0800 Pei Xiao wrote:
> free_netdev(ndev)                         |
> // dev is freed                           |

isn't there obviously a window here for the work to run after dev is
freed but before we canceled?

>                                           | queue_refill
>                                           | // use dev (use-after-free)
-- 
pw-bot: cr
