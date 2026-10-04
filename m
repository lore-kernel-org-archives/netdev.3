Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13430402B9E;
	Sun,  4 Oct 2026 06:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791093952; cv=none; b=NxrYej0A45kmTyM5XYyzUVXT6UuIf+t1nZ7gk/yzX0/InFZcUXUvz9dviwaE36oTdifzNjsS0MIe9BBilA0cJVfBtIq4uVj9zX2ONTulQ5RQM1mcORe9C0VZb1V+5vOw6Ncn559E8KiLHZ8iCpGpa9BBjG38QmIOzR6Ti2x32cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791093952; c=relaxed/simple;
	bh=Zidf7cU212OLrcl2hvxVlUBu4n668moRU7qzrJ7hc5o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jMCDx9utPe2gz70TTyGAw68zzOljA7nzPNH+lqI4idXYc/+8e2/SrNBOFEOFZNQP+pWsckeIkVj5ofioKm25jXb/alNfCTnCTuUBMLLCE+raR4p4ccEokAEqvZIN92qLWvOio/audcMayOvzo84+2iO9lazyKIR2qVsw2dnESO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8z80A5V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8z80A5V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5F31F00893;
	Sun,  4 Oct 2026 06:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791093950;
	bh=K8DYiXC3aDRn0QZjrJ5iLkHuK9WcmTffuz4L2dTPWa4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n8z80A5VERgw15v9nz5uAN95dlJX2NAapxxG32RJnmDSBYJxTi7+i3fXQe/wzqcWZ
	 ydh/OnelfUAjS2Xc9sBGuB36X6+eSXqpWAKJNUtcZZWdCizYp8spjpK6It15CLAaig
	 QIIZwdrAkiRG+xc8AwD+m4h9lXVA43Ofey9kBUq1O6Kgi4kHVKEg4pt6LKt3Vy87Pc
	 FDz228xKh9jCy3v/s5Jd3tdy5/aYDsS2j9/zCO6inGu8zsjtuUmIjr57ZQhL+OE4zM
	 +ei0F85m4M3qcw3+GSUmw00lzEx2irKRk3AB9zoTg5FVxuqPthYXPS5kzMnjP1gCEF
	 0cNOluRh9jLig==
Subject: Re: [PATCH net-next 3/7] net: qualcomm: rmnet: Restrict supported MAP
 checksum configurations
From: netdev-bot+sashiko@kernel.org
To: subash.a.kasiviswanathan@oss.qualcomm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net, horms@kernel.org,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 sean.tranchetti@oss.qualcomm.com
Date: Sun, 04 Oct 2026 06:05:49 +0000
Message-ID: <179109394966.434549.672853362138907385@kernel.org>
In-Reply-To:
 <20260930051345.857443-4-subash.a.kasiviswanathan@oss.qualcomm.com>
References:
 <20260930051345.857443-4-subash.a.kasiviswanathan@oss.qualcomm.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] rmnet_config_data_format_valid() in
  drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c puts the ingress…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  rmnet_newlink() in drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c…

--

net: qualcomm: rmnet: Restrict supported MAP checksum configurations

This patch adds rmnet_config_data_format_valid() and calls it from
rmnet_newlink() and rmnet_changelink(). A requested data format that has
both v4 and v5 checksum offload flags set is now rejected with -EINVAL.
The commit message says this prepares for a follow-up patch that allows
coalescing only with MAPv5.

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index 61b04c6c0390e..8051aef01ae31 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -26,6 +26,22 @@ static int rmnet_is_real_dev_registered(const struct net_device *real_dev)
>  	return rcu_access_pointer(real_dev->rx_handler) == rmnet_rx_handler;
>  }
>
> +/* Only three MAP configurations are supported: MAPv1 (no checksum
> + * offload), MAPv4 (v4 checksum offload) and MAPv5 (v5 checksum
> + * offload). QMAP command support is orthogonal and permitted with
> + * any of the three. Mixing v4 and v5 checksum offload flags together
> + * is not a supported configuration.
> + */
> +static bool rmnet_config_data_format_valid(u32 data_format)
> +{
> +	u32 v4_mask = RMNET_FLAGS_INGRESS_MAP_CKSUMV4 |
> +		      RMNET_FLAGS_EGRESS_MAP_CKSUMV4;
> +	u32 v5_mask = RMNET_FLAGS_INGRESS_MAP_CKSUMV5 |
> +		      RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
> +
> +	return !(data_format & v4_mask) || !(data_format & v5_mask);
> +}

[Severity: Medium]
Does this reject more than the commit needs? Each mask covers both the
ingress and egress bits. That means cross-direction setups are refused
along with same-direction mixes, for example:

    RMNET_FLAGS_INGRESS_MAP_CKSUMV5 | RMNET_FLAGS_EGRESS_MAP_CKSUMV4
    RMNET_FLAGS_INGRESS_MAP_CKSUMV4 | RMNET_FLAGS_EGRESS_MAP_CKSUMV5

Before this patch those were accepted. The datapath reads only the bits
for its own direction.

On egress, rmnet_map_egress_handler() only checks the EGRESS_* bits:

    data_format = READ_ONCE(port->data_format);
    if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV4) {
        ...
    } else if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV5) {
        ...
    }

rmnet_map_add_map_header() and rmnet_vnd_headroom() also check only the
EGRESS_* bits.

On ingress, __rmnet_map_ingress_handler(), rmnet_map_validate_packet_len()
and rmnet_map_send_ack() check only the INGRESS_* bits.

After this patch, RTM_NEWLINK through rmnet_newlink() and RTM_SETLINK
through rmnet_changelink() return -EINVAL for these configurations. Could
this break existing userspace that negotiates the UL and DL formats
separately?

Coalescing is ingress-only. The follow-up patch checks it on its own with
(RMNET_FLAGS_INGRESS_COALESCE && !RMNET_FLAGS_INGRESS_MAP_CKSUMV5). Would
it be enough to reject only same-direction mixes here, i.e. INGRESS v4
with INGRESS v5, and EGRESS v4 with EGRESS v5?

The commit message says:

    Mixing the v4 and v5 checksum offload flags together is not a valid
    configuration.

It does not say that cross-direction combinations were accepted and
worked before this change. Could the message mention that, if the
restriction is intentional?

[ ... ]

> @@ -167,14 +197,6 @@ static int rmnet_newlink(struct net_device *dev,
>
>  	hlist_add_head_rcu(&ep->hlnode, &port->muxed_ep[mux_id]);
>
> -	if (data[IFLA_RMNET_FLAGS]) {
> -		struct ifla_rmnet_flags *flags;
> -
> -		flags = nla_data(data[IFLA_RMNET_FLAGS]);
> -		data_format &= ~flags->mask;
> -		data_format |= flags->flags & flags->mask;
> -	}
> -
>  	netdev_dbg(dev, "data format [0x%08X]\n", data_format);
>  	WRITE_ONCE(port->data_format, data_format);

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. Now that
data_format is computed before rmnet_vnd_newlink(), it may be worth
looking at.

rmnet_newlink() calls rmnet_vnd_newlink() before port->data_format is
written. rmnet_vnd_newlink() sizes the new device's MTU from the old port
format:

drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c:rmnet_vnd_newlink() {
    ...
	headroom = rmnet_vnd_headroom(port);

	if (rmnet_vnd_change_mtu(rmnet_dev, real_dev->mtu - headroom)) {
    ...
}

rmnet_vnd_headroom() reads port->data_format &
RMNET_FLAGS_EGRESS_MAP_CKSUMV4.

rmnet_register_real_device() creates a fresh port with data_format == 0.
If the first newlink on that port requests EGRESS_MAP_CKSUMV4, the MTU
ends up sizeof(struct rmnet_map_ul_csum_header) too large. Can uplink
frames then go over the real device's MTU?

On a shared port, the WRITE_ONCE() also changes the framing for every
existing rmnet device on that port. Their MTUs are not re-checked the way
rmnet_changelink() does with rmnet_vnd_update_dev_mtu(). Should the new
format be applied, or at least checked against the MTUs, before
rmnet_vnd_newlink() runs?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930051345.857443-1-subash.a.kasiviswanathan%40oss.qualcomm.com
