Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67FB3793B0;
	Mon,  5 Oct 2026 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187648; cv=none; b=pokHbGBOCvNglzFsK0Pjf0bjjF7K19/wpsbWna03/niBHSVlEYSyFIKsW8yQD3jGZ+liO6ZIJcxELxbHpVjbgHnmqsRpkloB4SrcBa5ozLaCZdNNRNdZA2GiV0tLRnDtbZEt1wJNSVWKjZ2BFT5iG2csvhPDU5f3X6l4XcW/tt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187648; c=relaxed/simple;
	bh=6zh71r7Pekqk+DuJfsTKUYLgEbP99kCj6zYuylZ7BQI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDHvFiHbRzHSaGN2lHvbDJmBosGk8ozHPuL57/UUxa7AwsLU/9LC4xterA6/Jbf0GbyVHtth9hc6l6kl5mzheV/RwgnA2orrOOgZoxbdyvUh3x9PFcMx4FD7whYggySkdHte9hoNRaukN/h1VwJkbUY9dEM89yhK5KwQuVqcgs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buk1mhH7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buk1mhH7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A8A1F00898;
	Mon,  5 Oct 2026 08:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791187646;
	bh=jZ2Wr3yurVlKrvb7u7xx6x/OkIICaMNFkpoPnRtxfq8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=buk1mhH7gzE6nThCXxHEN/zjWrDvR/pAkD6HDMkNuJ7K3Vbx89WlctoSi44LoNjrS
	 rwHJQbzfzyw0JMW0UtJw0x0Bmncwwy3MQZUrlQprCxXJQkmwQcFCSL5bz+jsuLaqsU
	 8oGQt6Ix2MuworhwKyQRpgRjlziGezN5Fpr8q0d4+cFrvrxxLKUk4o8NFQshdF6MAa
	 LG5obgj771wBXDMjGdCImSudRWUrwEmFyu13HpHMWkXCulpjgw9OTBoOzMb/B191n3
	 rDB/qL60C+cAhLPZJ9O7SfVmCX1Vc5Sr375Ru0X9gdOVWrC3eA/SlP4bKfzPygaZ3o
	 k+sikU2LP870A==
Subject: Re: [PATCH net 1/2] dpll: zl3073x: make embedded sync follow the
 output carrier frequency
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, min.li@microchip.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, kuba@kernel.org,
 Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 08:07:25 +0000
Message-ID: <179118764578.434549.11911030839884571148@kernel.org>
In-Reply-To: <20261001080648.1424172-2-ivecera@redhat.com>
References: <20261001080648.1424172-2-ivecera@redhat.com>
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

- [Medium] In drivers/dpll/zl3073x/dpll.c,
  zl3073x_dpll_output_pin_esync_get() no longer works out the reported…

--

dpll: zl3073x: make embedded sync follow the output carrier frequency

This commit moves the output pin eSync handling into new
zl3073x_out_esync_{is_enabled,enable,disable}() helpers. When the output
divider changes in zl3073x_dpll_output_pin_frequency_set(), it recomputes
the eSync period and width, and it disables eSync when the new carrier is
1 Hz.

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index f2e137475b40f..9eec27331fe3d 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c

[ ... ]

> @@ -864,38 +864,28 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,

[ ... ]

>  	esync->range = esync_freq_ranges;
>  	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
>  
> -	if (zl3073x_out_clock_type_get(out) != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
> -		/* No need to read esync data if it is not enabled */
> +	if (zl3073x_out_esync_is_enabled(out)) {
> +		esync->freq = 1;
> +		esync->pulse = 25;
> +	} else {
>  		esync->freq = 0;
>  		esync->pulse = 0;
> -
> -		return 0;
>  	}
>  
> -	/* Compute esync frequency */
> -	esync->freq = out_freq / out->esync_n_period;
> -
> -	/* By comparing the esync_pulse_width to the half of the pulse width
> -	 * the esync pulse percentage can be determined.
> -	 * Note that half pulse width is in units of half synth cycles, which
> -	 * is why it reduces down to be output_div.
> -	 */
> -	esync->pulse = (50 * out->esync_n_width) / out->div;
> -

[Severity: Medium]
Is it intended that zl3073x_dpll_output_pin_esync_get() now reports fixed
values instead of what is actually programmed in esync_n_period and
esync_n_width?

When the clock type is ESYNC, the getter now always reports freq=1 and
pulse=25, whatever the cached period and width registers contain. The
values can differ from the real signal in at least two cases.

First, zl3073x_out_state_fetch() in out.c loads ESYNC_PERIOD and
ESYNC_WIDTH from the chip at probe and only rejects a zero period:

	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_ESYNC_PERIOD,
			      &out->esync_n_period);
	...
	if (!out->esync_n_period) {

Stale values can carry over. They can come from NVM, or from an older
kernel that changed div without updating esync_n_period, which is the bug
this patch fixes. Take a 1 MHz carrier with esync_n_period = 10000000.
That is really a 0.1 Hz eSync. The old getter reported 0, and the new one
reports 1.

Second, zl3073x_out_esync_enable() in out.h sets:

	out->esync_n_width = out->div / 2;

Its comment notes that resolution is lost when div is odd. With div = 5,
the programmed pulse is 50 * 2 / 5 = 20%. The old getter reported 20, but
the new one reports 25.

The fixed readback also seems to block reprogramming through netlink.
dpll_pin_esync_set() in dpll_netlink.c does:

	if (freq == esync.freq)
		return 0;

So a request for 1 Hz meant to fix a stale period returns success without
calling esync_set(). The registers would only be rewritten by setting 0
and then 1.

In dpll.yaml, esync-frequency and esync-pulse describe the actual embedded
SYNC signal. The input pin getter in the same file only reports 1 after
checking the divider:

	esync->freq = ref->esync_n_div == ZL_REF_ESYNC_DIV_1HZ ? 1 : 0;

Should the output getter keep computing freq and pulse from the cached
esync_n_period, esync_n_width and div? If the change is intended, could
the commit message mention it? Right now it only describes moving code
into helpers, and the values userspace reads back have changed.

>  	return 0;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001080648.1424172-1-ivecera%40redhat.com
