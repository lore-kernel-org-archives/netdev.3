Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439214;
	b=jQO/wtB0W+tYpDED3Q0AOmxD61ZOVgYs+uhrkVd7TOgx5NvxnW7kOAKb/hL20PNfHqF2
	 3b9hKiXLTqqPI1pwEJrfnsfCtAgHTluX1IpBaShaWalvEIIu4D88J8tmvuxvhussorvzs
	 p/Gm8r1YYAuAl05BInV4E5gcdJ3fOzK9E/bmzA3vGwDH0iURka/CnbDiGZFFgXlY2mIvQ
	 EmKbLaZ1ZzX2GooWqpB7pmr+oRT2P8n4j61bHLoGApRN2Z6GAftY4JOrG1IpGSM7/9e6o
	 7WEkk7/eCKwV1pJd6Zb6oTsTSQ8oNkrQVgwJM9Rig1VpF/yI7GWV7tQw6QDTOOxtaTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439214;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yQjKNXoDon76Ssw1IpfiyfUtDBeNTptP/9FUZ13/vxE=;
	b=GhmtOgM7FUOlpkXSAWiCzRsvtC/bs3LMXjII+eTbVISaAxw9cG6v3EuHBZRwACUti95k
	 9r5RTrPFUO+hVykRV77+Hs7HA9fugT0jXFneLE1PWkhMF8C0mGywyZuE6Po2aNVyRhyap
	 2w/xGGzCYUn8mkybk/6BKsdwA3rQEmUb9wPTC/Olt7ERJ7eUwsBC3UmV3PvsZ4BPhTpnP
	 puaT4IcOXEHQT46vCkyhZnx6PM5qxAcYkdgb+nY84IyPcTSoTlDHCQXakPbJqqL6bwd1Q
	 +VzNoThfnRe3vOlHL8M+BiOidBLKAOFugqJyUxQGe9U+MSLunJpQU3+aHF1nrum8Xuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ev3vVVLS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B76606A31C;
	Wed, 11 Nov 2026 23:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ev3vVVLS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6EA1F00A05;
	Wed, 11 Nov 2026 23:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439213;
	bh=yQjKNXoDon76Ssw1IpfiyfUtDBeNTptP/9FUZ13/vxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ev3vVVLSrdc8640RaxbsrKw/kjFMH3DSEjlw5uuzEqmSILi6omR2iQaOV9VnvDdfG
	 ALFjB3KBzAT0SRd9XmKYbHcyIvk8UD82o01Icvjopm5tSpGTBJR6uvTi/MH3cZXITx
	 ZRg2b/rx3BJiGkxzoU14C5PU4LtDUeWzR4OszLncGgV/dL2GoPlXN1qFlmTAXIZEdr
	 lhlSTVpNRDVuvdDtZNCXJT6BvrUZsPNBeAwTXyXZg1f5OKD2xK4I+5IOy3sSnFp9M6
	 ZBfX75zlSHo1191lf8iZhkicL4PBkl5Qj4fzn3qBDdaXB+a2TnblFzT0s6sLh0o7Dt
	 CSltpnCkIJzHA==
Date: Wed, 11 Nov 2026 15:20:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: Zxyan Zhu <zxyan0222@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, richardcochran@gmail.com,
 muhammad.nazim.amirul.nazle.asmade@altera.com, rohan.g.thomas@altera.com,
 rmk+kernel@armlinux.org.uk, o.rempel@pengutronix.de,
 wojciech.drewek@intel.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 0/3] net: stmmac: dwxgmac2: timestamp
 interrupt support + Agilex5 fix
Message-ID: <20261111152012.3506cf35@kernel.org>
In-Reply-To: <179423231463.488859.16977464890948797360@kernel.org>
References: <20261109134506.2794160-1-zxyan0222@gmail.com>
	<179423231463.488859.16977464890948797360@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Nov 2026 13:51:54 +0000 netdev-bot+sinfo@kernel.org wrote:
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.

You are at v10 and still getting these automated emails.
What's going on?
