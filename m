Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E563BA232;
	Sat, 10 Oct 2026 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791660422; cv=none; b=aydnKNzbENdoFLDqgMIpNPjWXE7M+51nrJbPrPbfi993ffD5Q+UcvgJcw6iCzQxbNRXHfiz8SdSSIK8qa7Z+e0yKFmGSTgcyEcDl2huHy2nLR/TlFmiKJoqskhSI8VIcSKuCgH6F65VKfKa23oG5ph3Re66z19XpPLnynXwDlro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791660422; c=relaxed/simple;
	bh=8oxBFzyPpQD7aHgj/e4xQeADxGso7MPsg5cVh1/aANU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RUTD5gmTPvuj1xKous1MT+E65wpSmmCkRKmU3tzg9XybI2JeKT/BJGwQ0VTHvffeu8mW4x87MEXlPdWU8CGAvzCiuTcxGJrKqSQ+vzEsX9n2fSwI0FD8xm75KkoT22d9XaZCMq+m8QTe+ZxeeZQa/2r8XpdDhjG6qUEjWDkv2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axAHdrv2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axAHdrv2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5331F000FF;
	Sat, 10 Oct 2026 19:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791660421;
	bh=RTYzQWbOq2I6U646F3ov4k0c0sdmFFlu5hbxBb5Gi6I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=axAHdrv2xCZAWamt4duDH0Od0WiFSVL0U5Urrh/05BkxdCqm6t7Wtr7SSD+9vmJIw
	 iTSwmzjboQ4pAVSDL38hVl3UDgD7Ut/TmkU3xhkk2Br9alT8J451BQlCWF6XprRZvj
	 QvO1d7olVSiprtTRTbGb356cnUiGfVRt6bzI6voW5O+J9Bs8JJmtOfLLibKVBei36b
	 00LmmQa16SovV8FsU08NLI1qQ+2mFVwIAn4ihPC1z/jFbeB2XksQRmkg+K9+2ocE8N
	 09dijX+lBJY9MnoxqXasgG9uGxmNlAqFpqb/yS/1cRH74/b5TbS8eUehOS8ty1NVOT
	 9b8XC7gNAtBXQ==
Subject: Re: [PATCH net v4 1/5] dpll: zl3073x: do not offer 0 Hz as a
 supported pin frequency
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, poros@redhat.com, min.li@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 19:27:00 +0000
Message-ID: <179166042014.434549.4178521508120779611@kernel.org>
In-Reply-To: <20261009192556.272263-2-ivecera@redhat.com>
References: <20261009192556.272263-2-ivecera@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit, the subject says 0 Hz is no longer offered,
  but zl3073x_pin_props_get() (drivers/dpll/zl3073x/prop.c) only filters…

--

dpll: zl3073x: do not offer 0 Hz as a supported pin frequency

This patch stops zl3073x_pin_props_get() from putting the current pin
frequency into the supported list when it reads back as 0 Hz. If the
list ends up empty, it is freed and not published, because the DPLL
core rejects an empty non-NULL list.

> diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
> index ac9d41d0f978e..18a1bf3103326 100644
> --- a/drivers/dpll/zl3073x/prop.c
> +++ b/drivers/dpll/zl3073x/prop.c
> @@ -295,13 +295,20 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
>  		goto err_alloc_ranges;
>  	}
>  
> -	/* Start with current frequency at index 0 */
> -	ranges[0] = (struct dpll_pin_frequency)DPLL_PIN_FREQUENCY(curr_freq);
> +	/* Start with current frequency at index 0. A sub-Hz frequency is
> +	 * read back as 0 Hz and cannot be set, so it is not offered.
> +	 */
> +	j = 0;
> +	if (curr_freq) {
> +		struct dpll_pin_frequency freq = DPLL_PIN_FREQUENCY(curr_freq);
> +
> +		ranges[j++] = freq;
> +	}
>  
>  	/* Add frequencies from firmware node, skipping current frequency
>  	 * and filtering out frequencies not representable by device
>  	 */
> -	for (i = 0, j = 1; i < num_freqs; i++) {
> +	for (i = 0; i < num_freqs; i++) {
>  		struct dpll_pin_frequency freq = DPLL_PIN_FREQUENCY(freqs[i]);
>  
>  		if (freqs[i] == curr_freq)

[Severity: Medium]
Can 0 Hz still end up offered through the firmware list?

The subject says 0 Hz is no longer offered. However, only a 0 Hz current
frequency is filtered.

Suppose the "supported-frequencies-hz" property has a 0 entry and
curr_freq is nonzero. That entry is not skipped by the
freqs[i] == curr_freq check. It goes on to zl3073x_pin_check_freq(),
which has no zero check at this commit:

drivers/dpll/zl3073x/prop.c:zl3073x_pin_check_freq() {
	if (freq > U32_MAX)
		goto err_inv_freq;
    ...
		/* Check the frequency divides synth frequency */
		if (synth_freq % (u32)freq)
			goto err_inv_freq;
    ...
}

On an output pin, does this divide by zero during probe?

On an input pin, zl3073x_ref_freq_factorize(0, ...) succeeds on the first
base frequency of 1. Here 0 / 1 = 0 <= U16_MAX and 0 % 1 == 0, so 0 Hz is
published as supported. It could then be programmed with base 1 and
multiplier 0.

The dpll-pin.yaml binding sets no minimum for supported-frequencies-hz,
so the schema does not reject 0.

A later patch in this series, "dpll: zl3073x: reject output frequencies
with too small divisor", changes the first check in
zl3073x_pin_check_freq() to:

	if (!freq || freq > U32_MAX)
		goto err_inv_freq;

That fixes this by the end of the series. At this intermediate commit,
though, the 0 Hz case is still reachable from firmware.

Would it make sense to move the !freq check into this patch? Bisection
would then not land on a kernel that can still divide by zero here.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009192556.272263-1-ivecera%40redhat.com
