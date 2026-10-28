Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196931;
	b=2Clf2kuZsMWOOf/HmKuSn1ybmx0RKqWCA2B9ZFVqkgrFNg2e80GONUwij2ywp0bduUqz
	 pg+ixwUQb0uFXNSaaAl5MB0HCiYx5ELKJWkB7J5X1NZLtt7iZr0QbPz3LXzTVSUrbn5Ws
	 RHzVwdM5+Jt2l7mi4PoLHqNpvNyl/CkTHFfUmFwNgFKsHaC3fKCynQUDuNvJ1Xv1nBIYD
	 p7x+dr+GvwLWstojmlNwryOQIjlc/WKgIXt9uutnZzOZTjBiXkKyV06zl3G8hNymt1D/u
	 w4fLaZsiNhiz0iWMXyWcnse+fQB6gJIzvvSfBzdDui3BgUJ3RyuUrjhHcV7Yxr+XZqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196931;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=NQ4g4eRxwnVlIJU9cI7wZlS5bt9P4P+Tzjm2W9vpNNQek/6szSo43uSxrQH3jWul3L3C
	 V3H9+BJfMMg2JCRHh8vE8L1DqPt/HLAhvRMRPLj2dm85xJ239eN9YlGKZ1iNL9CQ1CKxm
	 UJ1ZUktXq9HbsaeCTi0wzXbWmxi073H05MLVvXJJlhiDUTKB6mHlDjledIPrBFQ14djEE
	 wK8VJHE+pGJ3whqR/kaf9LNf+DxBBcgzwqKevd+Ves38xhiVor2OExO0cP0pZg8wOEdGJ
	 rrIRlRs4clIowl3OZkDjKY/jEoaJvaKu5PLKyCG3C2Fey5p9YlDPdeUVOhcacLNAfAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxrwzJ1x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD1F606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxrwzJ1x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DCA1F01825;
	Wed, 28 Oct 2026 14:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793196930;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VxrwzJ1xLnKh/GPG1D0EOBUcoVH9SzcdBbeXfdrWyqN+BKL9Yo6wdju1p7aZ0fmNm
	 fu1xFYKMviVK7XjD1LeC+2u9JA7UwzzX7i7sMNxonwo2ifQspvDR6U9Zh821conB8q
	 MmUnOMcxRmhYHCu8fRKJTzs+pVS06M9yxrFD0R0jodo+h+xUdl5L9uYb5MEbGnSWdV
	 rq85FDe6+Lq9qdwZvp8+mRdde3IDlr6KvJz4QiRs1fi8jsBHGPPBHvXYiXMm7D2fmi
	 PGo3pRly+tCdtjD4sjXz8qWRLMO9+epB+sp1jV4PfwmHIPvj1ChyKAuIQM9YJU27H3
	 mkeG3afNS9RxQ==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 AutonomousCodeSecurity@microsoft.com, netdev@vger.kernel.org
Subject: Re: [PATCH net 0/2] net: gro: fix frag0 and remcsum handling
Date: Wed, 28 Oct 2026 14:15:30 +0000
Message-ID: <179319693002.3327.12201524621910867445@kernel.org>
In-Reply-To: <20261028141325.2103814-1-edumazet@kernel.org>
References: <20261028141325.2103814-1-edumazet@kernel.org>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
