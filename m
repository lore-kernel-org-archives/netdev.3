Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01D23C09FB;
	Thu, 24 Sep 2026 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260184; cv=none; b=RFigE1TfrC6iAx1Yvw3d/5TVw9AJ79qKRf0eiwAM+d/CbZDRMzDvpyq7SGi4A/qCbpoKUJDJRL7CCmoltbM4RaQvP5Pa84vuTgQUBOUnTFER4kxVMGns7RzYvlDwYoDdx+vchnTCEnKTq8T8/EVjaZkglEOs3+qMVUmFlrTTx6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260184; c=relaxed/simple;
	bh=pSFbl8N/OOWi1AcITZOxdqY+IcdG3Zzw/pGoshpdmaA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OD558Ys+BbT+e+xokz4iIj8u2i0koaPPgSTxBcejGuCAZrFAIrRhI0h/kYSlNBZb2HT7hgJMaY0f4EI9Je5UIcdEZK8f81UxMg2lI/zjM3ZRUf++BATyoLpYIt08eQYa7QLhJyfy7J4ITrGdzZQxjGhQO+fi85Ufjz8b14fzeuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYxo78nl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYxo78nl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD9A1F000FF;
	Thu, 24 Sep 2026 14:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790260175;
	bh=1xuELKioqPtCmJN13OOPHU7lapX/N4LY1n9BvvTZWIQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZYxo78nlpVUSs33JPNGA1vyE0hthofs+S0O8hwU0m6/5TMNN3rHxxFMO94Twr0Zdg
	 AJFsJfjpGTTVHAUmOHCVYGu5KjEaxjw7n2Tp6MF1w6mLlw/NQO1coN0SQzKGqOBP2V
	 JM8HTGIeEeByZO/JbXgO8ezpdBCJznydgcPBwFMO5dqHQBX+JWcMj4300B9f9jfAG7
	 D4eT0GoIYejc5HuSC2D7hIQ+6efYsCr2BVVPIRNXeLCqbUxToyOe2r8IztV0WVLeII
	 7m2krbkJEkuY+ohVbS8DkOUFba1GzvFT12oYyL2LIKLeLKHFtYotc4fsc4IswdNF/L
	 ycj4huDODjFcQ==
Subject: Re: [PATCH net-next 9/9] ptp: ocp: confirm the CPLD really left
 configuration mode after REFRESH
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, corbet@lwn.net, rdunlap@infradead.org,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 14:29:34 +0000
Message-ID: <179026017445.2160803.6964997601220923867@kernel.org>
In-Reply-To: <20260922142829.57740-10-maimon.sagi@gmail.com>
References: <20260922142829.57740-10-maimon.sagi@gmail.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In adva_x1_cpld_flash() (drivers/ptp/ptp_ocp.c), the new post-
  REFRESH check sets bp->cpld_in_config_mode = true when…

Pre-existing issues:
- [Low] Documentation/ABI/testing/sysfs-timecard (lines 22-27) defines
  the cpld_status flag "done" as "the configuration flash holds a valid…

--

ptp: ocp: confirm the CPLD really left configuration mode after REFRESH

The post-REFRESH status check in adva_x1_cpld_flash() now also requires
CPLD_STATUS_ENAB to be clear, on the grounds that DONE/BUSY/ERR alone cannot
tell a REFRESH that rebooted the part from one that was only ACKed.  When
ENAB is still set, bp->cpld_in_config_mode is restored to true before the
function fails with -EIO.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 4f2bf54a23c21..9c2b7403bfd05 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -5135,6 +5135,9 @@ static int adva_x1_cpld_flash(struct ptp_ocp *bp, struct devlink *devlink,
>  
>  	/* REFRESH reboots the CPLD out of configuration mode, so the exit
>  	 * path must not send DIS_CFG afterwards even if a check below fails.
> +	 * The ENAB test below confirms it really left; until then assume it
> +	 * did, because sending DIS_CFG to a part that has rebooted is what
> +	 * this flag exists to avoid.
>  	 */
>  	bp->cpld_in_config_mode = false;
>  
> @@ -5156,12 +5159,21 @@ static int adva_x1_cpld_flash(struct ptp_ocp *bp, struct devlink *devlink,
>  	/* Require DONE set, not busy and no error code, as machxo2-spi.c does
>  	 * after a refresh: without it a CRC or preamble error reads back as a
>  	 * successful update.
> +	 *
> +	 * ENAB has to be clear too.  Those three conditions are already met
> +	 * by the state SET_DONE leaves behind, so on their own they cannot
> +	 * tell a REFRESH that rebooted the part from one whose frame was
> +	 * ACKed but never latched - which leaves the part in configuration
> +	 * mode still running the old image.  Leaving configuration mode is
> +	 * the one thing only a REFRESH does.
>  	 */
>  	err = adva_x1_cpld_read_status(bp, &st);
>  	if (err)
>  		goto deselect;
> +	if (st & CPLD_STATUS_ENAB)
> +		bp->cpld_in_config_mode = true;
>  	if (!(st & CPLD_STATUS_DONE) || (st & CPLD_STATUS_BUSY) ||
> -	    (st & CPLD_STATUS_ERR)) {
> +	    (st & CPLD_STATUS_ERR) || (st & CPLD_STATUS_ENAB)) {
>  		dev_err(&bp->pdev->dev,
>  			"CPLD refresh left status 0x%08x\n", st);
>  		NL_SET_ERR_MSG_MOD(extack, "CPLD did not come back configured");

[Severity: High]
Can the restored flag actually be acted on in this call?  The ENAB-set case
sets bp->cpld_in_config_mode = true and then leaves via goto deselect, but
the labels at the bottom of adva_x1_cpld_flash() are ordered:

	exit_config:
		adva_x1_cpld_exit_config(bp);
	deselect:
		ret = adva_x1_mux_select(bp, -1);
		...
		ret = adva_x1_bus_release(bp);

so jumping to deselect skips adva_x1_cpld_exit_config(), which is the only
code that issues CPLD_CMD_DIS_CFG and the only reader of the flag:

	static void adva_x1_cpld_exit_config(struct ptp_ocp *bp)
	{
		int err, i;

		if (!bp->cpld_in_config_mode)
			return;

		for (i = 0; i < CPLD_EXIT_CFG_TRIES; i++) {
			err = adva_x1_cpld_wait_idle(bp, CPLD_ERASE_MS);
			if (!err)
				err = adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG);
	...

In the exact case this change detects - REFRESH ACKed but not latched, part
still in transparent configuration mode running the old image - the mux
channel, the I2C segment and cpld_lock are all released with no DIS_CFG
attempted, even though the earlier comment in the same function says:

	/* Set before EN_CFG_TP, not after: ...
	 * makes the exit path send DIS_CFG.  A stray DIS_CFG is harmless;
	 * leaving config mode enabled is not.
	 */
	bp->cpld_in_config_mode = true;

The commit message says the flag is put back "so the exit path and the
recovery at the start of the next flash can act on it".  Is the exit path
part reachable here?  The other call site of adva_x1_cpld_exit_config() is
the recovery at the start of the next adva_x1_cpld_flash(), so recovery only
happens if another devlink flash of fw.cpld is issued on the same bound
instance.

Is that deferral durable?  ptp_ocp_remove() does not exit configuration
mode, and a fresh probe zero-initialises bp->cpld_in_config_mode, so after
rmmod, rebind or a PCI reset the knowledge that the part is still latched in
configuration mode is gone.

Would goto exit_config be the right target for the ENAB-set case?
adva_x1_cpld_exit_config() returns immediately when the flag is clear, so the
other post-REFRESH failure paths would be unaffected.  For comparison,
machxo2_write_complete() retries LSC_REFRESH and always runs its cleanup;
here neither a REFRESH retry nor DIS_CFG is attempted.

[Severity: Low]
This isn't a bug introduced by this patch, but the new interpretation of the
status register does not line up with what the sysfs ABI says about the same
register.  Documentation/ABI/testing/sysfs-timecard describes cpld_status as:

		==========  ================================================
		done        the configuration flash holds a valid image and
			    it is active
		busy        an internal operation is in progress
		failed      the last ISC operation failed
		==========  ================================================

and cpld_status_show() emits only those three bits:

	if (st & CPLD_STATUS_DONE)
		count += sysfs_emit_at(buf, count, "done");
	if (st & CPLD_STATUS_BUSY)
		count += sysfs_emit_at(buf, count, "%sbusy", count ? " " : "");
	if (st & CPLD_STATUS_FAILED)
		count += sysfs_emit_at(buf, count, "%sfailed",
				       count ? " " : "");

CPLD_STATUS_ENAB is never surfaced.  After the failure this patch adds (DONE
set, ENAB set), a read of /sys/class/timecard/ocpN/cpld_status reports "done",
which per the documented wording means the image is valid and active.  Should
the ABI text and cpld_status_show() also learn about the configuration-mode
bit so the state being detected here is visible?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922142829.57740-1-maimon.sagi%40gmail.com
