Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9142D486634;
	Wed, 12 Aug 2026 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786569316; cv=pass; b=Nzw9wGTZrSNW+tCuQgxmfsezulDRwdB6sIgdJkLOyGDJyxgFerU01zFlSbfXCILbi8/6b+iunztwc9wx9jUsPi0PiotOEiHfDlA57xsDGJaroHnq2xoqBfMrie1vuK2LxcBeROYP8PsR/Zs/C34y0Ms2znGLV4yJjYEHMuNb0cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786569316; c=relaxed/simple;
	bh=ohbLwvdIHJti+UGNkx3fB1kePNPBy33bhVCWWM8fCtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLo/i/9fbmqyGGlqdkKGhgEycim7Aw/RPAkLuwDHIDNZ6jqaPGGVPaHxYkeRi5mFViRkF15DdLYXApj1rsHkEPqsYPQZnzhxsiQqc/J8DRLFXZSpL6YZKcxc7J1rYDHVnqhp8A9QafR9GXdhySWQYsqDENmj0LlB5RlmztrcHJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=BupUEuKn; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="BupUEuKn"
ARC-Seal: i=1; a=rsa-sha256; t=1786569309; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IpkNhllMrOeY1Ki07ncjthuvxg5TC9XistcaVqxV8L7Z3N4Vjk/jMhBpc1hM+pocC/LjlUaBQ1aZUIGCpizv5+nZkrqhVRflQ4UQ0xnlIjYz7hAcNylPzGfQTIH/2OaVkUTW4CJsKkzgvw14QuP8IHJVCbJZ/uL16HZQLYE+rw0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786569309; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/wP24GqTbgu4Lf+JFa/mUy7/xcr+IkzHGTkcQgelCYU=; 
	b=jtp8Z5aZp/nG7YEbZkf1GdpLUAVjWKu9CPp73aOn4wjPwf6f0aSppkyETACPAXm4l0HOX5Fsqth20lNfaERUrt6ipU0RZgVnVq0hS0jyb2H+uWYPqMgEU3VpRIC0XX3l3SED3Ntm/6Nljme72FJOxKHiSXBn3eUi/0FTeERYl6c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786569309;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=/wP24GqTbgu4Lf+JFa/mUy7/xcr+IkzHGTkcQgelCYU=;
	b=BupUEuKnbgc4OnZZGfawSDk2LJVm0YfHGR4jivFmEoT2LcDHw5QsqY6zRvM3ugwn
	fuAw/tME1vXAenKY0SP9odBCrO++jO45pGrngDd4yCpnGnuc3O48KGEYBe6k0IswkcD
	3WjL4jC7UBJMd4TiZgvg34CVXIbJu1+6sQ/OM/Q8=
Received: by mx.zohomail.com with SMTPS id 1786569307490841.3412014312573;
	Wed, 12 Aug 2026 14:15:07 -0700 (PDT)
Date: Wed, 12 Aug 2026 21:14:56 +0000
From: Yao Zi <me@ziyao.cc>
To: Giuseppe Nespolino <g.nespolino@gmail.com>, Yao Zi <me@ziyao.cc>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: dwmac-motorcomm: RX dies after long s2idle, only wrapper
 SYS_RESET recovers
Message-ID: <anziUH_cC1LXoB1x@pie>
References: <CAKx9m6PywVwkirvkAtz144c-yg71c2+OcNYOTM4Bjtd8dF2PaA@mail.gmail.com>
 <CAKx9m6OsGKGKGxPnjwy8U-bDyvXVEK-dVNmvP0ZqSL-t2Exsgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKx9m6OsGKGKGxPnjwy8U-bDyvXVEK-dVNmvP0ZqSL-t2Exsgg@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/286.560.97
X-ZohoMailClient: External

On Wed, Aug 12, 2026 at 05:02:49PM +0200, Giuseppe Nespolino wrote:
> Answering my own question, since it turned out to be testable without a
> suspend at all.
> 
> On a healthy interface, writing 0 to OOB_WOL_CTRL (BAR0+0x1010) - clearing
> the DIS bit, i.e. enabling OOB WOL - kills RX within a second:
> 
>   OOB=1 (healthy)                      ping   0% loss, rx-0 irq +39,
> rx_packets +49
>   OOB=0                                ping 100% loss, rx-0 irq  +0,
> rx_packets  +0
>   OOB=1 again                          ping 100% loss, rx-0 irq  +0,
> rx_packets  +0
>   SYS_RESET + init + ip link down/up   ping   0% loss, rx-0 irq +35,
> rx_packets +41
> 
> So the DIS bit is one-way: writing it back reads 1 but does not disarm an
> engine that already armed. Only the SYS_RESET recovers. That's a one-writel
> reproducer of the symptom, no suspend needed.

This is quite unexpected. I found enabling OOB_WOL_CTRL blocks DMA
interrupts because it's the default state after resetting, without
clearing it, the MAC is non-operational.

> It also explains why nothing driver-side helps after resume:
> motorcomm_init() writes OOB_WOL_CTRL_DIS, the register reads 1, and it's a
> no-op because the engine is already armed. Only the probe's
> motorcomm_reset() tears it down.

This makes sense.

> Possible trigger: stmmac_pci_plat_suspend() calls
> pci_wake_from_d3(pdev, true) unconditionally, even when WoL is off.

Have you tested the idea? We always call pci_wake_from_d3(pdev, true) but
from your description, broken RX only happens after s2idle is active for
some time, right?

> Caveat, because the two states are not identical: with OOB WOL enabled by
> hand, CH0_STATUS reads 0x0 - fully quiesced, no events latched. In the
> natural post-resume failure it was 0x4c5 with RI/RBU latched and packets
> still landing in memory (RX descriptor OWN count dropping 512 -> 467). So
> this proves OOB WOL blocks interrupt delivery and that the DIS bit is
> irreversible, but not yet that OOB WOL is what arms across s2idle. I'll
> check whether the engine is armed on the next natural occurrence.

From my own testing, with OOB WOL enabled, both DMA TX and RX interrupts
aren't delivered. So TX behavior when RX is broken might indicate what
has happened.

> Given this, the fix is probably narrower than what I suggested: either
> don't enable PCI wake when WoL is off, or disarm OOB WOL properly on
> resume - and if a reset is the only way to disarm it, that at least gives
> the reset a documented reason. Tell me which direction you prefer and
> I'll send a patch.

I prefer the later, even disabling PCI wake works, we'll probably
re-visit this when adding WoL support. Sadly I took a brief look across
vendor's driver, and think there's no other way to disarm the OOB WOL.
Performing a SYS_RESET might be okay since the stmmac core restores
necessary hardware states.

Anyway, please try figuring out state of the DIS bit when the problem
occurs before sending the patch, which would be a strong reason to
perform a reset in the resume hook.

Best regards,
Yao Zi

> Giuseppe
> 
> Il giorno mer 12 ago 2026 alle ore 16:50 Giuseppe Nespolino
> <g.nespolino@gmail.com> ha scritto:
> >
> > Hi Yao,
> >
> > On a Slimbook EVO15-A8 (YT6801, 1f0a:6801, kernel 7.0.0-28 Ubuntu)
> > enp2s0 stops receiving after a long s2idle. 18-25 minutes reproduces
> > it; 5s and 30s cycles never did.
> > Link comes up at 1Gbps and the resume path logs nothing unusual.
> >
> > Measured while broken:
> >
> > - MAC is receiving: mmc_rx_framecount_gb climbing,
> > mmc_rx_fifo_overflow 2585. netdev rx_packets and the rx-0 MSI-X count
> > frozen.
> > - MSIX_PBA (BAR0+0x1300) = 0, so the device isn't asserting anything.
> > - CH0_STATUS = 0x4c5: RI/RBU/TI/TBU latched, NIS and AIS clear, with
> > NIE/AIE set in CH0_INTR_ENA (0xd041).
> > - All 512 RX descriptors in writeback format with sane lengths
> > (64-1518), OWN=0. The DMA received them; nothing ever consumed them.
> >
> > Event bits latch and clear fine (W1C works, MGMT_INT_CTRL0 tracks it
> > as a mirror), but the summary stage never asserts and no MSI-X is
> > generated. RBU, the full ring and the FIFO overflow are all downstream
> > of that.
> >
> > Ruled out with data: ASPM/remapping (PBA=0, MSI-X table intact, zero
> > IOMMU faults), wrapper registers lost across D3 (all identical to a
> > healthy baseline), unarmed ring, and MGMT_INT_CTRL0 needing an ack
> > (status field is read-only).
> >
> > What recovers it: toggling SYS_RESET (0x152c bit31) plus
> > motorcomm_init(), then ip link down/up. down/up alone does not - rings
> > get rebuilt, IRQs re-requested, packets land in memory, still zero
> > interrupts. I haven't yet isolated the reset from motorcomm_init().
> >
> > Which brings me to the question, since you know the chip: does
> > clearing OOB_WOL_CTRL_DIS actually disarm an OOB WOL engine that
> > already armed, or does that need the SYS_RESET? Your comment says OOB
> > WOL blocks DMA interrupt
> > delivery, which is exactly the symptom, and stmmac_pci_plat_suspend()
> > enables PCI wake unconditionally even with WoL off - it is off here.
> >
> > I have a candidate fix (do the full motorcomm_reset() in
> > motorcomm_resume() instead of only deasserting the MDIO/PHY reset) and
> > I'm happy to send it, but if OOB WOL is the mechanism the right patch
> > is probably narrower. Caveat: I validated reset + full open, not reset
> > + the stmmac_resume path, so a patched module still needs testing.
> >
> > Happy to run any experiment on this hardware.
> >
> > Giuseppe
