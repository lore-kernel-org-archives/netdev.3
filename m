Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096232;
	b=NqPdZg+qCtjrmdA7BEvXFdVBOTXjVQM4TqSFZsJU+71ADa6l5Nn1hDWbUKcGCZqRmkYq
	 Q5uKL/T8KGlQkZ6s6Q8s8mbHNJdWZ/J7Jbigm6wYLuzMmf9qDEJuN0oDvGCo7HQ/7FgBn
	 fE8pJ73uh1kTHSQzLcVwveWk/+WUoYPwQCZxIP22/6ztTyrs2e+avju74V42QuWWRNwVY
	 4a85gP3zWfRZiZRzW8fyJw+XTKhN0WDdAFShZVv5mAPA76vJj98bJztJEa0lnMLIqLitD
	 Pu8vKTmsCCIKYr7vsySuG/KJ0HssZhIiq2LZdTPhq4zJBmD8RTKWJHGnnSGWIsM+4hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096232;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=350ox5QQqjyuw0S50o6SyzYoMNexUoMgbyvdSGfqoWE=;
	b=piNpjPBOLNMvk2ILm5Q8ddfzJaVQTeyebdMFkoWCMCQPSCmK75WPPQhZKTvxeU7AMg3p
	 PJQ0kzcxMkFL8MNboi019R4lRkW5qTRT5hLj4vFvTVU2BEupPhBnKeoBNdsclEpsmtn+G
	 TA9UKY+mFzgEjyjP2INKwiC7uNebGgs7R4xrCgdT+2HqjCuquZrnnVfI8FY7jhYCnB+yT
	 PHCgj7p9VMcuk88YUJzTXn1uOnbpluLXQf+QOaDE+efF+s9gh+45EaPZ/qB+CJur5lqry
	 oqZK11GELwKeEsfzITTSMxB7i8FAeD6JjhM50+eweGwDB3HeSkAWi8YSPQoByrv1IAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VO7hBpsz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AF6606A31D;
	Tue, 27 Oct 2026 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VO7hBpsz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FA61F01825;
	Tue, 27 Oct 2026 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793096231;
	bh=350ox5QQqjyuw0S50o6SyzYoMNexUoMgbyvdSGfqoWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VO7hBpszikm9a8mzgYN7h9BuRv6QFbAY5Gkml1AKjTGSzjW/OELKbP39a35AI7KqO
	 Ny/9CKi1Y3g2sDlCoO6wzK5jwCk58KwSysj90m4nhiC/RIUJ5dEulE7PQ4+pppEdY7
	 3Bg7UbWe93ZS66AXGuDYkCxeJTmW8iPughSoKZAqx69gxyp188K/Vyedlt+QK7E1Bz
	 kEKGsHruIEbfrfUXw4v8PSufIbJpYiv038zXLHiCSAM2bd/Wr1Ax2DWEZbkz0Cz+VN
	 TVuXfEbyY1xAxKzLXmPr0qOd0qJJAYHOsl6yjTqRp5c8VeKBRWJtIrGNTpNDv864a7
	 wPAOguRpG0tGg==
Date: Tue, 27 Oct 2026 11:17:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, Richard Cochran <richardcochran@gmail.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: rockchip: Add RK3572 CRU
Message-ID: <20261027-vagabond-gabby-caracara-4edabe@quoll>
References: <20261026-add-board-ok3572-c-clk-v3-0-dbabfa39d692@qq.com>
 <20261026-add-board-ok3572-c-clk-v3-1-dbabfa39d692@qq.com>
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
In-Reply-To: <20261026-add-board-ok3572-c-clk-v3-1-dbabfa39d692@qq.com>

On Mon, Oct 26, 2026 at 02:56:47PM +0800, Cunhao Lu wrote:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> The RK3572 CRU uses the PMU0 GRF for the AUPLL reference mux.
> Describe the controller and define its clock and reset IDs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> 
> - Documented the xin24m input.
> - Made the PMU0 GRF phandle required.
> - Updated the example.
> - Closed the reset ID gap while preserving each named reset's register
>   mapping.
> - Removed CLK_NR_CLKS from the clock binding.
> 

All your patches seems to have odd commit msg.

> Signed-off-by: Cunhao Lu <1579567540@qq.com>


Best regards,
Krzysztof

