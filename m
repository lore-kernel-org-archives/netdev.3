Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67F63C062D;
	Sun, 27 Sep 2026 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790538014; cv=none; b=IHvdFxxV6vo4P64n9iFbqnkNo5TweGsFCP/EquP8Mdwfz2CT/4n75OVAZsfxe6a6vNv+pP0ATpY93ie53vRzUsQ4ddHP4mxxqTmPKLyf5SyJS48isOAokg8+TC6rsyrEEm5/ybkyum7aAr2c43mBmY0gla6PXqm8aAnyw8aIm5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790538014; c=relaxed/simple;
	bh=6u4UUv+MklcHf5+ADsFeYrTenxfLFfP4+g2kZ8VE/5I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=j7PO+l4m2DcPt+IBbUvORhS2/ukHblLOoa9I5HB49SSK/67hpIp9O3xynZMbm5usyCm7+MGeYfV/iPTaPmqPJF60ZgKnJ3mA0SD0L4Ugs9XW9FOR3VSoaHpQ8Oc+ttY9472zNm8bQAqHqGmXtcKg3LiFW7aOcccERHv1avwIsfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=uKYFxnoC; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="uKYFxnoC"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95E7FA4AAD;
	Sun, 27 Sep 2026 21:39:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790538000; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cc/xf2j4BHAulFylN5TkganxCXEiVqrHjFTZk/NxY14=;
	b=uKYFxnoCNAWJhBdOX2yuQEHTFhN3A1D5eBRWKm/JHg91uI1USLRCnBE1x1mmYXosyANiV+
	hMo6Fj3ODxlAl9TpicXKyzTJzBSSBZzKqWX62mlF3qQ9lnEebmrQIuzitt/lwzx0JzofIP
	mm56DDiFGpRbzd1TFbWzBHHl6Xl4GBVHUMrY0sVQ4SVsBGx3+GI7a/er8uWoMoVCE+MjAI
	nneQhN7kW4K44fQH+RB2eHpLIFagYlmnEAw1H2FF3Tq45NV1Z7JCTMw5L8HnD5cPCbme+x
	Q0HSEDh3wu2dksyNWcgq2RZfOlvKXwn3cTnsciTQuicZMOuhPYnyqLiY1MjGJw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 27 Sep 2026 21:39:57 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: systemport: Fix missing phy-handle
 parsing for non-fixed PHYs
In-Reply-To: <20260922222525.3992167-2-florian.fainelli@broadcom.com>
References: <20260922222525.3992167-1-florian.fainelli@broadcom.com>
 <20260922222525.3992167-2-florian.fainelli@broadcom.com>
Message-ID: <36c5d3c209826028f2b12f738a8ee3a5@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Florian

On 23.9.2026 00:25, Florian Fainelli wrote:
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
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Change-Id: I714a31091e833c87fc766445b90cea53090fcec9

nit: remove gerrit trailer

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
