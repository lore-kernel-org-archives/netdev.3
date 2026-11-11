Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378399;
	b=4rDdcWLzBi0ISI1kdxpvrNvOGzq/DsiFefdWdd1sT3OhnWp/YuxuMMZ9f3HSjkTITaLj
	 fwCSWEGpA+Si4NuLJ6xJQQWW0VeRfqi21IRTN3E4s3sBq/CpslV1/oSHFMELkZDRhQOUU
	 4HVNyEbzvfMStNoFVobcfgzYbnrl7Dt7mH3iAP1JFziPot8mNDhiKSWRFqiZ9jMl/pQ3+
	 6FYgT4GRHtTE9BXBiaP9s5kEqOjn4C5H4KFrgbyg4WYEEB75CC3Xn52B910v/p4HyPVRN
	 W7Cl5AyDx6y1bluIiuk0cxhqUTBxOISRy/fWy2g4nU86z7rF3BYG5D0aBp7xJLskLKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378399;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=aH1lj8dIHst+koRYHBjCH8ZxyIkd4I+Q8tgCqi7BSTKzmyiMobCP796UD3YbtI5niPjf
	 tjvctZKLeLKh/zHX5fp04LAI5jn3AZFySZocnKiITxB5BzVT+TJuTn/tdaRLX2odbEFed
	 s4X6NcfSSBm7WFBogJ3/4W4BNsjsKUgn6GtLi/GWVpgs368/62Tls3N7SGZ+YlLFI9af5
	 HpZ1SL0fg7gH2lL5s5NccDhj4yBAtnSn6TwCJLRYzrdkW6sFiA8SCU6Q/LWEuHJUbZdiH
	 mxpe438b4HUn1a4dQ5WCgFltpOk5Lv+5f3P/RR17rGXynUzomV2uoZ9lM2CLsJWNoPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kx3glgUK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79FD606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 06:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kx3glgUK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212551F00A05;
	Wed, 11 Nov 2026 06:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794378398;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kx3glgUKZ91cXiFo9j6hfxodO6CnAKxxzdb0fIe97+R4Q5GOxmym9Y9fNUbIrb0YC
	 SHMR6Id+PPWpjj71v2UcVrFfQW8qHSeWwx6gcUP2PZ9Dmpn9MhUEzfV/iHM0cpRyEG
	 auZcwmvLPTYn4rX/oEVY5E5K7qzscFwqmiaG9770KdoKs/2qdtadivMiaBuiXY2Y53
	 PjXCeM7Lln/0BefDHbSe8DqHNJzDgTFNCzVzB4wPQ7siTjLRYAqmEGetoBJHU3fa2a
	 G1y1/F2MZji+5EWQ+PX4eSUoE987k4TjXdOvKJiin/dr/Fg6HV9xfMhyJDbnm//2M4
	 MoKkn2zJTn62w==
From: netdev-bot+sinfo@kernel.org
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net v2] tcp: fix request_sock use-after-free during Fast
 Open accept()
Date: Wed, 11 Nov 2026 06:26:37 +0000
Message-ID: <179437839767.2168702.9870227089167877590@kernel.org>
In-Reply-To: <avQKA_YTAThtbsYU@v4bel>
References: <avQKA_YTAThtbsYU@v4bel>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
