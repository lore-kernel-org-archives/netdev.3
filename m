Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1EB468C05
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546276; cv=pass; b=tLFUdq4FZMF1F5zajb+Ug5GP1KpCPKXHsYGHyClN5UbcDh4bB8E7lbGE7w+i15gBcsXn5cnvRySkOe8VAtJmj/SK6v0MVKzozJEjG6cjFRb1Y2KQEnnxpOtUX13MFXDVcXFgoz33WWyEsyI07AU6/aZW2RxpOEajmqKdlonjkus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546276; c=relaxed/simple;
	bh=YV8lViX/Plx+pXmSAua3UM9oZhLBRYnDWBhiqxYz9FE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JWtJ6IYq4b+DcIKZNaJxW0j5mPSvdn/j5fXPoxA4vilJ6mBdZY8/FSGPk7zRi8MadpmUaJlV0+alsd+cuBNBhRjWxAyOiooJprU9VWyAQtLppVJlpnLUUMKGYWMqdduS4MnmAWqNUXVpgn87rXYI2Ak5d5HBspMosyr2UXMA/Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKBsZ20H; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKBsZ20H"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47fe377a217so646799f8f.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 07:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786546270; cv=none;
        d=google.com; s=arc-20260327;
        b=oEGfZHwvCPS6vJ21Ft0j+RGMGKLBHdYTKdJ/d2kR+uMhGkCDt8p/gI/KdUixF42LLd
         f0OsBsk+EvJUqrCIKQ6w7HX7EvvH4eXQOIYifTfghSpMSDq/TG6/E/TUFL3OkFHx8SaO
         mzKzcPcnVAIlt5GFjzEAkJ0ULB/xWw60qWEUIWK9P27dWDb+e84YB1vXATssOrusFlUi
         46fygCwqAEUFcTFxTPyuYZKeRg8nwwVJcDZY2VHwujMxPA2aBv+KzaYHxc5C1kDNLGj0
         4jl4guvC1omYC+ZKr+5pmcDFF9ZjBkP66eB8k/DkHsNsd6bc4x8wAFa8OJbIs0VzgfM7
         IG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=YV8lViX/Plx+pXmSAua3UM9oZhLBRYnDWBhiqxYz9FE=;
        fh=GJDOkJGMPhVedBW4znRBBLZnIkPYpiu96hIit20RvTE=;
        b=jWbFWkybVI7fxBe2oxv27vDl8M2hMLERWWoRKEi1X4CzZrOs9kqUM1okDYz1/DKdlb
         Ma81RofD362HWCKB1JyWzpAHZ+m6X7iCe9QTuner49VJLswQL/zZyk/DkkCzTWFdEVXK
         E21SumJGYCKDEy5KHjIJ/zzORncOZkLtKajoBxw2oiCr46q6oJnylqMaJekQkAb/H9IF
         o1JJMyeqiYpL2DESng3OTyyI8jCRmS8ic23Aw3xc7U9fgaQVInAXMgt2rlDQvWps6ZGF
         bo+ANns41NGXpXKz9PpYiz+swSfGnwWO2wyIWraNDgPSzHqbWiQlkIPOtHdYjFuk7kJy
         zpTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786546270; x=1787151070; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YV8lViX/Plx+pXmSAua3UM9oZhLBRYnDWBhiqxYz9FE=;
        b=PKBsZ20Huw6ResiVJ8z/1MJMa786lbavy1n3vnzJ1K2UlNqYocgbFwOfO0sxvk8AxM
         MeWb58efDZYcSscIDMxapaW7VoKggtV8QXRAwdFfWNX28lthEgHWi844vpOSKOk9//jE
         cmyvPKpB+xXGZBq1FLtjQ2ij5K+XHMuM7QmBVnV1r/Y9Fk2+BATgX6DB2p7bsMCddSV4
         fcgkU/WmrWdM2Zb2LMLcatdbBXdfjCsOjXcFbZpOhJhX4u2dSwwFk8L66yYLNC5BhuJQ
         smluwR2WbwmSHi/rAssOAAf9/NOEFvzo9DJ27NxXPF7+q/9eNMSaDVeXBWXdtIT3bTg2
         lZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786546270; x=1787151070;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YV8lViX/Plx+pXmSAua3UM9oZhLBRYnDWBhiqxYz9FE=;
        b=BCOFX+F0x9R8d1LxW4hvzCS9NwRJIGU4wBA3JqyQDUmyZHuzdwrZ691srZHv5WdzDV
         mrRGKJJDLdK/UFh5i8jDh3SgqkGpbOH+Dw3eOWon6w5pcwj95AzfemgiNpchZDcSmLhE
         BJ4+jsyP+5Z0LfTqHM2g5oFw9PvOmkh+Tmmpmc/iI2vaqBeiv2m78qrfREB28RosOrDT
         QPug2NDWgWve01l8XhiYsZrbRfDR6bL3+GZpclBSZeqAP4arGhIJaJ0sWUGCamfW1cHK
         4eAh8yf4ZqDxoJxyct79OST6CaAwfpHfDSpFhFslJ0a6UovspsG8UMdyfjv8bMg56KuU
         gDEA==
X-Gm-Message-State: AOJu0YxBRPDIbk722hmjGQW3sMbUR0qgT2RBg+v8OKp2ibVnR+p7iuWw
	sgWHe9f0mB090I5yjrI1iwrYhQcd1RXlH+p//mv+rXrb63sU4G/dmucT6beu31E+FTGIEwtd1cc
	UV/Vh1qe2Cqs0ReuepXgVqbQpBLPR2nHIbl54wCQ=
X-Gm-Gg: AR+sD10SlFVmSLWdLREYz6KF7hRJIT3zhpRV6yomenmazi/LU/q6zucPcH1EAiC78j0
	LwupPxPigm1cGldblnSXNwg2O95b/CjEVsd51JWt6iMAS82da+p435LiM+yOETTfSzoxuNrOsL3
	V0agEFlMBDOOngOB/jkimnoLwiqTL+FLn5xz4LRL/iDGJSsxX6YUdcyumS0wZ12Tvp1veHNqz0u
	eM13I37egkG5+iWq5ZjlSWaKp1RPgI3OhDZpP+78G9VSqP1xLcV7kCGsSkOjPiJgNhQjLb4VXzN
	As9aPpHrUV7FdBSqREA/2G5SJYq8K565fjcRU58Whq36m85HNbONf8omzYbrTwJqS9wAfRpRK+I
	=
X-Received: by 2002:a05:6000:1889:b0:47f:e877:641b with SMTP id
 ffacd0b85a97d-48152b15e25mr8190918f8f.11.1786546270318; Wed, 12 Aug 2026
 07:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Giuseppe Nespolino <g.nespolino@gmail.com>
Date: Wed, 12 Aug 2026 16:50:57 +0200
X-Gm-Features: AUfX_mzbNEFQ4zo4qYOJ3xJDnsZmD76jlbVmb-nZb7voYa2wFF2rx70KHzeia9c
Message-ID: <CAKx9m6PywVwkirvkAtz144c-yg71c2+OcNYOTM4Bjtd8dF2PaA@mail.gmail.com>
Subject: dwmac-motorcomm: RX dies after long s2idle, only wrapper SYS_RESET recovers
To: Yao Zi <me@ziyao.cc>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yao,

On a Slimbook EVO15-A8 (YT6801, 1f0a:6801, kernel 7.0.0-28 Ubuntu)
enp2s0 stops receiving after a long s2idle. 18-25 minutes reproduces
it; 5s and 30s cycles never did.
Link comes up at 1Gbps and the resume path logs nothing unusual.

Measured while broken:

- MAC is receiving: mmc_rx_framecount_gb climbing,
mmc_rx_fifo_overflow 2585. netdev rx_packets and the rx-0 MSI-X count
frozen.
- MSIX_PBA (BAR0+0x1300) = 0, so the device isn't asserting anything.
- CH0_STATUS = 0x4c5: RI/RBU/TI/TBU latched, NIS and AIS clear, with
NIE/AIE set in CH0_INTR_ENA (0xd041).
- All 512 RX descriptors in writeback format with sane lengths
(64-1518), OWN=0. The DMA received them; nothing ever consumed them.

Event bits latch and clear fine (W1C works, MGMT_INT_CTRL0 tracks it
as a mirror), but the summary stage never asserts and no MSI-X is
generated. RBU, the full ring and the FIFO overflow are all downstream
of that.

Ruled out with data: ASPM/remapping (PBA=0, MSI-X table intact, zero
IOMMU faults), wrapper registers lost across D3 (all identical to a
healthy baseline), unarmed ring, and MGMT_INT_CTRL0 needing an ack
(status field is read-only).

What recovers it: toggling SYS_RESET (0x152c bit31) plus
motorcomm_init(), then ip link down/up. down/up alone does not - rings
get rebuilt, IRQs re-requested, packets land in memory, still zero
interrupts. I haven't yet isolated the reset from motorcomm_init().

Which brings me to the question, since you know the chip: does
clearing OOB_WOL_CTRL_DIS actually disarm an OOB WOL engine that
already armed, or does that need the SYS_RESET? Your comment says OOB
WOL blocks DMA interrupt
delivery, which is exactly the symptom, and stmmac_pci_plat_suspend()
enables PCI wake unconditionally even with WoL off - it is off here.

I have a candidate fix (do the full motorcomm_reset() in
motorcomm_resume() instead of only deasserting the MDIO/PHY reset) and
I'm happy to send it, but if OOB WOL is the mechanism the right patch
is probably narrower. Caveat: I validated reset + full open, not reset
+ the stmmac_resume path, so a patched module still needs testing.

Happy to run any experiment on this hardware.

Giuseppe
