Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016B15172C2;
	Tue, 22 Sep 2026 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067013; cv=none; b=aLYb2E6p8WBWya9L/vDxXa6hNrQJcwyuLDouGjk0XQaA2IZKKrYF1asxbo6Z3M+0FffERMkDEM9A1rMm4RFCh0e/rm7R4D1RBUcP3LpBsH9zLuC/9J6oJlSA1BRwh2r90HXX7PRlt4rYzwo2YGwl/RrpVHjVljyi3IqSWC5L9Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067013; c=relaxed/simple;
	bh=ClbodkHrwN27abqBJADRyxKz+m8P1yTU7Ivb/J+3jW0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=E3B+2eTEUFlBn1EKSAM3VRrb7vH+PjjQDnydkaTvls3NLjsPRodXrtkBcszZ6F4wFO89ulBplv/2zq2AaOKsjF6zaCEofSSWAcTtGE0f6fsvOt0x8CXoWwT2Sv/eFWUgTNRrssF4N4r9gGcWxzi7I6oRPx+c1tz75g5M7h+L2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=AR6rMfnA; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="AR6rMfnA"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49259A48A8;
	Tue, 22 Sep 2026 10:50:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790067009; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AsQHul3JGvX/Sfy5DReNtDp11C6brH4rBkG6S7rC1qQ=;
	b=AR6rMfnAwioPtU1PCKJAGZQAmIau6i0Fc8YbcN8xcCSDWjx+rYjQkCEtJ1AAkbvC8No4/O
	T3PsMlrTJmjidb+B9nfYdUp8L+HHRu6Zr6KqqrDdiqHEhVerwf7lAlnTW7kESbqHh0qs2v
	uvS0kWmPYUXz8oiUy/TKLRVZ0uO+lVQ6JS5eVANuLpJNPiXrt/x2UwhqiMlfPLzGB0eM8g
	Z9bKRauolg63keaouR1zE+FcwZ/fwFO4ZAYJNVNm8S3uAVjas7QamacnItQ3rtk6a5l+ni
	OdelKJgOUuBRsuPLVjD53M2ZQDa83B/u1NWX5zTD9UeeE22smVwLtNfwxqeJeg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 10:50:08 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 04/12] net: systemport: Fix missing phy-handle parsing
 for non-fixed PHYs
In-Reply-To: <20260921231305.394773-5-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
 <20260921231305.394773-5-florian.fainelli@broadcom.com>
Message-ID: <b7f98fc21fb2187f431703519b5f1446@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Florian

On 22.9.2026 01:12, Florian Fainelli wrote:
> In bcm_sysport_probe(), priv->phy_dn is only initialized if the device
> tree node has a fixed-link configuration (of_phy_is_fixed_link). When
> connecting to a discrete MDIO-attached PHY referenced via 'phy-handle',
> priv->phy_dn remains NULL. This causes of_phy_connect() during
> bcm_sysport_open() to fail with -ENODEV since of_phy_find_device(NULL)
> returns NULL.
> 
> Fix this by parsing 'phy-handle' via of_parse_phandle() and falling 
> back
> to of_phy_is_fixed_link(). Ensure proper of_node_get() and 
> of_node_put()
> refcounting lifecycle on both error unwinding and module remove paths.
> 
> Fixes: 186534a3f832 ("net: systemport: use the new fixed PHY helpers")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

> [...]

Not sure this qualifies as a fix, the driver never parsed phy-handle. 
Maybe net-next material?

Regards
Nicolai
