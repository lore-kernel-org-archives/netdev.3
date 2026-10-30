Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353516;
	b=vJBELtrwQ0eXGLgagobi6C7Kr8iwzLye2dao9XL9rfBhumiEFnIn9oJ/CtRknmvWrrUV
	 f4aRHVHeM2Q6Fzx0+50Y0EMoyRdFIIP7Tcms5PYxc28Kuy2y+fbbveiyKQkjhGDfi76oW
	 b8zRd/1W5kZshklLdtHUrL3g5U4WBOqVZjPvTD++3wM60b/4rUgxvbLTQbNffjKgT+MTd
	 ydywLgGVv4JNLnzAhyRqTBvVMY60PfhuOsMx3smiMJX71avbzRYiaqlH7umbUpiVC/llg
	 5GGeev3aiW98HqPA0a1KNy4AFWcFUOkgOJM2/bMCC1jsoSWDKEgizvyW3+oQYnVIdJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353516;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=+at7dZGwSvVu/7pH3+e+iC9k0A30G52g4dzyOrLdjBc=;
	b=iJnWPsNDLT0DmF4z0UxYfg+9R7i0DX5YSvELtb57kY9+k6HEdpXdhcsHFtSjGEse/pdR
	 yiKJ7YNqqcMDl9zpMd9hnHapc0W1f3jDt2Np4M9pnf+nkU7qTUwxJ+F+Ec9VHTTtsIErq
	 ugmJJC8U79qpJeEpDWbIykxpZ8kkOxqLr/ZXlsj06OG0XKpZeXrXmkQsDmkocFCWyOckC
	 MVvy5d/I7w3BdJTdaT1dmvdSx4r6JIrXDc1hOEr255T+uaUBh3VKNaQIUYzoZfz+crIU/
	 PtFfyj9969WMhvlPQQpFaYxd7KhFhvDd1Jd1suFbpC+MEyAp6C4jo39QUD0UTXHxZgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=KakueTtm;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B7F606A31C;
	Fri, 30 Oct 2026 09:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83B7F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=KakueTtm
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BB4781A1398;
	Fri, 30 Oct 2026 09:45:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 80902603C2;
	Fri, 30 Oct 2026 09:45:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A1DD10328D09;
	Fri, 30 Oct 2026 10:45:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793353511; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+at7dZGwSvVu/7pH3+e+iC9k0A30G52g4dzyOrLdjBc=;
	b=KakueTtmpKnc0gGtghPxjB49nubrJ6XBiNYam2pWHCZjYxJfRbCIXhWKJZ1V2YP2Kze+Vd
	jqHOc7bT3gkJsajsa+0fpgL7ZbUYoJljuJVLoNG7WXE79CPkglquXiC/j1J23SnovW6uw+
	XbEoekTVBSNP2OrPTHTvnuzgkaAhp46UX86u9vR1M/drKBX8OCfGwxWaiF1dfrF0pDmoE1
	5s5f7X3Tuq6jZwPtW9Nt70g8TrBhoyM10I/y4yYn4N+H41IcB30NM8xCPkPr8JgFtXryXb
	YsMacOQMfcv83V5yeoEFHiRiWfPKO+cIGIx9AxIWyMWpIjJ+QGVJO0RC3bYiRw==
Message-ID: <fefab524-d29b-4d34-a638-6ad56674b2ed@bootlin.com>
Date: Fri, 30 Oct 2026 10:45:05 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net] net: phy: don't require RTNL to detach a PHY from an
 unregistered netdev
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+583f42a41879bb60de32@syzkaller.appspotmail.com
References: <20261029142423.93573-1-ngocthang2710.1999@gmail.com>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261029142423.93573-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/29/26 15:24, Nguyen Ngoc Thang wrote:
> phy_detach_internal() reads dev->hwprov with rtnl_dereference(), but
> MAC drivers commonly attach and detach PHYs while their net_device is
> not registered, without holding RTNL. Before register_netdev(), a failed
> phylink_connect_phy() or phy_attach_direct() unwinds through
> phy_detach_internal(). After unregister_netdev(), a driver's remove path
> may call phy_disconnect(). Both trip lockdep:
> 
>    WARNING: suspicious RCU usage
>    drivers/net/phy/phy_device.c:1831 suspicious rcu_dereference_protected() usage!
>     phy_detach_internal+0x6a5/0x830 drivers/net/phy/phy_device.c:1831
>     phylink_connect_phy+0x22e/0x2b0 drivers/net/phy/phylink.c:2452
>     ax88772_bind+0xbb1/0x1520 drivers/net/usb/asix_devices.c:925
>     usbnet_probe+0xbb3/0x27e0 drivers/net/usb/usbnet.c:1812
> 
> syzbot hits this with an emulated asix device. phy_eee_rx_clock_stop()
> fails on a USB MDIO error, so phylink_bringup_phy() fails and the PHY is
> detached from inside usbnet_probe(), before the netdev is registered.
> 
> hwprov is only set through ethtool, under RTNL, on a registered device.
> reg_state also changes only under RTNL. So if the device is not
> registered, no one else can reach hwprov, and RTNL is not needed. Tell
> lockdep that. A detach from a registered device without RTNL still
> warns.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

