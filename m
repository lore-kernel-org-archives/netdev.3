Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730C14FD289;
	Tue, 29 Sep 2026 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684880; cv=none; b=duQL3MUE8y0AMnopqxWmI/Isn7i2FfY+wWsN1jdpdWIB+NzxwccQ2KqM5D1CEX7r4MqLs+e5UE8n5LBBb6Eo2wWGz0MFoEPVeUqFOKb3g3wb8XxVRShwQMwjffQoRPyeFSRUKCymKs9E+8NcJh7eFLlWpXfyNUbdF9e521uTEnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684880; c=relaxed/simple;
	bh=W/WoswRfBWcd5gfG7FvmUsOtWrI5rXhVfqGXkWZpewk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yl/8bCUADk7Bfptey8u6VfthIOjRs7fDPum03qk64WAWlTdEo1HE+bgLP7VIytuQMIlvnyQ+3jWQmBWyoNEb2B7W/K88US3Kz94rltENT/mtn3uFryUh5+qNo+gqidUGNtCseJyBFOPokuJ0bGR5PdFNGVAfOMktVwPAsV5fo+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RinTuWxQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RinTuWxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F7B1F00893;
	Tue, 29 Sep 2026 12:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790684879;
	bh=HxubKJ9Fm4SMWXN0Le+F38JX4A6BdXE8ZreiDpeO1ug=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RinTuWxQK/2pzhkY16YkD+fIUfvdqaBAjjUZx5flEhjwZ6m49RDhk8f43sUK4uRdd
	 Ah7uYFT50oMgY4EYke9tOD3/5t0GBfntClkW1So6jerCTXk3XgYcthzsMS0MDbotNz
	 r9iN+Hu2BtKMsb9oO11OaFRKNYsu+Yl5WjAu3LQkQ9HqAbZrwUh1JuKUb05Xo9BGQB
	 zgw4tqKUB1nTYlNqx9jEkFZFLQT6Qpk3aS/Fugb4gVBXpquxbOXvDN7VDyCnJW2Jzp
	 w52XkJVf1lmL6IF8KhZ36EE4hPB7QQ25Up/VhkUCaNw3v+9Y3wnzcJPZmN4NbPBJV9
	 vfGv58Fs2v7WA==
Subject: Re: [PATCH net-next v4 02/11] net: dsa: microchip: add the number of
 pins to chip infos
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 12:27:57 +0000
Message-ID: <179068487777.434549.12888526139297751667@kernel.org>
In-Reply-To: <20260925-ksz-perout-v4-2-d675bd21ce49@bootlin.com>
References: <20260925-ksz-perout-v4-2-d675bd21ce49@bootlin.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Intermediate-state regression, fixed later in this series.

--

net: dsa: microchip: add the number of pins to chip infos

This adds an n_pins field to struct ksz_chip_data and sets it to 2 on the
PTP-capable chip entries. ksz_ptp_clock_register() now uses this field
instead of the hardcoded KSZ_PTP_N_GPIO.

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index 47cf397481d5e..33416e59edc73 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> @@ -1053,14 +1053,14 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
>  	ptp_data->caps.do_aux_work	= ksz_ptp_do_aux_work;
>  	ptp_data->caps.enable		= ksz_ptp_enable;
>  	ptp_data->caps.verify		= ksz_ptp_verify_pin;
> -	ptp_data->caps.n_pins		= KSZ_PTP_N_GPIO;
> +	ptp_data->caps.n_pins		= dev->info->n_pins;
>  	ptp_data->caps.n_per_out	= 3;

[Severity: Low]

Does this commit leave the KSZ8463 with zero pins?

The ksz_switch_chips[KSZ8463] entry is not marked ptp_capable, and this
patch does not give it an n_pins value. So dev->info->n_pins is 0 for that
chip.

ksz8463_setup() still registers the PTP clock whenever an IRQ is present,
and it does not check ptp_capable:

drivers/net/dsa/microchip/ksz8.c:ksz8463_setup() {
    ...
	if (dev->irq > 0) {
		...
		ret = ksz_ptp_clock_register(ds);
    ...
}

The KSZ8463 PHC therefore gets caps.n_pins = 0 and no pin descriptors,
while caps.n_per_out is still 3. Before this patch it exposed 2 pins.

With no pins, ptp_find_pin() in ksz_ptp_enable_perout() can never succeed:

	pin = ptp_find_pin(ptp_data->clock, PTP_PF_PEROUT, request->index);
	if (pin < 0)
		return -EINVAL;

As a result, every PTP_CLK_REQ_PEROUT request on the KSZ8463 would return
-EINVAL. The PTP core would also reject PIN_GETFUNC and PIN_SETFUNC.

A later patch in the series fixes this. "net: dsa: microchip: add periodic
output support for the KSZ8463" sets .n_pins = 12 and .n_per_out = 12 for
the KSZ8463, so the problem only affects bisection across the
intermediate commits.

Before this patch, periodic output on the KSZ8463 also used the KSZ9477
register layout (REG_PTP_UNIT_INDEX__4). So the lost capability probably
did not work correctly to begin with.

The commit message says:

    Set it to 2 for all the PTP-capable switches.

Could the commit message mention that the KSZ8463 temporarily loses its
pins? Alternatively, this patch could set .n_pins for the KSZ8463 entry.

>  
>  	ret = ksz_ptp_start_clock(dev);
>  	if (ret)
>  		return ret;
>  
> -	for (i = 0; i < KSZ_PTP_N_GPIO; i++) {
> +	for (i = 0; i < dev->info->n_pins; i++) {
>  		struct ptp_pin_desc *ptp_pin = &ptp_data->pin_config[i];

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-ksz-perout-v4-0-d675bd21ce49%40bootlin.com
