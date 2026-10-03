Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604BB31A56D;
	Sat,  3 Oct 2026 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791038206; cv=pass; b=h0SCVEIJPOrdfgA5P8ptzzPDjBygi9D+N4XLQ8zq72LRvAQegZq4BPyKMYJNBBlmtOyhWCXjj109MdQ9RbLpkblRIf6RosuDWJrTbZQgD01sH9qNH8BiqWqkndys9s0gfRFUIEdxqzkTZtglh0zQK7RvujPy0S3UPVZ6qXfSpq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791038206; c=relaxed/simple;
	bh=9Egv4q97ghG6oqT2h8uxYWEJx97iLxhYm/0+T/pO2i4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=VtIY7M4czw9XDZUHBaYHrIlQ7MpD36ul/klz1uXcALvDDouL+IPBZBM1uyRmRFB68DWhrh6A5XaeTivlpcYNlZ0dPhMD0+NfJy5LToUUXNtO7Zo12/YxAZJiJrphSrJtA0LzRO1tsC0hTM04Uo89Z0FVzuXDgn4eH4fOhmFozvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=aVP6eu9Q; arc=pass smtp.client-ip=165.173.180.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="aVP6eu9Q"
ARC-Seal: i=1; a=rsa-sha256; t=1791038153; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kLHYAhye2LfTlMwX0V6q6TTBkux+wUFvoV4mXNTnSVevlJCYF5FyMMRkdeFkH0XszsbgO+qYY2nuDmDtmuWaPe/Qry8FJt2ZBs79Ypjdi3fNNl4hpSYv+BiOAYPvjEGr930y6mI6YFb29oTMGzg8MfOcXrhEuaUKicppeQkNN0A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791038153; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9Egv4q97ghG6oqT2h8uxYWEJx97iLxhYm/0+T/pO2i4=; 
	b=kRHyPxPAhgGthdAaCK3cR3qk8LPjw/tJr7goGPLgT4hdbGXJLOiOJ1lqY0IdtuTXa9XDacMAmTO1f4RS03uNFPlHZxXQGT2pAIugaTweekvCg9hn+GKltqoM9snXW4m7nB8EGOvghDWut1qOUqMP68/t2wHIXMBOcPKR2QN3pmM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791038153;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:To:To:Cc:Cc:Subject:Subject:From:From:In-Reply-To:Reply-To;
	bh=9Egv4q97ghG6oqT2h8uxYWEJx97iLxhYm/0+T/pO2i4=;
	b=aVP6eu9QquEmV95y1DiK1BJcTJUnvthZ3+boRCVkxLohCUk8OTC/+kQtbqhGdwwC
	V3gRD61LqmAqz0zOpqvCC3f+OHP72cIIbFN5+2qPbvitDeoBI/XjkIeRaTIsvgm5ev7
	f6L/Rn7N7zv+L3ETm7cY0TEXFhKrt4FIczIQYM5w=
Received: by smtp.zohomail.com with SMTPS id 1791038151074231.15688188388413;
	Sat, 3 Oct 2026 07:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 22:35:41 +0800
Message-Id: <DLVA17A4RRG7.2ECQKV3SJDAGI@pigmoral.tech>
To: <wens@kernel.org>, "Junhui Liu" <junhui.liu@pigmoral.tech>
Cc: "Stephen Boyd" <sboyd@kernel.org>, "Brian Masney"
 <bmasney+clk@redhat.com>, "Jerome Brunet" <jbrunet+clk@baylibre.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Samuel Holland" <samuel@sholland.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Richard Cochran"
 <richardcochran@gmail.com>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <netdev@vger.kernel.org>, "Jerome
 Brunet" <jbrunet@baylibre.com>, "Enzo Adriano"
 <enzo.adriano.code@gmail.com>, "Andre Przywara" <andre.przywara@arm.com>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>, "Yixun Lan"
 <dlan@gentoo.org>
Subject: Re: [PATCH v5 0/8] clk: sunxi-ng: Add support for Allwinner A733
 CCU and PRCM
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
X-Mailer: aerc 0.22.0
References: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech>
 <CAGb2v66O7Ze=TiHO_5q=76QpU8ZXraFyV+HfO+_HpkTDr1U-nQ@mail.gmail.com>
In-Reply-To: <CAGb2v66O7Ze=TiHO_5q=76QpU8ZXraFyV+HfO+_HpkTDr1U-nQ@mail.gmail.com>
X-ZohoMailClient: External

Hi Chen-Yu,

On Sat Oct 3, 2026 at 9:37 PM CST, Chen-Yu Tsai wrote:
> On Wed, Sep 30, 2026 at 1:27=E2=80=AFAM Junhui Liu <junhui.liu@pigmoral.t=
ech> wrote:
>>
>> Add support for the main CCU and the PRCM module (R-CCU) found in the
>> Allwinner A733 SoC. The clock architecture is derived from the previous
>> A523 design, with the MCU_CCU removed and the clock tree extended for
>> the additional functional blocks found on the A733.
>>
>> The A733 introduces a "pll-ref" clock that normalizes the physical
>> oscillator frequency, which can be 19.2MHz, 24MHz, or 26MHz, into a
>> consistent 24MHz reference for the PLL clock tree.
>>
>> The peripheral, video, and DE PLLs provide multiple independently gated
>> outputs with programmable dividers. Model these outputs as separate
>> divider-and-gate child clocks. Also follow the documented hierarchy for
>> the derived peripheral PLL outputs. The explicitly named PLL_AUDIO1 /2
>> and /5 outputs are modeled as fixed-factor clocks, with their divider
>> fields initialized accordingly.
>>
>> Also extend the sunxi-ng SDM (Sigma-Delta Modulation) support for the
>> dual-pattern register layout used by the A733 PLLs. PLL_AUDIO0 uses the
>> dual-pattern SDM support to synthesize its fractional output.
>> PLL_AUDIO1 does not expose fractional rates, but its SDM controls are
>> modeled so that stale settings left by firmware can be disabled when an
>> integer rate is programmed.
>
> Some of the clock controls, like the PLL and AHB/APB bus dividers, are
> secure by default and need to be set to non-secure for Linux to be able
> to use them properly. And there is also a TWD clock in the PRCM that the
> user manual says is secure only.
>
> Have you given any thought to this? If we end up having to convert to
> SCMI or something to handle those clocks it's going to be a bit ugly.
>
> And presumably things work now because the secure/non-secure access bit
> isn't in effect right now because you aren't using secure boot? At least
> this was a thing in the past...
>

Thanks for pointing this out. This is indeed something I had not
considered before. I will try enabling secure boot on my spare Cubie A7Z
board and test it on actual hardware.

For the PLL and AHB/APB bus clock controls, the user manual indicates
that the relevant security bits can be set by TF-A to allow the kernel
to access these registers. This also appears to be how this has
traditionally been handled on sunxi platforms. So I think we can do the
same in TF-A for the A733.

For bus_r_twd_clk, I will test whether the register is indeed always
secure. If it is, I think the clock can be removed from the kernel and
left enabled by its hardware reset value or by the boot firmware.

>
> Thanks
> ChenYu
>

--=20
Best regards,
Junhui Liu

