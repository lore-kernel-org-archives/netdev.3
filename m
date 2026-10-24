Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792820495;
	b=2ox9R4B1aLIjjELhEQqLYV6ucdRfBDEXwjHmgklX1fE7Ol4o67SgA9zYaxARVHprS2v0
	 tfW2SS1swwfIdXlWzYU9YthtkX5IqQlMQeSu0Q5+j8qd1sBLqYbhsa0kH2g2stbG+nOnm
	 hu+KZA8ssw3fQPMct9MLOW8XwZPv2ab1N0atBwjZHwUFwZqCe7M53WZw2UnGHgLyMi2MS
	 QCVGvvxuAhA/D64vI5BivET/wOkyTk1rI/ZGQdyernmKPogCw5IIM9jZWE70imDPxwlRZ
	 P3iowylQTUgGvjy66ktxuJqzTHy4e6/gcKxihllPTM1WnLa4QemJlE+xrlEpsaRNwOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820495;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=Tijt/4xjzFZTKLjA3IxB24TrzJKml5fURIkUSqPbzsDMOIut4Yp1HFTW6OHNmpelNGl1
	 ud3VYAt4EQx+c7D8TwIsc5i9KOu4Re7CBgaJla+FlzeuPfm3ySS1LR5S7wd3aT/YPWSlH
	 oB+M0sPt6IkTkV+jOhXcKY5nbStBO3v7pwwnQh/mjmh6RDdWNO6ObxgZD7ecuTvzhUnzP
	 ZboMMmZSe1ANmSON+WAyPDjsOCB2O09ZKIl+sbtCvx2IGaUYlgv1gm2sdKgkJBoFSSwBN
	 aZBYn00QIQQZ1ahk60emfh/1KG1PVie+Wx+ZdITfUqcZw7e7RDQFgAuqpgZ+4PAz1Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFz6Jhk1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF3F606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 05:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFz6Jhk1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F661F01825;
	Sat, 24 Oct 2026 05:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792820494;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VFz6Jhk1aomAeHLzC/BbsfTJILPqMBnmaF5ED44BFxplV1OjZQZOxQedyXaY3/zWJ
	 eoLPCdLu/Jm82tGONdfrRUfIYet7RBlKH2HopYBBZ8ri/50fcUa9ddmpmMfcePemiz
	 Dnl3byrf3dwyj9iIVKd6Q6sxrqc9k/Z+r9SVM0lGEjgHDJz2EsC8g4appW90bBRjeL
	 FPWcXT46ZfnksEbFqK1W/+TGNGcqbwouVY1j2kxyx+ZTgKH1gmE/otCrJnUJCgaPPh
	 +wunl9zrfSp2LlZYYiUk7VrBIXDQ+0PfmhlyX03ZbZCPvKZts0w/j8Gwe+nL2ULDO4
	 yEfvyaNsTIiTw==
From: netdev-bot+sinfo@kernel.org
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
 sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net v3 0/2] inet: fix established lookup races
Date: Sat, 24 Oct 2026 05:41:33 +0000
Message-ID: <179282049337.3327.7552828562203929158@kernel.org>
In-Reply-To: <20261024053720.1147022-1-imv4bel@gmail.com>
References: <20261024053720.1147022-1-imv4bel@gmail.com>
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
