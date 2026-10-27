Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106604;
	b=m96Nm8dHEiER0ms2xTokj4VruzQjw+TGsMcg9CpQ3MDHja6WwKoo3WnsdlEu1RrKK/E0
	 cMXDMgJRglZGK+pLs7ReyUzLOvvRFOvO/r6rw2BDRK0AIqaLUvP6pxPl0BcLBvLUh1owh
	 WuqwPSbJfnBcnnN7svaNFf638Mil0OaOTMdrRtdnIefgKh3qe6/uJycLmUu5V38bf+T5M
	 1/bqnX5k+QqeIklsaMCPRvXVMdtvdRIP3R6HiejX4pe+9gU2MlzOiYAC2CJsmKI6Or7qc
	 SBCikYVfJGXbKDBIZoMwCITJmLqx8i6ZoDPeIPB7rR1miwDNx/c9Z1bVWa9IjQzbiWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106604;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=1aoAQGB2kxSYAF40uR5sd0bB84u695BXMoyFxjxfJZEL5Sshh3r9zmyhvaXKVsdfzsEu
	 PtF2rM6rh3+J3X3JIKTeXDZFnpRGFNE0JWl7a/eVIfBsgTmT4BCG3y6Lt+GloA7IfwgX+
	 6t2m4+rpFGlsy3AzVr15Ve5qt0lDnTsyjxjivtHexZMa2hqTcefKS4D3gd9ddfuHUS3gs
	 03/jfXxLBYC+LkVYr6tzcNebB9cdeotiTHnC0LI1ryy2oXeMiI6JAcMR8bZlR1JCf29cP
	 VHrGrSJavZ0m51vCFJfxR7vIbvwDKgmr7YHDG0ZXZpa+zj14HPY04sDk1d2EV547iYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i0GwqxtX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2D606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i0GwqxtX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A670D1F01825;
	Tue, 27 Oct 2026 13:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106604;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i0GwqxtX19a+EEGgNLffqVCtwZKhcFi4svht2zb3UHGuiLAVFTXWG3kHA7+UdOoPr
	 ZB2RHA4zWTgp3h3Vjzcf74n/rTSgSdPHr6AjT348/y+xAy57iIS7ukTyB2dcOLBJiv
	 XeusEQY5oneXcp8Gd2idsh4yaDHNSZqASQ08cRqQJwk8gO/c2FA4/3TZ02eIltGDeB
	 AjVBGi5nZDfwJcZamXu5YwT5mAKDOrNJhp0H2zDNFPqTTUDTbJ6TBA9HjY+BwFADIg
	 K3tQkHDd8T5sVBJKKh5hUSJCJkvohWQwqLmUhBviMX9jgqp8F0FJp7TdK69oXczE3W
	 m0VehX0j9tSnw==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Chris Mason <mason@kernel.org>
Subject: Re: [PATCH net] tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND
Date: Tue, 27 Oct 2026 13:10:03 +0000
Message-ID: <179310660320.3327.15829552011183958691@kernel.org>
In-Reply-To: <20261027130617.1550253-1-edumazet@kernel.org>
References: <20261027130617.1550253-1-edumazet@kernel.org>
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
