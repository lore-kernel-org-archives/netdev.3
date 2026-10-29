Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793239357;
	b=06fN3//CcRgpZJ7x6QbFDm9ybGqKoHhkMtnS0AvudU6PPKz3F9giw9xrqUiPek9UlRqR
	 miuSE3t9i82eqgvoAlCnIPGnfnOYSJAvKULTKz39qNtxQvSJds6cRy8ckBxgQuTCq8ReR
	 lPgW0p9uSKrMTVzgkbKaMc10qJzVZBgGcTN51yxTnyKMuuNFjDxSkaSnYGhoIf5J7qKy/
	 5T8H0zpVSF0lVAkwpRSokovthT9ZSBrUSqVTkZAE+lCCIe5uKk7CS0FYrEQWRZcierknL
	 RRiHSlzx/mNQpPnkbngmOt2KLLHV7kfxy29c988rsditM+IeBv0oJSxclPUe4/zzT0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793239357;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ig9ryT9lQ5WH61asJrWLJKKAff4oOz6FkZcoxGtITzU=;
	b=PZ+MXqNfzj4l0Ecsi1manAjUE4zxa0h6gMDBi9UVqsWEnkMr3N2zxZXz56JmtOBMi6x8
	 7XUfwsxovi++kxbHBfCtVOpvBS90+QnASN7z1fuvrkOK8cq9cu4nuCB9KGkTxbpYOu1Ab
	 EBN7jz9Tyz+l7earnVj6vxoJYXxalmkqK0cvEMrGRvVcT2iPVfR/RU3gSjt8zIBv1UUxq
	 k6SUN9Vt+ictfK6uxn6etxHiojRxQ8ALZI7wI85kdVHQLb1kFCdgZ6rrtWPfyrmE957Jw
	 li7YdZNC7/QBYqNmIjy5WVtZYsVIC6+TXrBcFFQU8cUlXBDwOmO4ZS/MwmMvHxpJqzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnxXNoL4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86815606A320;
	Thu, 29 Oct 2026 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnxXNoL4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ACB1F031E2;
	Thu, 29 Oct 2026 02:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793239357;
	bh=ig9ryT9lQ5WH61asJrWLJKKAff4oOz6FkZcoxGtITzU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZnxXNoL4Q40oWbzyvpUY0pLFjvFN9FK/DXVtODmCrRREcQk6rgGKqY0vLZVrupTcn
	 kqh7lvT35zYATayZeC0ejUHkuQdv2ZSgJmuIaRab3Pc0l/KSN8qSk23jsWXdJeaOaQ
	 sGQZhBXkf8KdYVHpLtlQaIC2gSBtuY4oaMD44xeXNOnVgiVvQh7nsSjOq89cDQACEI
	 ALKTSCmEwHySp6di+9UQlBJOMzGZBCokVke1li215uVNRoTfBPqScGn5CfdUDUQmZf
	 VUbR2NhuIUm3I1FRtMaKPz50O45m8TzLhZe15/JveDUGw818MUP2rTq6fxHkmLOM7L
	 fjDEok5axoDNA==
Subject:
 Re: [PATCH v3 1/7] net: dsa: mt7530: get ctrl phy addr using a function
From: netdev-bot+sashiko@kernel.org
To: cjd@cjdns.fr
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, linux@armlinux.org.uk,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, naseefkm@gmail.com, b.larsson@gmx.com
Date: Thu, 29 Oct 2026 02:02:35 +0000
Message-ID: <179323935516.3134.4150149245635529305@kernel.org>
In-Reply-To: <20261028011317.1557238-2-cjd@cjdns.fr>
References: <20261028011317.1557238-2-cjd@cjdns.fr>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new helper mt753x_ctrl_phy_addr()
  (drivers/net/dsa/mt7530.c:49-57) handles a NULL priv->mdiodev by…
- [Low] The commit message says the control PHY is found by taking the
  switch's MDIO address, adding 1, and taking it "modulo 31".

--

net: dsa: mt7530: get ctrl phy addr using a function

This commit replaces the MT753X_CTRL_PHY_ADDR() macro with a
mt753x_ctrl_phy_addr() helper. The helper warns and returns 0 when
priv->mdiodev is NULL. It is also meant to give MMIO implementations a
place to supply their own control PHY address.

> The switch is typically on
> MDIO address 31 and the PHYs are 0, 1, 2, 3, and 4 with 0 being the
> special one. So taking the address of mdiodev (the switch) add 1 and
> modulo 31 finds the first PHY.

[Severity: Low]
Is "modulo 31" right here? The code computes:

    (priv->mdiodev->addr + 1) & (PHY_MAX_ADDR - 1)

PHY_MAX_ADDR is 32, so this masks with 31, which is modulo 32. For a
switch at address 31, (31 + 1) % 31 would give 1. The code gives 0,
which is the PHY the message calls the special one.

Should this say modulo 32, or say that it wraps around the 32-address
MDIO space?

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 7781a63b4e6fd..d10194488bdee 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -46,6 +46,16 @@ static const struct mt7530_mib_desc mt7530_mib[] = {
>  	MIB_DESC(1, MT7530_PORT_MIB_RX_ARL_DROP, "RxArlDrop"),
>  };
>  
> +static int
> +mt753x_ctrl_phy_addr(struct mt7530_priv *priv)
> +{
> +	if (WARN_ON_ONCE(!priv->mdiodev))
> +		return 0;

[Severity: Low]
When priv->mdiodev is NULL, this returns 0. That is also a valid PHY
address, so callers can't tell the fallback from a real result.

At this commit, core_write() and core_rmw() then use priv->bus without
checking it:

    struct mii_bus *bus = priv->bus;
    ...
    ret = bus->write(bus, ctl_phy, MII_MMD_CTRL, MDIO_MMD_VEND2);

On MMIO devices, mt7988_probe() sets priv->bus = NULL and never sets
mdiodev. If the fallback were hit there, could the WARN be followed by a
NULL bus dereference in core_write() or core_rmw()?

In mt7531_setup(), the same fallback would send the CORE_PLL_GROUP4
write and the EEE advertisement writes to PHYs 0 to 4.

This doesn't look reachable at this commit. Every caller runs only for
MT7530/MT7621/MT7531, which are probed through mt7530-mdio.c and always
have both priv->bus and priv->mdiodev set.

Two later patches in the series also cover this:

  - "net: dsa: mediatek: support PLL setup on MMIO MT7530" adds a
    child_bus fallback and a WARN_ON_ONCE(!bus) check to core_write()
    and core_rmw().
  - "net: dsa: mediatek: support EN751221 switch" adds the EN751221
    special case to this helper.

That leaves a design question. Should the helper return an error for a
missing mdiodev, so callers can bail out instead of using address 0?

> +
> +	/* Default is 1st PHY */
> +	return (priv->mdiodev->addr + 1) & (PHY_MAX_ADDR - 1);
> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028011317.1557238-1-cjd%40cjdns.fr
