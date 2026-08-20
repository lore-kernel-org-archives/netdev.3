Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5D53988F8
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787257695; cv=pass; b=PyG7fb7xn7E6N8XcWOoOhX4MJwBpocVSkCHYyMn1s4Q+Asx03EqBEkECEj3i+GRXLbRceA+ZVA8q0FksICv29Z9WsEy7wUzAVdpKaVGDGDfbbte5/IbsvZ+DT8QShAzEnLQolFu55GAQyA1w90KL537DMe1FXkIPA42ah3xecZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787257695; c=relaxed/simple;
	bh=U/dTMGKvWzkN8MGftcnqRwlmaM4Gkz+9MeZ9NfAGpYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeFyKgZ0eC8Ran92OkTsDLaaZ/y8sLSBqJ51S/0VqSEovNMKLmVB9MQpZRpS4glcJTyJiK5iF7MkkGmsAk/hOxfZjzLrNnNcSbmPUHvnvRSgQkwslxovHm43UFGmCChIyqFaZIVh3y0PzY4vsyq/gsiZdSdGHPLX+N/EniHxaKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWMCuCnX; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWMCuCnX"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so478157a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 13:28:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787257692; cv=none;
        d=google.com; s=arc-20260327;
        b=aac+1aLdwJ4B67zX63VNu0xtid7t9VqYftHFG0fRJc6o7YaAyT7HIv+5lbB7JJ1jIA
         xruwkwt0z+r7GRoTm3iTUJYR0GFpLPEur2wtWQSjBNPo/z5y5IhpgBZfkNIXunrktvST
         8VC6vXjQcSXbKp2W8Ecnf2NjmgyxyMVfs6VQW9/w1nt9htfiS5h4XJekPgHrOkMXwGKR
         7jHXzulNJcNQ6c3tb172qBA3Ql+2pWZY/GoBh+ijQt16ep+sVZmiwJXzxezVu7I2iJ6s
         knxLxKLQfJCx+IekU7+RkdCic+B2w0uRJJ55AfliG7RPXl9WqP2cot08YZ5s+NzK8q9E
         APrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0kk0AVAj9nGqTqVxVL78VvobkVLKEhMiHFP97YU4FPk=;
        fh=d5bOL0GeHyVtepyY3nki5+7UVBHkCqjo+KZlUeQCTHA=;
        b=ju5klWm/5hNgF43jh7w2d3Fg7r5o9+8ozdik0JfITkB8qX0EporAzBZtJRYjGQ+dod
         ElOr+9caLy7qyul3zxp4QvTN+fh0KSn8etKKekDEePUD/eYDvWSzi9FSoT/00KmrJE48
         f746VinaGNbujrJ1XQmaEClaVCH+K0BZLHwBmNsw9FTkoZER+jaOBK3Pfc0HV2Tu/kZj
         iGdcwvD5GAUjpbNb73OjlGsOm4/gweZKuQrhEV1S3LYCr4rsKA3RhOQO8d5nZUcsolii
         4J27sM273Y1eoKbXHjAK+7+IaQMDYZrHYP2k7RrmFGUN0KxVfrLOSCOj3sW53HB3hc4c
         /usA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787257692; x=1787862492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0kk0AVAj9nGqTqVxVL78VvobkVLKEhMiHFP97YU4FPk=;
        b=FWMCuCnXLchSf/LPM20t/+3itOyUSe4IPywSuOi//qFt4O+Fss8JrFaNeTVQleOkW+
         PBykSN25ZG10MLpAfkouHGwxatPHK4hwrpsSwEj3oqa0zbtRfYoJzklaYfxBnY62LyaC
         ItFUoDBLFAQrVtA/KgmwaleHDS9/iVphplJnHy3BdVRF4FK9PXlM7Qrvo8C7poFIvW93
         oI/q4wrmZ4TFuWEO/WDjMSKHl/8z7UNmTopyzcK8d2mDCjgNMjyevMWSkYjtkWRcp4IX
         leSLh5n/j7oPOP5RmBS3bUDfW1Vn/MUr4DDnnx3HXBVcLRhfCVBapBEGmsI4+CekXNdd
         Of/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787257692; x=1787862492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0kk0AVAj9nGqTqVxVL78VvobkVLKEhMiHFP97YU4FPk=;
        b=W7K26Md8B6s5MUQOqZmpJz9p29XfU0ilBmKxvNJIN+MKgf86r83UFhUjFX5EqClJrf
         Xv+pKmSLxHGcdP01CG+7l0LQCzvliWP2eWy2ei05NtRdjwLvF65AAB0RLCA5c5XsKUJZ
         mPeLIDKOmyGTfO6YB6mNbN/epBIkV2055cZ5JehUdiv1rWdZEaM8Pjp6mbPgow2iZ5d8
         aL6LBdTB18h+Ts/KG5/Fqhxp+jF3KWEjCBbTiccKHPYs58H1ZqFqoFPw4MD7yOOvTwve
         je1wqaHsJIg9ZcwgpmFDhcJ8l/+xokq3nq256eIpfmzSHZHWDMyrDIquhwuUGvmK9P0M
         OW/A==
X-Gm-Message-State: AFuF++mFxFAjXte6Mqt2aewQrwcfa7N0ODNqFKToTA5XaiqZQR0CSFjz
	7ph0wYkXuICag6FpZp/A9XGb5P+ESR2WX3GOf7rKaVKSGoxLhBDL9S3rlnWTLY9IV5QeA+UehQ7
	c55IKb8BKq0RcPTg9KhCdarYxnT2odog=
X-Gm-Gg: AR+sD11b69pEkFnX4r9ihNy8KV4nzIR/4S/PEhPxbz2C4bssu5FoPd8w+iYDJHcDX4Z
	/4561wRXeAqq9UtoyPbZfq86Evojwe8FRGSXU5g/nzKvIkrdS5IM6UWAZhPH/PUj7RfE/Qwj/dc
	4Yc79QNdZKuIrvV3GToktfnm8jFtrILAImzkrrHoVAuZ048maGVFaX0k7ceyti1tCkRV6LYkpUd
	N2PgnpnhrAfeq2NUh8tVrOeP2RDvyoqMsifgUOiOZN7BGq1T8VrhN0SuCbioNWiay4ZnXlwtJ7c
	ItUX2zj733xf0z90o7PCFLrvyBR9dYme6sYM0TeOsZ6ngqiePCjBk+kQ6hXyWjOLekJax/gwTN1
	9Zv7EHpsLixf+dqkWHCzVaZZRabeetIoCGK6tfZx2
X-Received: by 2002:a05:6402:458d:b0:6a3:87b7:b5a9 with SMTP id
 4fb4d7f45d1cf-6a42f1f9d6cmr1132151a12.12.1787257692346; Thu, 20 Aug 2026
 13:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817090601.1256389-1-pawlik.dan@gmail.com>
 <20260817161756.5fd2185a@kernel.org> <CALC2Apj7rQv=6uUqaqBjfJ9yO+VCddQqHB=yDhXH7+QUCh2JyA@mail.gmail.com>
 <20260818082933.28b5c9d1@kernel.org> <CALC2Apj-KLB5CVbSvoZWvA4Oan7dmAerK=VP7W86jmErWW8OdQ@mail.gmail.com>
 <CALC2ApiCSY8DkVpd7puTssbJZMWBHGVtFCnG66fiK0PX7-u3Hw@mail.gmail.com> <20260820101851.0b4c284a@kernel.org>
In-Reply-To: <20260820101851.0b4c284a@kernel.org>
From: Daniel Pawlik <pawlik.dan@gmail.com>
Date: Thu, 20 Aug 2026 22:28:00 +0200
X-Gm-Features: AcwNN1Vsd9SSDhiQPcdRUECjLI5GP2wK-pPfntddOHFbe8M7j0tkDMN1vuQpucI
Message-ID: <CALC2Apgp1rxK4d4z1XcRJv3=O+7uxLcMuNBS0OTi0TbwA+0Fzw@mail.gmail.com>
Subject: Re: [PATCH v8] net: airoha: npu: use cacheline-sized buffers for
 mailbox DMA
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, win847@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuba,
Fair point - the interesting part is the mechanism. I don't have the
EN7581 TRM, so I can't name the exact register. From ATF, DT, NPU
firmware, and the instrumented kernel path, the picture looks like this:

TL;DR: Sub-cacheline map length forces SWIOTLB on this non-coherent
arm64 setup. SWIOTLB sync/invalidation doesn't explain the failure -
the response never appears in the bounce buffer. Cache-line-aligned
streaming buffers avoid SWIOTLB entirely and the probe reads 0.1111. The
remaining question is why the NPU doesn't produce visible writes in
the bounce region (high phys ~0xFF6x vs vendor DMA pools ~0x84-0x91).

What's ruled out:
- No IOMMU/SMMU on this SoC; DMA addresses equal physical addresses.
- No EMI MPU - unlike MT7622/MT7986, the Airoha ATF [1] configures
  only TZPC (secure/non-secure for NPU SRAM and EFUSE), not DMA
  address ranges.
- No PMP in NPU firmware =E2=80=94 disassembly of the RISC-V binary shows
  zero accesses to pmpcfg*/pmpaddr* CSRs.
- No dma-ranges in DT - the soc node uses identity-mapped ranges;
  the kernel sees no address translation for NPU DMA.
- set_memory_decrypted() on swiotlb pages is a no-op on standard
  arm64 (no CCA/memory encryption on EN7581).

What the bus fabric looks like:
The ATF bus test code [2] reveals the internal topology. Each DMA
engine has a dedicated port through the R2C (RBUS-to-DRAM converter)
bridge:

    port 0: GDMA/HSDMA
    port 1: PPE
    port 2: QDMA LAN (TX)
    port 3: QDMA WAN (TX)
    port 4: TDMA
    port 5: NPU

The RBUS also has a "DMA block" mechanism (0x1FA000EC) that
serializes CPU writes against DMA reads within 64B/128B-masked
regions, with per-engine block counters at 0x1FA000F4-0x1FA00108.

All vendor DMA buffers sit in one contiguous region:

    npu-binary:   0x84000000 (10MB)
    qdma0-buf:    0x87000000 (32MB)
    qdma1-buf:    0x89000000 (16MB)
    npu-pkt:      0x8A000000 (44MB)
    npu-txpkt:    0x8CC00000 (64MB)
    npu-txbufid:  0x90C00000
    npu-ba:       0x90C06800

The ATF bus test uses DRAM_TEST_BASE =3D 0x84000000 exclusively -
no test exercises DMA at high physical addresses.

The NPU reads the mailbox command from the swiotlb bounce address
(~0xFF6D0000) successfully - mbox_status returns success. But it
never writes the response back; the buffer stays zero, causing a
timeout.

Read-succeeds/write-fails at a high physical address, while all
production DMA stays in 0x84-0x91, points to the R2C bridge's
write path having a narrower address reach than the read path.
Whether that's an address decode window, a write-buffer range
check, or a port-specific routing constraint isn't visible in
the open-source ATF or kernel code - likely hardwired or set by
boot ROM before ATF runs.

So I suspect this is less "swiotlb unaligned-length sync is broken"
and more "this DMA master shouldn't be bounced to that DRAM region" -
but I can't prove the bridge/decode story without vendor docs.

Regards,
Dan

[1] https://github.com/Ansuel/atf-airoha
[2] atf-airoha/plat/ecnt/en7523/cpu_bus_bl2_test.c


czw., 20 sie 2026 o 19:18 Jakub Kicinski <kuba@kernel.org> napisa=C5=82(a):
>
> On Thu, 20 Aug 2026 10:20:08 +0200 Daniel Pawlik wrote:
> > size=3D24 < cache_line=3D64 fails this regardless of address alignment.
> > The swiotlb sync code itself is fine, but the NPU cannot DMA-write to
> > the bounce buffer address range (it reads commands fine, never writes
> > responses back). This is probably an EN7581 platform limitation.
>
> Sure, that's pretty much what GPT told us some revisions ago.
> The question is why.



--=20
Z powa=C5=BCaniem,
Daniel Pawlik
