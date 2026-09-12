Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B6322FF22;
	Sat, 12 Sep 2026 00:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789172936; cv=none; b=cqtFDOp6uKagJ+5AjJGoqIe88df9Qvp18rfRQXTMYgeFrhj+U9ueBhUGN2t/2vHW8ewubzfGGaLTz4RGtQLKTSvU5wuTvFNVyQmOQLujGQTI7jEtuGjXjZCi3YFV0RnKBAAJVs5+CXnLq3adp99hQleIPMiBTyUC+qX96TzAAPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789172936; c=relaxed/simple;
	bh=eToU4BHQ6da9kVpf5qP3yx4Og2UglyPSx3RDqR0I63w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WiBWiFvUpA5ibqSnFA21QUyjQ84UDoOC2objkb4wyVTcF74G6Beld/mB1Rm3O20ZQSMXjSZgehl6oSAIQaRdkBceM43uCQ06q2KCmxioQF9YYC4YPTicSkzDoG7OryUuuAE8ofMTDNJLc3nxmcn/bEjiUj1Y6pHjb175A0CR1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Upfg1afm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Upfg1afm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C51D1F000FF;
	Sat, 12 Sep 2026 00:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789172934;
	bh=CTD3K0LRtS7se4NoRtsizVYkgPim6OQ+nwetjOdhM84=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Upfg1afmn8w66u9POsKP11EqOYbYjnO2qrCGwk32UGLq5FD2MU65RbLcqcwoc43xh
	 up8fkxF5DWlDnhHks7e6KSQ7T2kpSFj5jf6xIjNry2t4kgTbOn0xJRhuprvbo47kWl
	 OjmueHPb0gqShW5T0EhIR47uchqzs+JoTLoQ+3RR0i0Sd59GHGy5SvWqWpo5OiHE9h
	 zbBc5YtN+VfA8h1oYk60/l/fDMvLVDXmy6PAcDHThLwFyjcUUTKiuO5XIoklJOL09L
	 vP4l7JhAMs/BzZgdJED9/xnUpghQEh87aQ8AtB7S+bHCUA7BXGkIl02UC1qygQMZ7e
	 fE9prWDRM6X0g==
Subject: Re: [PATCH net-next v14 1/6] net: dsa: add devlink flash_update
 callback to dsa_switch_ops
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Sat, 12 Sep 2026 00:28:53 +0000
Message-ID: <178917293319.219967.10417320204779425879@kernel.org>
In-Reply-To: =?utf-8?q?=3Cd7a5b34bdb1e9c171aa9af94d435dea08c05e363=2E1788976?=
 =?utf-8?q?064=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3Cd7a5b34bdb1e9c171aa9af94d435dea08c05e363=2E17889760?=
 =?utf-8?q?64=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] net/dsa/devlink.c now installs `.flash_update =
  dsa_devlink_flash_update` unconditionally in the single shared…

--

net: dsa: add devlink flash_update callback to dsa_switch_ops

This adds a devlink_flash_update callback to dsa_switch_ops and a
trampoline in net/dsa/devlink.c that forwards to it, returning
-EOPNOTSUPP when the driver does not implement the callback.  The
trampoline is installed unconditionally in the shared dsa_devlink_ops.

(No Link: tags in the commit header.)

> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 7507d632e7c6d..9babab92a0fc6 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -1174,6 +1174,9 @@ struct dsa_switch_ops {
>  	int	(*devlink_info_get)(struct dsa_switch *ds,
>  				    struct devlink_info_req *req,
>  				    struct netlink_ext_ack *extack);
> +	int	(*devlink_flash_update)(struct dsa_switch *ds,
> +					struct devlink_flash_update_params *params,
> +					struct netlink_ext_ack *extack);
>  	int	(*devlink_sb_pool_get)(struct dsa_switch *ds,
>  				       unsigned int sb_index, u16 pool_index,
>  				       struct devlink_sb_pool_info *pool_info);
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
>  static int dsa_devlink_sb_pool_get(struct devlink *dl,
>  				   unsigned int sb_index, u16 pool_index,
>  				   struct devlink_sb_pool_info *pool_info)

[ ... ]

> @@ -169,6 +181,7 @@ dsa_devlink_sb_occ_tc_port_bind_get(struct devlink_port *dlp,
>  
>  static const struct devlink_ops dsa_devlink_ops = {
>  	.info_get			= dsa_devlink_info_get,
> +	.flash_update			= dsa_devlink_flash_update,

[Severity: Medium]
Since dsa_devlink_ops is a single const structure shared by every DSA
switch, does installing .flash_update unconditionally make the devlink
core's capability probe always succeed for DSA?

The core uses the presence of the op as the gate, in
devlink_nl_flash_update_doit():

	if (!devlink->ops->flash_update)
		return -EOPNOTSUPP;

With the trampoline always present, that check can no longer fire for
any DSA switch, and the -EOPNOTSUPP from dsa_devlink_flash_update() is
only reached after the core has already done work:

net/devlink/dev.c:devlink_nl_flash_update_doit() {
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
	...
}

The commit message covers the firmware fetch:

    the devlink core will then have fetched the firmware file from
    userspace before the request fails, which is acceptable for an
    operation as infrequent as a firmware update.

Are the other two effects of that ordering intended as well?  A
FLASH_UPDATE / FLASH_UPDATE_END notification pair is now broadcast to
monitors for a flash that never reached any hardware, and if the named
file does not exist the caller gets -ENOENT with the extack "failed to
locate the requested firmware file" rather than -EOPNOTSUPP, which hides
the fact that the switch cannot be flashed at all.

There is also a second entry point that the commit message does not
mention.  DSA user ports have no ethtool_ops->flash_device but do have a
devlink port, so ETHTOOL_FLASHDEV falls through:

net/ethtool/ioctl.c:ethtool_flash_device() {
	if (!dev->ethtool_ops->flash_device) {
		req->devlink = netdev_to_devlink_get(dev);
		return 0;
	}
	...
}

which lands in devlink_compat_flash_update(), where the same gate is now
always passed and the op is called with extack == NULL:

net/devlink/dev.c:devlink_compat_flash_update() {
	...
	if (!devlink->ops->flash_update) {
		ret = -EOPNOTSUPP;
		goto out_unlock;
	}

	ret = request_firmware_direct(&params.fw, file_name, devlink->dev);
	...
	ret = devlink->ops->flash_update(devlink, &params, NULL);
	...
}

Should any extack message a DSA driver sets be documented as dropped on
that path?

Would gating the assignment of the .flash_update pointer on
ds->ops->devlink_flash_update (for instance a second devlink_ops variant
selected at registration) keep the core's probe truthful?  The existing
trampolines this one follows (info_get, sb_*) are pure queries with no
core-side side effects before the op is called, so the -EOPNOTSUPP-from-
the-trampoline convention does not carry the same cost there.

For context on the series: at the end of the range mxl862xx does
implement devlink_flash_update, so that driver has a real
implementation, but all other DSA drivers (b53, mv88e6xxx, microchip,
ocelot, sja1105, ...) still advertise flash support without one.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788976064.git.daniel%40makrotopia.org
