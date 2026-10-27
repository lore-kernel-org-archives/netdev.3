Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.126.93.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793062635;
	b=4oP57G/Io9OpCA136gEMS6sngg1zHAtZw64bckSXloHDwp096gi0JJLRtYDrQtPp0Idb
	 B/MKNSdw/mXpNxbSG+tExwM3+jqG2ft1attaPOfKBf1RzyaMZ5YjO8AmQS7bfl/nNXdp8
	 M6XVOrR/JFV/2nYfSdPNOr0LkS3bQzqg1kWt65XDS+3kFsRSvrLh2VvC4RUwe3xPRYsqS
	 bffBXmN/9d8R48AhR2UxkFReThO0bcwcKJ3eiGAYK8czcdE4qUlSQU2XsOQXNfmVHflLb
	 oZ11TvEEeEJakzc1Poek6WFStZxkmhPPX5Djn3d7zPFb32k5Bd8UyRgervbYN8G8xlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793062635;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=LTWlkC3bqSlTG2YkDHxmrbiZeaSggK5ojxGD1nHsNsI=;
	b=fV6gu6AmjPRTl3WWKHTF6QfIwDNPuA4mkZwkCHguq1JSNh7q3k3+LVE9XfHNlK2YiHkS
	 I6LLOquAPgTR1/LPgGO4nPXDDGnqq5p+6F/9lbxRNZbFwgBK9T3FuJ58aJNw0BEqibOlY
	 tjol0z9fJW0+wEy2yrewXaJD7WLthEWvCl1aEhoXt394mIYwT+4tn09qppDjbJWqvidU6
	 V/yIrUprMmrcrXcLbu9R+aEuKqYdpc2vkEVMAkIGA9+xXyerY6VKudE0CTqZkh/WeQvZc
	 fnmQWe1znP69pXpZUYUxz27Xuy84Nikiq/jiVpSS6GlUPc1Ix6lrDSwQQTw4JLeJieQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=hV1UNJnX;
	arc=none smtp.remote-ip=103.126.93.3
Received: from mail-m933.xmail.ntesmail.com (mail-m933.xmail.ntesmail.com [103.126.93.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2C606A31A;
	Tue, 27 Oct 2026 00:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27D2C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=hV1UNJnX
Received: from [172.16.12.93] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 526eb68c8;
	Tue, 27 Oct 2026 08:57:04 +0800 (GMT+08:00)
Message-ID: <9f8114fc-c4bd-4f50-8c5a-a8afc94249b8@rock-chips.com>
Date: Tue, 27 Oct 2026 08:57:02 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] clk: rockchip: Add RK3572 clock and reset support
To: Cunhao Lu <1579567540@qq.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk <linux-clk@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
References: <20261026-add-board-ok3572-c-clk-v3-0-dbabfa39d692@qq.com>
 <20261026-add-board-ok3572-c-clk-v3-3-dbabfa39d692@qq.com>
 <0d5de6fd-3150-4898-a652-7f5b64dcaf07@rock-chips.com>
 <tencent_6876096D2306016F88487E0E4D78345B3208@qq.com>
From: =?UTF-8?B?5byg5pm0?= <zhangqing@rock-chips.com>
In-Reply-To: <tencent_6876096D2306016F88487E0E4D78345B3208@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa17adc5aa409d2kunmf1cad9ec130d7c4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ0JJVkhLTU1JSB8dQ05LHlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=hV1UNJnX6QxnjUOiSLVmQD2uma3cke/feZxFVH5S4idvDB+vzdGr/E9wgn464etOHYT4aZjOe+e90+ba5lq8wnXpsEnx+r0uShc0/GkpQM+Mdf57U1BSBg7TzTBAjAc4coCZPgYikVjqHNbeHLnvM30slTEgbXfdnZ7gyX4ZygI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=LTWlkC3bqSlTG2YkDHxmrbiZeaSggK5ojxGD1nHsNsI=;
	h=date:mime-version:subject:message-id:from;


在 2026/10/26 22:56, Cunhao Lu 写道:
> Hi zhangqing,
>
>> This is in clk.h, please submit it separately.
> Thanks for the review. I will move COMPOSITE_MUXTBL to clk.h and add it
> in a separate preparatory patch.
>
>> This is incorrect here; there should be no negative values. Two's
>> complement is used here, so a conversion is needed. For example,
>> -12955 should be 52581.
>>
>> In clk-pll.c, cur.k & BIT(15) is used to determine the two's complement
>> conversion.
> I agree that the hardware expects a 16-bit two's complement encoding:
> -12955 is encoded as 0xcd65, which is 52581 when read as unsigned. The
> difference here is how that coefficient is represented in the rate
> table on the kernel version this series targets.
>
> I found the cur.k & BIT(15) branch in Rockchip's downstream develop-6.12
> tree. There, k is unsigned int, so the driver explicitly checks bit 15
> and subtracts the magnitude of a negative fractional coefficient.
>
> This series uses the upstream implementation. Both v2 and v3 are based
> on a804c5742bff, which already contains commit
> 581478883477 ("clk: rockchip: Fractional PLL coefficient on RK3588/RK3576
> is two's complement"). That commit changed the k member of
> struct rockchip_pll_rate_table to:
>
>          s16 k; /* fractional part, 16 bit two's complement */
>
> On this base, rockchip_rk3588_pll_recalc_rate() uses signed arithmetic:
>
>          s64 frac_rate64 = (s64)prate * cur.k;
>          postdiv = cur.p * 65536;
>          rate64 += div_s64(frac_rate64, postdiv);
>
> The signed type represents the negative coefficient directly, so this
> implementation does not need a separate cur.k & BIT(15) branch. For
> example, the mainline RK3576 rate table already contains:
>
>          RK3588_PLL_RATE(955520000, 3, 478, 2, -15730),
>          RK3588_PLL_RATE(785560000, 3, 393, 2, -14419),
>
> These are exactly the same entries as in this RK3572 patch, including
> p, m and s. Mainline RK3588 uses the same entries as well. Since RK3572
> uses this shared upstream PLL implementation, I will follow the
> mainline RK3576 convention for its rate table.
>
> Writing 52581 directly into an s16 initializer would require an
> out-of-range implicit conversion; a reduced compiler test reproduces
> Clang's constant-conversion diagnostic. An explicit cast such as
> (s16)52581 would produce the same signed coefficient, but would add a
> conversion that the existing mainline tables avoid. Using -12955
> directly makes the value used in the rate calculation clear and stays
> consistent with RK3576.
>
> The register encoding is preserved: the write path passes k through
> HIWORD_UPDATE() with a 0xffff mask, so -12955 still writes 0xcd65 into
> the coefficient field. The five initializer changes from v2 to v3 only
> make the signed values explicit; they do not change p, m, s or the
> 16-bit coefficient encodings. In particular, no further adjustment of
> m is needed for these representation changes.
>
> I will therefore retain the signed coefficients, following mainline
> RK3576.
OK
>
> Best regards,
> Cunhao
