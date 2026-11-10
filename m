Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353214;
	b=o5StJZK/FeIs6i9CIP4xdx62EJgQu/VSPthuNssR+qf6E5O5eBsIthQdQCyPVAHI80mV
	 jiMaUUNc4iUmGwewu6fim5+JiJmd7+v0GZW9gETapepQiC7FuyWTGrZEGpnk8F72SLA0U
	 wJHGZxaCUdOpE9ai6E06yNl21yLiK8XZj0ljmsjaJ8HPH9YXK7FI302xbcuxQkmLGOPka
	 /hnuoboV15NT0r7lHqz57fB/59xPVNfv/T9OQEJuTs81ZjhO9utV8FSZ7mIESsME2p3pq
	 zXHK1KmtWFScsDjf4v7eSsy9t7nyLAbbxEi52vexm1cqWFlgFfebLMMR9ZK9WEaf99w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353214;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VHkSyslIGe3LE/Cy+sUOcgTuRzUDEYAipH0v5Afu5Nk=;
	b=AVe3wqNBjXyfATFhxQQWa07FXwlyyHHN4Dkq3/AyovnoyjaPIkJ7S0uV1r9YiC0lZBm0
	 RJlEbPmxt+xxzvvRgaPDdSzI4q7I16QnaqXhKmFqqG0I5cuTXhCHqKJK6q2Q/CB1uojzm
	 G3VfLmji4gXaZ8KCBPYaeUM5SLMRrS8tEWl3T4obgR++UToEwVdeb1IDBHwh3odHQxa8Y
	 +0D/E0qBRSSoVDXAuFHxQ2Vc3UcH+9XRlTRCd3Sn+aI4oxR5mE5KSJPYGsGrn8brWPDIT
	 iTObfZcztFp1sgvOLu3oRGybgG5cV722gXnLbtulM4SV/3fpWfbPk1j0C8A0mv+avjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hi8tt+WG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC09B60A2602;
	Tue, 10 Nov 2026 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hi8tt+WG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5D11F0093D;
	Tue, 10 Nov 2026 23:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353214;
	bh=VHkSyslIGe3LE/Cy+sUOcgTuRzUDEYAipH0v5Afu5Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hi8tt+WGnAaXuKaANcoG5R7B6hi6SqsAbo/brWyFXYPPkzjL1vzSS1ze09EHfcAnY
	 BiDJ3Ru/KM1I6SOfNDMbACeKN/jO05h+9AbuwusYGcKCLr6gE9FjJ4hP1LKrEYcVIA
	 sCKKsn2NV0zrIKVeGp2UiC4ZDLDXl/D3VRwSXY3N95h6tcje9Q7kya3wi4Kipa2EhK
	 R5qHHWL6yH/6kMM2Bqi50KgVFmzqomFKzVOqtHYOZaOpfPvOyQIHBhXRkL/48ZmYyR
	 xcabUAeTrAI6uDlrY5Tf8agsY+XnF3WGyxNT2n6+YausktWrlYaKisz5Pe4GDkKJiF
	 SZjN8aitdeA0Q==
From: Jakub Kicinski <kuba@kernel.org>
To: kyle.switch@motor-comm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mmyangfl@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com,
	sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v17 5/5] net: dsa: motorcomm: Add support for Motorcomm YT922x
Date: Tue, 10 Nov 2026 15:26:53 -0800
Message-ID: <20261110232653.2437215-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105031442.4164960-6-kyle.switch@motor-comm.com>
References: <20261105031442.4164960-6-kyle.switch@motor-comm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: motorcomm: Add support for Motorcomm YT922x

This commit adds support for the YT9224 member of the Motorcomm YT922x
switch family to the existing yt921x DSA driver. It adds a separate set
of dsa_switch_ops and phylink_mac_ops for the YT922x series, a new PCS
driver in pcs-922x.c, and a "motorcomm,yt9224" OF compatible.

> This patch adds basic support for a working DSA switch,
> includes .port_setup, .setup, .phylink_get_caps,
> .get_tag_protocol.

[Severity: Low]
This isn't a bug, but could the commit message cover everything the
patch changes? Beyond the four dsa_switch_ops listed, it also adds:

  - a full phylink_mac_ops set (mac_config, mac_link_up, mac_link_down,
    mac_select_pcs)
  - a new PCS driver in pcs-922x.c for SGMII, 1000BASE-X, 2500BASE-X and
    USXGMII
  - two new MDIO helpers, yt921x_intif_ext_read() and
    yt921x_intif_ext_write()
  - YT921X_SPEED_5000 in the shared enum yt921x_speed, plus a SPEED_5000
    case in ethtool_speed_to_yt921x() that the YT921x path also uses
  - an early return for YT9224 in the shared yt921x_chip_detect(), which
    skips the CHIP_MODE, EXTMODE and SYS_CLK reads
  - removed and reworded error messages in yt92xx_register_switch()

There is also a stray blank line added at the end of mdio_bus.c.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 059775fd184d1..9d92c71205f80 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> +static int
> +yt922x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
> +	       phy_interface_t interface, int speed, int duplex,
> +	       bool tx_pause, bool rx_pause)
> +{

[ ... ]

> +	/*
> +	 * Self-negotiation: the LINK/AN bits in ctrl are set based to inband.
> +	 * Forced mode: set LINK, keep the AN bit at 0 and clear it via the mask
> +	 */
> +	if (pp->inband)
> +		ctrl |= (YT922X_PORT_FC_AN | YT922X_PORT_LINK_AN);
> +	else
> +		ctrl |= YT922X_PORT_LINK;

[Severity: Medium]
Should YT922X_PORT_FC_AN depend on more than pp->inband?

pp->inband is set in yt922x_pcs_config() from:

	bool inband = neg_mode & PHYLINK_PCS_NEG_INBAND;

That is true for both PHYLINK_PCS_NEG_INBAND_ENABLED and
PHYLINK_PCS_NEG_INBAND_DISABLED, and permit_pause_to_mac is never looked
at.

The SGMII and USXGMII control words don't carry pause bits. In those
modes, would the MAC take pause from AN and ignore the tx_pause/rx_pause
that phylink resolved from the PHY?

For 1000BASE-X/2500BASE-X with autoneg disabled, yt922x_pcs_config()
clears BMCR_ANENABLE. The MAC is still told to take pause from AN, though,
and that AN never runs.

The YT921x equivalent in yt921x_serdes_config() uses a narrower
condition:

	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED && permit_pause_to_mac &&
	    interface != PHY_INTERFACE_MODE_SGMII)
		ctrl |= YT921X_PORT_CTRL_PAUSE_AN;

Is something similar needed here?

[ ... ]

> +static int
> +yt922x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
> +		   phy_interface_t interface)
> +{

[ ... ]

> +	switch (interface) {
> +	/* SERDES */
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_100BASEX:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +	case PHY_INTERFACE_MODE_USXGMII:

[Severity: High]
Can this hand phylink a PCS that has no ops? yt922x_pcs_setup()
only fills in pp->pcs.ops for ports in info->serdes_mask, which on
YT9224 is ports 0 and 8. For every other port priv->ports[port].pcs
is left zeroed. yt922x_phylink_mac_select_pcs() still returns
&priv->ports[dp->index].pcs for SGMII, 1000BASE-X, 2500BASE-X and
USXGMII, without checking which port it is asked about.

Suppose the DT gives one of these phy-modes and a fixed-link to an
internal PHY port (4-7) or to one of ports 1-3. phylink_create()
still succeeds, because the fixed-link and initial validation paths
do not treat the -EINVAL from phylink_validate() as fatal.

Then, on phylink_start():

  - phylink_mac_initial_config() calls phylink_major_config()
  - phylink_major_config() calls mac_select_pcs and gets back the
    non-NULL pcs, whose pcs->ops is NULL
  - phylink_pcs_neg_mode() dereferences pcs->ops through
    phylink_pcs_inband_caps(), and phylink_pcs_pre_config() does too

That oopses before yt922x_phylink_mac_config() gets a chance to
reject the mode with its "Wrong mode" error.

The YT921x counterpart, yt921x_phylink_mac_select_pcs(), guards
against exactly this:

	if (!(BIT(port) & info->serdes_mask))
		return NULL;

Should yt922x_phylink_mac_select_pcs() check BIT(dp->index) against
priv->info->serdes_mask in the same way and return NULL otherwise?

[Severity: Low]
This isn't a bug, but is PHY_INTERFACE_MODE_100BASEX meant to be
supported? yt922x_port_config() accepts it here. yt922x_pcs_config() maps
it to YT922X_SERDES_MODE_100BASEX, and yt922x_pcs_get_state() has its own
100BASEX branch.

It is never advertised, though:

  - yt922x_dsa_phylink_get_caps() leaves it out of
    config->supported_interfaces
  - yt922x_pcs_setup() leaves it out of pp->pcs.supported_interfaces
  - yt922x_phylink_mac_select_pcs() returns NULL for it

So phylink validation rejects 100BASEX, and all of that handling is
unreachable. If 100BASEX were later added to the caps without changing
mac_select_pcs, mac_config would accept it with no PCS selected, and the
SerDes mode would never be programmed.

For comparison, the YT921x path does list 100BASEX in its PCS
supported_interfaces.

Should 100BASEX either be added to all four places or dropped from all of
them?

[ ... ]

> @@ -2586,12 +3069,25 @@ static const struct yt92xx_series yt92xx_series_table[] = {
>  		.switch_ops = &yt921x_dsa_switch_ops,
>  		.mac_ops = &yt921x_phylink_mac_ops
>  	},
> +	[YT92XX_MODE_YT922X] = {
> +		.name = "YT922x",
> +		.max_ports = YT922X_PORT_NUM,
> +		.num_lag_ids = YT922X_LAG_NUM,
> +		.ageing_time_min = 1 * 6000,
> +		.ageing_time_max = U16_MAX * 6000,
> +		.dscp_prio_mapping_is_global = true,
> +		.assisted_learning_on_cpu_port = true,

[Severity: Low]
This isn't a bug, but are these flags intended for YT922x at this stage?
yt922x_dsa_switch_ops has no FDB, LAG, bridge or DCB callbacks, yet the
series entry sets num_lag_ids, dscp_prio_mapping_is_global and
assisted_learning_on_cpu_port.

As far as I can tell nothing goes wrong at runtime. Without
.port_bridge_join, dp->bridge stays NULL, and dsa_user_fdb_event()
returns before it reads ds->assisted_learning_on_cpu_port:

	if (!dp->bridge)
		return 0;

Even so, could these be left unset until the matching ops are added?

> +		.switch_ops = &yt922x_dsa_switch_ops,
> +		.mac_ops = &yt922x_phylink_mac_ops,
> +	},
>  };

[ ... ]

> @@ -2716,6 +3210,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
>  
>  static const struct of_device_id yt921x_of_match[] = {
>  	{ .compatible = "motorcomm,yt9215" },
> +	{ .compatible = "motorcomm,yt9224" },

[Severity: Medium]
Does the binding need to be updated along with this?
Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml still
only allows:

  compatible:
    const: motorcomm,yt9215

As a result, any DTS that uses "motorcomm,yt9224" would fail dtbs_check,
and checkpatch would warn that the compatible is undocumented.

The binding's text also describes a different layout from the new YT9224
yt921x_infos entry. It lists only YT9213/14/15/18 parts with GbE PHYs on
ports 0-7 and GMACs on ports 8-9. Its mdio description says "PHY 0-7 are
used for Port 0-7 respectively".

The new entry instead has internal PHYs on ports 4-7 (GENMASK(7, 4)), no
xMII ports, SerDes on ports 0 and 8 (BIT(8) | BIT(0)), and nine ports in
total.

>  	{}
>  };

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/pcs-922x.c b/drivers/net/dsa/motorcomm/pcs-922x.c
> new file mode 100644
> index 0000000000000..5ad7873e0df7e
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/pcs-922x.c

[ ... ]

> +static int yt922x_sds_phyaddr_get(int port,
> +				  enum yt922x_phy_reg_type reg_type)
> +{
> +	if (reg_type == YT922X_PHY_REG_TYPE_COMMON_EXT)
> +		return YT922X_COMMON_EXT_PHYADDR;
> +
> +	return port;
> +}

[Severity: Low]
Is YT922X_PHY_REG_TYPE_SDS_COMMON_EXT supposed to map to the plain port
number? Only COMMON_EXT gets special handling, and no caller passes it.
That leaves YT922X_COMMON_EXT_PHYADDR and the COMMON_EXT/EXT enum values
unused.

yt922x_pcs_config() asks for SDS_COMMON_EXT and uses the per-port address
it gets back for both YT922X_PCS_WRITE_PROTECT (0x4be) and
YT922X_PORT_SDSn (0x400). YT922X_PORT_SDSn is named as a per-port
register but takes no port index.

If those registers are actually in the shared common extended space,
the SerDes mode would be written at the wrong MDIO address.

This helper also never returns a negative value, so the addr < 0 checks
in all five PCS callbacks can't trigger, and nothing confirms that port
is a SerDes port.

[ ... ]

> +static void yt922x_pcs_an_restart(struct phylink_pcs *pcs)
> +{

[ ... ]

> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_intif_read(priv, addr, MII_BMCR, &bmcr);
> +	if (res)
> +		goto err;
> +	bmcr |= BMCR_ANRESTART;
> +	bmcr |= BMCR_RESET;
> +	res = yt921x_intif_write(priv, addr, MII_BMCR, bmcr);

[Severity: Medium]
Is BMCR_RESET intended here? Under clause 22, a reset puts the control
and status registers back to their defaults. Nothing here waits for the
self-clearing reset bit to clear, either.

yt922x_pcs_config() reports a change whenever BMCR_ANENABLE flips:

	changed |= (bmcr_new != bmcr_old);

When pcs_config returns a positive value, phylink_major_config() calls
the an_restart op right away:

phylink_major_config()
  phylink_pcs_config() -> yt922x_pcs_config() returns 1
  phylink_pcs_an_restart() -> yt922x_pcs_an_restart()
    BMCR_RESET

Could that reset undo the ANENABLE setting and the MII_ADVERTISE word
that pcs_config just wrote? One example is AN being re-enabled on an
outband 2500BASE-X fixed-link CPU port.

With pcs.poll set, could the next yt922x_pcs_get_state() also read the
PCS while it is still in reset?

The YT921x yt921x_serdes_config() does the reverse and clears changed
when ANENABLE flips, because the PHY restarts negotiation by itself.

[ ... ]

> +static int yt922x_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> +			     phy_interface_t interface,
> +			     const unsigned long *advertising,
> +			     bool permit_pause_to_mac)
> +{

[ ... ]

> +	mutex_lock(&priv->reg_lock);
> +
> +	/* write protect */
> +	res = yt921x_intif_ext_write(priv, addr, YT922X_PCS_WRITE_PROTECT, 0xd);
> +	if (res)
> +		goto err;

[Severity: Low]
Should YT922X_PCS_WRITE_PROTECT be restored afterwards? 0xd is written
here and never put back, on either the success path or the goto err
paths. The write also comes before the interface switch, so the -EINVAL
default case returns with the protection register already changed.

If 0xd unlocks the space, the SerDes extended registers stay writable
from then on. If it locks the space, as the comment says, could the
YT922X_PORT_SDSn write that follows be dropped by the hardware even
though the driver records success?

> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +		ctrl = YT922X_SERDES_MODE_SGMII;
> +		break;

[ ... ]
