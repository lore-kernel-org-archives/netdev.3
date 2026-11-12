Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484841;
	b=BChF5/oLk6Bvg54OWz5X7HnKlcG007wBHMkeFx37ZSbi/R2Cf+NE/ytnnM54crosHx7H
	 IxdGWKoLlBj2sVv+sKJxv8nuzrtTpHw/DgBirewqJQRoYpUXJvtgPiWrcyZVq2wQwn1jl
	 ZDIgqSjLL3E9WkjE3c/6YVb8+s+6GjGbwp3mIL8E3odX7e0x0U2v6Ku0cXBaInMGXIOVB
	 yosAPfg3hEOlTfgVrhWtA/i0/FI1yejxhq+UsLtAQh3YxRpJq28Rs5XdIEBLM9pcCQOem
	 R7d6z1hty3xM8baRLNJzzCjYwz1VmFFcJuvHtNWCdD10L2uP2iBxT4EXHgeVIyY5JtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484841;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=reKXay7kC6Gsdw/UyiL0rvUz8qowAE4QmFzdhuP2pPQ=;
	b=OGU7iOfzH9O77uTwV4e2BNz5O+ak1DzrwSLBntVoQMKKd5edAeEJXdvObUGx9QzKCRYd
	 d15yQmdSAHiJHwSXTgn0ZyUexhJEujFYyiK9h05F27Y2CPFLPI3Wcczp9cRQo1beGXlrL
	 yX6LBVUNdyp9sMuAqKidPtzmsihibehgbtue+WlppZx8NOrqTDAoYNeKuCrERtHA0hqd0
	 oKh75Z5jJBcX1dcaZNFaUfVI2SSauJvb9rUcXSUW3UyzTWY1CMLFXn90QKX3vQCdSBG82
	 YW3wKTMJIdVQs7dK5hQSMVPJf/cMgXhpmAE1vUehh6GT7kUFhWGc9YrJcUuCrysrdmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKdxTFhs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25104606A331;
	Thu, 12 Nov 2026 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKdxTFhs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CCE1F00A06;
	Thu, 12 Nov 2026 12:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484841;
	bh=reKXay7kC6Gsdw/UyiL0rvUz8qowAE4QmFzdhuP2pPQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bKdxTFhsC2/F90bvg632OU8a5cGHCmEaEaLD8XVHD6s7BPhXW8ZtGuUDrwkHB7Z3r
	 6eZJjWX3jakT5pg9uHUfLjwLUWLkwcNMnHxqSjpXMZCfK5znbZG/0n0SM8pYxW5h+i
	 6mfjD2oJKkXXqH31ZjYSSiFkuG/e/cXUkC5dH/Wt8X0mXJv/hNpIh6R7lThPg258nH
	 dsJjh3fJerEnRLsM5EwW2BKj/top2xCSCiJNgatpwE4IyaOTkPgJtBj3asNi+jutqs
	 fbxfB4t5RxsJX7vyytjCR+abHhRKQgvRBcs/n1KwrGquk3+691Z+a+RMicxT54+4B3
	 Dau9tUWKyrz6g==
Subject: Re: [PATCH net-next v2 3/7] net: ethernet: oa_tc6: Add support for
 MDIO indirect access
From: netdev-bot+sashiko@kernel.org
To: iustin.stolniceanu@analog.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, parthiban.veerasooran@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, marcelo.schmitt@analog.com,
 alvin.sipraga@analog.com, ciprian.regus@analog.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 12:00:39 +0000
Message-ID: <179448483966.2199510.8874035838800779806@kernel.org>
In-Reply-To: <20261109085952.105331-4-iustin.stolniceanu@analog.com>
References: <20261109085952.105331-4-iustin.stolniceanu@analog.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The indirect MDIO sequencing in drivers/net/ethernet/oa_tc6.c
  relies on MDIOACC register behaviour that the patch never checks or…
- [Low] oa_tc6_mdiobus_register() decides that indirect MDIOACC access is
  available only because STDCAP.DPRAC (BIT(8),…

--

net: ethernet: oa_tc6: Add support for MDIO indirect access

This adds indirect PHY register access through the MDIOACC registers
for OA TC6 MAC-PHYs that don't advertise direct access in STDCAP.DPRAC.
Clause 22 operations write a single frame to MDIOACC1. Clause 45
operations write an address frame to MDIOACC0 and a read or write frame
to MDIOACC1, then poll MDIOACC1 for TRDONE. The patch also removes the
-ENODEV failure that happened when DPRAC was clear.

> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 549997ba363ad..be1833c232e37 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c

[ ... ]

> @@ -436,24 +437,149 @@ int oa_tc6_write_register_mms(struct oa_tc6 *tc6, u8 mms, u16 address,

[ ... ]

> +static int oa_tc6_indirect_mdiobus_read_c45(struct oa_tc6 *tc6, int addr,
> +					    int devnum, int regnum)
> +{
> +	u32 reg_val;
> +	int ret;
> +
> +	reg_val = FIELD_PREP(OA_TC6_MDIOACC_OP, OA_TC6_MDIOACC_OP_ADDR);
> +	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_ST, OA_TC6_MDIOACC_ST_C45);
> +	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_PRTAD, addr);
> +	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_DEVAD, devnum);
> +	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_DATA, regnum);
> +
> +	ret = oa_tc6_write_register(tc6, OA_TC6_REG_MDIOACC(0), reg_val);
> +	if (ret)
> +		return ret;
> +
> +	reg_val = FIELD_PREP(OA_TC6_MDIOACC_OP, OA_TC6_MDIOACC_OP_RD);
> +	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_ST, OA_TC6_MDIOACC_ST_C45);
> +	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_PRTAD, addr);
> +	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_DEVAD, devnum);
> +
> +	ret = oa_tc6_write_register(tc6, OA_TC6_REG_MDIOACC(1), reg_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = oa_tc6_mdioacc_wait_done(tc6, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	return oa_tc6_mdioacc_read_data(reg_val);
>  }

[ ... ]

> +static int oa_tc6_indirect_mdiobus_read(struct oa_tc6 *tc6, int addr,
> +					int regnum)
> +{
> +	u32 reg_val;
> +	int ret;
> +
> +	reg_val = FIELD_PREP(OA_TC6_MDIOACC_OP, OA_TC6_MDIOACC_OP_RD);
> +	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_ST, OA_TC6_MDIOACC_ST_C22);
> +	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_PRTAD, addr);
> +	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_DEVAD, regnum);
> +
> +	ret = oa_tc6_write_register(tc6, OA_TC6_REG_MDIOACC(1), reg_val);
> +	if (ret)
> +		return ret;

[Severity: Medium]
Both of these sequences rely on MDIOACC behaviour that the code doesn't
check and the commit message doesn't cite from the spec.

oa_tc6_indirect_mdiobus_read_c45() and oa_tc6_indirect_mdiobus_write_c45()
write the address frame to MDIOACC0 and then write the read or write frame
to MDIOACC1 straight away. oa_tc6_mdioacc_wait_done() only polls
OA_TC6_REG_MDIOACC(1), so nothing ever checks TRDONE or TAERR for the
MDIOACC0 frame.

Do all TC6 MAC-PHYs queue MDIOACCn writes and run them in order? If a
device doesn't, could the data frame run before the MMD address is set and
return the contents of the wrong register?

For Clause 22, oa_tc6_indirect_mdiobus_read() and
oa_tc6_indirect_mdiobus_write() put the single frame in MDIOACC1. Does a
write to MDIOACC1 alone start a transaction, whatever MDIOACC0 holds? That
could be its reset value or a stale C45 address frame from an earlier
access.

The existing ADIN1110 driver uses MDIOACC0 for a single C22 transaction:

drivers/net/ethernet/adi/adin1110.c:adin1110_mdio_read() {
    ...
	/* write the clause 22 read command to the chip */
	mutex_lock(&priv->lock);
	ret = adin1110_write_reg(priv, ADIN1110_MDIOACC, val);
    ...
}

ADIN1110_MDIOACC is defined as 0x20 there.

Suppose a MAC-PHY without DPRAC runs MDIOACC0..n starting at MDIOACC0, or
doesn't trigger on a lone MDIOACC1 write. Could the C22 reads in the
mdiobus_register() scan then time out, or put an extra frame on the bus?

This may well work on ADIN1110, which uses this path later in the series.
But adin1110.c only shows that MDIOACC0 works when used on its own. Could
the commit message point to the section of the OA TC6 spec that defines
this ordering and triggering behaviour?

[ ... ]

> @@ -535,8 +675,16 @@ EXPORT_SYMBOL_GPL(oa_tc6_mdiobus_write_c45);
>  
>  static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
>  {
> +	u32 regval;
>  	int ret;
>  
> +	ret = oa_tc6_read_register(tc6, OA_TC6_REG_STDCAP, &regval);
> +	if (ret)
> +		return ret;
> +
> +	if (!(regval & OA_TC6_STDCAP_DIRECT_PHY_REG_ACCESS))
> +		tc6->mdio_indirect_mode = true;

[Severity: Low]
Should this also check the STDCAP bit for indirect PHY register access
(IPRAC, bit 9 in the OA TC6 STDCAP layout)? include/linux/oa_tc6.h only
defines OA_TC6_STDCAP_DIRECT_PHY_REG_ACCESS (BIT(8)).

The patch also removes oa_tc6_check_phy_reg_direct_access_capability()
from oa_tc6_phy_init(). So a MAC-PHY that advertises neither direct nor
indirect access, and doesn't set OA_TC6_BROKEN_PHY, is now driven through
MDIOACC0/1 anyway. Before this patch it failed with -ENODEV and "Direct
PHY register access is not supported by the MAC-PHY".

On such a device, if TRDONE never sets, each C22 scan read polls for up to
30 ms and returns -ETIMEDOUT. get_phy_c22_id() turns that into -EIO, and
probe fails with the generic "Could not register MDIO bus".

If the unimplemented register reads back with bit 31 set, the DATA field
would be used as PHY ID or register data that no PHY produced.

None of the in-tree users reach this case: lan865x has DPRAC, adin1140
sets OA_TC6_BROKEN_PHY, and ADIN1110 supports indirect access.

Could indirect mode be selected only when IPRAC is set, and the -ENODEV
error kept for when neither bit is set?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109085952.105331-1-iustin.stolniceanu%40analog.com
