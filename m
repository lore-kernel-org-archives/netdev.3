Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F0D390CB8;
	Wed, 30 Sep 2026 03:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790740140; cv=none; b=kV/J6LLT7fgb3pP6tvfd5lpUARNI2J8PNyR8V73K0AWTiIJSv1mGiAfW+T8NXyKIqY6ecTS1CUHPqhZd62DECJOth6irBYCjOjd5re1u7tUhknwScDDBmd8QitNUD32VKTgInkCyNEjk8XW8d4OLHb4WSdZlHdlRt8CitS22fuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790740140; c=relaxed/simple;
	bh=Bi6SzUITqsWI5D+9gZMq4RgRtXzfVHUdW5uFZc0YkoY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YRt5wpggpMjpmWLNqZFwyUMhhSQoV5cTSAtFgU9EI5JCJyjxVrX9jwqVp+ePpfVgs7gVNNsR+UtVLIXV+UFFLL02YJJ1/NIXFsgVd5r5b+YktgEvvO/vxKUpNyYHw6oKoZrcpJpuDHLFfUYRew6fbrhcv84zlTrEgbqaHeXC2to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlgIWLOr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlgIWLOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF7A1F00898;
	Wed, 30 Sep 2026 03:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790740135;
	bh=4dq8t7Q8QvbHbJbu7xUVJxUkYlM267SUwA5lU7qHTTk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QlgIWLOr9zVTI0AXvEiO3C7UIvkRWzhOvEMTjBaGlLQx36N9OOLrhTGYn9GfPmn9D
	 OxJ2l9B1VN4R7PRASGc6TJMynIp4Gb57S1aY/Ex/tktl86BKdrTtgvsm+arijbLXGQ
	 jbO4FI/nHFkKqny6yhMzVHtNz4YI+FUKHuMO4u6DAF8s/7w9M6bdJBIaa6HzJKypji
	 gqJ/vnnxVtJO/noxn/0dnQpRvMPWErk6+V+rdXNBsfF+hdOWiOryxMn2Ikd5idEELE
	 zsVImqk7Xx5Oxr9Gp7NOzp99O56R3eoy7G9ENzM/jB7U2JFiQqgoLLscQI3EHcqtVg
	 4/bXTIxKFmvlw==
Subject: Re: [PATCH net-next v18 6/6] net: dsa: mxl862xx: document devlink
 flash and info support
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Wed, 30 Sep 2026 03:48:54 +0000
Message-ID: <179074013437.434549.6936491828121414928@kernel.org>
In-Reply-To: =?utf-8?q?=3Cc555c5507ffce3827917d9fb629b19cf928894cc=2E1790426?=
 =?utf-8?q?599=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3Cc555c5507ffce3827917d9fb629b19cf928894cc=2E17904265?=
 =?utf-8?q?99=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new Documentation/networking/devlink/mxl862xx.rst (lines
  82-87) gives different remedies for different rescue-recovery failures.
- [Low] In the fw row of Documentation/networking/devlink/mxl862xx.rst
  (lines 47-49), the sentence "Use ``devlink dev flash`` to tell a…

--

net: dsa: mxl862xx: document devlink flash and info support

This commit adds Documentation/networking/devlink/mxl862xx.rst. The file
describes the mxl862xx devlink info versions and the flash update
behaviour, including MCUboot rescue mode recovery. It also links the file
from the devlink index and adds it to the driver's MAINTAINERS entry.

> diff --git a/Documentation/networking/devlink/mxl862xx.rst b/Documentation/networking/devlink/mxl862xx.rst
> new file mode 100644
> index 0000000000000..c2dfc72ef9a40
> --- /dev/null
> +++ b/Documentation/networking/devlink/mxl862xx.rst

[ ... ]

> +   * - ``fw``
> +     - running, stored
> +     - 1.0.70
> +     - Version of the firmware running on the switch, reported as both
> +       running and stored since the switch boots it from its own flash.

[ ... ]

> +       running only, since the driver cannot tell what the flash holds
> +       while the loader runs. Use ``devlink dev
> +       flash`` to tell a recovering switch from a ready one, see below;
> +       a missing version on its own does not say why.

[Severity: Low]

Is this the right pair of states? mxl862xx_devlink_info_get() already
shows whether a rescue-mode switch is ready, without changing anything:

	if (READ_ONCE(priv->rescue_mode)) {
		if (!READ_ONCE(priv->rescue_ready))
			return 0;
		...
		return devlink_info_version_running_put(req,
				DEVLINK_INFO_VERSION_GENERIC_FW, buf);
	}

On a ready switch, devlink dev flash does not report a state. It closes
the ports and flashes the image.

Two states omit the version: a switch that is still recovering, and one
whose recovery failed. Those are the two that flash tells apart, with
-EBUSY "switch is recovering an interrupted download" and -EIO "loader
cannot accept a download".

Also, mxl862xx_devlink_flash_update() validates the image before either
of those checks:

	ret = mxl862xx_flash_validate(priv, params->fw, &payload_size);
	if (ret) {
		NL_SET_ERR_MSG_MOD(extack, "firmware image validation failed");
		return ret;
	}

	/* Refuse to flash while the background self-heal is still draining, and
	 * for good once it has given up on the loader.
	 */
	if (READ_ONCE(priv->rescue_failed)) {
	...
	if (READ_ONCE(priv->rescue_mode) && !READ_ONCE(priv->rescue_ready)) {

So the documented -EBUSY and -EIO only appear when a valid signed image is
supplied. A placeholder file gets the validation error instead. Could the
document mention that?

[ ... ]

> +If the driver gives up on the recovery, ``devlink dev flash`` returns
> +``-EIO`` and says so in its extack message. The drain runs once and is
> +never resumed, so a failed MDIO transaction ends it as well. A loader
> +that stops answering the drain needs a power cycle; a completed drain
> +whose reprobe could not be scheduled, and a drain a bus error cut
> +short, need only a driver rebind. The driver re-examines the switch

[Severity: Medium]

How can a user tell these cases apart? Take the case of a completed drain
whose reprobe could not be scheduled. mxl862xx_rescue_heal_work_fn() only
sets the flag and logs nothing:

	if (device_schedule_reprobe(dev, MXL862XX_FW_REPROBE_DELAY_MS))
		WRITE_ONCE(priv->rescue_failed, true);

The drain error path just above it logs "flash: download recovery failed:
%pe". The flash path's own reprobe failure in
mxl862xx_devlink_flash_update() also logs a message:

	err = device_schedule_reprobe(ds->dev, MXL862XX_FW_REPROBE_DELAY_MS);
	if (err)
		dev_err(ds->dev,
			"flash: re-probe could not be scheduled (%pe); unbind and rebind to reinitialise\n",
			ERR_PTR(err));

The heal path seems to be the only one that says nothing.

After that, mxl862xx_devlink_flash_update() returns the same -EIO and
extack for every rescue_failed cause:

	if (READ_ONCE(priv->rescue_failed)) {
		NL_SET_ERR_MSG_MOD(extack, "loader cannot accept a download");
		return -EIO;
	}

In the completed-drain case the extack is also wrong. The drain finished,
so the loader is at READY or a firmware has booted.

The v18 changelog says "a re-probe that cannot be scheduled is logged on
every path". That doesn't seem to hold for the heal path.

The errno and extack are the same and the log is empty. Is there a way
for a user to choose between the rebind and the power cycle described
here? The @rescue_failed kernel-doc in mxl862xx.h also sends readers to
this document, saying "the remedy depends on the cause".

The list of causes also leaves out two drain failures from
mxl862xx_rescue_drain() and mxl862xx_rescue_drain_finish(): -ETIMEDOUT
"did not drain after %u chunks" and -EIO "loader still busy after the
erase window". Which remedy applies to those?

> +when it binds and at no other time, so a power cycle on a board where
> +the switch can be cycled on its own still has to be followed by an
> +unbind and rebind for the recovered switch to be recognised.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790426599.git.daniel%40makrotopia.org
