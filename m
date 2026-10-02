Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC47844E64F;
	Fri,  2 Oct 2026 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929781; cv=none; b=tu524lSmEg/8sfm9uctrWjEhHNPxUtikpvdYCetWaQuL1VagrdAnz3SSa/YcgmxHqrX6ZQTGyJLAb9B3YyB1XsYTZdNcP4xXdvQAlwj0MVR2BjjeX9G4fu3ep1/PXNL3HBR5PIsCtB6gZptch/p99TS3uPVSQS4Etr16113TCa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929781; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Too6D4wtdcVfOGIYoaMo/LbGNFEjJazCoUjkM5vi+8NlBIPm9ojXikx06YwiR5z9O3T8zsUuSnIo518RUURXhD3Jy9+aDhFWYknB/xcUv/aFW8dQY1yrYgSzip5t09hftcOA0qHjTP9dwZxOXvxSlAVsnbmOSgys3kSupFJQWKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRBTKcs7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRBTKcs7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AF91F000FF;
	Fri,  2 Oct 2026 08:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790929780;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PRBTKcs7wEd0fHqPVtL1iIgsXSar6iAicwL0HqzvVqDXNi9vyZHEsm8HuTkwi4MZj
	 KUkHt+dN5KwVz72xi5hHchresa3tF0vNJLOPGveABkv3jxKrf2uV+gggheOPTl2v7A
	 HG1pvt8EOXEBQd72CoavcdlwrGlhvjbTwUEKMPtyZeNoHgtQDj1PoTnOtb9R1dBcSe
	 WGzJ9fN6MZy288kDISSzUcVKxWNRDgTGASgYk9soSlP4l9u7B1xskktd2PiMAQLmBt
	 nRaokZpExDKTBWpVs+VX+5wcJKLsu+AaRtmr2BUHohcmcYjHddJds8riDVwciwnd0U
	 i3wgBxEhRHX0w==
From: netdev-bot+sinfo@kernel.org
To: Star Chang <starchang@google.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, wangroger@google.com
Subject: Re: [PATCH net] net: Fix Hole-196 vulnerability by dropping unicast
 ARP/IP in L2 BMC
Date: Fri, 02 Oct 2026 08:29:39 +0000
Message-ID: <179092977931.1402591.17651630199573652586@kernel.org>
In-Reply-To: <20261002082336.608201-1-starchang@google.com>
References: <20261002082336.608201-1-starchang@google.com>
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
