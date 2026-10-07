Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA5647FAF4;
	Wed,  7 Oct 2026 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791398691; cv=none; b=LIoUrqP5wG32y/mSqI106UBb3yyW46VLOLuSCEuzqTNY/oHutyjXwjLx+8lXtcILzkgeGOLHeE3n5X4ur+Huew7hb+GSNiT5M2Ozl3IBg1MuwzExmN83Nwox58bXKwv6t1hj9dzcx9go8kVIvWJSfwJRRDYXwI36nekSptBy69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791398691; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LAwSuBB81mEHoYP+3v7FQBV5bSUmY6Mzc7Vv7QseaAlHceQMWQapv/flLC60CD0p/UKW3u16f4GbqD/0v/oS/U6EDkO46mYticAX+sivP+4dvBLc+sfbHBvh9Tqm5ac4H+FPuco6vRvNjWqiP2132PfXRD8IwCh66OZB9T1wBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2x7xVng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2x7xVng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7953C1F000FF;
	Wed,  7 Oct 2026 18:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791398689;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B2x7xVngkHZ9mRHi1/tOd8dD/jqMvUmyOKcw1XatWXFhN8i6G8ObUHtv6XmJAA09+
	 xd6PdRNdWbEyDP2TtRg1ll7dixl4kSDEIuC26ajcc9vcsK3ARh4FGrn4Shy1LSJ4Ym
	 SUPSLpG1EbMv4CCJsPuxIy8tXa20C4kenWVKIIWeoQAcCJdr0q4VXb1vENOvnL87QH
	 iI5DYaDyI4YCVXWQnXdrVNduqydygOMkiwoFI8gmiEixigiqq4OEs0RWIPyhGYv1zm
	 4dt6vXQKdgRnLXVhPhy9xWx7+oS0Hq+fPDZn5m55hzStRxzq/JCZ91485flhco3XoI
	 itA6gHzK8m6DQ==
From: netdev-bot+sinfo@kernel.org
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: emac: mal: replace devm_request_irq with
 request_irq to fix probe error race
Date: Wed, 07 Oct 2026 18:44:48 +0000
Message-ID: <179139868898.2527009.7529803204490860855@kernel.org>
In-Reply-To: <20261007183821.928263-1-rosenp@gmail.com>
References: <20261007183821.928263-1-rosenp@gmail.com>
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
