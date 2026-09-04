Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBD85221FE;
	Fri,  4 Sep 2026 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560730; cv=none; b=pEP20dFHeM4HXqkIz8UA9PhnC1F/8novhpL7edt9Jac5DzrJcVJtiNgCX5IINt7bpsd8BBGn+ZYthZKPejuxGsI8b33QXTwKhMOOCfLwcZCjb1NOKQLGBEPC+yWjQPLhmRyJ1rtTAkskc3JUTwIuCpSwFF+CpucaUaqFr00fa5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560730; c=relaxed/simple;
	bh=OrqWsalKoggloer6fIe43v9WfqO9URoBDYfl+kBLy5I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f5scDfN3RsAYwIacguPal+GbMcNhRuA34vMJPNk+ImtoGXWMPq6YhdmbWrOBm0ZRA8X//a6NE4H/G7w5VWKzsMvQjmr9ktHkX/wAIVOCzmBJGFST46X8C7O4Y4y7xpm7UVAl+Rrr2uTli/ELoCWxjamlt2pMcADqR1o+pLIXDQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7wJyVRs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7wJyVRs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6727A1F00ACF;
	Fri,  4 Sep 2026 22:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560725;
	bh=2tT7CmfqaApBjs+ekyMIteouyeWGCx8GzaJC1TaVJU0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h7wJyVRs8+U6ZeCTukUT78iEhpig61X/T97p81FjBIiSmzv6CuocvF5hNy5ucrlip
	 Bd2T/n6D1Z+zR0MtDqqfo2p0yaO8iHObE5GFqxz5pk1IjgFq49zmgINeZFBg1IoPv7
	 nHny00llOgwbITxSKWDpYrollLmpcz0mUL3Q8A3emV4JMzeXd00BKvRydC5ron2tUP
	 jldaXWpf9IhhmoX8ZHL74Mw6GE2kxVCfSvTu4eOmaFSjxby9BDCBEvhDd3PNfTv8s6
	 yhGlDjYY5sYs0iVFNe1DM3kNzLvUbyaTp1txzDqWxl4oYy0AAMYDNduZUkUsm/Zy6/
	 L2ZW+OizvmE7g==
Subject:
 Re: [PATCH net-next v9 7/7] r8169: fix RTL8116af can not enter s0idle and c10
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, linux@armlinux.org.uk,
 enelsonmoore@gmail.com, daniel@thingy.jp
Date: Fri, 04 Sep 2026 22:25:23 +0000
Message-ID: <178856072395.219967.5123094668587461591@kernel.org>
In-Reply-To: <20260831053745.1197-8-javen_xu@realsil.com.cn>
References: <20260831053745.1197-8-javen_xu@realsil.com.cn>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 1

- [High] The hidden-function power/ASPM programming is never re-applied
  on the runtime-PM resume path, so the bug class the patch claims to…
- [Medium] rtl_lowpower_hidden_functions() unconditionally ORs
  PCI_EXP_LNKCTL_ASPMC (both L0s and L1) and PCI_EXP_LNKCTL_CLKREQ_EN…
- [Medium] rtl_lowpower_hidden_functions() writes PCI_EXP_LNKCTL (force
  ASPM L0s/L1 + CLKREQ_EN) and PCI_PM_CTRL (D3hot + RW1C PME_STATUS) to…
- [Low] Commit message names the wrong config-space accessors.

--

r8169: fix RTL8116af can not enter s0idle and c10

This adds rtl_lowpower_hidden_functions(), which walks functions 2 to 7 of
the NIC's slot and programs their PCIe Link Control and PM Control
registers to enable ASPM and put them into D3hot.  It is called from
rtl_init_one() and rtl8169_resume() when rtl_is_8116af() is true.

A few questions below.

>     Put functions 2 to 7 into D3hot and enable ASPM on their PCIe link control
>     register. Since these functions are hidden, access their configuration
>     space through pci_bus_read_config_dword() / pci_bus_write_config_dword()
>     using the same slot and the target function numbers.

[Severity: Low]
This isn't a bug, but the changelog names accessors that the patch never
calls.  All four config accesses in rtl_lowpower_hidden_functions() are
16-bit:

	pci_bus_read_config_word(bus, devfn, pos + PCI_EXP_LNKCTL, &val);
	pci_bus_write_config_word(bus, devfn, pos + PCI_EXP_LNKCTL, val);
	pci_bus_read_config_word(bus, devfn, pos + PCI_PM_CTRL, &val);
	pci_bus_write_config_word(bus, devfn, pos + PCI_PM_CTRL, val);

Could the description say pci_bus_read_config_word() /
pci_bus_write_config_word() instead?  It may also be worth mentioning that
whether a function is touched at all is decided by
pci_bus_find_capability(), i.e. by walking the capability list of an
un-enumerated function.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 5dbbc3a48c09a..5415ff62a2869 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -3773,6 +3774,41 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
>  	r8168_mac_ocp_modify(tp, 0xe860, 0x0000, 0x0080);
>  }
>  
> +static void rtl_lowpower_hidden_functions(struct pci_dev *pdev)
> +{
> +	unsigned int slot = PCI_SLOT(pdev->devfn);
> +	struct pci_bus *bus = pdev->bus;
> +	int func, pos;
> +	u16 val;
> +
> +	for (func = 2; func < 8; func++) {
> +		unsigned int devfn = PCI_DEVFN(slot, func);
> +
> +		pos = pci_bus_find_capability(bus, devfn, PCI_CAP_ID_EXP);
> +		if (pos) {
> +			pci_bus_read_config_word(bus, devfn, pos + PCI_EXP_LNKCTL, &val);
> +
> +			if (PCI_POSSIBLE_ERROR(val))
> +				continue;
> +
> +			val |= (PCI_EXP_LNKCTL_ASPMC | PCI_EXP_LNKCTL_CLKREQ_EN);
> +			pci_bus_write_config_word(bus, devfn, pos + PCI_EXP_LNKCTL, val);
> +		}

[Severity: Medium]
Should this check PCI_EXP_LNKCAP before setting these bits?  Both ASPM
states plus Clock Power Management are enabled unconditionally, without
reading LNKCAP to see which of L0s/L1 and PCI_EXP_LNKCAP_CLKPM are
advertised.  The ASPM core encodes that rule explicitly:

drivers/pci/pcie/aspm.c:pcie_set_clkpm() {
	if (!link->clkpm_capable || link->clkpm_disable)
		enable = 0;
}

There is also a policy conflict on the same physical link.  rtl_init_one()
does:

	if (rtl_aspm_is_safe(tp)) {
		dev_info(&pdev->dev, "System vendor flags ASPM as safe\n");
		rc = 0;
	} else {
		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);
	}
	tp->aspm_manageable = !rc;

and rtl8169_tx_timeout() can later call
pci_disable_link_state(tp->pci_dev, PCIE_LINK_STATE_L1 |
PCIE_LINK_STATE_L0S).  Neither of those can reach functions 2 to 7, since
pcie_config_aspm_link() and pcie_set_clkpm_nocheck() only walk
linkbus->devices, which contains enumerated pci_devs only.

So can functions 2 to 7 end up with L0s, L1 and CLKREQ# enabled on a link
where the administrator or a blacklist (pcie_aspm=off, sysfs link_state) or
the driver's own workaround asked for ASPM to be off?  aspm.c also notes
that spec sec 7.5.3.7 recommends the same ASPM Control value for all
functions of a multi-function device, which this diverges from.

> +
> +		pos = pci_bus_find_capability(bus, devfn, PCI_CAP_ID_PM);
> +		if (pos) {
> +			pci_bus_read_config_word(bus, devfn, pos + PCI_PM_CTRL, &val);
> +
> +			if (PCI_POSSIBLE_ERROR(val))
> +				continue;
> +
> +			val &= ~PCI_PM_CTRL_STATE_MASK;
> +			val |= (RTL_PM_CTRL_D3HOT | PCI_PM_CTRL_PME_STATUS);
> +			pci_bus_write_config_word(bus, devfn, pos + PCI_PM_CTRL, val);
> +		}
> +	}
> +}

[Severity: Medium]
What guarantees the devfn being written here is really one of the hidden
functions?  The loop derives devfn purely from PCI_SLOT(pdev->devfn), and
never reads PCI_VENDOR_ID, never looks for an existing struct pci_dev (for
example via pci_get_slot()), and never excludes PCI_FUNC(pdev->devfn).

The two guards present do not separate "hidden" from "present and owned by
another driver".  A non-zero pos only says the function answers config
reads, and PCI_POSSIBLE_ERROR(val) looks unreachable, because a
non-responding function already fails the capability walk with hdr_type
0xff:

drivers/pci/pci.c:__pci_bus_find_cap_start() {
	switch (hdr_type) {
	case PCI_HEADER_TYPE_NORMAL:
	case PCI_HEADER_TYPE_BRIDGE:
		return PCI_CAPABILITY_LIST;
	...
	return 0;
}

If some devfn in 2..7 of that slot is an enumerated device bound to another
driver (composed multi-function slots in a guest, for instance), does this
put it into D3hot while the PCI core still believes it is in PCI_D0, so
pci_set_power_state() will not repair the state?  And does the
unconditional PCI_PM_CTRL_PME_STATUS write discard a pending wake event of
a function nobody is tracking?

Related question: if the NIC itself were ever at function 2..7, the call
from rtl8169_resume() would put it into D3hot right before
rtl8169_runtime_resume() touches its registers.  Is that ruled out
somewhere?  The rtl_is_8116af() gate only checks the MAC version and the
MAC-OCP package/hardware IDs, not which PCI function the NIC occupies.

[ ... ]

> @@ -5326,6 +5362,9 @@ static int rtl8169_resume(struct device *device)
>  	/* Some chip versions may truncate packets without this initialization */
>  	rtl_init_rxcfg(tp);
>  
> +	if (rtl_is_8116af(tp))
> +		rtl_lowpower_hidden_functions(tp->pci_dev);
> +
>  	return rtl8169_runtime_resume(device);
>  }

[Severity: High]
Does the runtime-PM resume path need this too?  The only two call sites are
rtl_init_one() and rtl8169_resume(), but rtl8169_runtime_resume() is
registered as a peer callback:

static const struct dev_pm_ops rtl8169_pm_ops = {
	SYSTEM_SLEEP_PM_OPS(rtl8169_suspend, rtl8169_resume)
	RUNTIME_PM_OPS(rtl8169_runtime_suspend, rtl8169_runtime_resume,
		       rtl8169_runtime_idle)
};

and it does not re-apply the hidden-function programming:

static int rtl8169_runtime_resume(struct device *dev)
{
	struct rtl8169_private *tp = dev_get_drvdata(dev);

	rtl_rar_set(tp, tp->dev->dev_addr);
	__rtl8169_set_wol(tp, tp->saved_wolopts);

	if (tp->TxDescArray)
		rtl8169_up(tp);

	netif_device_attach(tp->dev);

	return 0;
}

Runtime suspend is a normal event for this driver: rtl_init_one() arms it
with

	if (pci_dev_run_wake(pdev))
		pm_runtime_put_sync(&pdev->dev);

and rtl_mac_link_down() -> pm_runtime_idle() plus rtl8169_runtime_idle()
schedule it on link down.  If the PCI core places the endpoint in D3cold
(parent bridge powered down), the hidden functions' PMCSR and Link Control
registers return to power-on defaults, D0 with ASPM disabled, and the core
only restores saved config space for enumerated pci_devs.  After that, is
there any path that re-programs functions 2..7?

The same gap seems to apply when the device stays runtime-suspended across
a system sleep (PCI direct_complete), where the core skips
rtl8169_resume() entirely and the device comes back through the runtime
callback.

Since rtl8169_resume() already tail-calls rtl8169_runtime_resume(), would
moving the rtl_is_8116af() call into rtl8169_runtime_resume() cover both
wake paths from a single site?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831053745.1197-1-javen_xu%40realsil.com.cn
