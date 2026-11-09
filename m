Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794207690;
	b=OWkr1QMFtlUV4kY8ejzTgm9cyx356TG6MRRt+Mrb33c3mdssAY4lDVQ6ei5DRmbv4meD
	 xe9F8ha2hwdpbqWr8uDWZ5GdpIbp8UpGS2JrK3qBa1IiB5Hpp2Nh1h45L7E+pL+nN8d/d
	 xTxZZM3ehPb88tO4N+ZNKccqbN+EXQQqKBZ28V2hbOQyoCksjtrXo9FyZboQMGcS6xcKD
	 yw9ZIKJbV7a9k2TaqnXufUJRTnPULqxyjA3wJFxv+7okfSfJQko4yj4LcZ24RQ/U7kBNp
	 ZaC3PaBGzqG/aZsZS4crJllhEZzIuSr8wmhFmHBzFSBVEQ85kKxkV6kDse6FzToh7tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207690;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=KgufMvWGRqJcbeZJcfHI9Yd2eiLpqE6RRkZ1ZkWdDsB9YyTUvBS/Op1onFa22bByyJu/
	 xh3knZl/8x9wuEsfp7v175mGNmAt3yDCkXp3nLfaZmwkXV4Ywvyrb0Xaq4lCLPAXX+yyj
	 aw+4fTnUugCw6i6QvZIv9peSf2sxLvvi3L2Hhx3Bo+KVBpjrd8K91YorxS7I6Hjez8SRJ
	 tua2QL+vhLJHNX1sBe/0AXoz1HBFxZ23Uj21hZd3wD+Y0/iNcHgbepATOwSHfBT61cOZC
	 9Es9cFeh28XT5czunBaMu6Qy6T4pUbNntDFB04x1F2w3WRvCkS8aHUNUy4iriycnKWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbalWJeO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34763606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbalWJeO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2471A1F0089F;
	Mon,  9 Nov 2026 07:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794207689;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AbalWJeOUWjRnGIUFajT46On8vQnMtwVeAEDKmjihorwpIDAL4CqnhhMgaNVApy6v
	 cKdbHdsK77/UIkXMTrEKxu4dxV+TQDGlZScEStV7grsCBnUe5RkZn7YTtWDSRsCsQB
	 zIT1FOuqxUU0tFLtyDLNoRcP/ujM4wJopfCSgRxuW92jkG2IZsLRgRWv2y5o8EPmxK
	 RbXSOw81prvq/pTxg5Q2Z/Jz4mkBlqSGT4TdiFfQqN5mZ1dDKMHIIJlBS+iuLsWEdu
	 V6ouqxlop+EAGHZ6koxYcgKKQOCnfm/67ojtNpie0lQUgwmg6djjSNsQPuXZqC4mht
	 3pxv2KMWeJNow==
From: netdev-bot+sinfo@kernel.org
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org
Subject: 
 Re: [PATCH net] tcp: reject v4mapped source addresses in IPv6 SYN cookie ACKs
Date: Mon, 09 Nov 2026 07:01:28 +0000
Message-ID: <179420768867.488859.10947068411196194608@kernel.org>
In-Reply-To: <avFvW7nn7GIZmZ-a@v4bel>
References: <avFvW7nn7GIZmZ-a@v4bel>
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
