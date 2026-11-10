Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293185;
	b=Khwj6PHIIC7NDldVgLDrnDI9VzUK6ecZVhitrQmcJSmTnLy6h9xC5PaEA1n6ZsL2koeS
	 zwWOC4LjoqY5KwsQEKw2E1d2CFrnz5O/3EUcvZcSvrwgb1MtAGxmNZuHZP0Fd+CbmFnL+
	 VDNfSev0uIbgrPWEdsOGWXf31kKye+pFCtJr+vBwx9EX0+0KTb5gPoLHz1RqYS2AFk843
	 x07uUR/LDL9SthniqnH0snyBr1sG/iT+RE2uX9uzNrt1e5TXkvxqf6K9en53nmqiX5RPc
	 J+tHI2+olcnxp3j0THCXKNzuDxS0IUa4XMP0UDftjR5auFE8e/dc3G9yih8TpBRH72w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293185;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=xL3/g/3QZeFA5YJpw4rG8pJmciojnep1KKTIeAlf5HWELT+4Zy+LDwpuKlySnQRM/9w7
	 /ywC7FrS7dIpNQWplNECmu0CLHnIBLyxDLNxYFqH6jkRECgSReYEgv+s4NayKiZXHeFV6
	 /jHTQDsVqHq4c0yMi2WHZ3d+i7Q7z5q24thgH3ypsaeQz95xjz5OMKzWA4SPLI6gpUZW9
	 LUHP7ptp7wxUTizfXHZw/+1RT9XURMuj9LmbRgw90BCmbtAlWYdnM4nSXahaO+j/681sp
	 a0W2rlLk2WNe1L+BnpWuCo3cfQHTbqFyY6LDhX1or8htaDsZeaSZGuvee1loFX9ytlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CrqQPXQG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2610606A332;
	Tue, 10 Nov 2026 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CrqQPXQG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FD21F0089F;
	Tue, 10 Nov 2026 06:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794293184;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CrqQPXQGnk9uKXeQ3D08WLx/5U/8RZFKCGNPdKi1VOVeeDSWbooDRBUw2vCTkYpxZ
	 RzJqKLDT0JcgUebIgOgcLTRmIOEBHiOTZCHxH1qsJPKFudh87JENWOAeTfcVP6cQQC
	 nScUBw8YyTHTd0Cla47ox33NoLy9Z25w+bX3g2xP8u+Bn6VU1B2jdwoad5v7OuNFAz
	 +qiaE7s04TlbbLTgsA+7dJ8mZCmqrXR7Mhu5okLtDKAcp7QTcfhYdIrD2Egul2F6uz
	 4SamrxXw29y3zC7znJBVjV41DJtXTaYgWI3cXKoKY7eTSKv55ebG6uH2a7Hbl9aP5o
	 y0/quJToWhkzA==
From: netdev-bot+sinfo@kernel.org
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
 rogerq@kernel.org, jan.kiszka@siemens.com, diogo.ivo@siemens.com,
 haokexin@gmail.com, horms@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 0/4] net: ti: icssg: Fix device_node handling in
 prueth_probe()
Date: Tue, 10 Nov 2026 06:46:23 +0000
Message-ID: <179429318364.488859.2256720144223130993@kernel.org>
In-Reply-To: <20261110064118.1138-1-laixiangwu@cmss.chinamobile.com>
References: <20261110064118.1138-1-laixiangwu@cmss.chinamobile.com>
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
