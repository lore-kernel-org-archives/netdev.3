Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE7A4BD7B6;
	Sat, 10 Oct 2026 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661224; cv=none; b=rLPbCq9Jy8BtJV8GhXXMs3yuDRekDG4NA8A2DNTOaQa48lNQB8CjL0RiM1nAsuJB2uMWyWDb8oLbc9OvlCd1Dwyxl7nPwCOf3x/3AtTQedZyDWX+oc1QcmjXeCnyeYomGawPnnFKH62fD7MHLbB+Q6OzTWlKPG4avDgxAfttfBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661224; c=relaxed/simple;
	bh=8jrsGy6SWYYVjRXyTGb47a0v2IVm7BzeOKYuaU6QHz4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nviX5u2R90IWKHhK5Iz42X0Rf0iu+9TM2yCAAnsxqMYFu1PQICTbK8bOYZZ6G16aupMprSuxteo5IIfEKRO7qI2+BDKt7jXy+V53G9xJ+omuQ322RvsrRUd8dgp5tXlBDqnhlKg5HmzKbgGeKFFwenQFmQleQ7ug/W5SQT3+y6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXOfFamn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXOfFamn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61FE1F0089A;
	Sat, 10 Oct 2026 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791661220;
	bh=7OHwjQtY0x3YdtfuQNPPgk0/84ywzq7SNRlouHxpfow=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XXOfFamnsth8G6OOuGjETNqr9upFxWRi9TdA5JsrIl5BNu0j2eLIzdn0GWLHRlcJj
	 H8VYjgXmhFdVm/8hDSERvEKV4NOp/mCQzqbMSy/lrOlBTO9InP8JN4TzXSwr/BMvh9
	 9aDcfSEcTxK+Bc07B2jfon1ozFjXYLZtP1+i189xEZ8s19bkcV98ACA/YbTG72sCcz
	 6vWuz6s2T9VSfU+7JzYeug7w9o9jtx/7WD91GBmC+/sW17mS/4/WW08ND7UTuZcAOs
	 +QHX/R4wsuRpDdE8DMZbZaC9MweGwxzd4eOd3faPXsD14aWScJRJMv4Ht3miAf7lik
	 QbWu/Ckt5F9zA==
Subject: Re: [PATCH net-next v9 06/11] net: ethernet: oa_tc6: Support for
 vendor specific MMS
From: netdev-bot+sashiko@kernel.org
To: Selvamani.Rajagopal@onsemi.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 parthiban.veerasooran@microchip.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, richardcochran@gmail.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 edumazet@kernel.org, piergiorgio.beruto@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, jerry.ray@microchip.com, ciprian.regus@analog.com
Date: Sat, 10 Oct 2026 19:40:18 +0000
Message-ID: <179166121819.434549.1077502913840125344@kernel.org>
In-Reply-To: <20261009-s2500-mac-phy-support-v9-6-dcefe1d0bf0d@onsemi.com>
References: <20261009-s2500-mac-phy-support-v9-6-dcefe1d0bf0d@onsemi.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Documentation/networking/oa-tc6-framework.rst describes
  oa_tc6_set_vend1_mms() as mapping VEND1 to a vendor MMS 'between 10…

--

net: ethernet: oa_tc6: Support for vendor specific MMS

This commit adds an exported helper, oa_tc6_set_vend1_mms(), so a vendor
driver can map MDIO_MMD_VEND1 to a vendor-specific MMS value. With this
change, oa_tc6_get_phy_c45_mms() returns the stored value for
MDIO_MMD_VEND1. The value defaults to -EOPNOTSUPP in oa_tc6_init().

> diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6.c b/drivers/net/ethernet/oa_tc6/oa_tc6.c
> index 0b6e216de8a1b..0c4f7d3f978fd 100644
> --- a/drivers/net/ethernet/oa_tc6/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6/oa_tc6.c
> @@ -248,6 +248,18 @@ static int oa_tc6_update_standard_capability(struct oa_tc6 *tc6)
>  	return 0;
>  }
>  
> +/**
> + * oa_tc6_set_vend1_mms - Add vendor specific MDIO_MMD to OA TC6 MMS
> + * mapper value.
> + * @tc6: oa_tc6 struct.
> + * @mms: vendor defined MMS value for VEND1 mdio device.
> + */
> +void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms)
> +{
> +	tc6->vend1_mms = mms;
> +}

[Severity: Low]
Should this setter reject values outside the 10..15 range?

Documentation/networking/oa-tc6-framework.rst says the helper is for
vendors that "may have used any MMS value between 10 and 15 as allowed by
the specification". However, the setter stores any int as-is and returns
void.

oa_tc6_mdiobus_read_c45() and oa_tc6_mdiobus_write_c45() only reject
mms < 0. The value is then passed as a u8 to oa_tc6_read_register_mms() and
oa_tc6_write_register_mms(), which do:

    mms_reg = FIELD_PREP(OA_TC6_REG_MMS_MASK, mms) | address;

OA_TC6_REG_MMS_MASK is GENMASK(19, 16). That means a value of 0..9 selects
a standard memory map directly, and 16 or 17 wraps to MMS0 or MMS1. VEND1
MDIO reads and writes would then go to a different register space without
any error.

The only caller in the series, s2500_probe(), passes
OA_TC6_PHY_C45_VS_MMS12, which is in range. Nothing in the tree hits this
today.

Would it make sense to add a range check that returns -EINVAL? Another
option is kernel-doc text stating that the caller must pass a value in
10..15.

> +EXPORT_SYMBOL_GPL(oa_tc6_set_vend1_mms);
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d%40onsemi.com
