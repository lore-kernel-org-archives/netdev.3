Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322572;
	b=MJvMITrmY/POKwjRrNhReQkQ3moy3zf2Qpw+QnmawK3sC5hc1g9OT+/5vVDF6+qQpAM7
	 /k05yPqeYtfNFIKWZHtN0G1yfqrEN5cK5YZ6j63/keWvUIFbunD1SK1pb68FCRNMky3rJ
	 PoLpKYFKRtvF1hbcmPcfuND9gTya3NjZoJWMGyBZyk4+yZmHEZthPNGQP9Wt18Yi7YBIy
	 ez5nNHo9fKD5Xs+Dnz3qd5Z72F+2ArM35m+lQ8G1ejAepimMtgjOGLCVJ9SZjM5kggHxl
	 QKHgGujwjUO/dGhdRCDjkm2UJffeLEqEIMu/1Dxb1eVnvkh/NzdwmNt3PhHqgPmvk6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322572;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=oORDmuKjipQctS12DwaKaR7VWThQmhuzt9K9csDftBc=;
	b=g5kg//0poO3ex0Omm79ZYPWVDQd9rTCO+SalDFyusqPdzSyYl/+B1CSolBTG59uVh9PD
	 XDMmcq+mk53SSakStjV2Y5PprAgzSP3B1a9z1U1NpDuIBgabCJyBt/7wI16+MYf2lv9KH
	 yoh7+LodXTh11vjIBPgv+WnI2elZ9UBe4XXBE85N5fpxrrBEFvR2sMwwxtgnguh+/iBok
	 aFg/Xg2fRJuHQy9epCjqoPqFn3uiv+rShn1YBOs2+OZh/ByvTuRerl4dWqCXipDpD4hQu
	 uRt3obniUYcKlEe6Sj/EIgfcpbbItJB7a59+PpjRqIaKSxl0x7ODBkOzovMo3j3AmDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G16I+S+7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A988C606A331
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A988C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G16I+S+7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794322570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oORDmuKjipQctS12DwaKaR7VWThQmhuzt9K9csDftBc=;
	b=G16I+S+7e7n0velEkLYv+Y93xdfPh6ps4VGz/NbLiH77G+8/fSaIoj8MW9d2FCSNzLGgb2
	abtNUlwEgemtwZPYmXy1Es7+KBNcbBC6xsPR0xBiq8E6npEFCyCvHWGC0ufb8Wjl0eMvAq
	FbYtTTEO5pKDHb+u45FVa7jB0eBHvsk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-_cjHZJsTOjCn06W9wlcITA-1; Tue,
 10 Nov 2026 09:56:08 -0500
X-MC-Unique: _cjHZJsTOjCn06W9wlcITA-1
X-Mimecast-MFC-AGG-ID: _cjHZJsTOjCn06W9wlcITA_1794322566
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A51861956057;
	Tue, 10 Nov 2026 14:56:05 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 912FA7E2;
	Tue, 10 Nov 2026 14:55:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: kyle.switch@motor-comm.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Frank.Sae@motor-comm.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com
Subject: Re: [PATCH net-next v28 3/3] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
Date: Tue, 10 Nov 2026 15:55:41 +0100
Message-ID: <20261110145541.265328-1-pabeni@redhat.com>
In-Reply-To: <20261104060636.3901918-4-kyle.switch@motor-comm.com>
References: <20261104060636.3901918-4-kyle.switch@motor-comm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
--- Patch [3]: [PATCH net-next v28 3/3] net: phy: Add driver for Motorcomm Quad 2.5GbE phy ---
commit 7395dc0c40b1873da64b3582ad548b846fa382f0
Author: Kyle Switch <kyle.switch@motor-comm.com>

net: phy: Add driver for Motorcomm Quad 2.5GbE phy

This adds support for the Motorcomm YT8824 quad-port 2.5G PHY to the
existing motorcomm driver. The phy_package helpers give access to the
shared top extended register space, and the four ports share a mutex, the
package mode and a SerDes init flag.

> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 463e1ea3efc93..492e236ec9e31 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c

[ ... ]

> @@ -33,6 +39,18 @@
>   *  ------------------------------------------------------------
>   */
>  
> +/* YT8824 Register Overview
> + * UTP Register space	| SERDES Register space
> + *  ------------------------------------------------------------
> + * | UTP MII		| SERDES MII		|
> + * | UTP MMD		|			|
> + * | UTP Extended	| SERDES Extended	|
> + * | UTP Top Extended	| SERDES Top Extended	|
> + *  ------------------------------------------------------------
> + * |   Common Top Extended			|
> + *  ------------------------------------------------------------
> + */

[Severity: Low]
[Finding: main-2-3]
[Sources: opus-5-5]
Is this overview accurate for the SerDes extended registers? It puts
"SERDES Extended" among the per-PHY spaces, and only "Common Top Extended"
is shown as shared across the package.

yt8824_extern_config_sds_init_paged() writes all of its SerDes tuning
registers (PLL VCO/FBDIV, CDR, AFE, DFE, TX pre-emphasis, calibration
restart) through the calling PHY's own address:

ytphy_modify_ext() / ytphy_write_ext()
    __phy_write(phydev, YTPHY_PAGE_SELECT, regnum)
        __mdiobus_write(phydev->mdio.bus, phydev->mdio.addr, ...)

Only the efuse reads go through ytphy_read_top_ext() and the package
address. yt8824_config_init() runs this sequence for just one port per
package, gated by priv->sds_initialized.

If the SERDES Extended space really is per port, would ports 1-3 never get
their SerDes tuning? If it is aliased package-wide, which seems likely with
a single QXGMII lane, could the overview say so?

[ ... ]

> @@ -642,11 +950,1168 @@ static int ytphy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)

[ ... ]

> +static int yt8824_config_utp_init_paged(struct phy_device *phydev)
> +{

[ ... ]

> +	ctrl = FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH0, 0);
> +	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH1, 0);
> +	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH2, 0);
> +	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH3, 0);
> +	mask  = YT8824_U0_CSR_RESETB_TX_CH0 | YT8824_U0_CSR_RESETB_TX_CH1 |
> +		YT8824_U0_CSR_RESETB_TX_CH2 | YT8824_U0_CSR_RESETB_TX_CH3;
> +	ret = ytphy_modify_ext_with_lock(phydev, YT8824_U0_CSR_RESET_REG,
> +					 mask, ctrl);
> +	if (ret < 0)
> +		goto err_restore;
> +
> +	ctrl = FIELD_PREP(YT8824_U1_CSR_RESETB_TX_CH0, 0);
> +	ctrl |= FIELD_PREP(YT8824_U1_CSR_RESETB_TX_CH1, 0);
> +	ctrl |= FIELD_PREP(YT8824_U1_CSR_RESETB_TX_CH2, 0);
> +	ctrl |= FIELD_PREP(YT8824_U1_CSR_RESETB_TX_CH3, 0);
> +	mask = YT8824_U1_CSR_RESETB_TX_CH0 | YT8824_U1_CSR_RESETB_TX_CH1 |
> +	       YT8824_U1_CSR_RESETB_TX_CH2 | YT8824_U1_CSR_RESETB_TX_CH3;
> +	ret = ytphy_modify_ext_with_lock(phydev, YT8824_U1_CSR_RESET_REG,
> +					 mask, ctrl);
> +	if (ret < 0)
> +		goto err_restore;

[Severity: Medium]
[Finding: main-7-9]
[Sources: opus-5-5]
Are these U0/U1 TX channel resets local to the calling port?

yt8824_config_utp_init_paged() runs from every port's config_init: on each
attach, each system resume, and the MII BMCR_RESET ioctl path. There is no
phy_package_init_once() or similar guard around it.

Going by their names, several registers written here through the per-port
address may cover more than one port:

  YT8824_PLL_DAC_RST in 0xa2b6 (toggled 0 then 1)
  YT8824_U0_CSR_RESET_REG 0xa01d and YT8824_U1_CSR_RESET_REG 0xa01e
  YT8824_P01_PLL_EN_REG 0xa218
  the P0/P1 DAC bias registers 0xa2d5-0xa2d8
  YT8824_U0_U1_ENABLE_ODD_PREAMBLE in 0xa003
  the PLL VCO registers 0xa20a/0xa20c/0xa20e

The same patch treats 0xa000 (space select) and 0xa13e-0xa140 (efuse) as
shared top extended registers, reached through the package address.

If the U0/U1 and P0/P1/P01 registers do cover sibling ports, attaching or
resuming one port would briefly hold the neighbouring ports' TX channels
and PLL DAC in reset. Wouldn't that drop links that are already up? This
is based only on the register names and address range.

[ ... ]

> +static int yt8824_config_init(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret;
> +
> +	mutex_lock(&priv->shared_lock);
> +	if (priv->package_mode == PHY_INTERFACE_MODE_INTERNAL) {
> +		ret = yt8824_config_utp_init_paged(phydev);
> +		if (ret < 0)
> +			goto err;
> +	} else {
> +		if (!priv->sds_initialized) {
> +			ret = yt8824_extern_config_sds_init_paged(phydev);
> +			if (ret < 0)
> +				goto err;
> +			priv->sds_initialized = true;
> +		}

[ ... ]

> @@ -3240,6 +4705,455 @@ static int yt8821_resume(struct phy_device *phydev)

[ ... ]

> +static int yt8824_resume(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret;
> +
> +	mutex_lock(&priv->shared_lock);
> +	ret = yt8824_power_on(phydev);
> +	if (!ret)
> +		priv->sds_initialized = false;
> +	mutex_unlock(&priv->shared_lock);
> +
> +	return ret;
> +}

[Severity: Medium]
[Finding: main-1-1]
[Sources: opus-5-5]
Does clearing sds_initialized here defeat the once-per-package check in
yt8824_config_init() above?

phylib calls config_init before resume in each of these paths:

  phy_attach_direct()
    phy_init_hw()      -> yt8824_config_init(), flag set to true
    phy_resume()       -> yt8824_resume(), flag cleared

  mdio_bus_phy_resume()
    phy_init_hw()
    phy_resume()

  phy_start()
    __phy_resume()     -> yt8824_resume(), flag cleared

So the flag is false again as soon as port A is attached. The next
config_init on any port of the package reruns
yt8824_extern_config_sds_init_paged(). That happens on port B attach, and
on each port's mdio_bus_phy_resume().

That sequence clears YT8824_CSR_US_GLB_RESET_N and reprograms the PLL
VCO/FBDIV/spare registers. It also writes CALIB_SEQ_SW_RST and pulses
YT8824_RESTART_CAL_CTRL_REG (0x40, then 0). In 10G-QXGMII mode all four
ports share that lane.

Can bringing up one port re-calibrate the SerDes while the sibling ports
are carrying traffic?

The opposite case looks possible too. Suppose config_init runs with no
resume after it, for example phy_init_hw() from the MII ioctl BMCR_RESET
path. The flag then stays true across suspend, and the first config_init
after system resume would skip the SerDes init.

In both cases the flag no longer matches the struct comment "true once the
package-wide SERDES init has been done".

[ ... ]

> +static int yt8824_phy_package_probe_once(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	struct device_node *np = phy_package_get_node(phydev);
> +	const char *mode;
> +

[ ... ]

> +	/* Initialise shared lock for YT8824 */
> +	mutex_init(&priv->shared_lock);
> +	priv->sds_initialized = false;
> +	priv->package_mode = PHY_INTERFACE_MODE_INTERNAL;
> +	if (!of_property_read_string(np, "motorcomm,package-mode",
> +				     &mode)) {

[ ... ]

> +	} else {
> +		phydev_err(phydev, "missing package-mode in PHY package node.\n");
> +		return -EINVAL;
> +	}

[ ... ]

> +static int yt8824_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct yt8824_shared_priv *shared_priv;
> +	int ret;
> +
> +	ret = devm_of_phy_package_join(dev, phydev, sizeof(*shared_priv));
> +	if (ret)
> +		return ret;
> +
> +	/* Ensure other PHY probes wait for shared mutex initialization. */
> +	phy_package_lock(phydev);
> +	if (phy_package_probe_once(phydev)) {
> +		ret = yt8824_phy_package_probe_once(phydev);
> +		if (ret) {
> +			phy_package_unlock(phydev);
> +			return ret;
> +		}
> +	}
> +	phy_package_unlock(phydev);

[Severity: Low]
[Finding: main-4-5]
[Sources: opus-5-5]
phy_package_probe_once() uses up the package's once bit before the DT has
been validated, and nothing clears it again:

__phy_package_set_once()
    return !test_and_set_bit(b, &shared->flags);

yt8824_phy_package_probe_once() also sets package_mode to
PHY_INTERFACE_MODE_INTERNAL before it reads "motorcomm,package-mode".

If that property is missing or unsupported, this PHY returns -EINVAL. Its
devm_phy_package_leave() only drops its own reference. If a sibling has
already joined the package (overlapping probes, for example with async
probing), the shared struct survives with the once bit still set.

Would that sibling then see phy_package_probe_once() return false, skip the
DT check, and bind in INTERNAL mode, even though the DT is invalid or asks
for 10G-QXGMII?

Could a successful package init be tracked in a separate flag under
phy_package_lock(), so siblings fail or retry when it isn't set?

The !priv || !np early return can't happen once of_phy_package_join() has
succeeded, so an uninitialized shared_lock isn't reachable. The concern is
only the unvalidated package mode.
-- 
This is an AI-generated review.

