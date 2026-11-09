Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264995;
	b=0pQaXwhBops0ypjAzZhUUhZdGnjFtoJNpOxLXf9f5VEAqgi0GPH7WB0Rhy9SkyfhDugo
	 WDOYAtv+/KIbtRHZNx9DtjH0F/pRgtZEP7G06wA5qzwI4x7mG0EDIIEA9OtQ7+FHw5Tw1
	 fkUpywmth5WY/iErowhnQEPgWy+baBnR/KG1QxNIPvtjivAbq1k+g7qaWFmlgqgC3rpHv
	 j4Lcr7a39HqG6955n7lew/iEhGh0f+vav76bpGlC8xpCbKlc2UPsLj5+ruiv+hwNF9ak5
	 DE0ZbCliN+OPnkUMXrE5GrXIWNwBe8owYZAq9GhbK5tx7TxMDMR9LRagG7OGhLTwxgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264995;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=zd3M/hT7NbTE+1IaWwcUqIgTdINZOb9sB2fsD33hIoidm8CZMQ1t4s4coFGN+F8fD0Ho
	 +zud6k2Gc5Lt23OD/dShVXXxTrNVw7YRLA8DD/5JFDUMOZr9FzDWFfnHg0lglm/eIIup0
	 Gxbd10ihLPYO3RuQ7tYXTTv8blZKKwBzzOWIuk9RKyohT5DB1Hyw/W7+Gegx3TyfKQ56b
	 IuMTRJDEOmiFTyPbVdbp1lSKcJjb+PcbCzXG3b4jlLZUcLA6QLyQPs0fIzOlBEOnXYeSu
	 BoCbXBXhMKzIKP2yisiTtHPGDz12rXhFfNutGWoMJimHc6GgU6ib/70jpHTREI/Ug6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZqebq5X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC13B606A325;
	Mon,  9 Nov 2026 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZqebq5X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466291F0089F;
	Mon,  9 Nov 2026 22:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794264994;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BZqebq5XdQcisHnOldbxLsK4vsbACs0ZzEqR1Kp7ZYjgcYuX+pB+uIRimgsDt8WkP
	 fTfb/+GZm9wWY5Z+JHidL89egaYvqYKAT2ZDdPeuO98AuOSMA8pd2funcQXa9i4PQz
	 /QOZ9p8lXEBV/OA8T0Pw/AN7D1OA9FHAaCF7fBs8ykywIFWKhtxGyFwXTYswbYAlIi
	 AJ5ueVIDjiDnFJn3odCWCay+c+pKfK1vBo2mWcDORMwtuyn9I6GXoxv5OYziCdARQn
	 GhSXmZLy2POUtdjD/LiGviBjIOZmlc/iqyfXPXU8xYFFYKWrZXeAjXJYVA7Khi2QeZ
	 KQM1zfCAnorxw==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 0/2] xfrm: fix IPv6 atomic fragment policy handling
Date: Mon, 09 Nov 2026 22:56:33 +0000
Message-ID: <179426499382.488859.12636576773274199602@kernel.org>
In-Reply-To: <20261109213803.1785516-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261109213803.1785516-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
