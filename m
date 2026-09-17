Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC37C3370EC;
	Thu, 17 Sep 2026 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661488; cv=none; b=C3EoOm1NARQPH374r6D+2r9XSLKGbG/llwFXeGx2+a5dA+DTXVIR/QgBDfKOw9Ee595CmsnY1A1/YkvbnP2k1qLCNUzx7jbyzj9ch+Iq8iM+sRgmACOL/q9PptGrdBOjWhLraFb3cl4v/Ipai+E6aiRFXb78JiQ9Wbupj3Y0+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661488; c=relaxed/simple;
	bh=ArXTOPKWVCATv1fOfsoP2J6QBP1TeCp6Y1pnym5RlvM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bcragbTUmnUEpIHV4ZQi5jqeM7DCQ6FWRXo3eJAX0rdy9MsQNow/sFjvcn4UiDcurCj60s0XQhTn0GqEJjidm4/SLqN9ha/jE41R8FAY67YTP0q7ZJynak99++cbT2uWrGDroyYXX9BFc2d6c9xk0xWV7WtMpR/TSOzMmmtfNow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jfnxw57I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jfnxw57I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605401F000FF;
	Thu, 17 Sep 2026 16:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661486;
	bh=Ebsh1KMx217fm158u7uy5sWFmLM+nujOSFOT3DBKvTQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Jfnxw57IHeUaAY+x7hQqS2llkegFEAZwuBKAMKOMQFqR9ACyrvF7o693hrVAngWop
	 MOwEzQilTcj6fREzhuGH7+od+yHMnYnMrlHKW9/GRSlfi7aKvvehWcrwAqwkYFYtBW
	 qdqK1//cpCqQnHI+QXyM4FpEP99aDbfyPDhSLhrupnPl7rqyMDUHrRGVZX28DZCWQE
	 j7myKMRy1OXBxJxhS9OUSJPHjZzn5Pzhol1JlxykLv7j6CYDT2cPzrlNJG0WQrYB/9
	 UBSRj1GiD5RseX0jI7rMACUl4WgyURUkkp7dnyrRZStqAE++yJYfdiyZf8JLYKnOFc
	 XuG8MwUhgrjOw==
Subject: Re: [PATCH net-next v16 1/6] net: dsa: add devlink flash_update
 callback to dsa_switch_ops
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Thu, 17 Sep 2026 16:11:24 +0000
Message-ID: <178966148491.22033.3197063094980170397@kernel.org>
In-Reply-To: =?utf-8?q?=3C38abd1efa0da34be260c5799a18df401b7494a0a=2E1789477?=
 =?utf-8?q?568=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3C38abd1efa0da34be260c5799a18df401b7494a0a=2E17894775?=
 =?utf-8?q?68=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
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

- [Low] Installing `.flash_update = dsa_devlink_flash_update`
  unconditionally in the single shared `dsa_devlink_ops` removes the…

--

net: dsa: add devlink flash_update callback to dsa_switch_ops

This adds a devlink_flash_update callback to dsa_switch_ops and a
trampoline in net/dsa/devlink.c that forwards to it, returning
-EOPNOTSUPP when the driver does not implement the callback. The
.flash_update op is installed unconditionally in the shared
dsa_devlink_ops table.

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
This isn't a bug as such, since the commit message states the trade-off,
but is the full extent of the behaviour change on switches without the
callback covered?

Since dsa_devlink_ops is shared by every DSA switch, the core gate in
devlink_nl_flash_update_doit() now always passes:

net/devlink/dev.c:devlink_nl_flash_update_doit() {
	if (!devlink->ops->flash_update)
		return -EOPNOTSUPP;
	...
	file_name = nla_data(nla_file_name);
	ret = request_firmware_direct(&params.fw, file_name, devlink->dev);
	...
	devlink_flash_update_begin_notify(devlink);
	ret = devlink->ops->flash_update(devlink, &params, info->extack);
	devlink_flash_update_end_notify(devlink);
}

So on a switch that does not set ds->ops->devlink_flash_update, a flash
request now reads the entire userspace-named file from the firmware search
paths into kernel memory before dsa_devlink_flash_update() gets to return
-EOPNOTSUPP.

Beyond the -ENOENT versus -EOPNOTSUPP change already described, does this
also mean that on such switches a flash request becomes a file-existence
probe of the firmware search paths, performs an unbounded read of a
/lib/firmware file into kernel memory, and emits a FLASH_UPDATE /
FLASH_UPDATE_END pair to devlink monitors for an operation that can never
succeed?

For reference, path traversal is not a concern here:
_request_firmware() rejects names containing ".." via
name_contains_dotdot(), and the operation requires CAP_NET_ADMIN.

Would it be worth mentioning the firmware read and the notifications for
switches without the callback in the commit message, in addition to the
errno change?

>  	.sb_pool_get			= dsa_devlink_sb_pool_get,
>  	.sb_pool_set			= dsa_devlink_sb_pool_set,
>  	.sb_port_pool_get		= dsa_devlink_sb_port_pool_get,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1789477568.git.daniel%40makrotopia.org
