Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D8B48640D
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462228; cv=none; b=IFRiTxtkzgqa5+3sVpf9VT1U8lTKIQwjuhecoXzO2NNT6nEjqQW2hZ4BkEij1QKrtd8NseJkGUVKRJm9yujOtfEgJboUM2COqWUkZFxbwiZxiOI+qNrMTu3pwnMbCUBUTH4tRD14BeTJF96m/Xvq+3uf9nZII+yp4gC9M0js6zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462228; c=relaxed/simple;
	bh=eQBZRt73OJPvQihSuxprGsITasHhC0JemHvYW7flDPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9xqqIDghuVbJokwbWSnDjRZ9XLkxTDMt++pxTpCyn7Bg1MjZPeTLz+n9l6G+MHWH9J9j9J2fMZZDZAbIDpV6x3irrG4i49g9dBsASZym0kmeJdFNlfO4/RNhcdIpCg/EM8BBf3HioII/2Lcn1EB6nYEgNzWkBTtrN9VPaboYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FjAF2v+o; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s95J9I75; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjAF2v+o";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s95J9I75"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789462225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYcdF374Pa9T0avVKuHqJFN69BWIvYlMq0B1D72dSGY=;
	b=FjAF2v+o8f8pC29Z+bmLppVS55khpDGOuxP8y69/31kuUrFcZTX1N6ND6aJeSJx30ae8nt
	e0XYGbQEa9T6JEfJ5LfPEyuaQQLs9q0T+76fM+hHQpfcdZeAYdzYQRZ9arkSQrwhTxL1xI
	tsNrasiBvcXu+vaBAcN7QL9gnqYeqwY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-kk7fZGDeM9mZTiN48bRTxQ-1; Tue, 15 Sep 2026 04:50:24 -0400
X-MC-Unique: kk7fZGDeM9mZTiN48bRTxQ-1
X-Mimecast-MFC-AGG-ID: kk7fZGDeM9mZTiN48bRTxQ_1789462223
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-486f3dbf7d2so2746166f8f.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 01:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789462223; x=1790067023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WYcdF374Pa9T0avVKuHqJFN69BWIvYlMq0B1D72dSGY=;
        b=s95J9I7516Y1j0/YaZeNdvndUO7lKl1iQ8YlReD8avz/6zkP9ma+Tdtmqs4uNGBbHO
         eApGMRs7hSwAK+4mYJj4hgXwTLaRHbh2sZuGxciXHJ9nWKj0xAGHI3Sfbu3MIdYtcIHI
         q+XrGBbIn4vidBG2MtR8/r5oD/W2odLMiPRmKBHaD181CRZjBl8CjECVUQJH5GQe98Yr
         31NnjU9jf2gN/1NvodOFXlMpTltsoBCyf39bKf9HhF1/NHoPZ4WBMuBqvseBHJy7LwPE
         HA4xXPU6rnOmysn3tzOCcvtX4okZGxN2M6SjO3HNDbJk9tlOJicC03E7z2IXEEo47ioh
         csQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789462223; x=1790067023;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WYcdF374Pa9T0avVKuHqJFN69BWIvYlMq0B1D72dSGY=;
        b=Ey5VsIljh3PJMgSnrN+anc+uCe9RttZOkBfs844NO8XrmlySM4dRfY8SbJe4PL5yKh
         kkV38gRtaXbeqkjgSSFuZh3DOWAPkzauAzEJumZT3EIffd+1fFVcWMsOKLaxLF3+JdlJ
         sCHv+aSMoxeeOLf7DrUXHNyI2fK7WNpgjO0bDVf/9OWdsBQSmSTjagx5dSMj/bUNRJE3
         MBq152nGw62YjSPROShdEw0BW1K17MThN4QGxrjffeZxiygajiQ0K68TvRIUQrLiVwWc
         cZkqSHGcfpTxAi+psSh3+Q4MT5HIiOHbm/x5RoGR2XRnK75u+4ddr7VHG+6Idrjpp1Ih
         3nnA==
X-Gm-Message-State: AFuF++kL5biKaqFKmr067Yb4ku88Krp3B91WNKpL8+C/SbqBkYp/oxa5
	4h4Mx56SofIa81ylRQ3MNYbT+c9Rde4MUm5KHAXaSYboWAPtw1vQqYtrMuaLARbzi7BgIoe8wJq
	k6vwnovFrCoU5jMX4BZa0m93vlM267yg40oykcXGeKRLPoEnXXV6UQxXxrQ==
X-Gm-Gg: AYBFou1t/UAwEgFhAQZ1twOfJywfGIqxK+2ZKvngLjJLI/eCfm3p47N5EN4sBdWkFuE
	ooTKUqtJ4kPXR/YcDBBy9yv6QLZL3srrj2I/CcXM3jyp+sNexrWNxW3Qm3O/MJtnWSeqJixA2f3
	gSin89o/Ebnb/6aZTK2XHMvek/AzG5XY2d+3ia/NJu16M4XbYPqm3XYGhauzvArXv+yKgG+NPyx
	veVT2sBpfifA9ZJtx/jN4OlGR1yQGSY/sh+SaSC82/UpP9OW1ueureR6MZUL5UXx3F2FL0K4KLw
	DQ+onh/ts/XBNG77BVsWz/OOGUJiofs4ZuG6lB7WLKsrZPO71ZwKzi5exJuAf/Ai2SSm606lHQn
	PXCGjKbeYdPlGu1ILXaKjm6cX8cURW5dc4RlIP+Z9taw9SNF7CY6OXgiftLSD8pqoY9X2QiqpoA
	==
X-Received: by 2002:a5d:6f1c:0:b0:487:970:ca4b with SMTP id ffacd0b85a97d-4870970cb5amr941597f8f.25.1789462222472;
        Tue, 15 Sep 2026 01:50:22 -0700 (PDT)
X-Received: by 2002:a5d:6f1c:0:b0:487:970:ca4b with SMTP id ffacd0b85a97d-4870970cb5amr941559f8f.25.1789462221970;
        Tue, 15 Sep 2026 01:50:21 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e7f5sm32623392f8f.9.2026.09.15.01.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 01:50:21 -0700 (PDT)
Message-ID: <0d85afb2-c738-42da-aa1a-aa16e5709948@redhat.com>
Date: Tue, 15 Sep 2026 10:50:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 0/6] net: stmmac: More selftest-related fixes
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Minda Chen <minda.chen@starfivetech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jan Petrous <jan.petrous@oss.nxp.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Jose.Abreu@synopsys.com,
 Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de,
 David Laight <david.laight.linux@gmail.com>
References: <20260911212028.1497613-1-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260911212028.1497613-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/26 11:20 PM, Maxime Chevallier wrote:
> Hi everyone,
> 
> This is V3 of stmmac selftest fixes, adding a cap on EEE test as the
> timeout can get pretty long, found by Nicolai.
> 
> This is another round of stmmac selftest fixes, mostly about the selftests
> themselves but a few things were discovered w.r.t MTU and buffer size
> handling, see patch 5.
> 
> I've continued expanding the test devices I'm running this on, more devices
> should come in the future. With this series, _almost_ everything is
> green, except for some flow control stuff that is either a false positive
> or a real thing that needs investigating.
> 
> After this is merged, I consider the selftests to be now reliable enough
> to run them nightly on every stmmac series that's sent, and I'll be requiring
> clean selftests for new glue drivers.
> 
> I've been running this on :
> 
>  - Altera CycloneV (dwmac-socfpga, dwmac1000 IP, v3.70a)
>  - NXP imx8mp (dwmac-imx, dwmac4, v5.10a)
>  - Allwinner H2S (dwmac-sun8i, dwmac1000)
>  - Amlogic S905X3 (dwmac-meson8b, dwmac1000, v3.70a)
>  - STM32mp157a (dwmac-stm32, dwmac4, v4.20a)
>  - SiFive JH7110 (dwmac-starfive, dwmac4, v5.20)
>  - Motorcomm YT8061 (PCIe, dwmac-motorcomm, dwmac4)
>  - Qualcomm IPQ8064 (dwmac-ipq806x, dwmac1000)
> 
> Tests are OK if return is 0 or -95 (-EOPNOTSUPP), tests are KO otherwise
> 
> Before the series :
> 
> Test                     imx  socfpga sun8i meson8b stm32 starV mcom ipq806x
> MAC Loopback              0     0      0     0       0     0     0    -110
> MMC Counters              0     0      -95   0       0     0     0    -110
> EEE                       -95   -95    -95   -110    -110  -95   -95  -95
> Hash Filter MC            0     0      -95   0       0     0     0    -95
> Perfect Filter UC         -95   0      0     -95     -95   -95   -95  -95
> MC Filter                 -95   0      -95   -95     -95   -95   -95  -95
> UC Filter                 -95   0      -95   -95     -95   -95   -95  -95
> Flow Control              -95   0      -110  0       -110  -95   -110 -110
> RSS                       -95   -95    -95   -95     -95   -95   -95  -95
> VLAN Filtering            -110  -95    -95   -95     -110  -110  -95  -95
> VLAN Filtering (perf)     -110  -95    -95   -95     -110  -110  -95  -95
> Double VLAN Filter        -110  -95    -95   -95     -110  -110  -95  -95
> Double VLAN Filter (perf) -110  -95    -95   -95     -110  -110  -95  -95
> Flexible RX Parser        0     -95    -95   -95     -95   -95   -95  -95
> SA Insertion (desc)       0     -95    -95   -95     0     0     0    -95
> SA Replacement (desc)     0     -95    -95   -95     0     0     0    -95
> SA Insertion (reg         0     -95    -95   -95     0     0     0    -95
> SA Replacement (reg)      0     -95    -95   -95     0     0     0    -95
> VLAN TX Insertion         -110  -95    -95   -95     -110  -110  -110 -95
> SVLAN TX Insertion        -110  -95    -95   -95     -110  -95   -110 -95
> L3 DA Filtering           0     -95    -95   -95     -95   -95   -95  -95
> L3 SA Filtering           0     -95    -95   -95     -95   -95   -95  -95
> L4 DA TCP Filtering       0     -95    -95   -95     -95   -95   -95  -95
> L4 SA TCP Filtering       0     -95    -95   -95     -95   -95   -95  -95
> L4 DA UDP Filtering       0     -95    -95   -95     -95   -95   -95  -95
> L4 SA UDP Filtering       0     -95    -95   -95     -95   -95   -95  -95
> ARP Offload               -95   -95    -95   -95     -110  -110  -110 -95
> Jumbo Frame               0     -110   -110  0       0     0     0    -110
> Multichannel Jumbo        0     -95    -95   -95     -95   -95   -95  -95
> Split Header             --95   -95    -95   -95     -95   -95   0    -95
> TBS (ETF Scheduler)      --95   -95    -95   -95     -95   -95   -95  -95
> 
> ARP offload's still there as this was a net-next patch and I've ran these
> checks on the net tree.
> 
> Jumbo frame tests on dwmac1000 started failing after :
> 
> commit 23680bf5f8c6 ("net: stmmac: restore NET_IP_ALIGN in the RX DMA offset")
> 
> This commit is OK though, it just made the selftest reveal the cracks
> hiding beneath the surface of MTU/bufsz handling.
> 
> After this series :
> 
> Test                     imx  socfpga sun8i meson8b stm32 starV mcom ipq806x
> MAC Loopback              0      0     0       0     0     0     0    0
> MMC Counters              0      0     -95     0     0     0     0    0
> EEE                       -95    -95   -95     0     0     -95   -95  -95
> Hash Filter MC            0      0     -95     0     0     0     0    -95
> Perfect Filter UC         -95    0     0       -95   -95   -95   -95  -95
> MC Filter                 -95    0     -95     -95   -95   -95   -95  -95
> UC Filter                 -95    0     -95     -95   -95   -95   -95  -95
> Flow Control              -95    0     -110    0     -110  -95   -110 -110
> RSS                       -95    -95   -95     -95   -95   -95   -95  -95
> VLAN Filtering            0      -95   -95     -95   0     0     -95  -95
> VLAN Filtering (perf)     0      -95   -95     -95   0     0     -95  -95
> Double VLAN Filter        0      -95   -95     -95   0     0     -95  -95
> Double VLAN Filter (perf) 0      -95   -95     -95   0     0     -95  -95
> Flexible RX Parser        0      -95   -95     -95   -95   -95   -95  -95
> SA Insertion (desc)       0      -95   -95     -95   0     0     0    -95
> SA Replacement (desc)     0      -95   -95     -95   0     0     0    -95
> SA Insertion (reg         0      -95   -95     -95   0     0     0    -95
> SA Replacement (reg)      0      -95   -95     -95   0     0     0    -95
> VLAN TX Insertion         0      -95   -95     -95   0     0     0    -95
> SVLAN TX Insertion        -95    -95   -95     -95   -95   -95   -95  -95
> L3 DA Filtering           0      -95   -95     -95   -95   -95   -95  -95
> L3 SA Filtering           0      -95   -95     -95   -95   -95   -95  -95
> L4 DA TCP Filtering       0      -95   -95     -95   -95   -95   -95  -95
> L4 SA TCP Filtering       0      -95   -95     -95   -95   -95   -95  -95
> L4 DA UDP Filtering       0      -95   -95     -95   -95   -95   -95  -95
> L4 SA UDP Filtering       0      -95   -95     -95   -95   -95   -95  -95
> ARP Offload               -95    -95   -95     -95   -110  -110  -110 -95
> Jumbo Frame               0      0     0       0     0     0     0    0
> Multichannel Jumbo        0      -95   -95     -95   -95   -95   -95  -95
> Split Header              -95    -95   -95     -95   -95   -95   0    -95
> TBS (ETF Scheduler)       -95    -95   -95     -95   -95   -95   -95  -95
> 
> ARP can be ignored, and Flow control needs some more attention, but
> we're getting there :)
> 
> Thanks,
> 
> Maxime
> 
> V3:
>  - Bail out of the EEE test if LPI is over 5 seconds
> 
> V2:
> https://lore.kernel.org/r/20260910151404.976753-1-maxime.chevallier@bootlin.com
>  - Snapshot before sending the frame for EEE, in case we immediately
>    enter LPI
>  - Also return -ETIMEDOUT instead of EINVAL
> 
> V1: https://lore.kernel.org/lkml/20260909074740.1247762-1-maxime.chevallier@bootlin.com/
> 
> Maxime Chevallier (6):
>   net: stmmac: selftests: Support running selftests on DSA conduits
>   net: stmmac: selftests: Validate EEE based on the actual LPI timer
>     value
>   net: stmmac: selftests: Check the dev->features for S-TAG offload
>     testing
>   net: stmmac: selftests: Capture all packets for vlan checks
>   net: stmmac: size the RX buffers from the frame length, not the MTU
>   net: stmmac: selftests: Account for alignment shift on dwmac1000 for
>     Jumbo test
> 
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  20 +--
>  .../stmicro/stmmac/stmmac_selftests.c         | 121 +++++++++++++++---
>  2 files changed, 114 insertions(+), 27 deletions(-)

It looks like that the possible ETIMEDOUT reported on patch 4/6 is
contradicted by your testing, but the other not pre-existing 'high prio'
findings from clashiko look actionable to me.

/P

