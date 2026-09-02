Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9345E3876B8;
	Wed,  2 Sep 2026 05:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327409; cv=none; b=lvj7S0LyZC5KZNoFYc6BQFbvqk1u9bzjhQ8HWNgnRGFMS4YYKX1Z342n7e+jnRdhRliN9HyOZJ8+roP681ykcX2R3tM1u5xJxSkJe317oaKOlc5F/bORkwpzIvQgZJkk11t0LuiOCqJYvmIlTfArmGwuVsm31sNer4lL9EQ6qqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327409; c=relaxed/simple;
	bh=WjEuDL1tYxAFHdguR9U/h5r4/CE+pQvSWfp8Cg1OYxI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=am/5laEPI1sT9HBSNLWekTjDa5isGLZd9n1RXcSo/VWRgRmLLGdldmK7td4/uQW4Utn24mwI0NYW7N40LGo3cubiVT/JPufUd9sCN+MKhAy2+ZjXFVd+03kNXibQYm1R5VkV0Y8RYV16qywaNiv3g2zib8MVxWYyNf16mnM+0J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBkIJ5e8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBkIJ5e8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F541F000E9;
	Wed,  2 Sep 2026 05:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788327407;
	bh=9Fu85noIYYEh1fEpldT+xhQbnnowVIlbbhWNMxOmf8I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CBkIJ5e8qoGeW/TvDwQ/g0368K6t2qrEWPsMQnsQNYhEcg6MvPhjYr+4LhdzczHGn
	 +gmLHSKBv/XYsqOu2HiJtdw2IsSorARsxhaU/FuihA/lxeobnzFnBBh8tclUb6TQ4n
	 T0kRIHOYvqtpM/3ZQ92eEbPtNcNm/fjIkqVJESklaaFjvWAhSxgpuam1uHAJRmu09y
	 6D1j+/U40DcR+y9OTt+s6cXnqxg/W3twYFl5+5MYl+u8LByOB78/hGdtt8tjBsHnvv
	 PmOqViqCoySrYcL/dAlshHF4mpEy/siL27g+YjIxm+XGbR4SYIGcp6wYAOydkz7rt5
	 JVDdzCq1yCWgQ==
Subject:
 Re: [net-next,v15,12/13] net: mdio: realtek-rtl9300: Add support for RTL839x
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Wed, 02 Sep 2026 05:36:46 +0000
Message-ID: <178832740627.3394541.13025146752023517053@kernel.org>
In-Reply-To: <20260831143439.2404484-13-markus.stockhausen@gmx.de>
References: <20260831143439.2404484-13-markus.stockhausen@gmx.de>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] The binding schema
  Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml…

--

net: mdio: realtek-rtl9300: Add support for RTL839x

This adds the register definitions, C22/C45 accessors and the
otto_emdio_info instance for the RTL839x (cypress) family, plus the
realtek,rtl8391-mdio compatible to otto_emdio_ids[]. The new device
declares 2 SMI buses, 8192 pages and 52 ports.

> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index 57ab89afb9e5e..86b2040fa3335 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
> @@ -148,6 +148,28 @@
>  #define RTL8380_SMI_POLL_CTRL			0xa17c
>  #define RTL8380_SMI_PORT0_5_ADDR_CTRL		0xa1c8
>  
> +#define RTL8390_NUM_BUSES			2

[ ... ]

> @@ -980,6 +1058,29 @@ static const struct otto_emdio_info otto_emdio_8380_info = {
>  	.write_c45 = otto_emdio_8380_write_c45,
>  };
>  
> +static const struct otto_emdio_info otto_emdio_8390_info = {
> +	.cmd_fail = RTL8390_PHY_CTRL_FAIL,
> +	.cmd_read = RTL8390_PHY_CTRL_READ,
> +	.cmd_write = RTL8390_PHY_CTRL_WRITE,
> +	.cmd_regs = {
> +		.broadcast = RTL8390_BCAST_PHYID_CTRL,
> +		.c22_data = RTL8390_PHYREG_ACCESS_CTRL,
> +		.c45_data = RTL8390_PHYREG_MMD_CTRL,
> +		.ext_page = RTL8390_PHYREG_CTRL,
> +		.io_data = RTL8390_PHYREG_DATA_CTRL,
> +		.port_mask_low = RTL8390_PHYREG_PORT_CTRL_LOW,
> +		.port_mask_high = RTL8390_PHYREG_PORT_CTRL_HIGH,
> +	},
> +	.num_buses = RTL8390_NUM_BUSES,

[Severity: Low]
Should the binding schema be narrowed for this compatible too?

Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml has a
single unconditional child-node pattern that applies to every compatible
in the file:

    patternProperties:
      '^mdio-bus@[0-3]$':
        $ref: mdio.yaml#

There is no allOf/if-then block that restricts the index per compatible,
so a realtek,rtl8391-mdio node containing mdio-bus@2 or mdio-bus@3 passes
dt_binding_check, while the driver data added here says the part only has
two buses.

The driver then rejects such a tree in otto_emdio_probe_one():

	if (mdio_bus >= priv->info->num_buses)
		return dev_err_probe(dev, -EINVAL,
				     "illegal (dangling) smi bus number %d\n", mdio_bus);

and again in otto_emdio_map_ports() when a phy-handle resolves to a bus
node with reg = <2>:

	if (bus >= priv->info->num_buses) {
		err = dev_err_probe(dev, -EINVAL, "illegal smi bus number %d\n", bus);

Since the whole probe fails in that case, no MDIO bus is registered at all
for the switch. Would it make sense to add if-then blocks keying on
realtek,rtl8391-mdio (2 buses) and realtek,rtl8380-mdio (1 bus) so the
schema enforces the same limit the driver does?

> +	.num_pages = RTL8390_NUM_PAGES,
> +	.num_ports = RTL8390_NUM_PORTS,
> +	.poll_ctrl = RTL8390_SMI_PORT_POLLING_CTRL,
> +	.read_c22 = otto_emdio_8390_read_c22,
> +	.read_c45 = otto_emdio_8390_read_c45,
> +	.write_c22 = otto_emdio_8390_write_c22,
> +	.write_c45 = otto_emdio_8390_write_c45,
> +};
> +
>  static const struct otto_emdio_info otto_emdio_9300_info = {

[ ... ]

> @@ -1031,6 +1132,7 @@ static const struct otto_emdio_info otto_emdio_9310_info = {
>  
>  static const struct of_device_id otto_emdio_ids[] = {
>  	{ .compatible = "realtek,rtl8380-mdio", .data = &otto_emdio_8380_info },
> +	{ .compatible = "realtek,rtl8391-mdio", .data = &otto_emdio_8390_info },
>  	{ .compatible = "realtek,rtl9301-mdio", .data = &otto_emdio_9300_info },
>  	{ .compatible = "realtek,rtl9311-mdio", .data = &otto_emdio_9310_info },
>  	{}

For reference, the lax [0-3] pattern predates this series, but until now it
only covered realtek,rtl9301-mdio and realtek,rtl9311-mdio, which do have
four buses (RTL9300_NUM_BUSES and RTL9310_NUM_BUSES are both 4), so the
schema matched the driver. The mismatch appears with the 2-bus RTL839x
compatible claimed here.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831143439.2404484-1-markus.stockhausen%40gmx.de
