Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502C4AA024
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352532; cv=pass; b=NKpWAhhAe8JvtOz0RTn+XOsKNeN+cEauXii43aiByDsbTOcuDrACU1lILiz6FPywiRr65TTIgg76gUVJv39wsnf6f5mjDvNBzHAVGL157u4NRxuVfmD8cJYk7TzjGaEOjY1mf1PFy6YxvAf+KXBFS7ugNW1mwMfav9PinoMiccc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352532; c=relaxed/simple;
	bh=JRw9q5jRHY/DgMKF/A4HEiThH4D2k8drfD5RRQxQKzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQfgLimmVgauotr1pb7dIuqgvxmxLnoRiZwlZ1GJ0InFlxPwPaw6YsojqYLTtr7AhrAO13OmC5TnJspAxVcLZTx7Vnzww+s7r+PyG99HueDLsZCKuzDWyy1EPOcJ2BGe+xGdr2lfZK2+aWonZxFrdTo4TCMQC4Y5baDnV7opTQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STSJpStn; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STSJpStn"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b203527bceso1612643a12.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 12:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792352528; cv=none;
        d=google.com; s=arc-20260327;
        b=YU5KB4c6YNmTcWiLcjZiatK82w0X+b/HldeahRAVgORS+c+kFyfqKGchaGU3g8ezDu
         PzsrkvifLOhUWgj9azwVDcJ+ZfB+o1nvk7nU3iX02tBTJ3TGEABaVzoz2Tcvu89WBLcL
         NYOYrIwcYDcIunB/dQAURkoL61N3wbor8NBW6aioQCzfeoP+9cnFdwqyrKAYqQKgJRvr
         4roBH5u+68uucT465P59Lq5DYqFChP+5GNmqw0s5ZugwRFFrsczMLq1rBrvM3JmCs96p
         1/nh+9HtBa7HsZe9J+M170QTMzh1NgEnFXF1EJJFiYisD1v/WUVYpmLOpc4EusR75QLb
         n0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QHwvsvqVjCSuPQ9w9gIFwqDJ0IFeW7rQfd/iiwke0Ww=;
        fh=QRGKs7vUQUGrdYJDrUmq3yk1z8Dpuzbfx0wJjbFvW40=;
        b=VWP83UKFkTRKguUacDp+Q5ZCH72sqTjyt7Zhm/JQrw0h3NlDNjbMvKvFSAVOYAVYyu
         8Kz0i8gQ1Aza+uo8xyyi1p2ik9fU9HoEDUMasYqqNhynyzXDGBP3zUiWUa2qpoYrweKg
         PoSqJAxf13Z20vsyTtM6esJ7+XbIspmRzJzDohFqIDGKDIWXbSkgN3Ksa+BYsDL3wc7c
         tdDouZ8Z6/aU+kppNw/gq6uR3boZ0JBWcpwwpalLDGl2c49hztYjKTeNywfSKuaPgMq/
         cZ4IOFouFLHYln4bY9/0sn7V8ALXW3VjRdF4qY1yk/lO1giyADE94XBymbWNoaH4w+9q
         ExIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792352528; x=1792957328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QHwvsvqVjCSuPQ9w9gIFwqDJ0IFeW7rQfd/iiwke0Ww=;
        b=STSJpStneYu5DMCa8PHqKX2J8kF8+r7IWmmL09Ge5iK8MhBm57yGd7bLjci0gyQLYT
         X5YoHG4rgsgqfix4UUFwUFXtzZ4btJzy1Kep8JvlCNBoL0Rz8SWipQO9iBaXJuZ5Dtbu
         /i1+nyUiCPxubOg+aos0JX2eCansuQ9O4X+FKuqqXpw9xh8JtdlkqAkMnDv3CztWXgJ3
         9pgQS7NfeBgxsOI64RgXv3i1PmhnHEPwiDFeVPa2Gllou2vyELehpicvo840bdOppaH2
         LkVgShZ/3YRmI37m0SYbT0zhw2JhUHwxd4CjvUudwlOe2ipGGEUIbOwjCM7XaTIBuTu9
         c4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792352528; x=1792957328;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QHwvsvqVjCSuPQ9w9gIFwqDJ0IFeW7rQfd/iiwke0Ww=;
        b=eYNb0YmY8+rFAZwsf/MF+gQ29Sr3drLVdw7dLq8h3d2I7d0mF6YhT1iAWCccxj/Poq
         +KRmTqc5C7ljxfR90HWN43Rwu4gi+tngxjdrqBhJUo7R7ALOWNZjrIKrItibtfBhMnrs
         zD7wKJhCC7iyz55RlVpAx/xLcN/HL6Lx38cmn1A6s8J/eHg8ePPxKQCQfDatWJ+KkJWj
         Hf0YhYBgosI3XPs5cFbh0Wq6NxkEEEXzyrzN0oVSyfetf7yYieOIyPLrfF9H/0iOIYYd
         NZqqFsxKlz/h2wSX6d29No7+5Ql0/kH+KlCO9vogonNfAUWPpV63XYVks8U3AXje6Jbl
         +ZKw==
X-Gm-Message-State: AFq9FYJAlWr4ucMRgz5Rd6Xpq4qj6OEczvZS1he8rCUq8/3ugOwVAlPO
	qUkyXwy+Thg6yGcrdmIgOYYo8ciUXLgo7wOfbGvY+sxEEFhF3jO6aYMFo7xXVHEBkBg5HREf24U
	Dicraxy1BHJLfT+9W4vVlavFk877BM1Q=
X-Gm-Gg: AYBFou0akjHgzxLCKlqLbVEg5bLB1RftB9ZWt2CMsyKr1nykKHT14dJ6nOPLKLmXsxp
	QVlOSbmxCo96eS8KHmY46qdgtWTI3A1U6DkTFMPPfEH36Lxw44dG6WMVkx3mpxpkXU14d7bbtVv
	Nd2CHs5INAZRAtiGr/ArGRFMU6sbRDkWcC8IUZqBmigcnSW6uYYLlFOwqQ/M4FhSuqDV+uKe7Ga
	5NlMHVSWY3do4ef6QWigpFI7jzpj+/U1qMBBJUfm5IP1bTK8kRuB/zpUDbOM5bK8Dizsg46FGjG
	6PufAPDwqXxiGoOjm+qV1U1D413WzLKog9m/lrrkJWW4da1lbdzz1yDBOx9l6GSRB5azVA3V5dA
	OfIqtauNRKYOx0ymEPRJoA1VAMXyaFcLBhTPwTHJkdeA=
X-Received: by 2002:a17:907:e1c5:20b0:c41:cf68:bbd0 with SMTP id
 a640c23a62f3a-c41cf68f3a2mr204540166b.26.1792352528196; Sun, 18 Oct 2026
 12:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820085941.380401-1-pawlik.dan@gmail.com> <20260820085941.380401-2-pawlik.dan@gmail.com>
 <CALC2AphzQ=dHOk2Yjtaw=i2euCLxo+Lk0kO50ixtYydO0yzBHA@mail.gmail.com> <atCRsquzA1UxSpCc@mediatek.com>
In-Reply-To: <atCRsquzA1UxSpCc@mediatek.com>
From: Daniel Pawlik <pawlik.dan@gmail.com>
Date: Sun, 18 Oct 2026 21:41:56 +0200
X-Gm-Features: AclHuK-9M52vzlkmmRQHSoaXu2S7CfmvA6Nr1UPIKXQnzj9cVhweDgXmDdWoET0
Message-ID: <CALC2ApgG7gQx7af_6_barG_mxMY90Q5JGrCF1uHa3j=B67p6Ag@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] net: airoha: npu: use cacheline-sized buffers for
 mailbox DMA
To: Zhengping Zhang <zhengping.zhang@airoha.com>
Cc: netdev@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name, sean.wang@mediatek.com, 
	Mark-MC.Lee@mediatek.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, yangshiji66@outlook.com, 
	upstream@airoha.com, szymon.datko@gmail.com, lei.dong@airoha.com, 
	ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zhengping, Kuba,

Thanks for confirming the NPU address window.

Please consider v10 2/2 withdrawn. It avoids the observed SWIOTLB bounce
path but does not ensure that DMA addresses stay within the NPU window.

I tested W1700K with all 2 GiB of RAM and the upstream DMA_BIDIRECTIONAL
mailbox path, using a restricted DMA pool at 0xbc000000-0xbfffffff,
without either the cacheline patch or the coherent-mailbox workaround.
Both the NPU and MT7996 drivers report version 0.1111, and all three
Wi-Fi APs are enabled.

The OpenWrt change is posted for review [1]

[1] https://github.com/openwrt/openwrt/pull/25928


Thanks,
Dan

czw., 15 pa=C5=BA 2026, 10:41 u=C5=BCytkownik Zhengping Zhang
<zhengping.zhang@airoha.com> napisa=C5=82:
>
> Hi Daniel,
>
> We investigated the NPU V2 address handling and confirmed that the NPU
> exposes only a 1 GiB DRAM address window.
>
> The relevant vendor definitions are:
>
>     #define DRAM_RANGE_1GB 0xbfffffff
>
>     #define DRAM_CAC_TO_UNC(x) \
>             ((x & 0x3fffffff) | 0x40000000)
>
>     #define DRAM_UNC_TO_CAC(x) \
>             ((x & 0x3fffffff) | 0x80000000)
>
> Therefore, the supported host cached DRAM range is:
>
>     0x80000000 - 0xbfffffff
>
> The corresponding NPU uncached address range is:
>
>     0x40000000 - 0x7fffffff
>
> As a result, the upper 1 GiB of a 2 GiB DRAM configuration aliases the
> lower 1 GiB from the NPU's point of view.
>
> The WLAN NPU firmware also checks the address range for packet buffers
> and TX ring addresses:
>
>     if (addr > DRAM_RANGE_1GB)
>             printf("out of available range");
>
> NPU debug output is disabled by default. To enable it for debugging,
> change the value written to REG_CR_NPU_MIB(21) from 1 to 0 in
> airoha_npu.c:
>
> -    regmap_write(npu->regmap, REG_CR_NPU_MIB(21), 1);
> +    regmap_write(npu->regmap, REG_CR_NPU_MIB(21), 0);
>
> The recommended platform integration is to reserve all NPU-owned WLAN
> buffers inside the supported DRAM window. For example:
>
>     reserved-memory {
>             #address-cells =3D <2>;
>             #size-cells =3D <2>;
>             ranges;
>
>             npu_pkt: npu-pkt@8a000000 {
>                     no-map;
>                     reg =3D <0x0 0x8a000000 0x0 0x2c00000>;
>             };
>
>             npu_txpkt: npu-txpkt@8cc00000 {
>                     no-map;
>                     reg =3D <0x0 0x8cc00000 0x0 0x4000000>;
>             };
>
>             npu_txbufid: npu-txbufid@90c00000 {
>                     no-map;
>                     reg =3D <0x0 0x90c00000 0x0 0x6800>;
>             };
>
>             npu_ba: npu-ba@90c06800 {
>                     no-map;
>                     reg =3D <0x0 0x90c06800 0x0 0x200000>;
>             };
>     };
>
> The regions should then be referenced by name from the NPU device node:
>
>     npu {
>             memory-region =3D <&npu_pkt>,
>                             <&npu_txpkt>,
>                             <&npu_txbufid>,
>                             <&npu_ba>;
>             memory-region-names =3D "pkt", "tx-pkt", "tx-bufid", "ba";
>     };
>
> This reserved-memory configuration covers the NPU WLAN packet buffers,
> TX packet buffers, buffer IDs, and BA memory.
>
> It does not automatically constrain the temporary mailbox buffers
> allocated with kzalloc(). If the same NPU address-window restriction
> also applies to mailbox DMA, those buffers must be allocated from a
> low-address DMA pool or otherwise guaranteed to map to an address
> within the supported window.
>
> Best regards,
> Zhengping
>
> Wed, Sep 30, 2026 at 06:19:31PM +0200, Daniel Pawlik wrote:
> > Hi Kuba, Lorenzo, Airoha team,
> >
> > I found a concrete lead for the unresolved cacheline patch in the vendo=
r
> > firmware. The installed en7581_MT7996_npu_rv32.bin matches the blob in
> > linux-firmware commit 1043c0303910 by SHA-256.
> >
> > At file offset 0x3a9c, the Wi-Fi mailbox handler converts the supplied
> > buffer address before reading the command:
> >
> >   lui   a5,0x40000
> >   addi  a4,a5,-1
> >   and   a4,a4,a0
> >   or    a4,a4,a5
> >   lw    a1,0(a4)
> >
> > This implements (address & 0x3fffffff) | 0x40000000. Both 0xbf6cf000
> > and 0xff6cf000 produce 0x7f6cf000. W1700K has 2 GiB of RAM starting
> > at 0x80000000; its current SWIOTLB pool starts at 0xff6cf000.
> >
> > The handler also returns 1 (success) for an unsupported operation type
> > at file offset 0x3b4a. My earlier claim that mailbox success proved a
> > correct command read was therefore unjustified. The traces do not
> > establish a read-succeeds/write-fails limitation.
> >
> > This suggests an address-window problem, but the NPU-side bus mapping
> > still needs confirmation. The cacheline patch avoids the observed bounc=
e
> > path without constraining the address of future direct allocations.
> >
> > Can Airoha confirm which host DRAM range this alias covers, and whether
> > mailbox buffers above 0xbfffffff are supported?
> >
> > I have prepared, but not yet run, a test retaining all 2 GiB of RAM and
> > the 12-byte DMA_BIDIRECTIONAL mapping, with the SWIOTLB boot pool below
> > 0xc0000000. A successful version response through a verified bounced
> > mapping there would help distinguish the address limitation from a
> > SWIOTLB copy/cache issue.
> >
> > Thanks,
> > Dan
> >
