Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922272;
	b=dRShv5VuwVBeebFrJilA6YuIdpAEPsULeMHa+pYC+lamNDiilQJPZ2v7Djz7w+3GvWdJ
	 ub0HAUhKhP1j+BCwOiJ63Ng9NNeKEcCYRWb6UL3So0EUVViDZejcOdyLn2XoBlBgp7r4E
	 3YpuUF7FWXPiW/tBAEWrDLSGaDlghk+1c5QSml2JkO0Rtex4fU1uxCl51SuERI2kHZjTY
	 L9F/VYip/InMNA2wJkZduB8INnPgFJyOqecgMfwLLMMRWtYASuVJAvnhC2BZkn5WlscVV
	 UKf55odL12scBZTAs5hr7cdzkoiXV/GuVVj2V/hMDw7UwniP02v1OL3vMSi2pVpGg1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922272;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=W+uNQUyXcc+ekvFYQ9xIE0qfkbp7ilJ7NXxuLfb006w=;
	b=uNOUJwJRfmMnrej6ilYtfCVrp8J8TEFjrGks3Tlici9YUGFWoQi022FZsWLKmdINaOrL
	 Jda+NvKH3pO147k6E0MmaRZ75Zih4nLGe1GwUGEHt+T536RIhX+J1IdSrKpljzZhBA/g0
	 JCzhv1p2fEZGXL+D6Hl6OJDL22hFneDYsdwiKXbRwRRGeZj+12po4Stau4wmz8CSNBm0j
	 1GaljQtZbfD/+HZloytzBDM9/h5C0Xq5/tXFcJB3TzAiFuEkO7+iXjMzCq5VNesxr4eYP
	 w/ayyiZZd2JkPKJIHW5+ql5RSJEWOvE3NNoyzJrECrQK0SOKCJyWoxy/lPoIYDSXBNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gbVGAvbB;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF632606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 23:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF632606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gbVGAvbB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793922261; x=1825458261;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=snKNR2nl9AaDmkl2ulsSGrGAiVn+mGHWQlK5yFxTaMg=;
  b=gbVGAvbB35KipKvyomHyv1fDSyw6ZFF+/PdIUf+rlHjIA9cWkicAHVsd
   VNT4eNEcWDC/NFYtz542ckdaM2M7Nkh1qUfmWAQpV3WyjwY9TbPlsjg+b
   xQDvASkOaGviEZuyhCjCMeJlWuMFY8bpDgWumzpfJUQK8sXJ292nAhwjQ
   60ChX93Il3LwqVMhyTAH6hOoa98oBRoMO9YOS3/1PawpLtkiWnpM1WIab
   xvm8ydht11ygyC338++wXy2lvOMAkLgU8QRc6LZLJ7mLKctfNuAcQkSXr
   FmUmg187zu3u/Y0F9xbljWTCnZRBF1spMsHaVYH7KV+zyc1/HQH4qEdV6
   g==;
X-CSE-ConnectionGUID: skjgPMugQ1OQoypGE21M+A==
X-CSE-MsgGUID: 9smQ2kM6Q7KHqB0xnZjfrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2726081"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2726081"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 15:44:20 -0800
X-CSE-ConnectionGUID: nV4uMikZTyWvN89HWVbJnQ==
X-CSE-MsgGUID: hpgmX9uHSOe07DdJQLUnzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7458260"
Received: from vcostago-desk.jf.intel.com (HELO vcostago-desk) ([10.98.24.84])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 15:44:21 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Li, Yifan2" <yifan2.li@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, "Ruinskiy, Dima"
 <dima.ruinskiy@intel.com>, "Li, Lili" <lili.li@intel.com>, "Wang, Jie"
 <jie.wang@intel.com>
Subject: Re: [PATCH iwl-net] igc: Disable PTM after the last device reset on
 remove
In-Reply-To: <20261104164432.GA1216460@bhelgaas>
References: <20261104164432.GA1216460@bhelgaas>
Date: Thu, 05 Nov 2026 15:44:20 -0800
Message-ID: <87ik2avo6j.fsf@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Wed, Nov 04, 2026 at 02:22:40PM +0000, Li, Yifan2 wrote:
>> On Mon, Nov 02, 2026, Bjorn Helgaas wrote:
>> > On Sat, Oct 31, 2026 at 10:19:28AM +0800, Li Yifan wrote:
>> ...
>
>> > > Reset the device while the upstream port still has PTM enabled,
>> > > so that the PTM Request gets a response. Then disable PTM and
>> > > bus mastering. With this order, a later reset sends no PTM
>> > > Request (tested on I226-LM). igc_ptp_stop() has already cleared
>> > > IGC_PTP_ENABLED, so no new PTM dialog starts after this reset.
>> > 
>> > IGC_PTP_ENABLED is just a software flag, and it appears to be
>> > related to PTP, not directly related to PTM, so there are some
>> > dots missing between it and hardware PTM messages.
>> 
>> Sorry, I skipped steps. In igc, PTM is used only for PTP cross
>> timestamps. The driver starts PTM dialogs only from the PTP code, by
>> setting the TRIG bit in PTM_CTRL:
>> - igc_ptp_reset() sets PTM_CTRL.EN and triggers the first dialog.
>> - igc_ptp_getcrosststamp() triggers dialogs for each cross timestamp
>>   request.
>> 
>> igc_ptp_stop() runs before the reset and stops both:
>> 1. igc_ptp_suspend() -> igc_ptm_stop() clears PTM_CTRL.EN.
>> 2. ptp_clock_unregister() removes the PHC and waits for the
>>    getcrosststamp() calls in progress, so no more calls come.
>> 3. It clears IGC_PTP_ENABLED. igc_reset() calls igc_ptp_reset(),
>>    which returns early when this flag is clear, so the reset path does
>>    not set PTM_CTRL.EN again.
>> 
>> So IGC_PTP_ENABLED does not control the hardware directly. It only
>> stops the driver from setting PTM_CTRL.EN again. v2 will describe
>> these steps.
>
> I don't think the PCIe spec includes any generic way to trigger PTM
> dialogs, and in general, I think devices are permitted to initiate
> them at any time, independent of driver or other events.  So I think
> igc has device-specific knowledge that the NIC *only* initiates PTM
> dialogs when a driver sets the TRIG bit.  If so, I think that's worth
> a mention.
>
> I haven't worked through the steps you outlined, but maybe they
> explain why there's no PTM Request after the later reset.
>
>> > > If the interface is down,
>> > > unregister_netdev() does not reset the device, so reset it explicitly.
>> > > PTM is still disabled before bus mastering, as the related fix above
>> > > requires.
>> > 
>> > Which fix requires PTM disable before bus mastering disable?  And
>> > why is that required?
>> 
>> c080fe262f9e. Its commit message says: "Avoid an i225/i226 hardware
>> issue that PTM requests can be made even though PCI bus mastering is
>> not enabled. These unexpected PTM requests can crash some systems."
>> The order is a workaround for that I225/I226 hardware issue, not a
>> PCIe spec requirement. The commit message does not say more about
>> why the order matters, but when I checked with the hardware team, I
>> found an internal erratum for that issue.
>> 
>> I found c080fe262f9e when I searched the igc history for this PTM
>> problem. Our issue is different: after the device has done a PTM
>> dialog, the next CTRL.RST can make it send a PTM Request, even when
>> PTM Enable is clear.
>
> I think that part of the c080fe262f9e commit log is just wrong.  The
> fact that i225/i226 can make PTM requests when bus mastering is
> disabled is perfectly fine; it's not a hardware issue.  I *suspect*
> that only the pci_disable_ptm() in that commit is actually required.
>

Yeah, most probably I should have written that commit message better :-)

From what I remember, the issue was on the other side, even if i225/i226
sending PTM requests when bus mastering is disabled is fine, the side
receiving those requests weren't fine with that. And that caused some
stuck systems. (perhaps I should have focused on this when writing the
commit message)

>> > > Skip the reset if the device cannot respond: error recovery is in
>> > > progress or has failed (pci_channel_offline()), the device is gone
>> > > (pci_device_is_present()), or igc_rd32() has already reported "PCIe
>> > > link lost" (IGC_REMOVED()). Otherwise the reset accesses a device in
>> > > error recovery, or polls all-ones register values for about two
>> > > seconds until igc_disable_pcie_master() times out.
>> > >
>> > > Call pci_disable_ptm() only if PTM is enabled. pci_enable_ptm() can
>> > > fail in probe, for example if the upstream port does not support PTM,
>> > > and probe continues without PTM. The PCI/PTM change above also made
>> > > pci_disable_ptm() use a reference count: it decrements
>> > > dev->ptm_enable_cnt without a check, and then does the same for the
>> > > upstream port. Before, it did nothing if PTM was not enabled. After a
>> > > failed pci_enable_ptm(), the count of the device becomes negative and
>> > > stays negative after the driver unbinds. pcie_ptm_enabled() returns
>> > > true for a negative count, so after the next probe
>> > > igc_is_crosststamp_supported() reports PTM support and igc_ptp_reset()
>> > > starts PTM cycles on a device that does not have PTM enabled. Commit
>> > > 650f197d8ea6 ("idpf: disable PTM on probe failure and on remove") adds
>> > > the same check to idpf.
>> > 
>> > This sounds like a bug in the PCI core PTM support, i.e., maybe
>> > pci_disable_ptm() should be checking for PTM being enabled?
>> > Otherwise I'm afraid lots of drivers might trip over this.
>> 
>> Agree and thanks! I sent a PCI core fix:
>> https://lore.kernel.org/r/20261104121457.2108515-1-yifan2.li@intel.com
>
> Thanks for that!
>
> Bjorn


Cheers,
-- 
Vinicius
