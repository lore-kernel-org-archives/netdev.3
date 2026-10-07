Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2900C41F346;
	Wed,  7 Oct 2026 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365532; cv=none; b=ZtZBfig7mrKnZovGN2fnpTY9bulKkFnMJFSJUVhGQzuTmc9Jla1qobRVAIQNxfxDJaWExi+7xK/D/xKi6YpeS09Isn2G+1DGAJFUcyRvL7pQd0lcvMUVbNXuPXb9xqjZMC0Q8jbVe/lrXmPCOTP4suSBjKg0OcXJVcmOj0isYjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365532; c=relaxed/simple;
	bh=wDUi4KHhE5clSLNyLpTSGla06KpXCM3bFZCyUcCU/UQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mMJXl+YzyI9PSQgBuLRRMgmlwNvOoIMuMQMRV66r/6L/XXD5fZH3UelifTsM3JwsOtaZaIdVJsWTrCmpFj0xl/TgEKn0+l9dJiJAj+UpFofte+skVlzs7HAukEsYJDw2m99FTLEPhTKCie+jARi3XMYbfNxViXJbKbypr5e3uJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rLbroE9X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DR/f29Z/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rLbroE9X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DR/f29Z/"
Message-ID: <3190d10102167d5b72add3e5831cba40756d459a.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791365513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZYbyyvMS986uZEblqXqfDTl4F8VXAGukgUvCIUKQ5M=;
	b=rLbroE9XcrpMrNi3FWN41xa+80cJUFShTGdCp/5ctTG+5vwfjrTDry3Dx3BQH7gKsEfr/2
	czampDST+wizQsG5nlTUWFosyxnSamZcV090NS5GwHimrOoWNDPHBYw50uUjuS1ogmIMGZ
	/z8CYucvv3HhjwvzxrEKePZRxcf4ZhW1HH00j2i3BdkZpbQ7k4Cyvz/h7IHjucVWE4xVSg
	EAQDXAtAqpy70FRtodhZMXKK+/Gym/i+6scTaEY5U856L5o2RJTtFwgJG61QcJFSXHsHOe
	QKsOCokYwvvpFE33OkFc1Cd/oR2riTPM0HiwPS2Pm4ZE69QocAJui4a2D7LulA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791365513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZYbyyvMS986uZEblqXqfDTl4F8VXAGukgUvCIUKQ5M=;
	b=DR/f29Z/M7ZdoRvsrZKqD7x/o2+HeooFiiy8iBRlobau3+amAbqhiTxGUbYj6VV89CdU4C
	xlV7Fq1AWKPCzzCg==
Subject: Re: [PATCH net-next v3 5/8] net: mdio: Add SoC-e SWIP MDIO
 controller driver
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew@lunn.ch,  olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org,  pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, andrew+netdev@lunn.ch,  hkallweit1@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, martin.kaistra@linutronix.de,
 b.spranger@linutronix.de
Date: Wed, 07 Oct 2026 11:31:52 +0200
In-Reply-To: <179051210920.2160803.11497808586391363644@kernel.org>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-5-ddebafcb9ba7@linutronix.de>
	 <179051210920.2160803.11497808586391363644@kernel.org>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-09-27 at 12:28 +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] soce_mdio_iomap() (drivers/net/mdio/mdio-soce.c:48) returns
>   whatever devm_ioremap() returns.
> - [Medium] The external MDIO bus selector (bits 26:16) lives in the same
>   32-bit control register as OPSTATUS (bit 0), but the idle check does=E2=
=80=A6
>=20
> --
>=20
> net: mdio: Add SoC-e SWIP MDIO controller driver
>=20
> This adds a driver for the MDIO controller in SoC-e Ethernet switch IP
> cores. It supports Clause 22 and Clause 45 accesses. The transaction
> control register also holds an external MDIO bus selector in bits 26:16,
> which a generic MMIO MDIO mux manages and which the driver preserves when
> it starts a transaction.
>=20
> > diff --git a/drivers/net/mdio/mdio-soce.c b/drivers/net/mdio/mdio-soce.=
c
> > new file mode 100644
> > index 0000000000000..59c0b3da483eb
> > --- /dev/null
> > +++ b/drivers/net/mdio/mdio-soce.c
> > @@ -0,0 +1,239 @@
>=20
> [ ... ]
>=20
> > +static void __iomem *soce_mdio_iomap(struct device *dev, int index)
> > +{
> > +	struct resource res;
> > +	int ret;
> > +
> > +	ret =3D of_address_to_resource(dev->of_node, index, &res);
> > +	if (ret)
> > +		return IOMEM_ERR_PTR(ret);
> > +
> > +	return devm_ioremap(dev, res.start, resource_size(&res));
>=20
> [Severity: Medium]
> Can a failed mapping get past the checks in soce_mdio_probe()?
>=20
> devm_ioremap() returns NULL on failure, not an ERR_PTR. This happens both
> when the devres allocation fails and when ioremap() fails:
>=20
> lib/devres.c:__devm_ioremap() {
> 	void __iomem **ptr, *addr =3D NULL;
> 	...
> 	if (!ptr)
> 		return NULL;
> 	...
> 	} else
> 		devres_free(ptr);
>=20
> 	return addr;
> }
>=20
> soce_mdio_probe() checks both results only with IS_ERR():
>=20
> 	priv->data =3D soce_mdio_iomap(dev, SOCE_MDIO_DATA_IOMAP_IDX);
> 	if (IS_ERR(priv->data))
> 		return PTR_ERR(priv->data);
>=20
> 	priv->ctrl =3D soce_mdio_iomap(dev, SOCE_MDIO_CTRL_IOMAP_IDX);
> 	if (IS_ERR(priv->ctrl))
> 		return PTR_ERR(priv->ctrl);
>=20
> IS_ERR(NULL) is false, so probe would continue into
> devm_of_mdiobus_register() with a NULL base.
>=20
> The first bus access would then dereference NULL. That access comes eithe=
r
> from a PHY child during registration or through the mux:
>=20
> mdio_mux_read()
>   soce_mdio_read()
>     soce_mdio_wait_for_idle()
>       readl_poll_timeout(NULL, ...)
>=20
> Could soce_mdio_iomap() convert a NULL result into IOMEM_ERR_PTR(-ENOMEM)=
,
> or could probe use IS_ERR_OR_NULL()? A helper that also requests the regi=
on
> doesn't fit here, because the parent switch driver already requests the
> whole range.

This was already mentioned by kernel bot. I will fix it for the next
version. Rework for MFD will also change this code.

>=20
> > +}
> > +
> > +static int soce_mdio_wait_for_idle(struct soce_mdio *priv)
> > +{
> > +	void __iomem *ctrl =3D priv->ctrl;
> > +	u32 val;
> > +
> > +	return readl_poll_timeout(ctrl, val,
> > +		!(val & SOCE_MDIO_CTRL_OPSTATUS), 10,
> > +		SOCE_MDIO_TIMEOUT_US);
> > +}
> > +
> > +static void soce_mdio_start(struct soce_mdio *priv, u32 command)
> > +{
> > +	void __iomem *ctrl =3D priv->ctrl;
> > +
> > +	/* Keep the currently selected MDIO bus while updating op bits. */
> > +	command |=3D readl(ctrl) & SOCE_MDIO_CTRL_BUS_MASK;
> > +	writel(command, ctrl);
> > +}
> > +
> > +static int soce_mdio_read(struct mii_bus *bus, int phy_addr, int regnu=
m)
> > +{
> > +	struct soce_mdio *priv =3D bus->priv;
> > +	void __iomem *data =3D priv->data;
> > +	u32 command;
> > +	int ret;
> > +
> > +	ret =3D soce_mdio_wait_for_idle(priv);
> > +	if (ret)
> > +		return ret;
>=20
> [Severity: Medium]
> Does this idle check also protect the bus selector bits in the same
> register?
>=20
> The commit message says:
>=20
>     Return a timeout instead of waiting indefinitely, and allow a later
>     access to retry if the hardware becomes idle again.
>=20
> So when a completion wait returns -ETIMEDOUT, the engine may still be bus=
y.
> Nothing aborts or resets it before mdio_lock is released, and there is no
> mii_bus->reset callback.
>=20
> If the next access goes through the mux to a different child bus,
> mdio_mux_read() calls switch_fn before it calls the parent's read callbac=
k:
>=20
> drivers/net/mdio/mdio-mux.c:mdio_mux_read() {
> 	...
> 	r =3D pb->switch_fn(pb->current_child, cb->bus_number, pb->switch_data);
> 	...
> 	r =3D pb->mii_bus->read(pb->mii_bus, phy_id, regnum);
> 	...
> }
>=20
> mdio_mux_mmioreg_switch_fn() then rewrites the selector halfword without
> checking OPSTATUS:
>=20
> 			x =3D ioread16(p);
> 			y =3D (x & ~s->mask) | desired_child;
> 			if (x !=3D y) {
> 				iowrite16((x & ~s->mask) | desired_child, p);
>=20
> This means soce_mdio_wait_for_idle() runs only after bits 26:16 have
> already changed.
>=20
> If the hardware doesn't latch the selector when a transaction starts, cou=
ld
> the rest of the timed-out frame be sent to a different external MDIO bus?
> The original PHY would get a truncated frame and the newly selected bus
> would get a fragment from the middle of it. Neither the mux's current_chi=
ld
> nor the return code would show that this happened.
>=20
> soce_mdio_write() and the c45 variants have the same ordering. Does this =
IP
> latch the selector per transaction, or does the idle check also need to
> cover the selector writes?
>=20

Yes, the idle check does not protect selector writes made by the generic
mux driver. I already mentioned this in the previous version [1].

I intentionally accept this limitation after a transaction timeout. This
is not documented in the manual and an dedicated mux driver would be
required just to preserve the register state.

Imo, a new mux driver would add too much complexity solely to handle
this error path. I will clarify the commit message so it does not imply
that retrying through a different child bus is guaranteed to be safe.

[1] https://lore.kernel.org/netdev/ffec9201db3d12944dbd350010560f6234262bbe=
.camel@linutronix.de/


