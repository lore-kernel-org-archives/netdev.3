Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606583;
	b=mMSNhP/bx1V3pzZKlz8+hzVXxz6YyoJcHPw+YJrWz4PCc3TglzTtzT69c+/CcXSHaCt8
	 B7PqLdnQsDevm4CwbVs4GEMlWAbNW1o+WlY2aNGyOUpAdGfGigqgHtA+mB04vluctjlPd
	 J/IzoeJ+4ffFtn2Mi+gT8Mkrnz3fWBfAuwjwQsSFJMWN3ykxQOue3QY0XHpaHUTOm0GDC
	 U8lgq4jtAfFZPPzycA6NS6DdjSyYrqfdv4LhLywWIQxnFjglH0UTgYOCDgOBPSXPyJfy4
	 12y9ui186+k+SfM8v3NI7hiea36ja8W50CYc8SnRgjgvs13ZF2K7xvPeWejgn21rnWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606583;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=U6rujUAQs2Y1Y1weMw1WSfHc22ibpIuMwbt2s+QB2+k=;
	b=oSRIBEoRcX9U2aLhAUeS+PNu6kHPjGc+deDawUEEdW37FEmq+vrufM9cDceGeeN1+bwZ
	 kyMh4aYgNqe7KrX05rkRLUaM87UkKutR8+NCXK2L2MpHvJJBns9AfrglqKDfZGnZMBXZz
	 t0vlV9CfKkdRGGLL9Tehc0iKNXEiP9y8sP9YlTcxTCln8moA5O6an0wcBIis294Y8umua
	 a4o1EEudXgG+1ztPsXQeY2y6UQcwwX+wfpmb/E4WTfTn/p/e0mY5/yYYxciFv1jo0DvAC
	 ZZURGYj647IVmZOhw/7W2IuYVOfCE0uO0BD9MpdvVhLj0c9Meypb5P8JSei0S5UEOHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkNoZJ0n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C68606A333;
	Mon,  2 Nov 2026 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkNoZJ0n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E330D1F000C1;
	Mon,  2 Nov 2026 08:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793606582;
	bh=U6rujUAQs2Y1Y1weMw1WSfHc22ibpIuMwbt2s+QB2+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nkNoZJ0ncC7kvMOAEmJnnNbUlp2tHy4dbnyuT9fv2n0nS+11B4dO41kssOR9pUspI
	 uw7G7IjA3et1iqmN3UrjTsJsuonqATVfKe8Q13m899JkYYSdLFl3uirYA+ODqCruDQ
	 De9T/FrComFmMPphSBzjqN7NSJZXQ5iyG6Dcd6ByZYpxsJrkHRDC+JGhTMq5IPgtmd
	 l9X/GdwM+JNmiv5wsfI3vTgae/P0PXBTjjzEQ9EvvVv0ut1SOvVUCH7WzAU1oQmR+Z
	 HMQRDP6G4NKov4OmSRq4W0SsODcyr+0GiMbtJq7WYyzNX3iEtthDt2tDeC1fCh6nAn
	 LZzuLcLx0fLcQ==
Date: Mon, 2 Nov 2026 09:02:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, Richard Cochran <richardcochran@gmail.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: clock: rockchip: Add RK3572 CRU
Message-ID: <20261102-casual-free-starling-fd87a5@quoll>
References: <20261030-add-board-ok3572-c-clk-v5-0-9a43403cb149@qq.com>
 <20261030-add-board-ok3572-c-clk-v5-1-9a43403cb149@qq.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261030-add-board-ok3572-c-clk-v5-1-9a43403cb149@qq.com>

On Fri, Oct 30, 2026 at 05:43:57PM +0800, Cunhao Lu wrote:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> The RK3572 CRU uses the PMU0 GRF for the AUPLL reference mux.
> Describe the controller and define its clock and reset IDs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> [adapted to mainline rockchip clock and reset handling (xin24m input,
>  don't introduce CLK_NR_CLKS)]
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

