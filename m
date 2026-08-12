Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52EE46EC64
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546989; cv=pass; b=kPpzCmGEc/glYGrWDQWAdVhlNaqhvOoAEmNMYmtmARzG4NBzRcfSTT2rUUfNZld/cOhsFdejecp2lEHQjoQuA/4Ubrf/AnHaT+CA7WObmjvl5ZgbRASAFOuaejNuoGaIO/luhv+V6jNy+L/K0iuWtpEeVz6kiCL+YOpL0PVWebc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546989; c=relaxed/simple;
	bh=6TNPsPZ6Yu3+5VzxO9+Hm2dpinGJgEKNgWJQBP5BdqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAGIpn92VT/zcOrfXDAKIrwYIxdR9rrOp+feqGxno0cNAztnFLbIvATmmdMojpqB6ngm4Qn/lzesznv5p7frWYlXKtFnRJVA6ibwGgcMxL8QErb9hKldeRAwp6nvEGyGB1WpGUZVFxZ5Hc4dVcVLdmpnzAdqsHP5tOJAzW1I1gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDOP6bHt; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDOP6bHt"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-480033bdcf4so619875f8f.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 08:03:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786546982; cv=none;
        d=google.com; s=arc-20260327;
        b=n60kzzJikN/LT+QIC3s+Ds2WtzKZ/CauXRgu2yU3WtuJShN+17eJU+z31MeflqD9ix
         n1udqedQseHi+w4M8W7al8jik2ium0pnWtlw6EXjQahU0jEIteEtyV8WMNHl0LpH25H4
         I2Rx/CfZxHt1JVqmNyVPvjFl8rliuCPSfhak+IsuoaYnOqNXJDuleoc7TfDcPG5Xm6la
         4zlhviPWiEtKLFAag2AzwdSux4mREua95LZA+CCRsIbDBL8v0vhX0G5jTEV4sKkMY4U2
         cW/FXvMu7/dVWthpVgjiOhy9wLw1egXE3kSOGibMnRI1DWVIwbx2tS/x8S1Rl/ooPnr2
         K+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NKfgjZTCaXMPCDDA29s0W4zHdpmk7IHctSyL852pY0s=;
        fh=GJDOkJGMPhVedBW4znRBBLZnIkPYpiu96hIit20RvTE=;
        b=EeCE8UjuxfRn0fz0JK/SFGbc0rGXZEaqjwbX5SS/8cqvVbN6amNSgYVOVvvsnFLRwP
         W1hcVujKp0CSKfP/pBHbDOH3XW+1w3KuGU2LXwxAmpY6VXH1OutP+6VUiVgL1RH/2ZPg
         yE3d48s7WYvcLPJiXNJI6zyWe5kiM4npoRuDlhBGqIVtl+az/+2fA6Wz7uPeuqivBDJ/
         Nb7nkCy1a2bPk7Zv2qa39azS/MU/813RASZau1KaUGiFJGB4NCW2F2hQRCUhoctalKgy
         bZsmrMQBBFE8ftI/hSeYCijGxX9ee2hVswDcEEXBBugKXMftYBFYxjCSjDs8m5ectXAX
         9YeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786546982; x=1787151782; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NKfgjZTCaXMPCDDA29s0W4zHdpmk7IHctSyL852pY0s=;
        b=GDOP6bHt4wpLR4lCsN7BTB9ZZxe/7uzbznS2MwNEJpStClhRpQRm5TuQ9hk3d1d6y0
         RNRdILIeKXWrkMmHSDEd7g8N2u5eNEfg+UG+2PFUziMMbKphPAh7qQxRLljbLdBHosZO
         hnR+IdQA1RgPKT+iRrwKkQqJwu/yWwIRMO4KZy7er/D44xLhhY+bx+8UlZQRBJVGx/0E
         oSQFDM7dzD8aM782nAY6B+8iloYnYbA06PLawVOjPMAGlIBdnC/PDe5vlmU8DZyYvPmC
         z6AKhXxBHyAFf2v1hFyQ/+EXhuW7p28zEeH7d+9AzT7lVwzxra4+CHC7Lud2W1G//+ND
         /VdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786546982; x=1787151782;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NKfgjZTCaXMPCDDA29s0W4zHdpmk7IHctSyL852pY0s=;
        b=O2MgdmQbKiqTqkmijUN9tU7SIBazY6F4jEfx2nlkU1z8U8k6Gygzr0RH8vyZMPlBO7
         DS+4PXbbJnrepja6NK6NfQBpO6B+obR75dcO7K+hbds7wEnd2j4vL7DWhqqR3FH6cG1/
         ZtitCG6CJ7xFhqT3a3r+rmS+/eaGcwZVynBE765GDEkMkjqaRPU/oMsszJhlgvwDiCut
         WogSWl//ftPSaEdNTLuYdFUMTjsr4ggWNPRYcFSin4hORdMEpHE6ViqRDh2Qg5MMjNYq
         RaMbIGNMw/L/rJKSufEo+u4EA0zNa/d2zjJ63o7TQtKGki4inn3DpPSmU6mJSWmV+HDG
         qeng==
X-Gm-Message-State: AOJu0YxY6XCq7uhgsTgCqTLmvD/ASygNiBQXqkDWVkkfahjS4UUlV5uE
	ABj6As+Ji5GLiHa0+XBB/mq5pXBw6hTcI75LLoZZzwgkt2m5gYDwIWcys2US3Wx2kkS9JsxD+ni
	D1bQYHRl5z0t5pck8gXk3rtUw+C93Zt/w229g8xg=
X-Gm-Gg: AR+sD13o8g3xggl8SQTlYm6kO9Kqk8IuJp9MVadkr0v1/ND5YJMpz/jmG9eaTp5qAJ9
	txed4v1Q+3rEOjjrOmQLqOHc3QGRNeN70aQdpTbx7YoNcm/fqfIEyC/RBx9qfA5beWRZd/DtyD0
	LV0ENdEwgg3nVMnxSXyfm9gZ16CkbKpllu0blFq51P8e4IfkX1Nww8jB51kStT0xjdQYZkTQt4U
	+Lx+i6zmkR1CaZZi61khnXrENAgVy8d8ahg9UBPOb/lUXuiy3Cv0g4Iu1Wl9Eut3xlPoxPPRF+p
	I/w0a3ia1ZL/oRG4b3zt6VWfoDPOft/v8ozDukGiC8/9t+Ei29CoJSO1RjBu8x4vVzAn4WMYCLs
	=
X-Received: by 2002:a05:6000:4281:b0:47f:e76a:e8cc with SMTP id
 ffacd0b85a97d-48152b0ef26mr7584890f8f.22.1786546981310; Wed, 12 Aug 2026
 08:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKx9m6PywVwkirvkAtz144c-yg71c2+OcNYOTM4Bjtd8dF2PaA@mail.gmail.com>
In-Reply-To: <CAKx9m6PywVwkirvkAtz144c-yg71c2+OcNYOTM4Bjtd8dF2PaA@mail.gmail.com>
From: Giuseppe Nespolino <g.nespolino@gmail.com>
Date: Wed, 12 Aug 2026 17:02:49 +0200
X-Gm-Features: AUfX_mz2C-5bPIoXzetjqxxkpXSVWz1IGodffh-i5OTJXRMcRw8fdAr0ppjxlRM
Message-ID: <CAKx9m6OsGKGKGxPnjwy8U-bDyvXVEK-dVNmvP0ZqSL-t2Exsgg@mail.gmail.com>
Subject: Re: dwmac-motorcomm: RX dies after long s2idle, only wrapper
 SYS_RESET recovers
To: Yao Zi <me@ziyao.cc>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Answering my own question, since it turned out to be testable without a
suspend at all.

On a healthy interface, writing 0 to OOB_WOL_CTRL (BAR0+0x1010) - clearing
the DIS bit, i.e. enabling OOB WOL - kills RX within a second:

  OOB=1 (healthy)                      ping   0% loss, rx-0 irq +39,
rx_packets +49
  OOB=0                                ping 100% loss, rx-0 irq  +0,
rx_packets  +0
  OOB=1 again                          ping 100% loss, rx-0 irq  +0,
rx_packets  +0
  SYS_RESET + init + ip link down/up   ping   0% loss, rx-0 irq +35,
rx_packets +41

So the DIS bit is one-way: writing it back reads 1 but does not disarm an
engine that already armed. Only the SYS_RESET recovers. That's a one-writel
reproducer of the symptom, no suspend needed.

It also explains why nothing driver-side helps after resume:
motorcomm_init() writes OOB_WOL_CTRL_DIS, the register reads 1, and it's a
no-op because the engine is already armed. Only the probe's
motorcomm_reset() tears it down.

Possible trigger: stmmac_pci_plat_suspend() calls
pci_wake_from_d3(pdev, true) unconditionally, even when WoL is off.

Caveat, because the two states are not identical: with OOB WOL enabled by
hand, CH0_STATUS reads 0x0 - fully quiesced, no events latched. In the
natural post-resume failure it was 0x4c5 with RI/RBU latched and packets
still landing in memory (RX descriptor OWN count dropping 512 -> 467). So
this proves OOB WOL blocks interrupt delivery and that the DIS bit is
irreversible, but not yet that OOB WOL is what arms across s2idle. I'll
check whether the engine is armed on the next natural occurrence.

Given this, the fix is probably narrower than what I suggested: either
don't enable PCI wake when WoL is off, or disarm OOB WOL properly on
resume - and if a reset is the only way to disarm it, that at least gives
the reset a documented reason. Tell me which direction you prefer and
I'll send a patch.

Giuseppe

Il giorno mer 12 ago 2026 alle ore 16:50 Giuseppe Nespolino
<g.nespolino@gmail.com> ha scritto:
>
> Hi Yao,
>
> On a Slimbook EVO15-A8 (YT6801, 1f0a:6801, kernel 7.0.0-28 Ubuntu)
> enp2s0 stops receiving after a long s2idle. 18-25 minutes reproduces
> it; 5s and 30s cycles never did.
> Link comes up at 1Gbps and the resume path logs nothing unusual.
>
> Measured while broken:
>
> - MAC is receiving: mmc_rx_framecount_gb climbing,
> mmc_rx_fifo_overflow 2585. netdev rx_packets and the rx-0 MSI-X count
> frozen.
> - MSIX_PBA (BAR0+0x1300) = 0, so the device isn't asserting anything.
> - CH0_STATUS = 0x4c5: RI/RBU/TI/TBU latched, NIS and AIS clear, with
> NIE/AIE set in CH0_INTR_ENA (0xd041).
> - All 512 RX descriptors in writeback format with sane lengths
> (64-1518), OWN=0. The DMA received them; nothing ever consumed them.
>
> Event bits latch and clear fine (W1C works, MGMT_INT_CTRL0 tracks it
> as a mirror), but the summary stage never asserts and no MSI-X is
> generated. RBU, the full ring and the FIFO overflow are all downstream
> of that.
>
> Ruled out with data: ASPM/remapping (PBA=0, MSI-X table intact, zero
> IOMMU faults), wrapper registers lost across D3 (all identical to a
> healthy baseline), unarmed ring, and MGMT_INT_CTRL0 needing an ack
> (status field is read-only).
>
> What recovers it: toggling SYS_RESET (0x152c bit31) plus
> motorcomm_init(), then ip link down/up. down/up alone does not - rings
> get rebuilt, IRQs re-requested, packets land in memory, still zero
> interrupts. I haven't yet isolated the reset from motorcomm_init().
>
> Which brings me to the question, since you know the chip: does
> clearing OOB_WOL_CTRL_DIS actually disarm an OOB WOL engine that
> already armed, or does that need the SYS_RESET? Your comment says OOB
> WOL blocks DMA interrupt
> delivery, which is exactly the symptom, and stmmac_pci_plat_suspend()
> enables PCI wake unconditionally even with WoL off - it is off here.
>
> I have a candidate fix (do the full motorcomm_reset() in
> motorcomm_resume() instead of only deasserting the MDIO/PHY reset) and
> I'm happy to send it, but if OOB WOL is the mechanism the right patch
> is probably narrower. Caveat: I validated reset + full open, not reset
> + the stmmac_resume path, so a patched module still needs testing.
>
> Happy to run any experiment on this hardware.
>
> Giuseppe
