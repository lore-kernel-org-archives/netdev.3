Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794133340;
	b=JkJ+IoP7ThxvfDNfgRG83n+Y8LlW22DwoGWhqtcfdtVx6SyCMLFmMRTjM/+tb5XGSaSL
	 q3TMWEZ1IHtrFmCb1Wbq7XS6CGWHXDgxSGX4036eXaQ0HgKX4jePew2uBcc5LjfR2oP6b
	 jDovz19TCmadKPBMF5KMwfwHCMTRcVhItjl6z/VAbiDTLGwuDZh9fhBct6gjcUubI8B9x
	 p5+/AJM1S38DnrcdtJf9lgvrfZDbwzGMgQCBJrIxm4E/WmjDFU2uBUUF8PoBtnV4xBoTl
	 502KSX86CF1zlaxIqRpDavsZwYIRcR7aZZTKH4TjhxIRMoLAbWjFyDaWrCN++9E8v1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794133340;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=UxN8dE4K3RB/LCEldLSncka+ubVnAYsUmYcM4CLQAoSu1+Ye96kIJm4vFDou43A8OZ8C
	 Zt+KaQKXM4HGAEeQEZEBh1YEdq+zsT95llnqfgLUVaJInj0IlfuXW/Osjcl8d+oyVLIfW
	 Hoa/Y8qjJjSSMQ00Sf84Z/R+/SptbXY9coB3rh4oKsIfvILqEqrnd/bKq2ADmfWPHmuAz
	 8ZpU/0PjGHSd2PKiiIIUFv/VfO/AHU5m57Dp+h7pJeWk24gWu6yjLoZ2CupiKiz4KhgQ7
	 y2TNk/YOlrs9U945416Q3BeKeaE2tYYcscF1yi04+YwOi1TwH2cyIj62HFYvVkwsjsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtAg1mWJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F52606A31C;
	Sun,  8 Nov 2026 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtAg1mWJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D921F0089F;
	Sun,  8 Nov 2026 10:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794133339;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WtAg1mWJvwzhUD6anVkA5PY1D8NXqfPdbiY8LF4ufC3F32aG+2lwU2T+0fvZ5/lsA
	 0wJS/FaNoRKSvn/Z+A4Gbay+Qz+tpqYywbv6kQQ8PYJkr3ApnTYVro9bo7sQpvbk/a
	 gNO7qFQGr9NH+TZS8QwHbjqNJjyLvUSD4qZQeg6EAFQ/FtnVJrVXh2iopyrjD+slrW
	 dB9R+11/Q8lgeThr8toDlOp6pZqlqorQDhbUju7lCkli5IES42J4Cg1awXQx5pzx9H
	 FGAmqeaNqd6KhLJODsibUO0E07eh+Ujwk+FITNqehDjTd94mY2Cd1i0bmtsclqN/rZ
	 qGLSYRl8AfZyQ==
From: netdev-bot+sinfo@kernel.org
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net-next] net: dsa: motorcomm: Free the MIB block on port teardown
Date: Sun, 08 Nov 2026 10:22:18 +0000
Message-ID: <179413333835.488859.2320463860948262077@kernel.org>
In-Reply-To: <20261108101648.1308271-1-mmyangfl@gmail.com>
References: <20261108101648.1308271-1-mmyangfl@gmail.com>
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
