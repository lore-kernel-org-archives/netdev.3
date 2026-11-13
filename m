Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598677;
	b=antZUPr/4MnssNNAHfI1Jp/rVMrwM60PczOi2q/DnbKnGFn/xHxmeOmX00zOodg8hhNP
	 A0zYaken6A7OKoJgjLX84MaROj7pVArRRzRwpIu/t0PcDAWWxV2EIcftrA6hYs3wA7KzE
	 nkvK3eeTqFp4OAYdLkO++8c8tfluHF1f5HZugt2rjiy6ga+l7Aqrxry6Lhc6rGiOEgX9u
	 q8laNuTw0XmXR+j+DLGEhv929hRe6mQ+U8zLE9zX6GYItpkoy0po9Ex0J3/yb6za0ejzl
	 XARvS5ti7VkpIbx6ANYuF1Gtdr/COXRqVQQTzlbIGRYqQUE8NWHhJFRuhNOjJCWccpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598677;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=bhgX6TiO3ggoyg1USBIbhCVBJ0zZrGNa5rG+Utg78n1i/ZqFiN7uKQPpUe0OnPAnE2SQ
	 rp25Hq1KOlsnkgjdBFvS0iPwNx+l057WOSDQHKbNJ8QP1kPOXGMVVzYygzvaoTBcX59ma
	 q3NT/tsc5C8lGn0cdBrRcE0p/Zkw0d9ngmmqDgu2uiy/JyQuJcIBsGRZFoGJ36WcVHCMc
	 zsSsj5DNbz6Nnskx1aotNa5+j42DwCoDcsVIHqw9hBHJsoUER+w1vQUGeKk2P+y40Djoj
	 e1FIxfysSVXVNlAKuQ+SF9EXSOZBWO0TKLLM/qgkkntcQkAS5wFNhe804gv11KzETHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGvRXjaz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CD6606A327;
	Fri, 13 Nov 2026 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGvRXjaz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E8E1F000C4;
	Fri, 13 Nov 2026 19:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794598677;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UGvRXjazTqUrFd1aUWNF2u4UPVZDzjHnO8YGdEeO77TY45oRP8ybMux/F6P+OZ2s+
	 +Vi6pkFrDulqfoUXG15M5UvLP1MARqtyehfoKIBJhU+Gm+thCm8BUWh7+BZEjR3NSP
	 WKxoEHRqd239CmakowucqcHqC4ywh2edmxaKL1+SPptL+uQGaEjlZFblESbMvnOddO
	 5po6HbXvYhcwl3dSh5RTgtGz77ZIrU979mCmOXmkmWE17w1vswJ/plYCoHuH+ybb4E
	 M47NeUz4mFV69802sTzCbQMXlN9llKYWv4WWcfaagcrTsisdU3O7DcHnkvqO6iZqEG
	 hZJpI1sn1kzyQ==
From: netdev-bot+sinfo@kernel.org
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Simon Horman <horms@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] neighbour: do not update an existing proxy entry on SIOCSARP
Date: Fri, 13 Nov 2026 19:37:56 +0000
Message-ID: <179459867630.2168702.7684618528835869761@kernel.org>
In-Reply-To: <20261113193355.3820232-1-hengyul@cs.unc.edu>
References: <20261113193355.3820232-1-hengyul@cs.unc.edu>
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
