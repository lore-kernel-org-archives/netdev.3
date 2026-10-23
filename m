Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740135;
	b=5s1g/Y72h3jU718GtmDznNFJuVTj8iI0u2dNKzParoo/skzL+tISmbWJTuaq4oPAajI8
	 R5DWEWIkAsl6Hz9uH7BI65AFMRirjydCj7MGD0hVOKHrkEwFm/jDNWLw5nmtMcuA2Ny1m
	 Yc95oHErhbBMoC3C3MOZDhlsD77+tUNUlBGn33c/wBpciV9C/rRgb5xEk5jJRXjZniyLo
	 OqrYSsiBou0HJ/x24pB2ANrmVP2QV5Pa1dFDd76F/t2qpumNTctVDN+pyo0Pt8amo2Ljz
	 nHqCN52UYvSVkSN3kwlDf8ImLwKmoVOhBvC1XeOOChd9RHn3vCfk7L9NwCJw++wXtxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740135;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=CM/njSeqFBLXvplOoRpykdmkEi5F3MCLAfBA/f0GYOMwhuICNUbABtHbv46AhQ+uyXaa
	 6mZZEuCYGRnPBYgBzt3W38hTYyT7YN1Iw6TP0I3VZ9hMZyiinupJF+Nh9d4+NVyox0Yri
	 lrj6YuJMqhvXfOdts+FjRCEEN521QbKoCPJc4wuiDHYPL5HICko8gNzLKtsrB+A5QlnjP
	 yn3dsubuJkPf0Mw2rnidqUwq3INgr3i2C2Ah8R/Q8UXV2OsIhIxl/kRQFGwQj45GGDw1R
	 vNLfTpLJ9inGevbih40soQFjxf1Sc4AfFeqT8xNvbncXll1diNb22r3sPoHnrLEIr1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9H6RRWa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E75606A31D;
	Fri, 23 Oct 2026 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9H6RRWa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9F51F01828;
	Fri, 23 Oct 2026 07:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792740135;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c9H6RRWawM7mpyJV6lfng6L6eINK3xNWSCVY4ECHpLMsu5r7Dts0/GaQs5yPOWj3E
	 03shcu2NJSNVSbJhpAuH+nsHhOiGTZ0QLRnexO4t9rkhte4kQBWJ9Ui+bHoIh1WfBW
	 QZxyUleFAZHrYFEuZ4T3XA6/luhTztbWB2YYrzomymLYSMUj3ki3C05rz/T2yDZmoJ
	 ALC6HZ0QWP71SWEKcjIKJ/cyJFzVFiqG+XDQoacbzHRO8S5NJnHhsRm+tyy6g60qoV
	 Ugt+bbWQoA4pMi5904TTIt35sBa+3SImaNhNVZ+ahZeLLM2LLYZmapcuhUWopaL4GY
	 f9Ik3dFLesATA==
From: netdev-bot+sinfo@kernel.org
To: kmahammadraf <kmahammadraf@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Sunil Goutham <sgoutham@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kiran Kumar K <kirankumark@marvell.com>
Subject: 
 Re: [PATCH net] octeontx2-af: fix inner LC ltype match for RSS flowkey
Date: Fri, 23 Oct 2026 07:22:13 +0000
Message-ID: <179274013393.3327.15225984916591567903@kernel.org>
In-Reply-To: <20261023071905.2922825-1-kmahammadraf@marvell.com>
References: <20261023071905.2922825-1-kmahammadraf@marvell.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
