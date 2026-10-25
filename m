Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792960551;
	b=fteBsUsmNnYFVLW5Nm2ILvfim3YfClTEVfA3DLdvupegAVa2xHtse7E/hlAvrtLnZRO/
	 +4aI1+d5/ZwEcsV6/B1TnyT0xaxq0UkzkWTFQ9AMYd9d/x0gq0SfuXUbN7ZjoKSBaoFBM
	 IIIGVZiB9+z/6WOOMWS8eIz+qlR3V9DQdVGofPeN1T7vdap8FceFi/GQk2W4FrjE13B4M
	 jrGbdV0fkazc04xK9M8YiXkAEpcJL1wuduWFsV/BZdDYxHqTc51XKl6oNvsugZ/QFU8/p
	 q/tx70m9CrPPS3agCu/vErE/MePppGpjSa8ytyXSzqBzWMztFr1nqyyRJk6Q97tTGGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960551;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=45VDXUda6aQjdyd/Ng4NgHE93faiQFAFixi/mNPWv2GSmbG9pfSTRyWzwti+Q6+lvS0A
	 RuH5UFhIw92OcBZLrgKEWo4JSvwjiqa2MZg2fYLkoNDpk6knTEN4VSy1NnCLtJbNQCiYK
	 u7sqKkej24Ky7txmX6xUYq+AIl/4M+OIYXtKmr05XC113N+Vg+6eQijPi4KmuakUubrYH
	 EfnW0zjialbg/G2qsXKT1EveobvJhkBQZJGxWRgKLbNwIJ1HBKT7/lh8UA7zRz6ProHgO
	 p0XbcFG1ttlw+hseds36kX0hBWSAa//6s8kqgFqLFBVfwyfFWZqnqxPgaFiOK6yMhlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LL4hWD+G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B94606A323;
	Sun, 25 Oct 2026 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LL4hWD+G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB5F1F01825;
	Sun, 25 Oct 2026 20:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792960550;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LL4hWD+GkGDa58kRjxIj5qLLPYeI/a/q8qIkRc2FJ0/EjqBvqzg+id0GKzf/CHpbO
	 cG9nUf47DuD50btzX8h5das7rtuHViAYFq6+vnJWI5+j9W6kJmg6YpWQAKvVoBzFls
	 BnBOgnCQG+c0nE/ic48ls8SPXTZQQ+X5D+p/ZOfXyPJZjzeYnPz+XHg40ift7rGGo0
	 n188dkux94nKyjObgB3onCPvFZVV7l8SWMlhHCBgfJEaTTMzOuj2zbU7zspc56u6TT
	 7L+XPerhYGyLo0pzCjBI/tSzw7EgHRR2OykGL95aiWNXlNE8uBgCiiDyPai4DQSrDL
	 SI8xTc5kDOAow==
From: netdev-bot+sinfo@kernel.org
To: Selby Mashiki <mashikiselby@gmail.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: lan966x: fix double fwnode_handle_put() and missing
 mdb deinit in probe error path
Date: Sun, 25 Oct 2026 20:35:49 +0000
Message-ID: <179296054949.3327.9121298737310016079@kernel.org>
In-Reply-To: <20261025203155.455075-1-mashikiselby@gmail.com>
References: <20261025203155.455075-1-mashikiselby@gmail.com>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
