Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEDC15CD7E;
	Mon, 26 Jan 2026 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769431613; cv=none; b=ar/0BXj/SFk/kFI4ZdbSo95b8x25aNp0D87hb4FU7SBadq7IPLWBswn+tYQ7xaeT32otENbNP8cX7PCAytiH7IbzK0ADuDQKUSpz2uaKmWpvvlBbL9kasWFGF8PWd8898rcQk+yDhjVN8rpH7ivfL92c5IyVEHnjM+cS+AwGL50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769431613; c=relaxed/simple;
	bh=xzF+70RCHLThVHeN+fikhTq2hQTzCjlVjm0fsvownQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfVgdpw1F2paDQXSje81g1RlNQCx5DQb5HhzrnX4ldX5B1msb+/5sBZbazw3L23wXa4bPSaWjZh+wxUpTqzh4UQOBIWB2cDDb4CG87to2joOQPOGkHuP8gAJrLhY1UL+zwZEl2tWQCcPQYV5P3VSwezPusJlM3ob8inFY5OE/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3AE6F200EE2;
	Mon, 26 Jan 2026 13:46:45 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 23B2A200E9A;
	Mon, 26 Jan 2026 13:46:45 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D33D62035B;
	Mon, 26 Jan 2026 13:46:44 +0100 (CET)
Date: Mon, 26 Jan 2026 13:46:45 +0100
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: Conor Dooley <conor@kernel.org>
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
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: net: nxp,s32-dwmac: Declare
 per-queue interrupts
Message-ID: <aXdiNb92B4HH+ZFt@lsv051416.swis.nl-cdc01.nxp.com>
References: <20260123-dwmac_multi_irq-v3-0-cc53f2be8961@oss.nxp.com>
 <20260123-dwmac_multi_irq-v3-2-cc53f2be8961@oss.nxp.com>
 <20260123-dinner-aloft-e57deb6c546a@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-dinner-aloft-e57deb6c546a@spud>
X-Virus-Scanned: ClamAV using ClamSMTP

On Fri, Jan 23, 2026 at 05:13:03PM +0000, Conor Dooley wrote:
> On Fri, Jan 23, 2026 at 11:09:55AM +0100, Jan Petrous via B4 Relay wrote:
> > From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> > 
> > The DWMAC IP on NXP S32G/R SoCs has connected queue-based IRQ lines,
> > set them to allow using Multi-IRQ mode when supported.
> 
> The binding only supports s32{g,r} devices, why is the existing minimum
> retained? What devices are going to not have all 11 interrupts
> connected?
> 

The original idea was to support backward compatibility, as older DTs
didn't contain queue-based interrupt lines described.

But now, when you asked, I started to think it is not needed,
the requirement for backward compatibility is managed inside the driver
and yaml shall describe the hardware not used configuration.

Is it my understanding right? Should I provide v4 with minimum = 11?

BR.
/Jan

