Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203897;
	b=eVv+5yAO9JEOarNkV6hp6a/bAw7WNTHRcE5e0k0GIydif0c5bUtoQj9dJML5Rwr5L51i
	 MqPBBbtGR4MCsFchtnr6ATwd5cS1YXwIUr8O1p/WN2Sr6rKVnGTC7CyCwKiUM1MI+Riyk
	 d2S/ie876KdrXdFs0uidjdmhDosQWvdkHHGZ0Pu9gEnxByg1h7ESPcJTC/o+zBseXbFiU
	 SDsWsJ/pV8S0pay3xkYDhivfyOUA0FtVyDAPJWLa7u0P9K5zPKDk+AfjDTeNmcohRVP4U
	 ZP7Qnbp+1Lmp8rU+5Cfu29xsSoFvS+/W1YyeOL4ATCvIGeh18y4sIcQCxihNOK8zVbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203897;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=l7JM6kjEbmJMGR/DijPPNFztqWlH/SKeZbpLRpj6UamerRkSNJDUP+r95vH5mp7+SNMU
	 RDpfLBdDvbJObZGfMh/srKIApjLLL1XQ5IvQBVHEtITYaKKDxR/oAfY9o5p+esamqRTh+
	 JkKeZQGDCDv/IvlWwPKEK03tEuflGa1uFcYDyqwxz+0sTaCI67O4hPmOTeOymFQm3eFHE
	 ga5bqDFOICCGzYDGAvPWYAkv0lVICq/0SUICUFPgRa/I09ilmY0an4ZA/7P9ztNN8dLvK
	 haasPemE570pttWehypFbxzb6Xwp7OXAU1TLXJVNAhKht2zeGMALlTFBJUnC+jhTDTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BV/K2dx9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18184606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BV/K2dx9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB5B1F01300;
	Wed, 28 Oct 2026 16:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793203896;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BV/K2dx9Q8ujw2RoRkX6z8Ba7ckQ4vbewOGfzKH1oeYTR7IgcJOQ0YQTwmMmJc3tp
	 evXskE4++0Yw34VluvIZDOu2oJ3FWBtrOs6C+2wgDrNKG4o87UprrsHdhg6RsTERUl
	 k+te+DgqB/5l+yQYvm2EvDtmnOxyb5Jg7KJT8woQ2xiZs3nFsUcOkMBVIORAMLqUmW
	 tgJUvBrtOE9QWKEDAXgaR/xGliNalEYo1/jpsWaR0Txc75WTdlu5Ke2tCWUnccyn02
	 xIeGfnVky63WKviYYINps07lVe+5s1kq686jfw+63XH/VCgrWT+uVv+DSxcbmu4ejW
	 2LHXLRiCMSU+A==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Neal Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Subject: Re: [PATCH net] tcp: avoid double destroy in tcp_abort() of an
 unaccepted child
Date: Wed, 28 Oct 2026 16:11:35 +0000
Message-ID: <179320389561.3327.248054156447524630@kernel.org>
In-Reply-To: <20261028160847.2170959-1-edumazet@kernel.org>
References: <20261028160847.2170959-1-edumazet@kernel.org>
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
