Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1E73ADBB4;
	Thu, 10 Sep 2026 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038498; cv=none; b=gF1VUPQ8u0MouGau+m5rfhObLCZhn9/rOm6cOJE6NVpwlPULM00w+PAazFZk8Ov5Hzk5y1mrfSyuPzY86TMXZhNkSEmHfB+19I8pewNFviNGB1YroaOkXN6P5B7osbjmll+c2x/6rhWzjJxxM9N0rgMuAVqaQCvUrgiAxqKR3QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038498; c=relaxed/simple;
	bh=lvVwZT5G2DPI26FlTvfYulAsJOceRRV/6N9/zikzNxg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ln23b3nnMzNDA0cjFkh5VVHwGPzkVrkWeJj2aRCnsq5prMXZHBlelXPq3ex80U0uEjDO19kfwvUskv6cbmIKqOt1fFfV/v7Y+87twk7DN5Q65N5vITKrv138gET3mLV2WqKCPTD14j3Nrd8IB/9hbOFUwl/j7yeYSTuU1k8kPYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDm9souj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDm9souj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE351F000FF;
	Thu, 10 Sep 2026 11:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038496;
	bh=UtBkBjD4fGqm+D0lgDokxYy+g0WlGmIHBZgTasitzQ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SDm9soujF+lthd6lr2IVDFbJtAFG7AE7dXc/s7MeSEH9gFoS5k/GD+UkH2Jjvzpuo
	 FqgFe5UeMmBD8H8HN1FcusDB+CDUL8GK0glFoHKMgThz302lFEA1EFHCmh67KEQ0o3
	 LmPO3op/1nW+qcb3QCw+V3TzLXONev2dtWNLeQnAY3HodbxEE+iA7yHhjg+yn5TsJx
	 eIMNeXPLTu39g/V6C64wvIw0o/cPe2sfpk3zJu4jQk1mLo+BZje1vY8If6qtQHvBe/
	 ubgLesNm1W83H4iUEleZOZvteyqEXjFblQfv4qjY4oWTp9O1KloL+vO246JQiAf8Ym
	 KLybYZZ2KudJg==
Subject: Re: [PATCH net] r8169: don't enable chip LTR when the platform has
 not enabled LTR
From: netdev-bot+sashiko@kernel.org
To: yogeshgaur.83@gmail.com
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, javen_xu@realsil.com.cn
Date: Thu, 10 Sep 2026 11:08:15 +0000
Message-ID: <178903849584.219967.12066474820054965044@kernel.org>
In-Reply-To: <20260909110554.1977-1-yogeshgaur.83@gmail.com>
References: <20260909110554.1977-1-yogeshgaur.83@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 0

- [High] rtl_enable_ltr()
  (drivers/net/ethernet/realtek/r8169_main.c:3038-3048) gates all chip…
- [Medium] The new gate only skips *programming* the chip's LTR
  machinery; nothing ever programs it to the off state.

--

r8169: don't enable chip LTR when the platform has not enabled LTR

This adds a check in rtl_enable_ltr() that reads the endpoint's
PCI_EXP_DEVCTL2 register and returns early when PCI_EXP_DEVCTL2_LTR_EN is
clear, so the chip's LTR machinery is not programmed on hierarchies where
LTR was not enabled.

Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2529752

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index ec4fc21fa21f..c1ff4e898570 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -3037,6 +3037,16 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
>  
>  static void rtl_enable_ltr(struct rtl8169_private *tp)
>  {
> +	u16 ctl2;
> +
> +	/* The chip must not issue LTR messages unless the platform enabled
> +	 * LTR on the whole path up to the root port. The PCI core discovers
> +	 * that in pci_configure_ltr() and reflects it in LTR Mechanism Enable.
> +	 */
> +	pcie_capability_read_word(tp->pci_dev, PCI_EXP_DEVCTL2, &ctl2);
> +	if (!(ctl2 & PCI_EXP_DEVCTL2_LTR_EN))
> +		return;

[Severity: High]
Is the endpoint's LTR Mechanism Enable bit really what the PCI core uses to
reflect an end-to-end LTR path?

Looking at pci_configure_ltr() in drivers/pci/pcie/aspm.c, when the bit is
already set (for example by firmware), the core leaves it alone and only sets
the path flag if the upstream bridge already has one:

	pcie_capability_read_dword(pdev, PCI_EXP_DEVCTL2, &ctl);
	if (ctl & PCI_EXP_DEVCTL2_LTR_EN) {
		if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) {
			pdev->ltr_path = 1;
			return;
		}

		bridge = pci_upstream_bridge(pdev);
		if (bridge && bridge->ltr_path)
			pdev->ltr_path = 1;

		return;
	}

So on a machine where firmware set LTR_EN on the r8169 function but the
hierarchy above it has no LTR path, the function returns with LTR_EN still set
and pdev->ltr_path left at 0.

The whole-path result appears to live in pci_dev::ltr_path in
include/linux/pci.h instead:

	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
					   supported from root to here */

and aspm.c uses that field, not DEVCTL2, when deciding L1.2 is unusable:

	if (!child->ltr_path)
		child_l1ss_cap &= ~PCI_L1SS_CAP_ASPM_L1_2;

If that reading is right, then on the platform class described in the changelog
the new test passes, rtl_hw_start() -> rtl_hw_aspm_clkreq_enable(tp, true) ->
rtl_enable_ltr() still programs ALDPS_LTR_EN, LTR_SNOOP_EN,
LINK_SPEED_CHANGE_EN and finally LTR_OBFF_LOCK_EN, and the chip is still let to
trigger L1.2. Does the link-flap case the changelog reports stay reachable
in that configuration?

There is also the CONFIG_PCIEASPM=n build, where pci_configure_ltr() is an
empty stub in drivers/pci/pci.h while pci_disable_link_state() is a stub
returning 0, so tp->aspm_manageable stays 1 and rtl_enable_ltr() still runs.
In that build no path discovery has happened at all - is testing the bit
meaningful there, or is it just leftover firmware state?

Alongside that, could the comment and the commit message be adjusted? The
comment states the core "reflects it in LTR Mechanism Enable", and the changelog
says the core "records the result by setting LTR Mechanism Enable in the
endpoint's Device Control 2 register", which does not hold for the
firmware-already-set case shown above.

[Severity: Medium]
This early return skips the programming, but does anything ever program the
chip's LTR bits to the off state?

Grepping r8169_main.c, ALDPS_LTR_EN, LTR_SNOOP_EN, LTR_OBFF_LOCK_EN,
LINK_SPEED_CHANGE_EN and COMBO_LTR_EXTEND_EN only ever appear in set
operations inside rtl_enable_ltr():

	r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
	RTL_W8(tp, COMBO_LTR_EXTEND, RTL_R8(tp, COMBO_LTR_EXTEND) | COMBO_LTR_EXTEND_EN);

The disable branch of rtl_hw_aspm_clkreq_enable() clears only 0xe092,
ClkReqEn/INT_CFG0_CLKREQEN and ASPM_en, so those LTR bits stay armed.

If they were armed earlier and rtl_enable_ltr() later takes the new early
return - say a pre-boot UEFI Realtek driver configured ASPM plus LTR, or an
earlier call ran while LTR_EN read as set and the bit was cleared afterwards,
with rtl_reset_work() -> rtl_hw_start() re-entering this path on the same
device - does the chip keep emitting LTR messages with LTR Mechanism Enable
clear and ALDPS still tied to them?

Would writing the off values for those bits when the platform has not enabled
LTR be more robust than skipping the writes, so the driver's view and the
chip's state cannot diverge?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909110554.1977-1-yogeshgaur.83%40gmail.com
