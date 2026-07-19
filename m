Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65EA281369;
	Sun, 19 Jul 2026 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784458125; cv=none; b=Q3Tw4+GjQvSBV9U5MAxdrRN+ynhyUsGpU/0Ka18M61G0f03P0YkLhXBcDfKuvKpVpAYCqsthlB2rR67sEuLoGaRYP5ogEigQrc/LL0KRITYT1G4c24rJwjoGkfO3TTqmlP5lQvmHMT4ZzuJfevwm06aZiki+40a+BZavtJsUW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784458125; c=relaxed/simple;
	bh=Ul27rM4VBWdq30uH1ZU5wRIYlC8Lb94L79RmBrUWZ5I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dmY+o9AW6cRZvZ0euAwdztSdmh0dZPXh3esMujpVobZCZOYePDh8KGK38pBeH/wRtc7kuKYY4pPpjXUqAkIo8qj3UxtzAtIRC7vkK+L9CNytp0xx228jhrrJv2Y2KZlYNvCxMKdtlRT+f/L5QtxVBQieWkRqksKY2OdnvYfDiY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Cwh5VS0W; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Cwh5VS0W"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A2213A0290;
	Sun, 19 Jul 2026 12:48:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784458121; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nPLm1wuV6N2NNDBY6KXLR02DJU5hjEu5TNcghBfdqEY=;
	b=Cwh5VS0WOdHlRwT4T10gHlXF8Tk98++ghnGdu09Uz0LM3/3d5npCeXcVL1N9cDJGUvM0Uj
	6SVwb1kHQUQLdRAHmGSPtKMI0QKekrqwDXXGxw9VcPy8k//TBx6pMjZVL1RgcTJ+9qZq2e
	yeQOYjmbyqOlF6nycndyNKnoMnGdQLMTBQQnZ9RJzowbfuVSwvxSnqrgIjdN1ac18yU5Gp
	MnGuEy3IW137lgREdMZM9+0MVC6HEowaDsGh7GzRm0em6UR+dk+3Bx3Cf1aSscIjs3UV99
	jPCBPU4/GkE7rSeMddnDcI/6zH6UhxKhuD+EcP4XQRS1fgQtz/xfm/HM6IQXWA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Jul 2026 12:48:41 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell
 King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Paolo Valerio
 <pvalerio@redhat.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 13/15] net: macb: read ISR inside bp->lock
 critical section
In-Reply-To: <20260717-macb-context-v4-13-0acbe7f10cdb@bootlin.com>
References: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
 <20260717-macb-context-v4-13-0acbe7f10cdb@bootlin.com>
Message-ID: <0bd7a7be579d55b3e1f99b2d8e6b5abf@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 17.7.2026 21:48, Théo Lebrun wrote:
> The IRQ handler reads ISR register into the `status` stack variable.
> If empty, it early returns. Else, it grabs bp->lock and iterates on
> the status bits.
> 
> We risk a race on spinlock acquire; status might have changed.
> Move the readl(ISR) inside the bp->lock critical section.
> 
> One risk remains with spurious interrupts that would, in addition to
> taking excessive CPU time, also create lock contention. How bad is it?
> Probably not too bad.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 4c94c23d925a..c832b6c1b98c 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2185,13 +2185,14 @@ static irqreturn_t macb_interrupt(int irq, void 
> *dev_id)
>  	struct net_device *netdev = bp->netdev;
>  	u32 status;
> 
> -	status = queue_readl(queue, ISR);
> -
> -	if (unlikely(!status))
> -		return IRQ_NONE;
> -
>  	spin_lock(&bp->lock);
> 
> +	status = queue_readl(queue, ISR);
> +	if (unlikely(!status)) {
> +		spin_unlock(&bp->lock);
> +		return IRQ_NONE;
> +	}
> +
>  	while (status) {
>  		/* close possible race with dev_close */
>  		if (unlikely(!netif_running(netdev))) {

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
