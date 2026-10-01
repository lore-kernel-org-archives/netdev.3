Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34B408629;
	Thu,  1 Oct 2026 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879350; cv=none; b=rhjq2WLvZHb8kI+/lvNpK7vRAwubm3t3f67VzFQyh18TUs+fJh9yQetHdXvUyHwSHXtoIk5DdQJ5ybwQwfnLJOQSc7bCuqvNFUcUjGDIqhoJKloMRzKQc3/CC8Yej4pDgx0EcS2Ay9wwg2YteCmFrKsiAVCiiEhR2t+4E0eXckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879350; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nx5NxAiGSqcR38A/pBzZAPnFPKQq2srdJQHtLVxhpYe6gaNhjWwMovmOIGdrJskPLHdE0TDVwFtQ1UI1DWf9N5nxhkPUnVqaYRaGUV6kmBGGsROerzf7VkPsQ8MHJJJbcQUdWobcUY4EXjf0jvKVmcT75lBLk5QXVDM6Qnmoykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EV6FmYHi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EV6FmYHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD071F000FF;
	Thu,  1 Oct 2026 18:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790879348;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EV6FmYHiVv1JGqWIFBzIa8is+zTY3cNmr4fl8Pzns/BhsmGVqJivsqKdK8HXdWJ0P
	 zluyV73I/IirOnEIHpDv6Mrhxar7Vs6E7qciYRI+YzsXFdlfE1wCxYU+Fu55j6y/ap
	 cIdfNsqNramuHvi6u6tiQh2L7kQlu/m+vQAfDHCFmLSAT+Tn8aowTM0cES03E8dA2V
	 PpCQtHyALDxBZ/4D7SzqfhXOF0AzKJx92UWXFGKpV1IH+hMSr/kUjeEq80m2CpLm25
	 /DoljWQq6nZ6DHG9kav43Z0rUhgxXUMXgK9KwLCwFIEq3ylMD5FJB8OJw1ks1LGWcQ
	 qVzm1FTL8W+vw==
From: netdev-bot+sinfo@kernel.org
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Stefano Salsano <stefano.salsano@uniroma2.it>, Hui Peng <benquike@gmail.com>,
 Sashiko <sashiko-bot@kernel.org>
Subject: 
 Re: [PATCH net] ipv6: rpl: unclone the skb before modifying the packet
Date: Thu, 01 Oct 2026 18:29:07 +0000
Message-ID: <179087934758.1402591.6992807182585473895@kernel.org>
In-Reply-To: <20261001182136.33-1-andrea.mayer@uniroma2.it>
References: <20261001182136.33-1-andrea.mayer@uniroma2.it>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

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
