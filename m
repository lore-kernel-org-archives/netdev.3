Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290514;
	b=GKIH54jglOKaOifsq6HWVj4AGiOMnJm1lmZka9p3FJOgrTmnB+Hic6z5XzfAq7nihXzM
	 WPVHYW6y0xH0fNk1V3YnGgCtltPhInsBfzTsiKSBQFcPa1Agj07acBqizzfVwPNUAKbaH
	 /Z+/PYJ0dTzO28E2/7MG8GikHHBQNvCWg3Mo558cO1n2cJhTm+rkqMqjMXdE48g58HBQd
	 zLyZw/HcmogX5QqXThs3NKzaG3UKMFgkc+Kk8/JZ/sAdeFYPEMXZJy2gjXvF4ly9WCCPe
	 xA4h+kgZFGhskK60E72c2xgX6ldo/l7wXgVbYNEEYmEiAam6yuhUkzMmcFxtjOFCEwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290514;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=A5I0sjiC3/tXoE6gD6LWbDqfY9ZN1us7CsjxWKvsGJ0=;
	b=iBX2RqMJeQlwBHcQlnK7cUqOaNfhRv66nBF/IrKOCi1r07hKH+xG35NB/A+DtIseC6S9
	 CPlWeese9MwbR+t+PKmhUEjMKMtB4QKaICuhz7TOxnPB38GJCDlpPikKqT9TiYfLD/gTH
	 GfsNT7ONNQv/X548pIgA15+9w6/KVK+vkcn+PW6suKKXBO0N0KYrixLRuKO75+ATsnmi5
	 FFpzy9KITQClroADzD0Qe8hLczcARrhOo/5Qth8OYCenf01PG9AjOE2PU8vzT1HVXvZ4y
	 IKXQ0XxEXxM1m8giV01GHnPF6tvsxVWnKtm8X+WhbUj2WnarsAUSfWolmbjCxjZsSrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgWUOrU1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD9606A33C;
	Thu, 29 Oct 2026 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgWUOrU1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46351F031EB;
	Thu, 29 Oct 2026 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290513;
	bh=A5I0sjiC3/tXoE6gD6LWbDqfY9ZN1us7CsjxWKvsGJ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LgWUOrU1x3XohJOFevxR/w/0WuLroq8cLqXvzezz/1+GNgg9LQ2Oxo7OdgYg2OcXc
	 X1hmO5/Y1kGLIAo+gfi654dravufUexHX1GseLOSdAxA8XZHCVmhFy+oKTHsQkqfls
	 mv9v5sXnzfc64BFBaBLm/TutWPIKKwCcAaW4BHvVsS47Xqh5SY6YUTniSzPmYxAwHT
	 aYYzJsUaQWqRVZoFc29tl6IudnW2Asaw6CPBsUUb+KxbliIy6xH49E/8OPQ8yXTZNi
	 pDzAWxxW6JeyOhbzBdvS2OW1/LRbxeVGKnLroHuDy/GMs4aHnJXijz6NXnkkme9Gpr
	 ueZIrTfg0+sLg==
Subject: Re: [PATCH net 04/11] net: au1000: report MDIO transaction timeouts
From: netdev-bot+sashiko@kernel.org
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, shaojijie@huawei.com, horms@kernel.org,
 runyu.xiao@seu.edu.cn, mmyangfl@gmail.com, hvr@gnu.org, jeff@garzik.org,
 danny.kukawka@bisect.de, mugunthanvnm@ti.com, sebastian.hesselbarth@gmail.com,
 linux-kernel@vger.kernel.org, manuel.lauss@gmail.com
Date: Thu, 29 Oct 2026 16:15:12 +0000
Message-ID: <179329051221.3134.18425968013165195410@kernel.org>
In-Reply-To: <20261027223140.3774570-5-f.fainelli@gmail.com>
References: <20261027223140.3774570-5-f.fainelli@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new completion poll in au1000_mdio_write() reads MAC_MII_BUSY
  right after `writel(mii_control, mii_control_reg)`.

Pre-existing issues:
- [Low] On success, au1000_mdio_read() returns the raw 32-bit
  MAC_MII_DATA value (`return readl(mii_data_reg);`, au1000_eth.c:298)…

--

net: au1000: report MDIO transaction timeouts

This commit changes au1000_mdio_write() to return an int. Timeouts from
the busy wait before the transaction, and from a new completion poll after
the write, now go back to phylib through au1000_mdiobus_write(). The read
timeout paths in au1000_mdio_read() now return -ETIMEDOUT instead of -1.

> diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
> index 70319b432182f..a507a524370fd 100644
> --- a/drivers/net/ethernet/amd/au1000_eth.c
> +++ b/drivers/net/ethernet/amd/au1000_eth.c

[ ... ]

> @@ -292,14 +292,14 @@ static int au1000_mdio_read(struct net_device *dev, int phy_addr, int reg)
>  		mdelay(1);
>  		if (--timedout == 0) {
>  			netdev_err(dev, "mdio_read busy timeout!!\n");
> -			return -1;
> +			return -ETIMEDOUT;
>  		}
>  	}
>  	return readl(mii_data_reg);

[Severity: Low]
This isn't a bug introduced by this patch, but should au1000_mdio_read()
mask the data register value to 16 bits before returning it?

On success the raw 32-bit MAC_MII_DATA value goes back through
au1000_mdiobus_read() to phylib. __mdiobus_read() expects either a
register value or a negative errno, and it passes the value through
without masking:

drivers/net/phy/mdio_bus.c:__mdiobus_read() {
    ...
	if (bus->read)
		retval = bus->read(bus, addr, regnum);
    ...
}

If bits 31:16 of mii_data ever read back non-zero, phylib would get a
value wider than 16 bits. If bit 31 were set, it would read as an error.

Nothing in the tree shows whether those upper bits are ever non-zero on
this hardware. Would something like readl(mii_data_reg) & 0xffff be
safer, now that negative values on this path are proper errnos?

>  }

[ ... ]

> @@ -320,6 +320,17 @@ static void au1000_mdio_write(struct net_device *dev, int phy_addr,
>  
>  	writel(value, mii_data_reg);
>  	writel(mii_control, mii_control_reg);
> +
> +	timedout = 20;
> +	while (readl(mii_control_reg) & MAC_MII_BUSY) {
> +		mdelay(1);

[Severity: Low]
With this new completion poll, will every MDIO write now busy-wait for at
least 1 ms?

A clause 22 management frame is about 64 MDC cycles, which is roughly
26 us at 2.5 MHz. So the first readl() right after
writel(mii_control, mii_control_reg) will almost always see MAC_MII_BUSY
set, and mdelay(1) will run at least once.

The mii_bus->write callback runs in process context under
bus->mdio_lock, which is a mutex. Could this use readl_poll_timeout()
with a sleep of a few tens of microseconds and the same ~20 ms timeout?

To be fair, before this patch the access that followed a write already
paid this mdelay(1) in its own BUSY wait before starting. So for
back-to-back sequences the cost mostly moves into the write. The new cost
falls on the last write of a burst and on isolated writes. The existing
completion poll in au1000_mdio_read() has the same 1 ms granularity.

> +		if (--timedout == 0) {
> +			netdev_err(dev, "mdio_write busy timeout!!\n");
> +			return -ETIMEDOUT;
> +		}
> +	}
> +
> +	return 0;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027223140.3774570-1-f.fainelli%40gmail.com
