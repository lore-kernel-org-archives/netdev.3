Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276C94C226E;
	Tue, 29 Sep 2026 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671723; cv=none; b=YYEkwuYvNSGXxhbSboV40mhtnyWSOLuDT4T6pIlIvrWhN1z1prsFJg2ortMvi4W7lG+TNmVYqHc3InnfHm1jK1ynSofhYpAnZPyw91p1vjFiqMsmpFeJ3xRBrvm9LoZ1bXh2QROUj+Eog5Uzrc0WmOcqrYdDCd+NHBCNLKqMrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671723; c=relaxed/simple;
	bh=pPXDYD/RGJb0O3s+6lRqbo7NLPSamfflZ0IeEdlBN3c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cFwwILVnlyos4J6TyCgaa159KSy5Vn8oT/IkiDZZHO10GGJjanmdB/kzUJI3hbauVFYp2WWCsRqZaf+hLZ3BTaxigFU5HuyyTdOi3L2D4QgjyfuVIdef1G9Jp2mpPrP1bMIXYlWHaKN3TzL/FAukHY2YNcxyXhAHDqMhy9/+bG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYigNocC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYigNocC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AE11F000FF;
	Tue, 29 Sep 2026 08:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671714;
	bh=2en9nq3L+d0fr45TyjrHfqOEIYBYC2n45esf7o40X7A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NYigNocC7aAx7W+GLbnPMunsoyfwqUQ9jQNXDOV9zR2XcQh8dV2dRnO3HHeBCN7DM
	 GMnGrpB7o1I22tyHKh/YKrWl9BD2hkGn3H96OCDVpCzWQWrUEO4KqvVcVEQjDJmh+A
	 jN9Nd66ILgzhzeNPjqKi0HWTxGrxACuTJWwTxQFlfTcVCPKQQHnlMHoeLd7kHyWIoK
	 xwd+5w0pzS6K1ls1vkzmM1t4jmqnROIMz7UwZS1IpK2Cc799vqAahxryNr/0AKcazb
	 he3dXzNzjKsIWyZSniQ/4mAAZQLTHhxTj+iU9mT+A52Cs2dwIO7QToU0x+pWUM+YtI
	 dualbVsMeLIow==
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: Don't set or get RSS
 parameters when not supported
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, nb@tipi-net.de, jitendra.vegiraju@broadcom.com,
 thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, pbrobinson@gmail.com
Date: Tue, 29 Sep 2026 08:48:33 +0000
Message-ID: <179067171307.434549.1093187286398187440@kernel.org>
In-Reply-To: <20260928145043.1228968-3-maxime.chevallier@bootlin.com>
References: <20260928145043.1228968-3-maxime.chevallier@bootlin.com>
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

- [Medium] This patch makes stmmac_get_rxfh() in
  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c return…
- [Low] The commit message describes a user-visible bug: on stmmac
  devices without RSS, 'ethtool -x reports an indirection table and a…

--

net: stmmac: Don't set or get RSS parameters when not supported

This commit changes the stmmac ethtool RSS ops to return early when
stmmac_rss_is_supported() is false. The key and indirection sizes now
report 0, and get_rxfh/set_rxfh return -EOPNOTSUPP. The aim is to stop
reporting bogus RSS data and to make the RSS kselftests work on stmmac.

> The RSS kselftests fail on stmmac, and this is partly due to the driver
> reporting bogus data for the RSS ops :
>
>  - ethtool -x reports an indirection table and a key while the hardware
>    doesn't have any of that
>  - ethtool -X fails with -EINVAL.
>
> Let's return early in the rss ops if we know the hardware and platform
> don't support RSS.
>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

[Severity: Low]
The commit message describes a bug that users can see, but there is no
Fixes: tag.

Blame shows that the unconditional stmmac_get_rxfh_key_size(),
stmmac_get_rxfh_indir_size(), stmmac_get_rxfh() and stmmac_set_rxfh()
logic came from commit 76067459c686. The later refactor fb6e30a72539 only
moved these functions to the ethtool_rxfh_param API.

Should this carry the following tag?

Fixes: 76067459c686 ("net: stmmac: Implement RSS and enable it in XGMAC core")

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 1cf0f8820b33..56019683f399 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c

[ ... ]

> @@ -943,6 +949,9 @@ static int stmmac_get_rxfh(struct net_device *dev,
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	int i;
>  
> +	if (!stmmac_rss_is_supported(priv))
> +		return -EOPNOTSUPP;
> +

[Severity: Medium]
Does this -EOPNOTSUPP break namespace-wide ETHTOOL_MSG_RSS_GET dumps?

rss_dump_one_dev() in net/ethtool/rss.c only skips a device when it has
no get_rxfh op, and stmmac still provides one:

net/ethtool/rss.c:rss_dump_one_dev() {
    ...
	if (!dev->ethtool_ops->get_rxfh)
		return 0;

	if (!ctx->ctx_idx) {
		ret = rss_dump_one_ctx(skb, cb, dev, 0);
		if (ret)
			return ret;
    ...
}

The error then comes back through this path:

ethnl_rss_dumpit()
  rss_dump_one_dev()
    rss_dump_one_ctx()
      rss_prepare()
        rss_prepare_get()
          ops->get_rxfh() -> stmmac_get_rxfh() returns -EOPNOTSUPP

When it reaches ethnl_rss_dumpit(), the loop stops:

	for_each_netdev_lock_ops_compat_scoped(net, dev, ctx->ifindex) {
		...
		ret = rss_dump_one_dev(skb, cb, dev);
		if (ret)
			break;
	}

	return ret;

So the dump fails at the stmmac netdev, and no device with a higher
ifindex gets reported. That includes NICs that do support RSS.

No in-tree platform sets plat->rss_en. The only match is the declaration
in include/linux/stmmac.h. That means stmmac_rss_is_supported() is false
for every in-tree stmmac device.

Before this patch, stmmac_get_rxfh() always returned 0. The dump used to
complete, even though it reported bogus data.

The RSS selftests use this dump path. In
tools/testing/selftests/drivers/net/hw/rss_ctx.py,
test_rss_context_dump() calls:

    ctxs = cfg.ethnl.rss_get({}, dump=True)

It also runs a dump with {'start-context': 1}. On a test host that has a
stmmac port plus the NIC under test, would these now fail, when they
passed before?

mvpp2 and mvneta already return -EOPNOTSUPP from get_rxfh, so the core
already stopped dumps this way. This patch applies that behaviour to every
in-tree stmmac device.

Would it be better to have rss_dump_one_dev() skip devices whose get_rxfh
returns -EOPNOTSUPP, or that report zero indir and key sizes? Another
option is to not provide the stmmac get_rxfh op when RSS is unsupported.

>  	if (rxfh->indir) {
>  		for (i = 0; i < ARRAY_SIZE(priv->rss.table); i++)
>  			rxfh->indir[i] = priv->rss.table[i];

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928145043.1228968-1-maxime.chevallier%40bootlin.com
