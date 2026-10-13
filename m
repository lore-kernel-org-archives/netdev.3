Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A5B4FE2F1;
	Tue, 13 Oct 2026 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899687; cv=none; b=XfQQ66Z3xFeR0yAC8zsfOklJXxBY0Co0iiQdNPHfRKEFv30y74zaGDCaTaSHfbTSIb5n7rnmghV0u0jFJ25rHMbLtM1AK6FZl0oHY5igGGKHTofMxnQtd2ghxgqFHgsqPtfiEJHZAYbKwMIwIpoqkUEqzUh53wko9Equi6u6Zyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899687; c=relaxed/simple;
	bh=3PtGvoeT9m7Y4DmAr46TMvrMB44lIaxu8GMYoaFQUlI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LzznRXlYYa0qbXZZTrr0Ly8u36fnfvUois3jE6vsAnJL4FhaziWhFAglaltbDMLBUQ3/E76TwIjLE7TaHg65O9mYFthsUEmga8SWWBsmhK6d3UQm5GeMVeb2R9okZt/jL8VOWrAKV7R2/P8ma4ic3ZGnS3PUMvwHARkGNYeoQNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=vkOnxMQc; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="vkOnxMQc"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DCEADA05A6;
	Tue, 13 Oct 2026 15:54:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791899683; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ggmQ0VJqPDmKU8eTBEH1GzV2i54bDKySbMFuZrvZpi4=;
	b=vkOnxMQck/dOnXagzX8Ga0MOiUAgYvpOFLSOrP+DkchS9G+w+MDytLH6U4cJWPCGV1AOXh
	PAANUVjl101XGVbn1SJc/PlyNlFY55xrnmUJypRhX3FlCvWKIzAgMtgMz9q0cNGstfbYxK
	6a6Cu8KG8gyIjhH9F3JSgLrsEsLoDTt3yfpqWwPUu0QDujBOlQU6whTP0RpKDtm2eZvaR/
	CzMKLUT/FD9XFkRUDw+7qXK7s4a3ALqBXZHiHleINTlH4e0UtX2W6VQL3XGCHtRQA/EvwH
	8+RpprrfsyjzNzFD37PNE34LtGocr1snERmsS+AqaRFsF6qhSFp7lMbUeY0ZOA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Oct 2026 15:54:41 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell
 King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paolo Valerio <pvalerio@redhat.com>, Vladimir
 Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 stable+noautosel@kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v11 1/9] net: macb: close race between NAPI polls
 & ndo_stop
In-Reply-To: <20261013-macb-context-v11-1-b27785167566@bootlin.com>
References: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
 <20261013-macb-context-v11-1-b27785167566@bootlin.com>
Message-ID: <09659ad051e83174f82ecd74a4c9a49f@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 13.10.2026 15:16, Théo Lebrun wrote:
> In ndo_close, we call napi_disable() then free the ring buffers
> queue->rx_ring|tx_ring. In the NAPI poll functions, after
> napi_complete_done() we might enable interrupts and might re-check the
> next ring buffer slot.
> 
> This is a use-after-free race on our ring buffers because 
> napi_disable()
> only waits for napi_complete_done() to return, it does not wait for
> NAPI poll functions to finish.
> 
> The poll function sequence must stay as-is, see commit 0bf476fc3624
> ("net: macb: Fix lost RX packet wakeup race in NAPI receive") which
> explains why the sequence must be napi_complete_done() -> arm IRQs
> -> re-check ring slot.
> 
> Fix by waiting for full end of NAPI poll functions using
> synchronize_net() in our ndo_close implementation.
> 
> This bug has never been reproduced and was reported by Sashiko. The
> chances of facing it in practice sound tiny: it needs a system without
> any phylink attached, running PREEMPT_RT and with a kernel preemption
> on the NAPI poll at the right instant.
> 
> We fix it here before introducing context swapping, which is another
> place where the race could appear (and Sashiko complains on this
> series).
> 
> Fixes: 138badbc21a0 ("net: macb: use NAPI for TX completion path")
> Fixes: 1900e30d0ef7 ("net: macb: simplify/cleanup NAPI reschedule 
> checking")
> Cc: stable+noautosel@kernel.org  # too unlikely and never reported by 
> users
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001-macb-context-v10-0-beb541bbb7df%40bootlin.com?part=7
> Link: 
> https://lore.kernel.org/all/179115680572.434549.1016291990685937691@kernel.org/
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 020a47353d01..d414d00d93ce 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2059,6 +2059,12 @@ static void macb_quiesce_start(struct macb *bp)
>  		napi_disable(&queue->napi_tx);
>  	}
> 
> +	/* NAPI instances still access Rx/Tx rings after their
> +	 * napi_complete_done() calls! Callers to macb_quiesce_start()
> +	 * free rings, so wait for all NAPI handlers to be done.
> +	 */
> +	synchronize_net();
> +
>  	/* Must be done after napi_tx is disabled: its completion re-arms
>  	 * the LPI timer.
>  	 */

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
