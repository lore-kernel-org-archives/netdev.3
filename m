Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228948;
	b=yqrW+IDmApW4SHpE4zEb2WHJlsJtYb9XX58c6D/luy2k2mTDy78ebkVaZt3CDzNKMm71
	 /oB9wSbvXzr4opHz5UeZOiVFYVYbx+l81iyOyG02uo6SFOrlB4bB2mtOaIOiFxU6YTSmQ
	 MQlhq/iFi/g9kB6ykkYfHcuXu2eR19lfYwFXaliTJ0tzUFSqtFOF/+ySfK+VCyeLg/kYg
	 7+RAyjf7tB6BV0lSDMTlXGsw+nOoqymdPnLyucJlherHbLkjYOb7377LM29rNAe50T6ys
	 IFQePufpDvyVB4gtxMFvxJRbw/HQJz4kPSYPtmuQZRh3F30qKbrHwX3x12Ce6Vh5k+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228948;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=kw0pU5fJYLabLzm2TZxnPbXSczZohIpAKLdAOkOFn91re5XF8AueIcHsWByqI2UjE5yA
	 xb2iuWF5n3O01djERjJXVB6fs5km2iH5Dc2KiODSQQUIlE/W6dGbgNnzOI/FAbDHkvcop
	 dxOw/xpVdUZk3hyWVhqFAg6gEk9fa/D5ExSi1CT8YwKGG+u+DuZzhbEtAlyB9E5bUMctP
	 lXpbdAUUg8RbP7Sy1AHfWGrUfqmp36Qf7Qos7cGdtVR2Sqmqy1l/A3UqKG4GRhJuUt4jH
	 gmM1m7E30letowafg2lwNSpvhHbMKJf/4JX/Zmu09iZgwig//JqmpYUnXtB790nsa/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eS3zDmtX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F5606A330;
	Mon,  9 Nov 2026 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eS3zDmtX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7951F0089F;
	Mon,  9 Nov 2026 12:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794228948;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eS3zDmtXQoSM0WBw7ZtTZCxurQv7b9ykrc9ps93JgPsshsqc4135DzveG9YbJJJMv
	 6YtKqUWyD043tBclE20lvRheodkDJtBC5RX3JaRJl1l5u7P2qj7+KhqaZGm5IeqH2L
	 So4v1DZnQgEWG/K0T7G7rj77obIv1N4oYlHqCC4jGg1mE38FuAuuw5vWd3wiWshBaW
	 65t+QxWrQ0uxNM3Zb0f5ayK8uxQmwFGyFwfFbT7Xn8ymFm/YhCIatKhkHZOTlAN2yv
	 Qu1e4eE1zxANV0Xu1DQKKoe0RGfG8sgR2fGNR2HrR0vlI8Z7KCMW0BlSz3ATraMglU
	 nfQ9k+/Znlpjg==
From: netdev-bot+sinfo@kernel.org
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] igmp: use the joined device when leaving a multicast group
Date: Mon, 09 Nov 2026 12:55:46 +0000
Message-ID: <179422894695.488859.13925819352934947141@kernel.org>
In-Reply-To: <20261109125312.2208874-1-graypanda.inzag@gmail.com>
References: <20261109125312.2208874-1-graypanda.inzag@gmail.com>
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
