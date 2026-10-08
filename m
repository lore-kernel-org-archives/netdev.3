Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB3A4E5351;
	Thu,  8 Oct 2026 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473505; cv=none; b=Qk5SR8HrZqw27fic6QQyN4anTsRfSfk9kUEOc3hJ5vTTDcRo6aJi+BrZNJCGtq3p3ukKOIUIuy970jc8tMr+YPpD5xs6TEpPL6L/bNg+leYaQi1UBNnVwC/fWgibqSERt36+NpOPR/YbyPDUuP6JLTGegdrHP5YCSZRtD+dKc+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473505; c=relaxed/simple;
	bh=X5loojw06w0sU6yLH3fOJYJNruDkIhesFsHM3Q1KBCQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pe8QQViDu7PwKFKvpGLWoLJmByXJEnP3AXCkpBRN27GoNWrCAJofdDUPdTY4h1bBtACVHUFqetd/OjxvpioGmKfNQ6kyklvnoaNyHSUKaiMpS7JWM4aqx+XUUc5MgyENVgEkxZolOgb+F9YV+nT0gRLsLb7xavEYLlZot/Zki0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKgazAWk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKgazAWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CE41F00893;
	Thu,  8 Oct 2026 15:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791473503;
	bh=Y9+/yEyZ3mZZLuduONgiO0HVnWiQmszYLef6wC9SfWk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VKgazAWk9WJBTuivHzk5WUsYEb4g1rfaDzTRVjkTOZPLcHftPzAmbHzWqUdtCQFIB
	 JuF9BvZ3DYy6qj/MSn8z5r5xnnUZGOsK1Ay30vvDhh4lvRoN5DTQw8Bzg5I8UGz+rN
	 Rb0zuUdegmnu2g6M/uYOxCb3kjYRdoGEqKdYqQgVDTcU+6XJMi2j5DwHf8U6mopYIY
	 2sI3TSLF9UzPKs+Ob2KILa8Fekc4DmZZX92jvHYDBh3+aY509FpWtqVTaoByuFzmd9
	 PwGFC7pKz+G1MMf0Wsth5EOSxCW6uWHZlFwFzjushvImjHcXZ/UZHr/XBVMmdNEVWW
	 YhqorBHkOuFkw==
Subject: Re: [PATCH net v3 2/4] dpll: zl3073x: make embedded sync follow the
 output carrier frequency
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, min.li@microchip.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, kuba@kernel.org,
 Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 15:31:42 +0000
Message-ID: <179147350298.434549.8122554224626691119@kernel.org>
In-Reply-To: <20261006153116.347497-3-ivecera@redhat.com>
References: <20261006153116.347497-3-ivecera@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] zl3073x_dpll_output_pin_esync_get()
  (drivers/dpll/zl3073x/dpll.c) now returns esync->freq = 1 and…
- [Medium] The fix for the 'stuck-on' eSync only works when the driver's
  own frequency_set() moves the carrier to 1 Hz.

--

dpll: zl3073x: make embedded sync follow the output carrier frequency

This patch moves the eSync handling into zl3073x_out_esync_{is_enabled,
enable,disable}() helpers and uses them from the esync get/set callbacks.
On non-N-divided outputs, a frequency change now recomputes the eSync
period and width, or disables eSync when the new carrier is 1 Hz.
esync_get() now reports a nominal 1 Hz / 25% whenever the clock type is
ESYNC.

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index f2e137475b40f..7c997966c3c33 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c

[ ... ]

> @@ -864,38 +864,28 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
>  	 * for N-division is also used for the esync divider so both cannot
>  	 * be used.
>  	 */
> -	if (zl3073x_out_is_ndiv(out))
> +	if (zl3073x_out_is_ndiv(out) || !pin->esync_control)
>  		return -EOPNOTSUPP;
>  
>  	/* Get attached synth frequency */
>  	synth = zl3073x_synth_state_get(zldev, zl3073x_out_synth_get(out));
>  	synth_freq = zl3073x_synth_freq_get(synth);
> -	out_freq = synth_freq / out->div;
>  
> -	if (!pin->esync_control || out_freq <= 1)
> +	/* The esync is not supported for 1 Hz base frequency */
> +	if (synth_freq / out->div <= 1)
>  		return -EOPNOTSUPP;

[Severity: Medium]
Can eSync still get stuck on if the output already has the ESYNC clock
type on a 1 Hz carrier when the driver probes?

The commit message mentions configurations "left in flash or by an older
kernel". zl3073x_out_state_fetch() keeps the mode register exactly as it
reads it from the device. So this state can exist without the driver's
own frequency_set() ever having run.

In that case this check returns -EOPNOTSUPP even though eSync is enabled.
dpll_pin_esync_set() then returns before it reaches the driver's disable
path:

drivers/dpll/dpll_netlink.c:dpll_pin_esync_set() {
    ...
	ret = ops->esync_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
			     dpll_priv(dpll), &esync, extack);
	if (ret) {
		NL_SET_ERR_MSG(extack, "unable to get current embedded sync frequency value");
		return ret;
	}
    ...
}

The new disable branch in zl3073x_dpll_output_pin_frequency_set() can't
be reached either. The core short-circuits a request for 1 Hz on a pin
that is already at 1 Hz:

drivers/dpll/dpll_netlink.c:dpll_pin_freq_set() {
    ...
	if (freq == old_freq)
		return 0;
    ...
}

The only escape seems to be: move the pin to another supported frequency,
disable eSync, then go back to 1 Hz. That doesn't work if 1 Hz is the
only frequency the pin supports.

Could the driver clear the ESYNC clock type at fetch time when the carrier
is 1 Hz or less? Alternatively, esync_get() could report an enabled eSync
so that it can be turned off.

>  
>  	esync->range = esync_freq_ranges;
>  	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
>  
> -	if (zl3073x_out_clock_type_get(out) != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
> -		/* No need to read esync data if it is not enabled */
> +	if (zl3073x_out_esync_is_enabled(out)) {
> +		esync->freq = 1;
> +		esync->pulse = 25;

[Severity: Medium]
Does reporting a fixed 1 Hz here stop the core from correcting a
mismatched eSync?

dpll_pin_esync_set() treats the esync_get() result as the current
hardware state, and it skips the driver callback when the values match:

drivers/dpll/dpll_netlink.c:dpll_pin_esync_set() {
    ...
	if (freq == esync.freq)
		return 0;
    ...
}

zl3073x_out_state_fetch() imports whatever eSync period and width the
device holds and doesn't normalise them. For example, an older kernel
might have moved the carrier from 10 MHz to 20 MHz and left the period at
10000000. The real eSync is then 2 Hz.

Before this patch the getter reported 2 in that case. A request for 1 Hz
therefore reached zl3073x_dpll_output_pin_esync_set(), which reprogrammed
the period and width.

With this patch the getter reports 1. The same request returns success,
but the hardware keeps the wrong period. The only workaround is to set 0
and then 1, and nothing in the reported state tells the user that this
is needed.

The reported pulse can also differ from the programmed width.
zl3073x_out_esync_enable() does:

	out->esync_n_width = out->div / 2;

With an odd divider the real duty cycle is below 25%, for example about
16.7% for div=3. frequency_set() now writes that width on every carrier
change while eSync is on, but the getter still reports 25.

Documentation/driver-api/dpll.rst describes DPLL_A_PIN_ESYNC_FREQUENCY as
the "current Embedded SYNC frequency". In the same file,
zl3073x_dpll_input_pin_esync_get() reports 1 Hz only when
ref->esync_n_div really holds ZL_REF_ESYNC_DIV_1HZ.

The commit message mentions the nominal reporting. Should it also say
that a 1 Hz set can no longer fix a mismatched eSync? Or could the getter
keep deriving freq and pulse from esync_n_period and esync_n_width?

>  	} else {
>  		esync->freq = 0;
>  		esync->pulse = 0;
> -
> -		return 0;
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006153116.347497-1-ivecera%40redhat.com
