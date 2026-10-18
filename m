Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEAB421221;
	Sun, 18 Oct 2026 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311831; cv=none; b=jkJvEivjsScLHmtQroElC3pL/3l6SUX5JbWUaG153V23SY5X4WEcLquHAgnAQOHqJDLvJ/d5QBwE/accg29yWGmQJRHoCC2Ws8GOuPqtCbMxnwQGJh+N3gWW/SxXz+I3HdVWOrkqLSKiiLEtglChtz4ejvQj6CRBrpghZF5LHSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311831; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XjotasZ1PQLY8HDn017g0TT6mlWnvX/ioTCRjX6PWf0GAD5cVt9wt32tgGznNTeLwusVJwp5kDU/pztAo2xrtvhNaYh836CPBnjoHMFm8AH1bMcAyCGUcK++Z5oisY3rGenY2FEexeadLhYwusBpWB8wLEgJev5RFWNzQWHVaSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV1TUjtd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV1TUjtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93D01F000C4;
	Sun, 18 Oct 2026 08:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792311829;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GV1TUjtd0tJXEIqxwq36IA2C5rdhT/ZkCv4vn9fdNViEBTfo/EfXEY+nwxcqgJIaF
	 ymiIcn2m6wwS6Uokvspj1rtsQKRtm8DJ2t0a2VJBep9IIhdVMpVkBvL0gikN3M0xL5
	 L3l6UhvMToDMQuVr6+TW348s9WWH13wImW1cKVTLdwmxRnr8hkUEcNlZU/y3bpUsoY
	 DTGqB3gT7GizlW2c6xUSahODHK+pcBtD7A+YL+DM61EG6kBstCnjujBd2KqOW+N5SR
	 zeDK+g0X+80E59GGJRxMDJAEt7/tCitkXiVxGn0gRC7QXBGDlfWdtMGRYX36HnD7lj
	 cnpfhb43Q0Wfg==
From: netdev-bot+sinfo@kernel.org
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Corey Leavitt <corey@leavitt.info>,
 Kyle Swenson <kyle.swenson@est.tech>, Simon Horman <horms@kernel.org>,
 netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] net: pse-pd: core fixes ahead of the
 controller notifier
Date: Sun, 18 Oct 2026 08:23:48 +0000
Message-ID: <179231182849.3290.12579854151312214118@kernel.org>
In-Reply-To: <20261018081853.47484-1-github@szelinsky.de>
References: <20261018081853.47484-1-github@szelinsky.de>
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
