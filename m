Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645FF38E5F9;
	Fri,  9 Oct 2026 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551676; cv=none; b=J4ISineLjHFAPtFRwkTDVGQKrE5qgotoQYS2aFnobfVP6/URseg7hEb4zehed3yOuR9JwJwyNqyPySj9cDoGALgcHiJWoDDEL5kssnPoef+u9OtU+nboTfOYsy10gCAIS3Hgl0FDcfXHZKWHL0MCDTT7Jgt+WFgkrZt+JItPhw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551676; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jYX0YDOLLIi28XYMa2G+mkLhJMIZ3IUpLQyghQu00FP8ishF23/+gWSv5Kve2ilKIujCYl9B/e9eGMuA4W7EV16gTEdqCYMTVzEKJBbNSPOvWsSOZL50dtVSDC07rNtxiDA9/krIMQ68mrsM19iMWM51qD8NbLOfS0SmH/f8NjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HprGoPwX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HprGoPwX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B091F000FF;
	Fri,  9 Oct 2026 13:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791551675;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HprGoPwXbQyDB6BVKty580P9hzRmdKcPnkAm1pRENMrO4Ftdhal5KlKCm82pcmE60
	 TsxC3SYyI+ftQ4qGfUkn+Dp2zE7c3/Orz0AH3VRDTBdEuZueNJNjw2s069mfazaecg
	 MKFuQFvXnlTAZKXjDhVBZKQzqN/1V/6x8pPBVQpGkzBFH12fD3iWnXieS9a9WPh/te
	 AR+3/ML4i/QJS7Q2c5aqW4DwutQJnYuX3oEwYcUwZoyFW6T2cjtogUxXGosveNjGUe
	 x5rvg83o3XEclWwc2rapgR875ypzHO3SI/pavu9s3dGTwG1XOQDEuzj/9J6i1qmUBX
	 cWA4ocMsVW/4A==
From: netdev-bot+sinfo@kernel.org
To: Binbin Deng <18983559317@163.com>
Cc: sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v1] ncsi: Fix use-after-free in the VLAN id list removal
Date: Fri, 09 Oct 2026 13:14:34 +0000
Message-ID: <179155167432.2527009.16735710200995731738@kernel.org>
In-Reply-To: <20261009131146.38586-1-18983559317@163.com>
References: <20261009131146.38586-1-18983559317@163.com>
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
