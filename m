Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519920;
	b=xIMhMI9PkLIkLxYVtQjVJiuabQFo1pesYjkA/BSqrHHPISo9Cjive/9ZXVCeTx3QpqAS
	 B3z8CaM+lvn1n1isMYSFtJSwiArZJot49xMUMPEo4+LiWkHyJoszG+ewcXuB7INQT8BCS
	 oBz0AGSbnCFowf3KINUoCv/qvo0okVqXJSdU82k0+lzgqtv0BBP8X8+F9MVFz9WXywo1R
	 b5F0hyXiZmIRluO/N9MlOlX+0tT6VDRza0yhh8ehrW0HgW/nWIzhpLw0EToplg1tHJlV8
	 yOg2Gu+jfyEchJuwQFaWfAxqIEAHTd0oBTUziDA1jBcnaeczPcY/K6YJqpSbLY4q5QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519920;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=w0S73kQeA4n4wf6WAj+973/RL9otbjByBLVSYQz9d3o=;
	b=sVFsRlmt2CkaPRK94ZT89RkhZuQFq6IZf2KoXHhLEXBSWSV+2tZ04VuDZnXTiuosP3pv
	 5CPsLYXHbKlOVIjrtCZTKvy7eTiM5aybHprpZfpXo+0BG1KY/8UXSuVQNfOgs00f6xWc4
	 /T1Pzs8bgwdiNPJuSX1Li2zANkVusd2AEmjlEb4qRY+u2v9lBF8giOf6cav8GqYSHf9O2
	 eXjByk9Y3j33GAW7giH07OHpuCLFINFLXKJkrFSat/Fk2Rh0McO0pE9rUP3Jsot+mP6a/
	 TAsqQd5iIvGVVSRiCs4jVirTRjYUQowSeF2G1NTaw165AcSw8Cz6fMmOnrprdU2vvZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C56606A319;
	Tue, 20 Oct 2026 18:11:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999FA1F000C9;
	Tue, 20 Oct 2026 18:11:59 +0000 (UTC)
Date: Tue, 20 Oct 2026 13:11:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>, devicetree@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>
Subject: Re: [PATCH net-next v4 2/7] dt-bindings: net: ftgmac100: Add AST2700
 compatible
Message-ID: <179251988803.507344.18367097061225953280.robh@kernel.org>
References: <20261020-support_ast2700-v4-0-4d36b40939b3@aspeedtech.com>
 <20261020-support_ast2700-v4-2-4d36b40939b3@aspeedtech.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-support_ast2700-v4-2-4d36b40939b3@aspeedtech.com>


On Tue, 20 Oct 2026 19:34:13 +0800, Jacky Chou wrote:
> Add AST2700 to the FTGMAC100 compatible list and document that its
> RMII RCLK gate matches the earlier Aspeed SoCs. Allow the reset line
> for AST2700 as it follows the same reset requirements as AST2600.
> 
> Require "phy-mode" to be present in the device tree when the AST2700
> compatible is used, matching the driver's probe-time requirement.
> 
> Add aspeed,ast2700-mac as a standalone compatible, consistent with
> the other Aspeed compatibles.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

