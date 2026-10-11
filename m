Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C364D3DD87A;
	Sun, 11 Oct 2026 06:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791698773; cv=none; b=AF1J9DS9RJNAahrt5Sn/n2Tmr+rx3diRA8O5ECghn+01ib0CEgdNsrl4tyZwx94rbKzL0NYP75AB1LFHQvns2CUyJ8cUsl+nz3xA6mhPXWHjkam8+3R/AaZIKpJwhRq++PID+pBZPmtb90JD3f8mS6b1tn1/tTYJXFebu/6JQBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791698773; c=relaxed/simple;
	bh=rOt1P/x3OD7pyzaN3zaoUoDU/UF+A9YSArGcJUf5oeU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T2UEW4FfmeoYc1EDZ4UNMzu0Ac68FV5uzIhg1CWwSSBMOP8nEjtOj7H35EciRcVd2It0QopC1bC4TLjoJAhubVTocs7+OB2Yjwi2Ej5eDRNhi67vcHV/t3Iws8gHzA9WDtSOqDIlorNcFRWNca461RFqlQiiKhVtKMF3Oax/XeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E406FT/K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E406FT/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C4C1F0089B;
	Sun, 11 Oct 2026 06:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791698766;
	bh=zB3+bKFhNuFp12yMORYKatx4F3PfEKORcFI6oTyIUyc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E406FT/KzcHlFvcU1TvEdpVW+09QHEuu2hN0tLJet+DV0BDabS0z6B8kCx7SYF3hL
	 HBic14t5zUxzaKajHhaTG5n1ox9wKXcdIHd7EE3Z+HMjrvpyVnTfyqedv7fm02iucG
	 wr4Xypvhl6mfBtKKD89p8yCGz97FQ4+qD8DInSedNBslV7RS8wR62NWigNmT829h4J
	 D+eMu67v7ojm/snnCnkYm2ykTFP90+3AoNDCLKoXLuaKxfhzZXuhb5ReXNMks8vHsY
	 WrmzSpQQmvCPdLcyjwkYNv+SrxdvSa/+YrGrXMi92BcreXTg09LCaWmfrgj+3QVk4p
	 JegWupMacqtIw==
Subject: Re: [PATCH net v2 1/2] net: phy: xilinx-gmii2rgmii: Avoid overwriting
 PHY drvdata
From: netdev-bot+sashiko@kernel.org
To: vineeth.karumanchi@amd.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 michal.simek@amd.com, harini.katakam@xilinx.com, f.fainelli@gmail.com,
 appanad@xilinx.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@amd.com
Date: Sun, 11 Oct 2026 06:06:04 +0000
Message-ID: <179169876482.434549.4039467032611892577@kernel.org>
In-Reply-To: <20261007054844.529363-2-vineeth.karumanchi@amd.com>
References: <20261007054844.529363-2-vineeth.karumanchi@amd.com>
X-sashiko-severity: Critical
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

Critical: 1 · High: 1 (1) · Medium: 0 (3) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] net: phy: data race and type confusion computing priv from
  phydev->drv
- [High] net: phy: TOCTOU race in xgmiitorgmii_read_status yielding
  invalid pointer

Pre-existing issues:
- [High] At this commit the converter has no .remove callback.
- [Medium] xgmiitorgmii_configure() stores the int result of
  mdiobus_read(bus, addr, XILINX_GMII2RGMII_REG) in a u16 without…
- [Medium] At this commit, the device reference that of_phy_find_device()
  takes in xgmiitorgmii_probe() is dropped only on the…
- [Medium] xgmiitorgmii_probe() makes the wrapper visible with a plain
  store `priv->phy_dev->drv = &priv->conv_phy_drv`.

--

net: phy: xilinx-gmii2rgmii: Avoid overwriting PHY drvdata

This commit stops the GMII-to-RGMII converter from storing its private
data in the attached PHY's MDIO drvdata field, because that field belongs
to the underlying PHY driver. The read_status and set_loopback wrappers
now get struct gmii2rgmii by calling container_of_const() on phydev->drv.
xgmiitorgmii_configure() now takes a const pointer.

> diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> index 2024d8ef36d98..61f71e977a574 100644
> --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> @@ -28,7 +28,7 @@ struct gmii2rgmii {
>  	struct mdio_device *mdio;
>  };
>  
> -static void xgmiitorgmii_configure(struct gmii2rgmii *priv, int speed)
> +static void xgmiitorgmii_configure(const struct gmii2rgmii *priv, int speed)
>  {
>  	struct mii_bus *bus = priv->mdio->bus;
>  	int addr = priv->mdio->addr;

[Severity: Medium]
This isn't a bug introduced by this patch, but this function is being
touched here. What happens if the MDIO read fails?

drivers/net/phy/xilinx_gmii2rgmii.c:xgmiitorgmii_configure() {
    ...
	val = mdiobus_read(bus, addr, XILINX_GMII2RGMII_REG);
	val &= ~XILINX_GMII2RGMII_SPEED_MASK;
    ...
	mdiobus_write(bus, addr, XILINX_GMII2RGMII_REG, val);
}

mdiobus_read() returns a negative errno on failure. Since val is a u16,
-EIO becomes 0xfffb.

Only the speed bits are cleared before the write. Wouldn't that set other
bits of the converter register to values the hardware never reported?

The mdiobus_write() result is also ignored. Because the function returns
void, xgmiitorgmii_read_status() and xgmiitorgmii_set_loopback() always
return 0.

Could the PHY layer then believe the converter is set to phydev->speed
when it is not?

> @@ -49,7 +49,9 @@ static void xgmiitorgmii_configure(struct gmii2rgmii *priv, int speed)
>  
>  static int xgmiitorgmii_read_status(struct phy_device *phydev)
>  {
> -	struct gmii2rgmii *priv = mdiodev_get_drvdata(&phydev->mdio);
> +	const struct gmii2rgmii *priv = container_of_const(phydev->drv,
> +							   struct gmii2rgmii,
> +							   conv_phy_drv);
>  	int err;
>  
>  	if (priv->phy_drv->read_status)

[Severity: High]
Can a caller that does not hold phydev->lock see phydev->drv change
between selecting this callback and evaluating container_of_const()?

phy_read_status() takes no lock and loads phydev->drv several times:

include/linux/phy.h:phy_read_status() {
    ...
	if (phydev->drv->read_status)
		return phydev->drv->read_status(phydev);
    ...
}

xgmiitorgmii_read_status() then loads phydev->drv once more to compute
priv. phy_state_machine() calls in with phydev->lock held. Some MAC
drivers instead call phy_read_status() directly from their own link
polling or self-test paths, without holding that lock.

Suppose such a caller has already fetched xgmiitorgmii_read_status() as
the function pointer and is preempted. Meanwhile the converter is
unbound through sysfs. The xgmiitorgmii_remove() added by the next
patch in this series restores phydev->drv to priv->phy_drv, and devres
frees priv.

When the caller resumes, container_of_const() is applied to the
original phy_driver rather than to conv_phy_drv. priv is then a pointer
into unrelated memory. priv->phy_drv->read_status is loaded through it
and called.

xgmiitorgmii_remove() takes phydev->lock, but that only serializes
against callers that take the same lock. It does not close this window
for lockless callers.

Is the intent that every phy_read_status() caller must hold
phydev->lock when this converter is in use? If not, how should the
callbacks recover priv safely once phydev->drv can change under a
running callback?

[Severity: High]
This is a pre-existing issue, but is phydev->drv still valid here after
the converter has been unbound?

xgmiitorgmii_probe() allocates priv with devm_kzalloc() on the converter's
own device. It then installs &priv->conv_phy_drv as the attached PHY's
phydev->drv.

The driver has no .remove callback, so nothing restores the original
driver:

static struct mdio_driver xgmiitorgmii_driver = {
	.probe	= xgmiitorgmii_probe,
	...
};

After a sysfs unbind or rmmod of the converter, devres frees priv, but
phydev->drv still points into it.

The next call through phy_state_machine()->phy_read_status() would reach
this function. Here container_of_const() resolves into freed memory, and
priv->phy_drv and priv->mdio are then dereferenced.

A rebind would also memcpy() from the freed copy in xgmiitorgmii_probe().

The next patch in this series, "net: phy: xilinx-gmii2rgmii: Restore PHY
driver on remove", adds xgmiitorgmii_remove(). Under phydev->lock, that
function sets priv->phy_dev->drv back to priv->phy_drv, so this appears
to be fixed there.

[ ... ]

> @@ -123,7 +127,6 @@ static int xgmiitorgmii_probe(struct mdio_device *mdiodev)
>  	       sizeof(struct phy_driver));
>  	priv->conv_phy_drv.read_status = xgmiitorgmii_read_status;
>  	priv->conv_phy_drv.set_loopback = xgmiitorgmii_set_loopback;
> -	mdiodev_set_drvdata(&priv->phy_dev->mdio, priv);
>  	priv->phy_dev->drv = &priv->conv_phy_drv;

[Severity: Critical]
Does deriving priv from phydev->drv make the wrapper callbacks depend
on a pointer that nothing synchronizes?

xgmiitorgmii_probe() installs &priv->conv_phy_drv here with a plain
store, without taking phydev->lock. The attached PHY may already be
connected to a MAC with its state machine running. In that case
phydev->drv is rewritten while other code is using it.

With this patch, xgmiitorgmii_read_status() and
xgmiitorgmii_set_loopback() no longer get priv from a field owned by
the converter. They apply container_of_const() to phydev->drv, which
they reload on entry, separately from the load the caller used to pick
the callback.

That is only correct while phydev->drv still equals
&priv->conv_phy_drv. If it has been switched to another phy_driver in
the meantime, the result is that driver's address minus
offsetof(struct gmii2rgmii, conv_phy_drv). The remove path added in
the next patch, which restores the original driver, is one way this
can happen. The resulting pointer is not a struct gmii2rgmii at all.

priv->phy_drv is then read from whatever memory precedes that
phy_driver, and priv->phy_drv->read_status(phydev) becomes an indirect
call through an arbitrary pointer. Wouldn't that crash the kernel, or
let the call be steered somewhere else entirely?

Even within this patch alone, phy_remove() clears phydev->drv when the
attached PHY's own driver is unbound. Could a caller that is already
inside xgmiitorgmii_read_status() then compute priv from NULL?

Could the swap of phydev->drv be done under phydev->lock, with every
path that calls into these callbacks holding it as well? Or could priv
be found in a way that does not depend on the current value of
phydev->drv?

[Severity: Medium]
This isn't a bug introduced by this patch, but is this store ordered
after the setup of the wrapper?

The store to priv->phy_dev->drv is a plain store, done without
phydev->lock and without smp_store_release(). It comes after the stores to
priv->mdio and priv->phy_drv and the memcpy() into conv_phy_drv.

The PHY may already be attached with its state machine running, for
example when the converter module loads after the MAC opened the
interface. On a weakly ordered CPU such as the arm64 Zynq parts, could
another CPU see the new phydev->drv before those earlier stores?

If so, phy_read_status() or phy_loopback() would call
xgmiitorgmii_read_status() or xgmiitorgmii_set_loopback(). Those could
read priv->phy_drv or priv->mdio while they are still NULL from
devm_kzalloc().

>  
>  	return 0;

[Severity: Medium]
This is a pre-existing issue, but does a successful probe leak the
reference on the phy_device?

	priv->phy_dev = of_phy_find_device(phy_node);

of_phy_find_device() takes a device reference. That reference is only
dropped on the !priv->phy_dev->drv deferral path.

There is no teardown callback, so nothing calls
put_device(&priv->phy_dev->mdio.dev) after a successful probe. Each
bind/unbind cycle would leak one reference and keep the phy_device from
being freed.

The next patch in this series, "net: phy: xilinx-gmii2rgmii: Restore PHY
driver on remove", appears to fix this by calling put_device() in the new
xgmiitorgmii_remove().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007054844.529363-1-vineeth.karumanchi%40amd.com
