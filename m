Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC3A47C110;
	Thu,  1 Oct 2026 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879696; cv=none; b=oKJozCjgrYYuqdWNfUWTChuvJ/JKDqzW9uBZe5mlDVFdPbYFpwzvwTi30zXY3qs8q24bYegO6/+BsJeZHBrA73IkkCtuYvGkImf1vplpNr2senEdZVYqwcfgHa2OOMkcp6gLuCyVvOU9JZAPNF1ddklqfK7VQJCFIGcU87Hzo5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879696; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LHFSu4aqk6Cl0B6LeyQ5SHDHab3N7zabfIEfxDZPECRH3ixStFlM2XaLvtqQdsKD6I7Y945D/J1JGT+auWqt5re40mGdla1lrKj/vrZZ6T8lIE2Q+6DL544tJSzWqPN/3SgviyyAfhDFb4E+Ah51Cz2x/H39k63UbYlf4YBADxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsS8MI5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsS8MI5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623E11F000FF;
	Thu,  1 Oct 2026 18:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790879695;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IsS8MI5Mog6rk7bBE18k10Tip1Q2UELKC1W2Us7l+soXXGf2iGBy4meqnv/xmkkbc
	 PwhkzZc4tXCdLPy0AUyavTQ6ZFPYXEPR+lXlSztkbpZwyqmE4RuHIyvviP1t9K1YUx
	 R8lw91O2UNtdlmiz0U+AMW2sc/mr6pSSJVqOvHBTdXKOfveu1QrIr8vn0vure7GXZO
	 cMS7fbSA2FSn0Qpso4Uc21SBzWs9799MLT1ixkdI84XPS4UaMhJHcK1jedxIwMk9/o
	 eYmmv8SKxmfHjUAzGKzXPytYD3KT8BJ9RiOZLBvzwTBMDtYsPU+22BixUJu4y/FBUD
	 c8CvBbdodgGzw==
From: netdev-bot+sinfo@kernel.org
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Jon Maloy <jmaloy@redhat.com>,
 Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] tipc: fix publication lifetime races
Date: Thu, 01 Oct 2026 18:34:53 +0000
Message-ID: <179087969393.1402591.2584174490574228427@kernel.org>
In-Reply-To: <20261001182924.3928331-1-nicoyip.dev@gmail.com>
References: <20260927180806.1315902-1-nicoyip.dev@gmail.com>
 <20261001182924.3928331-1-nicoyip.dev@gmail.com>
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
