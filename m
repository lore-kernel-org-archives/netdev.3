Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18FD37BE8A
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707394; cv=none; b=Cq6evfY+ACVwiaSCaU7EK+FusZ43EBNobczmnlnXYueQegoBm1qmWJKjcHb6KS9ayp8NZ8zOwrQX7rfxsZFcsPYctqZnDpTDJkbxCayduM+1TBYzAuAFQLkVg8QZDXFSGcaYEIHgCaHnS8U3d6+VhVugENgiLVUBFWfCKejcA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707394; c=relaxed/simple;
	bh=bdmhJXYgp6hiwq2GvdcrhMN8527Ns07T1i4rMd9dmYI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=JGbDlb+9y2ggh2WeSZI4ukZj+70CdRdqtxTH+10vwMu1YfJZKBKJhU7ef72M0ri1ivoYDynGGWCNTWyaFryK9lYSuD+gYSwI8UhGbJE+B+ev5EEJKB/N5xRO2VFzDDLWpdJv1UNs6fVBVSCtY83tbbB9jrDiQck8/i4evnevs90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=m9xKcV8G; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="m9xKcV8G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JXAuD3nUVcKQxQuqoS4zKPyRKQFd55XZkokpVdQy2cE=; b=m9xKcV8GAJSk7SyGx2IYKMlYw5
	MmTmgM+rRCW4UhLaIhFCUUhyeAmy3s9WhqYQ84Nbzuo26rd3uNaM18O48FJguW79oiTRgvgdCTA/B
	s6WEACHq7JHG9ewfXG1DxN4hngbxM4tIDUk5hJtoI96OHJEZ0xaLkKEve9GoF513KPsdvpOgqTJVD
	QW6/nA85QQzbW3HE244YZwSrIXy8mfISSWPQZrC4LOz2ZdKDFmrwKB0eGVyNOzSYAAwogdqyLhykR
	v5sf3cIO+1NUshvPDO6EqHHVVo5+FvPKiy3Ylahk+XdY8mnTLYbIGE4vW2suvYu8cer9GX0FRGEgh
	LXmX5vyQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43352 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vy6AV-000000007oc-3yH9;
	Thu, 05 Mar 2026 10:43:00 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vy6AT-0000000BtxD-2qm7;
	Thu, 05 Mar 2026 10:42:57 +0000
In-Reply-To: <aald--qJquWGIvmO@shell.armlinux.org.uk>
References: <aald--qJquWGIvmO@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH net-next v2 7/8] net: stmmac: mdio_bus_data->default_an_inband
 is boolean
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vy6AT-0000000BtxD-2qm7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 05 Mar 2026 10:42:57 +0000

default_an_inband is declared as an unsigned int, but is set to true/
false and is assigned to phylink_config's member of the same name
which is a bool. Declare this also as a bool for consistency.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/linux/stmmac.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 2fc169c7117e..678d03d6d3bd 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -86,10 +86,10 @@ struct stmmac_priv;
 struct stmmac_mdio_bus_data {
 	unsigned int phy_mask;
 	unsigned int pcs_mask;
-	unsigned int default_an_inband;
 	int *irqs;
 	int probed_phy_irq;
 	bool needs_reset;
+	bool default_an_inband;
 };
 
 struct stmmac_dma_cfg {
-- 
2.47.3

