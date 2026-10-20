Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792535601;
	b=UMHtlNCKZo9pma5L8L03xaBgESZgOz5pFbyNQE6Ro9n+thhxZHyEuJ6FZTtCrv7xOuV1
	 3JNeK4BsL7fg5iU5XcrJ2gcoWRMzkT1HvMaVk+rFZIevVqB90jqILGdV/Jk+3aDO5kO/j
	 b8UPZR6hxn76Ybwk1CkB4Ftc5b9tv6TAFHjPcJKfRYHxVsRqbivhlNa5cQuIKjtd/KYhu
	 SCm/FqOtHPbntvOyvPXkhnKUD/nM7lyZDWeXsAAJk3R2dfMgNPEPwhqjiPhzIRq7Krl8W
	 cvzzK96jEXh/JYC9wbYx/W7TCpQqzpJMQmh0xAxV6MfrbWjDZ9DikwugqZZcwsGrk3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535601;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=3+B3FAhPN0GbBf+BdXXXQpa+2LRXhy9G27BQ7WK00InIqpT3JWD0ZZcZ3rThsBvK2Bsr
	 U18pVA+HuTITYjZD5SMG2Tykmbnv5jVsdEcHDIT04H27xa5ouCx1wvsL8iMCw0y5Nqfn3
	 9eg43LLl3smgPmaXOqT9cm9AStEi4b1YueunPPNS0syVDz95wwDks8Vbcp8Yb91UIy5Cg
	 lH6w5o7hnM2l9S6CIi0D82Qz69pb2teVZpEoFM0nN+MDCUdX6v2jLpaQVxMg1dQE5J3ah
	 iDI4xc4PsnnMHu6qP234lPLPt7+/dttKZxmf6z5HMPlnQR42X3V4x3Qu2lm8+GKuRxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3WmsJgF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB501606A31D;
	Tue, 20 Oct 2026 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3WmsJgF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275951F000C9;
	Tue, 20 Oct 2026 22:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792535600;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H3WmsJgFoss+A/g4VsqULYwPiFrXuqe9aJlsuDDhuUAXODEIb6aIYACSzj4BF7qpU
	 EXwErS5k3qtGO3O020didqzPmDHp2rgmmoRsKMk4OjuysJQvNaegB1s2pvJeoP6PQG
	 BNahI0uzus8tJSSVL4iZX0BnAKeGCHEO+4ZxFlcfol5HtldI1XplhGLKH4aLynZA7O
	 IZfSprd5KZPPfC/ZhU3Ktxl6eyje6tFn2C/LRuZq/DnYDGXc4Hbx2UXFoPKgQH/x5j
	 Oe+RYBFU4y1pvwpQWb4HaSzeGC/u3XnJHkUXg4NFN9w1CIpIBMZKQ9dKmh49myR3MO
	 1WXUao+423CBg==
From: netdev-bot+sinfo@kernel.org
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: emac: guard PHY bitmap teardown
Date: Tue, 20 Oct 2026 22:33:19 +0000
Message-ID: <179253559962.3290.16612111135539202564@kernel.org>
In-Reply-To: <20261020222723.1746201-1-rosenp@gmail.com>
References: <20261020222723.1746201-1-rosenp@gmail.com>
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
