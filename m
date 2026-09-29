Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E2C5226A7;
	Tue, 29 Sep 2026 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684884; cv=none; b=Y4WMUgfUa95U0y695nmrL6g7apRHcv8nH+FJ1tg8lyuwGn8IOLIooTgPwFdcxYYRHCoa4swTBbfJ92D9BTY5Ybvd11XRhagcGnACSH85yGbywXP6vBUbeG8mhY/RFHJnuyJq/Xw9cifo9Gq9ZaxsFiGbotjEWKOQTOBPHI5Swvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684884; c=relaxed/simple;
	bh=YV6RI5iSYf4z47W789l3BuPJfekqwqTsS7ESy0JOSdc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cjI7lBYDPwwB1uHSC7tLupgaZYjzHZG/XPbejFGdIvuCYR130t9tV0QEZ/r1f6rMfRZeIKDkhQqEYkNMag/C/RwLETrQhVWjpNoTmOUB6fAGbfXxaAAwSV/Yb0C2/UzC8tVZ4Y+B8Du0CL/W6vxavEmLi2yOjS/vjny2jOiS/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3QHX6yr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3QHX6yr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539791F00899;
	Tue, 29 Sep 2026 12:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790684883;
	bh=xzolaEgZgpmmNh+XUdWXRuKDHbRhDHxZZNzUlyphnm0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z3QHX6yrKe37B0RJIB8bUGOYNirIOrI5QOoBeDnC+ZVgEll5RtUsbKYNddTEBc5gG
	 gphmomSjqB87E05cXql3AYnGvHM/qtv9firwZ7e+1VE4H/wCncWESDivztJnZ1T9my
	 8DftJZ13zvd7+jgkvMHfpgRQ7A5l755H9xd6DqgaqQCgdFuwYitBPB457RsDiGeeyO
	 4pgqx6avhCPo7Nte5PpbSx8WhRBsVc+uD4oHAJzGTRZ0UY3NgDo5qGmGKt8AqJBkmE
	 X0lnHOcldmdyuR22XKS+VEXScYRyw2frUeMZG+P/qwYUmGPR1jpuIWIlta31yuciZz
	 2tHd8UDBwWXYQ==
Subject:
 Re: [PATCH net-next v4 08/11] net: dsa: microchip: extract prepare reset
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 12:28:01 +0000
Message-ID: <179068488191.434549.5879088334596708453@kernel.org>
In-Reply-To: <20260925-ksz-perout-v4-8-d675bd21ce49@bootlin.com>
References: <20260925-ksz-perout-v4-8-d675bd21ce49@bootlin.com>
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

- [Low] The commit subject "net: dsa: microchip: extract prepare reset"
  does not describe the change.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  moves it into the new shared helper and later patches keep using it.

--

net: dsa: microchip: extract prepare reset

This commit moves the request setup in ksz_ptp_restart_perout() into a
new helper, ksz_ptp_prepare_restart_perout(). The helper fills a
caller-supplied struct ptp_perout_request. A later KSZ8463-specific
restart path will reuse it.

> net: dsa: microchip: extract prepare reset

[Severity: Low]
This isn't a bug, but should the subject say "restart" instead of "reset"?

The patch adds no reset logic. It only splits out the setup of the
periodic output restart request into ksz_ptp_prepare_restart_perout().

This file also has ksz_ptp_tou_reset(), which ksz_ptp_enable_perout()
calls. That makes "reset" in the subject easy to confuse with a TOU
reset change.

> Extract the inialization into a dedicated function so it can be used
> later by the KSZ8463 support.

There is also a typo in the body: "inialization" should be
"initialization".

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index 4b57cf076bb4f..b627062dbaad7 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> @@ -793,11 +793,11 @@ static int ksz_ptp_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
>  	return ret;
>  }
>  
> -static int ksz_ptp_restart_perout(struct ksz_device *dev)
> +static int ksz_ptp_prepare_restart_perout(struct ksz_device *dev,
> +					  struct ptp_perout_request *request)
>  {
>  	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
>  	s64 now_ns, first_ns, period_ns, next_ns;
> -	struct ptp_perout_request request;
>  	struct timespec64 next;
>  	struct timespec64 now;
>  	struct timespec64 tmp;

[Severity: High]
This is a pre-existing issue and was not introduced by this patch.
However, the code now sits in the new shared helper, which the later
KSZ8463 restart path is meant to use.

Can the unsigned int count in ksz_ptp_prepare_restart_perout() truncate
the 64-bit div_u64() quotient?

drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_prepare_restart_perout() {
    ...
	unsigned int count;
    ...
	if (first_ns < now_ns) {
		count = div_u64(now_ns - first_ns, period_ns);
		next_ns = first_ns + count * period_ns;
	} else {
		next_ns = first_ns;
	}

	/* Ensure 100 ms guard time prior next event */
	while (next_ns < now_ns + 100000000)
		next_ns += period_ns;
    ...
}

Once the PHC is more than 2^32 periods past the stored perout start,
count loses its high bits and next_ns lands far behind now_ns. The guard
loop then has to make up the lost cycles one period_ns at a time. It has
no resched point, and ptp_data->lock is held.

For example, take a 1 us period started at 110 s, followed by a settime
to 5000 s. The quotient is 4,890,000,000, which truncates to
595,032,704. That leaves about 4.29e9 loop iterations.

Suppose instead a perout is started with the PHC near 0 and the clock
is then stepped to current TAI. With a 1 us period that is about 1.79e15
iterations, and ksz_ptp_tou_pulse_verify() accepts periods as short as
8 ns.

With a 1 ms period, the same thing happens on any settime or adjtime
more than about 49.7 days after the perout start time.

The paths that reach this whenever tou_mode == KSZ_PTP_TOU_PEROUT are:

  clock_settime() -> ksz_ptp_settime() -> ksz_ptp_restart_perout()
      -> ksz_ptp_prepare_restart_perout()

  clock_adjtime(ADJ_SETOFFSET) -> ksz_ptp_adjtime()
      -> ksz_ptp_restart_perout() -> ksz_ptp_prepare_restart_perout()

Would declaring count as u64 (or s64) avoid this?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-ksz-perout-v4-0-d675bd21ce49%40bootlin.com
