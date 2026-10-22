Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658242;
	b=Mri0WldE6I1WPzQsQGG3MPsRAd+G9KP1f3WNsga5Mn/CdAmKjWSeIF2hsrX7CRfB/Hva
	 wI0SfNvLCMphT8rn1F8mlCVuo0vOs6kOSG7SfVbXN/b7OtC9dX7kwYJahFTd5Apx5l1jy
	 r4cOEg7k7u9gAx304eZMSh6mF/hTugjkOduzn8RYZnOYpwpvSS4d+O71oS7TF4vbPbvSx
	 D+0J7PJ7A+TuBzPHoZVqa0HP/gpu9zorBXjmCUtEA75NjCM60vwnjmbBJc8hgoHscOM6S
	 o3OYJ4Z/IS6yyMqHwM3Ispk9C0XgZo8imGZl8FiNn0MQky62SfxBNsndqLQnAXecBMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658242;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IOEXCVhtNogAF9n7evnbF1KwICnoSgaiuPuP05wrMmU=;
	b=W0JSv+7xnnmicsj1GopT1x28Nxm4m6f9d/ip2vGfLwRNo8znoZ3FCItbsEfU4OFmwPZO
	 91o5P+o0Fez7q8i+vm9PhE2mihVyT69OtNeqFpeBX2UEfxgJErn5yTyF4bdc6zSOuwjKX
	 NExYcTbqRM/IghezFKvNQo8ceYVlbxvHTwjC2cu+L6wLrZT9pdagZijgFv6AZftc8fTp4
	 t9dS8TZ/3j/MBF+1uYWLdRzI4e8mimh75wniEvxI/MWmMaguxX6Xiw1m/0laCNcfHemYE
	 zW5TYICVIsY2KB5b56jHvYg/GgAHhezoJvKr51A+ZvrIacXKA5lkiPI1lpduJGK8T6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MDVxjPkr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0E606A31A;
	Thu, 22 Oct 2026 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MDVxjPkr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD671F000C1;
	Thu, 22 Oct 2026 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792658242;
	bh=IOEXCVhtNogAF9n7evnbF1KwICnoSgaiuPuP05wrMmU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MDVxjPkrVwS3bvxYbf8b+MGqbCRhbOJG7TuxZOJyfxmPrzJDHF+Ov2696VwDkRTtp
	 uUWjPS2KES/Mecq0QI+n48fJs5RV7oBMx1yRrNlF2NkUQTJlFcV1QaKsHD4pEx+E2R
	 izdgFsCHMh8OQ1Ymc7H6ulp4hLRsk9NfXd57mm6M68GDETY8fKOmosN43dzgWBsZyl
	 CZE+jijaOmppUm1AkQpogHCQPFh5HzF87LL69kX+rA7vvKUN55EBN2azVdimvtzVRh
	 UQVBjMOOMNJcuxNZkULgVHbHbbquW/DmzSPL/ulAmOJikHHG+G/q+BIXFS5jtTiI7C
	 7TiEBFWcShxqw==
Subject:
 Re: [PATCH net v6] net: dsa: qca8k: preserve port state across MTU changes
From: netdev-bot+sashiko@kernel.org
To: yongzhao.derek@gmail.com
Cc: netdev@vger.kernel.org, ansuelsmth@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 florian.fainelli@broadcom.com, linux-kernel@vger.kernel.org,
 hzyitc@outlook.com
Date: Thu, 22 Oct 2026 08:37:21 +0000
Message-ID: <179265824122.3135.15072303811434404600@kernel.org>
In-Reply-To: <20261019173716.198475-1-yongzhao.derek@gmail.com>
References: <20261019173716.198475-1-yongzhao.derek@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On a dual-CPU qca8k (ports 0 and 6 both declared as DSA CPU
  ports), the patch does not keep its own promise that an MTU change…
- [Medium] qca8k_port_status_restore() (qca8k-common.c:491-492) calls
  regmap_update_bits(priv->regmap, PORT_STATUS(port), mask,…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but bringing up a
  qca8k user port that has no PHY dereferences a NULL phy_device.

--

net: dsa: qca8k: preserve port state across MTU changes

This patch adds a dedicated mutex that serializes PORT_STATUS writers with
the MTU update in qca8k_port_change_mtu(). The MTU path now saves and
restores the MAC bits on ports 0 and 6 instead of enabling them
unconditionally. Failed PORT_STATUS writes are cached and retried from a
delayed work item.

> diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
> index 13005f10edb7..04001c345dd6 100644
> --- a/drivers/net/dsa/qca/qca8k-common.c
> +++ b/drivers/net/dsa/qca/qca8k-common.c

[ ... ]

> @@ -471,10 +471,74 @@ void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
>  	if (port > 0 && port < 6)
>  		mask |= QCA8K_PORT_STATUS_LINK_AUTO;
>  
> -	if (enable)
> -		regmap_set_bits(priv->regmap, QCA8K_REG_PORT_STATUS(port), mask);
> +	return mask;
> +}
> +
> +static int qca8k_port_status_restore(struct qca8k_priv *priv, int port)
> +{
> +	u32 mask = priv->port_status_mask[port];
> +	int ret;
> +
> +	lockdep_assert_held(&priv->port_status_lock);
> +
> +	if (!mask)
> +		return 0;
> +
> +	if (mask == U32_MAX)
> +		ret = qca8k_write(priv, QCA8K_REG_PORT_STATUS(port),
> +				  priv->port_status_value[port]);
>  	else
> -		regmap_clear_bits(priv->regmap, QCA8K_REG_PORT_STATUS(port), mask);
> +		ret = regmap_update_bits(priv->regmap, QCA8K_REG_PORT_STATUS(port),
> +					 mask, priv->port_status_value[port]);

[Severity: Medium]
Can this write bits outside of mask into PORT_STATUS?

For a partial mask, the whole cached priv->port_status_value[port] is
passed as the value. qca8k_port_status_update() below only refreshes the
bits inside the current mask. That leaves the bits from the last full
link_up write (mask U32_MAX) in the cache: the forced SPEED field, DUPLEX,
TXFLOW, RXFLOW, and LINK_AUTO on ports 0 and 6.

The qca8k regmap has no cache and provides a .reg_update_bits callback.
PORT_STATUS is therefore treated as volatile, and _regmap_update_bits()
passes the raw value to the driver without applying val & mask:

drivers/base/regmap/regmap.c:_regmap_update_bits() {
    if (regmap_volatile(map, reg) && map->reg_update_bits) {
        ...
        ret = map->reg_update_bits(map->bus_context, reg, mask, val);
    ...
}

qca8k_regmap_update_bits_eth() and qca8k_regmap_update_bits_mii() then
both do this without masking write_val:

	val &= ~mask;
	val |= write_val;

The old regmap_set_bits() and regmap_clear_bits() calls only passed mask
or 0. With this change, every partial PORT_STATUS update ORs the cached
non-mask fields into the live register. That covers link_down,
port_enable/disable, qca8k_set_pm(), the MTU pause restore and the retry
worker.

The live non-mask bits can differ from the cache. For example, the switch
may lose state across suspend before qca8k_set_pm(priv, 1). Or a port 1-5
may be in LINK_AUTO with hardware-updated speed bits while the cache
still holds forced speed bits.

In those cases, could this turn on flow control or duplex bits that no
phylink decision requested? Could it also combine two SPEED encodings
into the reserved value 3, until the next full link_up write?

Would passing priv->port_status_value[port] & mask avoid this?

[ ... ]

> @@ -751,8 +815,10 @@ int qca8k_port_enable(struct dsa_switch *ds, int port,
>  {
>  	struct qca8k_priv *priv = ds->priv;
>  
> -	qca8k_port_set_status(priv, port, 1);
> +	mutex_lock(&priv->port_status_lock);
> +	__qca8k_port_set_status(priv, port, 1);
>  	priv->port_enabled_map |= BIT(port);
> +	mutex_unlock(&priv->port_status_lock);
>  
>  	if (dsa_is_user_port(ds, port))
>  		phy_support_asym_pause(phy);

[Severity: High]
This isn't a bug introduced by this patch, but can phy be NULL here for a
user port that has no PHY?

Take a fixed-link port, or an in-band/SFP port on 0 or 6 without a
phy-handle. For these, phylink_fwnode_phy_connect() returns 0 without
attaching a PHY:

	if (!phylink_expects_phy(pl))
		return 0;

dsa_user_phy_setup() then succeeds without taking its -ENODEV fallback,
so dev->phydev stays NULL. Bringing the interface up then goes:

dsa_user_open()
  dsa_port_enable_rt(dp, dev->phydev)
    qca8k_port_enable(ds, port, NULL)
      phy_support_asym_pause(NULL)
        phy_copy_pause_bits(phydev->advertising, phydev->supported)

phy_support_asym_pause() has no NULL check. This would oops in ndo_open
with RTNL held. The code has looked like this since commit b3a302b171f7
("net: dsa: qca8k: move set age/MTU/port enable/disable functions to
common code").

Would it be enough to check phy as well as dsa_is_user_port() here?

[ ... ]

> @@ -782,27 +852,53 @@ int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
>  	if (!dsa_is_cpu_port(ds, port))
>  		return 0;
>  

[ ... ]

> +	mutex_lock(&priv->port_status_lock);
> +
> +	ports = BIT(0) | BIT(6);
> +
> +	/* Do not mistake a failed restore for a new link-down decision. */
> +	for_each_set_bit(i, &ports, QCA8K_NUM_PORTS) {
> +		ret = qca8k_port_status_restore(priv, i);
> +		if (ret)
> +			goto unlock;
> +	}

[Severity: Medium]
If ports 0 and 6 are both CPU ports, can qca8k_port_change_mtu() return
an error after the frame size has already been committed?

dsa_switch_mtu() calls port_change_mtu once for every port that
dsa_port_mtu_match() accepts, and that includes every CPU port. It returns
the first error:

net/dsa/switch.c:dsa_switch_mtu() {
    ...
		if (dsa_port_mtu_match(dp, info)) {
			ret = ds->ops->port_change_mtu(ds, dp->index,
						       info->mtu);
			if (ret)
				return ret;
    ...
}

QCA8K_MAX_FRAME_SIZE is a single global register, so the sequence could
be:

call 1, port 0:
  qca8k_write(priv, QCA8K_MAX_FRAME_SIZE, ...) succeeds
  qca8k_port_status_update() restore fails, mask stays pending
  returns 0

call 2, port 6:
  qca8k_port_status_restore() on the pending port fails again
  goto unlock, returns the error

If the regmap_read() snapshot or regmap_clear_bits() fails in call 2,
the result is the same.

dsa_user_change_mtu() then jumps to out_cpu_failed, which only does:

	if (new_conduit_mtu != old_conduit_mtu)
		dev_set_mtu(conduit, old_conduit_mtu);

The user and conduit netdevs keep their old MTU while MAX_FRAME_SIZE
keeps the new value. If the MTU was being shrunk, the switch would drop
frames that the netdev MTUs still allow, until the next MTU change.

Isn't this the mismatch that the "A restore failure must not report a
committed frame size as rejected" comment and the commit message are
meant to prevent?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019173716.198475-1-yongzhao.derek%40gmail.com
