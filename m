Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920635;
	b=XCV1hO03zo87F4cg541xk2L39MbUdGkUlm/ahSCkzJ8VaZQ1htXzqLELkECiNo5raI0t
	 7Avy1AOPHnFO4kF8UvIu+lK0iZeVcplqvJIHUgV2GwpBCUmxIsqp0ZWZhgP0TvgbWMP93
	 cmrk/A9bP6qHx2kheyfB7HokIgiO5T2ole436wIsIlII8vwVx00WV3BPXI42ie47BB7Bd
	 OQ3yjWvanTlZgPqVjIT2lWicYV9MTXO0H2b6EMvAZNNwbhvLCM+/nSz3Vzq8jGStiu28s
	 a8LXgpBB6Zo2CRVZR3e3KSdoBFSOOBfBWmCH1FteLMHHH6we5Z1ShkDigwhZhbvwotA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920635;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=155gUMciIZj6rWmFFNs2/HmMoZ9VxbsKdqqynQvRUmzObRbvO6a9CgJ4FDHQdirzxxnD
	 d5udUHXtZY6t3R1z6ggDbt6/0j/qmuZqKDEwII/aCsQ1VpP9KVfjWYcxQb9Mle7+kl5y3
	 Kv5lrDx0YJJjAQR7tod6r8QjE+OOUs4lzFtOtZCQRfEAZe+7A3z3q0vLOiwXPEbAXhOre
	 hOa85IqyV3G2Og18LDYxjqeo7y/CFGJ9LwOH5WVQNZsi7cfA8OS0+EvdZNff9bZMtp7Ag
	 RHx/f+dsGX7cAtGPVzOh59cuIvRZHOuYSKluTZh+XgGrV+Za8PNf9uKp1GSzTi4nMRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKebRKlL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9139A606A31B;
	Thu,  5 Nov 2026 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKebRKlL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907CB1F008A2;
	Thu,  5 Nov 2026 23:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793920635;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AKebRKlLE57bRls3o6MyQYWTCLNlmGUA8lGIdcJ0nJZ0wNcoAKem4AVVDGpUVMzTq
	 bd9z0aaOO6gxWfhVXl6JmEU0t5+DeJi0cFYcVBqItpG8LoKttPzeO57+EY43BTe1fX
	 VawK2GMQhDD6doGTYQZ68dy5/0tow7aHdj3jzRCZfAYkHEUkLRyEnOQUJRGjHYSOd5
	 cS78vY0JdUIY1mDBGvd+wDVDWhhchxpGCGs8PluOcRq/Ph+USWawtBgrc1C3Badi2t
	 WiUEWQQFAGA6JhjnGQxoLVR3+x4HhZi4ho5WfQeUTneSekNg53g/YkccfEBR/HF6Vy
	 yOhL/OZbGpt7w==
From: netdev-bot+sinfo@kernel.org
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jeff Garzik <jeff@garzik.org>, David Gibson <david@gibson.dropbear.id.au>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ibm: emac: fix MR0 write in emac_rx_enable()
Date: Thu, 05 Nov 2026 23:17:14 +0000
Message-ID: <179392063410.488859.17228254276936065586@kernel.org>
In-Reply-To: <20261105231417.119930-1-rosenp@gmail.com>
References: <20261105231417.119930-1-rosenp@gmail.com>
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
