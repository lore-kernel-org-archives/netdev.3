Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290521;
	b=TQKxIqSCGBK/yJNxID+7gjw73n+BnNkaERmxdFWwhaUL2NB7ZTb5dJmaFfhycV0dC40J
	 5xyPzgtAf0AD6Dj/Mb7Jwl3UioXXPkm/wJaazz9lYAKoHRWjaY1D1HWS+22oH4IJUre8/
	 vbS3qLA9drjlsZvxRSrDTcKS+zT5ClF/eYjptpZMlgxipYPsw3q8jn+SN+cvXUACXXh0B
	 R0B29h6LsjtXSz0SarwVDuMTGZw2zyB9efSHAA0QCtFGEDRe/RFLzHNsE0XxwchPwiPIP
	 uh9N1V5+gmyO9h0wpuGS+x5g+EKJ7J4S6xZm0OxbLL4gwui1IeFoR9CbXMtOcbQGLcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290521;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=AFeCYnytubQBMNux7hziA4Q5Uj+lo/pqtiW7DuReXLs=;
	b=xHYmFUiEJCr8YCsdDUoj2aA3ZTeNNlndrzg4rNtjapFGaRIXYwfx/J1Q2QphQSNyRq7d
	 DUKAZmDPlT1u1fmW3E5FDhP8tqC3i8l5UWefPOFY6xcP9J8ywmhjvLcNFuJrP7KqSSACG
	 dZeMpDfV5WwcIgi7bxc/Yqw442LVS//Moy72YZLKk40Tqwopo21MyUJTjV/AygS+ayxG5
	 PtR4boygYLyFRR3hyvkCGiEA60AjENoJVmK1H0/GtEZTIwFwMPV+B6JpYoS5nhENKgCzK
	 QrkpwHfqFyp5tkzmgj6ybrBKATuAsq+9PVX7zWQqVPE27FseGnICVPyQpk4dSJg8flA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WI/aCo4d";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E197F606A31A;
	Thu, 29 Oct 2026 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WI/aCo4d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD9A1F01816;
	Thu, 29 Oct 2026 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290520;
	bh=AFeCYnytubQBMNux7hziA4Q5Uj+lo/pqtiW7DuReXLs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WI/aCo4dVN3XY4/jtSh/oLLQAAsO4qYH2uU/FSoecB0NOYpAguZcI7CziqIeYhG1g
	 Y1ccxqmMEhYqruPGJoOw4zYT6RogrpramC1aAHh2+8yPdvpG4f6O0DiV4ZlSCth2zs
	 nTO6jo1mkPGMbesRm9V8Gye07PWVMC9yZXGRGLF+qGsOATX6yJwTS1OVTTS45SBXjM
	 p7PotTErS/DuxJD4KVhnkWVrKnIz6hOoqHzZIqmCscrH146SwZ86lR4G2dHrQA9rQq
	 d59EYnFBjH2/QQCDISOZa+CEEsS7NZPlCfJtzJOeCzmwm1IOfXtH3eMEeGv6xmSCR+
	 zNChM8QH0L3vA==
Subject: Re: [PATCH net 08/11] net: au1000: restore receive filtering after
 MAC initialization
From: netdev-bot+sashiko@kernel.org
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, shaojijie@huawei.com, horms@kernel.org,
 runyu.xiao@seu.edu.cn, mmyangfl@gmail.com, hvr@gnu.org, jeff@garzik.org,
 danny.kukawka@bisect.de, mugunthanvnm@ti.com, sebastian.hesselbarth@gmail.com,
 linux-kernel@vger.kernel.org, manuel.lauss@gmail.com
Date: Thu, 29 Oct 2026 16:15:19 +0000
Message-ID: <179329051912.3134.7644702434785244368@kernel.org>
In-Reply-To: <20261027223140.3774570-9-f.fainelli@gmail.com>
References: <20261027223140.3774570-9-f.fainelli@gmail.com>
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

- [Low] In au1000_init() (drivers/net/ethernet/amd/au1000_eth.c), the
  control register is written with MAC_RX_ENABLE | MAC_TX_ENABLE and no…

--

net: au1000: restore receive filtering after MAC initialization

This patch reapplies the current netdev receive mode at the end of
au1000_init(). Promiscuous and multicast settings are then kept after a
watchdog reset. It also takes aup->lock around the control register
read-modify-write in au1000_multicast_list().

> diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
> index f8976e324f0e7..6b817d18329b2 100644
> --- a/drivers/net/ethernet/amd/au1000_eth.c
> +++ b/drivers/net/ethernet/amd/au1000_eth.c

[ ... ]

> @@ -742,6 +744,9 @@ static int au1000_init(struct net_device *dev)
>  	wmb(); /* drain writebuffer */
>  
>  	spin_unlock_irqrestore(&aup->lock, flags);
> +	netif_addr_lock_bh(dev);
> +	au1000_multicast_list(dev);
> +	netif_addr_unlock_bh(dev);

[Severity: Low]
Is there a short window here where the receiver runs without the
requested filter?

A little earlier, au1000_init() enables RX and TX with none of the filter
bits set:

	if (!dev->phydev || dev->phydev->link)
		control |= MAC_RX_ENABLE | MAC_TX_ENABLE;

	writel(control, &aup->mac->control);

Then aup->lock is dropped. Only after that does au1000_multicast_list()
program multi_hash_high/low and set MAC_HASH_MODE, MAC_PROMISCUOUS or
MAC_PASS_ALL_MULTI, using a second read-modify-write.

This can happen on the au1000_tx_timeout()->au1000_reset_mac()->au1000_init()
path when the link is up, or on open when there is no PHY. In between the
two writes, frames for joined multicast groups, or non-local frames in
promiscuous mode, could be dropped.

The window is small next to the reset delays that come before it. On open
it is also shorter than before, since __dev_open() calls dev_set_rx_mode()
only after ndo_open. The window is still there at the end of the series in
"net: au1000: keep the MAC stopped until the PHY link is ready" when there
is no PHY or the link is up.

Would it be worth computing the filter bits and adding them to control
before the single writel()? Then enabling RX and programming the filter
would happen in one step.

>  	return 0;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027223140.3774570-1-f.fainelli%40gmail.com
