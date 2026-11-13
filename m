Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606971;
	b=5riN+fDTFVEy+kFqwzaOgPdja2+uVO7NGiKbV9VlsW4cYUDvo93yrL0kH7ymrPsqdg5c
	 2gjsPxcDFbkk1A38FSZxSb6AiKxpKta+/TXMZUNMNlfNKO1g8Zfo+LbLvGb0NTWSr4UD6
	 HciuJ9v7HWeYij6OCHUdM3B0oftpumcnZB6cyx11e+VWZngoyMWDEWaRsFP4BSJWdj965
	 xzG7+ak//zFXBUp4q+G6HwwY9NSOD4pR3xkH20VSv0LhRcCDRGIwUw45ilcT3dGWUyhty
	 ff9Oj6DyIuEEa7otLi/2ecN9HdhH41nRPj4++p9GsSwZ+sAvCrxrYPVIeF+b0VLeQGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606971;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WdL/mW8zck5x2lfZbgdsSb2WKHrSAth7GrBOdlsuH1Q=;
	b=DTo6w+8QYagytx6Y1N6RxNFU26Wu+K3MWRNTcfPXYBMJgrfs/I9sd5QcLTpm9C4MvQ+X
	 iljRQBAn56HeycIORM3UTM3n7pCiBdpRZMR0jud9gvlpS+JcUuxvAjPlFTV7HmG0s4hxT
	 krLxtoQ1dyar5niqpKZzmWsYvt+AgFS50Nemk6R8CYF9kvfDzyQ8EUIPiJ7/+VrSVHHAX
	 MkzOarNJj2BCpuEe5qFnqBsl3dJu5apYtjkajwlHzJwNhx9+K1YRh4RPjJobpBsuztQgS
	 /y4GvlImmpWzPW9mmSTOY2F7ug4lLyMaUndnz8BPMR3nPteNvI4zisSjYkc1j9GdMpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibdPC2Jj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6DB606A331;
	Fri, 13 Nov 2026 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibdPC2Jj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DF31F000C5;
	Fri, 13 Nov 2026 21:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606971;
	bh=WdL/mW8zck5x2lfZbgdsSb2WKHrSAth7GrBOdlsuH1Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ibdPC2JjjHkScr4rSdJq+McwDgQJg84IKuomtIZPHyDysQfmx06qZKs7tzhcpHG2m
	 AEMuMbitN1j1MsSre6Ozl2pKRZY87y8p0L3+cuw3aHpk5dvTVq/Czzf+Pzl2jXFg40
	 NAy0rBGnuEwt7fZipPzhCDOja28aL7gOk+Ew7EzRB/UIgDkwc1m8zheJkHwAi1L9xl
	 Fkn1RNJ7bBed9dLGqdC8TOZkF5VAW6Jmmu8/BXzrCMF2q1sZf9B+j3FKwok747o/YD
	 n8i7GsEbwtber7++Bui5cU25362STOlqzNydAeQT3SyeQbzeZZeE54oXF9gmfnCRFA
	 dJHbf23YJOuNw==
Subject: Re: [PATCH net-next v3 2/2] net: dsa: mxl-gsw1xx: reset the switch
 through reset-gpios
From: netdev-bot+sashiko@kernel.org
To: joseph@telaak.dev
Cc: hauke@hauke-m.de, andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, daniel@makrotopia.org,
 p.zabel@pengutronix.de, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 21:56:10 +0000
Message-ID: <179460697028.2199510.16469667611451246609@kernel.org>
In-Reply-To: <20261112-mxl-gsw1xx-reset-v3-2-863e82074893@telaak.dev>
References: <20261112-mxl-gsw1xx-reset-v3-2-863e82074893@telaak.dev>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In gsw1xx_probe() (drivers/net/dsa/lantiq/mxl-gsw1xx.c:745),
  the switch reset is fetched with…
- [Low] gsw1xx_probe() (drivers/net/dsa/lantiq/mxl-gsw1xx.c:750-764)
  pulses the reset and sleeps for a fixed 1.25 s on every probe attempt:…
- [Low] The new comment in gsw1xx_probe() says the driver handles the
  reset itself because "The MDIO core handles reset-gpios only for…
- [Low] GSW1XX_RESET_ASSERT_US (250000) and GSW1XX_RESET_DEASSERT_US
  (1000000) in drivers/net/dsa/lantiq/mxl-gsw1xx.h:22-24 are documented…

--

net: dsa: mxl-gsw1xx: reset the switch through reset-gpios

This patch makes gsw1xx_probe() pulse the switch reset before the first
register access. The reset is obtained through the reset controller API.
Without it, the bootloader's configuration stays in place, and on the
GL-SFT1200 the internal PHYs end up at the wrong MDIO addresses. The
timing follows the GSW150 vendor driver: 250 ms asserted, then 1 s
before the switch is accessed.

> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> index a26f78e1a44ce..f69856a65befa 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c

[ ... ]

> @@ -737,6 +739,30 @@ static int gsw1xx_probe(struct mdio_device *mdiodev)
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
> +
> +	if (reset) {

[Severity: Medium]
What happens here when the kernel is built with CONFIG_RESET_GPIO=n (or
CONFIG_RESET_CONTROLLER=n) and the switch node only has reset-gpios?

In drivers/reset/core.c, the reset-gpios fallback is only tried when
RESET_GPIO is enabled. Otherwise an optional get returns NULL:

drivers/reset/core.c:__fwnode_reset_control_get() {
    ...
	if (!IS_ENABLED(CONFIG_RESET_GPIO))
		return optional ? NULL : ERR_PTR(ret);
    ...
}

The !CONFIG_RESET_CONTROLLER stubs in include/linux/reset.h also return
NULL for optional gets.

gsw1xx_probe() treats NULL as "no reset wired". It skips the if (reset)
block and logs nothing. NET_DSA_MXL_GSW1XX in
drivers/net/dsa/lantiq/Kconfig also has no select or imply for
RESET_CONTROLLER or RESET_GPIO.

On such a kernel, wouldn't a GL-SFT1200 whose DT describes reset-gpios
silently keep the bootloader configuration? Port 0 would then fail again
with "failed to connect to PHY: -ENODEV". The binding text "or the
power-on default after a reset through reset-gpios" would not hold on
those kernels either.

The commit message mentions the CONFIG_RESET_GPIO requirement, but there
is no Kconfig link and no runtime message.

The MDIO core in mdio_device_register_reset() and other DSA drivers call
gpiod_get_optional(dev, "reset", ...) directly, which only needs GPIOLIB.
Would it work to use gpiod here, or add an imply/select? At minimum,
could the driver warn when reset-gpios is present but no reset control
was obtained?

> +		ret = reset_control_assert(reset);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to assert reset\n");
> +
> +		fsleep(GSW1XX_RESET_ASSERT_US);
> +
> +		ret = reset_control_deassert(reset);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to deassert reset\n");

[Severity: Low]
The comment above gives "The MDIO core handles reset-gpios only for
PHYs" as the reason for doing this here. Does this cover everything the
core does with the reset line?

In drivers/net/phy/mdio_device.c, mdio_probe() asserts the reset again
if the driver's probe fails, and mdio_remove() always asserts it:

drivers/net/phy/mdio_device.c:mdio_probe() {
    ...
		err = mdiodrv->probe(mdiodev);
		if (err) {
			/* Assert the reset signal */
			mdio_device_reset(mdiodev, 1);
		}
    ...
}

The core only sets up reset_ctrl and reset_gpio for
MDIO_DEVICE_FLAG_PHY, so those calls do nothing for this switch.

In gsw1xx_probe(), none of the later error returns assert the reset
again. That covers regmap init, -ENODEV on a chip ID mismatch,
gsw1xx_serdes_pcs_init(), the GSWIP_VERSION read, and
gswip_probe_common(), including -EPROBE_DEFER. gsw1xx_remove() and
gsw1xx_shutdown() never touch the reset either.

Should the switch be put back into reset on probe failure and on remove?
lan9303-core.c, for example, asserts reset on removal "to prevent it
from doing anything". The switch was already left running after unbind
before this patch, so the change is mostly the state after a failed
probe.

> +
> +		fsleep(GSW1XX_RESET_DEASSERT_US);
> +	}

[Severity: Low]
Is the reset pulse, with 1.25 s of sleeping, repeated on every deferred
probe attempt?

Nothing records that the reset already happened. Later in the same probe,
gswip_probe_common()->dsa_register_switch() can return -EPROBE_DEFER, for
example when the conduit netdev is not registered yet:

net/dsa/dsa.c:dsa_port_parse_of() {
    ...
	if (!conduit) {
		rtnl_unlock();
		return -EPROBE_DEFER;
	}
    ...
}

It can also defer when the tagger is missing. gswip_probe_common() passes
the error back through dev_err_probe().

Each retry would reset the switch again and block the deferred probe
worker for another 250 ms + 1 s, so boot time grows with every deferral.
The commit message does not mention this.

> +
>  	priv->gswip.gswip = gsw1xx_regmap_init(priv, "switch",
>  					       GSW1XX_SWITCH_BASE, 0xfff);
>  	if (IS_ERR(priv->gswip.gswip))
> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.h b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
> index 81bc00eabbfb3..bca8e3223cd60 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.h
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
> @@ -19,6 +19,10 @@
>  
>  #define GSW1XX_SYS_CLK_FREQ			340000000
>  
> +/* Hardware reset timing of the vendor's driver for the GSW150 */
> +#define GSW1XX_RESET_ASSERT_US			250000
> +#define GSW1XX_RESET_DEASSERT_US		1000000

[Severity: Low]
These values are described as the vendor's timing for the GSW150.
However, gsw1xx_probe() applies them to every compatible in
gsw1xx_of_match, including the GSW120, GSW125, GSW140, GSW141 and
GSW145. Are these timings right for the other variants?

The reset-assert-us and reset-deassert-us properties are also never
read, so a board cannot adjust the timing. These properties are defined
for MDIO bus children in Documentation/devicetree/bindings/net/mdio.yaml,
and the MDIO core reads them:

drivers/net/phy/mdio_device.c:mdio_device_register_reset() {
    ...
	device_property_read_u32(&mdiodev->dev, "reset-assert-us",
				 &mdiodev->reset_assert_delay);
	device_property_read_u32(&mdiodev->dev, "reset-deassert-us",
				 &mdiodev->reset_deassert_delay);
    ...
}

As a result, every variant with a reset line waits at least 1.25 s per
probe attempt, and firmware cannot override it.

The dependency on CONFIG_RESET_GPIO raised above has the same cause:
mdio_device_register_reset() uses gpiod directly, while this patch goes
through the reset_control API.

>  /* SMDIO switch register base address */
>  #define GSW1XX_SMDIO_BADR			0x1f
>  #define  GSW1XX_SMDIO_BADR_UNKNOWN		-1

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112-mxl-gsw1xx-reset-v3-0-863e82074893%40telaak.dev
