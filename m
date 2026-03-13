Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3F6387377;
	Fri, 13 Mar 2026 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393914; cv=none; b=mgK9wRkGv1CsIbN0XdLKyU/Y20Xs7+GF0/5R8a0XMaiaxwIn893IbqkSoM+3l+NKMskq0/vjkgt5ZRqn3gf0JpiIsUE77HDemFkipPqzoO+NTecicz+ZxOod+lsZbL0lSFoF7kbDlclIe80vLLHIX4sHnmmoATk28JEIdxSDrqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393914; c=relaxed/simple;
	bh=u7PHLQzEyh0y8EnqzZnd5xv6yY/Iw0TdZ7FpjnU0KQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a86dmxVR+B3TVZy3D2j4FFh/ZwMTpqHvaNXns5puUoUlgcRDCLyEq6aUV+R3vvSntki4lpU8gt50+uSfng6zNdHxwi3kpymp6iYOUymhFeK8VCXYUQHgPJeu1ihlRygEiTHWqZP+Z/FYUS016zCAH2EjlJjQgK5TTyeYFftCyV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rtK4yurW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rtK4yurW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=umrsSGTwb1y3zhmlEYx9qju8b83JtHbMLtH0KKSuGXg=; b=rtK4yurWV0aQ/kXCppIokAjzI4
	hSCwsz7v4XM1kswZv9CTB+lWBzibTnizExy74DUJXphgcZyz6Lb55rmTdiTubkkUL5JD0BDZ6zBLc
	8pw0w9a8+UGZq9i5nnPHEkK1e184FA5Hnn9kWc/EuR2FgKx3sE1B0E7ItmYDlFehM9J9HAK1JvwWh
	mnGrZUb6McZ0vahQ2EUgs1X+RT1syOuaOHAA6qP+G4i+bCvQK4mjcaeXiUBnzRgbX0X4qFqUNIHee
	xs6iPObU6qG8rS+Obs4q/2KcDLhe/GK0CKWPLLi8tntr3H9MKeGZcbjHhjyX4P4qyE/T0FmQA0+lu
	bmgCTHZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48998)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w0ylE-000000000Yg-0JZT;
	Fri, 13 Mar 2026 09:24:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w0ylA-0000000086N-1vZP;
	Fri, 13 Mar 2026 09:24:44 +0000
Date: Fri, 13 Mar 2026 09:24:44 +0000
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
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	vladimir.oltean@nxp.com, boon.khai.ng@altera.com
Subject: Re: [PATCH net-next v12 1/4] net: stmmac: platform: read channels irq
Message-ID: <abPX3C1CWZb3k_V8@shell.armlinux.org.uk>
References: <20260313-dwmac_multi_irq-v12-0-b5c9d0aa13d6@oss.nxp.com>
 <20260313-dwmac_multi_irq-v12-1-b5c9d0aa13d6@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-dwmac_multi_irq-v12-1-b5c9d0aa13d6@oss.nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 13, 2026 at 08:13:32AM +0100, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> Read IRQ resources for all rx/tx channels, to allow Multi-IRQ mode
> for platform glue drivers.
> 
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
