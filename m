Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF354B404D;
	Fri, 18 Sep 2026 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719409; cv=none; b=RodOGiDo4Pn0Lm/cukRq+yYN5G1cdjH82W5nb2OiW3+9UhTGvNMXKBlsVLCN3NrJfBHslJCGZyxXngYY3st7O7Ox4ms77g82okqhlBmnJsdBQaldt1exwZyUepJXceuVPDjdKnW4bFDHiUyrSSKxF+Y51NP5p7ghfUG+iuRPJXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719409; c=relaxed/simple;
	bh=GR0NmSqALrm/08vrADHp2Eq5wgJAf7oqAp268BfYiSo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FpkHPCf5telK1x0FRJW8uPpXR53zpSBg184Qzr007RnTaRlcyykKne0S0emzaH98l00l405RtYHtHSvz6Lqz/+dNwFl5gXYJEVg1MWWDnXXPXVCI74khPRlhtxXF+vfsi8y1Xhrm96k+NfxLhKmxd4aMDP+oOaWeqf3PsJrAa0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/eLT/ns; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/eLT/ns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B661F00899;
	Fri, 18 Sep 2026 08:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789719402;
	bh=svdWVUPfCuWhOFdW/xeAYqd+z0yB/y3Z+wfB7qlDPO4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m/eLT/ns+slOrb1n85TMEHxDTZoQkevtdbDaKJ2Jy3pv5iCOH1cvsvQAlaUV/PwDV
	 0SVQHT8qrHZp/TG+FvAxktsH8J/Y4C8TH2QjvP6p1AcCRqhgBmadouC1Mixbk8X5Z2
	 iKUsuOHCLstPquhEso+bRb6nhZLND+gfXH3Nd1j6njaah+yvlU4zYoo/s6D80hZgBZ
	 Lu39YJCmX0ZD9eA2w+uA9LPNgqQmww3icv/A8hl+b4l6u2MbM88YJkaSlTDOskhO66
	 dVj1mQYq/eUlQX5g5RnD7orNK6NLQh88B8pNCkjSXpNKEzdmMoVlMJihlQwo+zQoUo
	 vlSW0dUTTK8kw==
Subject:
 Re: [PATCH net-next v1 2/3] net: phy: realtek: add firmware for RTL8261D
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 freddy_gu@realsil.com.cn, nb@tipi-net.de, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, daniel@makrotopia.org,
 vladimir.oltean@nxp.com
Date: Fri, 18 Sep 2026 08:16:41 +0000
Message-ID: <178971940160.22033.15376845467031606521@kernel.org>
In-Reply-To: <20260916081444.497-3-javen_xu@realsil.com.cn>
References: <20260916081444.497-3-javen_xu@realsil.com.cn>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

- [High] net: phy: realtek: making rtl_nic/rtl8261d.bin a hard
  requirement silently breaks RTL8261D hardware that works today.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the RTL8261D
  path newly enabled here inherits it: priv->fw_loaded is never…

--

net: phy: realtek: add firmware for RTL8261D

This adds a firmware file name and a per-part sub magic value for the
RTL8261D, and makes rtl8261x_verify_firmware() compare the header sub
magic against the value stored in the driver private data instead of the
hardcoded RTL8261C value.

> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index d0d09e8e8f5c5..61e6029489313 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -286,11 +286,15 @@
>  
>  #define FW_MAIN_MAGIC			0x52544C38
>  #define FW_SUB_MAGIC_8261C		0x32363143
> +#define FW_SUB_MAGIC_8261D		0x32363144
>  #define RTL8261X_POLL_TIMEOUT_MS	100
>  #define RTL8261X_MAX_MMD_DEV		31
>  
>  #define RTL8261C_CE_FW_NAME	"rtl_nic/rtl8261c.bin"
> +#define RTL8261D_FW_NAME	"rtl_nic/rtl8261d.bin"
> +
>  MODULE_FIRMWARE(RTL8261C_CE_FW_NAME);
> +MODULE_FIRMWARE(RTL8261D_FW_NAME);

[ ... ]

> @@ -411,10 +416,13 @@ static int rtl8261x_probe(struct phy_device *phydev)
>  	switch (sub_phy_id) {
>  	case RTL8261C_CE_MODEL:
>  		priv->fw_name = RTL8261C_CE_FW_NAME;
> +		priv->fw_sub_magic = FW_SUB_MAGIC_8261C;
>  		phydev_info(phydev, "RTL8261C detected (sub_id 0x%02x)\n", sub_phy_id);
>  		break;
>  
>  	case RTL8261D_MODEL:
> +		priv->fw_name = RTL8261D_FW_NAME;
> +		priv->fw_sub_magic = FW_SUB_MAGIC_8261D;
>  		phydev_info(phydev, "RTL8261D detected (sub_id 0x%02x)\n", sub_phy_id);
>  		break;

[Severity: High]
Does setting priv->fw_name for RTL8261D turn rtl_nic/rtl8261d.bin into a
hard requirement for the part to work at all?

Before this patch this switch arm only printed the info line, so fw_name
stayed NULL from the devm_kzalloc() in rtl8261x_probe() and
rtl8261x_config_init() returned 0 without touching the firmware loader:

	/* The firmware parameters are preserved across IEEE soft resets and
	 * suspend/resume cycles. ...
	 */
	if (priv->fw_name && !priv->fw_loaded)
		return rtl8261x_fw_load(phydev);

	return 0;

With fw_name set, rtl8261x_fw_load() returns the request_firmware() error
verbatim:

	ret = request_firmware(&fw, priv->fw_name, &phydev->mdio.dev);
	if (ret) {
		phydev_err(phydev, "Failed to load firmware %s: %d\n", priv->fw_name, ret);
		return ret;
	}

and that error is fatal all the way up:

rtl8261x_config_init() -> phy_init_hw() -> phy_attach_direct()

phy_init_hw() does "ret = phydev->drv->config_init(phydev); if (ret < 0)
return ret;" and phy_attach_direct() does "err = phy_init_hw(phydev); if
(err) goto error;".

So on a board with an RTL8261D that links today, is a missing or unreadable
rtl8261d.bin (-ENOENT, or -EAGAIN when the loader/rootfs is not ready yet)
now enough to fail PHY attach so the interface never comes up?  MODULE_FIRMWARE()
only advertises the name to initramfs tooling, it does not make the blob exist.

Two follow-ups:

Has rtl8261d.bin been accepted into linux-firmware?  The commit message
("Add support for RTL8261D to load firmware") does not mention it.

Would firmware_request_nowarn() plus treating -ENOENT as non-fatal be
preferable here, so the part keeps falling back to its power-on/OTP defaults
as it does today?

For reference, the later patch in the series ("net: phy: realtek: add support
for RTL8261D_VM") does not change this behaviour: the RTL8261D_FW_NAME
assignment stays unconditional and config_init() still returns the loader
error.

[Severity: Medium]
This isn't a bug introduced by this patch, but routing RTL8261D through the
same mechanism extends it to the D part: priv->fw_loaded is never
invalidated across a PHY hardware reset, so the reload that the comment in
rtl8261x_config_init() calls for never happens.

rtl8261x_fw_load() sets the flag on success:

	priv->fw_loaded = true;

and nothing clears it again; the only zeroing is the devm_kzalloc() in
rtl8261x_probe(), i.e. once per driver bind.  Meanwhile
rtl8261x_config_init() states:

	/* The firmware parameters are preserved across IEEE soft resets and
	 * suspend/resume cycles. Reloading is only necessary after a power
	 * cycle or hard reset.
	 */
	if (priv->fw_name && !priv->fw_loaded)
		return rtl8261x_fw_load(phydev);

On boards that describe a PHY reset line, phy_detach_internal() only calls
device_release_driver() when phydev->is_genphy_driven is set, so a dedicated
driver such as this one stays bound with its private data intact, and then:

phy_detach_internal()
	phy_device_reset(phydev, 1);	/* reset asserted, fw_loaded survives */

A later re-attach goes:

phy_attach_direct() -> phy_init_hw()
	phy_device_reset(phydev, 0);
	ret = phydev->drv->config_init(phydev);

and config_init() sees fw_loaded still true and skips the load, so the PHY
runs on power-on defaults while initialization is reported as successful.

Should fw_loaded be cleared where the reset is asserted, or dropped in favour
of always loading in config_init()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916081444.497-1-javen_xu%40realsil.com.cn
