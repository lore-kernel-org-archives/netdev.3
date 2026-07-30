Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ACC3264F1;
	Thu, 30 Jul 2026 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447001; cv=none; b=rgSZjvgpMKOVXAulBXfE19A5yL9TpM54k6sOIDGabsN3H3HWGTR+hmBB36hFPTOWWQAVY6m05XVmeQu4d+/MPPC93LNjPyZXpPTCiZkuwha6OC7cn1pWlDThw3g6tFn5X9ZHw1q5omZjOlKuJo1y1gnJbKoQ+8l+humQL4D7Ezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447001; c=relaxed/simple;
	bh=GkLFfAiUjew/JKSAjfg7zvVezyZXAnky/0wqk4cx/8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9GDL0nbLGfQ7StVXfyJAiGOe548vLpO8Sq0HTAzt+OypAgiJT0FYeXnBAxXIVUFsfzx5HWHmWpsIqCmoWiR9uMd1Yg74ZZzDDInXCrHHTk0RIq+81Qmc7kYuUtDmG/P6wf2hCM+JAmOEWTK+LRSpRXwkpF2Q2Z6Bgmp0Cp173U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=URxRTSUW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="URxRTSUW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=B5axHUZyTZ+dZ8oS+he0haGxtMrwBrygnxKTL9ukhLg=; b=URxRTSUWJpGoXTekd7TUVnwwlX
	BznA9QYR4/SGbXfkXjQc3HdrSJW4wxtZ3SgTIEA7PhELxlXAObsL9A1zGkmY8z36nF3xeJx9mjx95
	mO8w5unCj7r0SXFee0iuj5uKAQZgP+C3uxYzJbxbPmmMOu84X3f2rVAKnh8lQK1kRs0A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wpYK3-00F466-3F; Thu, 30 Jul 2026 23:29:47 +0200
Date: Thu, 30 Jul 2026 23:29:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/5] net: dsa: mxl862xx: add devlink
 flash_update and info_get
Message-ID: <14be7694-8ec7-40b9-8845-d93896ed822c@lunn.ch>
References: <cover.1784945329.git.daniel@makrotopia.org>
 <73a63f1d11658a041514f79ae177bfb93153d33a.1784945329.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73a63f1d11658a041514f79ae177bfb93153d33a.1784945329.git.daniel@makrotopia.org>

> The switch leaves MCUboot on its own by booting the new image, but the
> driver has no in-place path back, so it reinitialises with a full
> device_reprobe() scheduled regardless of the transfer outcome -- after a
> failure the switch is still in MCUboot and probe re-detects it. During
> the teardown its API reads return -ENODEV and writes fake success, so it
> neither stalls on the absent firmware nor consumes buffers it never
> filled. The reprobe holds module and device references taken before the
> switch was disturbed and runs from a heap work item, not a kernel
> thread: remove() frees the devm-managed priv, and kthread_create() in
> the devlink caller would return -EINTR on interrupt or trip the
> hung-task watchdog while parked across the minute-long flash.

Just for my understanding....

The reprobe causes all the user point netdevs to be destroyed, and are
then recreated?

That seems like a good solution to the issue of all state information
has been lost in the switch.

> +static int mxl862xx_sb_pdi_poll_stat(struct mxl862xx_priv *priv, u16 expected,
> +				     unsigned long timeout_ms)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
> +	int ret;
> +
> +	do {
> +		ret = mxl862xx_smdio_read(priv, MXL862XX_SB_PDI_STAT);
> +		if (ret < 0)
> +			return ret;
> +		if ((u16)ret == expected)
> +			return 0;
> +		usleep_range(10000, 11000);
> +	} while (time_before(jiffies, timeout));
> +
> +	return -ETIMEDOUT;

I suggest using iopoll.h. This code has the usual bug when rolling
your own.

> +/* Post-flash reprobe. Runs from a self-contained heap work (not a kthread and
> + * not the devlink caller's context): kthread_create() in the caller context
> + * fails -EINTR if the devlink command was Ctrl-C'd, and schedule_work() cannot.

A English sentence should not finish with the word "cannot".

> +	/* Failures from here on must go through end_magic so MCUboot
> +	 * reboots instead of waiting forever.
> +	 */
> +	ret = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_SB_PDI_READY,
> +					MXL862XX_FW_READY_TIMEOUT_MS);
> +	if (ret) {
> +		dev_err(&priv->mdiodev->dev,
> +			"flash: bootloader not ready: %pe\n", ERR_PTR(ret));
> +		return ret;

What about the comment above? end_magic?

     	   Andrew
