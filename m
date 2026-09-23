Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC0F25B091;
	Wed, 23 Sep 2026 07:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790146840; cv=none; b=G8Al1VInYcXMLqD+zzUsN4VvDHhBtRIqNFBznPe0kTtAIJKFOSrm7K6n1W/AVDcAczF6YFP+LMwwd49bihscu0h6MWHshBRNVj6dUaD54IARa9Il1L8/Tvju43T8TaDjGdaUCosHl+c7Q56s21gFlGKDTHS9ijNSwtk03+JSxaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790146840; c=relaxed/simple;
	bh=2E/+CMt+kcx35sEnkY8dw6dj8vvP6NYzTNeYkVhQBeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfGqCpqxWD20yhKX1IkErmlMEurnexGh9W9DQ8I90cMOa8/jqp0+KJovcBja5TtuMxEY66ve2147GEcFJfsG+q2PlnsATU1VBU6tyBpcFUgrIMs5rM2U84zVF197ORdR2mk4aNUCfzftgTvAgUAB/ML0CVU8FKYcySDOqXfZeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3Mh0bM3; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3Mh0bM3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790146838; x=1821682838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2E/+CMt+kcx35sEnkY8dw6dj8vvP6NYzTNeYkVhQBeY=;
  b=i3Mh0bM3VNc0fA0yVrY+vi2eCu64L5mkyBjLJuVnVgYm3tz4MWoR47ow
   yEsJYrx1yjioz6qOWsiu3M19lRednAc/vat60YJraqOUvBJs0H8ruNiEs
   DTKRzFDXsXpVVMTA7W1+luI3c089BOPEATWlcmn/l2Kdtv389DIxjcW3e
   BRT7YFrruZ2XBJ2stDmB7cCsICJSXaMBC865tqvdbtkqWWFnCIj1tc377
   A98Om4uhiTjJY4vUFg6CwXPnTcaKKYbHASWO8kYTg3oNz4pFwkw0GnlPD
   nFDmzCpU9j0/07E1aA+on4qFoyYvncQZWoCQlZ/x/XNVjAfuKHBy7eXJu
   g==;
X-CSE-ConnectionGUID: 4dbbSMW3QNStDAa8xIsmvQ==
X-CSE-MsgGUID: lo3XgpWvStef1PizWhpN0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1316511"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="1316511"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 00:00:37 -0700
X-CSE-ConnectionGUID: HQSuThhOTZ6gfCxqQtR38w==
X-CSE-MsgGUID: 8Tu5+dbgRpmy+GK+JTxqIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4551028"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa011.fm.intel.com with ESMTP; 23 Sep 2026 00:00:35 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id C600999; Wed, 23 Sep 2026 09:00:33 +0200 (CEST)
Date: Wed, 23 Sep 2026 09:00:33 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Yusheng Zheng <yunwei356@gmail.com>
Cc: westeri@kernel.org, netdev@vger.kernel.org, YehezkelShB@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] net: thunderbolt: Allow per-device opt-in Tx E2E
 flow control
Message-ID: <20260923070033.GH106095@black.igk.intel.com>
References: <CAEnnukY8+i7j7A05afKrEz7s9kXEXXzjwGm+wV1wHgACe+iADg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEnnukY8+i7j7A05afKrEz7s9kXEXXzjwGm+wV1wHgACe+iADg@mail.gmail.com>

Hi,

On Tue, Sep 22, 2026 at 11:43:16PM -0700, Yusheng Zheng wrote:
> Commit a8065af3346e ("net: thunderbolt: Enable end-to-end flow control
> also in transmit") enabled E2E flow control on Tx rings. It was reverted
> after an ASMedia ASM4242 accepted the configuration without returning
> credits, leaving its Tx ring wedged. A separate report described similar
> Tx completion wedges with multiple native E2E rings on AMD Strix Halo.
> The revert kept Rx E2E and suggested a Tx opt-in for known-good
> controllers.

AMD is also working on a patch that prevents the issue.

> On two Intel Meteor Lake-P NHI (8086:7ec2) hosts, the exact patch built
> against their running 7.3-rc3 kernel was tested in a same-boot A/B/A run.
> Each arm used a ten-second, four-stream iperf3 transfer. For lab to g485,
> Tx E2E on, off, then on again produced 15.43, 15.76, and 15.18 Gbit/s,
> with 0, 29113, and 0 retransmissions. G485 Rx errors rose by 5097 during
> the off arm and did not rise during either on arm. In the reverse direction,
> throughput was about 19.41 Gbit/s in all three arms, with 0, 181, and 0
> retransmissions; lab Rx errors rose by 14 only during the off arm.
> 
> The link was brought down and up to change the flag, so link training was
> not held fixed. The result supports an integrity improvement on this pair,
> not a general throughput gain or proof for other controllers. Both hosts
> were returned to their distribution module after testing.
> 
> Add a per-netdev ethtool private flag named tx-e2e. It defaults to off and
> can only change while the interface is down. Enabling it requires the
> existing e2e module parameter. At open, the Tx ring uses E2E only if the
> peer advertises TBNET_E2E. This bit proves protocol support, not working
> credit return. Administrators must opt in only on controller pairs known
> to return credits; a bad controller can stall Tx until the flag is
> disabled.

If we advertise E2E support over XDomain we must enable it as well
otherwise the other side that can be something else that Linux will be
disapointed.

I think for this, we should come up a solution that deals with the NHI
wedge problem directly in the TB driver side (and this is what AMD is
working on). Then the Thunderbolt service drivers do not need to care.

Also this looks pretty much like LLM generated, so you should add
Assisted-by tag.

> Link: https://lore.kernel.org/netdev/20260727123002.25225-1-fy15309206903@gmail.com/
> Signed-off-by: Yusheng Zheng <yunwei356@gmail.com>
> ---
> RFC question: Is a per-netdev ethtool private flag an acceptable opt-in for
> known-good controller pairs, given that the peer protocol bit cannot prove
> that the controller returns Tx E2E credits?
> 
> Validation: The patched module built with W=1 against the running 7.3-rc3
> headers and ran on both Intel hosts. A same-boot A/B/A test is summarized
> above. Enabling the flag while the interface was up returned EBUSY; ring
> flags were observed as FRAME without the opt-in and FRAME|E2E with it.
> 
> A net-next allmodconfig W=1 build was attempted but failed on GCC 15
> -Werror diagnostics in unrelated files including samples/trace_events and
> kernel/locking; it did not provide a clean whole-tree result.
> 
>  drivers/net/thunderbolt/main.c | 60 ++++++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> index d9fb587a62c5..b17ab8e15c1f 100644
> --- a/drivers/net/thunderbolt/main.c
> +++ b/drivers/net/thunderbolt/main.c
> @@ -162,2 +162,3 @@ struct tbnet_ring {
>   *                 host
> + * @tx_e2e: Enable end-to-end flow control on the Tx ring
>   * @local_transmit_path: HopID we are using to send out packets
> @@ -192,2 +193,3 @@ struct tbnet {
>         bool login_received;
> +       bool tx_e2e;
>         int local_transmit_path;
> @@ -950,3 +952,7 @@ static int tbnet_open(struct net_device *dev)
> -       ring = tb_ring_alloc_tx(xd->tb->nhi, -1, TBNET_RING_SIZE,
> -                               RING_FLAG_FRAME);
> +       flags = RING_FLAG_FRAME;
> +       /* The peer bit advertises E2E protocol support. */
> +       if (net->tx_e2e && tbnet_e2e && net->svc->prtcstns & TBNET_E2E)
> +               flags |= RING_FLAG_E2E;
> +
> +       ring = tb_ring_alloc_tx(xd->tb->nhi, -1, TBNET_RING_SIZE, flags);
>         if (!ring) {
> @@ -1339,3 +1345,53 @@
> +static const char tbnet_priv_flags[][ETH_GSTRING_LEN] = {
> +#define TBNET_PRIV_FLAG_TX_E2E BIT(0)
> +       "tx-e2e",
> +};
> +
> +static void tbnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
> +{
> +       if (stringset == ETH_SS_PRIV_FLAGS)
> +               memcpy(data, tbnet_priv_flags, sizeof(tbnet_priv_flags));
> +}
> +
> +static int tbnet_get_sset_count(struct net_device *dev, int sset)
> +{
> +       if (sset == ETH_SS_PRIV_FLAGS)
> +               return ARRAY_SIZE(tbnet_priv_flags);
> +
> +       return -EOPNOTSUPP;
> +}
> +
> +static u32 tbnet_get_priv_flags(struct net_device *dev)
> +{
> +       const struct tbnet *net = netdev_priv(dev);
> +
> +       return net->tx_e2e ? TBNET_PRIV_FLAG_TX_E2E : 0;
> +}
> +
> +static int tbnet_set_priv_flags(struct net_device *dev, u32 flags)
> +{
> +       struct tbnet *net = netdev_priv(dev);
> +       bool tx_e2e;
> +
> +       if (flags & ~TBNET_PRIV_FLAG_TX_E2E)
> +               return -EINVAL;
> +
> +       tx_e2e = flags & TBNET_PRIV_FLAG_TX_E2E;
> +       if (net->tx_e2e == tx_e2e)
> +               return 0;
> +       if (netif_running(dev))
> +               return -EBUSY;
> +       if (tx_e2e && !tbnet_e2e)
> +               return -EOPNOTSUPP;
> +
> +       net->tx_e2e = tx_e2e;
> +       return 0;
> +}
> +
>  static const struct ethtool_ops tbnet_ethtool_ops = {
>         .get_link_ksettings = tbnet_get_link_ksettings,
> +       .get_strings = tbnet_get_strings,
> +       .get_sset_count = tbnet_get_sset_count,
> +       .get_priv_flags = tbnet_get_priv_flags,
> +       .set_priv_flags = tbnet_set_priv_flags,
>  };
> --
> 2.55.0
> 
