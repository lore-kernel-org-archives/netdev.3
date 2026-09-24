Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3754AD4DA;
	Thu, 24 Sep 2026 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269664; cv=none; b=QdrXzAq5/+FY9OsDM9kLA9JIhTvkOrv5a5FAGy+FaPeuGxc6LcFRXQekLoiYU4UNTH147Mb/Z8affvKvndcwveQRuJNyM1kwZiTEmCY8L5crqRUoima540xl/A5TxiMc9epkLqvlb/iRrPSUofjM75+yu4me7Su49A9AtyVG5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269664; c=relaxed/simple;
	bh=0JVjgZLgBHo8N0+eoL3qOFpTDctF3daGfncbtRT4ahs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tDCVH1n6/bxZGcrpTltgRS9rS+bjddgxYzh5wQcxxx/NIgNofVAjJaDFQeBgKYCJUcCsV5a2JwWHtqbK07HlA3wLrL+mLv9Wh4jInknPfR3/Jggaiku8Bsr5/cA3tplcJ/0tanwj9lf/KRONEs8BlLVZwE5m+v1l1tCMT9YVFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw5/65uO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw5/65uO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63611F00898;
	Thu, 24 Sep 2026 17:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269662;
	bh=mvYW6KeHhuXzjqy4KzxVxVRJ+giVGt65xk/VIbAMCqg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aw5/65uOaSGsD0PkV+DlZ3NIt47vGyaGzxZj9vxQDCncbqA4wz/pM6jxbNTVu4XUm
	 +L4pUlzK+7rmeFUqlW3h0CBXS1nopvSh+1jEFOr4T7GhtYIRdArosdTvfn+8EhX0bc
	 3KYG162lzvlEwRFaQp/XIZfibX2dMICE3NpdBRVSLd6BPuKv/zVw9Px2Q0nCh3Z4sH
	 JxxdJuPy+oKIvJz2WF+SxjXHSy28/zlGa9+YyTyTrKb1H/1j6BcwZPiPGXM0IaP21i
	 VCWP4m/4LD8sTJZnTZezyNxGBHIhHDAioWeQTU4YlsNrDAdOuzMB4q1oEGq8PgKDv4
	 //78e2aeL5bgA==
Subject: Re: [PATCH net 10/12] net: systemport: Fix unbalanced Wake-on-LAN
 clock disable in resume
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Thu, 24 Sep 2026 17:07:41 +0000
Message-ID: <179026966119.2160803.13520202114647532733@kernel.org>
In-Reply-To: <20260921231305.394773-11-florian.fainelli@broadcom.com>
References: <20260921231305.394773-11-florian.fainelli@broadcom.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] bcm_sysport_suspend()
  (drivers/net/ethernet/broadcom/bcmsysport.c:2780-2783) discards the…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but it defeats
  the balance the patch aims for on the suspend error path: when…
- [Low] This problem wasn't introduced by this patch, but it leaves the
  driver internally inconsistent about the exact condition the patch…

--

net: systemport: Fix unbalanced Wake-on-LAN clock disable in resume

The patch changes bcm_sysport_resume() so that the Wake-on-LAN clock is
only disabled when both device_may_wakeup(d) and priv->wolopts are true,
matching the condition used in bcm_sysport_suspend() when the clock is
prepared and enabled.

> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index 384423b312ca2..dd5a7c9dd90fb 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -2803,7 +2803,7 @@ static int __maybe_unused bcm_sysport_resume(struct device *d)
>  		return ret;
>  	}
>  
> -	if (priv->wolopts)
> +	if (device_may_wakeup(d) && priv->wolopts)
>  		clk_disable_unprepare(priv->wol_clk);

[Severity: Medium]
The new condition describes what suspend intended to do rather than what it
actually achieved.  In bcm_sysport_suspend() the return value of the enable
is discarded:

	/* Get prepared for Wake-on-LAN */
	if (device_may_wakeup(d) && priv->wolopts) {
		clk_prepare_enable(priv->wol_clk);
		ret = bcm_sysport_suspend_to_wol(priv);
	}

	clk_disable_unprepare(priv->clk);

	return ret;

priv->wol_clk is a real clock whenever the DT provides sw_sysportwol, since
bcm_sysport_probe() obtains it with devm_clk_get_optional(&pdev->dev,
"sw_sysportwol"), so it is NULL only when the clock is absent.

If clk_prepare_enable(priv->wol_clk) fails, bcm_sysport_suspend_to_wol()
still runs and can return 0, because the UMAC/RBUF/RXCHK registers it pokes
are clocked by priv->clk, which is only disabled after that block.  Suspend
therefore returns 0, the PM core calls bcm_sysport_resume(), and the line
above drops a prepare/enable reference that was never taken, which should
trip the clk core WARN(core->enable_count == 0) and
WARN(core->prepare_count == 0) checks.

So can the unbalanced clk_disable_unprepare() the commit message describes
still happen here?  Would latching the real outcome, for example a flag set
only when clk_prepare_enable() returned 0, or checking and propagating that
error, be a more complete fix than re-evaluating the predicate?

There is also a diagnostic side to the ignored return: the system suspends
believing WoL is armed while the WoL block is unclocked, so the wake event
can be lost silently.  Every other clk_prepare_enable() in this file checks
its return, including the one immediately above this hunk in
bcm_sysport_resume().

[Severity: Medium]
This isn't a bug introduced by this patch, but it affects the same balance
the patch is trying to establish.  When bcm_sysport_suspend_to_wol() fails,
bcm_sysport_suspend() returns the error with priv->wol_clk still prepared
and enabled, and there is no unwind for that:

	if (device_may_wakeup(d) && priv->wolopts) {
		clk_prepare_enable(priv->wol_clk);
		ret = bcm_sysport_suspend_to_wol(priv);
	}

	clk_disable_unprepare(priv->clk);

	return ret;

The failure comes from the RBUF WoL-mode poll in
bcm_sysport_suspend_to_wol():

	/* Do not leave the UniMAC RBUF matching only MPD packets */
	if (!timeout) {
		mpd_enable_set(priv, false);
		netif_err(priv, wol, ndev, "failed to enter WOL mode\n");
		return -ETIMEDOUT;
	}

The PM core sets dev->power.is_suspended only when the suspend callback
returned 0, and device_resume() bails out early with:

	if (!dev->power.is_suspended)
		goto Complete;

Since the clk_disable_unprepare(priv->wol_clk) edited by this patch is the
only disable site for that clock in the driver, does the sw_sysportwol
clock stay enabled forever after a failed suspend, with the enable count
growing on each further failed attempt?

On the WAKE_FILTER path the -ETIMEDOUT leg clears only MPD_EN, while
RBUF_ACPI_EN(_LITE) and RXCHK_EN | RXCHK_BRCM_TAG_EN stay set, and
bcm_sysport_resume_from_wol() never runs to clear them.  Should the suspend
error path also release wol_clk and roll back the RBUF/RXCHK programming,
rather than relying on resume mirroring the predicate?

[Severity: Low]
This is a pre-existing issue, but this change makes
device_may_wakeup(d) && priv->wolopts the driver's definition of "WoL is
armed for this suspend" in both bcm_sysport_suspend() and
bcm_sysport_resume(), while a third site in bcm_sysport_suspend() still
uses priv->wolopts alone:

	/* Flush RX pipe */
	if (!priv->wolopts)
		topctrl_writel(priv, RX_FLUSH, RX_FLUSH_CNTL);

In exactly the configuration this commit addresses, wakeup disabled at the
device level via /sys/.../power/wakeup while priv->wolopts is still
non-zero because the ethtool WoL options were never cleared, suspend skips
the RX_FLUSH write as if WoL were armed, yet bcm_sysport_suspend_to_wol()
is never called, the MPD/ACPI/RXCHK matching is never enabled and the WoL
clock is never enabled.

Should this flush decision use the same condition, so the RX pipe is not
left unflushed in a suspend where nothing is armed to match or consume
incoming traffic until bcm_sysport_resume() rewrites RX_FLUSH_CNTL?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921231305.394773-1-florian.fainelli%40broadcom.com
