Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BC1522F1A;
	Tue, 29 Sep 2026 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684883; cv=none; b=cAFXBlrXWw5vzWCPn4sCTdFxPvH2vHksVrqxs6nF9G2eqERtJA6kS4UvILoYKoqtMyf874QT9Oifmy04hCIRzQ63s4VxNTpXfmFDLNHLACf8K77Wq/72zFmb249c//BlsOcs9OvUTGKMxCRu/LfVf/Kb32xMVU5oV8ZfcO5KKGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684883; c=relaxed/simple;
	bh=XFqElrTxY+FpXrwnbf5/X0B8MJ189K7z3VAxxQRr0EU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qMRsK0w8uVjdOChqnlJ1KXn/+uC9RuBXuh973pWhr5f+foASzl8R2oNcQk7ZCWgI3SWdQjZ/YOH6tvsuJd1wh0gIUD87rnSuCw5/eB1zcz1H6GlroQtDqKX4hJGScef+Yc5m53f14Se1jOqwxwxMAFUctKhpAJ8lODqxscbHrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrSMSvQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrSMSvQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CDE1F00893;
	Tue, 29 Sep 2026 12:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790684881;
	bh=FuEiuzmksjO1qStfIEd8BJ4ChoXMH+FclTS0IWYYuCc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GrSMSvQTE5lDqbGSV5kldcoPIewdSe3ZR6yZmD6B8MwiuzfG8GuTHXc2vXZsdaZt1
	 YCQzwdYXR9RJvdfautnxJZX/iUIK7NuGGSiekAocO0qyrrMBTEsdHqWcO8PLB4MhU5
	 6MK4lYNzwnBKnauiUzr4Jp1rN3sGeojqb1Gu+Mzj1Achv7sUPKhZ+j1KoTpbXJ5vzF
	 59LzMNTo4tVYSxtFRqggK7cvp3+HeeYpSQS9YrH/0L9DbP/T8tFDYrcovCYtrxnoUk
	 x/sK6tTdlcOO9v0A0uaziQ3FGamFx6tc4qYAt0MJbhVW4fpp6qDGS849ZTI2i36M0v
	 Wr66IJAUb3pOA==
Subject:
 Re: [PATCH net-next v4 07/11] net: dsa: microchip: extract compute_width
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 12:28:00 +0000
Message-ID: <179068488049.434549.2405268057372474748@kernel.org>
In-Reply-To: <20260925-ksz-perout-v4-7-d675bd21ce49@bootlin.com>
References: <20260925-ksz-perout-v4-7-d675bd21ce49@bootlin.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new check in ksz_ptp_compute_perout_cycle() does not fully
  stop the divide-by-zero on restart that the commit message says it…
- [Medium] The new `request->period.sec < 0` check in
  ksz_ptp_compute_perout_cycle() fixes a crash that userspace can…

--

net: dsa: microchip: extract compute_width

This moves the period and pulse width calculation out of
ksz_ptp_enable_perout() into a new helper, ksz_ptp_compute_perout_cycle().
The helper will be reused later for KSZ8463 periodic output support. It
also adds checks that reject negative or zero periods, so that a restart
of the periodic output cannot divide by zero.

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index 79520d345efcf..4b57cf076bb4f 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> @@ -203,12 +203,50 @@ static int ksz_ptp_get_pin(struct ksz_device *dev,
>  	return pin;
>  }
>  
> +static int ksz_ptp_compute_perout_cycle(struct ksz_device *dev,
> +					struct ptp_perout_request const *request,
> +					u64 max_pulse_width,
> +					u64 *cycle_width_ns,
> +					u64 *pulse_width_ns)
> +{
> +	struct timespec64 tmp;
> +
> +	if (request->period.sec < 0)
> +		return -EINVAL;

[Severity: Medium]
Is this check fixing a crash in the existing code? If so, should it go to
net with a Fixes: tag?

Before this patch, take a request with period.sec = -1 and
period.nsec = 1000000000. The PTP core passes it to the driver with on = 1:

drivers/ptp/ptp_chardev.c:ptp_perout_request() {
    ...
	return ops->enable(ops, &req, perout->period.sec || perout->period.nsec);
}

timespec64_to_ns() turns this period into a cycle width of 0, which
passes the TRIG_CYCLE_WIDTH_M check. The pulse width is also 0, which
passes ksz_ptp_tou_pulse_verify(). The request is then stored and
tou_mode is set to KSZ_PTP_TOU_PEROUT.

The next settime or adjtime reaches ksz_ptp_restart_perout() with
period_ns = 0. That leads to div_u64(..., 0) and then an endless
next_ns += period_ns loop.

This looks reachable on every PTP capable KSZ switch since commit
1f12ae5b6760 ("net: dsa: microchip: ptp: add periodic output signal").
That assumes the hardware accepts a zero cycle width without reporting
TRIG_ERROR.

Since the fix sits in a refactor in a net-next series, stable kernels
won't pick it up. Could these checks be split into their own patch for
net, with "Fixes: 1f12ae5b6760" and a commit message that describes how
the crash is triggered?

> +
> +	if (!request->period.sec && !request->period.nsec)
> +		return -EINVAL;
> +
> +	tmp.tv_sec = request->period.sec;
> +	tmp.tv_nsec = request->period.nsec;
> +	*cycle_width_ns = timespec64_to_ns(&tmp);
> +	if ((*cycle_width_ns & TRIG_CYCLE_WIDTH_M) != *cycle_width_ns) {
> +		*cycle_width_ns = 0;
> +		*pulse_width_ns = 0;
> +		return -EINVAL;
> +	}

[Severity: High]
Can a zero cycle width still get through here on 32-bit kernels?

ptp_perout_request.period.nsec is a __u32. Neither ptp_perout_request()
nor the sysfs period_store() checks that it is below NSEC_PER_SEC. On
32-bit, struct timespec64.tv_nsec is a signed 32-bit long, so the
assignment to tmp.tv_nsec can wrap to a negative value.

Take period.sec = 1 and period.nsec = 3294967296 (0xC4653600). Both new
checks pass. tmp.tv_nsec becomes -1000000000, so timespec64_to_ns()
returns 0, and the TRIG_CYCLE_WIDTH_M check accepts 0. The pair
sec = 2, nsec = 2294967296 also gives 0.

The 50% duty cycle path below uses the raw u32 nsec. That value is clamped
to max_pulse_width and passes ksz_ptp_tou_pulse_verify().
ksz_ptp_enable_perout() then programs a zero cycle width and saves the
request in ptp_data->perout_request.

On the next settime or adjtime, ksz_ptp_restart_perout() does the same
conversion:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_restart_perout() {
    ...
	tmp.tv_sec = ptp_data->perout_request.period.sec;
	tmp.tv_nsec = ptp_data->perout_request.period.nsec;
	period_ns = timespec64_to_ns(&tmp);

	if (first_ns < now_ns) {
		count = div_u64(now_ns - first_ns, period_ns);
    ...
	while (next_ns < now_ns + 100000000)
		next_ns += period_ns;
    ...
}

Once the start time has passed, this divides by zero, which is a divide
error on x86-32. On ARM32, __div0 returns, and the while loop then spins
forever with ptp_data->lock held. Like the check above, this assumes
ksz_ptp_tou_start() does not report TRIG_ERROR for a zero cycle width.

The commit message says these checks ensure the request "will not cause
divide by zero issues if the periodic output is restarted". Would it be
better to reject period.nsec >= NSEC_PER_SEC, or to reject
*cycle_width_ns == 0 after the conversion?

The helper is unchanged at the end of the series, and
ksz8463_ptp_enable_perout() reuses it later in the series. So the KSZ8463
path would be affected as well.

> +
> +	if (request->flags & PTP_PEROUT_DUTY_CYCLE) {
> +		*pulse_width_ns = request->on.sec * NSEC_PER_SEC
> +				  + request->on.nsec;
> +		return 0;
> +	}
> +
> +	/* Use a duty cycle of 50%. Maximum pulse width supported by the
> +	 * hardware is a little bit more than 125 ms.
> +	 */
> +	*pulse_width_ns = (request->period.sec * NSEC_PER_SEC +
> +			   request->period.nsec) / 2;
> +	*pulse_width_ns = min_t(u64, *pulse_width_ns, max_pulse_width);
> +
> +	return 0;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-ksz-perout-v4-0-d675bd21ce49%40bootlin.com
