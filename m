Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFC64A3D55;
	Mon,  5 Oct 2026 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210610; cv=none; b=uQ7ZqdqEDGUY/EokmsXe7zLy65uv6dPUgojrzByQ7s9ACV/pnNynRPy/aufeusmgI23NTnC1tl+pLXOWxbOglAzHutxSYf9Pgs9E7ZvQ7bJS19AkT660DOPXJBtZwWHvAj+a8qzLG2wfYDgLVvJ3s60AyqeKrxfp6dg6ziV72lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210610; c=relaxed/simple;
	bh=zIkUsyCC3biCyvZvsefiUXK7B4ZaXBJ3nBfmuofOpi4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qnv1daQ6UlHmomn91OmWxaUR8y+WyZ83Qk6NNu69HBV1ll1pww9ISp2obnSzq499hrwadxo2+X9hkEzhQlQo9iQH1+MmsvPjGMngCIh1GvlAZylOH2/RkgOiW6aCwuL9cB8bZ0wel69dOHYumAnsymze/Cn8TKgMivrvwDza5U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U50PDw9g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U50PDw9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C691F000FF;
	Mon,  5 Oct 2026 14:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791210592;
	bh=CLaoWInJ6oiZvLvcPkvGvD0noWB/U5iTtuHTDdxmyxo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U50PDw9gFe6sdrxo2htMizTTfKkB1lb2w/Z1gOj5zvRMK5pvSxqlDYs/OotPAUeuZ
	 qIp56C4aANvymVgzSknzRGDOY9MfwubOtx6/A+d4YB6l0mz/PazpUxPT/bsDtJPrBL
	 zLgUtZm7uyadh+lRU3IzA2bsnyI4Or4pcYyG7NcJSP4XFyCwidApST0Fw7Y0iVfvjw
	 1ipiHy9RV4r+UUBMZjNk6SymwzyWt3/qOtTECKVsOPvuYEd/8LYLg4ViP3rIH7ZA21
	 Bgo57WDcrbhIDGEAM8Z4LL4LqHfBtS1EJhwiEn4C481Nfr4uOlWqVjx0GOrMCPfSBW
	 alBNlVdVfW4jg==
Subject: Re: [PATCH net-next v3 1/3] net: rss: Require indir table size or
 hash key size to support RSS
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, lorenzo.bianconi@oss.qualcomm.com, nb@tipi-net.de,
 jitendra.vegiraju@broadcom.com, thomas.petazzoni@bootlin.com,
 alexis.lothore@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, pbrobinson@gmail.com, joe@dama.to
Date: Mon, 05 Oct 2026 14:29:50 +0000
Message-ID: <179121059086.434549.5364767976780818051@kernel.org>
In-Reply-To: <20261002142806.1299041-2-maxime.chevallier@bootlin.com>
References: <20261002142806.1299041-2-maxime.chevallier@bootlin.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new zero-size check is in the shared helper
  rss_get_data_alloc().
- [Low] The commit message gets the side effect wrong in two ways.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but on 32-bit
  kernels the RSS dump cursor in rss_dump_one_dev() can wrap.

--

net: rss: Require indir table size or hash key size to support RSS

This commit makes the ethtool ioctl (GRSSH/SRSSH) and netlink RSS paths
return -EOPNOTSUPP when a device reports both a zero-size indirection
table and a zero-length hash key. The netlink dump path now skips such
devices instead of aborting.

> This however also reports -ENOTSUPP for devices that only supports flow
> hash fields ops now.

[Severity: Low]
Is this description accurate? The new checks return -EOPNOTSUPP, not
-ENOTSUPP. ENOTSUPP is a kernel-internal errno that userspace should never
see.

Are flow-hash-only devices really the ones affected? Devices without
->get_rxfh were already rejected before this patch:

net/ethtool/rss.c:rss_prepare_data() {
    ...
	ops = dev->ethtool_ops;
	if (!ops->get_rxfh)
		return -EOPNOTSUPP;
    ...
}

rss_dump_one_dev() already skipped them. rss_prepare() still returns 0 for
them on RSS_SET.

The devices whose behaviour changes implement ->get_rxfh but report
indir_size == 0 and key_size == 0 at runtime. One in-tree example is
sfc/falcon. It has no get_rxfh_key_size op, and its indir size can be 0:

drivers/net/ethernet/sfc/falcon/ethtool.c:ef4_ethtool_get_rxfh_indir_size() {
    ...
	return ((ef4_nic_rev(efx) < EF4_REV_FALCON_B0 ||
		 efx->n_rx_channels == 1) ?
		0 : ARRAY_SIZE(efx->rx_indir_table));
}

The commit message also doesn't mention that ETHTOOL_GRSSH and
ETHTOOL_SRSSH now return -EOPNOTSUPP for these devices, through
ethtool_get_rxfh() and ethtool_set_rxfh(). Before this patch, GRSSH still
returned hfunc (for example ETH_RSS_HASH_TOP) and input_xfrm for them.

Could the commit message say which devices are affected, and mention the
ioctl change?

> diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
> index d4a1a4724b675..cb9bead0cedd1 100644
> --- a/net/ethtool/rss.c
> +++ b/net/ethtool/rss.c
> @@ -129,6 +129,9 @@ rss_get_data_alloc(struct net_device *dev, struct rss_reply_data *data)
>  	if (ops->get_rxfh_key_size)
>  		data->hkey_size = ops->get_rxfh_key_size(dev);
>  
> +	if (!data->indir_size && !data->hkey_size)
> +		return -EOPNOTSUPP;
> +

[Severity: Medium]
rss_get_data_alloc() is shared by RSS_GET, RSS_SET and RSS_CREATE. Does
this drop flow-hash reporting for devices that have ->get_rxfh but report
0/0 sizes?

rss_prepare() fills in the flow hash first. It only returns early when
->get_rxfh is NULL:

net/ethtool/rss.c:rss_prepare() {
	rss_prepare_flow_hash(request, dev, data, info);

	/* Coming from RSS_SET, driver may only have flow_hash_fields ops */
	if (!dev->ethtool_ops->get_rxfh)
		return 0;

	if (request->rss_context)
		return rss_prepare_ctx(request, dev, data, info);
	return rss_prepare_get(request, dev, data, info);
}

For such a device with rss_context == 0, the path is now:

rss_prepare()
  rss_prepare_flow_hash()   <- data->flow_hash filled, has_flow_hash set
  rss_prepare_get()
    rss_get_data_alloc()    <- returns -EOPNOTSUPP

The flow hash that was already collected is thrown away. Before this
patch, kzalloc(0) returned ZERO_SIZE_PTR and get_rxfh() succeeded. The
reply then included ETHTOOL_A_RSS_HFUNC and the ETHTOOL_A_RSS_FLOW_HASH
nest.

Take sfc/falcon B0 with a single RX channel. ef4_ethtool_get_rxfh_fields()
reports real TCP/IPv4 hash fields there. RSS_GET now fails anyway, and the
device silently drops out of RSS dumps.

On the RSS_SET side, ethnl_rss_set() returns early on this error:

	ret = rss_prepare(request, dev, &data, info);
	if (ret)
		return ret;

So requests that only change ETHTOOL_A_RSS_FLOW_HASH or
ETHTOOL_A_RSS_INPUT_XFRM are rejected before they reach
ethnl_set_rss_fields(). Neither of those needs an indirection table or a
key. rss_set_prep_indir() already rejected a zero-size INDIR attribute on
its own.

I couldn't find an in-tree driver where the SET side does real harm
today:

  - vmxnet3 without RSS already returns -EOPNOTSUPP from its flow-field
    ops.
  - falcon has no set_rxfh_fields.
  - virtio_net without RSS/HASH_REPORT only accepts no-op set_hashflow
    changes.

The GET-side loss is concrete, though.

The ioctl equivalents ETHTOOL_GRXFH and ETHTOOL_SRXFH have no such size
check and keep working on the same device. They go through
ethtool_get_rxfh_fields() and ethtool_set_rxfh_fields().
Documentation/networking/ethtool-netlink.rst maps those commands to
ETHTOOL_MSG_RSS_GET and ETHTOOL_MSG_RSS_SET. Is it intended that netlink
and ioctl now disagree here?

>  	indir_bytes = data->indir_size * sizeof(u32);
>  	total_size = indir_bytes + data->hkey_size;
>  	rss_config = kzalloc(total_size, GFP_KERNEL);

[ ... ]

> @@ -457,7 +460,7 @@ rss_dump_one_dev(struct sk_buff *skb, struct netlink_callback *cb,
>  	for (; xa_find(&dev->ethtool->rss_ctx, &ctx->ctx_idx,
>  		       ULONG_MAX, XA_PRESENT); ctx->ctx_idx++) {
>  		ret = rss_dump_one_ctx(skb, cb, dev, ctx->ctx_idx);
> -		if (ret)
> +		if (ret && ret != -EOPNOTSUPP)
>  			return ret;
>  	}
>  	ctx->ctx_idx = ctx->start_ctx;

[Severity: Medium]
This isn't a bug introduced by this patch, but can ctx->ctx_idx wrap here
on 32-bit kernels?

ctx_idx is an unsigned long. The loop increments it after each context
without checking for ULONG_MAX.

RSS_CREATE accepts an explicit ETHTOOL_A_RSS_CONTEXT of U32_MAX, since the
policy is NLA_POLICY_MIN(NLA_U32, 1). When ops->rxfh_max_num_contexts is
0, ethnl_rss_create_validate() applies no upper bound. sfc's
efx_ethtool_ops is one such case:

	if (ops->rxfh_max_num_contexts &&
	    ops->rxfh_max_num_contexts <= rss_context) {

ethnl_rss_create_doit() then inserts that exact ID with xa_insert(). This
skips the limit - 1 bound that xa_alloc() applies to automatically
allocated IDs.

On 32-bit, U32_MAX equals ULONG_MAX. After that context is emitted,
ctx->ctx_idx++ wraps to 0 and xa_find() returns already-emitted contexts
again. When the skb fills, -EMSGSIZE keeps the cursor and the dump
resumes, so the cycle repeats.

Would the RSS_GET dump then never end for userspace? Creating such a
context needs admin privileges in the netns.

The -EOPNOTSUPP change in this patch doesn't touch the cursor arithmetic.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002142806.1299041-1-maxime.chevallier%40bootlin.com
