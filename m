Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691434E56F3;
	Thu,  8 Oct 2026 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473506; cv=none; b=Mm+TynMzHJf77QnAVIdDpeliAKXU5CNYO5DdGLbPIOKf/s9uwusbgL+v/Ef+cV3qxK5VURU+Ul9hM80A5sybBX+2SkuAyzKVu5/hlG+LN+tddY6x9EejLaUPPC78klXRrTM8C9qgJcoiGU2bFxYyg7D3FY6HHtnlcWoM+xkVxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473506; c=relaxed/simple;
	bh=s7JYSSbolPjcLrEe+uyU4I5N0qa7rT56REy8Bv620ok=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=McwJXSViZuMKimVJJYWOSgLGqfzT/KpeKlPJz8hS1PN7bdK3klqNtvAuieVt5Whop0meBJ0i4koI8RE9FKA6cjD1VP83kg+pxUrrmKHo6vD18rIu/RzmutEyJX5LbZA5XKhNt7I59vRmArbBZd6rDD2TarHnJMsF4Ko+szSJ9kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEHXPD2s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEHXPD2s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875BA1F000FF;
	Thu,  8 Oct 2026 15:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791473505;
	bh=ZxfDaV7DGTAgP65N6JD5OKXuET1MCkNz3egCKmQS+Qw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EEHXPD2sf7IOrGjPekQUHHZG2BcBTTky+ncsKH7ArHp8Jia0QEafB+AI8+WC3BnE4
	 IIZ5xioxAwV6myNuYau6XKFgW83VxgrKhIqO2MXgNumuG1ACvyLpaT09Sg+B+z6771
	 y0ra2L5DGRfYg0X+/SUVk5OicOtRhDIY7RepQ+xJi4YSdcRAKBG16+KVpvcqr4AZEG
	 I89IP5HyLpnUbbFNHpKOszORDoZLEhq90Nl3b6RHJIXygctNO1rKIgaGBR9703L4OM
	 ZQ+PELBn5TUYE8EwmYw83fSNPnZMdVsYfb1P6VwFGn4hDwvqHFibcbxj52TvUMwNNQ
	 p69xjnhTMu4ow==
Subject: Re: [PATCH net v3 3/4] dpll: zl3073x: reject inexact frequencies for
 N-divided outputs
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, min.li@microchip.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, kuba@kernel.org,
 Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 15:31:44 +0000
Message-ID: <179147350412.434549.10496013315426964523@kernel.org>
In-Reply-To: <20261006153116.347497-4-ivecera@redhat.com>
References: <20261006153116.347497-4-ivecera@redhat.com>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In the P-pin branch of zl3073x_dpll_output_pin_frequency_set()
  (drivers/dpll/zl3073x/dpll.c:1016-1031), the patch widens the product…

Pre-existing issues:
- [High] A privileged netlink request for frequency 0 can reach the
  unchecked division `new_div = synth_freq / (u32)frequency;` in…
- [Low] The four NL_SET_ERR_MSG_FMT() calls this patch adds to
  zl3073x_dpll_output_pin_frequency_set() (drivers/dpll/zl3073x/dpll.c,…

--

dpll: zl3073x: reject inexact frequencies for N-divided outputs

This patch changes zl3073x_dpll_output_pin_frequency_set() to check the
division remainder when it computes esync_n_period for N-divided outputs.
A request is rejected if it does not divide evenly or if the N-pin
frequency would not stay below the P-pin frequency. Both failure cases
get new extack messages.

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 7c997966c3c33..65107b4cc4f82 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -1007,15 +1007,28 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,

[Severity: High]
This is a pre-existing issue, but can a frequency of 0 reach the division
at the top of zl3073x_dpll_output_pin_frequency_set()?

	new_div = synth_freq / (u32)frequency;

zl3073x_dev_output_pin_freq_get() uses integer division, so a sub-Hz
output reads back as 0 Hz. For example, with a 600 MHz synth, an N-divided
output, div=60 and esync_n_period=20000000, N is 0.5 Hz and is reported
as 0. zl3073x_out_state_fetch() only rejects zero divisors.

zl3073x_pin_props_get() in drivers/dpll/zl3073x/prop.c then always
registers the current frequency as supported. This bypasses the !freq
check in zl3073x_pin_check_freq():

	ranges[0] = (struct dpll_pin_frequency)DPLL_PIN_FREQUENCY(curr_freq);

Suppose firmware also lists 1 Hz for that N-pin. A CAP_NET_ADMIN user can
set the N-pin to 1 Hz and then request 0 Hz:

dpll_pin_freq_set()
  dpll_pin_is_freq_supported(0)   -> true, ranges[0] is {0, 0}
  freq != old_freq (1)
  ops->frequency_set(..., 0, ...)
    zl3073x_dpll_output_pin_frequency_set()
      synth_freq / (u32)0

The division happens before any of the new remainder checks run.

There may be a similar path through a non N-divided output with
div > synth_freq, where P reads as 0 Hz. The DPLL_A_PIN_FREQUENCY policy
is a plain NLA_U64 with no range. This code is unchanged at the end of
the series.

Would rejecting a zero frequency here, or in dpll_pin_freq_set(), make
sense?

>  
>  	if (zl3073x_dpll_is_p_pin(pin)) {

[ ... ]

> -		out.esync_n_period = (out.esync_n_period * out.div) / new_div;
> -		if (!out.esync_n_period)
> +		u64 prod = mul_u32_u32(out.esync_n_period, out.div);
> +		u32 rem;
> +
> +		out.esync_n_period = div_u64_rem(prod, new_div, &rem);

[Severity: Medium]
Is the 64-bit quotient silently truncated when it is stored in the u32
out.esync_n_period?

mul_u32_u32() widens prod, but the result of div_u64_rem() is narrowed
before the rem and < 2 checks run. Those checks never see the upper bits.

For example, take a 600 MHz synth with div=12 and
esync_n_period=0x80000001 read from hardware (P=50 MHz, N about 0.023 Hz).
Requesting P=100 MHz gives new_div=6:

    prod     = 0x80000001 * 12 = 0x60000000C
    quotient = 0x60000000C / 6 = 0x100000002, rem = 0
    (u32)    = 2

Both checks pass, and zl3073x_out_state_set() commits div=6 and
esync_n_period=2. The N-pin then jumps from about 0.023 Hz to 50 MHz.
The commit message says this patch prevents that kind of N-pin shift.

zl3073x_out_state_fetch() only rejects a zero esync_n_period, so it
accepts this state from hardware. The driver's own N-pin path cannot
create it, but EEPROM or firmware can.

Could the quotient be kept in a u64 temporary, with values above U32_MAX
rejected before the assignment? This code is unchanged at the end of the
series.

> +		if (rem != 0) {
> +			NL_SET_ERR_MSG_FMT(extack,
> +					   "OUT%uN freq must divide OUT%uP freq",
> +					   out_id, out_id);
>  			return -EINVAL;
> +		}

[Severity: Low]
This isn't a bug introduced by this patch, but do the new extack messages
(here and in the N-pin branch) ever reach userspace?

The only caller, dpll_pin_freq_set(), sets its own message whenever
frequency_set() fails:

drivers/dpll/dpll_netlink.c:dpll_pin_freq_set() {
    ...
	if (ret) {
		NL_SET_ERR_MSG_FMT(extack,
				   "frequency set failed for dpll_id:%u",
				   dpll->id);
		return ret;
	}
    ...
}

NL_SET_ERR_MSG_FMT() writes into the same extack->_msg_buf and points
extack->_msg at it again. Userspace therefore gets only the generic
message. The driver text shows up only in the netlink_extack tracepoint.
The core still overwrites the message at the end of the series.

A smaller point: in the P-pin branch the remainder check runs before the
< 2 check. If the requested P frequency is below the current N frequency
(new_div > esync_n_period * div), the quotient is 0 and rem equals prod.
That case gets "must divide" instead of "must be less than". Would
checking esync_n_period < 2 first give the more accurate message?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006153116.347497-1-ivecera%40redhat.com
