Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793031714;
	b=LVd7Cg7jrGk87wrowE3vphSmsitjuuYskuAJV4aibIjrw/sIaG68o/iFZzaJynInA22M
	 w6FYmS0itxp9ZRNdsfD0HLiVIMEd0jvuwR41x+rZLtP+77nmjXD4Hcp3X7iiYBNSyRENu
	 rGoiRr0VUBZypnL7uWKL4SI2P8t6OExHd9okjIG1mGiez5kVPNhJ63ZjfJUydxJSTnrxr
	 xYJkw/M4DifnSWH+Jwtu6xSr1KWM7lEZBZW2Jmad5xEWmsZlVWbk776rLyMWAgBWSUFJa
	 WsHKiMeDcc/wxXe3nIFlwraNiWTX9HUTOnAcZMAYf3SL5FAK49MNVUsSDoYsXllJDng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793031714;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vFJvSTUDUI+jot4qzzEf7rMhildAD64LDwSLK2QFNKk=;
	b=g7bW8uXud3tAIHfJj7Q52xe6w6ePNFAWXAlOc1sW8093pN8ngHUb+eHMLcy42OUYKWv4
	 xFpBvtOQkHMkthiaESHQewaK5TouO2+ghCm6JkQqwxzlzMgFtMRZiuXj0qjD7L+Zny4gi
	 IWZB9FzHeobaunnjFb1RniiFBhPaQkmfNVoeQQdqkcFUHTT1M3Cr5dRGQj9/qfbG9C0l/
	 Q0AG6L26XYDLHJZBrVLOpfU2/YRokZGZI1CYY4p9HHzTPn6weonOA40JsT5zxdspb7K8J
	 CxiVhf/3ZUlpGWSyUjU4A9j0LZZnYmovDKXLkqbOnplQGAzXw7LcL84NpN0hx02tcWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZnDX5/NU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7C606A31A;
	Mon, 26 Oct 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnDX5/NU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56A21F01825;
	Mon, 26 Oct 2026 16:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793031713;
	bh=vFJvSTUDUI+jot4qzzEf7rMhildAD64LDwSLK2QFNKk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZnDX5/NUB/Yw2H2bYzCKezL16HGsJsa94oypBA6W1FgmppfufYwKhhlTdJmAMzAPS
	 HGxV/A8x1hpp8Y+mHY4dIiHTBpjphUF0UdN8xpBVyThbdHy6g/iGUZ9t/lBSSpFk2Y
	 nZvS+QyNWfmPTYAyWzq5t2RmjFJPElKQqe4+D7+tJAsoYSTCEwPKFvzA7lU5/Yy5gN
	 kztzERck2uzND2XtmPvpBeXn4DH1lMY7v1ZEUZPOw67xMahZaOsZjTF6g0fsna/cn4
	 gOErYJ5290bD0XdxEMh4SKhUA+94VmLGSUJVx9QHKa7NnTkKrqyx5qKs3ebAo9hBlA
	 t2gg8pfCiRoJA==
Subject:
 Re: [PATCH net v7] net: dsa: qca8k: preserve port state across MTU changes
From: netdev-bot+sashiko@kernel.org
To: yongzhao.derek@gmail.com
Cc: netdev@vger.kernel.org, ansuelsmth@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 florian.fainelli@broadcom.com, linux-kernel@vger.kernel.org,
 hzyitc@outlook.com
Date: Mon, 26 Oct 2026 16:21:52 +0000
Message-ID: <179303171241.3134.15019965307136674652@kernel.org>
In-Reply-To: <20261022155837.760-1-yongzhao.derek@gmail.com>
References: <20261022155837.760-1-yongzhao.derek@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In qca8k_port_change_mtu()
  (drivers/net/dsa/qca/qca8k-common.c), the decision to pause a CPU MAC…

--

net: dsa: qca8k: preserve port state across MTU changes

This patch adds a dedicated mutex that serializes the MTU update with all
PORT_STATUS writers. During the update, the MAC bits of the enabled CPU
ports are saved and restored instead of being forced back on afterwards.
Failed status writes are recorded and retried from a delayed work, and the
committed MAX_FRAME_SIZE is tracked so a duplicate call for the same value
returns early.

> diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
> index 13005f10edb7d..d9db5e57928ee 100644
> --- a/drivers/net/dsa/qca/qca8k-common.c
> +++ b/drivers/net/dsa/qca/qca8k-common.c

[ ... ]

> @@ -782,27 +856,59 @@ int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
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

[ ... ]

> +	ports &= priv->port_enabled_map;
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

[Severity: Medium]
Can a concurrent register reader corrupt the status[] snapshot here and
make this skip the pause?

qca8k_regmap_config in qca8k-8xxx.c has:

    .disable_locking = true, /* Locking is handled by qca8k read/write */

So regmap_read() goes through _regmap_bus_read() and takes no regmap lock.
The register address is formatted into the shared map->work_buf, and
qca8k_bulk_read() reads it back from there:

    u32 reg = *(u16 *)reg_buf;

The value is parsed from the shared work_val only after the transport has
released mdio_lock:

drivers/base/regmap/regmap.c:_regmap_bus_read() {
    ...
    ret = _regmap_raw_read(map, reg, work_val, map->format.val_bytes, false);
    if (ret == 0)
        *val = map->format.parse_val(work_val);
    ...
}

port_status_lock does not cover readers such as qca8k_pcs_get_state().
Phylink calls it from its resolve worker without RTNL, and it is polled
because qca8k_setup_pcs() sets pcs.poll = true. The LED hw_control_get
path is another reader that takes no lock.

For example, with port 0 enabled and port 6 in in-band mode after a
link_down:

CPU1 (RTNL held)
qca8k_port_change_mtu()
  regmap_read(QCA8K_REG_PORT_STATUS(0))

CPU2
phylink_resolve()
  qca8k_pcs_get_state(port 6)
    qca8k_read(priv, QCA8K_REG_PORT_STATUS(port), &reg)

Suppose port 6's address or value lands in work_buf before port 0's value
is parsed. Then status[0] would have no TXMAC/RXMAC bits, the continue
above would skip port 0, and this write would run with the port 0 MAC
still enabled:

> +		__set_bit(i, &stopped);
> +		ret = regmap_clear_bits(priv->regmap, QCA8K_REG_PORT_STATUS(i),
> +					mask);
> +		if (ret)
> +			goto restore;
> +	}
>  
> -	if (priv->port_enabled_map & BIT(0))
> -		qca8k_port_set_status(priv, 0, 1);
> +	ret = qca8k_write(priv, QCA8K_MAX_FRAME_SIZE, frame_size);

Commit 386228c694bf says this state stops the switch from sending packets
until reset.

The shared work_buf race itself predates this patch. However, the old pause
was an unconditional regmap_clear_bits(), which goes through
qca8k_regmap_update_bits() and does not use work_buf. So it could not be
skipped this way.

The window is small, but should the pause avoid depending on this unlocked
read? One option would be to clear the MAC bits of the enabled CPU ports
unconditionally, as before.

> +	if (!ret)
> +		priv->max_frame_size = frame_size;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022155837.760-1-yongzhao.derek%40gmail.com
