Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810674;
	b=rEgYTCBgDpcLqmjz2+ilUA7kIlNgTNBjCZ+ufcwAWZd4+iBhHDzdEhAGAejA1EDu75cu
	 532wdJ75NTqIZo4TUc7VgMu7TE0VAO7jpDQqyoftNtgDc5vrorLF8ScVSo0QLMM19P78u
	 j4bAiGnJtONvkzHkmSEzz/L2J1/mYnBzR0krnad7pvF61veMefsyySG2Xqzs6hoXkwtGX
	 kZaxWqxNbXlfl3GrE9q5owlq23dcd+yBqcGKfuUGqaKjOBQUW7Diov19UL9eD+ln1w0CG
	 e7dRj2/nxct4PpOR8wm87L0XjRm7U+f7yygZm36B84DacVBWBIuh/F1La8OIP8yrJiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810674;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bQvIDegU+Ei70cEI3udJurYLW6e3mWqJ7u/8qcqyJE8=;
	b=YIlzj0PG4LlHKmENrE4SoayUVjrkNzwMhYFNkLi+ucG0BQg+a+cCU+ewiSDCqKvsjZbx
	 PB+sooCYKkUai/SvOF1i+70TJMQLdaEmeViHzcTf6dou2guIZxOjj508gLt+vMsViShL/
	 ee7RTX1esvyJXfugUk4Or4r4zfeX0k00yimkeysocUGjgSKV+VhqtCxjW6m5Pnlqjd8uw
	 lYYq8rj76yGXAZyEAknqXZLMuZf/AscDFV9Zg/zroRinEy5zbVA7/rk1M317/8vSLN/ff
	 io1MkfuszXmeWK0vir13TEoIEoL8jjJ0MgMo/lUcEvlBd6+nXjbzs1E4LYOjYnP40ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c/2xBfda";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6F5606A329
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c/2xBfda
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9F31F000C1;
	Wed,  4 Nov 2026 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810674;
	bh=bQvIDegU+Ei70cEI3udJurYLW6e3mWqJ7u/8qcqyJE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=c/2xBfdaGBLrIZLTzTRRV+621+fS6sxissQ6IyXDuqGkDZk1caF40hjAYoZ3zCPyD
	 BtsWAWES2CqNm1d7eHkAiuIED17n6H1pQVEWXOu7kv2UgUrdccjeJ/znFm91rY93XW
	 V6osZXhH6VaCR2iLA98bAROLgdaBlpv6ig2A6uo86jKWmKusvRLT4Eoo+9o5dPRdeP
	 RxjkYpTUelw+0e9t/Dwh70EqG2l7IDNo30GqWNPZaFh4wDszLE8O2phq8ed4LQ7FeD
	 ZfaDVdNmYY2N/GZRVwVuqCXvI5L/dksaztAnPbeTZSGfcyW1GjjozziGt5uhDWNcAb
	 VPKtP4kaPB1Zg==
Date: Wed, 4 Nov 2026 10:44:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Li, Yifan2" <yifan2.li@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"Ruinskiy, Dima" <dima.ruinskiy@intel.com>,
	"Li, Lili" <lili.li@intel.com>, "Wang, Jie" <jie.wang@intel.com>
Subject: Re: [PATCH iwl-net] igc: Disable PTM after the last device reset on
 remove
Message-ID: <20261104164432.GA1216460@bhelgaas>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN7PR11MB170846508FFD9A89461965524FAF682@MN7PR11MB170846.namprd11.prod.outlook.com>

On Wed, Nov 04, 2026 at 02:22:40PM +0000, Li, Yifan2 wrote:
> On Mon, Nov 02, 2026, Bjorn Helgaas wrote:
> > On Sat, Oct 31, 2026 at 10:19:28AM +0800, Li Yifan wrote:
> ...

> > > Reset the device while the upstream port still has PTM enabled,
> > > so that the PTM Request gets a response. Then disable PTM and
> > > bus mastering. With this order, a later reset sends no PTM
> > > Request (tested on I226-LM). igc_ptp_stop() has already cleared
> > > IGC_PTP_ENABLED, so no new PTM dialog starts after this reset.
> > 
> > IGC_PTP_ENABLED is just a software flag, and it appears to be
> > related to PTP, not directly related to PTM, so there are some
> > dots missing between it and hardware PTM messages.
> 
> Sorry, I skipped steps. In igc, PTM is used only for PTP cross
> timestamps. The driver starts PTM dialogs only from the PTP code, by
> setting the TRIG bit in PTM_CTRL:
> - igc_ptp_reset() sets PTM_CTRL.EN and triggers the first dialog.
> - igc_ptp_getcrosststamp() triggers dialogs for each cross timestamp
>   request.
> 
> igc_ptp_stop() runs before the reset and stops both:
> 1. igc_ptp_suspend() -> igc_ptm_stop() clears PTM_CTRL.EN.
> 2. ptp_clock_unregister() removes the PHC and waits for the
>    getcrosststamp() calls in progress, so no more calls come.
> 3. It clears IGC_PTP_ENABLED. igc_reset() calls igc_ptp_reset(),
>    which returns early when this flag is clear, so the reset path does
>    not set PTM_CTRL.EN again.
> 
> So IGC_PTP_ENABLED does not control the hardware directly. It only
> stops the driver from setting PTM_CTRL.EN again. v2 will describe
> these steps.

I don't think the PCIe spec includes any generic way to trigger PTM
dialogs, and in general, I think devices are permitted to initiate
them at any time, independent of driver or other events.  So I think
igc has device-specific knowledge that the NIC *only* initiates PTM
dialogs when a driver sets the TRIG bit.  If so, I think that's worth
a mention.

I haven't worked through the steps you outlined, but maybe they
explain why there's no PTM Request after the later reset.

> > > If the interface is down,
> > > unregister_netdev() does not reset the device, so reset it explicitly.
> > > PTM is still disabled before bus mastering, as the related fix above
> > > requires.
> > 
> > Which fix requires PTM disable before bus mastering disable?  And
> > why is that required?
> 
> c080fe262f9e. Its commit message says: "Avoid an i225/i226 hardware
> issue that PTM requests can be made even though PCI bus mastering is
> not enabled. These unexpected PTM requests can crash some systems."
> The order is a workaround for that I225/I226 hardware issue, not a
> PCIe spec requirement. The commit message does not say more about
> why the order matters, but when I checked with the hardware team, I
> found an internal erratum for that issue.
> 
> I found c080fe262f9e when I searched the igc history for this PTM
> problem. Our issue is different: after the device has done a PTM
> dialog, the next CTRL.RST can make it send a PTM Request, even when
> PTM Enable is clear.

I think that part of the c080fe262f9e commit log is just wrong.  The
fact that i225/i226 can make PTM requests when bus mastering is
disabled is perfectly fine; it's not a hardware issue.  I *suspect*
that only the pci_disable_ptm() in that commit is actually required.

> > > Skip the reset if the device cannot respond: error recovery is in
> > > progress or has failed (pci_channel_offline()), the device is gone
> > > (pci_device_is_present()), or igc_rd32() has already reported "PCIe
> > > link lost" (IGC_REMOVED()). Otherwise the reset accesses a device in
> > > error recovery, or polls all-ones register values for about two
> > > seconds until igc_disable_pcie_master() times out.
> > >
> > > Call pci_disable_ptm() only if PTM is enabled. pci_enable_ptm() can
> > > fail in probe, for example if the upstream port does not support PTM,
> > > and probe continues without PTM. The PCI/PTM change above also made
> > > pci_disable_ptm() use a reference count: it decrements
> > > dev->ptm_enable_cnt without a check, and then does the same for the
> > > upstream port. Before, it did nothing if PTM was not enabled. After a
> > > failed pci_enable_ptm(), the count of the device becomes negative and
> > > stays negative after the driver unbinds. pcie_ptm_enabled() returns
> > > true for a negative count, so after the next probe
> > > igc_is_crosststamp_supported() reports PTM support and igc_ptp_reset()
> > > starts PTM cycles on a device that does not have PTM enabled. Commit
> > > 650f197d8ea6 ("idpf: disable PTM on probe failure and on remove") adds
> > > the same check to idpf.
> > 
> > This sounds like a bug in the PCI core PTM support, i.e., maybe
> > pci_disable_ptm() should be checking for PTM being enabled?
> > Otherwise I'm afraid lots of drivers might trip over this.
> 
> Agree and thanks! I sent a PCI core fix:
> https://lore.kernel.org/r/20261104121457.2108515-1-yifan2.li@intel.com

Thanks for that!

Bjorn
