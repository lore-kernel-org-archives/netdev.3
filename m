Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE54A0F06;
	Tue,  6 Oct 2026 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304304; cv=none; b=krEGPfw/cvZkT5yMon/scaT1wPYpjmeF4eiKvPX9sqDcgQlNeNfAHiDejiQ2ZSU1Shduw+buvX83A5FDQGQHO0kIzC91UmYx9tSgSx9g6Fse4ZdcLNDdiDhFX83H5qEE5giADViJOsiueyKAIbX+qVTkbZF4ulqEDOLCF0V6IIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304304; c=relaxed/simple;
	bh=Ia2PAF33SHxpLZgXFy71fnZ5fBK8iPw9HY67a8Vp0JA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VgG9dVOS9Pj7aZYuUGF4KOVtmEU+pfrmNCdSa4rs8WCoFSOp8yZkEyRrSRK5PECfEIKNbONzQ2iEo4y5Gk41k6ZwJkOTwHcrllIQ5L+eUoXyS9EW75pxr3Z1wYINf0qd4pC55HylPD5DkzJ/o+xkT6AHRstrgHKPyUSsiX5wRo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwveQMz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwveQMz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1AA1F0089E;
	Tue,  6 Oct 2026 16:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791304302;
	bh=PwgSoudEG75onyzQqXceiysP6xzmg+bTPZzQkCqQcCM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VwveQMz0JMQDodbqtVU7rZhmdyLwFj9KzT6+q0Z3StL0txckihpjd2r4hWBvkT8CC
	 oNd45d1CyxjAdq82NSMM356X0udaA9m/4bGhcG8qFxTGhacyxEx56ejvKzO9MeQUMl
	 Fx4MmhnlHJvW+GK5qXOUnY3XNtYORl9ma3Ktok6B6SLkm+H10+KcXE/D57mtZ0MtE3
	 6VN3brPfQpFWH8wNEDCmPvfOtInqdhm3jFKGeZmqENE3ikS6wLWwG7Mdk6aOjBmw3v
	 l+E50NrhVx9HVSMj+cdXW6ETAU1i+Gtmbtljqbhop44qO2cHRfFPRNuihBZKO0tp2h
	 cY+A59hJ2cY3A==
Subject: Re: [PATCH net-next v24 2/3] net: phy: Add support for Template
 Control register for PMA
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com
Date: Tue, 06 Oct 2026 16:31:41 +0000
Message-ID: <179130430105.434549.5432877862798179173@kernel.org>
In-Reply-To: <20261002153034.934814-3-kyle.switch@motor-comm.com>
References: <20261002153034.934814-3-kyle.switch@motor-comm.com>
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

- [Low] The concern: genphy_c45_template_testmode() in
  drivers/net/phy/phy-c45.c and the new MDIO_PMA_10GBT_TESTMODE_* UAPI…
- [Low] genphy_c45_template_testmode() returns -EOPNOTSUPP when test_mode
  > MDIO_PMA_10GBT_TESTMODE_7.
- [Low] The new UAPI macro MDIO_PMA_10GBT_TESTMODE_MASK in
  include/uapi/linux/mdio.h is defined as GENMASK(15, 13).
- [Low] MDIO_PMA_10GBT_TESTMODE_NORMAL through MDIO_PMA_10GBT_TESTMODE_7
  are exported in include/uapi/linux/mdio.h as raw, unshifted field…
- [Low] The concern: genphy_c45_template_testmode() writes PMA register
  1.132 without checking phydev->pma_extable for 10GBASE-T or NBASE-T…
- [Low] The concern: genphy_c45_template_testmode() puts the PMA into a
  link-disrupting test mode without forcing speed, disabling AN, setting…

--

net: phy: Add support for Template Control register for PMA

This commit adds genphy_c45_template_testmode(), an exported helper that
programs the 10GBASE-T PMA template test mode field (bits 15:13 of PMA
register 132). It also adds the register number and the field and value
definitions to include/uapi/linux/mdio.h.

> diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
> index 870920311f9a0..c5f5753f7194b 100644
> --- a/drivers/net/phy/phy-c45.c
> +++ b/drivers/net/phy/phy-c45.c
> @@ -1408,6 +1408,29 @@ int genphy_c45_fast_retrain(struct phy_device *phydev, bool enable)
>  }
>  EXPORT_SYMBOL_GPL(genphy_c45_fast_retrain);
>  
> +/**
> + * genphy_c45_template_testmode - configure template testmode registers
> + * @phydev: target phy_device struct
> + * @test_mode: testmode includes Normal to Test mode 7
> + *
> + * Description: Set template testmode include Normal to Test mode 7
> + *
> + * Return: 0 on success, or a negative error code on failure (e.g. register
> + * read/write error).
> + */
> +int genphy_c45_template_testmode(struct phy_device *phydev, u16 test_mode)

[Severity: Low]
In this patch by itself, nothing in the tree uses this exported helper or
the new MDIO_PMA_10GBT_TESTMODE_* defines.

The next patch in the series, "net: phy: Add driver for Motorcomm Quad
2.5GbE phy", adds the callers in drivers/net/phy/motorcomm.c. They are
yt8824_utp_set_template_test_mode() and the YT8824 soft reset sequence.
That looks like the usual split where the API comes before its user.

Would it help to say in the commit message that the user comes in the
following patch?

> +{
> +	u16 ctrl;
> +
> +	if (test_mode > MDIO_PMA_10GBT_TESTMODE_7)
> +		return -EOPNOTSUPP;

[Severity: Low]
Should this be -EINVAL rather than -EOPNOTSUPP?

A test_mode above 7 is a bad argument from the caller. In phylib,
-EOPNOTSUPP usually means the PHY does not support the operation, and
callers often check for it so they can fall back.

The helper also never checks PMA capability. So it never returns
-EOPNOTSUPP in the case that errno normally describes.

The kernel-doc Return: section above gives only register read/write
failures as examples. Could it also mention this range check and the errno
it returns?

Every in-series caller passes a constant between 0 and 7, so this cannot
be hit today.

> +
> +	ctrl = FIELD_PREP(MDIO_PMA_10GBT_TESTMODE_MASK, test_mode);
> +	return phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_10GBT_TESTMODE,
> +			      MDIO_PMA_10GBT_TESTMODE_MASK, ctrl);

[Severity: Low]
This writes PMA register 1.132 without checking phydev->pma_extable for
10GBASE-T or NBASE-T ability. On a PMA without BASE-T ability, could this
write a reserved or vendor register and still return 0?

This may be intended. genphy_c45_fast_retrain() above also writes
MDIO_PMA_10GBR_FSRT_CSR without a capability check and leaves that to the
calling driver.

The only caller in the series is motorcomm.c, which uses it for its own
YT8824 PHY, and that PHY implements the register.

[Severity: Low]
A non-normal template test mode disrupts the link. This helper does not
coordinate with the phylib state machine, and it does not record the mode
so it can be restored later.

Is the intent that callers handle all of the sequencing, including
restoring MDIO_PMA_10GBT_TESTMODE_NORMAL?

That would match genphy_c45_loopback() and genphy_c45_fast_retrain(). The
in-series caller in motorcomm.c does restore NORMAL after TESTMODE_1, on
both the success path and the err_restore_normal path.

Could the kernel-doc state that callers must do this?

> +}
> +EXPORT_SYMBOL_GPL(genphy_c45_template_testmode);

[ ... ]

> diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
> index 06f4bc3c20c71..353ca13c64fca 100644
> --- a/include/uapi/linux/mdio.h
> +++ b/include/uapi/linux/mdio.h

[ ... ]

> @@ -320,6 +321,17 @@
>  /* PMA 10GBASE-R Fast Retrain status and control register. */
>  #define MDIO_PMA_10GBR_FSRT_ENABLE	0x0001	/* Fast retrain enable */
>  
> +/* PMA 10GBASE-T Template Test Mode Register*/
> +#define MDIO_PMA_10GBT_TESTMODE_MASK GENMASK(15, 13) /* Template test mode */

[Severity: Low]
GENMASK() is defined only for the kernel, in include/linux/bits.h. The
exported include/uapi/linux/bits.h provides only __GENMASK(),
__GENMASK_ULL() and __GENMASK_U128(). Also, mdio.h includes only
<linux/types.h> and <linux/mii.h>.

If userspace includes the installed <linux/mdio.h> and uses
MDIO_PMA_10GBT_TESTMODE_MASK, will it fail to compile because GENMASK is
undefined?

The existing MDIO_AN_C73_* defines in this header have the same problem,
but this adds another one. Could this use __GENMASK(15, 13) with
<linux/bits.h> included, as include/uapi/linux/pci_regs.h does, or just
0xe000?

> +#define MDIO_PMA_10GBT_TESTMODE_NORMAL 0x0 /* Template Normal */
> +#define MDIO_PMA_10GBT_TESTMODE_1 0x1 /* Template TestMode1 */
> +#define MDIO_PMA_10GBT_TESTMODE_2 0x2 /* Template TestMode2 */
> +#define MDIO_PMA_10GBT_TESTMODE_3 0x3 /* Template TestMode3 */
> +#define MDIO_PMA_10GBT_TESTMODE_4 0x4 /* Template TestMode4 */
> +#define MDIO_PMA_10GBT_TESTMODE_5 0x5 /* Template TestMode5 */
> +#define MDIO_PMA_10GBT_TESTMODE_6 0x6 /* Template TestMode6 */
> +#define MDIO_PMA_10GBT_TESTMODE_7 0x7 /* Template TestMode7 */

[Severity: Low]
These are unshifted field values. Most other value constants in this
header are pre-shifted register bits. Examples are
MDIO_PMA_10GBR_FSRT_ENABLE just above, the MDIO_PMA_10GBT_SWAPPOL_* bits,
and MDIO_USXGMII_SPD_* under the 0x0e00 mask.

genphy_c45_template_testmode() shifts these values with FIELD_PREP(), but
the header does not say they need shifting. If someone writes
MDIO_PMA_10GBT_TESTMODE_3 directly into register 1.132, wouldn't bits
15:13 be left at 0 (Normal)?

These names become permanent UAPI. Would it be clearer to pre-shift them,
or to say in the comment that they are field values for
MDIO_PMA_10GBT_TESTMODE_MASK?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002153034.934814-2-kyle.switch%40motor-comm.com
