Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792354;
	b=rb9+s5hd5Op2bh4lAVLBH8buREpQXohYyO9XsTnYMHXwYMwbROdkxHatCSBUjsDURpCK
	 28XWdMkm76NAONJLo0TSQIjEQROew2mOC/Za56F8GjfVYpRCcjxvYJ0quATm/zvFqOVzK
	 OPMLWDixX37mLvmLTFPY3EXOmMhp5IA7s2Htk0wzXqtuEVNrBl5LPwzRfkt3Ec9ds3ivU
	 XSsubmtRR64c2kSIwvAEtf7PIucaoLNmHZ8IcWHGHGt9MvuvO2XVBY1DIXjlRADKSWw5p
	 vZAeJoYVvPfuYWGcO8vo/dJ95gUNgwG+BUsDJJIL19ELf+G+lfYLcg32aassWt5UVqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792354;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=b65pzJ5TnRWSzP7nj43qs8PY9qI0f+kdw1kbXZqXiCEdW3WRMGc6lEml8lW5AiQu8mHe
	 lBPYXC9m9JwggIT1XK0mVwnwYLpvq3+gpHFoQd6KuUozHD80XIRGSSZshO4gI1xg4ki2C
	 Het5stWkcdnkykje+6JjLmsUK5xbM3jFKp0cX6k+Vxd7EYGGISrpMUrzzTZsKAjDcEjP0
	 tdsWax/icEYy+0CSgRkA5jJFMEukpi2sGl7guaf825rfRXlG6Al/G/PMJ2xnGEEJwghpJ
	 Kkxzsa5EiZpLjLsuIB4eIcsg9e3npefK3vjmTDyNMCGNypg7gb4I82y3Pg/9qTKQUwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n12fr9o/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FEB606A32D
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n12fr9o/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319221F0093A;
	Wed,  4 Nov 2026 11:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793792353;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n12fr9o/eLfRH66x7aUMM99yMJ8o11YgLqvYJSltxvo/lttYGQ96bIuq/jHpl+Xkv
	 bQbYgYxFZrkBypIAf2FKY43tlNfZEKLPJ+HprQJcCe93Qlp0R6Lx6HjxomujtrOaxt
	 kcB4we/H+nupAzCZi63W3Z+e/pjbazZoLNcOXPgn/u8pK1L2Az+PVIRJIDsdUK62vx
	 63QiGcU4mu6GnLqHTJIH3U7qAPRlfLFHyTHZamcRe5jljsmLenBW4s3GBwaJJj8yvB
	 zy2ciSfwH3AYhu30fZn6VI4SiwcTpGwUpJtHT28pKus16SPAxyd2dyBkoF4/EDbF/l
	 C6utxzNsZUjTg==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Mahesh Bandewar <maheshb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Kyle Zeng <kylebot@openai.com>
Subject: Re: [PATCH net] ipvlan: make outbound skb headers writable
Date: Wed, 04 Nov 2026 11:39:12 +0000
Message-ID: <179379235268.488859.11510660996410063187@kernel.org>
In-Reply-To: <20261104113530.986664-1-edumazet@kernel.org>
References: <20261104113530.986664-1-edumazet@kernel.org>
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
