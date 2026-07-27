Received: from mail-m25470.xmail.ntesmail.com (mail-m25470.xmail.ntesmail.com [103.129.254.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F203DA7E4;
	Mon, 27 Jul 2026 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.254.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136898; cv=none; b=Fks+FHoJ4Yk7/2f8Y5SqRtYJI6qeqhdNUXFFlwVl2SHEzWVRwswutyF4hHA+OWP1rCA7CU5UUAPnCPT4hfQM9cZUmUZJTpn5lzBzbjVaL40aIePk7BbkDuBLoaGAq+2+/2IvEpMYmlZMlIU5QAalx/yy4Q7gyNDlveoI8oG6rr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136898; c=relaxed/simple;
	bh=kgslfGkZmdb/dIgZxp1pcwZdP5TBKPB4lnNqnSjbQA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gos+o31wM744w0Hvs8bGpd4wEx4Q3Rw0ALxIS+9rIAmWR7Se43G+8V70+Um3Oi9tog7B3U6t9CcKvct6gM7gQxaYXRfideELai16061TJXcBI90KY4ypd+ba1Q4qa/cz0qZwea2c9DZBIW1/zJqImFO45qF6rNmqrvW6P7Dkp1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=kJ++DX5L; arc=none smtp.client-ip=103.129.254.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="kJ++DX5L"
Received: from [172.16.12.90] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47ae5678e;
	Mon, 27 Jul 2026 15:21:21 +0800 (GMT+08:00)
Message-ID: <a5195a74-9008-405f-9b1e-f88fb47baf03@rock-chips.com>
Date: Mon, 27 Jul 2026 15:21:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: stmmac: dwmac-rk: add RK3576 GMAC 25M
 refout support
To: Alexey Charkov <alchark@gmail.com>, Gavin Gao <attinagaoxu@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, richardcochran@gmail.com,
 nicolas.frattaroli@collabora.com, sebastian.reichel@collabora.com,
 sashal@kernel.org, amadeus@jmu.edu.cn, rmk+kernel@armlinux.org.uk,
 horms@kernel.org, alok.a.tiwari@oracle.com, david.wu@rock-chips.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20260727021048.3375444-1-attinagaoxu@gmail.com>
 <CABjd4YyohxfbVufd1pwJGsm8a8f3Cm6rJiz=WLz=jBjAQRLj4A@mail.gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <CABjd4YyohxfbVufd1pwJGsm8a8f3Cm6rJiz=WLz=jBjAQRLj4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fa2731e6203a7kunmfdf57ff72381e0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEhDVh1IGE5DQ05NHxlCS1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pKQkxVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=kJ++DX5LfiTvcRVhr4D+AmKgnMGCBNhy0VnFX+PIv7PRdJG/AT9qBPR7r4YRP0N/HKJZuG5tvUzxpMLo/JVPrnx1TKhAjdLtgx+LOt/qwMl3y4fN8JUBoVOS5KEGUfuFPlbVHM9ZmGUcouPcrzreA9whPGrorBFQRAitdq3iIzc=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=raXLI4dRVY7FP9fHctbKE/LhEhyIFpZz+uaQSUe++L8=;
	h=date:mime-version:subject:message-id:from;

On 7/27/2026 3:14 PM, Alexey Charkov wrote:
> Hi Gavin,
> 
> On Mon, Jul 27, 2026 at 6:10 AM Gavin Gao <attinagaoxu@gmail.com> wrote:
>>
>> Hi,
>>
>> Some Rockchip GMAC instances can provide a 25 MHz reference clock output
>> for an external RGMII PHY. Boards already describe the MAC clock direction
>> with clock_in_out = "output", but the dwmac-rk driver does not currently
>> request or enable the corresponding 25 MHz reference output clock.
>>
>> On RK3576, this means the REFCLKO25M_GMACx_OUT clock may be disabled by
>> the common clock framework as unused, even though the board expects the
>> GMAC block to provide the PHY reference clock.
>>
>> This series adds an optional "clk_mac_25m_refout" clock name to the
>> Rockchip DWMAC binding, wires it up for RK3576 GMAC0/GMAC1, and enables
>> it from the dwmac-rk driver when the MAC is configured for RGMII output
>> clock mode.
>>
>> The clock remains optional, so existing device trees and SoCs are not
>> affected.
>>
>> Tested on a PicoCOM RK3576 ACP board with a Motorcomm YT8521 PHY.
>> The GMAC 25 MHz reference clock output remains active and Ethernet works.
>>
>> Gavin Gao (3):
>>   dt-bindings: net: rockchip-dwmac: Add 25M refout clock
>>   arm64: dts: rockchip: Add RK3576 GMAC 25M refout clocks
>>   net: stmmac: dwmac-rk: Enable RGMII 25M refout clock
>>
>>  .../bindings/net/rockchip-dwmac.yaml          |  1 +
>>  arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  8 ++---
>>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 33 ++++++++++++++++++-
>>  3 files changed, 37 insertions(+), 5 deletions(-)
> 
> Can you please try something like this [1] instead?
> 
> [1] https://lore.kernel.org/linux-rockchip/20260719034555.3623003-1-gahing@gahingwoo.com/
> 
> The GMAC on RK3576 neither produces nor consumes the clock. CRU is the
> producer, and PHY is the consumer. So the GMAC driver shouldn't be the
> one to enable it, nor should the dwmac binding have anything to do
> with it.
> 
> Have a look at how other boards already upstream handle this. For
> example, the RK3576 EVB1 uses a similar arrangement but with a
> different PHY.

Yep, we had a similar fix, but it was rejected. Please see how RK3576 EVB1 does it:

https://lore.kernel.org/all/20250910-rk3576-evb-network-v1-1-68ed4df272a2@collabora.com/


-- 
Best, 
Chaoyi

