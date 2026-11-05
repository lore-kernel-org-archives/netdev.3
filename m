Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873317;
	b=rKgVIK89U33dbwWP/lu6V4yzOQUvEMT7VCoYWzyLfJXiFSIDhD1QSWmx1dqrDIpxBkNO
	 1LAaLuulfg7vopEnlJFMF1Kr0ZeHnZ94F5Z/WYcD6UW3LJ5CNJuDFH7Smcjewyetu+76j
	 oQR9YsX7uHyFfuuR4ZHDbieZcIEJwo67u/1T8TW03svbIqKj7V4HL3j6HUe8gM/bxjKU1
	 y9VgMGZRFnCQiTdkRNhPtI1xaMvQ2i0X8WB5N3a/tR+MAHHoymXxry8n82wuCs5/Ky8VC
	 4YXyZ2mC30o0OlqjvY3L6af36tIDtpchvvq4dnujHm/XbKypEbMySiPypONQqgFlmuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873317;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=N6AE4P7gJc5QCWHdSGV8OXNHdYwxH3AcE81yYUGoqK0=;
	b=qTXFp/A6zcc+s2PYm3LH06NFm+b/1xzoP6HOHqA0qTSdNBLZV0NqDs3OMtyaBKWKeGIK
	 zWBQW+m0EIfE+Pi+Rcf5Ui9z2Tqr/hVhzWuhDNSLgE/dXF+cmTLwCI5If4PATkkaxs4yw
	 Hjw2eHJ1o5vnZvOqXeyfcxlx/lgzftRTOQcJ/CY/hnxaLEfZSpBPUpuH1yYFxkY1CMQLT
	 u5ACDci48njKlhjEGsBsHDRpnxZJDRe/NyVG0rdzdXOf1UqQ3Ox/TldCQVYxiRU7c5s2e
	 KPOItRh/Smv/c8M8LFNrWE5mfGC9yws6rbIc657/RrYzZiTkluhUqVgaakgbIMM47AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OQ+pAV/5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A77608362C;
	Thu,  5 Nov 2026 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQ+pAV/5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7B31F000C1;
	Thu,  5 Nov 2026 10:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793873317;
	bh=N6AE4P7gJc5QCWHdSGV8OXNHdYwxH3AcE81yYUGoqK0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OQ+pAV/5YXN/zn0H23OPLUQodmXHXDzbfWmosc0j8sSJMXLjM3GSjGUVnRqS6dIkv
	 gm6akoUHbpcj/iih6S7yrSymd0dsRnPu/ieH5ehSXsHNFHE0NvFGGW4l44XpXegmgX
	 oA6unzJUntQ3WE7QcL6GA3BuyBTEpGBUtntqtKpdeEBav+3diXVdEygDrRIrLNQfgl
	 OgVq20krqxXzfLBUNjG+Qo6Lrcvtvn/9i2vooG33vXqMqWn+Mrrmgx3uZ0EmT8fpVN
	 0PwNE/qoyryhUsGcazja8U1oPuu5LjMhWvM7+X4mV/wT7QpnhD1IAfnEBiYLMBi/Fo
	 1+P/mFwcvHZ0w==
Subject: Re: [PATCH net v3 08/14] net: pse-pd: stop async event sources before
 freeing PI data in unregister
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
 maxime.chevallier@bootlin.com, kyle.swenson@est.tech, ross@r-sc.ca,
 netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 05 Nov 2026 10:08:35 +0000
Message-ID: <179387331572.488856.14138423432886028016@kernel.org>
In-Reply-To: <20261103220217.1131971-9-github@szelinsky.de>
References: <20261103220217.1131971-9-github@szelinsky.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] net: pse-pd: spurious error event in pse_isr() on -ENODEV
  during unregister

--

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -612,6 +612,13 @@ static int _pse_pi_delivery_power_sw_pw_ctrl(struct pse_controller_dev *pcdev,
>  	struct pse_pi *pi = &pcdev->pi[id];
>  	int ret, pw_req;
>  
> +	/* pse_isr(), a priority change and the retry after a disable all
> +	 * power a PI through here, so stop them here once unregistering
> +	 * has started.
> +	 */
> +	if (pcdev->unregistering)
> +		return -ENODEV;
> +
>  	if (!ops->pi_get_pw_req) {
>  		/* No power allocation management */
>  		ret = ops->pi_enable(pcdev, id);

[Severity: Medium]
pse_isr() can report a false power control error during unregister.

Say the threaded pse_isr() is already blocked on pcdev->lock when
pse_controller_unregister() sets pcdev->unregistering and drops the
lock. It then takes the lock while disable_irq() is still waiting for
it to finish.

For a classification event on a PI with admin_state_enabled set,
pse_set_config_isr() calls _pse_pi_delivery_power_sw_pw_ctrl(). That
now returns -ENODEV at this new check.

pse_set_config_isr() only clears -ERANGE, so -ENODEV goes back to
pse_isr(). pse_isr() treats any non-zero return as a failure and sets
ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR for that PI. It pushes the event
into pcdev->ntf_fifo and schedules ntf_work before cancel_work_sync()
runs.

If pse_send_ntf_worker() is already running at that point, it can
pick up the entry and send it through ethnl_pse_send_ntf(). Userspace
then sees a power control error for a PI that did not fail; the
controller is only going away.

This is not a memory safety problem, since disable_irq() orders the
queueing before the drain, but the event is misleading.

Should pse_set_config_isr() filter the -ENODEV from the unregistering
check the same way it filters -ERANGE? Or would you rather have
pse_isr() skip the PIs once pcdev->unregistering is set?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103220217.1131971-1-github%40szelinsky.de
