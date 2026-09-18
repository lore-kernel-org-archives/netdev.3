Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE403C3442;
	Fri, 18 Sep 2026 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719661; cv=none; b=S7aXdlEhB9IUmYokFfNn1hRRiewBQxY3lLa0GoHBFjPQ33JQOsATub97nhTdVFkat56JxPeYdM3N0QWLUoyCXWYwjlLf4GgkB4nwnV1KvBsgXNgQq0++l7uXInkz9G9dpNdu/9K/B2MdK39q16MToMfhGZa/KO5ZpgxhIBXDws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719661; c=relaxed/simple;
	bh=xQpX9a/Y+WR/DhECYzGFApAZQWD9dvBUby6YXXmyt0g=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=q3HrnSgxxv+vesgncpVG1S6Zqxm0/M8IOIru5M2w9Xh04xFM+d8MXeQLnIvVFHkd5xDxfGS1k+nb9TT3i6jg16+qZN09KIFTSJfm460Bmj5pMTbuknfwC0b0L5lfGqCx4C8eH//1gHtRSL9v2KRqrdYwzelBjwQY/HU/+FRN9Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=f4yZzFxY; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="f4yZzFxY"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E6ACEA5677;
	Fri, 18 Sep 2026 10:20:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789719647; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pEQBosxIJ+26bEDv/S9l9I/X3ieDbLMvxda8fO8kJpI=;
	b=f4yZzFxYUpeGFkgQ8l6/hdizr2bfKea5Y2iCXu+18GPahWP7uSqeYSgIg8HOWfuitqKAYd
	GxBhz132JKg4quj1fqQMMt1iGI6pfdR70XwxjHzjK4Mn9CvoMiclpjtMaIX0I47ynKvH73
	2gmrESRPPVKJbPqs4mUZ8ijfcFbVWyjT6tJtDVeRY3NzOHWXqq5f6KVIthXZAufLVF+zZ+
	lRtlVWkNzauccF5sIolOmYWuCfun5mS7hp8iG5mwUOQ0Zs+HiYGyhgGzEBpLtZ78fpVONM
	LW+5z5szvJaR4EusrLXRtuWvq1GcxNEuJCgepF0a/5KizRHnjHFHwSDA47AE3g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 10:20:43 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: James Clark <jjc@jclark.com>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, netdev@vger.kernel.org, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Richard Cochran <richardcochran@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net] net: bcmgenet: add hwtstamp callbacks to restore PHY
 timestamping
In-Reply-To: <20260918030149.80398-1-jjc@jclark.com>
References: <20260918030149.80398-1-jjc@jclark.com>
Message-ID: <fe0a80d1f1f6aa553c1ea838cea52c18@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi James

On 18.9.2026 05:01, James Clark wrote:
> Hardware timestamp configuration fails with EOPNOTSUPP on BCMGENET
> interfaces connected to a timestamp-capable PHY. On a Raspberry Pi
> CM4, "hwstamp_ctl -i eth0 -t 1 -r 12" fails with "SIOCSHWTSTAMP failed:
> Operation not supported", preventing ptp4l from using hardware
> timestamping.
> 
> Commit 5062245a5a7f ("net: remove legacy way to get/set HW timestamp
> config") removed the legacy ioctl fallback, assuming that all MAC
> drivers supporting hardware timestamping implement ndo_hwtstamp_get()
> and ndo_hwtstamp_set(), even when timestamping is provided only by
> an attached PHY. BCMGENET does not implement these callbacks, so the
> core rejects timestamp configuration requests before they reach
> the PHY.
> 
> Add ndo_hwtstamp_get() and ndo_hwtstamp_set() callbacks so the core
> can dispatch timestamp configuration requests through its phylib
> helpers. Both callbacks return -EOPNOTSUPP because the MAC itself
> does not support hardware timestamping; requests for the PHY are
> handled by the core without invoking these callbacks.

I've tested with and without your patch and can reproduce the issue / 
fix.
IMHO the commit message should mention that 'get' isn't restored - it 
was
already broken as the legacy path through phy_mii_ioctl() only handled
SIOCSHWTSTAMP.

> 
> Fixes: 5062245a5a7f ("net: remove legacy way to get/set HW timestamp 
> config")
> Assisted-by: LLM
> Signed-off-by: James Clark <jjc@jclark.com>
> ---
>  drivers/net/ethernet/broadcom/genet/bcmgenet.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index a2305e642..8ead37ff9 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -3712,6 +3712,19 @@ static int bcmgenet_change_carrier(struct 
> net_device *dev, bool new_carrier)
>  	return 0;
>  }
> 
> +static int bcmgenet_hwtstamp_get(struct net_device *dev,
> +				 struct kernel_hwtstamp_config *cfg)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int bcmgenet_hwtstamp_set(struct net_device *dev,
> +				 struct kernel_hwtstamp_config *cfg,
> +				 struct netlink_ext_ack *extack)
> +{
> +	return -EOPNOTSUPP;
> +}

The check that rejects the request is in dev_set_hwtstamp():

         if (!ops->ndo_hwtstamp_set)
                 return -EOPNOTSUPP;

It runs before dev_set_hwtstamp_phylib() checks 
phy_is_default_hwtstamp()
and nothing about this is specific to bcmgenet. Personally, I think this 
should
be better handled by the core than adding -EOPNOTSUPP stubs to the 
drivers.

I will send a patch for this.

> +
>  static const struct net_device_ops bcmgenet_netdev_ops = {
>  	.ndo_open		= bcmgenet_open,
>  	.ndo_stop		= bcmgenet_close,
> @@ -3723,6 +3736,8 @@ static const struct net_device_ops 
> bcmgenet_netdev_ops = {
>  	.ndo_set_features	= bcmgenet_set_features,
>  	.ndo_get_stats64	= bcmgenet_get_stats64,
>  	.ndo_change_carrier	= bcmgenet_change_carrier,
> +	.ndo_hwtstamp_get	= bcmgenet_hwtstamp_get,
> +	.ndo_hwtstamp_set	= bcmgenet_hwtstamp_set,
>  };
> 
>  /* GENET hardware parameters/characteristics */

Thanks,
Nicolai
