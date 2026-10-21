Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792543721;
	b=ncoB4aL/TkE0axuOJMxTLnsIvg6oSOPGDcnLskY/PxnPWPDmjfq0abY9ozRFYZ+X/pTp
	 vA85Yw8HcX/IBwGD35e4KDFxoWHp/1hIpgGj1rDfIg8nw3v+EhNR8RuStI8SpXtRiMNxn
	 NgvVlM4cC1ULKGuZmE4QjCUgp4nF4zidOmhKlrqEQY21Tko0AfzXZQL8Enb3Cw+iCVxqV
	 A6G2SJm+wSfSm8zMXhDg867rogTeiGgS0dxqcizTf41zJI3Lk9jQouD+jB2aTJPLvJN2k
	 IzTF7YFmK8ah52Dktm9XFQzYA2iZiaFlsC+A9nqYO4vN7Mzb+QdRtX8bkGYUufuCD0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543721;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ryzqLtmTIYfeNRsCKA09cpqX71cPmMQWJEIQIlGWlaU=;
	b=nm5SGBnVrZQhf5ml9Uw+0EedebT0U430aYztzFYPzJcj8MazYXCCJHyO3TyDItvPtgmu
	 W29BDwJhFVdP9s85Kir+rmOCdtB/Ke5n/1P4L6ScXsVg6BYCVd34TzNB71bDtvu3EK2Pt
	 zoAAEyxBh3oUCPkWVCZUoWTD5XrMU06GilLJNrBGzy/cVZgeh2xdm3bQMcly5H++7ptnd
	 CgPSycHhTEPad8m2NBcBk+qvPMfua75ifGHrSIiIF4rPqRuDlcWJF2xWu4MseVkoJIghQ
	 FRje1wvJbSzYSSBampNulV+LVJDPEDck3z9xRy5znDNGos1u13HYswRNKZUDqO0wGAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWU80DNt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B394A606A319;
	Wed, 21 Oct 2026 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWU80DNt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2F11F000C9;
	Wed, 21 Oct 2026 00:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792543720;
	bh=ryzqLtmTIYfeNRsCKA09cpqX71cPmMQWJEIQIlGWlaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IWU80DNtUYS51kXrh/PJmIGJKVypUwxeIhOXFLFPJJt43DiHpSVFF7mXIP7nChQBc
	 mPFyl6C9lpG7e7VG3TX9h7tjwf2lVxry+hIB+2+AfGNvNa0SC4T9XmLUCSoAnHFmku
	 b9HD/q6uR9Fp18wdeYyUovrX+VEbdsUGxLmqRJbVuescIFzHHFiPcnp11Vp3khsdJq
	 3t3JjSJvUwK0pa1xoFktwkQGZbzTLUf0Y+fkP8/ausf15tMvI2UrA6O2LueqQOFnUM
	 rocDvVnM9HBJo8gUvziIweJODGmIK/vpRLLHTK2RTn3gG/t7uTW0WTTkMpm3M5Q84r
	 LGBcHTHmat7Eg==
Date: Tue, 20 Oct 2026 17:48:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Wu Di <wudi234@huawei.com>, Teng Peisen <tengpeisen@huawei.com>,
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana
 Ciornei <ioana.ciornei@nxp.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Mohsin Bashir <mohsin.bashr@gmail.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>
Subject: Re: [PATCH net-next v15 1/2] hinic3: Add ethtool statistic ops
 part1
Message-ID: <20261020174839.1589a2af@kernel.org>
In-Reply-To: <2b4a6fad842e0a2ea6c5ab7555916f970b78b599.1792053295.git.gongfan1@huawei.com>
References: <cover.1792053295.git.gongfan1@huawei.com>
	<2b4a6fad842e0a2ea6c5ab7555916f970b78b599.1792053295.git.gongfan1@huawei.com>
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

On Thu, 15 Oct 2026 17:55:43 +0800 Fan Gong wrote:
> +	HINIC3_RXQ_STAT(alloc_skb_err),
> +	HINIC3_RXQ_STAT(alloc_rx_buf_err),

Why bother separating these two? Rx packet was lost due to memory
pressure, doesn't matter which part failed to alloc.
