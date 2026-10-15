Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324E147DD77
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053698; cv=none; b=Y4A+aUsjgsuQLUn/eYBwd+sW4HdkNj9MgqjhUHV/p9zAJ5GFyKEdd9WSYXXx2Lc6vDwxpDHGrhKaUxN3IoR/W/2YD6yDhVSvWiidluwSnizEavRZfSfVX4mGPmuAwJ5uSXu7Qf9SmDv6yvMF4uEAMpsQv+qkbCQ3QnTOwa028e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053698; c=relaxed/simple;
	bh=R2HwbYA3M5LCmpIJnZ8/6z01M4GuhoCuS+CLTM/Xm6U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgAHi6sZHqFmdYGdDG2DShq6oVUkBVa7s7VqURtjTT1Rf0rMKy9UQt4x6DyXpgJzi6WKs145xdHAqwO3+Whm28z3M7xTopu2sqDlt7jS/CJNGb0wF7P+X75dGB7xhmlYcFv95mQ2EcbITXnsjOOMFS6wdyTB5wk1a0mwwY8HHhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com; spf=pass smtp.mailfrom=airoha.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=H4Q1odMD; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airoha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="H4Q1odMD"
X-UUID: 3404874cc87411f1b1788b6acf885367-20261015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=1TG6EaszwqcVuJqwSi/vXz+tyLYa/MdcQh36mn2UMKc=;
	b=H4Q1odMDUk2qt2xD9nhbmqkfcVfTZLq8ldMvRk4ES8cVVZ+rOk/uX7LTrXvF3qac/EnFzIqhtu7Y8VoWRr4qjqCYKcCdz5WGZdHWfdOiF3xlOcxaIZBsD65xE3R5KuBRXrJuUlGwiURXJGi1zcWYkKRkP7/vpoPY7FZXlFuTeUI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:c8d1547c-73a4-49cf-8203-efdc4319e0ce,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:07f317fd-82fa-4755-85ae-ebe9525ab585,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|836|865|888|898,TC:-5,Content:
	0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3404874cc87411f1b1788b6acf885367-20261015
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <zhengping.zhang@airoha.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1844561766; Thu, 15 Oct 2026 16:41:23 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Oct 2026 16:41:22 +0800
Received: from mediatek.com (172.18.153.129) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Thu, 15 Oct 2026 16:41:22 +0800
Date: Thu, 15 Oct 2026 16:41:22 +0800
From: Zhengping Zhang <zhengping.zhang@airoha.com>
To: Daniel Pawlik <pawlik.dan@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <kuba@kernel.org>,
	<lorenzo@kernel.org>, <nbd@nbd.name>, <sean.wang@mediatek.com>,
	<Mark-MC.Lee@mediatek.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <yangshiji66@outlook.com>,
	<upstream@airoha.com>, <szymon.datko@gmail.com>, <lei.dong@airoha.com>,
	<ansuelsmth@gmail.com>
Subject: Re: [PATCH v10 2/2] net: airoha: npu: use cacheline-sized buffers
 for mailbox DMA
Message-ID: <atCRsquzA1UxSpCc@mediatek.com>
References: <20260820085941.380401-1-pawlik.dan@gmail.com>
 <20260820085941.380401-2-pawlik.dan@gmail.com>
 <CALC2AphzQ=dHOk2Yjtaw=i2euCLxo+Lk0kO50ixtYydO0yzBHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CALC2AphzQ=dHOk2Yjtaw=i2euCLxo+Lk0kO50ixtYydO0yzBHA@mail.gmail.com>
X-MTK: N

Hi Daniel,

We investigated the NPU V2 address handling and confirmed that the NPU
exposes only a 1 GiB DRAM address window.

The relevant vendor definitions are:

    #define DRAM_RANGE_1GB 0xbfffffff

    #define DRAM_CAC_TO_UNC(x) \
            ((x & 0x3fffffff) | 0x40000000)

    #define DRAM_UNC_TO_CAC(x) \
            ((x & 0x3fffffff) | 0x80000000)

Therefore, the supported host cached DRAM range is:

    0x80000000 - 0xbfffffff

The corresponding NPU uncached address range is:

    0x40000000 - 0x7fffffff

As a result, the upper 1 GiB of a 2 GiB DRAM configuration aliases the
lower 1 GiB from the NPU's point of view.

The WLAN NPU firmware also checks the address range for packet buffers
and TX ring addresses:

    if (addr > DRAM_RANGE_1GB)
            printf("out of available range");

NPU debug output is disabled by default. To enable it for debugging,
change the value written to REG_CR_NPU_MIB(21) from 1 to 0 in
airoha_npu.c:

-    regmap_write(npu->regmap, REG_CR_NPU_MIB(21), 1);
+    regmap_write(npu->regmap, REG_CR_NPU_MIB(21), 0);

The recommended platform integration is to reserve all NPU-owned WLAN
buffers inside the supported DRAM window. For example:

    reserved-memory {
            #address-cells = <2>;
            #size-cells = <2>;
            ranges;

            npu_pkt: npu-pkt@8a000000 {
                    no-map;
                    reg = <0x0 0x8a000000 0x0 0x2c00000>;
            };

            npu_txpkt: npu-txpkt@8cc00000 {
                    no-map;
                    reg = <0x0 0x8cc00000 0x0 0x4000000>;
            };

            npu_txbufid: npu-txbufid@90c00000 {
                    no-map;
                    reg = <0x0 0x90c00000 0x0 0x6800>;
            };

            npu_ba: npu-ba@90c06800 {
                    no-map;
                    reg = <0x0 0x90c06800 0x0 0x200000>;
            };
    };

The regions should then be referenced by name from the NPU device node:

    npu {
            memory-region = <&npu_pkt>,
                            <&npu_txpkt>,
                            <&npu_txbufid>,
                            <&npu_ba>;
            memory-region-names = "pkt", "tx-pkt", "tx-bufid", "ba";
    };

This reserved-memory configuration covers the NPU WLAN packet buffers,
TX packet buffers, buffer IDs, and BA memory.

It does not automatically constrain the temporary mailbox buffers
allocated with kzalloc(). If the same NPU address-window restriction
also applies to mailbox DMA, those buffers must be allocated from a
low-address DMA pool or otherwise guaranteed to map to an address
within the supported window.

Best regards,
Zhengping

Wed, Sep 30, 2026 at 06:19:31PM +0200, Daniel Pawlik wrote:
> Hi Kuba, Lorenzo, Airoha team,
> 
> I found a concrete lead for the unresolved cacheline patch in the vendor
> firmware. The installed en7581_MT7996_npu_rv32.bin matches the blob in
> linux-firmware commit 1043c0303910 by SHA-256.
> 
> At file offset 0x3a9c, the Wi-Fi mailbox handler converts the supplied
> buffer address before reading the command:
> 
>   lui   a5,0x40000
>   addi  a4,a5,-1
>   and   a4,a4,a0
>   or    a4,a4,a5
>   lw    a1,0(a4)
> 
> This implements (address & 0x3fffffff) | 0x40000000. Both 0xbf6cf000
> and 0xff6cf000 produce 0x7f6cf000. W1700K has 2 GiB of RAM starting
> at 0x80000000; its current SWIOTLB pool starts at 0xff6cf000.
> 
> The handler also returns 1 (success) for an unsupported operation type
> at file offset 0x3b4a. My earlier claim that mailbox success proved a
> correct command read was therefore unjustified. The traces do not
> establish a read-succeeds/write-fails limitation.
> 
> This suggests an address-window problem, but the NPU-side bus mapping
> still needs confirmation. The cacheline patch avoids the observed bounce
> path without constraining the address of future direct allocations.
> 
> Can Airoha confirm which host DRAM range this alias covers, and whether
> mailbox buffers above 0xbfffffff are supported?
> 
> I have prepared, but not yet run, a test retaining all 2 GiB of RAM and
> the 12-byte DMA_BIDIRECTIONAL mapping, with the SWIOTLB boot pool below
> 0xc0000000. A successful version response through a verified bounced
> mapping there would help distinguish the address limitation from a
> SWIOTLB copy/cache issue.
> 
> Thanks,
> Dan
> 
