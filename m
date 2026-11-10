Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310597;
	b=4QgfuukV+PCFyYDu3Tv7jyI5DSGFjGOadMVestLWyuDK6JnwBW9Q0lgROvMvy/REQA4U
	 7Q/fFazDUxM1O/UVBytQ8sei3ZBJbVmZbnXoQDBcMBL/YWBr+n0Cu4gmS6lTyBVidrHj0
	 M2lS1KvPCe2IbiNzjkbsGM1iPQml7LsV9X/mP7CV5irJLzFTMFXd2sa3xI4swpvdFE7Xf
	 tVDMipnmAdeMpjA96J5JM6JnmFxgzrZRVJCGGfDJrsZ9bWUnUfEjl4ISdKPkl7aEbmUhQ
	 DFq3Oi1Bixmc8TtvQ/hDm8E/1cElqwikEgs3L7eqH8vbJpd6f5mVSGlD/xceH5o+xbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310597;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=BFBEnLC14bvpPsgy9OWSYCyQKbLU+Gyk3BH6g2EK9Es60Tpi48WuCuai3mSZjV1TiMlU
	 wZaknsWN11C/AnXUOJJ1ScOWk6fcRPI6JfmWkJ/FRWjbr8TPGi3Bk9yeKDfFU0dbqcE5S
	 PEnNw7WeSaQYf55AlPaOpk2eCc4s30O/cF8vTmv/xB7ShZxj40Y08Ga+ot+nbFlULvG11
	 eFOJHDreZbkdRaoI8yHiGtxklFs6SG9QW9y+9r/s1N48YEW3KkGONA/K+6NDH2TEV9P5p
	 mXZbJVrKbhnzQ34vjgBtYUH0WlUaTISO9uZnXb87xr4M7gK3l1WAW09Yls7FihWRVWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bJ//RS/D";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59F4606A31C;
	Tue, 10 Nov 2026 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJ//RS/D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7ADD1F0089F;
	Tue, 10 Nov 2026 11:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310596;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bJ//RS/D2zUscZrOpd/lAqGqEZ6/Ya3Jaya6m1wN/Mzg08eYuJyHbCTG/PLHNr7k7
	 7KLJU7Y+NF80+Q3tx6fmHhZA9BkDxHEmutN/wPGdf+4gHJ1F0fx9GopZWQcLcGEc3K
	 kiy7CdLer2EZaxx3Dsz/1plzAtFVrgJjkc26SHmuT2S85U9LwcrpLh2owORNc6Fftl
	 Glxo8IByU736QUZ8+skrnzExUC260D6xZEq0Er3zHBkA3omAR2TDVozLFhVqNn2TgC
	 XbBak1+mG7ZXxWfLxJ8o9hIgkT7Vm54C/mo5NzhBPQ5fx5g5tMNaWJ1lmRrCuG6+NK
	 GN11tIXj9j2kQ==
From: netdev-bot+sinfo@kernel.org
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Alice Mikityanska <alice.kernel@fastmail.im>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] udp_tunnel: don't treat IPv4 sockets bound to an
 address as wildcard
Date: Tue, 10 Nov 2026 11:36:35 +0000
Message-ID: <179431059548.488859.9340944150774199097@kernel.org>
In-Reply-To: <20261110113306.3698438-1-antonio@mandelbit.com>
References: <20261110113306.3698438-1-antonio@mandelbit.com>
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
