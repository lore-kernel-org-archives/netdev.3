Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCCC29BD91;
	Fri,  2 Oct 2026 04:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790914247; cv=none; b=K4/uo8NvM7nyhxe+NRcTm7GV07RH55HETLHZ68+gFJz42MjYGwnbbcdFngxNRxycM2sZ3ZenhX1gWKijN3vLn8P7axf8633c1GfrFda3cyiFP+4tWwJk93GagOOYgTJzw1fS3UiHDIhKHhLrD7C/KnYV5FYlbtaGpkMCoutWzb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790914247; c=relaxed/simple;
	bh=EIJOChoEaEBYESXE80s9ndb/MUmkNCdLxI8pLXZEk0Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=taKhVnwXYXu+jdbM3uhpUTOMOXf1l6sr5rD7Z1IKdZXxVCHWCHR/h5q+nqR6s0/FhezeN8dQ1R/j3P2GR3lPWMKoNHs2eDpTtlbbLkB1yj7wIDIItYzHkcfnsmGgjpBY7rwrw0W9bDKckxfgvl7YL2VHx5dUuIC0r8xdlTEU3K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQ1mi4za; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQ1mi4za"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1204F1F000FF;
	Fri,  2 Oct 2026 04:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790914245;
	bh=7EiCnC+fxZoU5zU0lqX0ZAzpiXyCq5Hiv/8TdrXYdFg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UQ1mi4zaJBmJbf4oVKRHX52ReKdm2jPrqU44Zls9vs1lPUFR4wBVyOjJZcZMEvIRL
	 85DhJV66p279niy7hV3uNFAMoe/i79/9IjSXzkG1zbalJVucMtpBbrr2xFmvg9BpAg
	 i32O28p6CMEbD+PV40xKufOBe9/ocI/HdwwuIcDSiM15D9M/N8S3VkVP4rsJM4/kQt
	 ppqv9uRffeDpklY3j7/hWP5eE/e2Km4XSvQGtoD8Oq21hi+ddtfNB6zuzvgZQ4O+6W
	 OU1bGDzJUpEY5guhbMo4RWomYJrXNA9um8eCR9IVR3UcApfHIS4WKki710KPoXby4x
	 UzIIWdzfnP1xA==
Subject: Re: [PATCH net-next v4 2/3] net: dsa: qca8k: serialize CPU MAC pause
 during MTU changes
From: netdev-bot+sashiko@kernel.org
To: yongzhao.derek@gmail.com
Cc: netdev@vger.kernel.org, hzyitc@outlook.com, ansuelsmth@gmail.com,
 andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, florian.fainelli@broadcom.com,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 04:10:44 +0000
Message-ID: <179091424456.434549.5853243408552872110@kernel.org>
In-Reply-To: <20260928220811.1880-3-yongzhao.derek@gmail.com>
References: <20260928220811.1880-3-yongzhao.derek@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the new error handling works: it will
  "abort before updating the frame size if ... pausing the MAC fails"…
- [Medium] For internal-PHY CPU ports (1-5), which this patch adds to the
  pause set, qca8k_port_change_mtu() clears only TXMAC|RXMAC (`mask`,…
- [Low] The concern: the commit message treats a CPU port on internal-PHY
  ports 1-5 as a live configuration, though the driver in this tree only…

--

net: dsa: qca8k: serialize CPU MAC pause during MTU changes

This commit adds internal PHY CPU ports 1-5 to the pause sequence that
runs in qca8k_port_change_mtu() before QCA8K_MAX_FRAME_SIZE is written.
It takes reg_mutex to serialize that sequence against port enable, port
disable and phylink link transitions. It also saves each port's
TXMAC/RXMAC bits and restores them afterwards, with new error handling
that aborts and restores on failure.

> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index 60f2a615a5cc2..dfe18b6e936bf 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -1483,7 +1483,9 @@ qca8k_phylink_mac_link_up(struct phylink_config *config,
>  
>  	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
>  
> +	mutex_lock(&priv->reg_mutex);
>  	qca8k_write(priv, QCA8K_REG_PORT_STATUS(port), reg);
> +	mutex_unlock(&priv->reg_mutex);
>  }

[Severity: Low]
This isn't a bug, but should part of this change carry a Fixes: tag?

qca8k_phylink_mac_link_up() and the link-down callback run from the
phylink resolve work without rtnl. qca8k_port_change_mtu() runs under
rtnl.

Before this patch, a concurrent link-up could set TXMAC/RXMAC on port 0
or 6 after the pause but before the QCA8K_MAX_FRAME_SIZE write. The same
goes for restoring ports 0 and 6 to their previous state instead of
always turning them back on. Both look like fixes for existing behavior.

The commit message also treats a CPU port on internal PHY ports 1-5 as a
configuration that exists today. In this tree, qca8k_find_cpu_port()
only accepts ports 0 or 6. That support arrives later in the series in
"net: dsa: qca8k: support QCA8337 internal PHY CPU links". Could the
message say this part is preparation for that commit?

> diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
> index 13005f10edb7d..6b32bdd75eabe 100644
> --- a/drivers/net/dsa/qca/qca8k-common.c
> +++ b/drivers/net/dsa/qca/qca8k-common.c

[ ... ]

> @@ -764,14 +774,20 @@ void qca8k_port_disable(struct dsa_switch *ds, int port)

[ ... ]

>  int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
>  {
> +	u32 mask = QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
>  	struct qca8k_priv *priv = ds->priv;

[ ... ]

> @@ -784,25 +800,58 @@ int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
>  
>  	/* To change the MAX_FRAME_SIZE the cpu ports must be off or
>  	 * the switch panics.
> -	 * Turn off both cpu ports before applying the new value to prevent
> -	 * this.
> +	 * Include internal PHY CPU ports as well as the two MAC-only ports.
> +	 * Toggle only MAC enables, preserving the phylink link-control mode.
>  	 */
> -	if (priv->port_enabled_map & BIT(0))
> -		qca8k_port_set_status(priv, 0, 0);
> +	ports = BIT(0) | BIT(6);
> +	for (i = 1; i < 6; i++)
> +		if (dsa_is_cpu_port(ds, i))
> +			ports |= BIT(i);

[Severity: Medium]
For internal PHY CPU ports 1-5, which are now in the pause set, does
clearing only TXMAC and RXMAC actually stop the MAC?

The driver's existing disable path also clears LINK_AUTO for those
ports:

qca8k_port_set_status_locked() {
	...
	/* Port 0 and 6 have no internal PHY */
	if (port > 0 && port < 6)
		mask |= QCA8K_PORT_STATUS_LINK_AUTO;
	...
}

If LINK_AUTO (LINK_EN) stays set, the MAC may keep following the
internal PHY's link state. It could then keep passing traffic while
QCA8K_MAX_FRAME_SIZE is rewritten.

One case: qca8k_port_enable() sets TXMAC|RXMAC|LINK_AUTO on the CPU port
during setup. Then the MTU is changed while the user port is created,
possibly before phylink's mac_link_up has rewritten the register:

dsa_user_create()
  dsa_user_change_mtu(user_dev, ETH_DATA_LEN)
    dsa_port_mtu_change(cpu_dp)
      qca8k_port_change_mtu()

qca8k_phylink_mac_link_up() also writes LINK_AUTO in in-band mode and in
the default branch for unknown speeds.

Whether LINK_EN overrides cleared TXMAC/RXMAC is hardware behavior that
can't be confirmed from the code. Since status[] already saves the
original bits, could LINK_AUTO be added to the pause mask for ports 1-5
and restored afterwards?

[ ... ]

> +	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
> +		if (!(ports & BIT(i)) || !(status[i] & mask))
> +			continue;
> +
> +		stopped |= BIT(i);
> +		ret = regmap_clear_bits(priv->regmap, QCA8K_REG_PORT_STATUS(i),
> +					mask);
> +		if (ret)
> +			goto restore;
> +	}

[Severity: Medium]
The commit message says:

  Abort before updating the frame size if reading port status or pausing
  the MAC fails. Attempt to restore all ports already modified, and report
  any restoration failures even if an earlier error occurred.

Can this goto restore fire on the MDIO register path?
qca8k_mii_write32() in qca8k-8xxx.c returns void:

static void
qca8k_mii_write32(struct mii_bus *bus, int phy_id, u32 regnum, u32 val)
{
	if (qca8k_mii_write_lo(bus, phy_id, regnum, val) < 0)
		return;

	qca8k_mii_write_hi(bus, phy_id, regnum + 1, val);
}

qca8k_regmap_update_bits_mii() returns the read result and ignores the
write:

	val &= ~mask;
	val |= write_val;
	qca8k_mii_write32(bus, 0x10 | r2, r1, val);

exit:
	mutex_unlock(&bus->mdio_lock);

	return ret;

qca8k_write_mii() only returns the qca8k_set_page() result.

Without mgmt_conduit, or when the Ethernet management path falls back to
MDIO, three calls report success even if the bus write fails:
regmap_clear_bits() here, qca8k_write() of QCA8K_MAX_FRAME_SIZE, and
regmap_update_bits() in the restore loop.

Wouldn't that let MAX_FRAME_SIZE be written while a CPU MAC is still
enabled? It would also mean the "failed to restore MAC state" message
never prints for a failed MDIO write.

The commit message also says:

  The standalone qca8k MDIO error-propagation fix is a prerequisite for
  this series; that error-handling bug predates this locking change.

That fix is not in the tree or in this series. The MDIO write helpers
are still unchanged at the end of the series.

Could the message name the prerequisite commit or link to it, so
maintainers and stable backporters know what must be applied first?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928220811.1880-1-yongzhao.derek%40gmail.com
