Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889A49E5ED;
	Mon, 19 Oct 2026 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404815; cv=none; b=nyMXh7IJV9/4bhn1O0IdyX25uaTNHQBflSn/mxUGtrJE3WmfBO2jM7IKO/AoDEUjnhAfX0qCPWAGWhdIE0bu7vjaMvU5M2gpg+69MYRbOuvK9ZbSV4T+UIpZN5bS1t+9622c7EMJy0/z1Tqhkfwt+QspYHBUWEyOtqoUWAnogm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404815; c=relaxed/simple;
	bh=Xqo4vljIiiz21/RhJekpRAMPyzV+YVhpiXSTBanJPKo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=j4+vWl+77qxkWwXtHTBFOwVUe1W1YcmqnasTxatw7ORWpAAqF9LF9bpuXhrqDLrefSeTQfK7sPagDzCqvNZVppe/DFtGA4M5CCJoLip8iEN6IYgA2TH3coOEtWbjEgx4QYpZKkD6yFoJySTVgTAeR+dQcYJRhJLo/kOZ32JMhvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=mpVR5LaG; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="mpVR5LaG"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C5ECA0E36;
	Mon, 19 Oct 2026 12:13:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792404810; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8h7nzr4NEQFRILhkT8O+MIgbmBu8pilgovWU9a/qJH0=;
	b=mpVR5LaGIMURe9zfdSEKM5E3eM1d0m8Uhm2M4LJN9EGCTBTAiw7DiQNEX7XHKPTtkS2EM0
	1YVLtpR93BK4bYib7ZQRl1bF7/nlUtSuECulC+poQPBHZaFZTCqUeedYELE7dFY2AZVSy5
	ylj1loYbKSxjh+aci4/N4c7UrQZzT/FUjUAtICGtZYIPtYOUdB0SiXFQV/8t5Oc2B2hrKj
	BrjGRziZMw9W+KZiy/L+gNxFTYO1iBvevmGSVGsTmK2WLowgAvcJXPSlJneuL9+zZMxzFE
	tcCC9b90Rn0ByjM8W+Q39P7nMquh5Eib/dV0TkukaheHrf+SZtfkW66w1INm8Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 12:13:28 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Chris Babroski <cbabroski@nvidia.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com,
 linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
 Raju.Lakkaraju@microchip.com, davthompson@nvidia.com
Subject: Re: [PATCH net-next v1 2/5] net: lan743x: start phylink last and stop
 it first
In-Reply-To: <84c495b24206953fb799d4070c4d99ff27efb829.1792008404.git.cbabroski@nvidia.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
 <84c495b24206953fb799d4070c4d99ff27efb829.1792008404.git.cbabroski@nvidia.com>
Message-ID: <b8e16814d4472d6456ba78918005c8bd@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 15.10.2026 17:00, Chris Babroski wrote:
> lan743x_netdev_open() starts phylink before the RX and TX rings exist,
> and lan743x_netdev_close() only stops it after the rings are freed. The
> mac_link_up() callback wakes all TX queues, so it can run while there 
> is
> no TX ring to transmit on.
> 
> For ndo_open and ndo_stop the qdisc is not active at that point, but 
> the
> suspend and resume paths call lan743x_netdev_close() and
> lan743x_netdev_open() directly with the qdisc still attached. A link up
> event in either window lets the stack call ndo_start_xmit() on a 
> channel
> whose ring is not allocated yet or has just been freed.
> 
> The error path of lan743x_netdev_open() is also wrong: a
> lan743x_ptp_open() failure jumps past lan743x_phylink_disconnect(),
> leaving phylink started and the PHY attached after open has failed.
> Every later open then fails because the PHY is already attached.
> 
> Connect and start phylink as the last step of open and stop it as the
> first step of close, as other phylink users do. If phylink fails to
> connect, nothing is attached, so the error path only needs to unwind 
> the
> rings, PTP, MAC and interrupts.
> 
> Fixes: a5f199a8d8a0 ("net: lan743x: Migrate phylib to phylink")
> Assisted-by: LLM
> Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c 
> b/drivers/net/ethernet/microchip/lan743x_main.c
> index 9e1276cf313c..583f631df701 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -3334,6 +3334,8 @@ static int lan743x_netdev_close(struct net_device 
> *netdev)
>  	struct lan743x_adapter *adapter = netdev_priv(netdev);
>  	int index;
> 
> +	lan743x_phylink_disconnect(adapter);
> +
>  	for (index = 0; index < adapter->used_tx_channels; index++)
>  		lan743x_tx_close(&adapter->tx[index]);
> 
> @@ -3342,8 +3344,6 @@ static int lan743x_netdev_close(struct net_device 
> *netdev)
> 
>  	lan743x_ptp_close(adapter);
> 
> -	lan743x_phylink_disconnect(adapter);
> -
>  	lan743x_mac_close(adapter);
> 
>  	lan743x_intr_close(adapter);
> @@ -3365,10 +3365,6 @@ static int lan743x_netdev_open(struct net_device 
> *netdev)
>  	if (ret)
>  		goto close_intr;
> 
> -	ret = lan743x_phylink_connect(adapter);
> -	if (ret)
> -		goto close_mac;
> -
>  	ret = lan743x_ptp_open(adapter);
>  	if (ret)
>  		goto close_mac;
> @@ -3387,6 +3383,10 @@ static int lan743x_netdev_open(struct net_device 
> *netdev)
>  			goto close_tx;
>  	}
> 
> +	ret = lan743x_phylink_connect(adapter);
> +	if (ret)
> +		goto close_tx;
> +
>  	if (netdev->phydev)
>  		phy_support_eee(netdev->phydev);
> 
> @@ -3414,8 +3414,6 @@ static int lan743x_netdev_open(struct net_device 
> *netdev)
>  			lan743x_rx_close(&adapter->rx[index]);
>  	}
>  	lan743x_ptp_close(adapter);
> -	if (adapter->phylink)
> -		lan743x_phylink_disconnect(adapter);
> 
>  close_mac:
>  	lan743x_mac_close(adapter);

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
