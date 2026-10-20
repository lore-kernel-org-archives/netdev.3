Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792535613;
	b=l5Rx1wdgW16yzFz+SI+htXjSHQ4tEDS9rjy93kqbJ2qTBVIzPt/TklzIOIpw0/lqtDae
	 luzFNJGwMNSE1vDSl9w3EUMr2iXRIz9LSiDasIwkkY8RlmkVFbOqPWi73GBI1BSaClhCr
	 YHRenfWeqLYKbT70C4oHDtx9GxMz0s21/TUSq6O61AoJcP5sVgkad8clxO+A5qKHyyDzO
	 o06wsSyJf8olOa4ezjei3epz0e9Y4oHmVzD3ahE5ZqJuxpLJYn0p8XKcPKr/ff/8NXZD5
	 AX+yM8yODX1ABKtx0eqROLxMiWncPrs21z/7SteAyHT16keTlx4rmXd9DmU51H7vz0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535613;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=n/mp81/FvkOfTmzvHexsRQDbu2jclfleftIWuH1I2ls/pWxOEEJIZYzBKSI3afLfmJaz
	 cE/geuuLOYyPGewjYmCw0GkbcPgrvz5MsuaixgydqZWtemTEKXfghDxX85C5Vazzoo8cB
	 /baNdATCV0ubYkYf2brJiwQiRWTVEW3NAmkxnzw4/b1vFruxBnhMNQMUmuSwnBVXoAcNz
	 bOEmuF52iztyVzenrIqOddwuK+lQkYwu5B1MME1iUdpbk0Nv7g6W4JMnBKE1CrNsxHlFh
	 GbtUKBZuIbhhkWxq6XGnrbRe4hch8cruX+1UDwI4M+U3KJOWWUcY5Yy9dN/e71wogaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lgB2mZqc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D45606A31B;
	Tue, 20 Oct 2026 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lgB2mZqc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E355C1F000C9;
	Tue, 20 Oct 2026 22:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792535612;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lgB2mZqcP7f/Qr3fPga17eFzB9yEblggwlMuBQ9agv9VvyQPUjBIN5XDeB6cYjtcX
	 Nm4Z8LCSa4+Q0v6UYtlCl8Smk6CYwDVGhiKkKkkEjKF8dqeoE9OEDXpdKjzGqO4yOl
	 HnbknyZzveMu25TRseal683mxgphwx5td8BhX3zkGOf8kQ0p6E1Ym3q2uPI/UZ1EdJ
	 o0T/QdKUOpBxGoQgpPAZ+zWINiOUCYGz884bck/CUyBY8TExs8pE+HyOhWEJXTd+o2
	 Ec//+MWtg+pFHsekG+dSiAlyQDCwgjRrmOwKjzwlQXe5ckeIimG2pzTtMS67NvfeZp
	 rcPE7KVaUEVOA==
From: netdev-bot+sinfo@kernel.org
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Christian Lamparter <chunkeey@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: emac: release DT PHY resources on teardown
Date: Tue, 20 Oct 2026 22:33:31 +0000
Message-ID: <179253561146.3290.7437858872851210199@kernel.org>
In-Reply-To: <20261020223002.1749284-1-rosenp@gmail.com>
References: <20261020223002.1749284-1-rosenp@gmail.com>
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
