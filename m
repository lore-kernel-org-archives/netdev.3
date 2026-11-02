Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658499;
	b=earpQc92Ianv9nPbEapJS0BGrk57KN2k5MNFkPZvSUaKw/wHl2A9TIgI5D0ZD6AEUUxq
	 pkXmYA43oVQ/Y5RjkpW0zNfPP0pPE3U9c0p2v6/iKYDPefEuodYyI4kLCB0M6jxUUKdXw
	 pbmtuR0MahwP3FI8WzxkcEVYlubG6JWsN+hISosvX0DqoqpZNxcJTTKIm/owDHzZpli3l
	 hJITlj4SwBC4u5iD9jjF4N1MttSOm7q3EFEHFbijxeg/696hoUm0fQQszIzt8gE7PIjqL
	 pMpjlDOddSwZj0LkMGAUdQf3th130CM88CX1Gm+4Rr/QrLmt2g48jLjUetdGHLWe2Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658499;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pLrc6IvsxvZox2frClEyQ8V7DfzXsEUEs896JOGYWfk=;
	b=slGxIJeoM29sJJxM9oEij2+9FGTKL6fvEbgshI+kbxxTKkYftCtub76fkpPxFHaNZjep
	 zvX/5uiyQjZxCaLg5bMv6ORBje1wd1gzrY5Q+N5cjNSuIaNp5HCF1mFa+ocRteDWl3kFN
	 P21ZLZLghLLIMxH1jHXTKfalBsngbegS0EJNR2lktOrsptMI1xWSLzE1L3RckdzSOtd69
	 pR7iu+c5hfPIb5KpnAIl3zhQePdfL5gC+XLwtOZYhepCZd2vorPR+KZ2QpJHW7s0z5Qsw
	 8OvB5eHWjlDPcpr9SDb5DQXTy+pYuDdL7Xg3UqA0Ejxl1GsZAxc1WVGUElVgDdVvYxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0xbMNSR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE0B606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0xbMNSR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBCB1F00A16;
	Mon,  2 Nov 2026 22:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793658499;
	bh=pLrc6IvsxvZox2frClEyQ8V7DfzXsEUEs896JOGYWfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=o0xbMNSROg9/PhI4EqQSPzRQ+s8Ia33KoO6eIdPfjUOpHDY59v0XgycrL12PCpw1X
	 kj+d3U4x/Tm4TBNzOh6yWQeWS/Pwy2uxoAuAU/5Q6msUXdc4M3B1lTsCSZLn3WuLrp
	 /orWGlt8Am0+awWt1D/AbkHLrjI/lq7t/c2QTnKXIQc1Ueykunl7fiamNrNif2r0WS
	 INkafWu1EGLsu43RccLnzsr9iFcwtrxx8giZgrraYSJuBCBjLMMrnMPsQ/qhyRpJ2N
	 BVnXmFWnFuSWmPrtMreyM9huw6xem2KMTsQl5+4009y3i4PZxlgsT23WyBdc+8Mky8
	 iBlvbGMZXo7eg==
Date: Mon, 2 Nov 2026 16:28:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Li Yifan <yifan2.li@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>,
	Li Lili <lili.li@intel.com>, Wang Jie <jie.wang@intel.com>
Subject: Re: [PATCH iwl-net] igc: Disable PTM after the last device reset on
 remove
Message-ID: <20261102222817.GA983941@bhelgaas>
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
In-Reply-To: <20261031021928.1714612-1-yifan2.li@intel.com>

On Sat, Oct 31, 2026 at 10:19:28AM +0800, Li Yifan wrote:
> I225/I226 have a hardware issue: after a PTM dialog, the next device
> reset through the RST bit of the Device Control register (CTRL.RST)

I assume this Device Control is a device-specific register, not the
Device Control in the PCIe Capability, right?

> can make the device send a PTM Request. The device sends it even if
> PTM is disabled in its PTM Control register (PCI config space), the EN
> bit of its PTM_CTRL register (MMIO) is clear

And I guess PTM_CTRL is another device-specific register.  The
architected PTM Enable bit in the PTM Capability in config space is
supposed to be enough to prevent the device from issuing PTM Requests,
so I guess the device-specific control is only relevant because it's
not enough to work around this hardware defect.

> and Bus Master Enable is
> clear, so the driver cannot stop it. Commit c080fe262f9e ("igc: Fix
> possible system crash when loading module") disables PTM before bus
> mastering because of a related issue (PTM Requests with bus mastering
> disabled), but that does not stop the request at CTRL.RST.

c080fe262f9e and this both mention Bus Master Enable, but I don't
think it's relevant to either change.  Bus Master Enable controls
ability to issue Memory and I/O Read/Write Requests.  PTM Requests are
PCIe Messages (not Read/Write Requests) so Bus Master Enable should
not affect them.

If this is a documented erratum, can we include an identifier or a
pointer to it?

> The request is harmless while the upstream port has PTM enabled. Since
> commit e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root
> and Switch Upstream Ports"), pci_disable_ptm() also disables PTM on the
> upstream port when the last user goes away. igc_remove() calls
> pci_disable_ptm() before unregister_netdev(). If the interface is up,
> unregister_netdev() then resets the device through igc_close() ->
> igc_down() -> igc_reset(). The upstream port now handles the PTM
> Request as an Unsupported Request. On an Intel Nova Lake-S system with
> an I226-LM, this triggers DPC on "modprobe -r igc". Recovery fails
> because the driver is unbinding, and the next probe fails:
> 
>   pcieport 0000:80:1d.0: DPC: containment event, status:0x1f01: unmasked uncorrectable error detected
>   pcieport 0000:80:1d.0:    [20] UnsupReq               (First)
>   pcieport 0000:80:1d.0: AER:   TLP Header: 0x34000000 0x81000052 0x00000000 0x00000000
> 
> Message code 0x52 in the TLP header is a PTM Request from 81:00.0.
> 
> Reset the device while the upstream port still has PTM enabled, so
> that the PTM Request gets a response. Then disable PTM and bus
> mastering. With this order, a later reset sends no PTM Request (tested
> on I226-LM). igc_ptp_stop() has already cleared IGC_PTP_ENABLED, so no
> new PTM dialog starts after this reset.

IGC_PTP_ENABLED is just a software flag, and it appears to be related
to PTP, not directly related to PTM, so there are some dots missing
between it and hardware PTM messages.

> If the interface is down,
> unregister_netdev() does not reset the device, so reset it explicitly.
> PTM is still disabled before bus mastering, as the related fix above
> requires.

Which fix requires PTM disable before bus mastering disable?  And why
is that required?

> Skip the reset if the device cannot respond: error recovery is in
> progress or has failed (pci_channel_offline()), the device is gone
> (pci_device_is_present()), or igc_rd32() has already reported "PCIe
> link lost" (IGC_REMOVED()). Otherwise the reset accesses a device in
> error recovery, or polls all-ones register values for about two
> seconds until igc_disable_pcie_master() times out.
> 
> Call pci_disable_ptm() only if PTM is enabled. pci_enable_ptm() can
> fail in probe, for example if the upstream port does not support
> PTM, and probe continues without PTM. The PCI/PTM change above
> also made pci_disable_ptm() use a reference count: it decrements
> dev->ptm_enable_cnt without a check, and then does the same for the
> upstream port. Before, it did nothing if PTM was not enabled. After
> a failed pci_enable_ptm(), the count of the device becomes negative
> and stays negative after the driver unbinds. pcie_ptm_enabled()
> returns true for a negative count, so after the next probe
> igc_is_crosststamp_supported() reports PTM support and igc_ptp_reset()
> starts PTM cycles on a device that does not have PTM enabled. Commit
> 650f197d8ea6 ("idpf: disable PTM on probe failure and on remove")
> adds the same check to idpf.

This sounds like a bug in the PCI core PTM support, i.e., maybe
pci_disable_ptm() should be checking for PTM being enabled?
Otherwise I'm afraid lots of drivers might trip over this.

> Fixes: e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports")
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Co-developed-by: Li Lili <lili.li@intel.com>
> Signed-off-by: Li Lili <lili.li@intel.com>
> Signed-off-by: Li Yifan <yifan2.li@intel.com>
> Tested-by: Wang Jie <jie.wang@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index b8ac2f4fea5a..3ee8b05f0515 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7406,9 +7406,6 @@ static void igc_remove(struct pci_dev *pdev)
>  
>  	igc_ptp_stop(adapter);
>  
> -	pci_disable_ptm(pdev);
> -	pci_clear_master(pdev);
> -
>  	set_bit(__IGC_DOWN, &adapter->state);
>  
>  	timer_delete_sync(&adapter->watchdog_timer);
> @@ -7427,6 +7424,22 @@ static void igc_remove(struct pci_dev *pdev)
>  	igc_release_hw_control(adapter);
>  	unregister_netdev(netdev);
>  
> +	/* After a PTM dialog, I225/I226 can send a PTM Request at the next
> +	 * CTRL.RST, even with PTM and bus mastering disabled on the device.
> +	 * Reset the device while PTM is still enabled on the upstream port,
> +	 * so that the request gets a response. unregister_netdev() resets the
> +	 * device only if the interface was up. Skip the reset if the device
> +	 * cannot respond (error recovery, surprise removal or an earlier
> +	 * "PCIe link lost"). Then disable PTM before bus mastering.
> +	 */
> +	if (!pci_channel_offline(pdev) && pci_device_is_present(pdev) &&
> +	    !IGC_REMOVED(adapter->hw.hw_addr))

All these tests look racy.  .reset_hw() really should be able to
detect and deal with any errors that happen if it tries to access a
device that is no longer responding.

> +		adapter->hw.mac.ops.reset_hw(&adapter->hw);
> +
> +	if (pcie_ptm_enabled(pdev))
> +		pci_disable_ptm(pdev);
> +	pci_clear_master(pdev);

I don't think bus mastering has any connection to PTM, so why are we
moving pci_clear_master()?

>  	igc_clear_interrupt_scheme(adapter);
>  	pci_iounmap(pdev, adapter->io_addr);
>  	pci_release_mem_regions(pdev);
> 
> base-commit: c550c1c9727726dcae121221c252013153fa5945
> -- 
> 2.43.0
> 
