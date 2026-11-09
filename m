Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267445;
	b=demovD3xv+KsvP5fehXek79ELVkShNkyX2cT9vUt1j6HbOLvuH6oz5mvj0VL5a8GC7fC
	 +1EKKt431HiNwkwoVxsJ0f1fAp8Mx2cM+JIXPsg/BovFktq+HO7xnvNOY19cU8AM8SS7N
	 bgiBQmf2U6iV71Cz3CNF0qlvXHFfJl7mRKHRsnXMJOTu/ry/BFt13PZf1YzLGh9qIbojG
	 SzMhLl9NvDvRTM8EIxhXI1fSrj7e05serqHu/LUSMLz0v1r71Mz7xs7IYYFxe5WaredwM
	 7/Va68N4K+fdzWOIiEyHSvAKwkNZFv1IwXgv3YKXoWGg0LsWAZwRWfzIshrrj1vPwDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267445;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LZzuKrAYvI3vtbFChn8wQkQb8sojMWPxLEy8ZPPg9Ec=;
	b=hQeo42kHHicoKgHFFiaXh+vX9LvK3JO9cWNd0f79zSa0Die3nd3Jrzn7A21EQ13MuNuf
	 i/zWu7BQwpB3VZb9eJb1n43DhRCxa6xvyHSI9QiKP2VLzMeAIdUXmJYQWCAsnYH5dYqhn
	 pYJdSbxYBby5ECiCZUFGcfIF/v1YCdizIJq7MSgmAhmRbkKkyVbUYl+Z/5xkMG+JnjE5W
	 Tlb7wAl92UkK8h0HdICrR5qa+SfwINKTPa74wh7uYe7F2U/mlx1tg4ovv+lbmrW6B3lNX
	 H0szRvU/1MCteEX07GfFMrqnWFu1q0NpSUHce8o4p2BiXu2VcVYvP0SepOigIWy2PWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EcT+UJvH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6E606A31C;
	Mon,  9 Nov 2026 23:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EcT+UJvH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6B31F0089F;
	Mon,  9 Nov 2026 23:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267444;
	bh=LZzuKrAYvI3vtbFChn8wQkQb8sojMWPxLEy8ZPPg9Ec=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EcT+UJvHAl4Iewl6XZuCG9KvEY04EVdAy6sWaYY/OJ6cohYIeOYF+2+3izewy+9QL
	 JXNhBRFprHbBBDdMQWzg2yPJIJCjEw8qNzY24GAUy8Q8UtdjTFFGA8eaISxy6oREeJ
	 3dmowb/RNiC9B1FV4G1iBqvB2pDQJVwA31AV9A/j/8stwJw61FPBQsDDP+Owd1j94u
	 TWnEiDGGpgxDZTk2KyJ2BA7LBPLIS7aLe/oTgNabABgsNbkM/w5jQtMXm7Ldut5fTf
	 /yZGsCJYGnimDp62Ct0m1tCqi0F65pCTqYlQrtwgI1ZJl+jMZlVb0zCnr/HMcajx5K
	 jmNvwZ9dpFFEQ==
Subject: Re: [PATCH net-next v2 2/2] net: dsa: mxl-gsw1xx: reset the switch
 through reset-gpios
From: netdev-bot+sashiko@kernel.org
To: joseph@telaak.dev
Cc: hauke@hauke-m.de, andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, daniel@makrotopia.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 23:37:23 +0000
Message-ID: <179426744353.994134.16211561618771955131@kernel.org>
In-Reply-To: <20261108-mxl-gsw1xx-reset-v2-2-46c1da093893@telaak.dev>
References: <20261108-mxl-gsw1xx-reset-v2-2-46c1da093893@telaak.dev>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The hardware reset only happens when CONFIG_RESET_CONTROLLER
  and CONFIG_RESET_GPIO are both enabled, and NET_DSA_MXL_GSW1XX does…
- [Medium] The new full-chip hardware reset in gsw1xx_probe()
  (drivers/net/dsa/lantiq/mxl-gsw1xx.c:750-763) contradicts the binding…
- [Low] gsw1xx_probe() (drivers/net/dsa/lantiq/mxl-gsw1xx.c:750-763)
  asserts the reset, sleeps 250 ms, deasserts and sleeps another 1 s…

--

net: dsa: mxl-gsw1xx: reset the switch through reset-gpios

The commit adds a hardware reset pulse to gsw1xx_probe() through the reset
controller API. The reset is held for 250 ms, followed by a 1 s wait before
the first register access. The goal is to clear the bootloader state that
leaves the internal PHYs of the GSW150 at shifted MDIO addresses on the
GL.iNet GL-SFT1200.

> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> index a26f78e1a44ce..94a7eff5e0077 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c

[ ... ]

> @@ -737,6 +739,29 @@ static int gsw1xx_probe(struct mdio_device *mdiodev)
>  	if (!priv->gswip.hw_info)
>  		return -EINVAL;
>  
> +	/* The MDIO core handles reset-gpios only for PHYs. Reset the switch
> +	 * here, so it does not run with whatever the bootloader configured.
> +	 */
> +	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(reset))
> +		return dev_err_probe(dev, PTR_ERR(reset),
> +				     "failed to get reset control\n");

[Severity: Medium]
If CONFIG_RESET_GPIO is disabled, does this lookup silently return NULL even
when the switch node has reset-gpios?

drivers/reset/core.c:__fwnode_reset_control_get() {
    ...
	if (!IS_ENABLED(CONFIG_RESET_GPIO))
		return optional ? NULL : ERR_PTR(ret);
    ...
}

With CONFIG_RESET_CONTROLLER=n, the optional stub also returns NULL. In
both cases the if (reset) block is skipped and nothing is logged. The switch
then keeps the bootloader state, and on the GL-SFT1200 port 0 would still
fail with "failed to connect to PHY: -ENODEV".

NET_DSA_MXL_GSW1XX in drivers/net/dsa/lantiq/Kconfig does not select, imply
or depend on RESET_CONTROLLER or RESET_GPIO. The reset-gpios entry added to
lantiq,gswip.yaml in this series ("dt-bindings: net: dsa: lantiq,gswip: add
reset-gpios") describes the property with no such condition. The commit
message mentions the requirement, but neither Kconfig nor the driver at
runtime does.

No Kconfig in the tree selects RESET_GPIO, and it sits inside the
RESET_CONTROLLER menuconfig, so selecting it is not straightforward.

Other DSA drivers (mv88e6xxx, rtl83xx, qca8k, ksz_common, mt7530-mdio,
lan9303, vitesse-vsc73xx) read reset-gpios with
devm_gpiod_get_optional(dev, "reset", ...), which only needs GPIOLIB.

Would a gpiod based lookup, or a gpiod fallback, make the documented
property work whatever the reset framework config is?

> +
> +	if (reset) {
> +		ret = reset_control_assert(reset);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to assert reset\n");

[Severity: Medium]
Does this full chip reset conflict with the slew rate binding? For
maxlinear,slew-rate-txc and maxlinear,slew-rate-txd, lantiq,gswip.yaml
says:

  If not present, the configuration made by the switch bootloader is
  preserved.

gsw1xx_rmii_slew_rate() relies on that and skips the write when the
property is absent:

	ret = of_property_read_u32(np, prop, &rate);
	/* Optional property */
	if (ret == -EINVAL)
		return 0;

When a board adds reset-gpios, the bootloader's GSW1XX_SHELL_RGMII_SLEW_CFG
setup would be replaced by power-on defaults before the driver touches the
switch.

RGMII_SLEW_CFG_RX_2_5_V and RGMII_SLEW_CFG_TX_2_5_V are defined in
mxl-gsw1xx.h but never written anywhere in drivers/net/dsa/lantiq/. Suppose
a bootloader set them for 2.5 V RGMII signalling. Could the RGMII CPU link
be degraded or stop working after this reset?

The actual hardware impact depends on the GSW1xx reset defaults and straps.
The GSWIP_SWRES_R0 reset in gswip_setup() only covers the switch core
register block, so this pad state was not reset before this patch.

> +
> +		fsleep(GSW1XX_RESET_ASSERT_US);
> +
> +		ret = reset_control_deassert(reset);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to deassert reset\n");
> +
> +		fsleep(GSW1XX_RESET_DEASSERT_US);
> +	}

[Severity: Low]
This runs before gswip_probe_common()->dsa_register_switch(), which can
return -EPROBE_DEFER when the conduit netdev is not available yet:

drivers/net/dsa/lantiq/lantiq_gswip_common.c:gswip_probe_common() {
    ...
	err = dsa_register_switch(priv->ds);
	if (err)
		return dev_err_probe(priv->dev, err, "dsa switch registration failed\n");
    ...
}

Does each deferred probe then repeat the full 250 ms + 1 s blocking pulse?

If the conduit Ethernet driver probes late or is built as a module, each
retry would add about 1.25 s to boot and reset the switch again.

> +
>  	priv->gswip.gswip = gsw1xx_regmap_init(priv, "switch",
>  					       GSW1XX_SWITCH_BASE, 0xfff);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108-mxl-gsw1xx-reset-v2-0-46c1da093893%40telaak.dev
