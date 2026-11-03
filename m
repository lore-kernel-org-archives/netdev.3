Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698399;
	b=gpZhqSm9WFxmB/4WBK8SfpupCRY2y8OIpKecUnQoaMugNMW2zxJANY+mRdlUQzrvSILe
	 /qiActAhilpWZFWC9JMFozBds2uCz6HYsQTeJtnMnGySLdR6QdrOi8pvfON+ugocliK4U
	 +pVjzcnfDUgHgvPaSfG3Zt4bcnkctOGzsJUM019JZu8vg/ahOl1a1HBracCHOxWzZV3CD
	 KX1UHtNWGH9MwTEt01f9j/UUlNXutJCpJb7NDJ0wmgLn/lgZ7ldgWYsrl1SoLWXeBTNEy
	 s2ciUUCQUX7FZluYJzQmwuEdsXpTiXQ9Xh+djVpq8qXVWRUQuIlRDuWW0ORJyM+jw/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698399;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=WES0h5+7BzSkmF4t+ZC11uknWf34EVIjFAEac0UN5Hxu0R6YNRwr1yD5i0LjzPJoYJCJ
	 HQlDtxTcvBA/7O/L9Sm+LM96JHcNyKvmjYIw0vI68h7L/VjEMgVjj+yb0IPCiFYpst/IZ
	 Y3ZEIAgqCgQMOSXLqOLpH49sAm5OSwknzxGR9+sBn1fVGUQdI9N3yoxLZnnVpK0+ubGV3
	 ly2Mm1u1Jh1zN43Io54mSeUjSaFx+xa+T45OAv9z/dP3hMVc0oFG01j8vXTkQgU29bzs+
	 JBvjaJ6NcHbps7a80iCbchWqAlNtZgEFg5XOrCa7E6iobFfiNQH9JXAb3XmfVGtVzxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1AeSvbn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E317C606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1AeSvbn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8AB1F00919;
	Tue,  3 Nov 2026 09:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698398;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k1AeSvbn71zOWlzzqIAvD0mXjnvs3SdKZUdJRIWTyZ+5X8c/6gdj72z2YfQ5s6pIA
	 rBnJHXNdYLu0XTQrMlbRgyK631tRQSZxdjw1uhECgSa30zrhBJZRYmD5md2om0HFRy
	 klD7QOcXX677eSK12WbwzKeyMp/FZMqjILKCTP/CChKU6MRlbYqfYwrSYh6kZisInp
	 hoO1Buczy6frX1oDlii0VPEd0VCw+JBuQkr2AdQ3PxsYEBs+Ptrr0Uxg26sXsK7776
	 c1q2Nnd1YaIRiT5c+qCv/oQhUQeTU0YNpg6r6SRKaRHcNR+1OBptzSMGIMvbWFeGA/
	 ou5zotniXtVpA==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net] inet: frags: bound the wmem charge of the socket
 completing a reassembly
Date: Tue, 03 Nov 2026 09:33:17 +0000
Message-ID: <179369839767.488859.11165843672492229472@kernel.org>
In-Reply-To: <20261103092957.4164530-1-edumazet@kernel.org>
References: <20261103092957.4164530-1-edumazet@kernel.org>
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
