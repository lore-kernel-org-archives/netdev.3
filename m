Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888084;
	b=vX9h1woOmYILJ6NBk40TwDH+dZWsnF01NJaKeq7wEq5SLd6V+qU3wpN0/1FCca378hvk
	 v1FUlhEghdygYqRcBi4vU4tBt4j2ZelUtD1B0ilWgYiEoIucBKr1+AQ9Nk7O3jW7nrdci
	 cPFoFGHqNO4AuBaOYsUdNryH68MTujkaiTDX4fKjrqPx92aSyTKECqT5sbUG/y5GH99GW
	 plvLoiCi8/aFqHYuWfz5Kuh61Mii1ScOcgV/F13F9EChnPCvZltAZTOfxx8DldIDFDiow
	 CuO8SvqT3M1t93TxnZFU7NgP9BrXVcrlsndgxuBV4GyRjMCEyfHhfsMYMUa6RSQmWrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888084;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=L4qcZpJpctSR8L+gEVgzkaLTeY8FpiA7w6TRy5u8043q90SLFDo5wt+8XgZV3+EPdYw5
	 iraCumjUmfb8WCVTofwc0yyV2KI3v04Z/qh7tMt1fL49l+l11TVkyik9UlGiwf1zGRm8O
	 7VzuFnanW2uyh2ed8ZUIhd75dYaz4Y5ls3i/+WILxbfE59+l8/KRqgWyQnjK4PaWxLK2+
	 3bZfYGo8KRBZu6LlWFcO60eE57NJEm1//LbNKY0wi78u9duHDqRXj9SjxoQjR0hbUvK5n
	 RXAahTnoSlFA76jWRkcC++PojeH544yFiObCTz3RlAO79D1vG0Zf7muw3tsyarYNAYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6UuvSRM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C53608361A;
	Thu,  5 Nov 2026 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6UuvSRM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3CB1F000C1;
	Thu,  5 Nov 2026 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888083;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d6UuvSRMxWeFneG33dT1c1heOT7SXHzFt9dpZq3uO5oWrn+IAIF8GVAz7TQl4hzeE
	 So3+Ri9fi4vrYaDxoNEJbZeYYu/rBuvxLoe97ETOldVXO0U9nzZHxXhXkm98b4hl/A
	 d0sScHVoPyWxt53RlmCS60uTWz9igRXlBVE544ndyy+R3vWy8YqCc9w1H1xxreVAQ5
	 jCrTYWMjMqjW0szaKMo0f2vF5BCIkeNJIh4tsOsYREaKAedvsQro9nB3A6iCG5D1HB
	 pnEIQQdjpSSQMvRPLX1wuQMsrqUffpLhkGWEJmf2fOI8VGk5oiKtTKaOHuIbIcpsmA
	 O97thb0HbTLPg==
From: netdev-bot+sinfo@kernel.org
To: Alexander Ildiyarov <alex@badcode.im>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net 0/2] wireguard: memcg accounting and initiation race fix
Date: Thu, 05 Nov 2026 14:14:42 +0000
Message-ID: <179388808273.488859.7701559647747958374@kernel.org>
In-Reply-To: <20261105141006.95083-1-alex@badcode.im>
References: <20261105141006.95083-1-alex@badcode.im>
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
