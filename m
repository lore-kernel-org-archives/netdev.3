Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5567348C6F;
	Fri, 25 Sep 2026 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790302787; cv=none; b=AF9pHfJEBGu68vYyftd9Ow8P05GdWaR+pC1b9Wipalja7VjvQPY8geyiksWty1LMiKt04A8NTugDzshzwoCGiHib41yuySQYd2fDxr6h5YqnguqBvmRxVV4aOkewF/KL0fgd3fJd+lu3sZD56Mb20w2bBlebzsdOBwF+CYuQm4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790302787; c=relaxed/simple;
	bh=5d1IMb44AVKj6v8CMu+pa4/V3lY1E8LHHMH4mbMTua4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=du2xVFGkkGo5H5NofYaQX3IFysD9lE7Djvy6YcsEMLe5vFGS4BDfwZJpjM0iBNzkF8Uo+s63y8mncW0ymlODdSeEdx5PQnt0/CZ29BG8WgTdhtOv6TtN3Ehop5RQ2DBanbZ3JutzqwHsdYASe5afjx+zXehOiYe2fZAg8FF0LQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRXvEZFN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRXvEZFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A163D1F000FF;
	Fri, 25 Sep 2026 02:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790302785;
	bh=Lt6ZSl+CO/t8SKf5uO4mhsTaM/8pXBSu+eH4k2cDzGE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eRXvEZFNETXfZI52grJ91XZ/OAjtokeRxVFEy4i7FjjB+7FxcyQxfWRELNYcawq/Q
	 IjXlzwN+xGtRb/Z7YzWvgPCQ6LzaFHgWcjU22XevzET/AQLq999DixDW5F48H5IZe/
	 /z+/WU9MBwLXc5eB0GzSX5NFiEakgj7uZwubkZdRTtauHaYgv0+Di66+oZg41LgeHN
	 KWALUWt0U6z2PZkRIhRRdt7JK28i0ytq8rPSW+NVDLYtfqc/woKm/7SgE7WaZQPjlm
	 Z0yFAOyxdoPQ3YGSal13mowutt9AoWGY+jh4EorgrYkfBP1MWuCQz8/TMNspise63r
	 iTgQy/PktTRSQ==
Subject: Re: [PATCH net-next v4 2/8] net: dsa: motorcomm: Split xMII and
 SERDES port masks
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 02:19:44 +0000
Message-ID: <179030278415.2160803.7209731671356572587@kernel.org>
In-Reply-To: <20260923021945.2203368-3-mmyangfl@gmail.com>
References: <20260923021945.2203368-3-mmyangfl@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After this patch, a GMAC port that is in xmii_mask but not in
  serdes_mask gets an empty supported_interfaces bitmap.
- [Low] Two comments in yt921x_dsa_phylink_get_caps()
  (drivers/net/dsa/motorcomm/chip.c) no longer match the code after this…

Pre-existing issues:
- [Low] The concern: the in-tree binding example
  (Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml,…

--

net: dsa: motorcomm: Split xMII and SERDES port masks

This commit replaces external_mask in struct yt921x_info with two
separate fields, xmii_mask and serdes_mask. It changes
yt921x_dsa_phylink_get_caps() so that SERDES modes are only advertised
for ports in serdes_mask. It also moves struct yt921x_info into chip.h.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 825e0bfcff86f..54881856b796a 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -96,53 +96,48 @@ static const struct yt921x_mib_desc yt921x_mib_descs[] = {

[ ... ]

>  	{
>  		"YT9215S", YT9215_MAJOR, 2, 0,
>  		GENMASK(4, 0),
> -		BIT(8) | BIT(9),
> +		BIT(9),
> +		BIT(8),
>  	},
>  	{
>  		"YT9215RB", YT9215_MAJOR, 3, 0,
>  		GENMASK(4, 0),
>  		BIT(8) | BIT(9),
> +		0,
>  	},
>  	{
>  		"YT9214NB", YT9215_MAJOR, 3, 2,
>  		BIT(1) | BIT(3),
> -		BIT(8) | BIT(9),
> +		BIT(9),
> +		BIT(8),
>  	},

[ ... ]

> @@ -4021,15 +4016,10 @@ yt921x_dsa_phylink_get_caps(struct dsa_switch *ds, int port,
>  		 */
>  		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
>  			  config->supported_interfaces);
> -	} else if (info->external_mask & BIT(port)) {
> -		/* TODO: external ports may support SERDES only, XMII only, or
> -		 * SERDES + XMII depending on the chip. However, we can't get
> -		 * the accurate config table due to lack of document, thus
> -		 * we simply declare SERDES + XMII and rely on the correctness
> -		 * of devicetree for now.
> -		 */
> +		return;
> +	}

[Severity: Low]
This isn't a bug, but the comment at the top of the internal_mask branch
still says:

	/* Port 10 for MCU should probably go here too. But since that
	 * is untested yet, turn it down for the moment by letting it
	 * fall to the default branch.
	 */

The if/else-if chain is now an early return followed by two independent
if blocks, so there is no default branch anymore. Could this comment be
updated?

The same applies to the trailing comment at the end of
yt921x_dsa_phylink_get_caps():

	/* no such port: empty supported_interfaces causes phylink to turn it
	 * down
	 */

Real GMAC ports that are only in xmii_mask now reach this comment too
(YT9215RB ports 8 and 9, and port 9 on YT9215S and YT9214NB). Should it
be reworded so that it doesn't describe those ports as nonexistent?

>  
> -		/* SERDES */
> +	if (BIT(port) & info->serdes_mask) {
>  		__set_bit(PHY_INTERFACE_MODE_SGMII,
>  			  config->supported_interfaces);
>  		/* REVSGMII (SGMII in PHY role) should go here, once
> @@ -4042,9 +4032,8 @@ yt921x_dsa_phylink_get_caps(struct dsa_switch *ds, int port,
>  		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
>  			  config->supported_interfaces);
>  		config->mac_capabilities |= MAC_2500FD;
> -
> -		/* XMII */
> -
> +	}
> +	if (BIT(port) & info->xmii_mask) {
>  		/* Not tested. To add support for XMII:
>  		 *   - Add proper interface modes below
>  		 *   - Handle them in yt921x_port_config()

[Severity: Medium]
If a port is in xmii_mask but not in serdes_mask, this block sets no
interface modes, so supported_interfaces stays empty. With the new table,
that covers ports 8 and 9 on YT9215RB (serdes_mask is 0) and port 9 on
YT9215S and YT9214NB.

Before this patch, these ports were in external_mask. They advertised
SGMII, 100BASE-X, 1000BASE-X and 2500BASE-X, so phylink_create()
succeeded. The xMII -EINVAL from yt921x_port_config() was only logged,
and yt921x_port_up() still enabled the MAC on ports 8 and 9.

Now phylink_create() rejects the empty bitmap:

drivers/net/phy/phylink.c:phylink_create() {
    ...
	if (phy_interface_empty(config->supported_interfaces)) {
		dev_err(config->dev,
			"phylink: error: empty supported_interfaces\n");
		return ERR_PTR(-EINVAL);
	}
    ...
}

If one of these ports is the CPU port in the device tree, does the whole
switch now fail DSA setup?

dsa_tree_setup_ports()
  dsa_port_setup()
    dsa_shared_port_link_register_of()
      dsa_shared_port_phylink_register()
        phylink_create()   <- returns -EINVAL

After that, dsa_tree_setup_ports() goes to teardown. CPU ports don't have
the fallback to an unused port that user ports get. On YT9215RB this
affects both GMACs, so a CPU conduit on port 8 or 9 would fail. A user
port in the same situation is silently turned into an unused port.

yt921x_port_config() still has no xMII handling, so nothing takes the
place of the removed SERDES modes:

	/* add XMII support here */
	default:
		return -EINVAL;

This is still the case at the end of the series. In "net: dsa: motorcomm:
Add SerDes PCS", the xmii_mask branch is still empty and
yt921x_port_config() still has no xMII case.

The commit message says the driver will "advertise the interface modes it
actually supports". Could it mention that these ports change from
"phylink created, mode not configured" to "phylink creation fails"?

Also, the removed TODO said the SERDES/xMII table was not available due
to lack of documentation. Where do the new per-chip xmii_mask and
serdes_mask values come from?

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. The
binding example in
Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml uses
an RGMII mode on port 9:

                ethernet-port@9 {
                    reg = <9>;
                    label = "wan";
                    phy-mode = "rgmii-id";
                    phy-handle = <&phy1>;
                };

The driver never advertises any RGMII mode in
yt921x_dsa_phylink_get_caps(), and it never configures one in
yt921x_port_config(). With the current driver, port 9 from the example
can't be used.

Bindings describe hardware rather than driver support, and xMII is
already marked as a TODO in both functions. This patch also moves port 9
into xmii_mask on all YT9215 variants, which is closer to the example.
Is it still worth noting that the example depends on the pending xMII
support?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923021945.2203368-1-mmyangfl%40gmail.com
