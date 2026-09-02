Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9164AA3F8;
	Wed,  2 Sep 2026 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366428; cv=none; b=GlxGHQueEegKDnNUnMZHEhLjyL2OasUTvsvN3/qY1B6xsG6XV+eh7MCphL8bORmgHwyUGaDSkrZAm6BBs5KeEAIAYpVK7Fr4nHnYWuUf7vAhjULMkwvn8dTGsNigAh9FGQtuVtnGXitqa81pOwsNEOomYO3rWaEWP4yAu4GDkb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366428; c=relaxed/simple;
	bh=w6r4Qb0mWeKgaRRewTm4v1gRBZhMkM/4AdiCSSrAfAM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oSAjVgv1PnGc3oygelOhr/BWJXQQnu1mHJCoF/bZvKY6VYBqEuJPxSckjF8UkSMQZUZ9+DiwO1gUB3QcbO5JDlBIgP3fm0F8wpHaDM2CdEOfp0HT6i6c52yY4N+jLh4WMIid5LmV90ae8qKyiqfwuMUZrlWV3yN48Wv81scJmSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTS8f7at; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTS8f7at"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E2E1F00A3A;
	Wed,  2 Sep 2026 16:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788366427;
	bh=Bd6CakqII8/k1Odjog2qnOhAf0OMvQXecu8oMIMJccg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dTS8f7atlP3Y/P9qQHtkQl6Fk3FRMmktpPwVx+8PIeK2TNeO9Kax95X4QcXWFb9nz
	 XhmUAHcKdQJBvsCx6FnnHIgX00Y96c2ba4Jd0mDfvtLtW2l55AtNUJsdS/FRJ3YKCd
	 v4OO+0lyisULNtF9kdDwnEgWkbC6yKc0bmard/6nMfPDFtB63+gAxQ80VMixbK8U+Q
	 +DDtxkszfRaMLVseqK7DFDFgcRrHagbKqgU0H3e6A9lZF7fO/P+h7vGvAf3K/pwfEg
	 +G3Yp50IJcAVCTesK0VanJqKZ58AqlG41qfAiX8hj6xxPe6cRiY0YMPrqL5ZWbKBYi
	 59R7Ok+t8gzWw==
Subject: Re: [net-next,05/10] net: dsa: microchip: extract ptp_get_pin
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 02 Sep 2026 16:27:05 +0000
Message-ID: <178836642589.3394541.5426419758691749867@kernel.org>
In-Reply-To: <20260831-ksz-perout-v1-5-14202db763b3@bootlin.com>
References: <20260831-ksz-perout-v1-5-14202db763b3@bootlin.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] PTP periodic-output/pin capabilities are silently zeroed for
  most PTP-capable KSZ/LAN switches.

--

net: dsa: microchip: extract ptp_get_pin

This patch splits the periodic output pin selection out of
ksz_ptp_enable_perout() into a new ksz_ptp_get_pin() helper, so that an
upcoming ksz8463_ptp_enable_perout() can reuse the same algorithm. No
functional change is intended by this patch itself.

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index ea22601f6b26b..f97ea9d69ebc5 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> @@ -183,17 +183,11 @@ static int ksz_ptp_configure_perout(struct ksz_device *dev,
>  	return 0;
>  }
>  
> -static int ksz_ptp_enable_perout(struct ksz_device *dev,
> -				 struct ptp_perout_request const *request,
> -				 int on)
> +static int ksz_ptp_get_pin(struct ksz_device *dev,
> +			   struct ptp_perout_request const *request)
>  {
>  	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
> -	u64 req_pulse_width_ns;
> -	u64 cycle_width_ns;
> -	u64 pulse_width_ns;
> -	int pin = 0;
> -	u32 data32;
> -	int ret;
> +	int pin;
>  
>  	if (request->flags & ~PTP_PEROUT_DUTY_CYCLE)
>  		return -EOPNOTSUPP;
> @@ -206,6 +200,25 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
>  	if (pin < 0)
>  		return -EINVAL;
>  
> +	return pin;
> +}

[Severity: High]
The pin selection moved here still relies on ptp_find_pin():

drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_get_pin() {
	pin = ptp_find_pin(ptp_data->clock, PTP_PF_PEROUT, request->index);
	if (pin < 0)
		return -EINVAL;
}

Earlier patches in this series ("add the number of pins to chip infos" and
"add the number of periodic signals to chip infos") replaced the previously
unconditional values in ksz_ptp_set_caps() with per-chip descriptor fields:

	ptp_data->caps.n_pins		= dev->info->n_pins;
	ptp_data->caps.n_per_out	= dev->info->n_per_out;

Before the series these were caps.n_pins = KSZ_PTP_N_GPIO (2) and
caps.n_per_out = 3 for every ptp_capable switch.

At this commit, only the KSZ8563 entry in ksz_switch_chips[] sets the new
members (.n_pins = 2, .n_per_out = 3). The other entries with
.ptp_capable = true - KSZ9477, KSZ9563, KSZ8567, KSZ9567, LAN9370, LAN9371,
LAN9372, LAN9373 and LAN9374 - leave both fields zero-initialized.

Can periodic output still work on those switches? With n_per_out == 0,
ptp_perout_request() in drivers/ptp/ptp_chardev.c rejects every request:

	if (perout->index >= ops->n_per_out)
		return -EINVAL;

and with n_pins == 0 the loop in ksz_ptp_clock_register() initializes no pin
descriptor at all:

	for (i = 0; i < dev->info->n_pins; i++) {
		struct ptp_pin_desc *ptp_pin = &ptp_data->pin_config[i];
		...
	}

so PTP_PIN_SETFUNC cannot address any pin and the ptp_find_pin() call above
can never succeed on those chips.

Should every .ptp_capable descriptor carry its previous .n_pins = 2 and
.n_per_out = 3 values? The later patch adding KSZ8463 periodic output
support only fills in the KSZ8463 entry, so the other families appear to
remain without pins and periodic outputs after the whole series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-ksz-perout-v1-0-14202db763b3%40bootlin.com
