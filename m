Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334605;
	b=nyBzp3uXjEPoIIE9n9KIxuoyxhqjDE0M5zjGdIga+sG3yTWc9ViG+D/x82pOuJMmRRQa
	 NEIyxRI5zb0yBh9drnzpQbKi7580obIQmtC/9rogKJNvw74tGLFnr5ZyNvyeWRAKG5ty1
	 +AarzKn8k1Pd5XSg9ix0V363bfWke9jsHF3cg0J9vVoHAF3B2KRrMlL1nkzlcBaty8CRf
	 YYbCXBRaEb5zHKymiXtR2fmJgv+EyovHYJzxmPBRgM7QkKfdtdSG0fQcFeAlAmkdnkyRz
	 E2XNCTF8oMdK3N4mGB6PNd6b1Kew2hchHHgiWcOlhI+nGDm0CDvVuQtq4cm1L94D7uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334605;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=MrvCQzsu+u+X7twykW8PdvHhvoLCjcthueo/Z61F+RtMJgUFiWXMEaAy2j5nNhJzJ6KO
	 odl5y4do9A6l/rH+LGV8ZQy7XrYJLPWC14sc0ZlR2k5Ab/QEFyZE90hIFamcyY5VLxmwj
	 0FmhK4B0xWpZhMAcqViR+cmnSzotyKhc9KZHntWrVaJoxXAVgs2u5FAhjUq2kVjudkotK
	 M4oWWxBlbGJ4bXSRkEUBX+VhWCI4ol3HFt3NEu7f/7Ikgs0rAAOuPv7NViibaPkh2gUWy
	 IzQQPsqwlgrHRzWHz6O7YWgEm+1zP6YKS8kAiseHKtVj2KjdS43e8Lmbv5VokOQswEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kqtk7joN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09C606A322;
	Fri, 30 Oct 2026 04:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kqtk7joN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71D31F000C1;
	Fri, 30 Oct 2026 04:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793334604;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kqtk7joN0Xd5irgoJUgeQ5jBi/R0oXFQ0RDnJEMN4+w3s36K+gqNlunJmB0mcjLIi
	 5tpL48a9UryWGPSd0i4zwrvAQGSAx1ZGCEz2zjcFoORoA26L3TyoSFf/vK20PGJgSN
	 Ix9PmPx8bOa/mYsCgcyiVgtq7sQBHwfLrt0rOr05LqMocs/23PLJRQUBBnMVDIVWRl
	 +aLPaZM+lZ+6gknien37lAKmxJNiU5HKaq4jdxU+yw8t5lZ2BjWwI+BpAKHtnSG+yk
	 VXWaRJ9DQLf0iQjJCzjo0iZU/UU1hgXhHBD/f63T/VOKkzU8RyiiriNJ/Wkb4KRvBX
	 J9nTrHkFJHnig==
From: netdev-bot+sinfo@kernel.org
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org,
 outbounddisclosures@openai.com
Subject: Re: [PATCH] net/sched: revalidate the sleeping-root lock in timers
Date: Fri, 30 Oct 2026 04:30:03 +0000
Message-ID: <179333460348.3327.13756554331672725273@kernel.org>
In-Reply-To: <20261030042312.74363-1-kylebot@openai.com>
References: <20261030042312.74363-1-kylebot@openai.com>
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
