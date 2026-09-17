Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F8F53FD3C
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652464; cv=none; b=BYTWVBC06G1qr061LEXhBeeJW7BELkc8ckiNqFfmVw+JPAi6b87wwB7WYfB8KDEH0wx9P0RAOI7GV4ElTvnGTVxvhYzcK2Th8sQpYwW6ok/Nyph24BBiUAX4/LOETi/VbdWo2dMFyJ3TgHOgMV8XzdDtyg4vTRdzFo6uxc/Xj9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652464; c=relaxed/simple;
	bh=IJem/yXJMFyhvjOqxJLA8ppqnECz2EfkkOTwg7hDJGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnbDPsWxL0eBXOfW71yPJBM0xom5jgTlzVWi0tGwbtOD639zuzu+hHq0dnCq77ZTaENicjHySAV+UiMD++rLjA21RWOY7BlWDRQvuBA5PQcQbBkF3eOHL/LpVIh6ackgK0R6FCRvdPpi0ZfuR4gRjNKbr8cmVvvopM5RKWiw2co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctT+ntsA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctT+ntsA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789652447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7uoVIuPbjTY+bbp4qvmUX2/sJrv1en7fCu5Hjo/DdM=;
	b=ctT+ntsA+MT/4DsYG/lmH/bMNklJmZ7YuNDA7QIi6W331BK/bhExIntgIFWuclIPFSDr7T
	Si5yNWH/TZ4kNKU/JX1+l9dH+DEGFHdIxLIax1Djff7qR/k4eBf08BDaSp/i0MvuGWpNik
	m8pHbRuKKHRFJhPc7tDwi9KCRIEUSrw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-tYANqAYONdKCAa1FXcGEuQ-1; Thu,
 17 Sep 2026 09:40:45 -0400
X-MC-Unique: tYANqAYONdKCAa1FXcGEuQ-1
X-Mimecast-MFC-AGG-ID: tYANqAYONdKCAa1FXcGEuQ_1789652444
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8E90195DE61;
	Thu, 17 Sep 2026 13:40:43 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 55AED1956089;
	Thu, 17 Sep 2026 13:40:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: yogeshgaur.83@gmail.com
Cc: hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	javen_xu@realsil.com.cn
Subject: Re: [PATCH net v4] r8169: don't enable chip LTR when the platform has not enabled LTR
Date: Thu, 17 Sep 2026 15:40:34 +0200
Message-ID: <20260917134034.251124-1-pabeni@redhat.com>
In-Reply-To: <20260914130050.304-1-yogeshgaur.83@gmail.com>
References: <20260914130050.304-1-yogeshgaur.83@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
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
This is an AI-generated review.

