Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDFB43CE77;
	Wed,  9 Sep 2026 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788938239; cv=none; b=kyK4BWc8wKyDZARgx8yHvJvW4bdJ1HpiYSMD7A5p65zTeUC2ddEWRR3RwElej/D01+luws9nfmoynP2AH/ngjg/9cOAm4e2kUHAD/Ch5dKLkAmdh2gekE7ibcMD4z2kyOz38Bhy9HHN03TBzzkOhH/xQEEsNoj+GsDPVZrs4myI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788938239; c=relaxed/simple;
	bh=xGAAc1i8hnpscbI1V4psmDu807nclzPJZJbuPnpBt30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lv4u/nRuePD62cyqmgL2LKtz+WYCqUmT+nwm/w90dQA9pny6S+76SUnhxglyRA5eqEa6iH/SwiRCMKnEraw5NdXoDqfJlmeoAtHL3W+izzmpRZp1bk3JSGa8wHBWNpzDL5xAb4UPWwO9Fd1V/EzgmpNXnH/GqCrRXGXQdPXhhY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyOSDITn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyOSDITn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03131F00A3A;
	Wed,  9 Sep 2026 07:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788938238;
	bh=HQc+Uc9CXTyrtR8l5K6ylLrvmXTF+T5Q3He3R+s5NIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TyOSDITnqL09whZ9Qxy6HEuAumowpSXOCY2gC/KkM0WG4ZCV2Yr0RiZp9HAratldc
	 bt427rgNrENsanlMeq/E8ExIVLGScRc0zDtqlinlmcpavbN9pg4Z+FvK+oYEHwfFlI
	 Dsdb3FzSkS59Arm4JbLPEtzB/vy6FtMiafvR53gdvohoAs7rfYKepCDGhm6u++O/dv
	 ICV2O/7bJiQAGhlF6DN0wLkGz1xuyjEZwuhbIgeW8lYoBJrV8hQjbcQPweROIAEnYI
	 jQy+oQBM5PHzCw6qfZ/C9hWhDbiJGl9Ki7fV9DCSaAjE31mefL/W1ybm020HqGhG1V
	 /BE8iMO7qLBXw==
Date: Wed, 9 Sep 2026 09:17:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Richard Cochran <richardcochran@gmail.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>, 
	Enzo Adriano <enzo.adriano.code@gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: clk: sun60i-a733-ccu: Add Allwinner
 A733 support
Message-ID: <20260909-illegal-organic-mammoth-5daf5d@quoll>
References: <20260905-a733-clk-v3-0-50f238f39c78@pigmoral.tech>
 <20260905-a733-clk-v3-1-50f238f39c78@pigmoral.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260905-a733-clk-v3-1-50f238f39c78@pigmoral.tech>

On Sat, Sep 05, 2026 at 12:45:30AM +0800, Junhui Liu wrote:
> The CCU and R-CCU (PRCM) modules provide clocks and reset functions for
> the Allwinner A733 SoC. The clock architecture of the A733 is evolved
> from the A523, though the root clocking strategy transitions from a
> static oscillator frequency in the Devicetree to the "hosc" clock, which
> is determined by choosing from three possible frequencies (19.2MHz,
> 24MHz, or 26MHz) by the RTC hardware, and finally feeds the CCU and
> R-CCU.
> 
> Additionally, the MCU_CCU module found in previous designs is removed
> from the A733, and the clock tree is expanded with more clock outputs
> to support new functional modules.
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  .../bindings/clock/allwinner,sun60i-a733-ccu.yaml  | 107 ++++++++
>  .../dt-bindings/clock/allwinner,sun60i-a733-ccu.h  | 290 +++++++++++++++++++++
>  .../clock/allwinner,sun60i-a733-r-ccu.h            |  39 +++
>  .../dt-bindings/reset/allwinner,sun60i-a733-ccu.h  | 129 +++++++++
>  .../reset/allwinner,sun60i-a733-r-ccu.h            |  23 ++
>  5 files changed, 588 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

