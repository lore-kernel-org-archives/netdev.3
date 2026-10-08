Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EB03769F4;
	Thu,  8 Oct 2026 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478770; cv=none; b=XBOrgfY756K5fUTEI5bYMlVf8aHvzRsXXsCp9fo+/FawI52eO4rySBo58dkVX1xgd9OfN50lIW6vMTiOjVyyyeFgsEwor4Bm1ARMQ4lfQtQwYDgqVFgGfKFq3mGzLCSgcHHgwulBsxhqYmFwN9CoHIp8pMrU2vcKqt0W8qm+TXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478770; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S9EjurEBG2JkYZWGaXctxFbx0fUXz1ct0V+nmMckdS2u8bmQ2wi+Tui2jbTBODI/4WK4c5+yWrpIGSa3KfMqz0KIW0rb4kmiVdY1ekkHQfml4tEcq9ui7GB9OQOMfW8At/eB4P4v6Tzj290ncMenFYVOGJRgJNGzdCCQev4g4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czNx/g1a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czNx/g1a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE7A1F000FF;
	Thu,  8 Oct 2026 16:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791478769;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=czNx/g1a1gDSp+cfNeebeb/DgFh6TTsU1myEM6pagKzVUK2Xu2+fpaTrnPzE/T8Jw
	 EibsJBjFsDhmC7fo1ewkEbn4pDWJUcg2oGmt+o9QebtpGY3ebAsH1jyd9edBv8kpex
	 uJoOzI/Ma0cKaDw79RKSTqih9yN8M9BsJhHEwa3hyhUUXf0XqwW2cSsOoySi+0xb7G
	 RgE/Pp27prl0vg80hX11jTeHdP7D6DSwTkZ9csTz2k/hFUSZAqaN6ruVxibjXOUNLx
	 fUmUFxv4I5a4fD49tGLkzDAWUGP0S0QghJ8nkdAb+CY8lOT8gjOUZs6+ivgbkTBdmM
	 qSycB9t+Blrnw==
From: netdev-bot+sinfo@kernel.org
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Josua Mayer <josua@solid-run.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mvmdio: fix clk reference leak in orion_mdio_probe()
Date: Thu, 08 Oct 2026 16:59:28 +0000
Message-ID: <179147876825.2527009.4031641692421195903@kernel.org>
In-Reply-To: <20261008165328.2702289-1-vulab@iscas.ac.cn>
References: <20261008165328.2702289-1-vulab@iscas.ac.cn>
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
