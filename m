Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143CA37A825;
	Sat, 10 Oct 2026 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791660424; cv=none; b=RxbmVw0pyJK3KVK3HmqokdW4wvcgByDeUbAiAFuNufrRjxLHor7+taf2BCteMklN0rvt2gobDOroWou2LNZW15CK87oJu4mHU4BchV5V+PrGQfYPwkpQG4O+7JLzm77zC90DzNh3RHzwbfYGCYVSyLOicaZmm6wXd2Yyqb5rVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791660424; c=relaxed/simple;
	bh=ijzLc0iSOgp9K4VUydWcfjUU5+TkxZUgBTTCYUMJ1z8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AJsviqHwF3QRugHTiS0OfThVx9FTM+Cn28ldObzQvKHXZyfbANUhIPCrgHObXN3t8GGeEASBmSXGICqGFtZ6kFPn/N2/42IUKfpxwv3OvU9/+f7DvkCbimmfmxYJBOgf9W/HgHG86FbaHHDuUOmHH7+c9pLEcgvyvj0lLssgHMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUookF1U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUookF1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA451F00898;
	Sat, 10 Oct 2026 19:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791660422;
	bh=Im3VYt3knGD1k1wiyEV3Lc2lBb8AIAFsUM9O24VQ68U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hUookF1U+62GRHX8Y/h2vOd7Am05e2MTs68gygO9XEMXB2HoD9u3WTT9h7k8usOMH
	 u+0kLZ21QoEslHGELx1+sGdnIIdMAPWsGJ/nWA8KQOAt20NpaC3AdeU52x51VtWoTe
	 uM8SaVhEGhGC+TTsRaI2s1RBnCsCUxStBdhRAWVf2kytQ2u97in5kswTD/U+Iv98vs
	 f6rsErRA8s1Gpe6eQu2RNdVJkvNuqYZ4EuURP2dekLnumyzSccFrTzhjrT786P2NWT
	 iO8vVzyBXo2FZ22DWbGoSVKmPxVzUOXmz6F0TO3SigeWtfVcvIizlof7MtsL/CQFvD
	 dlBTxbHzrikGg==
Subject: Re: [PATCH net v4 2/5] dpll: zl3073x: reject output frequencies with
 too small divisor
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, poros@redhat.com, min.li@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 19:27:01 +0000
Message-ID: <179166042155.434549.16991158418874345163@kernel.org>
In-Reply-To: <20261009192556.272263-3-ivecera@redhat.com>
References: <20261009192556.272263-3-ivecera@redhat.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Kept only because requires_validation=true.
- [Low] The commit message does not say that the new `!freq` check fixes
  a division by zero that firmware can trigger at probe time.

--

dpll: zl3073x: reject output frequencies with too small divisor

This patch makes zl3073x_pin_check_freq() reject output frequencies from
firmware when the resulting divisor is below 2. For the N-pin of an
N-divided output the minimum is 4. The patch also rejects 0 Hz for both
input and output pins.

> diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
> index 18a1bf3103326..4e006ed5950ad 100644
> --- a/drivers/dpll/zl3073x/prop.c
> +++ b/drivers/dpll/zl3073x/prop.c

[ ... ]

> @@ -30,7 +31,7 @@ static bool
>  zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,
>  		       u8 id, u64 freq)
>  {
> -	if (freq > U32_MAX)
> +	if (!freq || freq > U32_MAX)
>  		goto err_inv_freq;

[Severity: Low]
Should the commit message say that this check also fixes a divide error at
probe time?

Before this patch, the output path did:

	if (synth_freq % (u32)freq)

zl3073x_pin_props_get() only skips a supported-frequencies-hz entry when it
equals curr_freq:

	if (freqs[i] == curr_freq)
		continue;
	if (zl3073x_pin_check_freq(zldev, dir, index, freqs[i])) {

The dpll-pin.yaml binding doesn't set a minimum value. So an output pin
entry of 0 in firmware would reach the modulo and oops during probe.

The same check also changes how input pins behave. Before,
zl3073x_ref_freq_factorize(0, ...) succeeded, because 0 / 1 <= U16_MAX and
0 % 1 == 0. That meant 0 Hz was advertised as a supported input frequency.
With this patch it is dropped.

The commit message only says "reject 0 Hz". Could it also describe the
crash fix and the change for input pins?

> @@ -41,18 +42,38 @@ zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,

[ ... ]

>  		/* Check the frequency divides synth frequency */
> -		if (synth_freq % (u32)freq)
> +		div = div_u64_rem(synth_freq, freq, &rem);
> +		if (rem)
> +			goto err_inv_freq;
> +
> +		/* The driver requires an output divisor of at least 2 -
> +		 * below that the hardware bypasses the divider and ignores
> +		 * the pulse width and eSync registers the driver programs.
> +		 * For the N-pin of an N-divided output the effective divisor
> +		 * also includes the N divider (>= 2), so the minimum is 4.
> +		 * For N-divided outputs this is only a necessary condition -
> +		 * whether the frequency can be set also depends on the output
> +		 * divisor shared by both pins, which is checked when the
> +		 * frequency is set.
> +		 */

[Severity: Medium]
Is the "checked when the frequency is set" part true at this commit? The
commit message makes the same claim:

  "For N-divided outputs this is necessary but not sufficient, the rest
   is checked by the frequency set callback."

In zl3073x_dpll_output_pin_frequency_set() in drivers/dpll/zl3073x/dpll.c,
both N-divided branches only reject an N period of zero:

	if (zl3073x_dpll_is_p_pin(pin)) {
		...
		out.esync_n_period = (out.esync_n_period * out.div) / new_div;
		if (!out.esync_n_period)
			return -EINVAL;
		...
	} else {
		...
		out.esync_n_period = div64_u64(synth_freq, frequency * out.div);
		if (!out.esync_n_period)
			return -EINVAL;
	}

Neither branch requires an N divider of at least 2, and neither checks for
a remainder.

For example, take a 1 GHz synth with out.div == 4:

- Requesting 250 MHz on the N-pin passes zl3073x_pin_check_freq(), since
  div 4 >= min_div 4. The setter then programs an N divider of 1.
- Requesting 100 MHz on the N-pin gives esync_n_period == 2, so the pin
  runs at 125 MHz instead of 100 MHz.

Neither request returns an error.

A later patch in this series, "dpll: zl3073x: reject inexact frequencies
for N-divided outputs", appears to add these checks. It uses
div64_u64_rem() and rejects n_period < 2, n_period > U32_MAX and a non-zero
remainder.

Could the series be reordered so the setter checks land first?
Alternatively, could the comment and commit message here be changed to
match what the code does at this point?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009192556.272263-1-ivecera%40redhat.com
