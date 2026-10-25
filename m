Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792960544;
	b=kVBY+f/lktxzqXkwMTV3B8h+l4uchsz7e28gwxk0uEvxSsEK3diRpTfwH2yIMj2HaeIh
	 UTyTtkkmMWfUeN/ifexcCf85DA8x2YOjs670mgYA5eFJrCJdZgDOLh6OgItE3It4HAv8F
	 gov1H5AOyTXaXQLzPEqeOrarpGH5jtt8C5wXWOPmWjpU6PQ8Wt8WS+gIAlA82rTpulRF+
	 oQxTJJsCoCco/ZodA5ag1hsQfOB7m/Rv9WxXfFGqtYuRFeg3mFlYyp8q+qgSSqjY2Geaz
	 mLucIf8QMEAj4DBil0r2OjVjz3fuD5753TiONSe6Gll+onT3g5OEorx3WLi1YQEw2Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960544;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=0KyNqYBs7yPa4aFSSf8OKLf/I1mTPMqA6IpSN+8L3fs1bWNqEDvLYqn5AXOsCF5zPycc
	 SGdr8B8R8Go0X2dZFotepxAM7g0KEf3Gnjx9l3By7LYb/LXlltV4dUIJyPYntQQmy9hN1
	 QgEmzU2vGBzqcsyHeTWQ584TH9p0BkeFcLRodXWz1pgkmZuVbwsXu0pZD5AyL4rKlP0cY
	 5IoVIJqMrIs4VyzmBGb6VH/kWn3hl3q/UaCi7dmX05Zqw0zHBZHhhppzJEgJNDGDLGqov
	 wn9ze1Wra9z7ta9DqO7ZdWBMUePi+5ss5TquP9dHmcPXPFStN414ZkU+uZwwiHUmR+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1zoWgSn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8CE606A31A;
	Sun, 25 Oct 2026 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1zoWgSn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECE91F01825;
	Sun, 25 Oct 2026 20:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792960544;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C1zoWgSnSaaznUL024oOssl/u3Rc2pfkocTOdOIqwdKOQM1X0pxYCVHee2f7ZyBjy
	 6DQL7Vmken5Qi/dZUeja0doG5MmyyqSVcpNd6F6n6AANyWUzALN3mWnl5Pv+/zIBsp
	 HZzI9w2Ee796v5I9pNtME6GgPInE3Wx4OJ62mZCZRE30Owxz3i1HTkefQmOOmFn6uc
	 oYzwTWlWUFRVA5TlZbJqPN7kLweWjkAlRn2N/iCbHQtvZAZNWIk+BoY5/octB0qK5P
	 9a2uGAjAoNe1UsXCuTeiH19OaZtWgGJcSQVx9ACSpcHDYDVCoIjWkfPlL9fioT9eUO
	 FHcETsWVMCGbA==
From: netdev-bot+sinfo@kernel.org
To: Selby Mashiki <mashikiselby@gmail.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH] net: thunderx: fix fwnode_handle leak in bgx_init_of_phy()
Date: Sun, 25 Oct 2026 20:35:43 +0000
Message-ID: <179296054345.3327.8934502805880255428@kernel.org>
In-Reply-To: <20261025203159.455100-1-mashikiselby@gmail.com>
References: <20261025203159.455100-1-mashikiselby@gmail.com>
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
