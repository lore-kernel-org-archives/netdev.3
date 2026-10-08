Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B24A3D75A4
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448231; cv=none; b=II8Freetrleip4oSbfpXXxseiNWyQ52JbLgSXjhRrzu7xGVszuTvo+qFoonkB3pdxXrv99qKkYQWvk+Xt622x7SE6JpXCDu6GvALGYDzUyXQPlJp/49dBdfwC73YTnC3ktfxIzuFdWHSd4FOETKXLAWfad2q2/4fE3K4WhiFUZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448231; c=relaxed/simple;
	bh=NK4BN9I4Kbmst7DqPYbh2MeXJQp4Qdfp8C4ZhaQniaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkJiCWsGxIvYdEf9LTk4jHmqH5BykINm8GXTLkgv2+xvIKJlWkIB7hJJdpD0hsKujdghX//UHYOeBKdz9VTvXKeDxBZ3K+MfF49+O/oqLiTSXY5DZhk2ahtmUsKdvb0ZQvn7vU2+xX2sOKthuECpKu/TjMHDpPEGe1hcEpptoQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2VH/QRrU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2VH/QRrU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F3ACE1A1185;
	Thu,  8 Oct 2026 08:30:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C3FEC60341;
	Thu,  8 Oct 2026 08:30:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B0D4810333850;
	Thu,  8 Oct 2026 10:30:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791448226; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xxECxQ++O9X0OKyJZXgkZtO03GupF5npmg5sevhbrog=;
	b=2VH/QRrUho2xFw/tBmEw9RjXx/KeuK4roNPFgZM78+4XHVP4W2OQzheGIGq3728PvD02yt
	C2Gb8SokhmGuvHzU/vj3D+zMCFZWPASBe11zuv36fSDGdjRE2TS/gzxPjO5BnMmZ5OsfWE
	jA2r3Ad2tEPK5yjme2raaU1kZBfJdHUMGj3SJqIHsZFroLdXUeQLWkuPYsWPvO8Ri5BYhn
	Gnh9dED8kgmEjiIMkPX7Zx52ki6WeGTsMPTR8gdk/EuMyGwBDgnVnv8FqWANPelltfgxMq
	rQb7snen7yxmwPmLztfLmullzXxqsrEryAaHzasSoZC423QjI8DhPOkHUeoJ3A==
Message-ID: <b44d36a0-43a1-4399-8c79-29d1f57984cd@bootlin.com>
Date: Thu, 8 Oct 2026 10:30:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 03/10] net: ethernet: actions: Move setting of netops
 to fix crash
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <mani@kernel.org>, Stanislav Fomichev
 <sdf@fomichev.me>, Nicolai Buchwitz <nb@tipi-net.de>,
 Jacob Keller <jacob.e.keller@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
 <20261008022656.3592191-4-mmyangfl@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261008022656.3592191-4-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/8/26 04:26, David Yang wrote:
> owl_emac_probe() calls owl_emac_phy_init(), which connects the PHY,
> before netdev->netdev_ops is assigned. phy_attach_direct() ->
> phy_link_topo_add_phy() reads dev->netdev_ops through
> netdev_need_ops_lock() since the commit in question, so probing crashes
> with a NULL pointer dereference when CONFIG_NET_SHAPER is enabled.
> 
> Assign netdev_ops before the PHY attach, as was done for emac in commit
> 7c9f391ec89c ("net: emac: move setting of netops to fix crash").
> 
> Fixes: ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking assertion")
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

> ---
>  drivers/net/ethernet/actions/owl-emac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/actions/owl-emac.c b/drivers/net/ethernet/actions/owl-emac.c
> index 0a08da799255..2538275a1e57 100644
> --- a/drivers/net/ethernet/actions/owl-emac.c
> +++ b/drivers/net/ethernet/actions/owl-emac.c
> @@ -1552,6 +1552,8 @@ static int owl_emac_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	netdev->netdev_ops = &owl_emac_netdev_ops;
> +
>  	ret = owl_emac_phy_init(netdev);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize PHY\n");
> @@ -1563,7 +1565,6 @@ static int owl_emac_probe(struct platform_device *pdev)
>  	netdev->min_mtu = OWL_EMAC_MTU_MIN;
>  	netdev->max_mtu = OWL_EMAC_MTU_MAX;
>  	netdev->watchdog_timeo = OWL_EMAC_TX_TIMEOUT;
> -	netdev->netdev_ops = &owl_emac_netdev_ops;
>  	netdev->ethtool_ops = &owl_emac_ethtool_ops;
>  	netif_napi_add(netdev, &priv->napi, owl_emac_poll);
>  

