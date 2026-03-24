Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3569B3E0241;
	Tue, 24 Mar 2026 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346734; cv=none; b=R2kqcpHo/Eioze6niFkHiz6Crt9jnj2lXIwJzXodcLBrowjeeRxcMNosrAQIlxWsJ+iZS9eueQDi+93dm/ZvGGPP7MLmZ0AIuREZdFmraKK8spEVJxFTdfs9GVmXCFXqhtlXQHg6IP+rldkPN2a4dH8Uo1XJFl763Yl/hd1dveY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346734; c=relaxed/simple;
	bh=odeifUNZqzpqHAnO6JYk0YIgdOzn5/9Kmr3IlqaMeVw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KWzRwOxFbfxPWJRXCGy3Iq89DUF7xxBT0flyZdTUfPTIzJMAmYIDMN8wbPMHchLHkUiD6cTx429mL3URDDdNiC0lle9ts43VVPyUzX44xtxJEPyUDibWXoyCcGvMDx4JK70qyLsJAloNRsFLvo5pnRfc+LMiWC3KB4wMIoNGLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=k1Oqjp3T; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="k1Oqjp3T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r4V4dQe1gU9tt6jQ/MIXP64Tb/Q+nLz8skV//X5OSAI=; b=k1Oqjp3T4DZ9gFyQn4nVacB9W1
	Nu0DIPt1pBTzD78woBasQLdg9ox4bmQR81PXobsc0GhPtDkAPdvpqyIEVaGei5u8bRS6OJkpolxO+
	Gv6RTmKvqLyUK2SHLDILs4cs4cbKcLhOlVrEg1KKXPBOMPuPFZLN1LI8gi7LO7hfwufM29+z63eHo
	YTnXwaMkKKgeXPEPL1UYGae9nA2nf1t5SDiLEu1eEQY68XDf9q23NP2c3C7Iqra6rieW4B3jY4Po9
	teKJmhug6N8AMoZIsj39Mzx85toKXibNoM3101jtF3RuRFVBoLpoYTKDSdJEf0oiogb3bwa8skiJz
	MxFrqtyA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39192)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w4ydb-000000001kv-10UI;
	Tue, 24 Mar 2026 10:05:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w4ydX-000000004yU-3ZmT;
	Tue, 24 Mar 2026 10:05:24 +0000
Date: Tue, 24 Mar 2026 10:05:23 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH net-next 0/2] net: stmmac: remove unused and unimplemented
 AXI properties
Message-ID: <acJh4z3pRKkeaFbR@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

commit afea03656add ("stmmac: rework DMA bus setting and introduce new
platform AXI structure") added support for parsing all the stmmac AXI
attributes, and added code to set most of the appropriate register bits
with three exceptions:

	snps,kbbe
	snps,mb
	snps,rb

These were parsed by the driver, but the result of parsing was never
used by any of the cores.

Moreover, no DTS in the kernel makes use of these properties.

Thus, it doesn't make sense for the driver to parse these, so let's
remove them. Also remove them from the DT binding document.

 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 18 ------------------
 drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c |  1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |  3 ---
 include/linux/stmmac.h                                |  3 ---
 4 files changed, 25 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
