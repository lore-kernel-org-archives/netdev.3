Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7FC38E5DD;
	Wed, 25 Feb 2026 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011554; cv=none; b=K+gyrAspFof1JcqrATcJTQhHCC5G1Omugq9+IF+irLi9/izROi6f8+WwL8e11CCH9grZtRoILByjtQWd1UYopgLqGeyDFnZ+67CG0S9Qd1CFJpA7siKq93D9TEPz7K6EIW/EgYExP/Xu0GMPq0pc/abCbtm+vl7ALf/t+tX/19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011554; c=relaxed/simple;
	bh=rgKp5YVqKagpJ90dBd1U0u98y/nDFSmcQ/5cAIgBGO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQ3V9mcwwiVipqlQOUezLRS7m7Gh8weKS7b+wm3Opmn+HyE5xloZOqRwi/7zzuDt5y0+AoVNp1sgh4dLwcDN1E6Xo8IBuHspnQN7J1DcWlesVncnwSNubrOiXFWzBjZRqDhfA/WdJOVB8PG5NVz0is26e02CYFJVEppyACVsOyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hlifViC1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hlifViC1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=id9ft50ikpeYq2+DbJZJyBUEH3jA2m0GVsep0KOPZy4=; b=hlifViC1PGDWeKiILXqnlayMso
	ML3lAMkdhTOBBO9Q7f/62nWqghLstcjiKEe2DJci0UOgpAUqXOzzx0RPIyepl68I/nr9mEg5/tqr4
	0ge+0080csH7Cf9webe7Nj7vj+3VM5itj5uwP1rCjk+T1oPTBZFm0w+hqelpvhsAsRt6RUcX1VTmJ
	L6QIiwR4Rv3WtzI8idcTPYnpENciT49idMr69PlYCwIB5AQmdDticanOvDeqXfx5hCRoIqDXfSKD0
	MlQJyTX5mezGgVjhCqHVPz9aYRQpTMPyQsJPsqWafrYW6LTySQSiKTchGrefDZSiHEvJqJQiOiVbG
	gzyvf4NQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46704)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vvB9B-000000006Lo-0h2P;
	Wed, 25 Feb 2026 09:25:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vvB96-000000000pi-2Vrn;
	Wed, 25 Feb 2026 09:25:28 +0000
Date: Wed, 25 Feb 2026 09:25:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: jan.petrous@oss.nxp.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/5] dt-bindings: net: nxp,s32-dwmac: Declare
 per-queue interrupts
Message-ID: <aZ7ACLx1yUMWPAsZ@shell.armlinux.org.uk>
References: <20260225-dwmac_multi_irq-v6-0-245bf1d7110c@oss.nxp.com>
 <20260225-dwmac_multi_irq-v6-3-245bf1d7110c@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225-dwmac_multi_irq-v6-3-245bf1d7110c@oss.nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 25, 2026 at 10:20:35AM +0100, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> The DWMAC IP on NXP S32G/R SoCs has connected queue-based IRQ lines,
> set them to allow using Multi-IRQ mode.
> 
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---
>  .../devicetree/bindings/net/nxp,s32-dwmac.yaml     | 44 +++++++++++++++++++---

As you have added support for these IRQs into the generic code,
shouldn't the generic dwmac binding doc reflect that this is now
supported?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
