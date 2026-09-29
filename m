Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60F4E3ED2
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718569; cv=none; b=W9RQyA2YjEcrvPOe/uryMRh4r/A0P06ubb7kg3tj7JTLgaD8d6w9WV16qIq540qoQ6UUZ9PFA2fZrrDAlg+QR0bKw/fVy1UaTBYWDp7vYMQtvBB/1RwuOQ1YxNY7sEkvoE6azAli0IkIOoHmB2IDXZeqA0QuMyKTp9QVP09aIiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718569; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XV85BGF4oD0NSAtRiuakK5Lk+6UC+DtPQYVyFgCR+zRD42DlPqoiNgD8DoSGOX2PokxtVSW4tYFGAD9ASqcVsOWJFfCm5aQeWxJlI9QAt3pC35I8aG2xBAyOeCUseVlps6Z5wV8A8jPZMV66e2YkK96sKktf0Y9hSMmIUs1Ttls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AE5gE/hk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AE5gE/hk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9841F000FF;
	Tue, 29 Sep 2026 21:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790718561;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AE5gE/hkxX+UGFPSe5nrodNHHZ0qErPD81wr6EdDBNXTwJSSmCfqFoag0MBQ2kNxs
	 OVWYb38P1BkXrvkHxVR5dwKKuVZfhi1qf3eLgl7DI1XI/73GhiIY67lDgCEHX+gQ7Z
	 Xwu3OowqaFlLJk4rrb9pMZx8TfWGHBLVLOhKF7rd4rdHoJ7iurXRNwfbEPwQWLd3ls
	 6gi068TBLN5OLfak90fKPq3wDDYdQ+GNlHldwMaa/zg7FPjrnFP43tlabgre7MG4Yh
	 wDWzSmP/4YRKD862oqfD+bGopsQDnCAVN7tLYF6JpINb4quc7CvBs0JqK3TkT5O75r
	 JoEBNbU20BfvA==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 edumazet@google.com, netdev@vger.kernel.org,
 Xinyang Ge <xinyang@anthropic.com>
Subject: Re: [PATCH net] ipv4: free inet_opt after an RCU grace period
Date: Tue, 29 Sep 2026 21:49:20 +0000
Message-ID: <179071856014.31693.12785796665106437529@kernel.org>
In-Reply-To: <20260929214351.856940-1-edumazet@kernel.org>
References: <20260929214351.856940-1-edumazet@kernel.org>
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
