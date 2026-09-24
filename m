Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310F83C13E5;
	Thu, 24 Sep 2026 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260182; cv=none; b=k2M1cepDi50mjac8FaWNgJoiMAkkzildKzLyRir5vXkHbvvOJS/yAqE/VPaN/3DWRalDcVY1lXcudGIggOZNRD6lx0bEu/hag4MbAxkxwsQ591yNvnB5Ep8LlNG0UBjs6apQl2Stjfj1xB5cNCytkZyOWDhqZ9mw9mY03+C0DTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260182; c=relaxed/simple;
	bh=2oL+g61r9LNMyDF5ZElm+/gAZ2An4t7SiafGcmhRE1g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WDuft7nFtnl9JSB+q5r1wRG1txo0kLAMTXvEHl+iBLmBZ1p5dKtkit6d+eXISckY7uwfFFs72bnMQRDl1NxqlVClU3KKH/nei4QS9JuoGwzC7+EGi/4Au1Lot3B7nsoWHM0SDMcnEiDNbYbW4TqS9sG2ym0pdiNBEOzSAzH6m/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuvVXxx/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuvVXxx/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F5A1F0089D;
	Thu, 24 Sep 2026 14:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790260174;
	bh=SRbvwTNcBw/MUkzqEebybdHJ28IP3DWUd4wxZT29I9g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NuvVXxx/dzcwK74VaH4MfU/AtNg6ietZbtqnTYsbOfsCLP7rmf5Y8ty571HslkQt+
	 qWZ3Xau6gZlvmKO8mLXX5sH9HkKS+dLLK2wWF+bq5DgDFgJDuJsbhOOKq1IGDboulQ
	 oWqNfcy//Op9oBcM+Gtf2kH3YvFyNN0C90vd6xADT4CaXjeA+8eCG067ffQXhCCefi
	 go3bgjlHoeVhGaWNasx5jGoBDdR5xY+rv73w164k8zIWiiAqJBSk0lZPu3iaXI+dt1
	 s8r0Dkaf6zjjSSkcLmeX8xkcLxHTpK4yhlRYnUzQcMRCggmzu1oP8qTsxYU5lMQlaQ
	 t3oiSL1S1tVkw==
Subject: Re: [PATCH net-next 8/9] ptp: ocp: tolerate a latched FAILED when
 entering configuration mode
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, corbet@lwn.net, rdunlap@infradead.org,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 14:29:33 +0000
Message-ID: <179026017305.2160803.11471616461860982077@kernel.org>
In-Reply-To: <20260922142829.57740-9-maimon.sagi@gmail.com>
References: <20260922142829.57740-9-maimon.sagi@gmail.com>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch relaxes only the EN_CFG_TP wait to
  adva_x1_cpld_wait_idle() (drivers/ptp/ptp_ocp.c:5030) but leaves the…

--

ptp: ocp: tolerate a latched FAILED when entering configuration mode

The first status wait after CPLD_CMD_EN_CFG_TP in adva_x1_cpld_flash() is
changed from adva_x1_cpld_wait_ready() to adva_x1_cpld_wait_idle(), so a
latched CPLD_STATUS_FAILED no longer turns the enable step into -EIO.  The
following CPLD_STATUS_ENAB check is left to decide whether the part entered
configuration mode.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 0d6d0c02882c1..4f2bf54a23c21 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -5018,9 +5018,16 @@ static int adva_x1_cpld_flash(struct ptp_ocp *bp, struct devlink *devlink,
>  	 */
>  	bp->cpld_in_config_mode = true;
>  
> +	/* wait_idle(), not wait_ready(): FAILED is latched across operations
> +	 * and nothing here clears it, so treating it as fatal at the enable
> +	 * step would make every later flash of a part that has failed once
> +	 * return -EIO before reaching the ERASE and REFRESH that put it back
> +	 * into a defined state.  ENAB below is what says the enable worked;
> +	 * machxo2-spi.c likewise tests FAIL only after ISC_ENABLE completes.
> +	 */
>  	err = adva_x1_cpld_write(bp, CPLD_CMD_EN_CFG_TP);
>  	if (!err)
> -		err = adva_x1_cpld_wait_ready(bp, 5000);
> +		err = adva_x1_cpld_wait_idle(bp, 5000);
>  	if (err)
>  		goto exit_config;

[Severity: High]

Given the premise that FAILED is latched and nothing in the driver clears
it, does the sequence actually reach the ERASE and REFRESH that the new
comment says put the part back into a defined state?

The next wait in adva_x1_cpld_flash() is still the strict one:

	err = adva_x1_cpld_write(bp, CPLD_CMD_ERASE);
	if (!err)
		err = adva_x1_cpld_wait_ready(bp, CPLD_ERASE_MS);
	if (err)
		goto exit_config;

and adva_x1_cpld_wait_ready() stops polling on FAILED independently of
BUSY, with sleep_before_read == false, so the first status read can
observe the stale bit:

	ret = read_poll_timeout(adva_x1_cpld_read_status, err,
				err || (status & CPLD_STATUS_FAILED) ||
				!(status & CPLD_STATUS_BUSY),
				CPLD_POLL_US, max_ms * USEC_PER_MSEC, false,
				bp, &status);
	if (ret)
		return ret;
	...
	if (status & CPLD_STATUS_FAILED)
		return -EIO;

So on a part with FAILED latched from an earlier aborted update, wouldn't
"devlink dev flash ... component fw.cpld" still return -EIO, just a few
commands later than before?

Is the state the part is left in also worse than before this change?  The
ERASE has been ACKed by then, and this function documents that itself:

	/* Once the erase is issued the image is gone whatever happens next -
	 * an ACKed ERASE runs in the part even if the wait for it fails - so
	 * stop reporting the USERCODE before sending it rather than after
	 * the whole sequence has succeeded.

The goto exit_config path runs adva_x1_cpld_exit_config(), which only waits
BUSY out and sends CPLD_CMD_DIS_CFG, so CPLD_CMD_SET_DONE and
CPLD_CMD_REFRESH are never issued.  Before this patch the same device state
produced a refusal at the enable step with the configuration image intact;
afterwards it erases the configuration flash with DONE cleared and no
refresh.  On this board the CPLD is only reachable through the TMC mux
segment, so does an unconfigured part still have the access path needed to
write a replacement image?

Would the ERASE, page-write (adva_x1_cpld_wait_ready(bp, 100) in the page
loop) and SET_DONE waits need the same treatment, i.e. tolerating a
pre-existing FAILED and testing it only after the operation completes?
That is what the cited machxo2_write_init() in drivers/fpga/machxo2-spi.c
does - it issues ISC_ENABLE and ISC_ERASE, waits with
wait_until_not_busy(), and only then tests FAIL:

	ret = wait_until_not_busy(spi);
	if (ret)
		goto fail;

	get_status(spi, &status);
	if (test_bit(FAIL, &status)) {

The alternative reading, that the part clears FAILED at the start of each
new ISC operation, would make the enable wait harmless either way, but it
also contradicts the "FAILED is latched across operations and nothing in
the driver clears it" premise the commit message and the new comment are
built on.  Which of the two describes the hardware?

Checking the rest of the series, the ERASE wait is unchanged through
5b9611f9 ("ptp: ocp: confirm the CPLD really left configuration mode after
REFRESH"), so this does not appear to be addressed by a later patch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922142829.57740-1-maimon.sagi%40gmail.com
