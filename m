Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEAF24DCF9;
	Mon,  9 Mar 2026 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057500; cv=none; b=Kx693llf8RB/jx39cEZYnAeqR8u+k9CQ0GxOGD9QfLkNEhD0JzMtARoXwcwvG8ghcV19+e34Q9Mz+Gz1x03zkq6cUxhwoyyoIGnevPHjy2bWDwU/+taZeH2GoYqA6j65AHAGX7o7fPcOje62Z1rIVyblnjtU/pO700rSf8vSK8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057500; c=relaxed/simple;
	bh=5UhEkPknfnsB5jTbLVpmF3G52xxS28ffrxg3XyafvTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpAGV9exJqxyqG6LVKyorkp+twaDC6if81RiNey1CqJe5zFYcS73EAYsc6m9l0xBjrCvV2QIVRivvoM3eR7EqZOONln6aEorZ3Wemdajj31RCQEGMPLs4EthRzMHeIuN+hhpd71EkYlBglz3eVEUYJZv1PWbNtNhys0PDZ6l3/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WHB4Atuo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WHB4Atuo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yYsZBJ4GMFIpxA0RqdxTm5oDj/CJzJ+geYC1kQuf9ZA=; b=WHB4Atuobao0lAn8MjHVJj8567
	IXNy73+/GweBMyUdXZQY5m0teZ5wrje4SFRI/RceHS6J5lW+UWC7XmOo9VWzM2dRN065UqU2Qrwki
	JlhuOqv9EKf3OEMZiXOxVRBQBruDdmnwTnuNA+OxVTcl9I8R7SKn7aNOYYORHvnnDW7wH7zpytk0k
	Rtxs7wKQk46X7+x79o+94tGUKPS5YIjz2I0qeggCqRudcIy7AEuESQZOydgt/ZxAEmPGwl2N9TaHM
	iTEmW9d2YRuT7HRinFWL7AJPyhme0q/v5xF9RmCRQ14g2wBe+0pH0YI8kN3tiuoIHmrf+ZdwUVxSf
	y6FKQEvw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35154)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vzZFD-000000003kV-0QuQ;
	Mon, 09 Mar 2026 11:57:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vzZF9-000000004Hq-3KeJ;
	Mon, 09 Mar 2026 11:57:51 +0000
Date: Mon, 9 Mar 2026 11:57:51 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yao Zi <me@ziyao.cc>, Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v8 3/3] net: stmmac: Add glue layer for Spacemit
 K3 SoC
Message-ID: <aa61v7MQoYq10Jes@shell.armlinux.org.uk>
References: <20260309004305.315018-1-inochiama@gmail.com>
 <20260309004305.315018-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309004305.315018-4-inochiama@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 09, 2026 at 08:42:44AM +0800, Inochi Amaoto wrote:
> +static int spacemit_dwmac_update_irq_config(struct spacmit_dwmac *dwmac,
> +					    struct stmmac_resources *stmmac_res)
> +{
> +	unsigned int mask = CTRL_WAKE_IRQ_EN;
> +	unsigned int val = stmmac_res->wol_irq >= 0 ? CTRL_WAKE_IRQ_EN : 0;

This looks like the last thing I can spot that needs to be addressed.
netdev wants to see "reverse christmas tree" local variable
declarations.

Please reverse the order of these two declarations to achieve that.

With that fixed:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
