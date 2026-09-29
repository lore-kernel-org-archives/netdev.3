Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B245221F1;
	Tue, 29 Sep 2026 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684882; cv=none; b=fRIegZziah1dxsRO4bV9XxWHo26COokEd5YmgIBrZoJeafjhe7fFjSeZLyaKnGBfA42go4co6YsDtvDua+MWG3W6NnByPjK6KuxNyn/3vkCQM5SDnpLnljf33b7J5SZHKLGNArg7UJtfouxBvEotEoLqANPRP7CVnem7f6JrE+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684882; c=relaxed/simple;
	bh=zyvAPNhrkzo5vrJDdn65bK60T5OuaXCWtGIDAds7nnA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lLRpg+S753jP4m8G78FLppZ1XNw80YBD7f1AaBUEQGVKSxppl8ebs3AZJOC0mTMg5ExlNyb4BDwtrdgYcLz4OcobFMDFQXVTHB755QFqQ5nitrLX7OpBMdw/o5N1miuwINVXlq6+QZd+oFgSNoJ/bQHVNW441tVsXE+zBMcuMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9zjoEQh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9zjoEQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9143F1F000FF;
	Tue, 29 Sep 2026 12:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790684880;
	bh=+ejDH2vIKhJq7ZGFESPNBFaoCF+xqNB9QEBkFJpmYPM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I9zjoEQhim1ezDfp8SfBTfdviR0OiPxWlqD/ieIYhr37LvoyOnwChBHBRbGRHsbi+
	 jOe3H7VzNoselyVmCdIleZqZ/7rJX79g2Q7Q2TtMCS4Q+IZxns/Rco8APVGM1maJvy
	 cGWUiy6u1+LZjT66SLGuC09ZKtCHnroKno/f44/fmzRjTxUv9vpCjnw1tlGhk1kmeC
	 W2xgwZruv5qRmOZ7FvndlpUCx8htlrIqy0Rdw+Vdcpmjf1lB13BJ61VL+GJniAR0MP
	 44gmF0LWf53qDO0sWFw6OSh3UVkQFLl9qHJ+21nxJcemRzT8MxbCC0Al8+YikDYgoQ
	 zKkVspo8PNExQ==
Subject: Re: [PATCH net-next v4 03/11] net: dsa: microchip: add the number of
 periodic signals to chip infos
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 12:27:59 +0000
Message-ID: <179068487918.434549.2890359979860089796@kernel.org>
In-Reply-To: <20260925-ksz-perout-v4-3-d675bd21ce49@bootlin.com>
References: <20260925-ksz-perout-v4-3-d675bd21ce49@bootlin.com>
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

- [Low] This patch makes KSZ8463 advertise zero periodic outputs until
  the last patch in the series fixes it.

--

net: dsa: microchip: add the number of periodic signals to chip infos

This commit adds an n_per_out field to struct ksz_chip_data. It sets the
field to 3 for the PTP-capable switches in ksz_switch_chips[], and
ksz_ptp_clock_register() now uses it in place of the hardcoded value of 3.

[ ... ]

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index 33416e59edc73..84c799959aaab 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> @@ -1054,7 +1054,7 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
>  	ptp_data->caps.enable		= ksz_ptp_enable;
>  	ptp_data->caps.verify		= ksz_ptp_verify_pin;
>  	ptp_data->caps.n_pins		= dev->info->n_pins;
> -	ptp_data->caps.n_per_out	= 3;
> +	ptp_data->caps.n_per_out	= dev->info->n_per_out;

[Severity: Low]
Does this make KSZ8463 advertise zero periodic outputs at this commit?

The ksz_switch_chips[KSZ8463] entry in ksz_common.c gets no .n_per_out
here, so the field is 0. KSZ8463 still registers a PHC whenever an IRQ is
present, and ksz8463_setup() never checks ptp_capable:

drivers/net/dsa/microchip/ksz8.c:ksz8463_setup() {
    ...
	if (dev->irq > 0) {
		...
		ret = ksz8463_ptp_irq_setup(ds);
		...
		ret = ksz_ptp_clock_register(ds);
    ...
}

Before this patch, the KSZ8463 PHC reported n_per_out = 3. After it, the
PHC reports 0 in n_periodic_outputs and PTP_CLOCK_GETCAPS. As a result,
ptp_perout_request() rejects every PTP_PEROUT_REQUEST index.

The commit message says KSZ8463 can produce 12 periodic signals, but
KSZ8463 is the only chip that registers a PHC here and is left at 0. The
earlier patch "net: dsa: microchip: add the number of pins to chip infos"
also leaves KSZ8463 at n_pins = 0.

The last patch in the series, "net: dsa: microchip: add periodic output
support for the KSZ8463", adds .n_pins = 12 and .n_per_out = 12 to the
KSZ8463 entry. The final tree is correct, so this only affects bisection
through the intermediate commits.

Could this patch set .n_per_out for KSZ8463 so the intermediate commits
keep the previous behaviour?

>  
>  	ret = ksz_ptp_start_clock(dev);
>  	if (ret)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-ksz-perout-v4-0-d675bd21ce49%40bootlin.com
