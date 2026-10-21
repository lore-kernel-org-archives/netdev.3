Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792545265;
	b=wAJAUAQI82tsf/3+tMn1HFAt7soeaFer1F3OV/U40d2BU/HryK04loZXialvTPUln8jQ
	 XW5Sz4XBN+S26FszjnzkXtm6mIzVAfdcUd1cj1gtG6yydewKaFMbPnPaz+eO3azIZTLyQ
	 +da0MRH1HHAPpUErO4ra8IgM3OATcXph5SulxsFs/n+V+Xqt9z32dQzJuMKS/vQfzN9Lt
	 /hRqm+Pj+AyhT9G+fJDA8gq6Uxeu92dGoyembFG0cUD6EioQqobXz9fy8MhPmpV1hMJtS
	 j4HhF3C5Mv3JvpsrwMIyZfRCl763BQg7ZieZKiUUYyTch10/k5Cwjj82PDHwFLWm2Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792545265;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YiujvNx3Csh2JtNlwupywHzIt7d25f8Y6BC9JYT+HNA=;
	b=eGy+nTA7XsC1WB/O9pUZll/VUNmBrzuX3NLNHpFJuCg/WH/W/ooLMPUeiZxGhRDt7s11
	 0E32htKq1UI6xp3jWLI3PPmoLKqtIY0Ntr4U3iqjoj0OJXkkfPtpiSRpM/dzk00H+A+bZ
	 sXNojJkGfk+XoTm0YaLCN8w29wx/ZjgC1Nk0gqP2rCP5sPgcK8p2BIOMWRYtTr55DC8H8
	 +c54/V5XyFjumvLLe58xz74O9iY2DO/x9RsyCs2U/uWALt8Q4bFxDwRqdrDxIhIP/xoDa
	 wOTkSsGHXSLM6Jz3Z7jMOdou9WiwKm4uWoR8DxvHe0Of9bRd6KCs33h16aeV05nfr4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P2yl1S3N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F12606A319;
	Wed, 21 Oct 2026 01:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P2yl1S3N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617731F000C9;
	Wed, 21 Oct 2026 01:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792545264;
	bh=YiujvNx3Csh2JtNlwupywHzIt7d25f8Y6BC9JYT+HNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P2yl1S3NwGJbzmIgYe/0Ljf3UVZGLrFTOJaRcQdgh43cR9vERTJLSZfTQqhI/lGmj
	 VxE0Nu5QKSeZRH8RY0Yy2UxcPmxLbLOxPq1zF5zBD8dthau0pQNfpxsq5P/NdJDa8e
	 lQnpUeFIAEbGTUH49d37TMr163XYjByaOBfPqEy0VYJa4/v9St3sOUL+mgIqhUTnMs
	 jQBs/4nzq5sWMniHodrz7GtKExXS1cIGme9U8i268cLTUeWYeaFVvSOtkywUk4Qhk+
	 4dzBZycf+Dzl2qKhf7409dhELDZc2/Szy7qi7q+xZHWvhVB+zz4T4i/vB/7LUwYQeg
	 h+2tmVjocCSCQ==
Date: Tue, 20 Oct 2026 18:14:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org, =?UTF-8?B?UmFm?=
 =?UTF-8?B?YcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Broadcom internal kernel
 review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Felix
 Fietkau <nbd@openwrt.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: bgmac: fix TX DMA unmapping and slot
 cleanup
Message-ID: <20261020181423.68783c1b@kernel.org>
In-Reply-To: <179254219525.3290.1761340258214254709@kernel.org>
References: <20261021001744.2042320-1-rosenp@gmail.com>
	<179254219525.3290.1761340258214254709@kernel.org>
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

On Wed, 21 Oct 2026 00:23:15 +0000 netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

This is getting tedious, the bot has emailed you 10 times asking for
this info. One more fix without this info and you're getting a ban.
