Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B54137B40C;
	Mon, 14 Sep 2026 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789410896; cv=none; b=KlwmunIkETA0BjRjrIUCV+K/sPlmR+HcFwx3btXYa2ehQoUB3hwMm6T7K96566B5BzPqL+kXdWbbOs99fqtw1w7q4OvOzcd3rZ4A8Q/oAVFmu/y9M8qua8lOUEDzyUtk2WWyLWMMawu2FIC5VJQKgJOhDnkFL2w6p6qcoi0Vz3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789410896; c=relaxed/simple;
	bh=HeEHSOmnu6L0MO+BvK8YZCzbsf5XxGPND3GMPmB3hBs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HpqfeJEZfQ4aKfCQPdC1KG/8AlA3Ez7FV+hWwgBmTnvO+bGWU7Amn0afj5hmMauunLRVR2bTPTHlbBIplbUYGkXLeuUeiSMCMAeYFKunbDe1P9UVhmyHtEZ7KCN/u+PYjz/hZ8GLcO8DtkqllwN5bYDWV8N1qJ0wzvJj2oeDuUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqJaG1dc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqJaG1dc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7899A1F00893;
	Mon, 14 Sep 2026 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789410893;
	bh=zuQ/cNLib+ohmA59rvN9InBTbPJi2qXYvtBFBlrAdGE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nqJaG1dcJayOMBnu2uuw6XjZBRPU4XOcId6PE3UBFB3sRu3lUaLGUlZtyXgSn88a8
	 DhWyLabQW0B7ttHmNuRjKNGJaNz6sZWDDGKxsDuyeV5dwWecayGIogEJo00EFxRYF1
	 AfkTTllMlvrTaecUvImio6rGTNXivEC6drRXfnz/3uqvskNnLfVcblG1pZfJi5tF38
	 6DDKwCFNy7qHTR8xUqe0GKAFPRzpSfyI4o2idA016BQKpqJJcIxCZ0KaAPgHJyayxL
	 e9OKOl59Fd/MjcuFHX8aFuwmm/oFlxtJf2jYqdZ/Zgc6g+lEfkO2W3s5wrAzyf8ktm
	 14qstqILo3K/w==
Subject: Re: [PATCH net-next v15 1/6] net: dsa: add devlink flash_update
 callback to dsa_switch_ops
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Mon, 14 Sep 2026 18:34:51 +0000
Message-ID: <178941089199.22033.6731579125161335389@kernel.org>
In-Reply-To: =?utf-8?q?=3Ca35ce7431d32ff6802e1bd1d5f0988756cd91e82=2E1789175?=
 =?utf-8?q?618=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3Ca35ce7431d32ff6802e1bd1d5f0988756cd91e82=2E17891756?=
 =?utf-8?q?18=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] net/dsa/devlink.c installs `.flash_update =
  dsa_devlink_flash_update` unconditionally in the single shared…

--

net: dsa: add devlink flash_update callback to dsa_switch_ops

This adds a devlink_flash_update callback to dsa_switch_ops and a
trampoline in net/dsa/devlink.c that forwards devlink dev flash requests
to the driver. The trampoline is installed unconditionally in
dsa_devlink_ops and returns -EOPNOTSUPP when the driver does not
implement the callback.

> diff --git a/net/dsa/devlink.c b/net/dsa/devlink.c
> index ed342f345692b..25311a87cbc56 100644
> --- a/net/dsa/devlink.c
> +++ b/net/dsa/devlink.c
> @@ -20,6 +20,18 @@ static int dsa_devlink_info_get(struct devlink *dl,
>  	return -EOPNOTSUPP;
>  }
>  
> +static int dsa_devlink_flash_update(struct devlink *dl,
> +				    struct devlink_flash_update_params *params,
> +				    struct netlink_ext_ack *extack)
> +{
> +	struct dsa_switch *ds = dsa_devlink_to_ds(dl);
> +
> +	if (!ds->ops->devlink_flash_update)
> +		return -EOPNOTSUPP;
> +
> +	return ds->ops->devlink_flash_update(ds, params, extack);
> +}
> +

[ ... ]

> @@ -169,6 +181,7 @@ dsa_devlink_sb_occ_tc_port_bind_get(struct devlink_port *dlp,
>  
>  static const struct devlink_ops dsa_devlink_ops = {
>  	.info_get			= dsa_devlink_info_get,
> +	.flash_update			= dsa_devlink_flash_update,

[Severity: Low]
Since dsa_devlink_ops is shared by every DSA switch, does this make
devlink->ops->flash_update non-NULL even for the majority of drivers that
do not set ds->ops->devlink_flash_update?

The devlink core uses that pointer as the capability gate for the whole
feature, in devlink_nl_flash_update_doit():

	if (!devlink->ops->flash_update)
		return -EOPNOTSUPP;
	...
	ret = request_firmware_direct(&params.fw, file_name, devlink->dev);
	if (ret) {
		NL_SET_ERR_MSG_ATTR(info->extack, nla_file_name,
				    "failed to locate the requested firmware file");
		return ret;
	}

	devlink_flash_update_begin_notify(devlink);
	ret = devlink->ops->flash_update(devlink, &params, info->extack);
	devlink_flash_update_end_notify(devlink);

With that early return now unreachable for DSA, two behaviour changes seem
to follow for switches that do not implement the callback:

- devlink dev flash with a missing or unreadable file returns -ENOENT with
  the extack "failed to locate the requested firmware file" instead of the
  previous -EOPNOTSUPP, which hides the fact that the device cannot be
  flashed at all.

- a DEVLINK_CMD_FLASH_UPDATE / DEVLINK_CMD_FLASH_UPDATE_END notification
  pair is multicast for a device where no flash takes place.

Does the same apply to the legacy ioctl path?  DSA user ports have no
ethtool_ops->flash_device, so ethtool_flash_device() falls back to the
attached devlink instance:

	if (!dev->ethtool_ops->flash_device) {
		req->devlink = netdev_to_devlink_get(dev);
		return 0;
	}

and devlink_compat_flash_update() carries the same gate that is now dead
for DSA:

	if (!devlink->ops->flash_update) {
		ret = -EOPNOTSUPP;
		goto out_unlock;
	}

so ethtool -f swpN file would read the file and emit the begin/end
notifications before failing.

There is also devlink_flash_component_get(), which infers component-update
support from ops->info_get being non-NULL; DSA's info_get trampoline is
installed unconditionally too, so a component request on a switch without
either callback now gets past that check as well.

The commit message covers part of this:

    the devlink core will then have fetched the firmware file from
    userspace before the request fails, which is acceptable for an
    operation as infrequent as a firmware update.

Could the errno change from -EOPNOTSUPP to -ENOENT and the emitted
FLASH_UPDATE/FLASH_UPDATE_END notifications be mentioned there as well, or
alternatively the ops table selected based on
ds->ops->devlink_flash_update?

>  	.sb_pool_get			= dsa_devlink_sb_pool_get,
>  	.sb_pool_set			= dsa_devlink_sb_pool_set,
>  	.sb_port_pool_get		= dsa_devlink_sb_port_pool_get,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1789175618.git.daniel%40makrotopia.org
