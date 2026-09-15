Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAB23126AD
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789456068; cv=none; b=eNVTxPTeAz9nS9S2xhLLCdRFu8Sh9AjOolC2l6wQV0FGHzxcNi08CwsnQtVAYhazD46blrl2I80uzfWXc2W4Qn/KZSt/UHzn7FSoCTbc6h9ANQWFOS5dm8go+c3ZeVOt4ld9NhsZ3k1XFsoLEtzxel5kNYMwDE/+qO3IVBkX2Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789456068; c=relaxed/simple;
	bh=t0k7VhOeALx/k9IMLqTLqcfPQJSWqs6QTFOLUhJkvm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kneISbtT+0VJBBqyIdWVJjb9BoWeweiUNSerJZqOEoWN3rXgVaWgIBhxEQL2JbdgwPDt6qGhpZ9GbGmv0tA/Zi1Wzje/mMnjEG9aQpVs60yvFwnMV1W8x52X0qiRC5LeR2EKemMNBWqluGKJFp3IJQjhWB3My9fEgY8nlTLDWQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOcZ9cSE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOcZ9cSE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7921F000FF;
	Tue, 15 Sep 2026 07:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789456066;
	bh=pSRStC7aY5Clq6xWKHD8Xid17gLiCMSgSqnZi2YOUww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nOcZ9cSEWmU0XM47BOUj216dvjlNZAV14YSjDQQ/ya5b1RTEil7V+GdiED9mQsauM
	 ZJzMX/tgPCRCrUSIzpMwelCJyhZEF+V/t3cQMEBGeAr2JT8/0vzykVNUnrmy5z4LGb
	 ICCuNy/6y7OeqdHa+SUyWigIIap80+xCDNmf5ZXMibRlBazebjZX08/GrjkB6YZT5F
	 yLT+MILRaKaiVfCHPY/vRSwjOLY88KT+lpToEZ6epYRS2PRgo8MFcl2wWHIxbbdeuI
	 xWa1sn/rOB803dwo/NkiBz4etAadlcYvSs+nYcGTTIXjSALZEuPDtntT9r43q1Qxex
	 0xTLYrsrWr4Rw==
Date: Tue, 15 Sep 2026 08:07:42 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: make smp_rmb() conditional in tcp_poll()
Message-ID: <20260915070742.GA314999@horms.kernel.org>
References: <20260913123224.762935-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913123224.762935-1-edumazet@google.com>

On Sun, Sep 13, 2026 at 12:32:24PM +0000, Eric Dumazet wrote:
> Commit a4d258036ed9 ("tcp: Fix race in tcp_poll") added smp_rmb() in
> tcp_poll() and smp_wmb() in tcp_reset() (now tcp_done_with_error())
> to ensure that if tcp_poll() observed socket closure, it would also
> observe sk->sk_err.
> 
> Currently, tcp_poll() unconditionally executes smp_rmb() at the end
> of every invocation, which on weakly-ordered architectures such as ARM64
> emits a memory barrier instruction (dmb ishld) on the poll fast path,
> even for healthy, active sockets.
> 
> However, tcp_poll() only needs this barrier if socket closure has been
> observed, to ensure that the error code set by tcp_done_with_error()
> before socket closure is visible before returning EPOLLERR.
> 
> Move smp_rmb() inside the conditional block handling socket closure
> (shutdown == SHUTDOWN_MASK || state == TCP_CLOSE). For healthy
> connected sockets in epoll, tcp_poll() avoids the barrier entirely.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

