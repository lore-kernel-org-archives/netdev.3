Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888D044F561;
	Mon, 28 Sep 2026 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578770; cv=none; b=PK8pNGqvlgaMdfb1ZCsMTyfIVg4AcgYEyOg3IhlljKtJsHJkjyJwKPzwkmjY0gfYnNyJrhicFRlDgs1FFvZGoMYWT5/yexF/aU/NI+/72gyO7ui2WpFI4Lh+XqiaqExLC2WJd+Mt61MUfzGtLSsF0HNaMV+Icxc1Mwyb4ouvBww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578770; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mjRPiJfjITreLoyXEKyLbSZalWDNP0NU3738xpgl2qdYkD9ANjuRrk0jCGQvFpi63p2Rsoo8/c3IM57E+ZeRSGwmQxhcqgQNQqaEu/KRB/fTl5jXBbmqiYLO3WQfSDNKVAycAEFgEjF9ihUxiwnelMLNGEb5Gp57OgtJChAQT7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVyu9Fny; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVyu9Fny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4781F000FF;
	Mon, 28 Sep 2026 06:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790578765;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BVyu9FnyObfdesnb9kYS37FovHQtWB8sgWaSwkRBrvIXwQdfIaA4i7GZFXnSLFLb4
	 mck+gzWrEmrpj9p59Sw9Ms5CJe1OvMqBMz/RD5WfDX4SyAhx8wdohWj/JpIyiJf6F3
	 oWyEU3FjjCS7mEhzLe8fWJ35LkaGSIFiWh8F9+5GHMBEz3h1rZr4cFRlXw5k/Tuq+k
	 FSoBRStRK7gAA02AY8rwyiZypnZ8tIt3aDKFel2r9BvwwNb7J4gnEy7WvHumlvuxTM
	 4GlAXlaNE2Z5w3AncDVj7wvPREmepf50j05JmGr8BR4yCMJl0x4cpfPkF1mZP30OhW
	 Ip9oNxtguLaRw==
From: netdev-bot+sinfo@kernel.org
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v3] octeontx2-af: Fix BPID leak in nix_bp_enable()
Date: Mon, 28 Sep 2026 06:59:24 +0000
Message-ID: <179057876428.31693.4036993774330437044@kernel.org>
In-Reply-To: <20260928065718.3378580-1-nshettyj@marvell.com>
References: <20260928065718.3378580-1-nshettyj@marvell.com>
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
