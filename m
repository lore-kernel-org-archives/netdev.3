Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996544;
	b=yyCtdSu174xFn9qRwtSOyJKGRImoEM0UEtcNJdzWLioI2CWN9nnJR/HL5Zn00x1qoiXk
	 fmcOdTEj87iPhYAIJAQBKrxdbys0yiEyHhlDSRzcipeO5mL4XjGeDzx6kZ8iGFGjeCixj
	 ndr8sYbMAdTPyydu6L5O8C9Pw1AdooU1nPqqI/ynWNycNAlK4LDJ8TuHesLNU0BMXCJeS
	 2eWNdefQ5OM5u3QRumATBBdrQvlhFNPKCy85pYlMPf/EzvSkObn2VzYADmFhQ4BF+KufC
	 grJOGNB3ciil6/t1EkrTOk9Oe39vGPILrWwEsmII/ukA0wQUY+OJqWUDSInzBiIiWhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996544;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=p+cbvzIdFl5gCQ1RZgoqhQXcDFVWigNg0uNV5W7vN/zzW1haZthBXgfl6rAaF9E0fkK8
	 xxIwtJluJXGWwAxHQ0JgZg+yrCllzG13KRPZIGh2TmJYV3yJOzCizrdWkN4xPhC0ciqWK
	 5lqfMGgIpMGhqb7TU1PLLSXYamupiZTKSeca8T91D4OlGZJ0E7eVoPJA0KuC3GyR3JF9W
	 WlPuZxqXwpIcgMVqMMQ9QiXOagstsJalX1eS3uJ1CROnPqZu5ZS0EkKdmHC3cHJ9IMmAL
	 kY8GCGt2ziPcDXykCviLgT5P0C2j2gjIXk2vLRt291CpP8srpW2+tqflEyx5MepnyUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jl66uxc8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9DE606A326;
	Fri,  6 Nov 2026 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jl66uxc8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D651F0089F;
	Fri,  6 Nov 2026 20:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793996543;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jl66uxc89TwkUakNeqcUGW3Dc94GLS5iJDleh2FhEG3X/9cs1Mm47WNKaSIoj4tJn
	 ZNPiLB1WO73T9mW2GZJm5veu/v3pUTKocZvFrKUzVGfPS+IrjLbshwrQu0+NeZZ68q
	 3cUQW+8ixu8XIPBWCz+iCG4RSDAgc5NUYCfJofaDr84zfkEUf+mUdnAjutLf1rwx3W
	 Xua0ysCPNWYO/mAYrjrcofIhigOkSBrI/l3T5YnOj3c7vPdPfHJgI/+JbUKxrH7s1X
	 tJ7uOKJ0hUi+2jC797mOEhPil+/4lB3bCZ53pYdqRs4Nu7PzqCt0Q+sUJjLp5JJwS6
	 Yr4J0v3HjDXAQ==
From: netdev-bot+sinfo@kernel.org
To: lirongqing <lirongqing@baidu.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] af_unix: Fix wrong socket tested in the symmetric half of
 unix_state_lock_cmp_fn().
Date: Fri, 06 Nov 2026 20:22:22 +0000
Message-ID: <179399654290.488859.12173389538103383117@kernel.org>
In-Reply-To: <20261106201822.1734-1-lirongqing@baidu.com>
References: <20261106201822.1734-1-lirongqing@baidu.com>
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
