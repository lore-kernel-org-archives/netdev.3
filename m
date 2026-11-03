Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746966;
	b=IeTqqvHyx1aI4QeWu345lILKN772WQ0AD2FyBJelRjiTptsmKR7jvv3sd5qL9gtrIMD6
	 +pIHR/7d2PxZT7sy1e22LDDz7mKMeH+rNiph0FU0mjBHi/lQ8iRgsOudzMB9ZCMckeDYW
	 LFUq/qE7x1XsryvwFvfkXniEbzyfgK+k8auG+lXV7bBPC4OH1q9DMspM86Qe3+aB6NG2r
	 sZgtGtL828tjBfAKL/GXSsk3FGpKrIzGZmcI5ljKemnv3ad1MYxAZDvd9bfKdNKZApsYo
	 7bO0yRpcXSRVL55wj/kZcjzdpzUHSH9F8/D7NafyBRJ7I4pFgf1A+tVQq3iJCx21Wwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746966;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=sxZGDDO+qarBNehVRXLiW4QnSXHqNnckr4gCKtL4jrObAHRd/OFLcuIXUGnKf9O60uO0
	 1tzxKCyw/ymwt4DnND9Ff/vVN8aYJr2+xrr7MbVKLwoVvjk0aof7JDThf8mDHUApZ+PTN
	 ZC9v/bm5E7xuANICGgdd8exQKf6zYZTKf/p9o7VXRlun4nW0pQgWgPo3aRLjm2EkVWw/Q
	 hDhDUSjmi12KV4iAVm2TMfAxZApOs7p1DEaZP6N5h48qbn2TfROeEnp9qkP6Z5wAp0rCA
	 wy+0ridaHalet4Irc15DiK2aivoy3yWJBimqjWJlr1L4RnUrjNaKTbG800yB1awOpXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsZsUXgK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD389606A31B;
	Tue,  3 Nov 2026 23:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsZsUXgK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB351F000C1;
	Tue,  3 Nov 2026 23:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793746965;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bsZsUXgKk90CXnyipaDTd5hHh3xPlga2/lF/iPnW0HFbBlAU0MbvZlVmCXnz133Zc
	 oSSNS0hnu+SPNDPBrQ/szNemwRmxCgVdBdY2gRYQ7ystDlshbyWPscb2AzXm+F5qUu
	 uKcPYcu9fQ5GS4RjTkB8Sogp3arAmyNyH+14vwGerwztQ+UNqj1w5dzdY52l+a2KMW
	 N+/UGmcDXyl18IX23iJ+5CIR7ffdccqWcMd28MkkikZw5MaAGztVJPyGJxWIVl0k+B
	 te11emPX+9fwg15CDFh+yQ84ffXl2RFLCQBEvCvq1tB/B7Gi2QtlTtspxmgY8LFKm1
	 s2cwU9kJkbNUQ==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] xfrm: fix IPv6 atomic fragment policy handling
Date: Tue, 03 Nov 2026 23:02:44 +0000
Message-ID: <179374696489.488859.7997993098681012351@kernel.org>
In-Reply-To: <20261103225842.3204446-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261103225842.3204446-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
