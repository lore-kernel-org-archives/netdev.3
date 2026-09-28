Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9635B33A02B
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570719; cv=none; b=REpzIn+fnZBD7wHHat5Zt4//XQeUsupVWE4XFmksiKzqfMjbssvHMNuV2IVM1lf1QhnOInvRWsGjJzTQN8w1v9z+FQ9XyjM2c0j51GiKoNWFrA9ivPoTK+3llxIZoB0kpITC9Wt8kcRjkwcmbeygL2Muec1L8XTS4ryAwUC8MiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570719; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pTMEkFrqN0V5r0ssSUWimC4bAEh9DRbAYmjUEBDtX8DqDqjtL4vrKkXqtX9+EV9K1ouNsMcwsn/xF8l2aiSTriOjW0E615N6PU6igUMc5ZcZR2gM1bCZ0Us1E0wLdrqwi9i4fvw1Lmjp2b7halDArEbQFp5D06NwHHnzzQRt9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9yPxInl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9yPxInl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102941F000FF;
	Mon, 28 Sep 2026 04:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790570718;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y9yPxInlSNVPxUdFQJu3h+xVH5TqW3+20DCdxmuW42oMM5d5aToF5ujw3HB4aCB0E
	 /VPQR4JyxUclgSxSvyZio3EMk5E08iFhlKAnSlHrzn8g8yye4L8D9OvPRAAn00HOV6
	 PPQsW3DOJdSjT6D18KR2g2lrHSyYa+8s7ICutjUqc+GKIINILO1qN6bwUd2QgcDNyS
	 ETnKK/Rfqqj+BBprCTWWDV6os6aTwbC+IN3v2I6c7h9IMNqzzRvXERioLvebfNhh2E
	 F1fUrnJrQLAN18cOklfTrvJtEeTGqzFaCGYiZqB+mtmNHKJKpRmeDJOpqDo3bzfd6Y
	 Rw6zJ3hnZ6b/w==
From: netdev-bot+sinfo@kernel.org
To: Wang Zhan <wang.zhan@smartx.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, dev@openvswitch.org,
 Daniel Borkmann <daniel@iogearbox.net>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Alice Mikityanska <alice@isovalent.com>,
 David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH net-next v3 0/5] net: resegment oversized TCP GSO skbs
Date: Mon, 28 Sep 2026 04:45:16 +0000
Message-ID: <179057071651.31693.213200671694715782@kernel.org>
In-Reply-To: <20260928044102.1004310-1-wang.zhan@smartx.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com>
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
