Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E903E27442;
	Wed, 16 Sep 2026 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789517528; cv=none; b=DqybU4LoloNBApAe0ikLUM9xGhLCXmqOVx1q9jPJg8yPTB6NKmYUzwiyWStEHQo3zcxYQdgpS83GsNhSo11wzSW+g1u+8A4VdOHDWo3jziJ+3q06+lE4PQQUOHlWjVWDbkk8f0GAF0Z+329nzsmWf8uB6lw2OGHc3W8vuYTgXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789517528; c=relaxed/simple;
	bh=m64LWlqRk2DM9/bb1LgHhv5Jk1i71MXMDK4An7aJXiU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MZD6vizcuwEuxTFyX4t+xCTkSp6+qz0rRPJsIMnFmBPA9ze4QdYorA0HZZboOQHqXICnitAmtAyWGKwifJet8HZ/ytIVHdoRytl5eeAEhdOFg4c+gt65TwLEnGp/Ufa5vHcBna/V/z2s/4w4gTkfAh6JENiN3HkzupBhogb/8B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuceZS1o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuceZS1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A4B1F000FF;
	Wed, 16 Sep 2026 00:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789517526;
	bh=rfu3xW2K2rwisp5gOFShc+9kCaYMLkibQrG6JtIHCMs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SuceZS1oMaRRjcBg1JuHghJWSnW/8IATJAizx2ivQn2uuZxOYgNChsPK1TFHe4EIW
	 aZ1hOc/g12egyzJcWeRyRlMAo4oaj2QHUihS4lasJukSJ1k9SNsComVFAZIEsll1i8
	 JZDht0DKmJL/UU1zRd3ZEf0t6a7rUMxjAl7VdFpLuHNFfGVH9fLgpu2JAT7VrpwtXR
	 cF80A2kbVVEqHyTn8jMOXN1z1zEHdU18joSbc5hC/eDkYlbiWK70/NOW5WuEh0ImH8
	 GvLraAAvAA5NbB+o0Me86qSb4slkaLL7h03XRhRaHqetcZFHFYMWF6MdeKzjwthqSU
	 u/yEOZED3BMXg==
Subject:
 Re: [PATCH net] macsec: initialize SecY before registering the netdevice
From: netdev-bot+sashiko@kernel.org
To: haseebulhaq55@gmail.com
Cc: sd@queasysnail.net, andrew+netdev@lunn.ch, horms@kernel.org,
 hangbin.liu@linux.dev, felix.walter@cloudandheat.com, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, kuba@kernel.org,
 syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 00:12:05 +0000
Message-ID: <178951752525.22033.8547704610100726932@kernel.org>
In-Reply-To: <20260911-fix-macsec-net-v1-1-c82aa58ae741@gmail.com>
References: <20260911-fix-macsec-net-v1-1-c82aa58ae741@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 0

- [Medium] Incomplete fix: the registration-time RTM_NEWLINK notification
  that this patch makes succeed now carries a bogus IFLA_MACSEC_SCI = 0.

Pre-existing issues:
- [Medium] A user-supplied IFLA_MACSEC_SCI equal to MACSEC_UNDEF_SCI
  (0xffffffffffffffff) bypasses the duplicate-SCI check in…
- [Medium] In macsec_newlink(), once mdo_add_secy() has successfully
  programmed the offload engine (drivers/net/macsec.c:4264-4279), a…

--

macsec: initialize SecY before registering the netdevice

The patch moves SecY initialization and the new-link attribute handling
ahead of register_netdevice(), so that macsec_fill_info() does not fail
for notifications emitted during registration. The per-CPU stats and
metadata_dst allocations move into ndo_init() with an unwind path, and
the SCI assignment stays after registration.

Closes: https://syzkaller.appspot.com/bug?extid=f2f6312ad1b5a0bfe316
Link: https://lists.openwall.net/linux-kernel/2026/08/19/552

> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index 6f9f3aceffaad..11207d671fb6a 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c

[ ... ]

> @@ -4116,29 +4138,11 @@ static sci_t dev_to_sci(struct net_device *dev, __be16 port)
>  	return make_sci(dev->dev_addr, port);
>  }
>
> -static int macsec_add_dev(struct net_device *dev, sci_t sci, u8 icv_len)
> +static void macsec_init_secy(struct net_device *dev, u8 icv_len)
>  {
>  	struct macsec_dev *macsec = macsec_priv(dev);
>  	struct macsec_secy *secy = &macsec->secy;
>
> -	macsec->stats = netdev_alloc_pcpu_stats(struct pcpu_secy_stats);
> -	if (!macsec->stats)
> -		return -ENOMEM;
> -
> -	secy->tx_sc.stats = netdev_alloc_pcpu_stats(struct pcpu_tx_sc_stats);
> -	if (!secy->tx_sc.stats)
> -		return -ENOMEM;
> -
> -	secy->tx_sc.md_dst = metadata_dst_alloc(0, METADATA_MACSEC, GFP_KERNEL);
> -	if (!secy->tx_sc.md_dst)
> -		/* macsec and secy percpu stats will be freed when unregistering
> -		 * net_device in macsec_free_netdev()
> -		 */
> -		return -ENOMEM;
> -
> -	if (sci == MACSEC_UNDEF_SCI)
> -		sci = dev_to_sci(dev, MACSEC_PORT_ES);
> -
>  	secy->netdev = dev;
>  	secy->operational = true;
>  	secy->key_len = DEFAULT_SAK_LEN;
> @@ -4148,16 +4152,12 @@ static int macsec_add_dev(struct net_device *dev, sci_t sci, u8 icv_len)
>  	secy->replay_protect = false;
>  	secy->xpn = DEFAULT_XPN;
>
> -	secy->sci = sci;
> -	secy->tx_sc.md_dst->u.macsec_info.sci = sci;
>  	secy->tx_sc.active = true;

[Severity: Medium]
With key_len set here but secy->sci left at zero until after registration,
what SCI does the notification that now succeeds actually carry?

macsec_fill_info() no longer hits the default case of the key_len switch,
so it reaches:

	if (nla_put_sci(skb, IFLA_MACSEC_SCI, secy->sci,
			IFLA_MACSEC_PAD) ||

while secy->sci is still the zero value of the freshly allocated private
area, i.e. MAC 00:00:00:00:00:00 with port 0. That is neither a value the
driver ever assigns nor MACSEC_UNDEF_SCI, and it contradicts an explicitly
requested IFLA_MACSEC_SCI as well as every later GET or dump for the same
ifindex.

The notification looks reachable on exactly the syzbot path:
register_netdevice() sets reg_state = NETREG_REGISTERED before
call_netdevice_notifiers(NETDEV_REGISTER), inetdev_init() calls
dev_disable_lro() which emits NETDEV_FEAT_CHANGE, and rtnetlink_event()
forwards that to rtmsg_ifinfo_event(), which only checks:

	if (dev->reg_state != NETREG_REGISTERED)
		return;

dev->rtnl_link_initializing only suppresses register_netdevice()'s own
rtmsg_ifinfo() and the DELLINK message, not this one. So RTNLGRP_LINK
listeners see an RTM_NEWLINK with IFLA_MACSEC_SCI = 0, and if macsec_newlink()
subsequently fails in netdev_upper_dev_link(), the sci_exists() -EBUSY case,
mdo_add_secy() or register_macsec_dev(), no DELLINK follows, so a monitor can
keep a phantom link with that SCI in its cache.

Could an explicitly requested SCI (IFLA_MACSEC_SCI or IFLA_MACSEC_PORT) be
programmed in macsec_init_secy() before registration? Only the
dev_to_sci(dev, MACSEC_PORT_ES) default depends on the MAC address inherited
by ndo_init(). If the ordering is intended to stay as is, could the commit
message mention that registration-time notifications now report SCI 0?

> @@ -4220,6 +4220,14 @@ static int macsec_newlink(struct net_device *dev,
>  	if (rx_handler && rx_handler != macsec_handle_frame)
>  		return -EBUSY;
>
> +	/* Registration can notify listeners before returning. */
> +	macsec_init_secy(dev, icv_len);
> +	if (data) {
> +		err = macsec_changelink_common(dev, data);
> +		if (err)
> +			return err;
> +	}
> +
>  	err = register_netdevice(dev);
>  	if (err < 0)
>  		return err;
> @@ -4247,15 +4255,11 @@ static int macsec_newlink(struct net_device *dev,
>  		goto unlink;
>  	}
>
> -	err = macsec_add_dev(dev, sci, icv_len);
> -	if (err)
> -		goto unlink;
> +	if (sci == MACSEC_UNDEF_SCI)
> +		sci = dev_to_sci(dev, MACSEC_PORT_ES);

[Severity: Medium]
This isn't a bug introduced by this patch, but while the two blocks are being
moved around, is the ordering of the MACSEC_UNDEF_SCI rewrite against the
duplicate check in macsec_newlink() intentional?

The uniqueness check runs on the raw attribute value:

	if (rx_handler && sci_exists(real_dev, sci)) {
		err = -EBUSY;
		goto unlink;
	}

	if (sci == MACSEC_UNDEF_SCI)
		sci = dev_to_sci(dev, MACSEC_PORT_ES);

sci_exists() only compares committed values:

	list_for_each_entry(macsec, &rxd->secys, secys) {
		if (macsec->secy.sci == sci)
			return true;
	}

No registered SecY can hold MACSEC_UNDEF_SCI, so passing
IFLA_MACSEC_SCI = 0xffffffffffffffff always passes the check, and the value
is then rewritten to dev_to_sci(dev, MACSEC_PORT_ES). Since
macsec_dev_init() inherits the lower device's MAC via eth_hw_addr_inherit(),
that default is normally the same SCI the first MACsec device on the same
lower device already uses, so two SecYs with identical secy.sci land in
rxd->secys and find_secy() always returns the first one. Would doing the
remap before the sci_exists() call, or rejecting MACSEC_UNDEF_SCI outright,
be preferable? The IFLA_MACSEC_SCI policy is a plain NLA_U64 with no value
validation.

>
> -	if (data) {
> -		err = macsec_changelink_common(dev, data);
> -		if (err)
> -			goto del_dev;
> -	}
> +	macsec->secy.sci = sci;
> +	macsec->secy.tx_sc.md_dst->u.macsec_info.sci = sci;
>
>  	/* If h/w offloading is available, propagate to the device */
>  	if (macsec_is_offloaded(macsec)) {

[Severity: Medium]
This is a pre-existing issue, but since the del_dev unwind path is being
touched here: after mdo_add_secy() has succeeded, does anything undo it when
register_macsec_dev() fails?

	err = macsec_offload(ops->mdo_add_secy, &ctx);
	...
	err = register_macsec_dev(real_dev, dev);
	if (err < 0)
		goto del_dev;

register_macsec_dev() can fail on the rxd allocation or in
netdev_rx_handler_register(). The del_dev label only calls macsec_del_dev(),
which is purely software (frees the rx_sc list and clears the tx SAs), then
netdev_upper_dev_unlink() and unregister_netdevice(). mdo_del_secy() is only
issued from macsec_common_dellink() and macsec_update_offload(), neither of
which runs on this path, and unregister_netdevice() only reaches
macsec_dev_uninit() (gro_cells_destroy).

For mlx5, mlx5e_macsec_add_secy() has already allocated a struct
mlx5e_macsec_device holding macdev = ctx->secy->netdev and consumed one of
the MLX5_MACSEC_NUM_OF_SUPPORTED_INTERFACES slots, so that entry keeps a
pointer to a device that is about to go away. PHY and MAC drivers that
program SecY registers in mdo_add_secy leave the hardware entry armed. Should
this path issue mdo_del_secy() before macsec_del_dev()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260911-fix-macsec-net-v1-1-c82aa58ae741%40gmail.com
