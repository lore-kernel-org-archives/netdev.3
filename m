Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793445186;
	b=4PDMTCYwvF4f1XxFMk+Y088IIS+H27Ys69dvJAeKvzkFaE4ZXU+cF/PMkoiNqOeGsABJ
	 dIBech5avFFqMzUTyEg8ojtJOKKiuzPIfEVUUz3PFnYSs3mUBql1Jlyas3USMvf76C1gy
	 YomecRwmU7UtXbgB5/wTQZKj5L05mhenVrxMF0MIehtkfGqNsDmco1982PAdiAta3wkmh
	 TDEzmrfBpCnV9WlVBOgshJTg7RosGkpQO6ZwzYd2bR2+AzEZIbWeXhYexJSawfvBotDVe
	 72/77L+xvJwrETCAlqYn3kbXtGr5GkAHhktfoekM5YBs+8AogHvCpE2cXjcv1p+Y3NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793445186;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=KToMP0y4lhRhCOVkzT1FKz7uCtUi0r4HH6yIPemF3ObwEig+d6p4D5bL+GSS3LOtgz+k
	 cytAHUA+0wPdlM/I8/eh7vSyMu5T+xUHBR68Q5S7i58nIpH1zMO+xDunPhgNmSnpdwUMr
	 n8uMzIfzzTQSfEgfapttZtNT2UB2LNMPe2WwEWRuFh+1+As5PzqOU3y61U7jCvcmbOFXf
	 t/lDIqCetfKN6n5TnaSInja5leKBa/jZg7qzdvttGfmObn9hYQxQ1Drm2dpRxUPvrM7LE
	 WmQZ8NUBvQ1DoYZfPvBIiHu5X/ggjzm9NJfUvGwot1f19D9VYgqgQyCx1UMZDmR7m3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmXeSyYS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A1606A31A;
	Sat, 31 Oct 2026 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmXeSyYS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DFF1F000C1;
	Sat, 31 Oct 2026 11:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793445185;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dmXeSyYSOejE1R9ZgB5IV54YEw1hmnlTK9Yth3psAVoH1QK42yV7dMrTnnq0wVg5M
	 1wFUEFTMy2mWLpq3voJ7iMHZwVbeDFeBH7EcBalHdvB2aWrBctFlRbxqc1XlpjVxRe
	 AO1DKWBJv5vl/mYT4CvoERsdD7iZ0dH8RKMGN3zh+yxXpy6Jn9lGX1lw/PzDTZHleC
	 OAKxzlvn8rRm34j0285s/GEwS7BltoTHwfO7jkHGhdmRrUZehvtDhlriRm6qI6mSv2
	 Qjjd7+x7nOY6nOE925gNil9aK7otuv07/iARGCWa91Lds1yeW/BU9BH1I9+iha4D69
	 0A9CGYfYCZf8A==
From: netdev-bot+sinfo@kernel.org
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@kernel.org, kuniyu@google.com,
 pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net 1/2] net: check the sendmsg LSM hook for every batched message
Date: Sat, 31 Oct 2026 11:13:04 +0000
Message-ID: <179344518436.3286.5985999522455402268@kernel.org>
In-Reply-To: =?utf-8?q?=3C0b1a91e7fa0de128c6e2bd3ae2f5c960a5c0f883=2E1793444?=
 =?utf-8?q?262=2Egit=2Ethnkslprpt=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3C0b1a91e7fa0de128c6e2bd3ae2f5c960a5c0f883=2E17934442?=
 =?utf-8?q?62=2Egit=2Ethnkslprpt=40gmail=2Ecom=3E?=
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
