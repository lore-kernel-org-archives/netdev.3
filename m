Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379744DE72F
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646452; cv=none; b=X5yGX6AOEl8zC/hLMP5EoC2TcXjNWDfem+pPcpnTPrScLZrUzV/3Am0ennREZre+kpdve6aVNugeJMZXzDH/sYum4n15FWv/2zr0KtVLI5ootHJh7/pNrJCHm9nJAOkTkTPAOzLVNoBAZN/KPOVweQb/elnhw+4YOxy1qyhSvQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646452; c=relaxed/simple;
	bh=y8zkIJLYcQP14rzk+pSVdaqivSiA4EzzwRkUgJizY+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ulk82+7xE+vsSk/FylNvVFjf7tSxYgsa0O3+rhsYxsIQ048QQg8AW0xFnu8/q/ZN00oTvBUsbyvP5tZwRGUreRVgAEX3DXnrjDTnnGjis4d4tpbKCkDhIDHI3nd8YkV4gK0iloRlkB8LGjarONfhNDn3RTDC4jlnTELO/o8UjDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=INOxrhfi; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="INOxrhfi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8C14D1A0925;
	Thu, 17 Sep 2026 12:00:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5C7D95FAA3;
	Thu, 17 Sep 2026 12:00:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 967FD11C78B65;
	Thu, 17 Sep 2026 14:00:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789646425; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=k64Hbz6c8hUXxW/5Wdy/5UyoWVfa0/Y+gjzD+nPySPA=;
	b=INOxrhfi0uA88selAjHxfJLJoUxDUG4Y3KL3Q0yovIudrt88A7iRJgF9iUpjH4nIN4cb6C
	BfxRHoZeqyIaUKfp4ZIbBln/0J8tr5T+H4CmY0D6E/UV5bcNNvDC6d0j7UMQk1q4e1CZhp
	1CmeUXbyWnb4jdBfFXM6RJJe9DVRsGdeDOdCmfuc1bxzjUeLI0xxA1mUrLSGtSCwJaH7JZ
	iixX7Eof9xLYgX34viJ+9Pp2KlKt6tzvDBUHsE0fkEIQUNBqPbSPCITamhNRTeoShcuIs7
	DB3qrDLQ0HPT7teASverIsChO0j1jRC6T7qUQ8LCgpomckxPSq2CHpvN2UVWmQ==
Message-ID: <6e82dc04-a68d-4c54-a6f0-a13c04fa2eef@bootlin.com>
Date: Thu, 17 Sep 2026 14:00:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: reject attach while the PHY driver is in
 transition
To: Aleksei Sviridkin <f@lex.la>, netdev@vger.kernel.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org
References: <20260914204200.2743251-1-f@lex.la>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260914204200.2743251-1-f@lex.la>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/14/26 22:42, Aleksei Sviridkin wrote:
> phy_remove() clears phydev->drv as its last act; the driver core
> clears d->driver only afterwards, in device_unbind_cleanup(). In that
> window phy_attach_direct() skips the genphy substitution, because
> d->driver is still set, and then dereferences the NULL phydev->drv in
> phy_drv_supports_irq().

[...]

>     Verified on an MT7981 board (mtk_eth_soc GMAC, "MediaTek MT7981 PHY" at
>     mdio-bus:00), 6.18.44, with a 200 ms msleep() added at the end of
>     phy_remove() to hold the window open. Two images, identical except for
>     this patch.

If you need to add msleep(200) in the core of the framework to trigger that,
this is net-next material.

Maxime

