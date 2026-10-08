Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D873838D402;
	Thu,  8 Oct 2026 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476640; cv=none; b=rnCsy33AdzDEsJ4JwJajn4G2i8+n1gkdZ+jgGN+3LuCirQ72fFB/SnRoU1Mfq3NSGB56NC+xjtKEJISNVzuDW7QPU81KnKVunnKXyC5HeUjFhWJWg1R58GA8b2kt8pgKRGPCHhljxsHNeaEAz0+NrHDsaCBCnqN0n9ZZ2NRjyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476640; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IMR9tlJ9feze5vaoU6lE3pUaSr7bb2eZKe5ZhAs1teo1b8Sc0Ic2hDp+rZLhUrHjEEwdIOLyCaFFouMoqv3PK9ovGUcSAGVPJN2RQ51vfU5HN5QJS6qj8HcirEW2FU0QF5dWBFqDvPn//czMKwtUwWPqNMMm09imh+s/dMTWusg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT/Ya97w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT/Ya97w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCF01F000FF;
	Thu,  8 Oct 2026 16:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791476639;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XT/Ya97wt/ULznEJCAlPkwAU9bOesozVXQr2zbEMh7I4uyUMwJvvGsWV7XzTFjbAL
	 atYl9dTTBZJZqX9CVr25PAHDri7vS7VhFLW95VE/9u6VWnddWwnGXG3u1Dx0H1DGHJ
	 cCtqOW4/XmhyCeHiYKMjxkHxky3GWs8Ta8s9yipIIVSDrsocTweue/jOxrDLh5vybs
	 Gfthxlcij7Jn+nWDn1Lsf1gHSp0qkGNXvdUVx5rrVOcs4TaTp/0rfBjNGE5WGLNm5R
	 Jn9L5KEjlxsBBnIuYSe6RJZdRlaR+O25tUAif3yqRaaa63ppNa6kgjcYS7eSFp2nLP
	 Havn2KKqCRmSg==
From: netdev-bot+sinfo@kernel.org
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH] net: winbond-840: release IRQ on alloc_ringdesc() error path
Date: Thu, 08 Oct 2026 16:23:58 +0000
Message-ID: <179147663850.2527009.3579752858238787977@kernel.org>
In-Reply-To: <20261008162109.2678143-1-vulab@iscas.ac.cn>
References: <20261008162109.2678143-1-vulab@iscas.ac.cn>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
