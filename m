Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598291;
	b=KtgnO2PNsZXHUlVYt3erCZr+2ptCmaGFBbk8pocAUopNnmOxXCZeV/QwXIAzQpRkEShV
	 GCHZx6OQUoOXvRZ3/6g39tHKX8IH32Gp1AKHD2EVeGTmeKN+Fog284shrrqSK92v13cSt
	 Cr6tUZ/AVJm36kgeNF5LCYswFUyxi75sRdu0MVVvHIEL9HcojMDzS7nBOz92Whmeq4z8r
	 62OIiYS5FnWb0d6K1g+Wpj2d9e7mpm5IlIh9RNEo7Dv2yDAVchQg8ydfhOG/Xb1BLPv6w
	 UtkjyvNeKYB84mRtU7zLO2/lSqzYXEVAaKTBGPyLpB9Gifq0gJYrBW/hHUUs4XjqdLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598291;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=qZzw0ArYOMv0SZ7cG5fFUgMDjubZyAOUb1Ipo8GZaEEVm+VNZykdPZhlRejauzM/LwVm
	 SO1dfG6E/p/4DJ0UacEWBNt9e09WZLddiNSZVW2JeltSvB+OR4JsWy8fFrLehKytOfK++
	 Tnm97/yMEgUGpBh7mef/uQWTRrVxtdO6R4UEY1JJdpE+/2ROdd/sEvFE3I7L7yW0/o+5O
	 glxxJrLqK0kltcv+mMdUFhvJjMU4XmrUBcf3cwTmmYBiFm5bM7Sr7gLVbhFkSFqeIN8Qp
	 hx7yt6+dKtsoINnE1QWarlAHMQE4ZnL0772MdV/0RpXtATMNTOf3mRAfghAKcCs6iMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CN769Oxy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B32606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CN769Oxy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414CF1F000C1;
	Wed, 21 Oct 2026 15:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792598290;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CN769OxyASuVYI6/9lml6hXAdVohr2fLrfua2EEVJ5BB594L9CScRsPHpWtXF3YBj
	 V9DVz2Z+UBDH5FBHJG1bVDfTv2cjMYpzBZJl+udYIjbqOf5CzJio6wmegZKqHYM2PL
	 ms1ahLQLQRDIjKwBlcOL5uXlKqW26Xnlf6t4THZ/cuA+G68RjcHJt+4g1GES6Dck7w
	 cRBa8FsTqOt1hQDTxJdUz9D5imwSa7SoBaOgM8kD60jfWiWCuzmoDGvgRdQrvIdwwZ
	 zv2uRuZy/kmSB1Xz2F3hA9aqV5FCgKqmgM9hDcbZAAiKEqbZMB/sKRF6pLYZYvjCvk
	 VdSw+tYx1L7Yw==
From: netdev-bot+sinfo@kernel.org
To: Dudu Lu <phx0fer@gmail.com>
Cc: vinicius.gomes@intel.com, jhs@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net/sched: etf: initialise the sock_exterr_skb before
 filling it
Date: Wed, 21 Oct 2026 15:58:09 +0000
Message-ID: <179259828981.3290.1199435370807230530@kernel.org>
In-Reply-To: <20261021155401.65997-1-phx0fer@gmail.com>
References: <20261021155401.65997-1-phx0fer@gmail.com>
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
