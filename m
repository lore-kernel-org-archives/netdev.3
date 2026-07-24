Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1153342669E
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784891631; cv=none; b=WbqmqunH2ODyC0BtoQTPTctr/3/XgeOj7Fcx7TcwNGFRkf2P0dfL5/WFtSn8Tkgtz96ZepvS/QmtaQTpGVgdEc9JKMTgI/v4Nu90aXwNTbb6nlL1e28atKsqsJQQwJDLfifX8vcqqzHsxp62W2Khnxq5HCmnfXLZKqZ3UmXN3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784891631; c=relaxed/simple;
	bh=cqaHUbZRZY3l/5xbqIO2nrDdB0Zn+H/zzlajTfVUEqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaRUuBPhY8mqXeMLX2bfP3fBpfeNQ/bzGESWv7z668lhhH4IbCx/eSmniysIvRIUqKFbQ2qfys9aqaFEeFRj8dB9p6dtHhYSWZkFSlontguiI7x8Z5V7XDyU9JhE1mE85JWvWK4DbPjZuLyrAescWLCziiA+LwrXf8iIuP2PNF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mp6Mwoqk; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mp6Mwoqk"
Message-ID: <1dff878d-5f70-442e-9c6e-c829d51cfbf0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784890840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aoU0Q+dQgaNPxXZy6NeJmOiYyjoEqDE37HzIbGeX3bI=;
	b=Mp6MwoqkSQn6tQ/X3udmzWLsNSYKZHYH9ZIexBrU6sql5n9GgZq2W+1K9UVPQ0yG200g9u
	XK91jwaP9bUlqOlONhCEha1UGA6Um1v83aWak58OKrDfTFzTS1mBcuIAa1EEHYjJqlFV7O
	LVf3Nq+MASq+bxEjmwhJn7UBZQ4h2pQ=
Date: Fri, 24 Jul 2026 12:00:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ptp: netc: fix potential interrupt storm caused by
 incorrect unbind order
To: wei.fang@oss.nxp.com, richardcochran@gmail.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Frank.Li@nxp.com
Cc: wei.fang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260724065116.521893-1-wei.fang@oss.nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260724065116.521893-1-wei.fang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/07/2026 07:51, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> In netc_timer_remove(), hardware interrupts are disabled by clearing
> TMR_TEMASK before ptp_clock_unregister() is called. This may cause a
> race condition during driver unbind that could leave hardware interrupts
> active. For example, a concurrent PTP_CLK_REQ_EXTTS ioctl can re-enable
> TMR_TEMASK after it has been cleared, leaving a pending hardware
> interrupt when the driver unbinds.
> 
> Since the NETC Timer does not support PCIe FLR, hardware state is not
> reset during probe. When the driver is rebound and the IRQ is registered,
> the pending interrupt fires immediately. At that point priv->tmr_emask
> is still zero, so netc_timer_isr() does not clear the interrupt status
> and unconditionally returns IRQ_HANDLED, resulting in an uninterruptible
> infinite interrupt storm.
> 
> Therefore, move ptp_clock_unregister() before the register writes that
> clear NETC_TMR_TEMASK and NETC_TMR_CTRL. This guarantees that no
> in-flight or concurrent ioctl can re-enable hardware interrupts, so no
> pending interrupt is left when the driver unbinds.
> 
> Fixes: 671e266835b8 ("ptp: netc: add periodic pulse output support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260720012508.23227-1-wei.fang%40oss.nxp.com
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>   drivers/ptp/ptp_netc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> index 5e381c354d74..3bab86afe8e2 100644
> --- a/drivers/ptp/ptp_netc.c
> +++ b/drivers/ptp/ptp_netc.c
> @@ -1019,9 +1019,9 @@ static void netc_timer_remove(struct pci_dev *pdev)
>   {
>   	struct netc_timer *priv = pci_get_drvdata(pdev);
>   
> +	ptp_clock_unregister(priv->clock);
>   	netc_timer_wr(priv, NETC_TMR_TEMASK, 0);
>   	netc_timer_wr(priv, NETC_TMR_CTRL, 0);
> -	ptp_clock_unregister(priv->clock);
>   	netc_timer_free_msix_irq(priv);
>   	netc_timer_pci_remove(pdev);
>   }

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
