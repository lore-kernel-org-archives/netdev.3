Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79EA4611CF;
	Wed, 30 Sep 2026 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756939; cv=none; b=a3XWDUWZW7I7srbdJQq4TINAslYycgJDUiRlt/YbCd7yBYpM4uogwEYjDjSpypzG2L1K2/pxeIkrPw6klMZkiDIhuUaKfC1AJK7VN9YqaOqBVSuzbzHKPXBcNw0CRwSqW6YjbQvjJ9POvVsT6ZpuvJfDyP+yJ1Q4pXrYV6+1azE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756939; c=relaxed/simple;
	bh=hrRo4iHvOFteEii1fLjsxxErXsDOCIAJEpbxHTHg1WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jImoHqO7ZbOHJEACRCf1w1SFGTFKvmSQZ2+OGpSCSSc+pUt6DZ5qsLaz0jquzy5B/Pv125YkvL2Ow8R4TknXM4in8X4TmYD7GrMTOcs8v2AozDVdvywvzLToU5oivv0bs6RMN7MuyM70/gaglTTcf2K4+n8VT7s1xqveQgdLYNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=Zfr20NvS; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="Zfr20NvS"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D94DD3EB90;
	Wed, 30 Sep 2026 08:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1790756929; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=EK6rK5UvTaistktgw1jCehgeAUAnCfSbI+UwNU2TkAU=;
	b=Zfr20NvSRLXnBGaCzenxKaZYlNR1d6ggpbOaimoRTD6/WWohmBdNIKuN9tTVM2CH2sBLWJ
	Yz365+o6obeYm11rghbCuSd7vYYun+fTi8bPBkCMW2vM0FBauza7SSECFWt830fj1aD31a
	jrDpKUTrsDx93rcu+HtkHTMZexmDhotG0iD3tnRg8OtHUHZdFt8I8wRbwk3QqG/S3mxPBo
	7h7YfJ+MEeXQabMU33WYIITVTB/ds6DPfiUeftQKgm8jOG1YWSU4X4thhy2MNm2X+T46IP
	pKFdM0X2qx5Wti29YUdVr7xheI1rqVm1GV7jSpzOCV6E1K4UfOTTzz+WWjJIvQ==
Date: Wed, 30 Sep 2026 10:28:45 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
Message-ID: <20260930082845.GA84786@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260924-wiznet-link-gpio-v11-3-42a332517b30@marmottus.net>
 <179059099826.3145.7654211997843249181@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <179059099826.3145.7654211997843249181@kernel.org>
X-GND-Sasl: arthur@marmottus.net
X-GND-Cause: dmFkZTEh1VmwNUjjxurnXkY/b4R7bZnpO/OS/5ckYwW7fxTbdm7aYf4fs5ZgRP9qBczC/tgOSi+GPb9IvnL7zBQuVh8xLo1VB7oD118U2kzNyZoBs38SBYbwKtnFA0WdU5luWYqfvegXMFG597iMFxwKu46vt9L9CqJO3uMVDJKjq/yHEQpZGkzPCxGtVHowrybZGsvzINQWxU0NVCj/WDbu33VBo/vVyq3+g1dA36kChOnAPgdYEe/JyyRUge+L0M68z5Zaza0SQaWicOyfFaKmOcBZ/FfNFRH+BectZD9Jxc0eE77tYIMn4iOqEAm8Lv9M9E0tZzE6VIuZN/40zMPNDkdnDXn3IETQHUM/yAiOEvV+jY7MX0JSAhwjYE8mEdvitQa5EqgRQc9rB/NI1WdTq6qHXFG2QU4fzAk0K4CO8mSgtE1mtMZ4W+w1YnTlwPRFEwDfzdy9VoSizDfMd8flah/uX5R9G1VteliHmxF2xKWzY+wdBh7SBn4dybK8T4zCsIr+/DHQCQLf+1xx+38YAwap6mr3OQz4/Yn/6jUwhWvc9k57Ho1tiDJmEPt4OO1oPT7oYnNLX1YZ+u4uzonBiuSM996WzMqBu1ULMi4+MIVymUHpw/xpws/vwxpt42QleZTg7WH9P66mfaAilN7EBQuVlPV/vki6JkUpviBXanyLSQ
X-GND-State: clean
X-GND-Score: 0

On Mon, Sep 28, 2026 at 10:23:18AM +0000, netdev-bot+sashiko@kernel.org wrote:
>> +static irqreturn_t w5500_detect_link_interrupt(int irq, void *ndev_instance)
>> +{
>> +	struct net_device *ndev = ndev_instance;
>> +
>> +	if (netif_running(ndev))
>> +		w5500_report_carrier_state(ndev);
>> +
>> +	return IRQ_HANDLED;
>> +}
>
>[Severity: Low]
>What happens if all three PHYCFGR reads in w5500_get_phycfgr_lnk() fail on
>the link-up edge?

The driver will log the error but I do not think this patch can much
more than that.

>[ ... ]
>
>> @@ -448,12 +531,28 @@ static void w5100_restart(struct net_device *ndev)
>>  {
>>  	struct w5100_priv *priv = netdev_priv(ndev);
>>
>> +	if (!netif_running(ndev) || !netif_device_present(ndev))
>> +		return;
>> +
>> +	disable_irq(priv->irq);
>> +	if (priv->link_irq > 0)
>> +		disable_irq(priv->link_irq);
>> +
>>  	netif_stop_queue(ndev);
>> +	w5100_hw_close(priv);
>> +	flush_work(&priv->rx_work);
>> +	flush_work(&priv->tx_work);
>>  	w5100_hw_reset(priv);
>
>[Severity: Low]
>This isn't a bug introduced by this patch, but netif_stop_queue() doesn't
>wait for an ndo_start_xmit that is already running. Can w5100_start_tx()
>still queue tx_work after flush_work(&priv->tx_work) here?
>
>w5100_start_tx() {
>	...
>	if (priv->ops->may_sleep) {
>		WARN_ON(priv->tx_skb);
>		priv->tx_skb = skb;
>		queue_work(priv->xfer_wq, &priv->tx_work);
>	...
>}
>
>If it can, tx_work could issue SPI transfers at the same time as
>w5100_hw_reset() during tx timeout recovery. The baseline w5100_restart()
>had no flush at all, so this patch narrows the window rather than opening
>it.

True, the low risk still exists.

>[ ... ]
>
>> @@ -667,13 +772,40 @@ static int w5100_stop(struct net_device *ndev)
>>  	struct w5100_priv *priv = netdev_priv(ndev);
>>
>>  	netif_info(priv, ifdown, ndev, "shutting down\n");
>> -	w5100_hw_close(priv);
>> -	netif_carrier_off(ndev);
>> +
>> +	disable_irq(priv->irq);
>> +	if (priv->link_irq > 0)
>> +		disable_irq(priv->link_irq);
>> +
>>  	netif_stop_queue(ndev);
>>  	napi_disable(&priv->napi);
>> +
>> +	cancel_work_sync(&priv->restart_work);
>
>[Severity: Medium]
>Can a restart_work that is already running wake the queue again after the
>netif_stop_queue() above?
>

With the correct timing, technically yes it could.

>[ ... ]
>
>> @@ -839,10 +1011,11 @@ static int w5100_suspend(struct device *dev)
>>  	struct w5100_priv *priv = netdev_priv(ndev);
>>
>>  	if (netif_running(ndev)) {
>> -		netif_carrier_off(ndev);
>> +		mutex_lock(&priv->link_lock);
>>  		netif_device_detach(ndev);
>> +		mutex_unlock(&priv->link_lock);
>>
>> -		w5100_hw_close(priv);
>> +		w5100_stop(ndev);
>>  	}
>>  	return 0;
>>  }
>
>[Severity: Medium]
>What happens if the core calls ndo_stop between this suspend and the
>matching resume?
>
>Here w5100_stop() disables both irqs and calls napi_disable(). However,
>__LINK_STATE_START stays set, and suspend takes neither rtnl nor the netdev
>lock.
>
>A kernel-initiated dev_close() can run during the suspend window, for
>example from cleanup_net() on the non-freezable netns workqueue. In that
>case w5100_stop() runs a second time:
>
>__dev_close_many()
>  w5100_stop()
>    disable_irq(priv->irq)          <- disable depth now 2
>    napi_disable(&priv->napi)
>      napi_disable_locked()         <- SCHED/NPSVC still set from the
>                                       first napi_disable()
>
>napi_disable_locked() would then spin forever in usleep_range() while
>holding rtnl.
>
>After that, netif_running() is false, so w5100_resume() skips w5100_open().
>The irq disable depth stays raised, and a later ifup leaves both irqs
>disabled.
>
>Before this patch, suspend only called w5100_hw_close(), which touched
>neither NAPI nor the irq disable depth.
>

Taking rtnl_lock/unlock in suspend/resume could close this gap
but it is again probably something very unlikely to happen.

Arthur
