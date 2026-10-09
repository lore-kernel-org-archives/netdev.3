Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105073C0A19;
	Fri,  9 Oct 2026 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577164; cv=none; b=cTHeUrLhyQv8v7ehQdnDAyUwQxClxTnrj9z6c779yeFnXRqvFamCfz11StRnox5QPVIee/ETa0hGjqROJHwqSKrFTW/2XBwTQHcfC9RULp7XJ0cmUxbSR2vEpBg+E+PVUwlrTCKehkbfx2P2txLBS5joX0IpBtOjcUoUk7FMSY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577164; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ia0FOmnaK4VK2qcl9lagHpzYy1FESeyTpko7pnbdZrgnhwy2ouszJjrFWYUEbQ4ZZzH2PjT+4Xs4FGikZFMP2w+JW7V4Y2L0g7+Ayas5VofFUgUbOI9FXSSwpU7pFVRGBNCsRkeFlr24r11nhGpyeAOFeGIp7CVtKj3nW4AIpsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRzeEKvg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRzeEKvg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DB81F000FF;
	Fri,  9 Oct 2026 20:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791577162;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GRzeEKvgPD1aC7UHt/7d6+mvin/iNMmBXyKwgVnD01DQcHJ8olIEo3gt9TOrx+o3L
	 IsC4luH5VfMkYOcPYfCqxF8B+nP8DVeBwCP3+Cp+36hcrYL0NZnOCdV3ysjt8st1fk
	 7JBiOVvprGjtmC1y7Lejus5PuAQSiKTNHzvjKI2si8MDtZTCMsbFMmVUV6QYDtJDRQ
	 BWx1Fv+7+atk9It1K9FeHyuv4exP6k1/eB6x9Gv5kNSPaH2iZAulu7LyZihS8gv/Kz
	 GwhA5w702ReeDo232A+KXMde47Lm3JOavZ/d/yXqe51+53e5InDOBxp6wt8IVTMvnJ
	 tgjEppHynDBuA==
From: netdev-bot+sinfo@kernel.org
To: Omar Ramadan <omar@blockcast.net>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2 0/3] amt: fix relay tunnel keying and
 unauthenticated-Request DoS
Date: Fri, 09 Oct 2026 20:19:21 +0000
Message-ID: <179157716137.2527009.182281197229207517@kernel.org>
In-Reply-To: <20261009201455.1904698-1-omar@blockcast.net>
References: <20261009201455.1904698-1-omar@blockcast.net>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
