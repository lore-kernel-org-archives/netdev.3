Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B83DA5C1;
	Mon, 14 Sep 2026 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395265; cv=none; b=JdAsy9NM1N2Q28iBViFKhJqnMJ9E/DT41ode9Zvr7/euLNDLfS1nZ7Z+xpzFL29viEHxIuHykBYKxDAomrAdd2hDKfNrVmjuxyZAhxaK5qZFDm5cUMpr5ANW+SN4Tuxkm+CGzD+aqlD93S49OgT2/RR6i4ycLOLX8ssrveooelk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395265; c=relaxed/simple;
	bh=LGL1YWvJWpau1/cNewDTAZhx8AzhG7NFKL+03wdKC1A=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sSvCQMpCkSfZk8YkMgwkgIp/LATCowB4Fq6EuiUJ2ZcCvqo5D81D8ohu68BTK34GoUw3jMxWtXs2fbc3PmQ/5j5N9ivFseXOR7VskUUgYzXkIsOA1cJYoe+UJzDMNPCkuh5QV13Ad5hgDFcGtzLy4hOheUuS6GE3HWY2Y3uuzDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=j1XjfEkx; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="j1XjfEkx"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 11E07A02A9;
	Mon, 14 Sep 2026 16:14:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789395261; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rT+VwkAWI2S/eResoXZOri77kA7K1i893Ug+mAkjcmw=;
	b=j1XjfEkx2ZFB4hbaCIApnpAUZpCbrmwUYSnEGHkBzFba766FtRiAMGKjdoq2mRV0zV0KJu
	UHda9+Bx/QBqjeve5jr6ZdEwu9CFGKuyT62iwWV0Af6/HPpnqHGkWYZU5wvdgTx5FgE4Km
	GVF/x1K9DOt4yilE+OBRfp/2MpvUZv5etzJq26ZnnKXmYy1+BRHFeYo//roO+c+sK44zMm
	ut2inPym5Z8/nKmXfFq/6LJohpYTFmEuPKXL8c+QyEs4x4Yt0I9cYuy2f6jXrxPDARb2D3
	qELxuBEatL9tjabkThIhxL3hguN2BPxPTmBcUyO6RQfWwLJOHbcdk3eRvPAaAQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 16:14:20 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v11 02/15] phylib: Add support for PHYs with
 broken forced mode
In-Reply-To: <20260914-ax88179a-v11-2-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
 <20260914-ax88179a-v11-2-5ea7a925ba6d@birger-koblitz.de>
Message-ID: <f64d21ee4706d57e80ac7a950c26878a@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 14.9.2026 14:46, Birger Koblitz wrote:
> Add support for PHYs which only supported auto-negotiated
> speed modes. This prevents a kernel warning and stack-trace within the
> phy_state_machine when PHYs return -EOPNOTSUPP from config_aneg()
> because they do not support forced modes.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/phy/phy.c | 4 ++++
>  include/linux/phy.h   | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 
> fce9bc7be3304b408c9f3ec9b5b95c76d3680a88..b83f938fe7c3bd619ae453434fd9582c0a055a57 
> 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1190,6 +1190,10 @@ int phy_ethtool_ksettings_set(struct phy_device 
> *phydev,
>  	      duplex != DUPLEX_FULL)))
>  		return -EINVAL;
> 
> +	if (autoneg == AUTONEG_DISABLE &&
> +	    (phydev->drv->flags & PHY_BROKEN_FORCED))
> +		return -EOPNOTSUPP;
> +
>  	mutex_lock(&phydev->lock);
>  	phydev->autoneg = autoneg;
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 
> 5f8d65868e0ff558c163421cfea5a6f3bd73a53e..d5f8e527ce8dfefd40a8b34e7c2f9adbcd6c87c1 
> 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -64,6 +64,7 @@ extern const int phy_basic_ports_array[3];
>  #define PHY_RST_AFTER_CLK_EN	0x00000002
>  #define PHY_POLL_CABLE_TEST	0x00000004
>  #define PHY_ALWAYS_CALL_SUSPEND	0x00000008
> +#define PHY_BROKEN_FORCED	0x00000010
>  #define MDIO_DEVICE_IS_PHY	0x80000000
> 
>  /**


Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
