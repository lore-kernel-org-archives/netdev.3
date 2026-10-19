Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31860346E5E;
	Mon, 19 Oct 2026 02:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375480; cv=none; b=VwsPSBT48sxH6nAytpjYlfyzZYMvcqbn9ZPwMn9P3BcQjQCRDw44XYeRgKl0GadERKwMTOEuMeZ2zxHKgzzQPzbhgeA6KSh+qUecLpm9+d/NHY2W/Bd24is9PYUDFU00EewdQ79QZTrYRvjdR83Q7Hu4M6fs/1volPZuPsOZL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375480; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UdoiVjgOUnR0wv3Yi9ma5kqVprQN64QUJTn5Y0t6L/xCidKczGqOvIjWuamVGwh8Q7X9hfZAzDeJsm+EoNeYMbis0CH95evrwoblWQFXVn/xwxDzPgRLc8zdczuFxuF7k8YVk0/SvFk2RDKAJbbBpOBRhBY3qOOoIzB7Ftpf60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6yhdFWv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6yhdFWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8771F000C4;
	Mon, 19 Oct 2026 02:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792375478;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B6yhdFWv3O7KTl7v5S9k+IdQ43tfvNbby11C3iBmbT7C9w63BOX5kOkrJ7ZOqXaqd
	 RY5spUdNAJ4gOx0RTHPbfNMyxwlk2cs3OCZD1r/EvCqKYEsSG7yu2V+9qcl+CPaihN
	 z6/2iO3co0VR4qA1P5PTfZtQZACnkl4nIYp1TU7IqtJFJI7ZelduGgZ7oSxDdn5et4
	 S+4G7gX+KbCQYE4BL8WxN+QzNJiuKXqlop+wLaAGU0y4KsaDEHkDlithadcW+q2OXE
	 3GMtPCutqlgmX8RSrdrKRgO4RiisP80KD5uC6z/meLHRy7dYHgQrjRX78oVwRCmTYv
	 7r5bFVHnFxEtg==
From: netdev-bot+sinfo@kernel.org
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Chris Snook <chris.snook@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: ag71xx: re-enable TX interrupts on RX OOM
Date: Mon, 19 Oct 2026 02:04:37 +0000
Message-ID: <179237547779.3290.3423337652551310148@kernel.org>
In-Reply-To: <20261019020147.213746-1-rosenp@gmail.com>
References: <20261019020147.213746-1-rosenp@gmail.com>
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
