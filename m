Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550693E5A27;
	Sat, 10 Oct 2026 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791616181; cv=none; b=TEdqtoDLcruxcyddxcTr4dNTRwh4qTCJJKgNw0Aa8sePIwpnZZPZzQIUAk0RXcrhnh1/6kq3zmKgt8bh4qhjPKGUmCUhLAZqcTyWthC0Jk6gy6IPJ0L6s3d2tTwkY0QCxFTJAn48YmT6IYtqfxMvx7d4iS+KMy7Xfspz+MR8duA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791616181; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rj391t3qz9GQZ/vm4uhpbtnRxzAGUP9KEcEKdrySVYPzb+KyVT+D8IlGiFW1HaYkm1bOsWIAIEN1ALivKg9TkO6O5o9zB41CvPLZQk37JKy3rYkya+MYt4ltV5LCh2+c7Z/3zzvV7g4H/vUsppCdfMZ+bjk4zpKoaNKrOvMvZ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qq+cTGBw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq+cTGBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E201F000FF;
	Sat, 10 Oct 2026 07:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791616180;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qq+cTGBwGzB7yl8zWq2y1dTbGtBy3zBMbZtQfp84M/oTCFnprL1OA5e+ozjxNJcCG
	 23kFhjOFE2Z26kNnOy78n4ASGfGOTe5viA5IKS1iTY0MLcPjJyLKExQ2FnJyqjEwmG
	 y8XmsDNguCJMVqsCvaBXu278Nin0kpzRLJl0CDr2vhUuS8Lc2fd6VO/F6L/oLUpQ6S
	 R1isfBrx43agP0mhdeFKoSuH/ek/f9CbtvV0yCYVg3HN46mw0YrNMQlirFOdmvzOBi
	 6H3Y34k0HtPgjr2msNXyQZ2pXx9McH18RuI6yscOz/Ws0Hgd9RvQxdUjVpGIj5kgBc
	 8ETucUG+/k1pA==
From: netdev-bot+sinfo@kernel.org
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org,
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@openwrt.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bgmac: clear TX slots when freeing the ring
Date: Sat, 10 Oct 2026 07:09:38 +0000
Message-ID: <179161617899.2527009.14522666109345593776@kernel.org>
In-Reply-To: <20261010070418.84457-1-rosenp@gmail.com>
References: <20261010070418.84457-1-rosenp@gmail.com>
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
