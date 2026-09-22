Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DA442E40F;
	Tue, 22 Sep 2026 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067492; cv=none; b=iJ7TT8CKFg7kxHIbcR9cUVD6BL3WMHJYT3AX1Vc6yZBDcv7vQxTv4GC6eQewVAmxGOpZIwOXeKAAmK3oGI/8C/lft/o3LEQfDJobgok6m9SRAtz4ClQ1m0LvL9usYkFI/FNEkqhyv1jz/5hRgbkpw/A84HJ/7US4s7A2poHur1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067492; c=relaxed/simple;
	bh=HCghI6B5XR5O7Pinh+TlIQ2Bo8pT+2v2fO9A6qRKXcU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=uUQH8v21IzbPsJDf851TOakLbm8VyehiHzoE+3zj4w+vPlj+DuUt5xPshNUIGSry62r8k4icthK7occqsWlXtR8Q+eHvQ8jfu2cUmaj415z+Uw715EWfOZchYqgTkhvKBuZ11mxBSlfR8ZKyEDhv+L1xakMRjAdQw2G/C7MBzaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=iU3weUmZ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="iU3weUmZ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0B854A48A8;
	Tue, 22 Sep 2026 10:58:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790067488; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+j8pTvdfJB9RlncZLBRBInAE9D5Ej55N+i65IplmUPs=;
	b=iU3weUmZ8SgKXUhqncOgURlItnYMmwT0S9ae1NyOkbByO1qeT4/WRvNRLkoZ336zZerD5l
	pdpCo6XtffdZ+EA1tvO4X1cO8l9DrzhAb5seoB/AxKfx1txTsB7RxZC8u5aeyFsnDIMG5l
	BzyKslmU4oCRpwCFUur0w0Xbvk7SjXhTazYT6aAJd63cW2mO61EMR+wxO6klGp/LGDT8Tm
	WKD22HRzBcM8wVdJG+y1FMo46paRteZ7d81PzIm7nmi7VW+zrU/uHfi8uXQ6vCKkOF21eP
	qNjcsW7jyp7letAILTIW8LCNZVjx+6OBvdC7SZrK+tFyvNwO8xW/74R+FlIDBA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 10:58:06 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 07/12] net: systemport: Fix potential packet length
 underflow in bcm_sysport_desc_rx()
In-Reply-To: <20260921231305.394773-8-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
 <20260921231305.394773-8-florian.fainelli@broadcom.com>
Message-ID: <e82722225b62056031dac3648630c2c1@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Florian

On 22.9.2026 01:13, Florian Fainelli wrote:
> In bcm_sysport_desc_rx(), the packet length 'len' extracted from the 
> RSB
> is only validated against RX_BUF_LENGTH. If a malformed or corrupted
> frame is received with 'len' smaller than the prepended Receive Status
> Block (sizeof(*rsb)) plus 2 padding bytes (and optional FCS), calling
> skb_pull() will trigger a BUG() in __skb_pull() when pulling beyond
> skb->len. Furthermore, subtracting (sizeof(*rsb) + 2) from 'len' (u16)
> will underflow, resulting in corrupted packet stats and potential
> out-of-bounds operations.

AFAIU skb_pull() returns NULL for len > skb->len and never reaches
__skb_pull(), so it doesn't reach BUG()?

I agree on the underflow and the wrong rx_bytes issue though.

> [...]

Thanks
Nicolai
