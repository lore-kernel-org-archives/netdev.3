Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B226B3A16A4;
	Fri,  1 May 2026 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777642104; cv=none; b=KynS9YHHqxjICjwXkv4s3/E48M9SzneZr5Ku2zq9+W39kO/DRYbwOmhSxtwWOTYQStGIO8mSQNzOaSb39I82yX5vn/jMAlf4OLxQhwJIYkpU6eu66bEqlfsSffNiNi91DwLCcEziQ2NrA0COn6HuSu65+pRSkoRjhyLSZpJJFt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777642104; c=relaxed/simple;
	bh=EiIjBWMxWONv9mLaw0wqiMAPaQbSeljXGKJV4PKEVB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ll7p/svz+mTffHu3yR2m318ECbv5bIA8mfErvFtjdrqQ05x/hJBUb6GtiJ1yYntfOei5Apek1DDC3CbRv27zQGlpJdf9SpkDKP3PH/Th+4NcClTFZJZnGPuOnTQMYg9/jFaX3f3nI7aDNLqrACAGH46D65T8YV1LdtXJZFoZtFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxlgFwBU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxlgFwBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139B1C2BCB4;
	Fri,  1 May 2026 13:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777642104;
	bh=EiIjBWMxWONv9mLaw0wqiMAPaQbSeljXGKJV4PKEVB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxlgFwBUVqdfdXNK4Cv0AMD2KaToJxkI11QiHw0ideYVPz8DBVnQ8gjLB1sy1ZBm4
	 +S37lZd+ogWYmw2HaLwf5/hqZ4nxNHAWX8qIiqMR3y9EQlD1xc2tYN3moRu0LSFp7w
	 40NJGRP+gORw9ddxK+MuI0JloHF4BDAzNJg50wF4m8GdJi4AiraeXeLTkS6vYHm7nC
	 JNpeShedrYHBAXfOMkGw1+rIV8d4a/UITH4JTL90657aSF0N9sNe5hPNasdovlvssI
	 KPpqQrNYqB2ccznk6a2D8MkB2EQzi6xDtLZW2wFZso8zCLuKHSWd/78ROMsdnNAdPs
	 5opnoadG8Vzfw==
Date: Fri, 1 May 2026 14:28:19 +0100
From: Simon Horman <horms@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	Junxi Qian <qjx1298677004@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nfc: llcp: Fix use-after-free race in
 nfc_llcp_recv_cc()
Message-ID: <20260501132819.GD15617@horms.kernel.org>
References: <20260429134115.3558604-1-lee@kernel.org>
 <20260429134115.3558604-2-lee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429134115.3558604-2-lee@kernel.org>

On Wed, Apr 29, 2026 at 01:40:42PM +0000, Lee Jones wrote:
> A race condition exists in the NFC LLCP connection state machine where
> the connection acceptance packet (CC) can be processed concurrently with
> socket release.  This can lead to a use-after-free of the socket object.
> 
> When nfc_llcp_recv_cc() moves the socket from the connecting_sockets
> list to the sockets list, it does so without holding the socket lock.
> If llcp_sock_release() is executing concurrently, it might have already
> unlinked the socket and dropped its references, which can result in
> nfc_llcp_recv_cc() linking a freed socket into the live list.
> 
> Fix this by holding lock_sock() during the state transition and list
> movement in nfc_llcp_recv_cc().  After acquiring the lock, check if
> the socket is still hashed to ensure it hasn't already been unlinked
> and marked for destruction by the release path.  This aligns the locking
> pattern with recv_hdlc() and recv_disc().
> 
> Fixes: a69f32af86e3 ("NFC: Socket linked list")
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, there is an AI generated review available for this patch on sashiko.dev.
I have looked over it and I believe it only covers pre-existing issues
and should not block progress of this patch.
