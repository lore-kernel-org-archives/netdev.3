Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12D52CCEB
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914049; cv=none; b=NpnWyE8GC+bH3jHTqX8pGath4l1ZEUJTRExfkJHrtj7anQYPilnzqQpw2STYnu+iqzhwDWUHxdgFrD78YpEqXbv12zK87UfqrVGjxbYB5/y7ZKEaqGJ7qDX9sovMnO/m+XIsEleaEh2XaIq0tVBm0A9zd0WFBSZ4PGxdZfWjr9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914049; c=relaxed/simple;
	bh=Y2/Ewf5IkZDC5G7ubw4tGMSTAq4i4xDhgRpZcpWtjVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KI4h0YaiBV5s+DGmyKFgAv9aVTW5I4Nb2OrtvIRl9jsQ1mHnnGS7jWlj27w3VTUy0Bvmg/vf1FDG74+9kdFjaxF1SL+sZGS0JISwA0FhNFbGG5QMCF63o0INUbDyNPMz0jkjqL/JGaEM6dz2lOrm84EJLjIWnvGZlipPxs7efhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WfMcpWzX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WfMcpWzX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0892E1A1201
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:54:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D06FE60362
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:54:06 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id 594FC11D717F3; Tue, 13 Oct 2026 19:51:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791914046; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=NX/RScijLlgmk9jFAka1C5iMtn80JrFrW2GWXIg3HGQ=;
	b=WfMcpWzXh2E3aFY/AIJ1i8PBKGmcdhv5ZroG1MMlzV29H5uAt2lD+Ie9PhkzBCC+ZpjttO
	2TBkUJvZ5LJsqvvsupP6+3MI0vxurVPrCbw8FzoeXrHxv1eGIDNwsAUedUwX5ckZ+Rm/gw
	aD0JAojOPEl263hgFq+SIuZp/bwRacARAsOkOKB6j3d1i3Yo8WxRYio1l4cZJAL268JCUj
	xuTu0Luqnc+fo0LP/CAEm0dOxNWYOs8iXAiX6IissxSktsNx90bOUiQJnP18NGHzEDOTo4
	xxnfZJCumOhmSl2FEi3VpIZXmu0fjskmFKAZrmaZkRVT9uvSrvo2MvOWH1Rekw==
Authentication-Results: mail.galae.net;
	none
Message-ID: <cdf6cbfd-1892-45dd-aa44-754a3412500a@bootlin.com>
Date: Thu, 8 Oct 2026 10:30:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 02/10] net: hisilicon: hip04_eth: Move setting of
 netops to fix crash
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Jian Shen <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Nicolai Buchwitz <nb@tipi-net.de>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
 <20261008022656.3592191-3-mmyangfl@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261008022656.3592191-3-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 594FC11D717F3
X-Spamd-Result: default: False [2.37 / 30.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[129];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.03)[51.22%];
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
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
	URIBL_BLOCKED(0.00)[localhost:rdns,localhost:helo,bootlin.com:mid,bootlin.com:email];
	TO_DN_SOME(0.00)[]



On 10/8/26 04:26, David Yang wrote:
> hip04_mac_probe() calls of_phy_connect() before ndev->netdev_ops is
> assigned. phy_attach_direct() -> phy_link_topo_add_phy() reads
> dev->netdev_ops through netdev_need_ops_lock() since the commit in
> question, so probing crashes with a NULL pointer dereference when
> CONFIG_NET_SHAPER is enabled.
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
>  drivers/net/ethernet/hisilicon/hip04_eth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
> index fc2c47dcfaab..d0409de5c553 100644
> --- a/drivers/net/ethernet/hisilicon/hip04_eth.c
> +++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
> @@ -976,6 +976,8 @@ static int hip04_mac_probe(struct platform_device *pdev)
>  		goto init_fail;
>  	}
>  
> +	ndev->netdev_ops = &hip04_netdev_ops;
> +
>  	priv->phy_node = of_parse_phandle(node, "phy-handle", 0);
>  	if (priv->phy_node) {
>  		priv->phy = of_phy_connect(ndev, priv->phy_node,
> @@ -989,7 +991,6 @@ static int hip04_mac_probe(struct platform_device *pdev)
>  
>  	INIT_WORK(&priv->tx_timeout_task, hip04_tx_timeout_task);
>  
> -	ndev->netdev_ops = &hip04_netdev_ops;
>  	ndev->ethtool_ops = &hip04_ethtool_ops;
>  	ndev->watchdog_timeo = TX_TIMEOUT;
>  	ndev->priv_flags |= IFF_UNICAST_FLT;

