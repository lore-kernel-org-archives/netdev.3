Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E9428A72F;
	Fri, 17 Jul 2026 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325694; cv=none; b=RaylzC3orY8ZLYuN61DkAOubB1RlGaV1F1NYvKNr1EZrLn6aVsGdo+bTZ82gVIAxSgO5lAaXzXDtpIrLGAQzPN5wJA31Tj/xRB9BX0N1Dbnx/3T/P+WrFpH2F+c7cTJxFnk5Q3hqHzrBNRBZwq5YAr/NYbmXuxRiptA0uA7WsUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325694; c=relaxed/simple;
	bh=ibP4H/kTc6QpQES5l0G9CzhAJHDJoBKAVcsqYj265Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWsCGMi8Hpu4Y9HDTxixP9vku70O1dYPgExtCWNbx6iz8qhQrL/8EivDpCs40z8SFhzhQOveqfUONkOgJn+8R+87yHvCiZXSPDHf5TTJW4wDm0Fnce+HqcErW69LuPuWll6iko5a3M8HL1YCan5nelbBPScoB6rdhH2l3kC/MOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=liTaZx7p; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="liTaZx7p"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D51A1476;
	Fri, 17 Jul 2026 15:01:27 -0700 (PDT)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF9F83F66F;
	Fri, 17 Jul 2026 15:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784325691; bh=ibP4H/kTc6QpQES5l0G9CzhAJHDJoBKAVcsqYj265Qk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=liTaZx7pXEUG/d54Fz0HF4kPrlEEhQ5Soeb/Xz0YcG0QXdu2r82YoCE3lKDkxRQd6
	 0LZp9/3XsmIkKdbtG/VTXeMs7YQWwAL+tEEbZfcfbnJR+dQcWrBBOfRxwvoUd7nb3L
	 L3QtznJYV6bxhepnmiy6xjDB14+QPAO3G6X5XzTs=
Date: Fri, 17 Jul 2026 23:57:37 +0200
From: Andre Przywara <andre.przywara@arm.com>
To: Enzo Adriano <enzo.adriano.code@gmail.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>, Brian Masney
 <bmasney@redhat.com>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran
 <richardcochran@gmail.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/8] clk: sunxi-ng: a733: Add PRCM CCU
Message-ID: <20260717235737.6e69ba19@ryzen.lan>
In-Reply-To: <20260702165944.828550-1-enzo.adriano.code@gmail.com>
References: <20260310-a733-clk-v1-3-36b4e9b24457@pigmoral.tech>
	<20260702165944.828550-1-enzo.adriano.code@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Jul 2026 12:59:44 -0400
Enzo Adriano <enzo.adriano.code@gmail.com> wrote:

Hi Enzo,

> Register check for the PRCM driver against the public A733 User Manual
> V0.92, chapter 4.2.5: all 41 entries I could extract (13 reset-map
> entries, 18 bus gates, 10 mod/mux clocks) match the manual's register
> offsets and bit positions. No discrepancies found in this patch.
> 
> For what it's worth, we have also exercised the R-domain at runtime on a
> Radxa Cubie A7S (r-ahb/r-apb0 rates with live consumers on r-pinctrl,
> r-rtc and the PPU, bus-r-cpucfg via its critical flag), with no
> misbehavior attributable to the PRCM model.

many thanks for doing this, but please add proper tags to your replies,
otherwise this won't be carried over to new revision, and your work
gets lost in the cracks - as it happened this time.

So you now would need to redo the review on v2. I'd suggest to compare
the patches between their RFC and v2 version, and if you agree that the
changes don't touch anything you checked (register offsets, bit
positions), then you can just (re-)post your review with the proper
tags - and a brief list of what you checked, as you did in the RFC
reply.

Thanks,
Andre
