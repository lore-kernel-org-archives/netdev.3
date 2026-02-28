Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B013175A80;
	Sat, 28 Feb 2026 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772313528; cv=none; b=nBJx6CtdOhVkDu60gzAWSLvjeQ46h74j3p1MPKTxVNCZPrqT9y+sEGnDttY1q/jaeMMpa5IofHDeG05f6nmhpNDn2TVIR059gbNDOylkTOMnnFkyfQ3vcUd9HdeeCrjb8l/fa5WgjehdcFHZjp3qRzvxHT7ed6JQeOAnJupPnno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772313528; c=relaxed/simple;
	bh=LrGT6mNI+jCfEdEtzYEm5ownAK+ham3iPLxI8Va3x6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EszHQ9RNLioqn2HgX5IUwQzUB5KwB8Jx9ZY37Cq+VfDsIG8YsuMKNtt01xNK0EyZQgmPalgG/XkEYwfGPz/h9VwxSjHUuuxMJVDABUGhC1UB9xiblRzl/8BAoeg+/gmDnb9qb3Af8zVoDU8Nv6pLmGjbP23xmf9RjyVvgDo1Iic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ew5g5c8t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ew5g5c8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361BFC116D0;
	Sat, 28 Feb 2026 21:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772313527;
	bh=LrGT6mNI+jCfEdEtzYEm5ownAK+ham3iPLxI8Va3x6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ew5g5c8tzhBv5k8g1mFuy03Thy+F5AuRIn5yAWi6HNFtQv56oq1bs9bzo03rTCdns
	 5ztCwasRq6mudOLB9siqGZycUc16wcm5QZ1B1TxiWUg3IgDAyqw8+XehIMUtMeetPq
	 p2aG7roHkxbBwDGcjGL4QbUj86OrIKbMdR/YtvkVtI598ms6Ljd+UU1rRJBTZmF/QY
	 Bvd+8BZgAbsbjiEjS38dOameD66tzEhzeS28OOQzeSvOo2oZ+K+X0tfA+rTWId+g4+
	 IIGgvxEygphcugx6YHcfaUdz4ieS3mOu77DEXncjwKKns4Ra87Va0+phlJS0pZ47sW
	 f5fWCxoljvdEA==
Date: Sat, 28 Feb 2026 13:18:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan
 <dlan@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Richard Cochran
 <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Yao
 Zi <me@ziyao.cc>, Yanteng Si <siyanteng@cqsoftware.com.cn>, Choong Yong
 Liang <yong.liang.choong@linux.intel.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Shangjuan Wei
 <weishangjuan@eswincomputing.com>, Chen-Yu Tsai <wens@kernel.org>, Boon
 Khai Ng <boon.khai.ng@altera.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu
 <joabreu@synopsys.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin
 Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v5 3/3] net: stmmac: Add glue layer for
 Spacemit K3 SoC
Message-ID: <20260228131845.70421792@kernel.org>
In-Reply-To: <20260227075718.2243818-4-inochiama@gmail.com>
References: <20260227075718.2243818-1-inochiama@gmail.com>
	<20260227075718.2243818-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 15:57:17 +0800 Inochi Amaoto wrote:
> The ethernet controller on Spacemit K3 SoC is Synopsys DesignWare
> MAC (version 5.40a), with the following special points:
> 1. The rate of the tx clock line is auto changed when the mac speed
>    rate is changed, and no need for changing the input tx clock.
> 2. This controller require a extra syscon device to configure the
>    interface type, enable wake up interrupt and delay configuration
>    if needed.

checkpatch says:

ERROR: "foo* bar" should be "foo *bar"
#110: FILE: drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c:45:
+static int spacemit_dwmac_set_delay(struct spacmit_dwmac* dwmac,

ERROR: "foo* bar" should be "foo *bar"
#148: FILE: drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c:83:
+static int spacemit_dwmac_fix_delay(struct spacmit_dwmac* dwmac,

WARNING: line length of 99 exceeds 80 columns
#243: FILE: drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c:178:
+	apmu = syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node, "spacemit,apmu", 2, offset);
-- 
pw-bot: cr
