Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08388369208
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142357; cv=none; b=ewixPrHIRHnNaApJCVQC3SMG7CITLBk0DWxuncOuvug50MamcWQqs1Rblwl2ipL/Ot4yW4MDTlFdiQFpT2t3GSVrhnlhNc23i1rMnUw0gHcukUR4RKiNpJJ7ZVKA2ic+rEXDHRPEOPDasKOjEz/MHt77LoAoNkOUrLnDwo2T6sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142357; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u4QmyJ1RXPocHSrxfjp9GlbMX4IEdFvRmVjFxsx9t1ODBjapotdFGWb13eerGILrRxDZXEwer53GKEES7slcOzoVt9iHxzoflybPpGwt3/bEXmL+f006qt40cq96TLti9tqPgPIf83+VzffWfcf2xrKKs530TtaALB8Q28a7bB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoMGtO3T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoMGtO3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BF31F000C4;
	Fri, 16 Oct 2026 09:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792142356;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EoMGtO3THpstrM01B9Qp/j6cmJyYgI0c5tIcSxSybFYqyZ2gHnj8y4No3SYEyxQ5D
	 mOHiXgYxv9vnIkWH8eAb1jFij31Iz2Ep/4/tRFClzlwQAJNLUa2TPzfRTG3TpJ/Ri6
	 YFy7b/HQfD9v94Ry1cb/WfcTABaKq/i1XagmspJwF7xqc2qboX2CRrCwa8PLzjr9SU
	 8iVY68fWlKeQpnIWawCd5XgggZOP5ACs9UV+wevOVB6yjL2qEOi+WztBpOmsDV/oT/
	 TbJqKmjWGM/ZJmXI0NR9xwKOjoi3XZgzYJD4U2aBTQk+WEJ6XLTlwirumFs/mRolzB
	 2riC+Fr0UuTZA==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Qiliang Yuan <odys.yuan@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org
Subject: 
 Re: [PATCH net] ipv6: account route exceptions to the netns of their dst
Date: Fri, 16 Oct 2026 09:19:15 +0000
Message-ID: <179214235565.408196.17937869760737531000@kernel.org>
In-Reply-To: <20261016091556.2750902-1-edumazet@kernel.org>
References: <20261016091556.2750902-1-edumazet@kernel.org>
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
