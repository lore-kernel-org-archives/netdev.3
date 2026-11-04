Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798597;
	b=z7y2/93/XRcM1R7VwNNq+UndemZLRCOI7qWvUfhaui7bJ6MfvMgWzK/KGA55NYBfc0rd
	 Blwh2dQiDp/QfaYlJTz5opPyi/tnupzWAGmwm2QH5eCF7iY9wlML5cbPzoHpfZetJF0Qe
	 JST/zqcIvBS9kEUDP5Ncu63YC8l/4eQiw8kwEWbK1lgBfkI4aTZRXYT4DpvbgQfZwVEsU
	 Iw1gVO/sIovX1FPlUzd9jQso5fHAXQuInnaf+ftwLAiXQK2O464MVvTj8TARD4F1bU3y+
	 ugyPhsxE5lON8j3EL3qo9iX9Sw971vljMt1shyBqtyagaJkGDzSn+pgJ4npS6xdR1pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798597;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=oE+oIXEC/291yNh+PTD09Uzmn29CRV0ynZlFV76YpumrjBiRxr0WXp7EsPGmQb0xLgri
	 JEEnkMteHuANmcLe8vl2l0308JLnDNBLcKZN8AhtmnNBIhsFqZwjmml6gacUrsXk3rZ5W
	 Slhs5q5OzWq2fDZHotEJe0JkmyMETUZnRlpVUFU6BT7IPBzJHAk1N3nzb3gGsw51y46G/
	 EGhnfwbIXEVcV6VRaiQgiSU+/LfpwlgqXveQSdRhD2srX62yHMEI2wfvYxyajYE3E1gME
	 K6EJiazSb7iyEYBot8cnbrcqnKF3maLksB7+OcJP3GXo1aYyi3TJ6NyvlLxmT8cf/oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQ+TgFim;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD5606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQ+TgFim
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9841F000C1;
	Wed,  4 Nov 2026 13:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793798597;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hQ+TgFimCKh5tUYEvPtmV5qbI8cwwBiKsdriXQ5NaeK4xy5vyYlXAxGaH/AYa5XZT
	 fsaafgjSd9XbB9cFemdI5kO9cy1tvm+JmjNK2ZeMzHj77fSjAFWOMWzmFZ34Lq5HsD
	 LX3S+2kQgUU3kQJyVudUXzOMi7PkN9Y252MJbDa4A6+E+rjMi5a1vhuZh8aLijDffi
	 4gq38/o/JNmvk2Dr2fX2edGfwZoSMlL9uv8KuNktaAMOQFkIqOMug6LOScytQrmK81
	 jhD1q9TYHosMv+ZFCSJF4NeVyJRkg/HekO+msACjdxfpdXjdJUF18O1jAJmma8Lmn4
	 +hf/SRjePWpLA==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Subject: Re: [PATCH net] net: protect negative destination advice with RCU
Date: Wed, 04 Nov 2026 13:23:16 +0000
Message-ID: <179379859620.488859.8976747958626151541@kernel.org>
In-Reply-To: <20261104131744.1056562-1-edumazet@kernel.org>
References: <20261104131744.1056562-1-edumazet@kernel.org>
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
