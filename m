Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B440B6F4;
	Mon, 19 Oct 2026 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404849; cv=none; b=PBfB7i8OF0CAomUOx2/XvJwCqPHIOsIZ0F0lLLuxuBSfW70OC66rzRKXtKUDG3AAGUrjeJYPa2gmHULAzOXDJ+JbPvlJIf14g+Vr/gvdWZJRTKCFMwV0NWDMBNEYcpB0lPEM+NjfXxKrUovIJS9AbogupbbcYuoPuRo1S29mfSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404849; c=relaxed/simple;
	bh=BFt+qJi4377eMLyOGENL4gyLd6HdQF0i5o/onvNS+4M=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=E3uIPlujyF9M7dCVpKvOWHa6bZm8vJ+WdR1rMtB2Ye7/2nM/kMvBivKmf/B5ysodvHQm4tsVMs0SpsTATDijIv5g/hZksOeC5UjJi/e2/VE+tryj3qblI1aRbiWL/neBwiZLIMUfmoinwl+RUHB+47kcInVL9yRcejXeJTnxfBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=WEXXVbJF; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="WEXXVbJF"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B5D1FA1579;
	Mon, 19 Oct 2026 12:14:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792404845; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=InL61VLUuzPlGWQofu2zxUA1ILOLKdLMcGn7+Lgz2Ys=;
	b=WEXXVbJF6M9yn4ihy20FLHEgWB27Q6iFhTyeQuJUNad7ojxjXNP4p1hNCijDw3P9khp1uM
	TUzRNlfTUZcK/b8hNAyWDy2v2KR1blejFtCWYx+OouguCNeIsZHw326AJKPwPv3K/60zS/
	qLUMJeVKkRbYAfTpCSbsEBX/FJPKoNNUolSDQXHjkd0rBWDfUL9cELxLoQz0Hm2w46+Lbt
	jCURMgpxtTPPNjls1PWin/hmUblW/y3IHilFtg6q1YkH6uHKmCCCNDeipTugFv6awPYgp5
	CeUy64nNhCM7zP54wEnM3iKkhtmjZC3Y505n6ZcJrSVFNUgDZJcWdK5Sg39u7g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 12:14:05 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Chris Babroski <cbabroski@nvidia.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com,
 linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
 Raju.Lakkaraju@microchip.com, davthompson@nvidia.com
Subject: Re: [PATCH net-next v1 3/5] net: lan743x: quiesce TX before freeing
 the rings
In-Reply-To: <9e3d980f9853cd73ce4e845f9c3e5b5cb93fd2f5.1792008404.git.cbabroski@nvidia.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
 <9e3d980f9853cd73ce4e845f9c3e5b5cb93fd2f5.1792008404.git.cbabroski@nvidia.com>
Message-ID: <875bb04f66e19cee8b786f4403c006e6@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 15.10.2026 17:00, Chris Babroski wrote:
> lan743x_pcidev_shutdown(), which suspend also uses, calls
> netif_device_detach() and then lan743x_netdev_close() with the qdisc
> still attached. Detaching only sets the queue stop bits. It does not 
> wait
> for an ndo_start_xmit() that is already running, and the TX NAPI poll
> still wakes a stopped queue as soon as it has reclaimed descriptors. 
> The
> TX NAPI of a channel that has not been closed yet can therefore restart
> its queue, and the stack then transmits on a ring that
> lan743x_tx_close() is freeing.
> 
> Only wake a queue from TX NAPI while the device is present. In
> lan743x_netdev_close(), wait for any NAPI poll that may have missed the
> detach with synchronize_net(), then stop all queues with
> netif_tx_disable(), which also waits for transmits in progress, before
> closing the channels. For ndo_stop the qdisc is already deactivated, so
> this only adds a grace period there.
> 
> Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x 
> driver")
> Assisted-by: LLM
> Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c 
> b/drivers/net/ethernet/microchip/lan743x_main.c
> index 583f631df701..8d256a80dac6 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -2125,7 +2125,8 @@ static int lan743x_tx_napi_poll(struct 
> napi_struct *napi, int weight)
>  	/* clean up tx ring */
>  	lan743x_tx_release_completed_descriptors(tx);
>  	txq = netdev_get_tx_queue(adapter->netdev, tx->channel_number);
> -	if (netif_tx_queue_stopped(txq)) {
> +	if (netif_tx_queue_stopped(txq) &&
> +	    netif_device_present(adapter->netdev)) {
>  		if (tx->rqd_descriptors) {
>  			if (tx->rqd_descriptors <=
>  			    lan743x_tx_get_avail_desc(tx)) {
> @@ -3336,6 +3337,9 @@ static int lan743x_netdev_close(struct net_device 
> *netdev)
> 
>  	lan743x_phylink_disconnect(adapter);
> 
> +	synchronize_net();
> +	netif_tx_disable(netdev);
> +
>  	for (index = 0; index < adapter->used_tx_channels; index++)
>  		lan743x_tx_close(&adapter->tx[index]);

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
