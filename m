Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6439B50AC05
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792063796; cv=none; b=YVYmBQC50INf0jJOoaYkf2/Qj5Mj1o5DedYA9+d2S6itTivAma0QIT61/1pxqjLVzbV5Vek4zYlz/rPA61iPE4sKwzHdA4NrcuUzr36nFoL7SKfZvQ0RbOXmywGu6dY6DRentAFU/hfH+PJa8c8stb8ORKJIixAKvK2VugoKmfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792063796; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cgIEJ1LIpZFiuyexla5R2qEqFTdRhaJ5ZUJQxOBn8aAwLJIOkbv8gU1h+URcJPpQmNyoHdGBehptH7XBw/xu5rQcw9zqNZR7PkpFmJLFy0ftn1to4gXm4BTaUZQaxMvumQxoQWFmLr+2jSchXdh8/5E/FpmdaJgA0S+3RYt6ets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2zudOXd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2zudOXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347681F000C5;
	Thu, 15 Oct 2026 11:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792063792;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i2zudOXd7Ihuir264YgXFWuXIplAgdpf6MkQb4pPaNMMkAne0C3RmNsBpm7bSIk3a
	 /EFiG0z3Xb1UOvHnFACYMz4pfm/ijiHKW6Ld89wmSybEpRCN8ulXn/XL21+mEI27Vi
	 SF3YBQknBlRD+GQGULXZYQp8ePw61SINnVtxBKg+qkOEsoDCnFJlqwa1CkWafEQX4H
	 25W1wsha/ZCy1OEeieqo11+r2DQ/jU65TQv/shOpxrFR2frSvbIDsafYXeExTE/roE
	 Af8NestTnZbNBlPM6J/V8OsWWavqE0LrelrDDcJR31UBJepPcBFo9kqOeKSNML/UNc
	 vozuj53w/bDVQ==
From: netdev-bot+sinfo@kernel.org
To: Xiaochuan Li <chuanx2070@163.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] net: stmmac: remove STMMAC_DOWN check to avoid irq storm
Date: Thu, 15 Oct 2026 11:29:51 +0000
Message-ID: <179206379174.408196.18162425580678440243@kernel.org>
In-Reply-To: <20261015112415.437900-1-chuanx2070@163.com>
References: <20261015112415.437900-1-chuanx2070@163.com>
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
