Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C63C81A9;
	Sun,  4 Oct 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129403; cv=none; b=m8ZOb8VfNWi/jphnbNlt/TCG6NIhIqGlGnrDXp7Tl9hdG9EfAWCEKRn7QjRFmix4hc9a7URbfgwbJIONMolDCYxDhi92VjBaPV+gvzeUGnYROEuQwBQZmFos+9b1eGIfjdWSpu06i+5zJAT7OWEP7+NgDkPYgrpQoaaWhnvcoOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129403; c=relaxed/simple;
	bh=Qk72ogs3loQk6MO/sXlmLlwMC8WoNFc+AIQHI1I0mgw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bi9rkme7lOYClpaWO6GkuGlaXhKJSAfFLwJHKUVTds2BBEYq15aQcysl6oXgzMvstLVXVRTic7OzSaJOG1xzHKd63wdUc5JTLXcPZ/j9zj540CtJ9XzrJ/t8m4YqV/HM/W73aR8pa+6+lxACjX+BV33Bd+9O5GVrqg8b8JFwEWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4OALko3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4OALko3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A057B1F000FF;
	Sun,  4 Oct 2026 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791129401;
	bh=BWwIwVvmKmVGrcElACqBBNV6CyWHLmJKq5YrRmgbZo4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m4OALko3QwlebnJUITGTaGzbwCLERIc9nDwxH7yr9AzZiM/BoBmvs0uMf/g4gv7Fo
	 RSsnfwixy9WWhgXomjPEN3J5agqB81oExrTa+7gXBgQbrHsNIuIfUTF5Unsg/dfq3p
	 S77ZYl3y70PSU5B9cqeDOiw6pKCEEOIqI7EdIOVKq7JoUNDRVxjiAxhgRTBcgZdehV
	 k3Z0IR1RoDigfeLtCx8TTc5slpi9XI8GEXJ2tt7Gbw+4k5L9kGFVgNBwkGLHLDFHTI
	 +oqSBaZLppXB8RuC+uiFS+LbNHFUHGJCd8HE1Oben+kLs9EaUFqZDzFElySpbF3WdZ
	 roX8CkCiMKthQ==
Subject: Re: [PATCH net-next v19 6/6] net: dsa: mxl862xx: document devlink
 flash and info support
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Sun, 04 Oct 2026 15:56:40 +0000
Message-ID: <179112940022.434549.1061439161294970031@kernel.org>
In-Reply-To: =?utf-8?q?=3C2f9c6249f77a1940ef64e04de8153ec4b5a5f08f=2E1791035?=
 =?utf-8?q?885=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3C2f9c6249f77a1940ef64e04de8153ec4b5a5f08f=2E17910358?=
 =?utf-8?q?85=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
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

- [Low] The new devlink document gives two different answers for what
  `devlink dev flash` returns after a flash whose reprobe could not be…

--

net: dsa: mxl862xx: document devlink flash and info support

This commit adds Documentation/networking/devlink/mxl862xx.rst. The new
file describes the devlink info versions and the flash update behaviour
of the mxl862xx DSA driver, including recovery from MCUboot rescue mode.
It is linked from the devlink index and added to the driver's
MAINTAINERS entry.

> diff --git a/Documentation/networking/devlink/mxl862xx.rst b/Documentation/networking/devlink/mxl862xx.rst
> new file mode 100644
> index 0000000000000..6ec2c793fd0f3
> --- /dev/null
> +++ b/Documentation/networking/devlink/mxl862xx.rst
> @@ -0,0 +1,118 @@

[ ... ]

> +   * - ``fw``
> +     - running, stored
> +     - 1.0.70
> +     - Version of the firmware running on the switch, reported as both
> +       running and stored since the switch boots it from its own flash.
> +       It is omitted while no firmware version is known: after a failed
> +       flash until the reprobe it schedules, and in MCUboot rescue mode
> +       while an interrupted download is still being recovered in the
> +       background, once that recovery has failed, or while the loader
> +       waits in an opening handshake nobody can finish. Once the loader
> +       is ready to accept a new image the version appears as "0.0.0",
> +       which no released firmware reports, so version-comparing tools
> +       offer any available release as an upgrade; it is reported as
> +       running only, since the driver cannot tell what the flash holds
> +       while the loader runs. A missing version on its own does not say
> +       why; ``devlink dev flash``, given an image file that passes the
> +       driver's validation, answers ``-EBUSY`` while the switch is still
> +       recovering and ``-EIO`` once it cannot be flashed from this
> +       binding, see below.

[Severity: Low]
Does this rule still hold after a flash whose reprobe could not be
scheduled?

Every flash in mxl862xx_devlink_flash_update() ends by setting
skip_teardown and scheduling a reprobe. If scheduling fails, the driver
only logs it:

	priv->skip_teardown = true;
	...
	err = device_schedule_reprobe(ds->dev, MXL862XX_FW_REPROBE_DELAY_MS);
	/* -EINVAL is a device being deleted, whose teardown takes over. */
	if (err == -EINVAL)
		err = 0;

Here device_schedule_reprobe() can return -ENOMEM or -EBUSY, and
rescue_failed is not set. The rescue path in
mxl862xx_rescue_heal_work_fn() does set it:

	ret = device_schedule_reprobe(dev, MXL862XX_FW_REPROBE_DELAY_MS);
	if (ret && ret != -EINVAL) {
		dev_err(dev, ...);
		WRITE_ONCE(priv->rescue_failed, true);
	}

>From then on, every later flash returns early. This happens before
mxl862xx_flash_validate() and before the rescue_failed -EIO check:

	if (priv->skip_teardown) {
		NL_SET_ERR_MSG_MOD(extack,
				   "a previous flash left the driver awaiting reinitialisation");
		return -EBUSY;
	}

If the transfer had also failed, fw_version was zeroed. In that case
devlink dev info shows no fw version, and devlink dev flash returns
-EBUSY until an unbind and rebind.

Under the rule in this row, that looks like "still recovering". In fact
the switch can no longer be flashed from this binding, and this row says
that case should give -EIO.

The Flash Update section below describes this case correctly as a
permanent -EBUSY ("further updates refused with -EBUSY, until it is
unbound and rebound").

The later paragraph, however, starts with "If the switch cannot be
flashed from its binding, devlink dev flash returns -EIO". It also lists
"a reprobe that could not be scheduled" as one of the causes, but that
only applies to the reprobe after the rescue drain.

Should the fw row and the -EIO paragraph make an exception for a failed
post-flash reprobe? Or should the flash path also move to the -EIO
state?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791035885.git.daniel%40makrotopia.org
