Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08854522EE6
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914113; cv=none; b=dJcee6QDInS4vzPvLT3Dgssm1cSZRjhZb5J4RFDR/XRbDM2/HKZLc4YFkCy3YOC1nFRY78IHdBxlSDuAJpChlhIcWoMOSKiO4J76FmG4eGqYdo6850uiQYrDopbezuWvdA9XQPzXcK7MsRtp861CP0s1lpbo9WqZKyEg9hYk3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914113; c=relaxed/simple;
	bh=x3o1DAZn/q9fK5VTxPdRdzWyhUDNB8E+v0vhPr97sVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJRiSGgERsmQ/A1Auflg/Zx9/qraKoZWVezUq005xhv8CHA4wvDEkoGcymHZ0f1JEHw0H/d2f0eVIvDgomhszlV6sYPLQneaal5/7kJJBPc8HunRiXP75i9WSrWYeyRNvrlJ7z2uFXkrEuj6JdLXFwxwWjr7Fukzq4nsOmmJ43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WPQeTOxd; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WPQeTOxd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2A182C653F9
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:56:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8909660362
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:55:10 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id 01AC611D703F4; Tue, 13 Oct 2026 19:51:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791914109; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4CnS8TZf6JbIo1PcyuhgihPY/KfHm7HXGTDf4os3Y2U=;
	b=WPQeTOxdcMUUDEfqcYyV7mnKzHXwm90cHFxGDIajf9/Kbri4zx5eo7zFH+rXtndWKQPf46
	PGJf24fGButtHpsao6/l8+dSFDgvf+vyqOdRR43hLFdhqSkAvyCsTx3ROQAxT0QZ/PgCSI
	KrXWy/k2jYwUDrT0D7G/Dkt8QTjUrSolD83G24sMiJukq9KZn7ghIW2WtkRmzzHCAehE8P
	KDr3VIB0zZJkuDr/ZTQBa+T18PSBEu4sZr+DS7ctf2LjtJ+5BvO6cQDtQ1Qrh0Lp8i0Edu
	/N9X3z+QZl4Nd9WOPyP25AUl3IKJFhUvZcBrNaCVdpJWPsz6pHk8GfAHypH0cw==
Authentication-Results: mail.galae.net;
	none
Message-ID: <cf574b62-efc9-4e18-9fd2-8854196823d6@bootlin.com>
Date: Thu, 8 Oct 2026 10:31:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 07/10] net: ethoc: move setting of netops to fix crash
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Jacob Keller
 <jacob.e.keller@intel.com>, linux-kernel@vger.kernel.org
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
 <20261008022656.3592191-8-mmyangfl@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261008022656.3592191-8-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 01AC611D703F4
X-Spamd-Result: default: False [2.37 / 30.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[129];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.03)[51.99%];
	RCVD_COUNT_ZERO(0.00)[0];
	TAGGED_RCPT(0.00)[netdev];
	BCC(0.00)[];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
	URIBL_BLOCKED(0.00)[bootlin.com:mid,bootlin.com:email,localhost:rdns,localhost:helo];
	TO_DN_SOME(0.00)[]



On 10/8/26 04:26, David Yang wrote:
> ethoc_probe() calls ethoc_mdio_probe(), which connects the PHY,
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
>  drivers/net/ethernet/ethoc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ethoc.c b/drivers/net/ethernet/ethoc.c
> index 0c418557264c..e5b7df43e8f6 100644
> --- a/drivers/net/ethernet/ethoc.c
> +++ b/drivers/net/ethernet/ethoc.c
> @@ -1211,6 +1211,8 @@ static int ethoc_probe(struct platform_device *pdev)
>  		goto free3;
>  	}
>  
> +	netdev->netdev_ops = &ethoc_netdev_ops;
> +
>  	ret = ethoc_mdio_probe(netdev);
>  	if (ret) {
>  		dev_err(&netdev->dev, "failed to probe MDIO bus\n");
> @@ -1218,7 +1220,6 @@ static int ethoc_probe(struct platform_device *pdev)
>  	}
>  
>  	/* setup the net_device structure */
> -	netdev->netdev_ops = &ethoc_netdev_ops;
>  	netdev->watchdog_timeo = ETHOC_TIMEOUT;
>  	netdev->features |= 0;
>  	netdev->ethtool_ops = &ethoc_ethtool_ops;

