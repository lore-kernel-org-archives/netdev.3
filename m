Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBD437F8D7;
	Mon, 12 Oct 2026 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815442; cv=none; b=UrmxWEjHCCS39C7qvdI6S7YDDG4kifmBND+7wHK4RMNFSwUNczCAP4LWrRszllGnYmEbEXQuOy8LNaqJE31+o95ODHHqEqmvIybXco+YekOTKMSRyyZ8qbBWRIY0+IygH74+RC58nfY0laYZT64M6DEd2B3+gb2GbrsSz7ymwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815442; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fF6puGEMd67p2KF1Cgfda/BeOylcdy07fJst6Ty4nsQ9gbfQJzzfRyVkucOrOXXwv7ii0w4FpP+M9gI+qCWkDxW5KoPI6J1W4noa8eHk5w1aNyFH9uLgxdyjrhTkQikCmyvOZSujN2qg/lenxpQx49povmdlLl5FWU9Xd1OpXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoKb7zEo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoKb7zEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFAD1F0089B;
	Mon, 12 Oct 2026 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815441;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HoKb7zEoHyGHsjUhiR5hFFwzxegSpgi1K93zOfhE/JdTyMwZqrwRN7jFmoyQNuYnY
	 Rp47VcI1DhswHuPm5edJ+Ko74/DYSJAUlmbQ2Aref0fiZVETuJGlsbKZR0QQcyEInp
	 rd8pLvV5vuSxu8ObqzAdcehhWnsGL1RZqZuBktOuWCaJlCxOX5KlReyi+Kh//VQ55g
	 wrjW70PmW66Z9+WFbFi3jsUl0enzlx9K5XLbXRWo17z/k41Z4fy1lN3y2CwkawoQvF
	 0KhGSvY6xIIz7lsYMXzA9ZYvPpuuHbrLDiw4/yd0mZDuONyljfeGOhTGiNjf699h8S
	 yh7hR7XwsWFJA==
From: netdev-bot+sinfo@kernel.org
To: Ding Hui <dinghui1111@163.com>
Cc: netdev-bot+sashiko@kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dinghui@lixiang.com, xiasanbo@lixiang.com, yangchen11@lixiang.com,
 liuxuanjun@lixiang.com
Subject: Re: [PATCH net v5] net: stmmac: fix error path cleanup in DMA
 descriptor ring allocation
Date: Mon, 12 Oct 2026 14:30:39 +0000
Message-ID: <179181543993.2527009.12387879434239599818@kernel.org>
In-Reply-To: <20261012142458.2845385-1-dinghui1111@163.com>
References: <20261012142458.2845385-1-dinghui1111@163.com>
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
