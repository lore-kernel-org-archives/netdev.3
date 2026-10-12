Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943B2E7380;
	Mon, 12 Oct 2026 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810280; cv=none; b=cNuBQHO8/xC60tytHRxC/NB9ZJnILeNXy09D5LzT5ZGZbeYc/r/WSKfhlbCYdExM9AlQngnWgiYPDgzOM2oyoIVAAy9QtS9vNBJAI79L2P+ddSMsDypc+mSKRWf68cDJn4x9zphSqqARjFRftdpjVRAaOIPgAD4C81Us+Ig08O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810280; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mqu/fxCX/ZUuqn+sM7TduDDLf44bbWaZ2hlJBUou5NRgPb5qFaAC5Ahf+tlR/zXcbxbdBsxlpKCEE4IIV3hZqG2pLkIjqOOPLGqMb4vJNeHs9NaqePy09kLoAybJpzOPfvG+N9XG80TocRWq4c5xJpFpT9A6fyg6Q0GzEZVtgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3m8+7Rh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3m8+7Rh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AA01F0089B;
	Mon, 12 Oct 2026 13:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810279;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e3m8+7RhB6ScibKr7XbAbwZiz623C2Ys5H/zew+ZRznIfmemE75gRwoDCbIMwKcRJ
	 np0BcGjkNKoFaFsT065+fYq29YRz2xnZHrDz/bOAiQetCEeF4zJJLtWfNkC4grLRsJ
	 yZmIaxjer3Mx6ocUj3mmCFJ0vF80kuZECXuaYzNGAF3VxPDielu9L8foOEXIsqAE/6
	 6itLKd1e6UXEfE4dq1vf4bpVwfY1LGDrlPiryJFHxW9HByFGvxIuAHbI5Xgcq7oEDc
	 3pmclQCO6bIDYFOFNw6eGCxMoNwUT1wyNEq4pJuvB8T/EdEs1MBjskWuGqoye8dDVy
	 78tjVjAhngyUA==
From: netdev-bot+sinfo@kernel.org
To: Omar Ramadan <omar@blockcast.net>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v3 0/6] amt: relay tunnel lifetime, validation and
 request-path hardening
Date: Mon, 12 Oct 2026 13:04:38 +0000
Message-ID: <179181027837.2527009.16947894937025349774@kernel.org>
In-Reply-To: <20261012125943.558629-1-omar@blockcast.net>
References: <20261012125943.558629-1-omar@blockcast.net>
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
