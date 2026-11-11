Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430040;
	b=b5dmhqtnlFr7og3QInEqCysEBVSjkryLxGTw8aBzbUdOWmtX3tAy4nsHWZ8XYscpCz92
	 L3tP0tpG5JwdKtsi8F4o/htu4o3yUM1MknzJikbTQZYRB22NvjT2XMUv6Dj615HvpVKiz
	 B7+baTlfe4SofI1Wk7lYi/3NeW+N1adPf4jkeaMjidxXoMh+Sdqs3ic3xVf526bBLf/0w
	 54HflmoRt5T2qAWx4ZgC0N+h1uiA2uHGS660ZAKsihB3s0UHQUpNK7HGeTIve/k+8+U6D
	 u8sPQIT3DLzSG81NJCwxWKjD4S/+VBkSpHRGo0RwPwZfj7T829hrnoXQ2VxUtMD2L5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430040;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=B+IdrmzJ+2aYuhu7s7WjDv3vJGewxP3vyqrjHtY9u9cJjzMKoIzaPxVXEsexOl+f37a3
	 PWnoUXSZJUI+G72nfhDwqwPslZEET4GaqwxgdnfBKQbxeZ78l9KtLigInVRS6NdsyLa3a
	 D1rUXZ3AEscfiFJcd5uijChyEFYNIjdEPeJPVAQnWcfGq4EVvb80agn5K6jk/xnjsJJQN
	 vzfSYSuL0oDnN+H4NzuIbnrKbERVeUMFe2xhKo5rHhKo+nMQbVfIUl70gyG9eWq406iJA
	 PYqBOZ0VT5uor4GdTEQ2YrtFlhxLHPR5Z10UBpgLzMMjiVVp458sDplrBD4P7QzHBcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQ146Vn9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F81606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQ146Vn9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944131F00A05;
	Wed, 11 Nov 2026 20:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794430040;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cQ146Vn9LiRcDDBIQoajJ+ugCBXs5plswu9hNP4+vxRVRBYq9biFIUnEtU3ZnjnPl
	 IMgkw6La28oQ/BK5cyFPORbwpMTzNwPGXrx8Me4y6d6tg9N6dLcOD9eebzNmPKnob6
	 BSy4uIWB4fsFOjOMpX5Bly6rApKHGs02nzKdYthtQKCk57En/LJEruLkBpK5q/PPeM
	 xJOTjBVUwbiRP6UV2835IHuD5dX478daVz1qvRXmcT4JjM9wGTzrGrbmvnyWg/CgRW
	 4X9WdnzxGfu9lHzKE/Uhjm1Nyz2eH8JIl8Qm0dt9FMe2rmVEapiBKYoF+gLywayjhw
	 B3485zsTNRXcg==
From: netdev-bot+sinfo@kernel.org
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Richard Gobert <richardbgobert@gmail.com>,
 Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] ipv6: gro: avoid truncating transport header offsets
Date: Wed, 11 Nov 2026 20:47:19 +0000
Message-ID: <179443003908.2168702.3813206213552261542@kernel.org>
In-Reply-To: <avTTQNyvwPP6LtGx@v4bel>
References: <avTTQNyvwPP6LtGx@v4bel>
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
