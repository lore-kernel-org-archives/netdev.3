Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0B54848AC;
	Mon, 19 Oct 2026 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407753; cv=none; b=d9UI5BNBmXA7I0lwFpu1qAKcgoxJ6dooQwgMm2y6Gu9N8bYCxhdj0r1r1HOJVkvSqckJtnD417WFgPfZJdBrSZPhKoVbCQPhVbYp8eOoilu9RpxIOhMBWIqK2nPbdBDTSjp9QvV158gxGB+vvg5N72GWtSWno2K99AF2KwewQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407753; c=relaxed/simple;
	bh=VQWE5qSmq/PbzwcSQdiCohOFF8g0JMgi3k6teDvgVsc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nnEI7vV3kHWq7JdzrCYkR7twJnw+6iN43DYnZMstpeb9/AfS8Lhb65m9oa7muW8bmpkNM/BvxLgm/b0pJ5X6cHsG9bLKSZ3tybIuBRdHdJ39eZ8LIqGl3yX85iPqI860fsXRpcDMyEqkHqKSByelu35Ep0rsZpCmgCY6csNz28o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRVqusUG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRVqusUG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376CA1F000C5;
	Mon, 19 Oct 2026 11:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792407752;
	bh=nmJ3Y0wL9KjB35FjrT6M/q1X1i7ns1JCug/N9Mv/0EA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kRVqusUGE7Mq+Mvfi9NjGt+uB8v+zMhAiH5J+dtkrTi+Ps0xfuYxmgNmaRv66osSB
	 TPRrVHutR9O8UgDSfVaYsIk9qSo3mMWwDu8XqA0s1FLaavSdaa2//d210kC4JgWUIT
	 /U90lRJh5cIXTlBIxwzGVy8Gcam7ZdvVXlGK8HEE8d0TtlZSv/8t8Vj3b9X+X6CbUs
	 OwutD3uU78OWSkpWddgyIkdfwftPCCe1GMmm7wtwAoLaw9AtyWSFcN0lpBZ4Hd8L9w
	 YO7wvLzLLwdFgDS5HpEwANTLANMlzBHaQp26eKbMGZQxYZeFzptNvzWx6kYBrcqiZU
	 mlsOiibU4oVxA==
Subject:
 Re: [PATCH net v5] net: dsa: qca8k: preserve port state across MTU changes
From: netdev-bot+sashiko@kernel.org
To: yongzhao.derek@gmail.com
Cc: netdev@vger.kernel.org, ansuelsmth@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 florian.fainelli@broadcom.com, linux-kernel@vger.kernel.org,
 hzyitc@outlook.com
Date: Mon, 19 Oct 2026 11:02:30 +0000
Message-ID: <179240775070.3135.2434822808609533404@kernel.org>
In-Reply-To: <20261015104550.43169-1-yongzhao.derek@gmail.com>
References: <20261015104550.43169-1-yongzhao.derek@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When qca8k_port_change_mtu()
  (drivers/net/dsa/qca/qca8k-common.c) fails partway, the hardware can…

--

net: dsa: qca8k: preserve port state across MTU changes

This patch adds a port_status_lock mutex. The lock serializes the
MTU update in qca8k_port_change_mtu() with the PORT_STATUS writers,
including the phylink mac_link_up callback. The MTU path now saves the
TXMAC/RXMAC bits of enabled ports 0 and 6 and restores them, where it
used to force them back on. It also returns the first error it hits
during the read, pause, write or restore steps.

> diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
> index 13005f10edb7d..084df92c53c40 100644
> --- a/drivers/net/dsa/qca/qca8k-common.c
> +++ b/drivers/net/dsa/qca/qca8k-common.c

[ ... ]

> @@ -782,27 +805,54 @@ int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
>  	if (!dsa_is_cpu_port(ds, port))
>  		return 0;
>  
> -	/* To change the MAX_FRAME_SIZE the cpu ports must be off or
> -	 * the switch panics.
> -	 * Turn off both cpu ports before applying the new value to prevent
> -	 * this.
> +	/* To change MAX_FRAME_SIZE, pause enabled ports 0 and 6.
> +	 * Serialize with phylink and restore the saved MAC state.
>  	 */
> -	if (priv->port_enabled_map & BIT(0))
> -		qca8k_port_set_status(priv, 0, 0);
> +	mutex_lock(&priv->port_status_lock);
> +
> +	ports = (BIT(0) | BIT(6)) & priv->port_enabled_map;
>  
> -	if (priv->port_enabled_map & BIT(6))
> -		qca8k_port_set_status(priv, 6, 0);
> +	for_each_set_bit(i, &ports, QCA8K_NUM_PORTS) {
> +		ret = regmap_read(priv->regmap, QCA8K_REG_PORT_STATUS(i),
> +				  &status[i]);
> +		if (ret)
> +			goto unlock;
> +	}
> +
> +	for_each_set_bit(i, &ports, QCA8K_NUM_PORTS) {
> +		u32 mask = qca8k_port_status_mask(i);
> +
> +		if (!(status[i] & mask))
> +			continue;
> +
> +		__set_bit(i, &stopped);
> +		ret = regmap_clear_bits(priv->regmap, QCA8K_REG_PORT_STATUS(i),
> +					mask);
> +		if (ret)
> +			goto restore;
> +	}
>  
>  	/* Include L2 header / FCS length */
>  	ret = qca8k_write(priv, QCA8K_MAX_FRAME_SIZE, new_mtu +
>  			  ETH_HLEN + ETH_FCS_LEN);
>  
> -	if (priv->port_enabled_map & BIT(0))
> -		qca8k_port_set_status(priv, 0, 1);
> -
> -	if (priv->port_enabled_map & BIT(6))
> -		qca8k_port_set_status(priv, 6, 1);
> +restore:
> +	for_each_set_bit(i, &stopped, QCA8K_NUM_PORTS) {
> +		u32 mask = qca8k_port_status_mask(i);
> +
> +		restore_ret = regmap_update_bits(priv->regmap,
> +						 QCA8K_REG_PORT_STATUS(i),
> +						 mask, status[i] & mask);
> +		if (restore_ret) {
> +			dev_err(priv->dev, "failed to restore MAC state on port %d: %d\n",
> +				i, restore_ret);
> +			if (!ret)
> +				ret = restore_ret;
                                ^^^^

[Severity: Medium]
What happens when the qca8k_write() of QCA8K_MAX_FRAME_SIZE succeeds
but the restore regmap_update_bits() fails for port 0 or 6?

qca8k_regmap_update_bits() can fall back to
qca8k_regmap_update_bits_mii(). That function returns an error if
qca8k_set_page() or qca8k_mii_read32() fails. In that case, the
successful frame-size change is reported to the caller as an error.

The CPU-port call comes from:

dsa_user_change_mtu()
  dsa_port_mtu_change(cpu_dp, cpu_mtu)
    dsa_tree_notify()
      dsa_switch_mtu()
        qca8k_port_change_mtu()

On error, dsa_user_change_mtu() in net/dsa/user.c takes this path:

	err = dsa_port_mtu_change(cpu_dp, cpu_mtu);
	if (err)
		goto out_cpu_failed;
	...
out_cpu_failed:
	if (new_conduit_mtu != old_conduit_mtu)
		dev_set_mtu(conduit, old_conduit_mtu);

That path only reverts the conduit MTU. Does the switch-global
MAX_FRAME_SIZE register then keep the new value, while DSA and the
conduit keep the old MTU? Nothing seems to write the old frame size
back.

The same failure also leaves TXMAC/RXMAC cleared on the CPU port.
port_enabled_map still has the bit set, and phylink still thinks the
link is up. A fixed-link CPU port gets no further mac_link_up(), so
nothing rewrites PORT_STATUS.

Before this patch, the next MTU change called
qca8k_port_set_status(priv, i, 1), which forced the MAC back on and
recovered the port. With this patch, the next MTU change reads
PORT_STATUS, sees the MAC bits as 0, and skips the port:

		if (!(status[i] & mask))
			continue;

Can this leave the CPU port MAC off until a link flap or reboot? This
check cannot tell "phylink turned the MAC off" apart from "an earlier
restore failed".

Two options: keep returning success once MAX_FRAME_SIZE has been
written, or roll MAX_FRAME_SIZE back on failure. Either way, should a
failed restore stop being treated as the saved state on later calls?

> +		}
> +	}
>  
> +unlock:
> +	mutex_unlock(&priv->port_status_lock);
>  	return ret;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015104550.43169-1-yongzhao.derek%40gmail.com
