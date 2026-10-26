Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055916;
	b=Ve3pDYKitpN7TWAUC8CX5Mdq4/ra2OSqnhh5FIp0NRZ3iA+PI1FzV4aiP1LlXmbBEPE0
	 UW8EpjNHaxXGDy/Y456zpGmV+wRCXATx1j4mhAJm3gHcBzWPYnOw2rZ8Y2KHWGT7BdvWw
	 597P9xIt2QGJWO8ypI2T3K9BtBj0WAq8PZeLPCZijRe0U2gCJMokdcWLnQF5Hzly5b5ev
	 baTiKTyRVrZ2+BGobh+3q8SdvLbVAjaQjDHGeAkhWd3Td2D4JnScK18nAOJDZ2hq18H4y
	 jv4YySreE90/20DWud1ur2mcnooMFkNwWeKpjzsm+hJmJz9Cm/oiY/8t3rbKQRVZHLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055916;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=u+pcA88uqljIuM4J+8W32stD+B35hyJR5+c7Ut/D2VScHyj7d8qfRbiTVX/dqkIRpVDF
	 QckkfzLo/L6Uh2x9FmyI81EsNMW+6xBb8zEvqlN0dHki60urajDcSTyIfD/2HUB9DwdIl
	 J0kIQY0q4vf4L582sFzAon11mVPT1JOJsVRFbs+GA5OdqF0bVvuKegRvYD78QOfLYcuPj
	 kjVoPGtzWPI5GOk9nLo5lbAx1H27w8Q7wL+q9js7mB1V45p3rmk2gd7dd9RbQRB+MtS87
	 3yOokRnLl/WNdwTRZFYjU2lgonx9PiQNVBIGtlZrFkBXDVDtynUN/Q6XrB/KnCTMiDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgCp+P8y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486E606A31B;
	Mon, 26 Oct 2026 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgCp+P8y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26ADE1F01825;
	Mon, 26 Oct 2026 23:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793055915;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NgCp+P8yU7DZ/iuJx+Xl9oNUKf3stDCxcL2Axv+GMxovwBp44dFoddxt1qBH0iNER
	 Sdh0ZYQCQXSnduPmLEHWtbMX2E2QqgXV33SFtIxkP2CSFYl9EWdT5Ex6sKiOFsWz1U
	 mBea+HGRt+SDXYjL6eCRqGv0uZBzoHddNJh8p8uMk4fbb8L9eosrv5M/4y4YL3vcq4
	 SIByfPZ/jdx9Lm4mQ7nnSMkCWTHQBXtQEOZt/N7hjYHZn7G00NAhiwB8xb7QogLb6i
	 RnVGbh+kHB4VB1Y/9hOsTTpwEFeIUw1Y4T6du5DuyHmBLRPzIXeaedMCnI6Gxv7xkz
	 EidBavGRi7i4w==
From: netdev-bot+sinfo@kernel.org
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v3] net: dsa: motorcomm: Isolate all ports during chip setup
Date: Mon, 26 Oct 2026 23:05:14 +0000
Message-ID: <179305591469.3327.15926756079213213876@kernel.org>
In-Reply-To: <20261026230300.1108190-1-mmyangfl@gmail.com>
References: <20261026230300.1108190-1-mmyangfl@gmail.com>
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
