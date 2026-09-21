Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43643B4423;
	Mon, 21 Sep 2026 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986229; cv=none; b=W0lTiui2VEAymqtrNpYCuaz7QDwZAaHg2U3LYgaA8nFv0zhFOJh4ZnPGRl+xfm2Tg/o9ImG9ZLzsfOxGXzday4g8Zer31H7OGuRBFmFJV33k0dzfoc+nyk3wInGrdR1qgvD1VNJ5UfpzKqbt5ppflsoALg5TmoTpAP96TELrEwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986229; c=relaxed/simple;
	bh=SGxlfflnoEUE8PQna8EIobdZGBeut1mKJI2YDTFNBSk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VE8Xhunv27KRLGVHvIuEkh4YvNpUbjITmXQ7lpvbyNMXJS8mfdNL3EA0xdDGcy9peB+zT3VdPtXrfqWee2liUAAVbGqqkEuLJA1A+aZfvxfcPkuGcX4DfJlUqkhsOG8hYzpxJVzyI8T5pEJY+6JAeQakVQiZ1+8KEAFuUmOXc2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Gu8aXN/Y; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Gu8aXN/Y"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A63DA4A31;
	Mon, 21 Sep 2026 12:23:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789986221; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sYTyf2NzK31tnC6ydhPwUeBuS5CmfMmG+CeRjqUuIfE=;
	b=Gu8aXN/YGk9qhL59VL0nIyWichBQRIS8ZytYfql2XkgbGzV9TMGQHQThHKrpZtmKkRK37S
	yF1g9z5XUrNH1IbOFixDvcY4BU3R4QRQJ1yNgKEZtY6NrVvH8q/by6vcDdl3sArYyg0jlK
	7PI/ljHWHKv5rS31XbgkX3lbeQeovU0rYY3nHQ/+cIc+ftJIbX5RZltwMsvi5yHSzcxQkJ
	1ufZ0NpRTIW8QYIgSbviE/5cjzbegDKLtb98ipZtZaAWtM0RFW0pvkRZBwTxw4ooNjRDQL
	leLQf/jUls/M6DnK682xY5UjK3uXOJBPOP6cn4eTLA8yLhmecJU3LYCQXkMLMQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Sep 2026 12:23:37 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, richardcochran@gmail.com,
 kory.maincent@bootlin.com, vadim.fedorenko@linux.dev, jjc@jclark.com,
 florian.fainelli@broadcom.com, opendmb@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: don't require the hwtstamp NDOs when a PHY
 provides timestamping
In-Reply-To: <178998466913.2160803.80702009306181180@kernel.org>
References: <20260918095540.34286-1-nb@tipi-net.de>
 <178998466913.2160803.80702009306181180@kernel.org>
Message-ID: <8037c32ce6fef79a74ee56973bf185c2@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi (S|Cl)ashiko

On 21.9.2026 11:57, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let 
> patchwork
> know by including "pw-bot: cr" as a separate line at the end of your 
> reply
> (one such reply per series is enough).
> 
> - [Medium] Incomplete fix: the ethtool-netlink tsconfig path still
>   rejects PHY-only devices, so the two documented-equivalent uAPIs now…
> 
> --
> 
> [...]

> [Severity: Medium]
> With the checks relocated here, the ioctl entry points now reach
> phy_hwtstamp_get()/phy_hwtstamp_set() for a device whose MAC implements
> neither NDO but whose phydev satisfies phy_is_default_hwtstamp().  The
> ethtool netlink peers of those ioctls keep the old unconditional gates,
> and they run before these helpers are ever called.
> 
> net/ethtool/tsconfig.c:tsconfig_prepare_data() {
> 	...
> 	if (!dev->netdev_ops->ndo_hwtstamp_get)
> 		return -EOPNOTSUPP;
> 
> 	ret = ethnl_ops_begin(dev);
> 	...
> 	ret = dev_get_hwtstamp_phylib(dev, &cfg);
> 	...
> }
> 
> net/ethtool/tsconfig.c:ethnl_set_tsconfig_validate() {
> 	const struct net_device_ops *ops = req_base->dev->netdev_ops;
> 
> 	if (!ops->ndo_hwtstamp_set || !ops->ndo_hwtstamp_get)
> 		return -EOPNOTSUPP;
> 
> 	return 1;
> }
> 
> Does this leave the two interfaces disagreeing on the same hardware?  
> On

Yes, but they already disagreed before this patch (EOPNOTSUPP).

The ioctls are the regression and AFAIU TSCONFIG_GET/SET never worked
here. Both gates are part of 6e9e2eed4f39 (~ a year before 
5062245a5a7f).

> the bcmgenet plus BCM54213PE setup named in the changelog,
> SIOCGHWTSTAMP/SIOCSHWTSTAMP would succeed after this patch, while
> ETHTOOL_MSG_TSCONFIG_GET and ETHTOOL_MSG_TSCONFIG_SET would still 
> return
> -EOPNOTSUPP, even though Documentation/networking/ethtool-netlink.rst
> lists those netlink operations as the replacements for the two ioctls 
> in
> its ioctl-to-netlink mapping table.
> 
> The note about this ("tsconfig keeps its own copy of the check ... IMHO
> this is an extra patch for net-next") sits below the --- separator, so 
> it
> does not end up in git history.  Could it be moved into the commit 
> message
> so that maintainers and stable backporters can see that PHY-only
> timestamping devices are only fixed on the ioctl path?

That would suggest the regression is half fixed. It isn't, the tsconfig
gap is a separate and older bug. I placed it deliberately below ---.

> 
> One detail for whoever narrows the tsconfig gates later: the fix is not 
> a
> mechanical copy of this one.  The HWTSTAMP_SOURCE_NETDEV branch in
> dev_get_hwtstamp_phylib() still calls the callback with no NULL test:
> 
> net/core/dev_ioctl.c:dev_get_hwtstamp_phylib() {
> 	...
> 	if (hwprov->source == HWTSTAMP_SOURCE_NETDEV)
> 		return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
> 	...
> }
> 
> dev->hwprov is only ever assigned in ethnl_set_tsconfig(), which is
> reached through ethnl_set_tsconfig_validate(), so that branch is safe
> today precisely because of the check under discussion.  Should the two
> sites be changed together?

No, IMHO not here. It would change change behaviour that never worked.
Thus I would suggest fixing this with a follow-up to net-next.

> 
> [ ... ]

Thanks,
Nicolai
