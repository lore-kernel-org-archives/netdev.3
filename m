Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511714;
	b=PX87+XecUnoqMfpCPmu/uNs7er37USbgysCHcoa2Ij/C6kYJGExqq0IU6jm0nzczdpSj
	 K1MFCZWBgpjBHHr4w6s97LO5F8NoLv8EZu53Gu4hFUkAFxz/wXkS1KVUQakL4ibTy5scN
	 JkNJWR6EmZh8xr7Ng33dGuy+zoV7Hj/kFZ5kR6FSmuD9c0zRQbfEBV+nwhM7SUYVWA8Zq
	 Jy1FAEjc9wGOajcGhx8EeKBlccRWYaTcydL0ierdskzgguag3iywRn7leetxUWBQHqhR7
	 8IMFCteS6QcKiUcoBIkaz6lkOflNCudyx+tHQ24iQyvHby0ocqozDrKDIIZMvpY/fng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511714;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	b=YlfG4OEOQmm8AUyad/o/s/FTgTaDpLqGP05PVWfUpw3Au/V+AjUvdGG6wYHQV6rc9y3V
	 mqnigXJOKI0uuiCBQvi2waJyLP/pZhwtYhq9ouLQEse/iu2KuF6bD0d4G7jJwHr6/LzIo
	 sNBkW5IQH9lLvzY0uQpv9dIexloEAe2QIPqPOTfE3dltZIMJ2fDgFNLeL3GwdjQptHRWQ
	 dE7JclKXo1CWdrzPIdTQlk8vtYWpN1gtGl3o1dqrDYhW1F3FpnhGCCu2+ds+GuN0J5Mnz
	 uVDWQdyxzjZ3DHXDct8TzPpFbFKimbP3HIBQM3uKtcEihZpaxKruz1IrVDGvZp7LKLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WPHaTUFA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA71D606A327
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WPHaTUFA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1D71F000C5;
	Thu, 12 Nov 2026 19:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794511714;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WPHaTUFAfm5Go5JNHegCwOSwxO86YrgJPTiI31nYL8KS8vZe1R1mX1WwW1uhnDNRK
	 RQ8pJ6aU6MLwclSv5rbv2/Pm1OIZ+muGgpJJ7OUcfnBvdD3xnMV57yYxZw3hEb8LIa
	 qK84EafLZurSiLk2yzBAdn21VSo6LpbDUkVbdDPNpR3Rlq3XLjH6desxy2q1RSIPzS
	 KGGd33g0KvmvGLjXz1V6I0N87zE+sBBe1PRYUY29q6HnrJEjy0KS6njSMvE8cxjQPA
	 ToeMkKuNNbgTzMwrMitjC/5IQx8qRB56hKLYi9gauOEwJAyFYcGVBWDlTpe46sCEiF
	 ebv+9sTdAslMg==
From: netdev-bot+sinfo@kernel.org
To: Artemii Mashanov <ralerrdirsardx@gmail.com>
Cc: netdev@vger.kernel.org, kmehltretter@gmail.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk
Subject: Re: [RFC net-next] net: phy: realtek: track clock state across
 suspend and resume
Date: Thu, 12 Nov 2026 19:28:33 +0000
Message-ID: <179451171375.2168702.17531890187326124496@kernel.org>
In-Reply-To: <20261112192408.24771-1-ralerrdirsardx@gmail.com>
References: <20261112192408.24771-1-ralerrdirsardx@gmail.com>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
