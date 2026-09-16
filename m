Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330A1412BF7;
	Wed, 16 Sep 2026 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563739; cv=none; b=ayPS5geGVwcJNuILcFXPDSOLvPNqpVB5cn0FQFs8s8kgz6ip+wVpYjdL7JEGkAX4aoBOKZmgvY1aRczb0EKR/K3xrZ5bFVv2kqktoIsdiSP8XOOtjHrw/ctdH61oK8x1VzMqOtCTOsid3Q2Na6hxdAOssyGU+5OkdMkyIDtdOE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563739; c=relaxed/simple;
	bh=8iWGi+qHF15QgH4sKYP5ZBcXJhr/Sp5RK4Ot3VCtfVU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fYwI/azP0PbqG7zrU4YwkWSba3dvfR3BQ48UDuMhPiY4EPvpzIkaRbrQooqMeFcRGMm2Cfvt3dnn92V3M2Il7P1do1u/Yrsn1ezFSsnx15KexMFSuse+EuA+g0Opqckii1rR15EFk+3f/xD7GU9+sRMPv4sy/8ejgN/QBMfTNac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlH5itJz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlH5itJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E2B1F000FF;
	Wed, 16 Sep 2026 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789563738;
	bh=0QcGnacH+KJFn6w+VrA90e+YcwQ6uth1bj6kaKnv7os=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YlH5itJzso+qhoLoQF9+0WCI75Mii6UkgT3kT/gVe3//VMgqptZ0Qz6td9RMiBiY7
	 DtYIi808yunn+AOgv0SVc/eEN7VNQrCL4+HKzsMeaDAS4C86/y7fyTW+0Eg1WGXT5L
	 9YpewMqENL0MK+DB44CKETUz63GwIKPAeWFgsGn0LiGuHfND0jykNSQYit0PFAwmV5
	 A9c+pu98mWkOPK0LQZ+Xb324i6m8HCYM4PsUX6IOl9usq81NBVoYIfSMsAJQpPQTm/
	 Djb18yow738txZN6wuJHhvOJUoscT9bVFElLTUZS4FU1rCTE8s+4kj2CXkGHmiq2oj
	 G7hf2CO8DOciA==
Subject: Re: [PATCH net v4] r8169: don't enable chip LTR when the platform has
 not enabled LTR
From: netdev-bot+sashiko@kernel.org
To: yogeshgaur.83@gmail.com
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, javen_xu@realsil.com.cn
Date: Wed, 16 Sep 2026 13:02:16 +0000
Message-ID: <178956373695.22033.1995661852322501750@kernel.org>
In-Reply-To: <20260914130050.304-1-yogeshgaur.83@gmail.com>
References: <20260914130050.304-1-yogeshgaur.83@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 0

- [Medium] rtl_enable_ltr()
  (drivers/net/ethernet/realtek/r8169_main.c:3038-3050) gates all chip-…
- [Medium] The permanent commit message presents the RTL8125B link-flap
  report as demonstrating the effect of chip LTR programming ("A report…
- [Medium] The patch only *skips* the chip's LTR programming when
  pci_dev->ltr_path is clear (or CONFIG_PCIEASPM=n); it never clears the…

--

r8169: don't enable chip LTR when the platform has not enabled LTR

This makes rtl_enable_ltr() return early unless pci_dev->ltr_path is set,
and return unconditionally when CONFIG_PCIEASPM=n, so the MAC's LTR
generation bits are no longer programmed on hierarchies where the PCI core
did not record an LTR path.

A couple of questions on the commit message and on the shape of the gate.

> The only gate is tp->aspm_manageable, which records that the OS is allowed
> to control ASPM. It says nothing about LTR. LTR is a separate PCIe
> capability that only works if every device on the path to the root port
> supports it. The PCI core works that out in pci_configure_ltr() and
> records the result in pci_dev->ltr_path; per PCIe r6.0 sec 7.5.3.16 a
> function must not issue LTR messages while LTR Mechanism Enable is clear.
>
> So on a platform whose hierarchy has no LTR path, the driver tells the
> chip to start sending LTR messages nothing will honour, and ties ALDPS -
> the PHY's link-down power saving - to them. A report against RTL8125B
> (rev 05, firmware rtl8125b-2_0.0.2) in a mini PC shows the effect: 291
> link down/up transitions in one eight-hour boot, with repeated downshifts
> to 100Mbps, against four transitions at boot and then a stable link on
> the kernel before the LTR change.

[Severity: Medium]
Should the durable commit text be this definite about causation?  The notes
below the --- separator say "NOT VERIFIED ON HARDWARE. The causal claim
above is reasoned from the register writes" and "Compile-tested only", and
those notes are dropped by git am, so what remains in history is a
confirmed-regression narrative plus a Fixes: tag that invites stable
backporting.

rtl_enable_ltr() programs several things together:

	r8168_mac_ocp_modify(tp, LTR_SNOOP, 0x0000, LTR_SNOOP_EN);
	r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
	...
	r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0000, LINK_SPEED_CHANGE_EN);

and its caller rtl_hw_aspm_clkreq_enable() also sets ASPM_en, ClkReqEn and
the "chip can trigger L1.2" bit, none of which this patch touches.  Can the
register writes alone distinguish LTR message generation from ALDPS or chip
ASPM as the source of the observed flapping?

Also, the patch only changes behaviour where pci_dev->ltr_path is 0.  Is it
established that the reporter's mini PC is such a platform?

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index ec4fc21fa21fb..c305a8f19551d 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -3037,6 +3037,18 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
>  
>  static void rtl_enable_ltr(struct rtl8169_private *tp)
>  {
> +	/* The chip must not issue LTR messages unless LTR is enabled for the
> +	 * whole path up to the root port. pci_configure_ltr() works that out
> +	 * and records the result in pci_dev->ltr_path, which exists only with
> +	 * CONFIG_PCIEASPM; without it the PCI core never enables LTR anywhere.
> +	 */
> +#ifdef CONFIG_PCIEASPM
> +	if (!tp->pci_dev->ltr_path)
> +		return;
> +#else
> +	return;
> +#endif

[Severity: Medium]
Is the #else return; branch correct for platforms where firmware already
enabled LTR?  With CONFIG_PCIEASPM=n, pci_configure_ltr() is the stub in
drivers/pci/pci.h, so firmware-set PCI_EXP_DEVCTL2_LTR_EN bits along the
path are simply left alone.  The CONFIG_PCIEASPM=y implementation treats
that as a supported configuration:

drivers/pci/pcie/aspm.c:pci_configure_ltr() {
	pcie_capability_read_dword(pdev, PCI_EXP_DEVCTL2, &ctl);
	if (ctl & PCI_EXP_DEVCTL2_LTR_EN) {
		if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) {
			pdev->ltr_path = 1;
			return;
		}

		bridge = pci_upstream_bridge(pdev);
		if (bridge && bridge->ltr_path)
			pdev->ltr_path = 1;
	...
}

So does the commit message claim "with CONFIG_PCIEASPM=n the PCI core's
pci_configure_ltr() is a stub and LTR is enabled nowhere" conflate "the
kernel does not enable LTR" with "LTR is not enabled"?

There is a second consequence in the same configuration.  pci_disable_link_state()
is a stub returning 0 in include/linux/pci.h, so tp->aspm_manageable ends up
set and rtl_hw_aspm_clkreq_enable() still takes the enable branch:

	rtl_enable_ltr(tp);		/* now returns immediately */
	switch (tp->mac_version) {
	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
		/* reset ephy tx/rx disable timer */
		r8168_mac_ocp_modify(tp, 0xe094, 0xff00, 0);
		/* chip can trigger L1.2 */
		r8168_mac_ocp_modify(tp, 0xe092, 0x00ff, BIT(2));

Does this leave the MAC armed for L1.2 with the LTR machinery deliberately
left unconfigured on every CONFIG_PCIEASPM=n build?

Would reading the endpoint's own LTR Mechanism Enable bit, which is
available in any Kconfig setting via
pcie_capability_read_dword(tp->pci_dev, PCI_EXP_DEVCTL2, ...), avoid the
need for the blanket #else return; here?

One more note on the comment wording: ltr_path is also left clear when
DEVCAP2 has no LTR bit, when there is no upstream bridge (root-bus or
RC-integrated endpoint), and when firmware owns LTR (!host->native_ltr).
Is "LTR is enabled for the whole path up to the root port" a stronger
statement than what the core actually computes?

[Severity: Medium]
Does this need to clear the chip's LTR bits rather than just skip
programming them?  Grepping r8169_main.c, ALDPS_LTR/ALDPS_LTR_EN,
LTR_SNOOP/LTR_SNOOP_EN, LTR_OBFF_LOCK/LTR_OBFF_LOCK_EN,
LINK_SPEED_CHANGE_EN and COMBO_LTR_EXTEND/COMBO_LTR_EXTEND_EN appear only
in their register definitions and inside rtl_enable_ltr(), and every access
there is a set/OR:

	r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
	RTL_W8(tp, COMBO_LTR_EXTEND, RTL_R8(tp, COMBO_LTR_EXTEND) | COMBO_LTR_EXTEND_EN);
	...
	/* chip can trigger LTR */
	r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0003, LTR_OBFF_LOCK_EN);

There is no rtl_disable_ltr(), and the disable branch of
rtl_hw_aspm_clkreq_enable() clears only 0xe092, ClkReqEn/INT_CFG0_CLKREQEN
and ASPM_en:

		r8168_mac_ocp_modify(tp, 0xe092, 0x00ff, 0);
		...
		rtl_mod_config5(tp, ASPM_en, 0);

If any of those LTR enables is already set when the new early return is
taken (power-on or warm-reboot residue, a boot firmware Realtek driver, or
kexec from a kernel that programmed them), does the MAC keep issuing LTR
messages with LTR Mechanism Enable clear, which is the exact state the
commit message says must not happen?  rtl_hw_reset() only writes ChipCmd
CmdReset:

	static void rtl_hw_reset(struct rtl8169_private *tp)
	{
		RTL_W8(tp, ChipCmd, CmdReset);

		rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
	}

so it is not obvious from the source that those MAC OCP bits come back as 0.

The existing in-tree consumer of ltr_path takes the other approach in
drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c:nbio_v4_3_program_ltr():

	if (adev->pdev->ltr_path)
		data |= BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
	else
		data &= ~BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;

Would an explicit clear of the LTR enables on the !ltr_path path, matching
the driver's own ASPM disable convention, be the more robust shape here?

>  	switch (tp->mac_version) {
>  	case RTL_GIGA_MAC_VER_80:
>  		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914130050.304-1-yogeshgaur.83%40gmail.com
