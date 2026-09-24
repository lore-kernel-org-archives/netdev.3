Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466563D4108;
	Thu, 24 Sep 2026 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216492; cv=none; b=avkDNpp2jPEBrVm+FA5rFL1CC5DrNWAaXyxI95pX5JhaWm3bghoGF2L0+2AVJM7CaiS70MwQupj626ZGa/VDOtJKRAMbfaZ6FiIEdCZ6WOYeyyhRew8j3yKiLHB+9gZRbb0NnkaqwoJ1w81jhE/edaEllWJo5YI8wr5jkVsB3Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216492; c=relaxed/simple;
	bh=1LkUQ4rF3qWKEaXhUAE5z4mWnWFf45eh4F+Wh008kTs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n6EXHVjG1WyOLGqgWu+xlKux2yeT66flvaBYqRJ9t9lgdEfcTCogfC6kTjPFuI2TxHocZyq7wtpBlk3iBJiOwyfU1gh6phgp2c5YzUWZpXhp9PcusveoxjFKrtP8MJn7+FfKEtP6CqPB8kfagyJMIr7rL1dM0fjh7KZysLWMDEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZU7j5wz4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU7j5wz4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9B51F00898;
	Thu, 24 Sep 2026 02:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790216489;
	bh=mlTMAmQ9G98sO7Hh8w07DX1Ys7QagY26xr8d3D4UQ7I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZU7j5wz4ACAw6fKjOPBoYJh2jajTUvM8gZpj7SRGkZdDavywww2UTNPx4+kauce/U
	 3PoEenrnHE96jW1VFQ/dTF59vo/ol9mWN60PdDpOONx27kY9p1jwOgqf9v9yHsN06C
	 WwFIuxJ9q03tfztKv7I1PdDDjJsO9plEg50/9BmpFEpu3S0RIr93rX2iuVJNLdQr7I
	 4Ye9oI9TK+/fmJskXFYuMF3NRCzyLWNJTt+E4VDGeHd/ZETDWR5U2D6tL1gIlZKqWT
	 2mZHjkc891J5kbBWC+DxnY/ui9VHGdbMbRV03btN/LtIH9RrIuK6YJrGK8eapkwVbW
	 IRIvZo58tP4oA==
Subject: Re: [PATCH net v2 09/10] net: systemport: Fix unbalanced Wake-on-LAN
 clock disable in resume
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, nb@tipi-net.de, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 02:21:28 +0000
Message-ID: <179021648855.2160803.3416536313328165493@kernel.org>
In-Reply-To: <20260922232440.598918-10-florian.fainelli@broadcom.com>
References: <20260922232440.598918-10-florian.fainelli@broadcom.com>
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

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The unbalanced wol_clk disable on resume that this patch
  targets can still happen when enabling the clock fails.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is serious.
- [Medium] The timeout check in bcm_sysport_suspend_to_wol() is inverted.

--

net: systemport: Fix unbalanced Wake-on-LAN clock disable in resume

bcm_sysport_suspend() prepares and enables the Wake-on-LAN clock only
when both device_may_wakeup() and priv->wolopts are true. However,
bcm_sysport_resume() disabled it whenever priv->wolopts was set. This
patch makes resume use the same check as suspend so that
clk_disable_unprepare() is not called unbalanced.

> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index 11b2cb4cc7927..dedd49ad6c4ef 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -2799,7 +2799,7 @@ static int __maybe_unused bcm_sysport_resume(struct device *d)
>  		return ret;
>  	}
>  
> -	if (priv->wolopts)
> +	if (device_may_wakeup(d) && priv->wolopts)
>  		clk_disable_unprepare(priv->wol_clk);

[Severity: Medium]
Does this fully balance the wol_clk enable and disable? In
bcm_sysport_suspend(), the return value of clk_prepare_enable() is
ignored:

    if (device_may_wakeup(d) && priv->wolopts) {
        clk_prepare_enable(priv->wol_clk);
        ret = bcm_sysport_suspend_to_wol(priv);
    }

When clk_prepare_enable() fails, it undoes its own prepare, which leaves
wol_clk neither prepared nor enabled. Suspend still returns 0 as long as
bcm_sysport_suspend_to_wol() succeeds.

On resume, the new check above is true again. clk_disable_unprepare()
then runs on a clock that was never enabled. The common clock framework
would warn with "already disabled" and "already unprepared". WoL would
also be armed without its clock for that cycle.

Should the return value be checked in suspend, and then either skip WoL
or record in a flag that resume tests whether the clock was enabled?

>  
>  	umac_reset(priv);

[Severity: High]
This isn't a bug introduced by this patch, but there is a related wol_clk
imbalance in the suspend error path. When bcm_sysport_suspend_to_wol()
returns -ETIMEDOUT, bcm_sysport_suspend() has already enabled wol_clk. It
still gates priv->clk and then returns the error:

    if (device_may_wakeup(d) && priv->wolopts) {
        clk_prepare_enable(priv->wol_clk);
        ret = bcm_sysport_suspend_to_wol(priv);
    }

    clk_disable_unprepare(priv->clk);

    return ret;

After a failed ->suspend(), the PM core leaves dev->power.is_suspended
false and does not call bcm_sysport_resume(). The wol_clk enable leaks,
and every later cycle enables it again but disables it only once.

The error path in bcm_sysport_suspend_to_wol() only calls
mpd_enable_set(priv, false). RBUF_ACPI_EN and the RXCHK filter match
bits stay set.

The device is also left with the core clock off, the netdev detached,
the rings freed and NAPI disabled, while netif_running() is still true.
Can the next suspend or interface down then hang?

    bcm_sysport_suspend() or bcm_sysport_stop()
      bcm_sysport_netif_stop()
        napi_disable(&priv->napi)

napi_disable() on a NAPI that is already disabled waits for
NAPIF_STATE_SCHED to clear, with no timeout. Nothing will ever clear it.

Right now -ETIMEDOUT is only returned when RBUF_WOL_MODE appears on the
very last poll (see below). A corrected timeout check would send every
real timeout down this path.

Should this error path undo the wol_clk enable and restore the device
state before it returns?

[Severity: Medium]
This is also a pre-existing issue, but is the timeout check in
bcm_sysport_suspend_to_wol() inverted?

    unsigned int timeout = 1000;
    ...
    do {
        reg = rbuf_readl(priv, RBUF_STATUS);
        if (reg & RBUF_WOL_MODE)
            break;

        udelay(10);
    } while (timeout-- > 0);

    /* Do not leave the UniMAC RBUF matching only MPD packets */
    if (!timeout) {

On a real timeout, the final "0 > 0" test fails and the post-decrement
wraps timeout to UINT_MAX, so !timeout is false. MPD stays enabled,
UniMAC RX is turned on, and 0 is returned even though RBUF never entered
WoL mode.

It also goes wrong the other way. If RBUF_WOL_MODE is seen on the last
iteration, the loop was entered with timeout == 0 and breaks with it
still 0. A successful WoL entry is then reported as -ETIMEDOUT, which
takes the failed-suspend path described above.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922232440.598918-1-florian.fainelli%40broadcom.com
