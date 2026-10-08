Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59A752BE3C
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914078; cv=none; b=ulF1/a39Xlz4p0xoFqTpBKemYH7NFsR4UsaWq4WMu3OEW5zzs2aSLFzwSTqt6UqJU0ncP5VpuuNA4W726CJZgPOn1OMb1tHrZ8VL68yTQ+QMAEny9xI6MRivQpUGZ0RzHi1PBXxpDrYJs6UE137AD6EH+KMJhoxMx4uR14Igrzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914078; c=relaxed/simple;
	bh=hCygAOcpoOgYSOhn3ir2c13VrfChCeMianiS4x5J6n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7Lwe3vMgwpX6XyCpztIoK/RbpjFZy005EN67N1lAJVtZLciRjUY3yF4dTHvHaeHmVlnNfPvubX8M9Qg30Sg4Cjw1ZWbW6OTnUMa6oLidbVLxWTghZkXlEeTUT1eWJ1oFzeiu4Yiv2P7DAY6+YTmNHCzrLHvM0EqSU6raWuRjqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=03B3EQ0A; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="03B3EQ0A"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 372A71A1201
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:54:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0B47660362
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:54:35 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id 88B1811D718B2; Tue, 13 Oct 2026 19:51:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791914070; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+ZpQqUUT5xDOkosuVKHI5oZ4WAPT6O1QigZ2jMnin5k=;
	b=03B3EQ0AYiwHZtPKJL+HjsZ9G5myHcStZtWHWXfav4SR0S8atcmdWaK1rwQAkxhU5wZykU
	I1kroVCoHI1TAHIvMersrNQCrpDcz0E7fWgq4kT3UotIRbEYd5Jr9BX5msuvvpTBR9xvDv
	oPPkLyBJGWLhPkwq07/ZjI3zfRumUWOdpkqVEYmqoDL1IvWqCRS4tNcpZ9iOfx7L4UMB85
	3nJHcK1tbgyFeN5LokJK1frhepCoAkNcC59eO7d4uapEUQ31f3nsehW41gIgqMwr7R8JKF
	j4+8TbBhGl6ao6mWYDQ+fBJSVBUPNkboBO5b7KCf0tcaQpyvv2DAhVUDS83Pdg==
Authentication-Results: mail.galae.net;
	none
Message-ID: <e0a76d2f-cfe5-497b-b25b-aeae2e174ab5@bootlin.com>
Date: Thu, 8 Oct 2026 10:29:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 01/10] net: hisilicon: hisi_femac: Move setting of
 netops to fix crash
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Jian Shen <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nicolai Buchwitz <nb@tipi-net.de>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kernel@vger.kernel.org
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
 <20261008022656.3592191-2-mmyangfl@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261008022656.3592191-2-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 88B1811D718B2
X-Spamd-Result: default: False [2.34 / 30.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[129];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.06)[57.25%];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	BCC(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
	URIBL_BLOCKED(0.00)[bootlin.com:mid,bootlin.com:email,localhost:rdns,localhost:helo];
	TO_DN_SOME(0.00)[]



On 10/8/26 04:26, David Yang wrote:
> hisi_femac_drv_probe() connects the PHY before dev->netdev_ops is
> assigned. phy_attach_direct() -> phy_link_topo_add_phy() reads
> dev->netdev_ops through netdev_need_ops_lock() since the commit in
> question, so probing crashes with a NULL pointer dereference when
> CONFIG_NET_SHAPER is enabled.
> 
>   phy_link_topo_add_phy from phy_attach_direct+0xec/0x37c
>   of_phy_get_and_connect from hisi_femac_drv_probe+0x1f4/0x558
>   Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
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
>  drivers/net/ethernet/hisilicon/hisi_femac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
> index d244a40df430..016605e86f0b 100644
> --- a/drivers/net/ethernet/hisilicon/hisi_femac.c
> +++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
> @@ -830,6 +830,8 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
>  		hisi_femac_phy_reset(priv);
>  	}
>  
> +	ndev->netdev_ops = &hisi_femac_netdev_ops;
> +
>  	phy = of_phy_get_and_connect(ndev, node, hisi_femac_adjust_link);
>  	if (!phy) {
>  		dev_err(dev, "connect to PHY failed!\n");
> @@ -850,7 +852,6 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
>  
>  	ndev->watchdog_timeo = 6 * HZ;
>  	ndev->priv_flags |= IFF_UNICAST_FLT;
> -	ndev->netdev_ops = &hisi_femac_netdev_ops;
>  	ndev->ethtool_ops = &hisi_femac_ethtools_ops;
>  	netif_napi_add_weight(ndev, &priv->napi, hisi_femac_poll,
>  			      FEMAC_POLL_WEIGHT);

