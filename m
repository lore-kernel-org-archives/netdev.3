Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797996;
	b=P1qheiXsc3gT0/3/s4mznM6n1Y42Kxs1iw/g7kPvDX1JV2a9YjhpO5IyUQ0HfU8Wq0CZ
	 h1bEn3J2Dw7J78704a7/GlwjxyqJpLc2YpZWxBZ5VUqPzJpFR/82dwKPgEG1fjEHHeDAZ
	 dLpRRb6uMUKNvvcFeLRUMHtpirGQPaXdTgI/Y4iFuTMQkfqZWOwTEEpI9udulbJEe6AZg
	 0G1ZzQ/Qfi3aF3OrPI4G+yN9Z5WDxmMlB+zpryR8TjA4jaivIwfqnqwm++NSMj+f0UNyf
	 EZZNGUbm3dFpiC+dNnxX3syy4UME1C9vpaKeV+xTyR8vmgQkmwKYyWQIQf+X5lv5hPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797996;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=Vwk9IbKulPCMnlnFcO8m0xeXVPa1pPu5XFfWxlyWEOu9Kvr9+m/YXztPU0Pi0E0CpdMj
	 +LGDd7IQiBvhTHtujLL/cxwYIFKPVR3OvjcEvB3R2nBf3CH57mflveEw+bN+LrmuLFZrP
	 5YmIIBtahkBZ1MMDM4MR1qpPezSTMLXpZZRty+McNiSJrx/y4I5fyyOOWTv/CmY2NQBSP
	 mvjcvz1XKzkDnd8lSpeLtBu/nkSDrmrjBZlgJyqja5bQ8KDmSPA2+drNof6/TRZHKoD9o
	 9o0tg1nczWTnYDqTAON2QQzDrrPiNbgQ9b4HpSWU5MUFdy4VByzxzkxxuoqyI24QaRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUcZ28OV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109AB606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUcZ28OV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031821F000C1;
	Wed,  4 Nov 2026 13:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797995;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZUcZ28OVxXAcJSySLd/npLl6PBajpuQWmxR5Eg6Nc/rFYs39zpnZyq3ruxl6U8juq
	 SK1BTp4Bg3m1yLzXqwbxJF4keXeLIxxrR0E6jGlDh4JTDoeXUENCla434wowcsYhvv
	 Ho4TNErTrqZY0zYYE3SpXuuaW94nWVC93tumVFpaJSUt8P62PvZPx8fCLlvvNaC8YR
	 EIYWZoLm7Hfv+8JaDrVxiIXPHjsd9u1owSinlHv12XSa++q3l3dEuC24mjKcwcA6Fe
	 KP9lVsRyxp1UvpA+cVjMGq3mSY/jGVj6EVgjehn3NhaHFYdvPegBeWSpAPruPhsT9v
	 v6VMVNips7FDg==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Subject: 
 Re: [PATCH net] mptcp: reject DATA_ACKs against a reversed send interval
Date: Wed, 04 Nov 2026 13:13:14 +0000
Message-ID: <179379799448.488859.12019585019924727317@kernel.org>
In-Reply-To: <20261104130747.1045741-1-edumazet@kernel.org>
References: <20261104130747.1045741-1-edumazet@kernel.org>
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
